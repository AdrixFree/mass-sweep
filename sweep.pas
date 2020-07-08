///////////////////////////////////////////////////////////
//
//        LANGHOST MASS SWEEP SCRIPT v1.0 (C) 2020
//
///////////////////////////////////////////////////////////

const
	SWEEP_RANGE = 600;
	SWEEP_SKILL = 42;

function FindTarget() : TL2Npc;
var
	i : integer;
	target : TL2Npc;
begin
	for i := 0 to NpcList.Count - 1 do
	begin
		target := NpcList.Items(i);
		if (User.DistToTarget <= SWEEP_RANGE) and (target.Dead)
			and (target.Sweepable)
		then begin
			result := target;
			exit;
		end;
	end;
	result := nil;
end;

procedure MassSweep();
var
	target : TL2Char;
begin
	target := FindTarget();
	if (target <> nil)
	then begin
		while (target.Valid) do
		begin
			Engine.DUseSkill(SWEEP_SKILL, false, false);
			delay(50);
		end;
	end;
end;

procedure MassSweepThread();
begin
	while True do
	begin
		MassSweep();
		delay(10);
	end;
end;

begin
	script.NewThread(@MassSweepThread);
end.
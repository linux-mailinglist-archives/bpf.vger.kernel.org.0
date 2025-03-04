Return-Path: <bpf+bounces-53155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F1A4D161
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 03:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9185188D900
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89F354769;
	Tue,  4 Mar 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAScqV+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6A2F46
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053864; cv=none; b=VlCk92+Z8cNTpD/8OM2j1avaaqoah6srVQPdMtldGsvvNP5AdLcaBMnL4Tvi1o0Ct7dk4h4Uo5m7uLeVUGANWfvfm02atDR20HNU5NNzizLJlS+VxWfwlXN6im+ESS30MeFcF5vYOWmyTtmGdZI6NasHjPDkw1qchXcBHNMU9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053864; c=relaxed/simple;
	bh=DcCEF0yxb/7AX4q4xQ1zzGERbDf2MDmoQI/1iIg0j+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7ZyT5ABQ04kIQ5BB4O1WV/lxx4T6fwp5pQOBOz5E067cKRrHkU9LMWtZWRQpY7TMTqNbFyuYtsMib6E2/9xhk7lkTS4V/N6KlLssRU0DbaWUsLruiIf5U2BpXVnGdidMh6FkwJ2OxLQYZFaNKme/QsBL3LsGSUXbuHqQ5uuk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAScqV+9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso1123785e9.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 18:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741053861; x=1741658661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM/5QtMFkVh5ABgZJujkVIaPtGk15qyKScevaZ4FhK0=;
        b=kAScqV+9fVkskgiAKFP1uta0Ggol6ZASsOuN0Q9D5ItbSqO2jq16S48ic5wXWF7pic
         Kn8mstSjsTyfn6DvT5HJ22iqGQd+2mw2fxeatG4rVUCpCUJTZrVWovDmHI4yzqDO6IS1
         mnSidvflw4/aQpo0WOHj3iTvlWq/itpZqA3h0Ocn7zVy97x1wPQv9dFqj1ppRDI7BLdr
         SqnAcL5E/ew5qpFRs7kTkTJOHNSChgYuzyyu+P8oZChRX3NRINWud0Hbkre58kSvcn7h
         SV/jXH6kq/cESbcEJowb0D3y1oSoQ2ZWabpSCoBRHMPbup4xGh8ipRR0uQcxNqKDpoNx
         MueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741053861; x=1741658661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM/5QtMFkVh5ABgZJujkVIaPtGk15qyKScevaZ4FhK0=;
        b=ljVnGP9BjFWaJE+g/dqZ43L6X9iNQBjMjWgiMrsnmdIHxlBrN+mxr8H9HktP2Xl480
         O1AH/wc0F1n9JwbGERoRi9TT8ERgcsx4qseAWbSkD9mkx8UOOcEsOMMRNLfTmOSudPhk
         kgy7vpm/mBOK+lffP8m5A6g9Zo7VhK5U2zk8NlDPLgoHu+3vDbBbETRmO2ZlCzXKCsoU
         out58ZfLkBunGwvkeYeDV/2AXe1rvEIfKqRE8c+gFE6LuLVoJLELTCc+eNjwMt7shHf6
         ufVAv35OWGu0HVp9RfEofxR6k4mF+Jg2tt7W3DXzALzXfDuUKRYGo99VxMahu03+F6d7
         I0Ug==
X-Gm-Message-State: AOJu0Yw4/pA0kjp/14DTNgudfLy3n7NIyMMAlXlrur30o0qs21HtdsKt
	1FRHivBbNbUnDIiPmWLo13UlmEphMencLEY4fj8cTwHVZWzKtBkL2A3Kjd27axLrRbHo2F+X+9l
	SCuX3IoYAK1U6usr9KvK9n/mmQrY=
X-Gm-Gg: ASbGncu7k/FNFT+qv78AyjttnXa+GGbRFbEyNpRFXrJKwY6kWHblIMOFIaGOZNYNJnh
	/i15zk13al/nFXjSnjdw87ShUks5dG0EJxWfPljif5Sm4TusRaBthUKqht6v/UDpCNeaHYTH7sR
	USxNs0H5dZ/qEZtuQfuYXSdJsTLs6l3jU+0RdT3lay8w==
X-Google-Smtp-Source: AGHT+IEvpbb60WU00jvyxXJwN+NHfqI+qai0zP/pMfMB57MrXtTkErZgYjWusn1Fhu6FA18eaG+dMAG0KwMJ2MMIb+0=
X-Received: by 2002:a5d:6da3:0:b0:390:e76f:163 with SMTP id
 ffacd0b85a97d-390eca52819mr14056647f8f.45.1741053860572; Mon, 03 Mar 2025
 18:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304003239.2390751-1-memxor@gmail.com> <20250304003239.2390751-2-memxor@gmail.com>
In-Reply-To: <20250304003239.2390751-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 18:04:09 -0800
X-Gm-Features: AQ5f1JpNDUI8BLvzXsk9W5XpyXhu159CP95J7bCCS6TkrX4LwFhtZ1RLUF9NvK4
Message-ID: <CAADnVQKioRtH8yKkx2yBPu8NMiU38qfgfXEjEaXayU77LMBssw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add verifier support for timed may_goto
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:32=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
> +{
> +       u64 time =3D ktime_get_mono_fast_ns();
> +
> +       /*
> +        * Populate the timestamp for this stack frame, and refresh count=
.
> +        */
> +       if (!p->timestamp) {
> +               p->timestamp =3D time;
> +               return BPF_MAX_TIMED_LOOPS;
> +       }
> +       /*
> +        * Check if we've exhausted our time slice, and zero count.
> +        */
> +       if (time - p->timestamp >=3D (NSEC_PER_SEC / 4))
> +               return 0;
> +       /*
> +        * Refresh the count for the stack frame.
> +        */

I converted the comments back to single line comments.

> +       return BPF_MAX_TIMED_LOOPS;
> +}
> +
>  /* for configs without MMU or 32-bit */
>  __weak const struct bpf_map_ops arena_map_ops;
>  __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 22c4edc8695c..f3e95d471fa3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21572,7 +21572,50 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 }
>
> -               if (is_may_goto_insn(insn)) {
> +               if (is_may_goto_insn(insn) && bpf_jit_supports_timed_may_=
goto()) {
> +                       int stack_off_cnt =3D -stack_depth - 16;
> +
> +                       /*
> +                        * Two 8 byte slots, depth-16 stores the count, a=
nd
> +                        * depth-8 stores the start timestamp of the loop=
.
> +                        *
> +                        * The starting value of count is BPF_MAX_TIMED_L=
OOPS
> +                        * (0xffff).  Every iteration loads it and subs i=
t by 1,
> +                        * until the value becomes 0 in AX (thus, 1 in st=
ack),
> +                        * after which we call arch_bpf_timed_may_goto, w=
hich
> +                        * either sets AX to 0xffff to keep looping, or t=
o 0
> +                        * upon timeout. AX is then stored into the stack=
. In
> +                        * the next iteration, we either see 0 and break =
out, or
> +                        * continue iterating until the next time value i=
s 0
> +                        * after subtraction, rinse and repeat.
> +                        */
> +                       stack_depth_extra =3D 16;
> +                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX, B=
PF_REG_10, stack_off_cnt);
> +                       if (insn->off >=3D 0)
> +                               insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BPF_=
REG_AX, 0, insn->off + 5);
> +                       else
> +                               insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BPF_=
REG_AX, 0, insn->off - 1);
> +                       insn_buf[2] =3D BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX=
, 1);
> +                       insn_buf[3] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, =
0, 2);
> +                       /*
> +                        * AX is used as an argument to pass in stack_off=
_cnt
> +                        * (to add to r10/fp), and also as the return val=
ue of
> +                        * the call to arch_bpf_timed_may_goto.
> +                        */
> +                       insn_buf[4] =3D BPF_MOV64_IMM(BPF_REG_AX, stack_o=
ff_cnt);
> +                       insn_buf[5] =3D BPF_EMIT_CALL(arch_bpf_timed_may_=
goto);
> +                       insn_buf[6] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, B=
PF_REG_AX, stack_off_cnt);
> +                       cnt =3D 7;
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn =3D new_prog->insnsi + i + delta;
> +                       goto next_insn;
> +               } else if (is_may_goto_insn(insn)) {
>                         int stack_off =3D -stack_depth - 8;
>
>                         stack_depth_extra =3D 8;
> @@ -22113,23 +22156,34 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>
>         env->prog->aux->stack_depth =3D subprogs[0].stack_depth;
>         for (i =3D 0; i < env->subprog_cnt; i++) {
> +               int delta =3D bpf_jit_supports_timed_may_goto() ? 2 : 1;
>                 int subprog_start =3D subprogs[i].start;
>                 int stack_slots =3D subprogs[i].stack_extra / 8;
> +               int slots =3D delta, cnt =3D 0;
>
>                 if (!stack_slots)
>                         continue;
> -               if (stack_slots > 1) {
> +               /*
> +                * We need two slots in case timed may_goto is supported.
> +                */
> +               if (stack_slots > slots) {
>                         verbose(env, "verifier bug: stack_slots supports =
may_goto only\n");
>                         return -EFAULT;
>                 }
>
> -               /* Add ST insn to subprog prologue to init extra stack */
> -               insn_buf[0] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
> -                                        -subprogs[i].stack_depth, BPF_MA=
X_LOOPS);

and here added
stack_depth =3D subprogs[i].stack_depth;
to reduce copy paste in below lines...

> +               if (bpf_jit_supports_timed_may_goto()) {
> +                       insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP=
, -subprogs[i].stack_depth,
> +                                                    BPF_MAX_TIMED_LOOPS)=
;
> +                       insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP=
, -subprogs[i].stack_depth + 8, 0);
> +               } else {
> +                       /* Add ST insn to subprog prologue to init extra =
stack */
> +                       insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP=
, -subprogs[i].stack_depth,
> +                                                    BPF_MAX_LOOPS);
> +               }

and applied.


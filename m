Return-Path: <bpf+bounces-53116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A5A4CDC9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CEE3A77FD
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA71F12F9;
	Mon,  3 Mar 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itw3BMVz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B71E5213
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039188; cv=none; b=ARWr6h0aMG9oesLLN+tV0/RFm8/HHcBEb80baHCDsi6sgdvBG9aFG+lOy45ZCVQJPX3SuHZwBMeA/hm/KGaHqJSv6Z6LMC15BLg6vkiyWYmIXcKHtDMn3T8GiVcowQYawxu9+F5+wPVVI5AsuJNVIAXJDgGYTMI1q5hDd0v4xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039188; c=relaxed/simple;
	bh=e25i1ZCq3KSszdAaF7ozblKDigSvmGrXphzHnTnwTjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1sns10pLikmoPSa3kSx+n/tehlLukHqXWbNpXg9IFFCFBdpMej9o9AsOJqADBT+x8Cs9jf3SqKdh4QwNF8KWGighS2BCW21t0lIVq5FDcP3RvP0waac2u87cFYbrtyU+zXHDRQyUzTB31X7K+Nchqb6usBnST1mnNccYsbWGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itw3BMVz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43998deed24so47061635e9.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039184; x=1741643984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPDl9TYchzJyySw5yGOuKrZPQOgfBexHEv+0ejlxcKc=;
        b=itw3BMVz98g2YprJQb5fXR9f4pDTMuFpopWdYHksjjLEaRczF5Eojdqwt8BdBRlOTr
         NvicrmDCiVHwTyjMIbsNmLChxISO7OoxCVCLDFUPUxMnozgdqYkK6PBOF9kH1quVi+d7
         Zw3EQYaLQ3INdS81cd466v3D9+7gigrjWneiFs/or7TYB/TQd1i8Ba1Aho5sHmrkSD8k
         kq0AMK6qOibp32iN0FMcW381IQhkJboQ2AwvA0YbwuTM9EnTPfyWBPQoHm6bX+uif+Wx
         kqXp+ogtugveLB618+vQOQgUfdkljF17qCHHg9RiqG/TdmxTGOYltAtCoIRZdkS2hQxf
         Go9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039184; x=1741643984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPDl9TYchzJyySw5yGOuKrZPQOgfBexHEv+0ejlxcKc=;
        b=FyXegSeUFcIgKGrlSJziXMuNlG1jBjyiKAJEraC1J2Ex9N5e9j46k9up3epIVKE3+J
         gOUN2gB6Q9Ma5MAnUSfbMnwoIg16IYSKKOJ5xe4bn8YJRhE5ELIEXJjeCPG4y5mTVNIW
         OVgAkXbECCcfh+iCysx2JlmGCcjBWaKBUAuWtypWN7nakIhneqqqUp8Wl8rSTESbTNLY
         6vzsLvCiaGHsdFmsFFVMaOxw7JIbidfj8/OIeZxiDC8g9ibtzbOxUbQvnhTJH6aPbgFJ
         /2Ch8QIgB1eMdKY53OY7LRt+06+WTQiNHOAIuucVjcSQGYBw2xs6pJfNgLYnQ9fwOpWN
         lhdg==
X-Gm-Message-State: AOJu0YyoKuCnW3bM2CpYc5g+zf7PiEnjqBzCyeinafknG8tIk5tdTEfZ
	mcLdbIWLAWkqmqx2TvTo4Jn8mAN2SKpsKAxHRXg9tyJ6jEtxyjmJmQxkoh4NlHIR7/0HumWHSay
	YPEKOVLQpShd7Al62hokeiMsUmr4=
X-Gm-Gg: ASbGncu5MCiKoPreq6JxxPXQG/tT4xjk57SckTViEisc6FgSXC3DwhYLBVqYIjp1quU
	CN1OutRK8ffO5GneMvKewYz7uAv8vCkw2O4n2hOL+/y36Yvnw6tcXLNcgHJHCKnnJk++12dpqvv
	OabSwuPxDb8VZbkga0gcHGWzL/u9LHxgFd8ShShCT0ug==
X-Google-Smtp-Source: AGHT+IG01nMpE/OLzOTHk9oyxZOyVbMnj7DR6OhhBosXgUBMNpKdwyVNY50YLHdcCO4RaUhnfOcrJ+MhZ4/yL/6BRXI=
X-Received: by 2002:a7b:c3cb:0:b0:43b:c0fa:f9dc with SMTP id
 5b1f17b1804b1-43bc0fafe33mr44591065e9.10.1741039183921; Mon, 03 Mar 2025
 13:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302201348.940234-1-memxor@gmail.com> <20250302201348.940234-2-memxor@gmail.com>
In-Reply-To: <20250302201348.940234-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 13:59:32 -0800
X-Gm-Features: AQ5f1Jqv-3Zz76jy1zy0ZMGvmPdyjGqJs_9pEBXLC8lABb-4QjqmHT9rWy8cQ6Q
Message-ID: <CAADnVQJsW1Nk_yhz=fiAtuDsx-V0vPWZHzVyx25cbVpX+SvOiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add verifier support for timed may_goto
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Implement support in the verifier for replacing may_goto implementation
> from a counter-based approach to one which samples time on the local CPU
> to have a bigger loop bound.
>
> We implement it by maintaining 16-bytes per-stack frame, and using 8
> bytes for maintaining the count for amortizing time sampling, and 8
> bytes for the starting timestamp. To minimize overhead, we need to avoid
> spilling and filling of registers around this sequence, so we push this
> cost into the time sampling function 'arch_bpf_timed_may_goto'. This is
> a JIT-specific wrapper around bpf_check_timed_may_goto which returns us
> the count to store into the stack through BPF_REG_AX. All caller-saved
> registers (r0-r5) are guaranteed to remain untouched.
>
> The loop can be broken by returning count as 0, otherwise we dispatch
> into the function when the count becomes 1, and the runtime chooses to
> refresh it (by returning count as BPF_MAX_TIMED_LOOPS) or returning 0
> and aborting it.
>
> Since the check for 0 is done right after loading the count from the
> stack, all subsequent cond_break sequences should immediately break as
> well.
>
> We pass in the stack_depth of the count (and thus the timestamp, by
> adding 8 to it) to the arch_bpf_timed_may_goto call so that it can be
> passed in to bpf_check_timed_may_goto as an argument after r1 is saved,
> by adding the offset to r10/fp. This adjustment will be arch specific,
> and the next patch will introduce support for x86.
>
> Note that depending on loop complexity, time spent in the loop can be
> more than the current limit (250 ms), but imposing an upper bound on
> program runtime is an orthogonal problem which will be addressed when
> program cancellations are supported.
>
> The current time afforded by cond_break may not be enough for cases
> where BPF programs want to implement locking algorithms inline, and use
> cond_break as a promise to the verifier that they will eventually
> terminate.
>
> Below are some benchmarking numbers on the time taken per-iteration for
> an empty loop that counts the number of iterations until cond_break
> fires. For comparison, we compare it against bpf_for/bpf_repeat which is
> another way to achieve the same number of spins (BPF_MAX_LOOPS).  The
> hardware used for benchmarking was a Saphire Rapids Intel server with
> performance governor enabled.
>
> +-----------------------------+--------------+--------------+------------=
------+
> | Loop type                   | Iterations   |  Time (ms)   |   Time/iter=
 (ns) |
> +-----------------------------|--------------+--------------+------------=
------+
> | may_goto                    | 8388608      |  3           |   0.36     =
      |
> | timed_may_goto (count=3D65535)| 589674932    |  250         |   0.42   =
        |
> | bpf_for                     | 8388608      |  10          |   1.19     =
      |
> +-----------------------------+--------------+--------------+------------=
------+
>
> This gives a good approximation at low overhead while staying close to
> the current implementation.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h    |  1 +
>  include/linux/filter.h |  8 +++++++
>  kernel/bpf/core.c      | 31 +++++++++++++++++++++++++
>  kernel/bpf/verifier.c  | 52 +++++++++++++++++++++++++++++++++++-------
>  4 files changed, 84 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index aec102868b93..788f6ca374e9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1986,6 +1986,7 @@ struct bpf_array {
>   */
>  enum {
>         BPF_MAX_LOOPS =3D 8 * 1024 * 1024,
> +       BPF_MAX_TIMED_LOOPS =3D 0xffff,
>  };
>
>  #define BPF_F_ACCESS_MASK      (BPF_F_RDONLY |         \
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 3ed6eb9e7c73..02dda5c53d91 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -669,6 +669,11 @@ struct bpf_prog_stats {
>         struct u64_stats_sync syncp;
>  } __aligned(2 * sizeof(u64));
>
> +struct bpf_timed_may_goto {
> +       u64 count;
> +       u64 timestamp;
> +};
> +
>  struct sk_filter {
>         refcount_t      refcnt;
>         struct rcu_head rcu;
> @@ -1130,8 +1135,11 @@ bool bpf_jit_supports_ptr_xchg(void);
>  bool bpf_jit_supports_arena(void);
>  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
>  bool bpf_jit_supports_private_stack(void);
> +bool bpf_jit_supports_timed_may_goto(void);
>  u64 bpf_arch_uaddress_limit(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
> +u64 arch_bpf_timed_may_goto(void);
> +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
>  bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
>
>  static inline bool bpf_dump_raw_ok(const struct cred *cred)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a0200fbbace9..b3f7c7bd08d3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3069,6 +3069,37 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
(void *cookie, u64 ip, u64 sp,
>  {
>  }
>
> +bool __weak bpf_jit_supports_timed_may_goto(void)
> +{
> +       return false;
> +}
> +
> +u64 __weak arch_bpf_timed_may_goto(void)
> +{
> +       return 0;
> +}
> +
> +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
> +{
> +       u64 time =3D ktime_get_mono_fast_ns();

let's move the call after !p->count check to avoid unused work.

> +
> +       /* If the count is zero, we've already broken a prior loop in thi=
s stack
> +        * frame, let's just exit quickly.
> +        */

Let's use normal kernel comment style in all new code.
I think even netdev folks allow both styles now.

> +       if (!p->count)
> +               return 0;
> +       /* Populate the timestamp for this stack frame. */
> +       if (!p->timestamp) {
> +               p->timestamp =3D time;
> +               return BPF_MAX_TIMED_LOOPS;
> +       }
> +       /* Check if we've exhausted our time slice. */
> +       if (time - p->timestamp >=3D (NSEC_PER_SEC / 4))
> +               return 0;
> +       /* Refresh the count for the stack frame. */
> +       return BPF_MAX_TIMED_LOOPS;
> +}
> +
>  /* for configs without MMU or 32-bit */
>  __weak const struct bpf_map_ops arena_map_ops;
>  __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dcd0da4e62fc..79bfb1932f40 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21503,7 +21503,34 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 }
>
> -               if (is_may_goto_insn(insn)) {
> +               if (is_may_goto_insn(insn) && bpf_jit_supports_timed_may_=
goto()) {
> +                       int stack_off_cnt =3D -stack_depth - 16;
> +
> +                       /* Two 8 byte slots, depth-16 stores the count, a=
nd
> +                        * depth-8 stores the start timestamp of the loop=
.
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
1, 2);

Maybe !=3D 0 instead ?
Otherwise it's off by 1.

> +                       insn_buf[4] =3D BPF_MOV64_IMM(BPF_REG_AX, stack_o=
ff_cnt);

Please add a comment that BPF_REG_AX is used as an argument
register and contains return value too.

I looked at a couple other non-x86 JITs and I think this calling
convention should work for them too.

> +                       insn_buf[5] =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, =
0, 0, 0, BPF_CALL_IMM(arch_bpf_timed_may_goto));

Use BPF_EMIT_CALL() instead?

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
> @@ -22044,23 +22071,32 @@ static int do_misc_fixups(struct bpf_verifier_e=
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
> +               /* We need two in case timed may_goto is supported. */
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
>                 /* Copy first actual insn to preserve it */
> -               insn_buf[1] =3D env->prog->insnsi[subprog_start];
> +               insn_buf[cnt++] =3D env->prog->insnsi[subprog_start];
>
> -               new_prog =3D bpf_patch_insn_data(env, subprog_start, insn=
_buf, 2);
> +               new_prog =3D bpf_patch_insn_data(env, subprog_start, insn=
_buf, cnt);
>                 if (!new_prog)
>                         return -ENOMEM;
>                 env->prog =3D prog =3D new_prog;
> @@ -22070,7 +22106,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                  * to insn after BPF_ST that inits may_goto count.
>                  * Adjustment will succeed because bpf_patch_insn_data() =
didn't fail.
>                  */
> -               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
> +               WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
>         }
>
>         /* Since poke tab is now finalized, publish aux to tracker. */
> --
> 2.43.5
>


Return-Path: <bpf+bounces-68662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7AB7F919
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16C73A16A0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC193090EC;
	Wed, 17 Sep 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmQJgKQY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06E2FBE0C
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116610; cv=none; b=lVwGJOGUZYSRzMKv11pH4uICXlueYFIE37+kr8s4MxhabkUl5w0/KNixC7AAvoBBP72vCYb0vLOpdVtTQ1YPwfXG6Adnd3li9ViT9ZbF8ft4V6boV+8U75IInkdVMUCtiybY2kDMgsSoq1XNVIDsVFwI/gXI+95VCFQzifTYhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116610; c=relaxed/simple;
	bh=QsabnHuoJVpZzRvuZyNzaAqudPEIzFgkuPaY4sUfqKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qp+IB0TovEicfD6ZQLbUB6SA1TetfW4R+2iOjs3nGjpSFrgTs+lgfg7rlsgVPNXCDXDEOAaE35XKULGB1120sDaL9OyL+JPo3KNxN+DOdiYuqyHnjOdofgMGStPabYFW6ywgIjmdMBGs5xdqBb2Zgxjfb0ATiXXMCuTQ5pYSwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmQJgKQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B08DC4CEF0;
	Wed, 17 Sep 2025 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758116610;
	bh=QsabnHuoJVpZzRvuZyNzaAqudPEIzFgkuPaY4sUfqKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XmQJgKQYHI+/p1suB7QwRJIIRnxjDN/2J1bYWMKCuzWPo0x9Dup9bY6zLPR4LBQpx
	 32fqV7oDUl8Tn15Bf3TcbxrJoiJ9fVl4inNzKwi2phO/0vijHZrYGTz9zRgswAFP9s
	 bBSH+7xqyewEyWpK0V6AIPfqF4p8QQsViCX4Ena+n5dfu5QUfj0syjVtbsrbdkivu5
	 DcW04fUOMwaqlnI77n0BC7jnyyMrf2oz9KiNewGDZjoEfLDWD9bu3qPxYk9BJXsJjV
	 ln35H2LQ0Irv7cY1KM/qV1KfAqMyjgL3Ibt47WF9hhbAHf05GrDX4vvEHw18H+xWh7
	 VEB9BjB4ib/tg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
In-Reply-To: <CAADnVQKqjQKrSYTm8DO-GLYTFyaGaN8_RiuuJ8kj4zaAShQF0w@mail.gmail.com>
References: <20250916113622.19540-1-puranjay@kernel.org>
 <CAADnVQKqjQKrSYTm8DO-GLYTFyaGaN8_RiuuJ8kj4zaAShQF0w@mail.gmail.com>
Date: Wed, 17 Sep 2025 13:43:26 +0000
Message-ID: <mb61pfrclqjnl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Sep 16, 2025 at 4:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> Currently, nested rcu critical sections are rejected by the verifier and
>> rcu_lock state is managed by a boolean variable. Add support for nested
>> rcu critical sections by make active_rcu_locks a counter similar to
>> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
>> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
>> happens when active_rcu_locks drops to 0.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  include/linux/bpf_verifier.h                  |  2 +-
>>  kernel/bpf/verifier.c                         | 34 ++++++++--------
>>  .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
>>  .../selftests/bpf/progs/rcu_read_lock.c       | 40 +++++++++++++++++++
>>  4 files changed, 61 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 020de62bd09c..3fb4632d5eed 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -441,7 +441,7 @@ struct bpf_verifier_state {
>>         u32 active_irq_id;
>>         u32 active_lock_id;
>>         void *active_lock_ptr;
>> -       bool active_rcu_lock;
>> +       u32 active_rcu_locks;
>>
>>         bool speculative;
>>         bool in_sleepable;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1029380f84db..645af66e29ab 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1438,7 +1438,7 @@ static int copy_reference_state(struct bpf_verifie=
r_state *dst, const struct bpf
>>         dst->acquired_refs =3D src->acquired_refs;
>>         dst->active_locks =3D src->active_locks;
>>         dst->active_preempt_locks =3D src->active_preempt_locks;
>> -       dst->active_rcu_lock =3D src->active_rcu_lock;
>> +       dst->active_rcu_locks =3D src->active_rcu_locks;
>>         dst->active_irq_id =3D src->active_irq_id;
>>         dst->active_lock_id =3D src->active_lock_id;
>>         dst->active_lock_ptr =3D src->active_lock_ptr;
>> @@ -5924,7 +5924,7 @@ static bool in_sleepable(struct bpf_verifier_env *=
env)
>>   */
>>  static bool in_rcu_cs(struct bpf_verifier_env *env)
>>  {
>> -       return env->cur_state->active_rcu_lock ||
>> +       return env->cur_state->active_rcu_locks ||
>>                env->cur_state->active_locks ||
>>                !in_sleepable(env);
>>  }
>> @@ -10684,7 +10684,7 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>>                 }
>>
>>                 if (env->subprog_info[subprog].might_sleep &&
>> -                   (env->cur_state->active_rcu_lock || env->cur_state->=
active_preempt_locks ||
>> +                   (env->cur_state->active_rcu_locks || env->cur_state-=
>active_preempt_locks ||
>>                      env->cur_state->active_irq_id || !in_sleepable(env)=
)) {
>>                         verbose(env, "global functions that may sleep ar=
e not allowed in non-sleepable context,\n"
>>                                      "i.e., in a RCU/IRQ/preempt-disable=
d section, or in\n"
>> @@ -11231,7 +11231,7 @@ static int check_resource_leak(struct bpf_verifi=
er_env *env, bool exception_exit
>>                 return -EINVAL;
>>         }
>>
>> -       if (check_lock && env->cur_state->active_rcu_lock) {
>> +       if (check_lock && env->cur_state->active_rcu_locks) {
>>                 verbose(env, "%s cannot be used inside bpf_rcu_read_lock=
-ed region\n", prefix);
>>                 return -EINVAL;
>>         }
>> @@ -11426,7 +11426,7 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>>                 return err;
>>         }
>>
>> -       if (env->cur_state->active_rcu_lock) {
>> +       if (env->cur_state->active_rcu_locks) {
>>                 if (fn->might_sleep) {
>>                         verbose(env, "sleepable helper %s#%d in rcu_read=
_lock region\n",
>>                                 func_id_name(func_id), func_id);
>> @@ -13863,7 +13863,7 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>>         preempt_disable =3D is_kfunc_bpf_preempt_disable(&meta);
>>         preempt_enable =3D is_kfunc_bpf_preempt_enable(&meta);
>>
>> -       if (env->cur_state->active_rcu_lock) {
>> +       if (env->cur_state->active_rcu_locks) {
>>                 struct bpf_func_state *state;
>>                 struct bpf_reg_state *reg;
>>                 u32 clear_mask =3D (1 << STACK_SPILL) | (1 << STACK_ITER=
);
>> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
>>                 }
>>
>>                 if (rcu_lock) {
>> -                       verbose(env, "nested rcu read lock (kernel funct=
ion %s)\n", func_name);
>> -                       return -EINVAL;
>> +                       env->cur_state->active_rcu_locks++;
>>                 } else if (rcu_unlock) {
>> -                       bpf_for_each_reg_in_vstate_mask(env->cur_state, =
state, reg, clear_mask, ({
>> -                               if (reg->type & MEM_RCU) {
>> -                                       reg->type &=3D ~(MEM_RCU | PTR_M=
AYBE_NULL);
>> -                                       reg->type |=3D PTR_UNTRUSTED;
>> -                               }
>> -                       }));
>> -                       env->cur_state->active_rcu_lock =3D false;
>> +                       if (--env->cur_state->active_rcu_locks =3D=3D 0)=
 {
>
> hmm. can it go negative ?
>
> nested_rcu_region_unbalanced_1 test suppose to check it,
> but what kind of error is returned?

It can't go regative as active_rcu_locks is checked above before the
line (-- =3D=3D 0) is executed, nested_rcu_region_unbalanced_1 will return
the following error:

unmatched rcu read unlock (kernel function bpf_rcu_read_unlock)

>
>
>> +                               bpf_for_each_reg_in_vstate_mask(env-
>
> rewrite it to avoid adding extra ident?

Ack!

>>cur_state, state, reg, clear_mask, ({
>> +                                       if (reg->type & MEM_RCU) {
>> +                                               reg->type &=3D ~(MEM_RCU=
 | PTR_MAYBE_NULL);
>> +                                               reg->type |=3D PTR_UNTRU=
STED;
>> +                                       }
>> +                               }));
>> +                       }
>>                 } else if (sleepable) {
>>                         verbose(env, "kernel func %s is sleepable within=
 rcu_read_lock region\n", func_name);
>>                         return -EACCES;
>>                 }
>>         } else if (rcu_lock) {
>> -               env->cur_state->active_rcu_lock =3D true;
>> +               env->cur_state->active_rcu_locks++;
>>         } else if (rcu_unlock) {
>>                 verbose(env, "unmatched rcu read unlock (kernel function=
 %s)\n", func_name);
>>                 return -EINVAL;
>> @@ -18887,7 +18887,7 @@ static bool refsafe(struct bpf_verifier_state *o=
ld, struct bpf_verifier_state *c
>>         if (old->active_preempt_locks !=3D cur->active_preempt_locks)
>>                 return false;
>>
>> -       if (old->active_rcu_lock !=3D cur->active_rcu_lock)
>> +       if (old->active_rcu_locks !=3D cur->active_rcu_locks)
>>                 return false;
>>
>>         if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
>> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/to=
ols/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>> index c9f855e5da24..246eb259c08a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>> @@ -28,6 +28,7 @@ static void test_success(void)
>>         bpf_program__set_autoload(skel->progs.two_regions, true);
>>         bpf_program__set_autoload(skel->progs.non_sleepable_1, true);
>>         bpf_program__set_autoload(skel->progs.non_sleepable_2, true);
>> +       bpf_program__set_autoload(skel->progs.nested_rcu_region, true);
>>         bpf_program__set_autoload(skel->progs.task_trusted_non_rcuptr, t=
rue);
>>         bpf_program__set_autoload(skel->progs.rcu_read_lock_subprog, tru=
e);
>>         bpf_program__set_autoload(skel->progs.rcu_read_lock_global_subpr=
og, true);
>> @@ -78,7 +79,8 @@ static const char * const inproper_region_tests[] =3D {
>>         "non_sleepable_rcu_mismatch",
>>         "inproper_sleepable_helper",
>>         "inproper_sleepable_kfunc",
>> -       "nested_rcu_region",
>
> should be deleted from progs/rcu_read_lock.c too ?

This is not deleted, just moved above into test_success() because now it
will succeed.

> This selftests hunk should in the main patch,
> but below new tests need to go into another patch.

Sure, I will split the changes into two patches.


Thanks,
Puranjay


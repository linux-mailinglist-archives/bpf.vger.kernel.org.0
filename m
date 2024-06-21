Return-Path: <bpf+bounces-32685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBA911922
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 05:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05AF2840AA
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A3127B62;
	Fri, 21 Jun 2024 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGukH8vO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27B43687;
	Fri, 21 Jun 2024 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942088; cv=none; b=SdA29WyNVJ/gGtkc6nPaJGYpbq3efFN0xl43budc7BUGMUBw2d6ozxp8QmT12xZ7NByx7lwHlNdYsP9Ykli/pcWEikQL59i/lgvJC4gAu+hG0Ia3FNyHliOQgWbkB4E/RegaDON8Ot0IWwbv2kh/SboqV6lkIaGtfHYFbxhvo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942088; c=relaxed/simple;
	bh=PskQLFs0tTCQe+R5dwKN+t+4IktNY3ftEQAFoEPxBcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0SSrKeDt4NiQ2+JjUESI3jQ/1ZtVGf1tDxSXQNoua94I/Rn9uITcQpHOmX7Zb18rkldyhgIKLi9FeP20jiMHdU1Q82D0KsD8Xqm5lmeEkDHXMBP/UXa/QNS2DOo+g5Cr44Abv7JDjb1M/uDfBcCmCAj/JPAhqa/V/exXXhABSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGukH8vO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421eab59723so12225145e9.3;
        Thu, 20 Jun 2024 20:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718942084; x=1719546884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJkt70AcS7WvaiTi/TT0EQ7gtGa0lI/JcE0ucrQQu2c=;
        b=UGukH8vOehrXcoDxrRnygn7lh9A3eIYVL2SXKTHHJ+/aJRVEjq1D5fKn80myU71cZu
         40nNA/Y+mmh7qvoVOtkMN/vvjBDdic2q4NebnGFzKPjuXyVlfLLnqHNR0BXL1cQWMDNc
         f2xN///chzMXap7lvFwoic+lN7VkU0aNYa+VfC8pED/Eo8tXmo8mr1r2fMGdJgMWJM+U
         sEQuTKtxjQ+A3j0/59Uus2yGI9zN4s99Zesl6L4OIrnd3WSA/y5lIfFwu4JGaRGKMgcs
         8OU+Dp5GrBU+TeDU+lcHyBDhLRkmw+9UmR/1pYmdIK5lC1XPhoR48nfBb72juvtHjxTd
         kFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718942084; x=1719546884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJkt70AcS7WvaiTi/TT0EQ7gtGa0lI/JcE0ucrQQu2c=;
        b=DI76CzRqCq4yCYTn6XtD+cHRY462IA7dounPjVtn5p3ZwsG55xIFiGshmuOmTPeDl7
         AK4bjGIG081kdSWGh0xgnwZ6GLB2OABi9k8GNWkp76bzqQdZo83eeQmG6O1zuHbGAbUS
         GAEcN0CXjrXW75H/f738Klr+YEdtBJlrKp+lxFXcNoBES/j3lWOwucG3bNpE10PB9IOk
         aDzxLdxiYOBgFiWZBSW1vuttiiBRw5kxUPwJpbejfzdOr71zMMJotLbZ8MVR7oygcKcM
         +Ogf2CdU+3yXcLmfBZjhpmniUEs9Mz/alcdSpbyS08mcENgSaBe/uJWGvSqvltZxkTAU
         u35A==
X-Forwarded-Encrypted: i=1; AJvYcCUEkZl4LHKSJlXi1t9xRHS7NN0Igw6m4Xn0I9UpWXxCs/ALLL3CaoHRPy9m3NOgrf4zvpGurcLtBHAIIjMGMMrXrPdM7X78kI0PD1o7HXDfG9nuJTuR8btVctxRRnKucU8D
X-Gm-Message-State: AOJu0YxCDJWOstyRiv6yuyxEaOs9mvjd4ecIRut2QhYBFlKO9Djp4eNV
	GjU1oR2RAmQoSx18zyGdff1ISnFUeIlDnRjb0sXxAM2oZaCL/cea+ngbKeS+p2Q3UpIUZtBC1d3
	lPLa2nLmf9GzAPVXz7Z54pCD23MBlvZuP
X-Google-Smtp-Source: AGHT+IEpr0901/ovIHLJCFeJFi2cgLAu1/qzbCdAnGSe2/7n/JdN+yYy1F1MX0eZhHmmez4hqZKKr7oYqWL8j0dLqsU=
X-Received: by 2002:a7b:c8ce:0:b0:422:807a:992f with SMTP id
 5b1f17b1804b1-42475296a90mr54252185e9.30.1718942084210; Thu, 20 Jun 2024
 20:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008312ad06163b7225@google.com> <20240618130518.25884-1-wojciech.gladysz@infogain.com>
In-Reply-To: <20240618130518.25884-1-wojciech.gladysz@infogain.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Jun 2024 20:54:32 -0700
Message-ID: <CAADnVQKmnzDueZ22rcYc1FuBpFKPJqb_NueT_HTcK3Bqt7O76w@mail.gmail.com>
Subject: Re: [PATCH] kernel/bpf: enable BPF bytecode call parsing for uninit value
To: =?UTF-8?Q?Wojciech_G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Cc: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:05=E2=80=AFAM Wojciech G=C5=82adysz
<wojciech.gladysz@infogain.com> wrote:
>
> Some syzkaller repros create BPF code that passes as an argument to map
> functions a pointer to uninitialized map key on bpf program stack. So far
> handling calls to map functions did not check for not/initialized
> pointed to values with some comments that it was not possible to tell the
> pointer use be read or write op. This led to KMSAN report in a case of
> reading not initialized map key.
> The fix assumes ARG_PTR_TO_MAP_KEY arguments to map function calls from
> BPF byte code are always of read type. For read access the value pointed
> to by map key pointer is expected to be initialized. Otherwise the BPF
> bytecode will not load.
>
> You may want to add an STX line to your repro.c to init stack value
> pointed to by R2 BPF register and adjust memcpy length:
>
>   memcpy((void*)0x20000458,
>          "\x00\x00\x00\x00\x00\x00\x00\x00"     // ...
>          "\xb7\x08\x00\x00\x00\x00\x00\x00"     // ALU64_MOV_K
>          "\x1f\x00\x00\x00\x00\x00\x00\x00"     // SUB_X?
>          "\xbf\xa2\x00\x00\x00\x00\x00\x00"     // ALU64_MOV_X
>          "\x07\x02\x00\x00\xf8\xff\xff\xff"     // ALU(64)_ADD_{K,X}
>          "\x7a\x02\x00\x00\xef\xbe\xad\xde"     // *** STX ***
>          "\xb7\x03\x00\x00\x00\x00\x00\x00"     // ALU64_MOV_K
>          "\xb7\x04\x00\x00\x00\x00\x00\x00"     // ALU64_MOV_K
>          "\x85\x00\x00\x00\xc3\x00\x00\x00"     // CALL
>          "\x95", 73);                           // EXIT
>
> Syzbot report
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:6=
91 [inline]
> BUG: KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem+0x3f8/=
0x630 kernel/bpf/hashtab.c:2343
>  __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
>  htab_lru_percpu_map_lookup_percpu_elem+0x3f8/0x630 kernel/bpf/hashtab.c:=
2343
>  ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:133 [inline]
>  bpf_map_lookup_percpu_elem+0x67/0x90 kernel/bpf/helpers.c:130
>  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>  __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
>  __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
>  trace_kfree include/trace/events/kmem.h:94 [inline]
>  kfree+0x6a5/0xa30 mm/slub.c:4377
>  security_task_free+0x115/0x150 security/security.c:3032
>  __put_task_struct+0x17f/0x730 kernel/fork.c:976
>  put_task_struct include/linux/sched/task.h:138 [inline]
>  delayed_put_task_struct+0x8a/0x280 kernel/exit.c:229
>  rcu_do_batch kernel/rcu/tree.c:2196 [inline]
>  rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
>  rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
>  __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:633 [inline]
>  irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
>  sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
>  asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.=
h:702
>  __msan_metadata_ptr_for_load_8+0x31/0x40 mm/kmsan/instrumentation.c:92
>  filter_irq_stacks+0x60/0x1a0 kernel/stacktrace.c:397
>  stack_depot_save_flags+0x2c/0x6e0 lib/stackdepot.c:609
>  stack_depot_save+0x12/0x20 lib/stackdepot.c:685
>  __msan_poison_alloca+0x106/0x1b0 mm/kmsan/instrumentation.c:285
>  arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
>  arch_local_irq_save arch/x86/include/asm/irqflags.h:103 [inline]
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
>  _raw_spin_lock_irqsave+0x35/0xc0 kernel/locking/spinlock.c:162
>  remove_wait_queue+0x36/0x270 kernel/sched/wait.c:54
>  do_wait+0x34a/0x530 kernel/exit.c:1640
>  kernel_wait4+0x2ab/0x480 kernel/exit.c:1790
>  __do_sys_wait4 kernel/exit.c:1818 [inline]
>  __se_sys_wait4 kernel/exit.c:1814 [inline]
>  __x64_sys_wait4+0x14e/0x310 kernel/exit.c:1814
>  x64_sys_call+0x6e6/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:6=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Local variable stack created at:
>  __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
>
> CPU: 0 PID: 5018 Comm: strace-static-x Not tainted 6.9.0-rc3-syzkaller-00=
355-g7efd0a74039f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Reported-by: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1971e47e5210c718db3c
> Link: https://lore.kernel.org/all/0000000000008312ad06163b7225@google.com=
/T/
> Signed-off-by: Wojciech G=C5=82adysz <wojciech.gladysz@infogain.com>
> ---
>  kernel/bpf/verifier.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 36ef8e96787e..13a9c2e2908a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7146,8 +7146,8 @@ static int check_stack_range_initialized(
>                  * reads. However, if raw_mode is not set, we'll do extra
>                  * checks below.
>                  */
> -               bounds_check_type =3D BPF_WRITE;
> -               clobber =3D true;
> +               clobber =3D !meta || meta->raw_mode;
> +               bounds_check_type =3D clobber ? BPF_WRITE : BPF_READ;
>         } else {
>                 bounds_check_type =3D BPF_READ;
>         }
> @@ -7230,8 +7230,7 @@ static int check_stack_range_initialized(
>                 stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZ=
E];
>                 if (*stype =3D=3D STACK_MISC)
>                         goto mark;
> -               if ((*stype =3D=3D STACK_ZERO) ||
> -                   (*stype =3D=3D STACK_INVALID && env->allow_uninit_sta=
ck)) {
> +               if (*stype =3D=3D STACK_ZERO) {
>                         if (clobber) {
>                                 /* helper can write anything into the sta=
ck */
>                                 *stype =3D STACK_MISC;
> @@ -8748,6 +8747,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>                 meta->map_uid =3D reg->map_uid;
>                 break;
>         case ARG_PTR_TO_MAP_KEY:
> +               /* always mark read access */
> +               meta->raw_mode =3D false;

Lots of tests fail due to this restriction:
https://github.com/kernel-patches/bpf/actions/runs/9607559206/job/264991444=
29

In general bpf allows uninitialized stack access with cap_bpf and cap_perfm=
on.
We did a few hacks to shut up KMSAN with the interpreter, but
syzbot reports will keep coming.
We're going to ignore them all.
Sorry, KMSAN provides no value here.
Please focus on fixing real bugs.


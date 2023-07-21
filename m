Return-Path: <bpf+bounces-5593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C475C21E
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225A41C209B1
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE714F84;
	Fri, 21 Jul 2023 08:53:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCA14F66;
	Fri, 21 Jul 2023 08:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E96C433C7;
	Fri, 21 Jul 2023 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689929617;
	bh=WRzmHl06YjeTbeelD+mm6yKK/tRETpCC6HszXiCLP0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oSYzKMMdUmcQWMFCoPcHkiRNu2t2yRu0iQi2juh6gtCmE8cN76NbGgzyMvlOvds4y
	 4j8he4BHfoWnMoWcj7VjtdT5ho4syp+47RMIxJ6D+TXw/pwxwj/LbsAGrwRdx+3T/h
	 iqhdmZidZKFtKj6WevQO1jKZCodyTKOiW8fdxGHO3O7bmSuTUHwLDN7iggHs1EhIFK
	 peIJLzs/HUxGMn3jo+Xr9zBKe1i2QZrNgeKHS8ejS2cRZLHAyExedg9FIfvcm5a9NH
	 rM1TePC6zhFU3yMZ1UmQob+MuTS9CH9YJkdbtosi0MlKjU1YBa67TTYFAj16lI1rnf
	 M8mJT3RIKtWhQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>, Song Shuai
 <suagrfillet@gmail.com>
Subject: Re: [PATCH bpf] riscv, bpf: Adapt bpf trampoline to optimized riscv
 ftrace framework
In-Reply-To: <b5977c5d-c434-7b4c-89f3-d575ee5d04e8@huawei.com>
References: <20230715090137.2141358-1-pulehui@huaweicloud.com>
 <87lefdougi.fsf@all.your.base.are.belong.to.us>
 <63986ef9-10a4-bcef-369d-0bad28b192d1@huawei.com>
 <87o7k8udzj.fsf@all.your.base.are.belong.to.us>
 <b5977c5d-c434-7b4c-89f3-d575ee5d04e8@huawei.com>
Date: Fri, 21 Jul 2023 10:53:34 +0200
Message-ID: <87o7k5fxwx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2023/7/19 23:18, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huawei.com> writes:
>>=20
>>> On 2023/7/19 4:06, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>
>>>>> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
>>>>> half") optimizes the detour code size of kernel functions to half with
>>>>> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
>>>>> is based on this optimization, we need to adapt riscv bpf trampoline
>>>>> based on this. One thing to do is to reduce detour code size of bpf
>>>>> programs, and the second is to deal with the return address after the
>>>>> execution of bpf trampoline. Meanwhile, add more comments and rename
>>>>> some variables to make more sense. The related tests have passed.
>>>>>
>>>>> This adaptation needs to be merged before the upcoming
>>>>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv, otherwise it will crash due
>>>>> to a mismatch in the return address. So we target this modification to
>>>>> bpf tree and add fixes tag for locating.
>>>>
>>>> Thank you for working on this!
>>>>
>>>>> Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to h=
alf")
>>>>
>>>> This is not a fix. Nothing is broken. Only that this patch much come
>>>> before or as part of the ftrace series.
>>>
>>> Yep, it's really not a fix. I have no idea whether this patch target to
>>> bpf-next tree can be ahead of the ftrace series of riscv tree?
>>=20
>> For this patch, I'd say it's easier to take it via the RISC-V tree, IFF
>> the ftrace series is in for-next.
>>=20
>
> alright, so let's make it target to riscv-tree to avoid that cracsh.
>
>> [...]
>>=20
>>>>> +#define DETOUR_NINSNS	2
>>>>
>>>> Better name? Maybe call this patchable function entry something? Also,
>>>
>>> How about RV_FENTRY_NINSNS?
>>=20
>> Sure. And more importantly that it's actually used in the places where
>> nops/skips are done.
>
> the new one is suited up.
>
>>=20
>>>> to catch future breaks like this -- would it make sense to have a
>>>> static_assert() combined with something tied to
>>>> -fpatchable-function-entry=3D from arch/riscv/Makefile?
>>>
>>> It is very necessary, but it doesn't seem to be easy. I try to find GCC
>>> related functions, something like __builtin_xxx, but I can't find it so
>>> far. Also try to make it as a CONFIG_PATCHABLE_FUNCTION_ENTRY=3D4 in
>>> Makefile and then static_assert, but obviously it shouldn't be done.
>>> Maybe we can deal with this later when we have a solution?
>>=20
>> Ok!
>>=20
>> [...]
>>=20
>>>>> @@ -787,20 +762,19 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im,
>>>>>    	int i, ret, offset;
>>>>>    	int *branches_off =3D NULL;
>>>>>    	int stack_size =3D 0, nregs =3D m->nr_args;
>>>>> -	int retaddr_off, fp_off, retval_off, args_off;
>>>>> -	int nregs_off, ip_off, run_ctx_off, sreg_off;
>>>>> +	int fp_off, retval_off, args_off, nregs_off, ip_off, run_ctx_off, s=
reg_off;
>>>>>    	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>>>>>    	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>>>>>    	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
>>>>>    	void *orig_call =3D func_addr;
>>>>> -	bool save_ret;
>>>>> +	bool save_retval, traced_ret;
>>>>>    	u32 insn;
>>>>>=20=20=20=20
>>>>>    	/* Generated trampoline stack layout:
>>>>>    	 *
>>>>>    	 * FP - 8	    [ RA of parent func	] return address of parent
>>>>>    	 *					  function
>>>>> -	 * FP - retaddr_off [ RA of traced func	] return address of traced
>>>>> +	 * FP - 16	    [ RA of traced func	] return address of
>>>>>    	traced
>>>>
>>>> BPF code uses frame pointers. Shouldn't the trampoline frame look like=
 a
>>>> regular frame [1], i.e. start with return address followed by previous
>>>> frame pointer?
>>>>
>>>
>>> oops, will fix it. Also we need to consider two types of trampoline
>>> stack layout, that is:
>>>
>>> * 1. trampoline called from function entry
>>> * --------------------------------------
>>> * FP + 8           [ RA of parent func ] return address of parent
>>> *                                        function
>>> * FP + 0           [ FP                ]
>>> *
>>> * FP - 8           [ RA of traced func ] return address of traced
>>> *                                        function
>>> * FP - 16          [ FP                ]
>>> * --------------------------------------
>>> *
>>> * 2. trampoline called directly
>>> * --------------------------------------
>>> * FP - 8           [ RA of caller func ] return address of caller
>>> *                                        function
>>> * FP - 16          [ FP                ]
>>> * --------------------------------------
>>=20
>> Hmm, could you expand a bit on this? The stack frame top 16B (8+8)
>> should follow what the psabi suggests, regardless of the call site?
>>=20
>
> Maybe I've missed something important! Or maybe I'm misunderstanding=20
> what you mean. But anyway there is something to show. In my perspective,=
=20
> we should construct a complete stack frame, otherwise one layer of stack=
=20
> will be lost in calltrace when enable CONFIG_FRAME_POINTER.
>
> We can verify it by `echo 1 >=20
> /sys/kernel/debug/tracing/options/stacktrace`, and the results as show=20
> below:
>
> 1. complete stack frame
> * --------------------------------------
> * FP + 8           [ RA of parent func ] return address of parent
> *                                        function
> * FP + 0           [ FP                ]
> *
> * FP - 8           [ RA of traced func ] return address of traced
> *                                        function
> * FP - 16          [ FP                ]
> * --------------------------------------
> the stacktrace is:
>
>   =3D> trace_event_raw_event_bpf_trace_printk
>   =3D> bpf_trace_printk
>   =3D> bpf_prog_ad7f62a5e7675635_bpf_prog
>   =3D> bpf_trampoline_6442536643
>   =3D> do_empty
>   =3D> meminfo_proc_show
>   =3D> seq_read_iter
>   =3D> proc_reg_read_iter
>   =3D> copy_splice_read
>   =3D> vfs_splice_read
>   =3D> splice_direct_to_actor
>   =3D> do_splice_direct
>   =3D> do_sendfile
>   =3D> sys_sendfile64
>   =3D> do_trap_ecall_u
>   =3D> ret_from_exception
>
> 2. omit one FP
> * --------------------------------------
> * FP + 0           [ RA of parent func ] return address of parent
> *                                        function
> * FP - 8           [ RA of traced func ] return address of traced
> *                                        function
> * FP - 16          [ FP                ]
> * --------------------------------------
> the stacktrace is:
>
>   =3D> trace_event_raw_event_bpf_trace_printk
>   =3D> bpf_trace_printk
>   =3D> bpf_prog_ad7f62a5e7675635_bpf_prog
>   =3D> bpf_trampoline_6442491529
>   =3D> do_empty
>   =3D> seq_read_iter
>   =3D> proc_reg_read_iter
>   =3D> copy_splice_read
>   =3D> vfs_splice_read
>   =3D> splice_direct_to_actor
>   =3D> do_splice_direct
>   =3D> do_sendfile
>   =3D> sys_sendfile64
>   =3D> do_trap_ecall_u
>   =3D> ret_from_exception
>
> it lost the layer of 'meminfo_proc_show'.

(Lehui was friendly enough to explain the details for me offlist.)

Aha, now I get what you mean! When we're getting into the trampoline
from the fentry-side, an additional stack frame needs to be
created. Otherwise, the unwinding will be incorrect.

So (for the rest of the readers ;-)), the BPF trampoline can be called
from:

A. A tracing point of view; Here, we're calling into the trampoline via
   the fentry/patchable entry. In this scenario, an additional stack
   frame needs to be constructed for proper unwinding.

B. For kfuncs. Here, the call into the trampoline is just a "regular
   call", and no additional stack frame is needed.

@Guo @Song Is the RISC-V ftrace code creating an additional stack frame,
or is the stack unwinding incorrect when the fentry is patched?


Thanks for clearing it up for me, Lehui!


Bj=C3=B6rn


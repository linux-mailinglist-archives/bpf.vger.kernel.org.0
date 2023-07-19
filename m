Return-Path: <bpf+bounces-5327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7566475995B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72701C21047
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14101156FA;
	Wed, 19 Jul 2023 15:18:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AACB156D7;
	Wed, 19 Jul 2023 15:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C11C433C8;
	Wed, 19 Jul 2023 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689779890;
	bh=yRNGM7k1m44UGiSOAxGAbNASoCiFYC+UXo3gbDSSuDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QwLsB+j6V0YIEGRkP2tox2mqqdk3mE2QCURMU/CVETBBJwN3oyIYtmxOUetSAkF40
	 /RS+ApBqn8DYnYau+OosPfhhGaQMbCAqoV5muR0AMrG9m+67v0S5YqjDvIP571n7Is
	 S92IT+ZnwZqdluFH+xPI4Wr2hvcqWHvhKgaiZUKny/P+2/eLfZk1Mzh8CRyxAK7EYT
	 fyLyR+rYYBa/ZAa1yU3cVuD70VfIUN5JeWYJbpaThX0BbafGKTmiTbyEf+MqjwwtiR
	 k0moGCANuw6dLL87/X8pt6mSGmBYUtp11ymCqAwOr2KXeND2V4L25mEuAKblIZUGeY
	 a9IrYQfBI7DsQ==
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
In-Reply-To: <63986ef9-10a4-bcef-369d-0bad28b192d1@huawei.com>
References: <20230715090137.2141358-1-pulehui@huaweicloud.com>
 <87lefdougi.fsf@all.your.base.are.belong.to.us>
 <63986ef9-10a4-bcef-369d-0bad28b192d1@huawei.com>
Date: Wed, 19 Jul 2023 17:18:08 +0200
Message-ID: <87o7k8udzj.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huawei.com> writes:

> On 2023/7/19 4:06, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
>>> half") optimizes the detour code size of kernel functions to half with
>>> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
>>> is based on this optimization, we need to adapt riscv bpf trampoline
>>> based on this. One thing to do is to reduce detour code size of bpf
>>> programs, and the second is to deal with the return address after the
>>> execution of bpf trampoline. Meanwhile, add more comments and rename
>>> some variables to make more sense. The related tests have passed.
>>>
>>> This adaptation needs to be merged before the upcoming
>>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv, otherwise it will crash due
>>> to a mismatch in the return address. So we target this modification to
>>> bpf tree and add fixes tag for locating.
>>=20
>> Thank you for working on this!
>>=20
>>> Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to hal=
f")
>>=20
>> This is not a fix. Nothing is broken. Only that this patch much come
>> before or as part of the ftrace series.
>
> Yep, it's really not a fix. I have no idea whether this patch target to=20
> bpf-next tree can be ahead of the ftrace series of riscv tree?

For this patch, I'd say it's easier to take it via the RISC-V tree, IFF
the ftrace series is in for-next.

[...]

>>> +#define DETOUR_NINSNS	2
>>=20
>> Better name? Maybe call this patchable function entry something? Also,
>
> How about RV_FENTRY_NINSNS?

Sure. And more importantly that it's actually used in the places where
nops/skips are done.

>> to catch future breaks like this -- would it make sense to have a
>> static_assert() combined with something tied to
>> -fpatchable-function-entry=3D from arch/riscv/Makefile?
>
> It is very necessary, but it doesn't seem to be easy. I try to find GCC=20
> related functions, something like __builtin_xxx, but I can't find it so=20
> far. Also try to make it as a CONFIG_PATCHABLE_FUNCTION_ENTRY=3D4 in=20
> Makefile and then static_assert, but obviously it shouldn't be done.=20
> Maybe we can deal with this later when we have a solution?

Ok!

[...]

>>> @@ -787,20 +762,19 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im,
>>>   	int i, ret, offset;
>>>   	int *branches_off =3D NULL;
>>>   	int stack_size =3D 0, nregs =3D m->nr_args;
>>> -	int retaddr_off, fp_off, retval_off, args_off;
>>> -	int nregs_off, ip_off, run_ctx_off, sreg_off;
>>> +	int fp_off, retval_off, args_off, nregs_off, ip_off, run_ctx_off, sre=
g_off;
>>>   	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>>>   	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>>>   	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN=
];
>>>   	void *orig_call =3D func_addr;
>>> -	bool save_ret;
>>> +	bool save_retval, traced_ret;
>>>   	u32 insn;
>>>=20=20=20
>>>   	/* Generated trampoline stack layout:
>>>   	 *
>>>   	 * FP - 8	    [ RA of parent func	] return address of parent
>>>   	 *					  function
>>> -	 * FP - retaddr_off [ RA of traced func	] return address of traced
>>> +	 * FP - 16	    [ RA of traced func	] return address of
>>>   	traced
>>=20
>> BPF code uses frame pointers. Shouldn't the trampoline frame look like a
>> regular frame [1], i.e. start with return address followed by previous
>> frame pointer?
>>=20
>
> oops, will fix it. Also we need to consider two types of trampoline=20
> stack layout, that is:
>
> * 1. trampoline called from function entry
> * --------------------------------------
> * FP + 8           [ RA of parent func ] return address of parent
> *                                        function
> * FP + 0           [ FP                ]
> *
> * FP - 8           [ RA of traced func ] return address of traced
> *                                        function
> * FP - 16          [ FP                ]
> * --------------------------------------
> *
> * 2. trampoline called directly
> * --------------------------------------
> * FP - 8           [ RA of caller func ] return address of caller
> *                                        function
> * FP - 16          [ FP                ]
> * --------------------------------------

Hmm, could you expand a bit on this? The stack frame top 16B (8+8)
should follow what the psabi suggests, regardless of the call site?

Maybe it's me that's not following -- please explain a bit more!


Bj=C3=B6rn


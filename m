Return-Path: <bpf+bounces-33886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E2927470
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C1281F51
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9A1AC224;
	Thu,  4 Jul 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onTzVqDT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFD1AB52B
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090542; cv=none; b=I/bmE5dOWdmUbb29jOc5n12E6QKp5kx4y6UegBPVjX4FRYJWIHrIVBicqIgRl+xccPhkMLEUmSjVRVFXLdCbEdZbJBBv0CiT1FVFIzyCT7qs6pL9fVgCUbYKdefXC3GR4hBhvoHdxCFkUfSuh6hlZaJpmrydwaXRhevjnnvRVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090542; c=relaxed/simple;
	bh=ZzZFpEOTcs6qZ/znLXNLJ/Jdta82EhDzlUh3wadyVkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EjXfihXekWrS9CW2wnpZGZMMO1ZVdAuJEnCh/Y0AhxmUs9quH/Q7rhKX5Ca8sMng00d0uj7koUtv/j340I8AFw+TojDfOr2JiPHysscvmxJcZg/pilKvWn0OBaVmg5ZlbownEA4SZNecieIoOaWRCkAZ1xQEr6w0sFO8h5FlnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onTzVqDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D683C3277B;
	Thu,  4 Jul 2024 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720090541;
	bh=ZzZFpEOTcs6qZ/znLXNLJ/Jdta82EhDzlUh3wadyVkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=onTzVqDTS8oB7MHQXk5QFBXmNXJvLkyk+HDdkaRm1DiEME6WmEdgl3E4Fm4b96FJ5
	 o5pp9mrQNz1neh5qLtM2lb7INZo6qUymJS/2Xke6jOpK0Fx8h1WYtHz/AsbqFJkUz3
	 TnP1FSC+4p60rXEC2c2RC6DD6r2cFjOOoi6jOYWlJSr1iGmhB47HiunyINtWsFBwKy
	 BgooOItTed0hGnrxpW7WhFaemsnlycpf7rBS7yfDNjMTckdmUZ6XgsfLurkuteBt9s
	 /EKHIwCK235XHR16QHOBw3dolr1m2iKbXEvZGfdtFfbmDw41cjC2kQIx+ezpnhatlT
	 bavB4cVvD322A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
In-Reply-To: <b60d6b6a385fc7fa2c323a2122660fdd9fd6f6f0.camel@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
 <20240629094733.3863850-3-eddyz87@gmail.com>
 <mb61pbk3ek7rf.fsf@kernel.org>
 <b60d6b6a385fc7fa2c323a2122660fdd9fd6f6f0.camel@gmail.com>
Date: Thu, 04 Jul 2024 10:55:34 +0000
Message-ID: <mb61pwmm1bf4p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Wed, 2024-07-03 at 11:57 +0000, Puranjay Mohan wrote:
>
> [...]
>
>> > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_ins=
n *insn)
>> > +{
>> > +	const struct bpf_func_proto *fn;
>> > +
>> > +	if (bpf_helper_call(insn) &&
>> > +	    verifier_inlines_helper_call(env, insn->imm) &&
>>=20
>> This should also check bpf_jit_inlines_helper_call(insn->imm) as the JIT
>> can also inline helper calls separately from the verifier.
>>=20
>>     if (bpf_helper_call(insn) &&
>>         (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines=
_helper_call(insn->imm)) &&
>>=20
>> This is currently being done by the arm64 and risc-v JITs and they don't
>> scratch any register except R0 (The helpers inlined by these JITs are
>> non-void).
>
> Hello Puranjay, thank you for commenting.
> In a sibling email Andrii suggested to also add a function like below:
>
>     __weak bool bpf_jit_supports_helper_nocsr(s32)
>
> At the moment I see the following helpers inlined by jits:
> - arm64:
>   - BPF_FUNC_get_smp_processor_id
>   - BPF_FUNC_get_current_task
>   - BPF_FUNC_get_current_task_btf
> - riscv:
>   - BPF_FUNC_get_smp_processor_id

Yes, all of the above conform to nocsr.

> I suspect (but need to double check) that all of these patches conform
> to nocsr. If so, what are you thoughts regarding bpf_jit_supports_helper_=
nocsr():
> do we need it, or should inlining imply nocsr?

I don't think we need bpf_jit_supports_helper_nocsr() because JITs will
be only inlining very simple helpers and will not clobber caller saved
registers. JITs anyway use temperory registers for intermediate steps if
required.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZoZ/pxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nbqGAP4pgnLfRcM+5LO2mzFerjnM1p9G7RAc
rsFtH+a//OXVjQEArxiKYPDt4R7aKf26kySruv169SsFZiWikZFA+hJLww0=
=Yf34
-----END PGP SIGNATURE-----
--=-=-=--


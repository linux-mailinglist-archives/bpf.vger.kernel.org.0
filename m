Return-Path: <bpf+bounces-73057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88255C217FB
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC6B3A3856
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFAA368F33;
	Thu, 30 Oct 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5aedShf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074B3683A7
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845205; cv=none; b=ROx2LpaHGqnByolFKHwz1FPshs04N+qqXU7W44JOKXZZH6Qj8lsdqKLTi+7+1Wh6BOKFBVNCasVGj6VeJWc2ji/aWZkz/9FIO/a+9z49HTwTdoXUIwKsaUkqQgX4SelcAXieMTmFp8wBREytER5FVCtHLz8BY/ZcbFvf6AwXY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845205; c=relaxed/simple;
	bh=R66pJ2aeC9T8mvq2SNWf8g2+t/j2D+rZ3f/RxsZQgbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwekhlPS4pahQG6SCHa9Q1XCnqEeg72EmtCz3Ri3gCoIt3mhPcVb0yMW4TWbhlWOodg9v0hVgeddiU07PlhadM8gW/poSj34bhBzNoKtuLIM2OPV2yTpSqfzVRvwaxPfbinLkPwbV4Fv/bmly7vt3LHtzrS7AMYMr50ZGDiD5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5aedShf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso1589176a91.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761845203; x=1762450003; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VBUZoX5dT2XZvzWD1hhhjp5IwzQTAkja0LZXBOQj9Aw=;
        b=C5aedShfUdlRcp2X2X5npNdaQv5tPy22EKYt1MttovPaP/6Z5fTtgrtjF016IT5AT5
         eK4E1vK4xcHuczp3i3uunwrnW5li+mkZDLCuiqzlD2smlr/BkdUP48LtxH6hKzrFLn1E
         et6pyeUNNy2gh7DMdw46eec+Wq16QJiRINjUlGrlhG3db2MdMSnNMfcaLZKaYW0ab7R5
         BMxS6CfY/b16sn346rcuAm8y6mwd3MmRVnLz7HbnYmCTHjzMUl3lP+TPxOe6/d5nGkar
         8wj49cuJ0CpiGLv5Hq6T2ahG/mYuH8XP058xJAUDIBQ521GuSpWPEYU5zD6keX3jVleM
         vqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761845203; x=1762450003;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBUZoX5dT2XZvzWD1hhhjp5IwzQTAkja0LZXBOQj9Aw=;
        b=ol/8yP2JbHdl/bsaR79AYP4ehThYfChhve6ERqWuziOZyNmlOk0v9S7ZZtLYqkiclu
         dTzc9/HHlkMlzXRWkyJJSQh5DSF3+AswMkgz/ff1Et+7aUtjIyegHbbTRVeq8ntc6deF
         DgfihF3B+BHWCcmIFYkVOjl5mb2Zdj6zQl3+GR2B14/OZmqEH35NdON/iLmlq0oIJbD8
         cQIpNOwZq95pijC0u/Txm904O6CxolrVtxm6LDvTFqPE3W/C2TDh637gu5wrgBYiL1ti
         l/z3hiNCsdIzgqlZwBcg3ACTslBSSQe0AnK+pi4SumR/fuMQc9+OEaKY4Y0VeOoEhpxZ
         knEw==
X-Forwarded-Encrypted: i=1; AJvYcCW67n8e2J2twcAXPkqaORcLJ7ZDx2OsxZ4Gro+v78AVI5BVqBn5agqjui3+VDnwcfNiuuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUhzZQtJDL4y7TLS6ZZtgB1nd/zEj53hspNFg+b2tX3mFqHa+d
	uYFAN5FtRxbZP2y5rwZrGQknQLufvRmU42PayMOHFieAG4n4RdVPXVON
X-Gm-Gg: ASbGnctn8VN3GLa1f9gH22fGzoyUBx1rCh16IQ1aM0lnLDhaEKeoZfgxAMQAspVcKNa
	evIMnEceTqLXd2N8UNm4odZCENWF2Ijfs0GAzE386vKmzcley/FNHK/6GgxBcH2xqppgLyJPLaQ
	u/6aTLXHG+zu71WX+wn1/TIwqQ94XKYVGgCU7yagvGifY46YTeUzOs8nuWJDgxETRW4oIKu8RG5
	6hjO33iwl2xZjMMuYzQkxvKXHtDM50IBGWCuKCY6d5BcEF6yyodjDa0Zd5XC9IPymxT/asN20Ri
	33LiXGCssn+9z4/MKes3p5/gANbkKisEQ7Q0IkkHcDunyhibcxtyjM1ArH38oUevazdFSBSPotZ
	QsiknW0+G0D72Ng8bWpgmDcZ6Eg5rqxMcUL5RHnEfeZ6FYUcWfd+QJ2JoXoGVOxxl9mlvwXhlFd
	2ex7ZgbdpT
X-Google-Smtp-Source: AGHT+IF8A1a0P+znyR1j5oHtd7dlJzE05Rb6IK1i4Mns4f+5/RJqwEfxxr/XTUHh1gih4O1KdJJb3w==
X-Received: by 2002:a17:90b:3947:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-34083074e0emr636625a91.20.1761845202733;
        Thu, 30 Oct 2025 10:26:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050972842sm3298836a91.2.2025.10.30.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:26:42 -0700 (PDT)
Message-ID: <aea5cd2ca9523a61d0193308a1b5f938a8d5b073.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Thu, 30 Oct 2025 10:26:39 -0700
In-Reply-To: <da20bc30-85be-44ab-b837-19aa97ebc431@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <20251029190113.3323406-4-ihor.solodrai@linux.dev>
	 <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
	 <da20bc30-85be-44ab-b837-19aa97ebc431@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 09:31 -0700, Ihor Solodrai wrote:
> Hi Eduard, thank you for a quick review.
>=20
> On 10/29/25 4:54 PM, Eduard Zingerman wrote:
> > On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> > > A kernel function bpf_foo with KF_MAGIC_ARGS flag is expected to have
> >                                  ^^^^^^^^^^^^^
> > 		I don't like this name very much.
> > 		It bears very little context.
> > 		Imo, KF_IMPLICIT_ARGS fits the use case much better.
>=20
> I know, naming is hard...
>=20
> The issue is that it's not only the flag, across the code we need
> descriptive names for every "magic" thing:
>   * a flagged function
>     * how do we call it? kfunc_with_impl_args?
>   * a function that exists only in BTF (_impl)
>     * it's not an "implicit" function
>     * it's not exactly an "implementation" function
>     * "fake" is even worse than "magic" IMO, because it's not fake,
>       but you could argue it's magical :D
>     * btf_only_kfunc?
>   * describing arguments is simpler: "implicit" seems ok, although as
>     Alexei pointed out in previous iteration they are very much
>     explicit in the kernel [1]
>=20
> For me, "(BPF) interface" and "(kernel) implementation" pair of terms
> makes sense, but then I think it would be logical to have both
> declarations in the kernel.
>=20
> The advantage of "magic" in this context is that it doesn't have
> loaded meaning. But I agree this is a stretch, so can't insist.
>=20
> [1] https://lore.kernel.org/bpf/CAADnVQLvuubey0A0Fk=3DbzN-=3DJG2UUQHRqBij=
ZpuvqMQ+xy4W4g@mail.gmail.com/

- KF_IMPLICIT_ARGS
- explicit_args_id -- for prototype with full set of args
- implicit_args_id -- for prototype with missing args

[...]

> > > @@ -3349,8 +3400,37 @@ static int add_kfunc_call(struct bpf_verifier_=
env *env, u32 func_id, s16 offset)
> > >  		return -EINVAL;
> > >  	}
> > > =20
> > > +	kfunc_flags =3D btf_kfunc_flags(desc_btf, func_id, env->prog);
> > >  	func_name =3D btf_name_by_offset(desc_btf, func->name_off);
> > >  	addr =3D kallsyms_lookup_name(func_name);
> > > +
> > > +	/* This may be an _impl kfunc with KF_MAGIC_ARGS counterpart */
> > > +	if (unlikely(!addr && !kfunc_flags)) {
> > > +		tmp_func_id =3D magic_kfunc_by_impl(func_id);
> >=20
> > I think there is no need to hide magic_kfunc_by_impl() call behind the
> > above condition. It can be moved before kfunc_flags assignment.
> > Then it wont be necessary to textually repeat btf_name_by_offset() and
> > kallsyms_lookup_name() calls.
>=20
> Not sure I follow...
>=20
> Yes, !addr is enough to detect potential _impl function, but there is
> no way around name lookup in BTF and then another address lookup.
>=20
> The _impl function doesn't have an address, so after failed
>   kallsyms_lookup_name("kfunc_impl");
> we must do
>   kallsyms_lookup_name("kfunc");
> to find the correct address.
>=20
> Or do you suggest doing something like:
>=20
>   tmp_func_id =3D magic_kfunc_by_impl(func_id);
>   if (tmp_func_id > 0)
>       func_id =3D tmp_func_id;
>=20
> at the beginning of add_kfunc_call()?

This, just check for magic_kfunc_by_impl() and replace func_id.

[...]

> > > @@ -13632,10 +13718,28 @@ static int fetch_kfunc_meta(struct bpf_veri=
fier_env *env,
> > >  	func_proto =3D btf_type_by_id(desc_btf, func->type);
> > > =20
> > >  	kfunc_flags =3D btf_kfunc_flags_if_allowed(desc_btf, func_id, env->=
prog);
> > > -	if (!kfunc_flags) {
> > > -		return -EACCES;
> > > +	if (unlikely(!kfunc_flags)) {
> >=20
> > What if we patch insn->imm to use the "fake" function id in add_kfunc_c=
all()?
> > Then modifications to fetch_kfunc_meta() wont be necessary.
>=20
>=20
> I considered this. I wasn't sure it's safe to patch insn->imm at this
> stage of verification. Also I thought it may be harder to debug the
> verifier if we do btf id replacement in the calls pre-verification
> (because we lose the original btf id).

See no issues with that.

> Maybe I was too causious.
>=20
> Alexei, Andrii, what do you think?

[...]


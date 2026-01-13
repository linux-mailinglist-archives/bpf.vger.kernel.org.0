Return-Path: <bpf+bounces-78754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E9D1B433
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13DF302D901
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6243101BC;
	Tue, 13 Jan 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuiKHgIr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7E2BCF6C
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336780; cv=none; b=a06Y1SpeAJfkLN2AhL1bFBAx75/mWoLSS+Xcsl/IWq/8e3BY676r+gEPfROXfGwPM1BAIqZWPOswFQMt1eLoHVgOyBYbVP7zPHOScFRd+ffksqg/B+na0MyxsVp9iTO3zSp11cIfY0bk6at9bmnlZiqbqUyIvhcJMNzXbG//WQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336780; c=relaxed/simple;
	bh=5G/+O4AfoFl7Mun62PXu7YMTfSDOOK90wf7hCG0XoWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Na9ekpbLFK1TY5wMjOQJv1qQGeJq1XUCVN4ofLmTnFE0uB4azgibkegPMA5MN+gkbyO2aVUPHJJ3YLy8NsOftLJ/335AQ95Vfni7KOBQAGSfPpSJ1T6F9vNXBBThmBCxIRgXjOz6oIerPPnV3AvMhtxDVZ8UfcNETjNPErmN3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuiKHgIr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d6f647e2so79488895ad.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768336779; x=1768941579; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vuKJVwdXdLFoBFmdbdguCpeTwBYgUktjFchgdX5Irfo=;
        b=VuiKHgIrGqdniq6cfe8yQe1Ae2YdksGWyylrbInAtjq3QwVSaARsjPohyPcG97stx9
         iSEZY3mG3EYygxV7m9g3+Bnse0KOW8UeBiJApkXXPuEqe8HkOuyzvJ+qOQ6M/C+cJtcR
         kwfAQsKSEUX5N8rNvHNNslbDBgs3X8V9lNFKMiYIe/yiJL75eOH+M6kwe0WimgSjVRNY
         IZ5DLoEi8E+/efVAeJ/KRQEX9USeRQJ7hNW6rlLsHlPR8xFx6BqA2v+9rTnuzgEeNcTx
         pNnX5kO5VUMNWPh+dWFWsOX30cTbX6GVKs1AD/zf/Ooa93CH2WFIk91PHxQoB0jtIsaR
         6djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768336779; x=1768941579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuKJVwdXdLFoBFmdbdguCpeTwBYgUktjFchgdX5Irfo=;
        b=H4xpfEYhQu+Noibv4HjO8Y13O4SxHklj1WPpP7czjs1Y2D4qqWJRoCKsJ/g4WqiGfT
         1QbcXELorDvX/hHxRHLXJaxZOzeO8/9HIhI4c2uyz9g/L/Vntl0o2OQk0A4oMDDKuiTk
         tqtqFmOLMNhuw0zZPp3mLFTCc0aW0d7XVqDvkW/EzmwL920F02YCxMxzzw03WTYKz1jo
         D8GcZYgl0o6ydOPKxvXNHurj+LuRIFdVoABiP1DSrQexRbyaYH2GCe3SYfKauJ1d4Gnj
         nOGtx7VXZrYk+Op8xat8xIpE5/fwL3tiY/ePW6/NQ93mp3u2jo7f1+rLpDWoeJHCJcS+
         LNpg==
X-Forwarded-Encrypted: i=1; AJvYcCVC/a9YJFghn4W0HDs8jbegL/0MpnZlVUMpgM2mlqD4iMwN0ZraOancbH/NabEIpYDxAq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOcDk2VHbQJDjqLkLhs1dudW5JAq/4baW83XEcQQnqqjIeAyB
	vaDQrtOz+AurQwrIU1ng6RR6orCsiRA7dM12cnUvYojxk2El/TqEZPHj
X-Gm-Gg: AY/fxX7dbSYMKGsMrZvYEeJpdm9qsJ7a5vqZyEWHxwol+3UlA+qZOqmyjfuN8JPvFLu
	87Z2FuBOHhKNZGEbxcCJplc7Jbx+gJRgUpqQ8J6pWPE1flYvMgsJ8rHFW1e68DklVZFzXWbraV4
	ScRRrbQOFqMf59pZyxI1ASgXOoI66K5c/OVFEpIkJR5WmlkBIMBbeHclDcOF6A+h7LTRyfp4l+w
	ufh/D1Iiv70sG0WCmoR0t8BukxmENC1dNbhbk17t7F6FHIIrPC3f5ng43WalZcPo2X0CHxzi8bM
	lf6SSQr478fy+x+xIafTNtg1djGJSWUltHGhkvGS5AQg7Qg3AsfG2szsm/R7Jl4JxteOKITlLEc
	DD3+dhZgzQ4mWhepi2uNsJsw4pACf24DZSdYiPZbr3X8hhio+tkDazTxSCWywONb148Cx9vFB6D
	V7AHcbNRGkEkmoK6ON36E+1oQXFrPWHwgurkJcKAzk
X-Received: by 2002:a17:902:f651:b0:2a3:bf5f:926c with SMTP id d9443c01a7336-2a599e3434fmr3125395ad.39.1768336778822;
        Tue, 13 Jan 2026 12:39:38 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f6cdsm20541766a12.6.2026.01.13.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:39:38 -0800 (PST)
Message-ID: <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 12:39:35 -0800
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> A kernel function bpf_foo marked with KF_IMPLICIT_ARGS flag is
> expected to have two associated types in BTF:
>   * `bpf_foo` with a function prototype that omits implicit arguments
>   * `bpf_foo_impl` with a function prototype that matches the kernel
>      declaration of `bpf_foo`, but doesn't have a ksym associated with
>      its name
>=20
> In order to support kfuncs with implicit arguments, the verifier has
> to know how to resolve a call of `bpf_foo` to the correct BTF function
> prototype and address.
>=20
> To implement this, in add_kfunc_call() kfunc flags are checked for
> KF_IMPLICIT_ARGS. For such kfuncs a BTF func prototype is adjusted to
> the one found for `bpf_foo_impl` (func_name + "_impl" suffix, by
> convention) function in BTF.
>=20
> This effectively changes the signature of the `bpf_foo` kfunc in the
> context of verification: from one without implicit args to the one
> with full argument list.
>=20
> Whether a kfunc argument is implicit or not is determined by
> is_kfunc_arg_implicit(). The values of implicit arguments by design
> are provided by the verifier, and so they can only be of particular
> types. In this patch the only allowed implicit arg type is a pointer
> to struct bpf_prog_aux. The __prog args (usually void *) are also
> considered implicit for backwards compatibility.
>=20
> In order to enable the verifier to correctly set an implicit
> bpf_prog_aux arg value at runtime, is_kfunc_arg_prog() is extended to
> check for the arg type. At a point when prog arg is determined in
> check_kfunc_args() the kfunc with implicit args already has a
> prototype with full argument list, so the existing value patch
> mechanism just works.
>=20
> If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
> that uses a __prog argument (a legacy case), the prototype
> substitution works in exactly the same way, assuming the kfunc follows
> the _impl naming convention. The difference is only in how _impl
> prototype is added to the BTF, which is not the verifier's
> concern. See a subsequent resolve_btfids patch for details.
>=20
> In check_kfunc_call() reset the subreg_def of registers holding
> implicit arguments to correctly track zero extensions.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Overall lgtm.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[...]

> @@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	for (i =3D 0; i < nargs; i++) {
>  		u32 regno =3D i + 1;
> =20
> +		/*
> +		 * Implicit kfunc arguments are set after main verification pass.
> +		 * For correct tracking of zero-extensions we have to reset subreg_def=
 for such
> +		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_=
def of regs
> +		 * from an earlier (irrelevant) point in the program, which may lead t=
o an error
> +		 * in opt_subreg_zext_lo32_rnd_hi32().
> +		 */
> +		if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
> +				&& is_kfunc_arg_implicit(desc_btf, &args[i])))
> +			regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +

Did you try doing this in `mark_reg_not_init()`?
This function is called for R1-R5 some time prior this hunk.
What I don't like from structural point of view is:
- `is_kfunc_arg_implicit()` depends on KF_IMPLICIT_ARGS, but that
  check is done externally. Hence, the naming is misleading or 'meta'
  should be passed to `is_kfunc_arg_implicit()`.
- doing DEF_NOT_SUBREG logically has not much to do with implicit args,
  so it is a bit confusing that is pre-conditioned like that.

>  		t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
>  		if (btf_type_is_ptr(t))
>  			mark_btf_func_reg_size(env, regno, sizeof(void *));


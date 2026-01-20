Return-Path: <bpf+bounces-79537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C66D3BD57
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A0F30262A1
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853C325C80D;
	Tue, 20 Jan 2026 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5AX7YLi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61CF23EA8E
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874239; cv=none; b=jyeA9INuC8IgfsRTyv/dbj6K9a4923R9bMqxz/sK87QgE/rhoc+iCnJMg3TKXueAPijFGZcOBFHwukkQMXVIBcWrMFhrc5tkmK/W0YqZThF9zqm5Af6r2AWhckWFv8D6sRADGM43FbX+B2F/35Yfy7ACvKvbc6Pt0XMB5wHOoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874239; c=relaxed/simple;
	bh=DFMDqIBxWMeUoPAyaqN8hr45MYvMg+GV75NoJCt74uw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUgFdGoHefQ3FYUAwIkBFPHjcfBfAWlgBg0voMKdlY8PcZjEXUCPwaLX2MiLOQQC+/7aBGGciitxdkfq8VShV8gdbs22z0hEdbQG0uIHF4XFqLA1Yqe4HB/EFmsUD+iLeKlnoAI9Sc5y6h3r9f//TG/ADJlTroWA4KnZaXA3O/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5AX7YLi; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12331482b8fso8481318c88.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874237; x=1769479037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bs/xgeR13/qdRJT1LBeIlLMVbrV4KZcmi7z58cgPbxU=;
        b=e5AX7YLilMmc9Zmad8607DPpxKLuDKoY/0IJm0cqAQjYRowPpazAIQEgKP+vAUEYNU
         gp5mDrhGBQAdG7qgm1ti+aal4rWxlttc8MzxtpFogVcZXNQWPvoAAmkpXbL9cDiUT361
         MN9mvYtJhNuXcbED4LBXC+J7EZslh4oCFWcW8UiHiFb98MADyWrU+h9vHyzOAnLo2oHH
         mP3Dv8nXWBNwqYf2ICev5DyKjqhDZfc7P/1Gtl8L1+XPVHHqxtrdmxKcK4FrS7BzEw0N
         ZFEovZY4zt7mtCcmAWmnsgbjQNiGt8f0EBBlN+Ueo/7kPNd6h9EEWDDILhsoTWQlaKgW
         wNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874237; x=1769479037;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs/xgeR13/qdRJT1LBeIlLMVbrV4KZcmi7z58cgPbxU=;
        b=G1uUw7rEtEM/Bl4qH1lxEfQZ9dfy/YIx8mP0/qJ3z1IIM7e9+0aY+WNimRjfNxiiOu
         FzO3SuUux9yScFkNvOyGCh1hAqUvFqGLeeYGk7mSzmWRL6nCYtuVBdZfyW/Yd8XByvOj
         +P5SZBHQwIN6kxJvYdjCX0KKmJ+RtNmq+FgEb1IF24sL1QXNvUsMsCzIqILoCO6tfgt2
         S88l6+K5iRzcoZAEOW0M9hEF7cl3WqF/SFxcd8xHDboHUXbStnzHiISySz+ZtoQDLQx3
         gyxsvPdmpsPuQ06cKUA8+LUGp+kOBq9qK4FFP4j8+7LKvTHMeRu9q6q9O6LW0TsTlSJl
         uHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzV1ABW/SFIUUAPNuEUcEGtvKgM/P6FEP4IppdchxtZ7rMpz322xlRIFigkgDnZi/8Z/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YKZL6KKE974LItoo0UpU4GkGPonEvOyffOzua8erKEkcHXCm
	PxkwMjcfhsy2WEmA6EBTKAH4uS4OFqhtoGAnqVYGmJDOQQRA7gqG6/xz
X-Gm-Gg: AY/fxX45iy4Mvkmy9Dbuy0gqXx63qyZ9TU+A38lOO4HC8E8sbTY1QFJ3CjugF8JAOpa
	qPAbDsbibuHEpuJ+lDK3LNuH+VnPXo5ygiqEoLT3HrSH/YKUpdhCAh9yavhXvdTiSQ+fhz3/Bl0
	pC8cljgnN3wFVthOIyfUEUTCC3zeZ2vsuUxEPTKMWIFMJl956+dy3dA7AyneHhNISTAMmNwUb/j
	ot+HsOMw5SGm2Ng27irsBdeEcutQS/W6R6m+tsftvSGi18fsHixQLRZliUtzdLtVLKS7rk0u5u2
	knYn8el9LAE+D/wKxX/g0yA42dNYGQI9IB1cu3Z7Rf3XHsULlLotmiEy9t6ezY5MXq/x7cDawvW
	qxFsJ9ey3qMC9aqvXpTK4qLlWlCCU0W7fpXFvrPyRAQGizDT6VxYYDRd9M81wtKsOl4Ei8zpwh+
	Ah+N1PWphQ+rlwxqHH/lHud+fBnnEqZU5XZGP7ECUtimdKOLCVci81xV8FcLF7nSRLPg==
X-Received: by 2002:a05:7300:dc85:b0:2ac:2480:f0ac with SMTP id 5a478bee46e88-2b6b40d991cmr8107963eec.23.1768867408672;
        Mon, 19 Jan 2026 16:03:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3679980sm15230498eec.31.2026.01.19.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:03:28 -0800 (PST)
Message-ID: <e2d174e79c4550fb7251f29351f1fe5afb812328.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:03:25 -0800
In-Reply-To: <20260116201700.864797-4-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
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
> The values of implicit arguments by design are provided by the
> verifier, and so they can only be of particular types. In this patch
> the only allowed implicit arg type is a pointer to struct
> bpf_prog_aux.
>=20
> In order for the verifier to correctly set an implicit bpf_prog_aux
> arg value at runtime, is_kfunc_arg_prog() is extended to check for the
> arg type. At a point when prog arg is determined in check_kfunc_args()
> the kfunc with implicit args already has a prototype with full
> argument list, so the existing value patch mechanism just works.
>=20
> If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
> that uses a __prog argument (a legacy case), the prototype
> substitution works in exactly the same way, assuming the kfunc follows
> the _impl naming convention. The difference is only in how _impl
> prototype is added to the BTF, which is not the verifier's
> concern. See a subsequent resolve_btfids patch for details.
>=20
> __prog suffix is still supported at this point, but will be removed in
> a subsequent patch, after current users are moved to KF_IMPLICIT_ARGS.
>=20
> Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
> tracking, because an explicit rX =3D 0 in place of the verifier-supplied
> argument is now absent if the arg is implicit (the BPF prog doesn't
> pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
> all caller saved registers in check_kfunc_call() [1].
>=20
> [1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.=
camel@gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -14177,8 +14223,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		}
>  	}
> =20
> -	for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -		mark_reg_not_init(env, regs, caller_saved[i]);
> +	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +		u32 regno =3D caller_saved[i];
> +
> +		mark_reg_not_init(env, regs, regno);
> +		regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +	}

But we still need to understand why .subreg_def assignment can't be
moved inside mark_reg_not_init().

[...]


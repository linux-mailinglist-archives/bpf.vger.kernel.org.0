Return-Path: <bpf+bounces-60409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723DAD6258
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A503A8416
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBBA24A049;
	Wed, 11 Jun 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn7rmUA/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823F185B61;
	Wed, 11 Jun 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680592; cv=none; b=fxhYufuIyQzAJASS1JhwQvS3ANEXt2BjrvsipxjxQFJou9jIdkl9BQLxQypMAowvuCm4a24PzBi4awYLiruTN64sEI3JDcn0YIJew1YriAZhuukOF8QPUHrzIXJuSw+yZ9cd8Rpyc/DNjefn07i4P4SiZjh65NMzY7hSDJX9Boo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680592; c=relaxed/simple;
	bh=qQpv1pCUz1GO0RCKVrv+eVIX66xPkLSWnaiCqdqyVpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCQ5yh4PeSotKi8pdPAuiMNuoP8t4uKMwN/NTnga/csANew0+E6qOuFwSKjEObQhyu3sZS7FGacr4xpt4V/kcmxEq70jNwvNmUK2LlZ2RONm/CQpfDJy3vkVLS3dgbrHnKn4op6flOr/hcCW3zZpVL6qkZJnOG6CKUprH+S9OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn7rmUA/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b440afa7so3368105ad.0;
        Wed, 11 Jun 2025 15:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749680589; x=1750285389; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hH7V1Cwx9ulTLJQwiy8rhYwEEe+FtFXFruDqwN1k0zs=;
        b=Rn7rmUA/tmoN5ejQ4rDGhzru8J/VeMmG7wUCVwQTRNqU3vofNNzsQWPGoIaqHkMohf
         RqXQhBycleQgYo/QNMGOQAK3AfbH/6TXtPGTAB9AMcxmltWWJMVFDdLTcqiMdl1l0v0z
         AgudbKFmV6EwLWy+cSpyMEVgfaArmG7e6GH5hIc6FmdBLIGC7QhYVFSDzP6/8/atqqse
         JoRLVRTlFfVOIWst7RGq61Nuup/UB2cT6ofl3JL8OEyyYqzyG5fR5nnK/jFw5E1bvGuY
         Xx5fBOKU37B60Yhu3Ef5kxQgmZ98sHJVslWjY1UWzaMERiTaSSebc4LPmif27bn7dCwU
         xGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749680589; x=1750285389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hH7V1Cwx9ulTLJQwiy8rhYwEEe+FtFXFruDqwN1k0zs=;
        b=NOnuMGgfmQmMfRdTODQtJPygdA5eDV3e4DCuL/wrK1kHcJsEnPzB3R989s2cqtSlUh
         w8KCyOE+2vQ9r3AHJaUOekzHKPSor7fAQcYXmCylOwXZJvxrHmJhZgKMCVmY4+UGH2qq
         oMvTdK56IzYaPk2jVep7R4B3IDD6G0zAPrhIjA0AyqyPY4tzPycy3IS9E5Dg8a3x8Y8p
         agq/L0LdTKCUljsHg3K7BWSW5H1lnwLNgGbECx3Iqp3d3zT58TqIcr3OJwd2nowO0IIz
         9GDCSLz+BS6oHHnV8a9LDSXP9r1vx3Aac75b9mUonxGxw/eXoYpqkdIxiSw+L/mmi0aj
         ZJqw==
X-Forwarded-Encrypted: i=1; AJvYcCWucBVOGM05UnKpjcj9h3iX3cPTF1qpGXaYufvlox/92ZIY66/wYGxxtG9t1W2kjBpwgEYbMmt6rzZGAH9+@vger.kernel.org, AJvYcCX6SwQ4eR3uYxyFYKeovm0nd7Gz+0NHEkka0pJBPC57IPN6VefDdsNlt38FacDMn1CZTFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxBnZ3Y6o3fP8eLWAwHzwp4uLg60KyPW8iF9uFsKzOEVYYEgn
	R95l1rvR2wdH/ymggN/an+u99SRO+thsYx2mdO9RCtPKfx2a3GIkpo8ZTgOorn2LViTfRw==
X-Gm-Gg: ASbGncv0G+EFsatHQrJEmTcxK/Gtzb4Lo+ML4797a7ZPKtsIVRKW0lrEpczGeQRwinO
	+08XPCP1yQF9uyadHZGnx7Dl7JInd5HNZ4l+po6v0N91YHCFgXXZLc7us0GvIxChSMDx5u1474y
	RvfFvHHW7YE47LoHB8ajzr5bThKGA7HOIIBNM0QTKkBJcHeLQWnn+AIBgPqciAWRWOpP84zrKd+
	QZxjVllMaX841+boaSxDmEccnqPSLJfczbH0kgBV0G5qnUMYWil+D3VMoCuyVqgeziV1HjVgVZ7
	r2nlpneVQzAGxJoOvLtA8cQ6UUQXSl/CWg7CmrTgwzxhd1OBEB7c5J0K7QvlVQQEFuSYNYtfyvT
	FSj730bXWVg==
X-Google-Smtp-Source: AGHT+IGCkvbEgrLZPkxE+t4S+oALPtAEE4uihKyURBYGx17yST1MMjsmq44jSnAQrY7SINQCz9l2fQ==
X-Received: by 2002:a17:903:41cb:b0:231:c792:205 with SMTP id d9443c01a7336-23641aa234dmr73085205ad.4.1749680589533;
        Wed, 11 Jun 2025 15:23:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b1d2:545:de25:d977? ([2620:10d:c090:500::7:d234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6fa254sm701525ad.168.2025.06.11.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:23:09 -0700 (PDT)
Message-ID: <01c816691c132dd6c8c2588f396b240f033ce201.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix state use-after-free on push_stack()
 err
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Henriette
 Herzog <henriette.herzog@rub.de>, 	bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzbot+b5eb72a560b8149a1885@syzkaller.appspotmail.com
Date: Wed, 11 Jun 2025 15:23:06 -0700
In-Reply-To: <20250611210728.266563-1-luis.gerhorst@fau.de>
References: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
	 <20250611210728.266563-1-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 23:07 +0200, Luis Gerhorst wrote:

[...]

> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>

I reproduced the error locally and this patch fixes it.
Also double-checked places where free_verifier_state is called
and error codes used in error_recoverable_with_nospec() are used.
Looks like env->cur_state should be always ok if
error_recoverable_with_nospec() recovers, env internal structures
in healthy state.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b1f797616f20..d3bff0385a55 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14229,7 +14229,7 @@ static int sanitize_err(struct bpf_verifier_env *=
env,
>  	case REASON_STACK:
>  		verbose(env, "R%d could not be pushed for speculative verification, %s=
\n",
>  			dst, err);
> -		break;
> +		return -ENOMEM;

Good catch, I would have probably missed it.

>  	default:
>  		verbose(env, "verifier internal error: unknown reason (%d)\n",
>  			reason);
> @@ -19753,7 +19753,7 @@ static int do_check(struct bpf_verifier_env *env)
>  			goto process_bpf_exit;
> =20
>  		err =3D do_check_insn(env, &do_print_state);
> -		if (state->speculative && error_recoverable_with_nospec(err)) {
> +		if (error_recoverable_with_nospec(err) && state->speculative) {
>  			/* Prevent this speculative path from ever reaching the
>  			 * insn that would have been unsafe to execute.
>  			 */
>=20
> base-commit: 2d72dd14d77f31a7caa619fe0b889304844e612e


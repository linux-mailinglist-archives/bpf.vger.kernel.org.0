Return-Path: <bpf+bounces-22111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DE857063
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB051F2933B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C654145320;
	Thu, 15 Feb 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBDXjNQz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9413DB92
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035128; cv=none; b=WhWGRbz4XnZZzteBiIaS2sK5HAkSlHcRb7XU2zbPzab+x2Tj7ePTv8rFNK6LPaUeVmWetrKhmI0glT5WBugmf1c8Dbk3bPhFVQTm+2kJ2RQJsuCavOa4JsIA2ECaF4vUVlGdBl9OqDyq9dz+3LAUueECFEoZ6RDs/w7w3nH6EGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035128; c=relaxed/simple;
	bh=zeiqnMl7VHj4gXgru1J6NEicUe/RYx93puLtvI0c8HI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZInKWOrEOBWKpo/mw89YRJFxdPYmwdHea4Qy2IhqDvhOkZ2GAmLGPcgGWGvd16gF+j5OsZMSjRRbxLvVtUIzxB/JAkftFjzhUllhUTbgkYppEQ8EaeEUDuZEOZNVZ6N5IdHbSDWA1z6oFl4Vf84kvVh/M3a+vuAtFej1iY/4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBDXjNQz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563a6656c46so2100503a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708035124; x=1708639924; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnWphXx8jwKy46A8kTwbEX5Dg6YiFlqAJk7iw1skCwE=;
        b=FBDXjNQzPlOy6PZ4QBzmNghY0dBE227dsaarZzctx4IhZyASWesL7Ra1GogmpX7U8J
         KDl4pfC8jK5+S8sElHk0Z3q6HAByzDbMgZJkEb5QZOwMZpj7i4s68hh+iMVajl7s3//X
         O54NBKniB2TPUb40wWiO1lhPzQ1H1Py3cKLGow5lqbMrIyF/9s4qGm77n9vdKQS0LsRt
         eY6XAxBEMMggA2sezGPv5tYPXpH6C1ftP4Kudl8YEc7Y0rO3AzF/zHqf3pP9NgeC7W4a
         okGD1BTE+5ZMBxyLKMa4CjxHCFTGbeUG/8bSRfZW0MO1Ybwm54FWuiGWfJwpWZKoxBPS
         dgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035124; x=1708639924;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnWphXx8jwKy46A8kTwbEX5Dg6YiFlqAJk7iw1skCwE=;
        b=Jj/rqPXxYKFLlvgy3TQ08iq5ooSuf/ni3kSvJ/6nKYwH24y4gcMtRHezRJFwsPLGcS
         maiO6/0g+zR8hC7oXjHGLWqGfo9pzIN72BhkMJqGmBhRCNneQK/NybaVcnEC/Epsk3Q/
         VedYiGoK3uFRDZYTprQSdcp1h9iZ15zeQjfCR62P5ltyVleUvv5wyD9O7N1zgHotkDIN
         QuUIFPMHmcqxi0rJuC17yrPmsioLCtXsluIUAOhnQu4EMtdU3Kmsh3+oT8xUJg/BW7rm
         bjG3HykI/23Mzz4+ZsatIOIGMqNqz9ISWwc/VQwZxbJoJPn/VssLeM602lTLgkbncpNa
         ECRw==
X-Forwarded-Encrypted: i=1; AJvYcCV+hzL31bpSQLa3OL6XZhKxYgvxMcK9yGZ1BRP4QMsZUH/E/hVNfaVIINbcvxU83SbPGyA/eGRD8VY19fgvqRE2L2Nd
X-Gm-Message-State: AOJu0YyIbgYhsgafREsk+2k/8sg+uB5ad/dOzcxSZfn3dJc6tG8M+jS8
	cs3zkVqi+bVHGvdZetNvMIY9Nc5dlNk2P/Kn1RNRvgsSBWDvG3S2
X-Google-Smtp-Source: AGHT+IERCRRImmIMPSHoDihwBUkknWgVYXrFOIe5RHf5zfFovwZ6sdGbTVXUDlqeTXNtOV11ls0zfQ==
X-Received: by 2002:a50:ed93:0:b0:562:1209:ae04 with SMTP id h19-20020a50ed93000000b005621209ae04mr2109056edr.5.1708035124356;
        Thu, 15 Feb 2024 14:12:04 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t33-20020a056402242100b0055edfb81384sm926316eda.60.2024.02.15.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:12:03 -0800 (PST)
Message-ID: <a99c123671efdf4e795d883cb3b0c67ced3884c1.camel@gmail.com>
Subject: Re: [RFC PATCH v1 08/14] bpf: Compute used callee saved registers
 for subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 00:12:02 +0200
In-Reply-To: <20240201042109.1150490-9-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-9-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 942243cba9f1..aeaf97b0a749 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2942,6 +2942,15 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>  		    insn[i].src_reg =3D=3D 0 &&
>  		    insn[i].imm =3D=3D BPF_FUNC_tail_call)
>  			subprog[cur_subprog].has_tail_call =3D true;
> +		/* Collect callee regs used in the subprog. */
> +		if (insn[i].dst_reg =3D=3D BPF_REG_6 || insn[i].src_reg =3D=3D BPF_REG=
_6)
> +			subprog[cur_subprog].callee_regs_used[0] =3D true;
> +		if (insn[i].dst_reg =3D=3D BPF_REG_7 || insn[i].src_reg =3D=3D BPF_REG=
_7)
> +			subprog[cur_subprog].callee_regs_used[1] =3D true;
> +		if (insn[i].dst_reg =3D=3D BPF_REG_8 || insn[i].src_reg =3D=3D BPF_REG=
_8)
> +			subprog[cur_subprog].callee_regs_used[2] =3D true;
> +		if (insn[i].dst_reg =3D=3D BPF_REG_9 || insn[i].src_reg =3D=3D BPF_REG=
_9)
> +			subprog[cur_subprog].callee_regs_used[3] =3D true;

Nit: Maybe move bpf_jit_comp.c:detect_reg_usage() to some place available t=
o
     both verifier and jit? Just to keep all related code in one place.
     E.g. technically nothing prevents x86 jit to do this detection in a mo=
re
     precise manner as a "fixed point" computation.

>  		if (!env->seen_throw_insn && is_bpf_throw_kfunc(&insn[i]))
>  			env->seen_throw_insn =3D true;
>  		if (BPF_CLASS(code) =3D=3D BPF_LD &&

[...]




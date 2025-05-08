Return-Path: <bpf+bounces-57815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F78AB065C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766BD1C24DDE
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA422A811;
	Thu,  8 May 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEEYgWI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3728373
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746745660; cv=none; b=WGT27EvabA/D57xoSXSOQCxtOBtc5aTqEqzI5X3IjOAHpp0EXUszCDgXKJzOPVXoQo2ch3BfAhUtkQoTwud4trIoh7QQqC7WzWbPg5DUdPviedofpDtH7wxpVFp1hMBI6wLrZGH3f/JdLNXCIOhLApyfVNaMWu5RVF17P4/pQI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746745660; c=relaxed/simple;
	bh=VR2y76vgQaPlf8KJwI/L/xCwNbtHLDjf7DyrA8x4Y4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sd34Nn2xX0sYNYqc1+7dRVcxxSQ4UjsW7M9zENYCXS+tQiPnADuK/Txi/IccLhVcZqzMu7WTkGjxpAWVyI0Y4ImoV381SSBYdjE11Q+KrsWTY/Q8IY7NxTx8N8tjiGuFs0NUboJNcoO2kyzmnG9F3F0kJb+shJz4I5lBsokr4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEEYgWI0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7418e182864so895362b3a.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746745658; x=1747350458; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lA02nPpiARH+/xzNBeook52pjGP8ZEcq/1e0lI7TygY=;
        b=MEEYgWI0m5+FkLoDLNvycQ7HDjBn76Ft9Lnky85/Mw9MVRDEkkO/PtzRpIB6rkwDcI
         +xfq8Rbrw6I95l1hUTft1u9MZQnTwByMZB8OgDhBFOxBALgFHh3AbaN4XP28FclqoUZ1
         NQcmCISzq876hXdAq7d+wotD5K3VXu+FALNtc+ZvuMzl6iI3TAXo3EqBb2sWaz1P8wkY
         gh8GyaJUVcINmyVtt2eK998RcBE+Z/TIetzx7wvcJgIGr9XDQl5Ueow6zGbfaXuNg3Fs
         iwhOXvCwH7LvOClHuf/V7JiuY3sidu4ZsFuafqCUu1e4fQj0kEcwbXvhyKBICdxsLPl3
         cdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746745658; x=1747350458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lA02nPpiARH+/xzNBeook52pjGP8ZEcq/1e0lI7TygY=;
        b=XQ9NpQ2XbCBna6L5BSBGg5P990DvKW2lSvE2HeVQ5+jaR+44pCtK9GHzZ3lNNQeuDA
         GvDiBVppJaaKX172dkdpepJHn05Sp/dux5Fx+ULGD7bNBl3sK3BgjT8O52VBS79v5eGB
         YLAbYfkPXpr/p/Dg6LfFcPJWIZsjnA25XSNk1ei0EU/d8XXNC/UxLCfvOzA8/KhC21Si
         MVWQW+lUNmTjc22X0YSIZUNxyp5HMqtZC45a8gdZ2WStXpsnDi62yR1Ut5kjMes6Fa7T
         LXvdfyjc0bSZOY/SurB8SwMsjDU5pSAzqx/QdV1lR0JXty501Fxk0/R0PWYY5ASMnTrB
         33SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzFdjpT6ltOZCYQCwdMetuT/QbuZyPn7eOYN2yBNxWkwiMMe/A9ZCZlneWFbk8QPDe0zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNe3DU2+aAMV24puOXdeFOoajEfC5V7AsaBzqtnJwQTrIVHsw
	I1xss6sz4SIA1JTtQBcV5Kp2SwPRrCQeIiz2Xybe0w+CqkG/hfUQ
X-Gm-Gg: ASbGnctmWI0NjCVvJyfewtRmCo02xwnbBUhFMR50j/oLV19VIbim6f0y3jLkqgNf8BU
	1VWNmIK7pGmv3KLDnGHNojYs5fJOS4T50/HkBzaMdhxXck4+Sj4XQSd955mZgzTin1wmi6jTZ9r
	WXlii70TNcmZQJCQsMj7e8xjEXvv32JtW3pW1JrvqaYfOk/LzjJLbzBdpKl/Vk5DexDeeZLcTet
	+6im4gNlSoQxq3XQcN5i1w6sqJBzp6M4Ievl2XGOWQGSioWCJ3s/EbnhD6i81brAKFJngyK3jaK
	6sNMhmxUC1D9kfnz/g1Sl4tL6L2iUBWimHIfR23/+JYjIVo=
X-Google-Smtp-Source: AGHT+IEQ/cnkrZ12+nF1CbM4CYZrFx2QhgLFQHba2esGs0zVuIZxZN4JDIql+lty2x6zgREkXJMqPw==
X-Received: by 2002:a05:6a00:a83:b0:736:d297:164 with SMTP id d2e1a72fcca58-7423ba80ea8mr1502242b3a.1.1746745658549;
        Thu, 08 May 2025 16:07:38 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237727a1asm616491b3a.54.2025.05.08.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 16:07:38 -0700 (PDT)
Message-ID: <43ab09ea0150f8d987106604235886f28a73ebd8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/11] bpf: Add function to find program
 from stack trace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 08 May 2025 16:07:36 -0700
In-Reply-To: <20250507171720.1958296-5-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> In preparation of figuring out the closest program that led to the
> current point in the kernel, implement a function that scans through the
> stack trace and finds out the closest BPF program when walking down the
> stack trace.
>=20
> Special care needs to be taken to skip over kernel and BPF subprog
> frames. We basically scan until we find a BPF main prog frame. The
> assumption is that if a program calls into us transitively, we'll
> hit it along the way. If not, we end up returning NULL.
>=20
> Contextually the function will be used in places where we know the
> program may have called into us.
>=20
> Due to reliance on arch_bpf_stack_walk(), this function only works on
> x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
> arch_bpf_stack_walk as well since we call it outside bpf_throw()
> context.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index df1bae084abd..dcb665bff22f 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3244,3 +3244,29 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
unsigned long ip, const char *
>  		*linep +=3D 1;
>  	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
>  }
> +
> +struct walk_stack_ctx {
> +	struct bpf_prog *prog;
> +};
> +
> +static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> +{
> +	struct walk_stack_ctx *ctxp =3D cookie;
> +	struct bpf_prog *prog;
> +
> +	if (!is_bpf_text_address(ip))
> +		return true;
> +	prog =3D bpf_prog_ksym_find(ip);

Nit: both bpf_prog_ksym_find() and is_bpf_text_address()
     use bpf_ksym_find(), so it ends up called twice.

> +	if (bpf_is_subprog(prog))
> +		return true;
> +	ctxp->prog =3D prog;
> +	return false;
> +}
> +
> +struct bpf_prog *bpf_prog_find_from_stack(void)
> +{
> +	struct walk_stack_ctx ctx =3D {};
> +
> +	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
> +	return ctx.prog;
> +}




Return-Path: <bpf+bounces-77636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3EFCEC7EC
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13C1300DC95
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7A30AACA;
	Wed, 31 Dec 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsvS4w7C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B22309EFF
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209229; cv=none; b=cP5YRxOjYE7mSU4PXGf4hMkVMfypJbb8ZygAvuYNWrnYIfg+vnLVwWVKmLRXExvmg7QdfHEivb911fGoeDqBRWNzyZBpacf/Of7OH6z5opxiXsFaJvnLY0ItIP+lNzdyNHNouujedCjMvL/a8z0nBpNmtiolPN4dTXDBUcfwFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209229; c=relaxed/simple;
	bh=MloGqyD0EphAFOUJV24fYwwfBI5OfaESKkn3K9xOkwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=at0dRVOoOt/1rvGUuhO+AFxH00zefF4qAdSCg1G31NEwvwAvK/r2FL0tSa5iZrME7oizWwnQy77sYo+S3U2zlGBwANlFVi7s4g2UNhnuNS4Wg7YpWHDbpr2TqxIhgh8codmH1WQcOQLQ8i2XzTn7i9tfDFEKh7erojMzk8nHABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsvS4w7C; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so10506749b3a.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767209227; x=1767814027; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hnWy0vllf6Vg8aYRom5ucXXCAs8BWouWpGFvsFt9B6k=;
        b=nsvS4w7CqUEoMWSN6fbGfw3yfUSRz1FQnjVBSGPl7Pj23GXL/yJFOwcAYWbXGw81jC
         j530sY4rrRFXlUsO5r2LTVqH8nhiOqYgAPRlfoP32YjpDsvrDrlWAf/CJ750AuqSFvi/
         CRXoa4Qyd2iaeHHgzZThxRzgvtL0iGcCkZhSnqy93NiwKSI5fpEQxwvBMLiXNhAbpOsP
         Jf7heZn86vEDzkiP+1Bb8X99vbTGLdZLUrXFfqIV+TBnREDb002PhkSLV/hVH28afMjS
         jU1ZRaNoWneOQg/4462c5bJ3ttJpaAVCoWgDsVIn9JX8TEC6vshNI0q9TEUnPJEezZRH
         vBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767209227; x=1767814027;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnWy0vllf6Vg8aYRom5ucXXCAs8BWouWpGFvsFt9B6k=;
        b=TdE7+ae4VpWFQ8P2v8xLCdFwbV3F2woqtR9xKeHQsswORkfhznG+3Kv36t95LWN58C
         DjWzlljps4O3XKjqTN24s26I4qJPJmP74u/oYMjwOgO5sapL9AqVycWAQbFTZ1l66Tpz
         4qWCt5ArKoZGa00IrHOAK0Vq+z4ZyoLp2/9Yg9UbhQX7EVBOAp1csVHPoiLyXCNTPl9j
         1qILKQXCyTg2+U4FYFZpoxdlim8+5aBP+kmahRwld5nDZVG7B2tE8FEdj4i0SuP3pe/q
         mE1d7mvQvj95G90ZCumf1hUn9P21ZJIAxA+rcdQugNY0tCJVEc5hBmaSacDlgVJQ5qZN
         xDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXUtr2WrDeUjXxk9tgy5bYG9Zzxroj/7aqtjpF7F2aQEzpOK9GJMnr6UmH6gGi0NTY/k3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPbMwRdV5KO12mjKvtRuuSwYvZxTMRsA9FZ2J86JRve9ECJJH
	PwuQF3GOrIVMBIM5Hf4rQA2tuf3yEchd4W2T/1wpAFKSoWMocwEH9GYV
X-Gm-Gg: AY/fxX5oHaSQQRKHgprj8ykfjxemgAI2RJVvIUPEAW6Lw3mTS4Y47gWeyeqYbIcIsUt
	DkAMI0fwu6qG/F99W3G0OROBZCaPbuuEVb5KiKY12f1E/4pAqdLqRZKs31uK6SoLVK8nARfFeCY
	KMTYlNAi1PlNuQLhIFoMrFLrf+ov55HLoy+ORWgWRpp0vJjSqU/A1a3BOA2DcZwM9oFQk2xcOSb
	AXDIfI2DGcwnItCdneRuEYzXAt66YeL5mzfivjdHoXPpYWMrxo5FNY5W9PrmcIgXmBEGK2xz2vA
	Pljb5A5OGsgXUOr21+SkCWyXUpedf+xoKmEYdc63ISnwoIgpGA8GGtCdeWtTT378biqaiFGWph2
	eMH0QcOpRo7dGXEQphsX4QptCHcXcpyIa8VPW3f7/nHC+N20iad6xKL6R5roO05LTO84EurP42f
	rwHdvsS3CB1f4t+/iiTN8=
X-Google-Smtp-Source: AGHT+IFqWuwON5N7SJg0txtWDI0hwRnhu1AOXYhoup46qwZvuinrOUien+7XXreV+ll5BjxSSlRfYQ==
X-Received: by 2002:a05:6a20:7fa6:b0:359:d678:5493 with SMTP id adf61e73a8af0-376a94bf4e4mr35195220637.34.1767209227491;
        Wed, 31 Dec 2025 11:27:07 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a05e4sm35853832b3a.38.2025.12.31.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:27:07 -0800 (PST)
Message-ID: <158a0c1b46418130cd8e3a7b67775f3bd00caa16.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] selftests: bpf: Update failure message
 for rbtree_fail
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:27:04 -0800
In-Reply-To: <20251231171118.1174007-6-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-6-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> The rbtree_api_use_unchecked_remove_retval() selftest passes a pointer
> received from bpf_rbtree_remove() to bpf_rbtree_add() without checking
> for NULL, this was earlier caught by __check_ptr_off_reg() in the
> verifier. Now the verifier assumes every kfunc only takes trusted pointer
> arguments, so it catches this NULL pointer earlier in the path and
> provides a more accurate failure message.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  tools/testing/selftests/bpf/progs/rbtree_fail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
> index 4acb6af2dfe3..70b7baf9304b 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> @@ -153,7 +153,7 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
>  }
> =20
>  SEC("?tc")
> -__failure __msg("dereference of modified ptr_or_null_ ptr R2 off=3D16 di=
sallowed")
> +__failure __msg("Possibly NULL pointer passed to trusted arg1")
>  long rbtree_api_use_unchecked_remove_retval(void *ctx)
>  {
>  	struct bpf_rb_node *res;

Do you happen to know how did it infer off=3D16 for R2?
From the test I would infer that the off is zero.


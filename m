Return-Path: <bpf+bounces-77668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B084CED991
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA1373003F89
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2FB1FDE31;
	Fri,  2 Jan 2026 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="j5OhR6BE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D91F03DE
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767318291; cv=none; b=b35hreVsD113PLiasM8vrUcI0fK+AXTScxEDQpP6Gi1pe3QiSAL4Rry3LRFbGHT/qujsk4Dub2HlAqFu829fSRmY0oPQ9pQ3wRonESv0lISfbGS+liz7AtL/4AC0QdArt8WQsnPTvnaJbzhmzxW0q2VlxSqukuSRNlLs/ioBuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767318291; c=relaxed/simple;
	bh=xrD7MbxiYek44E8M+T/cHvTJDr/5hHz83SDD6vd5TD8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JGRrP8bALxFebhwREKuvFOiuA2YqylKPjY9I1r3qW7aY7AT0o63sZCnKRN4VSPwrrUt9mxkyrVFZkB+u4JtPJcrET/tdNZnBn/l0x/O5RJYjuv56UKgceh82bagrsXqHqlZkQrkttf1bZTwtZtNkjtb/QY2PtXE/D7hKKIJ6Iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=j5OhR6BE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed7024c8c5so97759241cf.3
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 17:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767318288; x=1767923088; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAfczwucXcapsZVwsbvSr9ZmWeGKQ59nyliMHBrVmQc=;
        b=j5OhR6BE3/PrH/tRBRLa0VVAoQWXoYVjIALkn9XdY/pgF6Id8WFUZGDitJi4X28kp1
         I4bAot8f1ME0TrCkXhqzL66v0ebsrFI75+QxRemhpj6qCM/0a+BVJX+wodDKGevqHnb+
         DThsc2m+PahWWkQgXnjQsk2TKTxdTMvpRfuZWZJlx/rjBd2SMdnURHduCHj3mCD4To3X
         0muVkJZXHzIvlsUcfJeFWOu2mx7oS49uPRKPEqhb8Ijp0WsMxuk9dosgCzf3sngL8aSi
         EBBQHhrMGg01DcuFkehYFlcfjAzYnGWYOinFPdt32byU68uE3dl32g/RlfMvyBusbVHI
         QqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767318288; x=1767923088;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAfczwucXcapsZVwsbvSr9ZmWeGKQ59nyliMHBrVmQc=;
        b=w0MiAX1ydG2qWINYoei49SVjv2/eKB4f/e4ETOxNpdf51RtVa0qng1UKz3zFNrhNfY
         CTuTiHAeLBcmsRKptEJEsfiGVfl+reyDNGjLRKf7sQAk6QOSGZ7Ay0NQw9RpDkPEh1dB
         Z6vgNeDPm/CWEQ8mRhMJVGsOY+UEpsLcbUx7e68rReT2DfTe3hQrDm1Wh2YbG9nuLBh2
         pVINtl6VfvmfJo94gD7WbZ35/W59C1ZmO25udGmbZV3ZymfXjiAqcZOmz7PhELg/pp21
         IgUsQ68OSCuSBYGkGbh+wKzYQjYnKDJLDPN5m/dUosJib3epwhC5z1gudr8Pl5Ferw1H
         JAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx0xuuC5UKpUYIBnjePfY9IP32hmYUkWH5g/cb2MO9Vb74atP1uTCvi2KU3vC+LIu+Rbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQdRDEpWRrMgZqJ8URT3IEiz3jTD2JPh5JwH7fT4Pjn2wvYV+
	h/oqJAHL2ibSDScW7qGaph5KdNUgwDq8DGI42NiCx/U8cT/eiJoMfW/oIA/itjo9Hfk=
X-Gm-Gg: AY/fxX6yFRoLKcmIIFgSNcywVEaWVWxi5PaJDN+QPVZnG9FoqrKLbmjz3/VXLBaIXm+
	3ue+WBegexZAU6rVMXUMRJ7GmP1BCwj4s5eIhLWTtO02es4o2YVcELR79wBO+Hho1Ekx7aXq/Vp
	RBCTjvU8FamHhn2VRLfXs0vxgJsHxOJRjtcjfKMuNOUIxETNEUDqPVYOaa9rKnr8UiQJS6hZv6f
	MRbq2GyCzxbE2ELy7uvYyIH2+xCst6Kpbj/fZUwpLSQTfxiVC7NxefMhrHHTTzf4zwVrujgQ/a7
	Cwpwq68d3urVySnxUTB94XxV6wLm3C2QlKMzcYXgNZCFp4YQcIqw6kAEzbjo8QM7QRxFLxURoMb
	X2GMTxsK9NSZaezxhE/MJ+OyoYEdwQFR2LQBcvZ7LV7NvpIwI59huLrjcra5Jw26n3jODmtxfO6
	71ratwQGxTDTS08zny2Kx2zw==
X-Google-Smtp-Source: AGHT+IHGbehIbu0+f5R9+W1Nmrbf+Z04VYkieLvJ3k027Cr9AimEDo5TvWfqWQ9RYNKqVbO31i4lKg==
X-Received: by 2002:a05:622a:110e:b0:4ed:66bd:95ea with SMTP id d75a77b69052e-4f4abcf525emr706051751cf.29.1767318288416;
        Thu, 01 Jan 2026 17:44:48 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac649957sm288162581cf.23.2026.01.01.17.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 17:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Jan 2026 20:44:47 -0500
Message-Id: <DFDQ1OT39TCW.JW5QMT1DMMH4@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 5/9] selftests: bpf: Update failure message
 for rbtree_fail
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.20.1
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-6-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-6-puranjay@kernel.org>

On Wed Dec 31, 2025 at 12:08 PM EST, Puranjay Mohan wrote:
> The rbtree_api_use_unchecked_remove_retval() selftest passes a pointer
> received from bpf_rbtree_remove() to bpf_rbtree_add() without checking
> for NULL, this was earlier caught by __check_ptr_off_reg() in the
> verifier. Now the verifier assumes every kfunc only takes trusted pointer
> arguments, so it catches this NULL pointer earlier in the path and
> provides a more accurate failure message.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/progs/rbtree_fail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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



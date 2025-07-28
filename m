Return-Path: <bpf+bounces-64550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DFB141D5
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F85D16B44F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D5C275AE2;
	Mon, 28 Jul 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5alndfC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78024273D65
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726714; cv=none; b=dgTvDa3vS4olqcvn7bjT7avFg78S3dFRynmy/MWxH5cYdcZUo6hYObXmK4lTMIMt9aMphFdvyAm4YSpJi6C7X4roTh9NbdBv39uknzE48QQ7KUE0S0hbXxLgVrcgcwgh3tHgmBKeeDYPTF17KF9gtgtgMfISCVgUpC7X4asy1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726714; c=relaxed/simple;
	bh=AdeJRdfJyCXJ75dUB9dz+Y8q5UgDcwwKMzTthCRUE+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcfBoEXyo6fRrxfUxsgf8DHcJV1eLKcAUKoYyo4ByY1zwKF9O/DbXXZ7JfTYY6zmG7hQ1Hog7W7Lt/j623YnBdF6sQimSpQwf1v4ufcoVa8wQWYp1hwlEeTNta52r57ej7Ja7ftxhcWQwRxELHmdR1iCpLats5x+hA1wA+bpCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5alndfC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso27245ad.0
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726713; x=1754331513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=934JXgrmfTiZKyG8AS6cDigjtQRPbfTN1Gxmsj8ReVg=;
        b=X5alndfCBBlPAccId3gGV7xrV3UCmBxDiSXLT5TtK2m5I5TNEf+z2F36az6UvHUbzC
         bAKMDA7LknH7nW3byaQQSr50prbconGoa+kDIpgLzPDr1Y+GimIpCD4/qCksLDqeGP0f
         sz0bS4RGQQQzyQNpOHO74xfERrFUhm77z6FVsgYnGLwzEcINZrncSKAvJc1hThJEHghk
         pPNmH3ugipt7sKjBfWT5jnB4sVNHYYbS7BXlFDld4pKWStXj4+YqZcBqtsJ+bnEX1gyA
         JRbzRXnuELgWOjAC/W56iDb6QAEgXz9GAtjaDUXqjy1Ms/qKSj5pfY8d6y2JzHuUGkSs
         VoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726713; x=1754331513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=934JXgrmfTiZKyG8AS6cDigjtQRPbfTN1Gxmsj8ReVg=;
        b=PwNpjzHzVk4doLdE1K9ycdUBOxRhm+0W9NX06/yyiMIJq/T/49rkB15/Hx/MroW5ii
         TNF6lsgYA9ignODd1Sih5+xuWNMExN+nU3H7+UXT8DnMSTgrJ85mRDHCdxYHwNji7lRl
         cb25m27tqC5AMj9dbaMgmg7G6TmZbgANoxeT8itUMakNAeh5z1C4vUNZaGL0GpjQJn0D
         Ca6XvZE4ciRrZdabcPRSh3MBQXuJsDgbSZY0IoaZRP5A5y0/JPR0QeGE3sb1J74G18ca
         iNTgJd0cXOHq8K/NeGEPaaCzBmA6nW4EgiIUy/Ak7XEZ3sh179R6nVoQ8qgipXS4U0+X
         U8wA==
X-Gm-Message-State: AOJu0YzqjdgKdIOJsNGQhscowNgPkF7vRVUc39IBB+HQBMPMUHnVM8IW
	N+MC9dgOmRJX6BGWkfIZLfQrcV21HzvB7muTgEseNOTV0rpwTqC1s4GDeVNQXO039A==
X-Gm-Gg: ASbGncs0tLlbeFQ/btdNriNat6NyPnGVvKrst7UMgykn2QSDvNWjhzPM7qUpKMZta+i
	NRnqv6aec3luNc5dbtUAhEdjTyCnFdOxNSIn+s4n/dOQf6Gz1AuWi1XxvDgmjWjr7/zSCWYRW1N
	EQxvjJYoMfhagSQ+RZIR3eiq2dc82rtVnj45e15Ftb3TMNRs1j0L/tByuWjZuStHoZ0KsTDrkOZ
	JeHZlQ0VY5hjMQs0MSHeYIySuX+MAVf+3TK7aAzkHmpMEw88+DRrJDP5bx8UH5u/IlToIBDBOmu
	gLQ3K1fz00cV1+fSfzE5eojTfmSDVr8nr16nQzknmvzB0qVIOPGprvehfi7QYbrcXywfx987abW
	FzdD9db+FaWgPD/ew38TLSYHgapuWr8kDmNIDbr5zdqYDpTilMCCSEuNO8BcnIoVSrtfh+kdJTW
	LqC1Q=
X-Google-Smtp-Source: AGHT+IHxxJZ1UPR2CgoRBMmD9QUIzkRhy63XqqC43AGYc+LeSZvQDPxlTzuPfaZ07fzByT4GOjK3EQ==
X-Received: by 2002:a17:902:d50e:b0:240:589e:c8c9 with SMTP id d9443c01a7336-2406788feb6mr279565ad.10.1753726712249;
        Mon, 28 Jul 2025 11:18:32 -0700 (PDT)
Received: from google.com (111.143.125.34.bc.googleusercontent.com. [34.125.143.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b0c60sm6064646b3a.126.2025.07.28.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:18:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:18:26 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf: crypto: Use the correct destructor
 kfunc type
Message-ID: <20250728181826.GA899009@google.com>
References: <20250725214401.1475224-6-samitolvanen@google.com>
 <20250725214401.1475224-7-samitolvanen@google.com>
 <932a6a4d-d30b-4b85-b6a9-2eabeb5eaf2e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932a6a4d-d30b-4b85-b6a9-2eabeb5eaf2e@linux.dev>

On Fri, Jul 25, 2025 at 04:11:27PM -0700, Yonghong Song wrote:
> 
> Okay, looks like Peter has made similar changes before.
> See https://lore.kernel.org/all/20231215092707.799451071@infradead.org/
> 
> To be consistent with existing code base, I think the following
> change is better:
> 
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 94854cd9c4cc..a267d9087d40 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>                 call_rcu(&ctx->rcu, crypto_free_cb);
>  }
> +__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
> +{
> +       bpf_crypto_ctx_release(ctx);
> +}
> +CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
> +
>  static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>                             const struct bpf_dynptr_kern *src,
>                             const struct bpf_dynptr_kern *dst,
> @@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
>  BTF_ID_LIST(bpf_crypto_dtor_ids)
>  BTF_ID(struct, bpf_crypto_ctx)
> -BTF_ID(func, bpf_crypto_ctx_release)
> +BTF_ID(func, bpf_crypto_ctx_release_dtor)
>  static int __init crypto_kfunc_init(void)
>  {
> 
> The same code pattern can be done for patch 2 and patch 3.

Sure, I'll update the patches and send v3.

Sami


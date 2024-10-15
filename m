Return-Path: <bpf+bounces-41898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C251B99DAB2
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84610282C97
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11392BA4B;
	Tue, 15 Oct 2024 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWqt0uyc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67873AD55
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952505; cv=none; b=s5e1E1/Ay1KOxtWEtyxQldwbM4n+HoWLsJ/evdp43rdBO+gDF+p1h1bpMl0bYUMrDTwD54vp73kJNPTBj7jFLV4t2tQhYYknQFwVAxH/J7yt48dTo8mUvChXf/7hDu68Bo0TSBp8uZSoTsBRcGfu11lE8fryd3GKKztliiYnIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952505; c=relaxed/simple;
	bh=imwk7K4u9VEsAPlUbTjjNXOk2G6W0JDAfWPyv+DKGFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsIBvBROBaZvmAsy92D4CZNUcoZSMWihSovhteg+piixn1Fh7Y/IdDp3ur239LdiCUgkfMmkWONWvjyXcC+aVErjQZt3/8i7sttWnTYysWVW5nI+rLPpSFnMS63ww3Tvr/9dTE/gos/8qtdIKSoDAY2bey36SR8Lld24AaMvwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWqt0uyc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso2569061fa.2
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728952501; x=1729557301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YXh2Q41Ele1/0DVwSmnNKS/mkgQys39iWXGBdkL0FY=;
        b=YWqt0uycfkupLSJmrWbLXc8I+/gpqVYA1+d4q1bSnbY3QO8deD51gPqVyaY+RqCblw
         Ao9hNQfm3sfBuWp8puZMYos0ENm7DyAlBMoD1TT0njhY53+Zt5VlFbetX4QSrDw0WUSw
         Tx8O+rOhdb7ck8hZZWB0dSrG0nm0PcMywVSX0+cfJuIywKTPZkxH16PhMgerAYQYeco2
         7OdCe9lFipZWA44296FlSrQzYI65Yuk1Itj/AoHOTPmAjjFLKgvds6S2o9IjLby8O1Sn
         nFEQZmtTgYR0X/m4jsNAces2TW0tHoeNeN41My+ujMk4elEv8FW0pQBbbfjJSdGD+0U3
         0AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952501; x=1729557301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YXh2Q41Ele1/0DVwSmnNKS/mkgQys39iWXGBdkL0FY=;
        b=QsnmtNqBo9ZnyoZmV4vdFJLeeZLpmHaIrm/HjjAAHGnjFU3/4FlXxXz3AebSsGUZN+
         URFXYSZPXttIrW16wEquMuPLoogf9RndMfV8nNkF2Mx2xnxSG4zNAuaC/pBMylQz3rlr
         pEkunqRawwEF9UyBQZ/wvfsbDA16FC0zt4PRNB3ScdF7hrM0qPCAQy1mwLRss/7JTdRT
         BriyfotPXYWt/eYSV0mkTbCIHGUL1noQpfQdGIpXREaKRwsfMaElbEq4otL+URxK+4YD
         e0FjXwWItVNRYPhG3VYGQWvfWDy+IlZxvHD0pw6orKArzlJdmASMzm/9aCrb5beLxoTC
         1Q3g==
X-Forwarded-Encrypted: i=1; AJvYcCX/iVyBkyrrCAEbjroMdBJYNAdKTOohefogGZLImmo1AIxiq9omXgEN2YWtqFRiypGssrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kCBLouV5yXNOVyZO6HPTyCMDtDpyx87Pka5Xm2yvSkhBIdHb
	hGtSqTpg5hG1FUf8OuDX9WUj4vtjOHmzeqvuIX9a/dROUJI3UCwHrLdB53LDy9VJ4/R7ECz3yNS
	r7Tc=
X-Google-Smtp-Source: AGHT+IFRreFzQ8h7VSU7UkasygGzLuLxMyHWaChq+LTbV4PmYDY+e4A7tsUv1j/7DdcrGvwB+Ei76Q==
X-Received: by 2002:a05:651c:2121:b0:2fb:5d2c:7509 with SMTP id 38308e7fff4ca-2fb5d2c76ccmr1186601fa.14.1728952501449;
        Mon, 14 Oct 2024 17:35:01 -0700 (PDT)
Received: from u94a (39-9-37-148.adsl.fetnet.net. [39.9.37.148])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d715e2aasm515315ab.82.2024.10.14.17.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:35:00 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:34:49 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Zac Ecob <zacecob@protonmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Fix truncation bug in coerce_reg_to_size_sx()
Message-ID: <ywjkybsqgzzlahmh5qxjzownd747sojvwm45ukl7a2vq55ttjt@3wzyq5kapmq3>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
 <20241014121155.92887-2-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014121155.92887-2-dimitar.kanaliev@siteground.com>

On Mon, Oct 14, 2024 at 03:11:53PM GMT, Dimitar Kanaliev wrote:
> coerce_reg_to_size_sx() updates the register state after a sign-extension
> operation. However, there's a bug in the assignment order of the unsigned
> min/max values, leading to incorrect truncation:
> 
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
>   1: (57) r0 &= 1                       ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>   2: (07) r0 += 254                     ; R0_w=scalar(smin=umin=smin32=umin32=254,smax=umax=smax32=umax32=255,var_off=(0xfe; 0x1))
>   3: (bf) r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-2,smax=smax32=-1,umin=umin32=0xfffffffe,umax=0xffffffff,var_off=(0xfffffffffffffffe; 0x1))
> 
> In the current implementation, the unsigned 32-bit min/max values
> (u32_min_value and u32_max_value) are assigned directly from the 64-bit
> signed min/max values (s64_min and s64_max):
> 
>   reg->umin_value = reg->u32_min_value = s64_min;
>   reg->umax_value = reg->u32_max_value = s64_max;
> 
> Due to the chain assigmnent, this is equivalent to:
> 
>   reg->u32_min_value = s64_min;  // Unintended truncation
>   reg->umin_value = reg->u32_min_value;
>   reg->u32_max_value = s64_max;  // Unintended truncation
>   reg->umax_value = reg->u32_max_value;

Nit: while I initially suggested the above fragment to Dimitar to use in
commit message, perhaps saying that "reg->u32_min_value = s64_min" is an
unintended truncation is not entirely correct; we do want truncation in
"reg->u32_max_value = (u32)s64_max" to happen, just not
"reg->umax_value = (u32)s64_max". Hopefully the maintainer knows a more
elegant way to put it.

Other than that,

Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
...


Return-Path: <bpf+bounces-73952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE74C3FC22
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C8194E19E1
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237F322DBB;
	Fri,  7 Nov 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF//1vcs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F031D748
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515695; cv=none; b=SrUM7j6j5yc+hchlaQzOpU42vPvBofjIGkYbf9gIgsF9UyKylhiGY5mloNL7z3/a5ux69gOkBSlHycHC2NuAAcRtrHXwh2bKhQwBfzPATWI+28+ir+73Jm31ckfX9Pi4cqqLs0gn2b0/eSsAnHaffqsiys83JvAbhIZdnOZJsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515695; c=relaxed/simple;
	bh=67O0HM6LgZ57wI3RHX22DyqBmRYudasdbXg/4Zmqlvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUQ7LZB7xAuL7SY99cY7fFdXquy09minQ8PHn3OTJDmrtvlhRkCouiYl9GWebhndRGJSf3IHzqOU2yZBFKGXFkEumhu15CJ9zw2M0+r3ROCfssfBYH4hWnAoNaKyfEaIHEDST7TLXByZJ42oxagPlRYz5wdMYozPSm/xWqMEUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF//1vcs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so4353555e9.3
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762515690; x=1763120490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbIyLdjACXlDwnRSKcJQKOcA3uAX0B3KEyjgAmsMwwY=;
        b=DF//1vcs9RgkCYaYA1vmxFOfcxodUX7AgmJ4wMGQOMSzvi4ZJ+jrvoeiNPe1n+7OYv
         H0EoZ6CdRhOyFe1B5YaFLaArkP6CCVBWV4lrz6P8JDeXHS6FK+hSRRTl0cyk2LjLSDjv
         IyLwZE0ZbmWeg6Dqaf9xoHgPpfZm0yIQEVv5EnxjeIMqMcVDI3LOY3nWYURtI1OR3aga
         NSHzkopQXCN7YDuH2beZwAgEajlsqt1jF/nSQs1SgxMCrnKhWH1I+T+iXX4kh+XpsEbw
         zmCk6D9P8uvbGuPKk/TKPEnaufeXlMKUUDLDgnGKJgUpiAUffy9IUwWg9vt+Y4UcbFNp
         oh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515690; x=1763120490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbIyLdjACXlDwnRSKcJQKOcA3uAX0B3KEyjgAmsMwwY=;
        b=r1FCviDyo4PxiA6mkAGHo3Y6fEjtpgr040y8LhwcIsVHZFqSSyi7z4gV5LFh3TwEeR
         0f51zjxz3CkI6zUsXwaJeLR8x/MtGxqI51ZNhUfquFL8SHVf5PjJMkmWTstalhShMKI7
         Z1UQ8uYUwj1lrI781BSddiaOb8xOabB2nnla1IGBmqpyC4DumNk1UFWBSOwMsMXKb1E9
         GwU0tbAW+Q6SSn9xZXUNWPMb1+eQbj9orc5dvD6yeE3l7y7rqGLAB6uaYxL8UCskYf1H
         0PkH2YLF2ww13BHkzDQpm1M5oeMWvEcdBTcbIMQ/1FqYzzBwaMLM8cu1cH2ly/loueGe
         3INw==
X-Forwarded-Encrypted: i=1; AJvYcCUq7qoh7MDNWPKUExXrQUlfSCk0+fzJ5nFusVaK8BVp4YOXPtH/oMkUT/3gBM6trLDCtlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CPCIICw+z3sEsSbzKgSQhrK2vM1RWylfvDi1jUwR7g/pSX0i
	8zYwtPM/1JZi5RDjzJ0RPUzA9Jxof+/UIp1bZKvs280AHvTm0+SYFvgx
X-Gm-Gg: ASbGncvZ8nLgJk1XutdZijewNT9JBooYa4cwr17fMqVKKBVgqpl2wG5XcIR4HFfT+ua
	T2KnRK6ewgcNu2zqbF0XcoytbQqUa/LvchfrCxNJEpG3GjcG+aw495ic95PXnsPIkoFfiE2Kv5T
	UF2tFTiMbrpcYFxYA19Su8E57Q88aYJZJNatVXN4SonvhKxbHBe7unclELksmUj4YVDzRM5/Df6
	zjBHZAStHndZrEoYyg2xQ7soTcsBzO6hifqlvdehZt750zl0zmIkn/+s6Oii7rxnihwMYO+TatK
	DMIrvCNGyCfWbxoqPJsjj8+whSdgNxYlj98lt5vtEOPWD7Qh9pzZvnM1b4jz35Y1SBI7ICS8szD
	GqEvM7NaCIf+mYC/v0jym1YNzcaoBo7HB3mAfNzUMH6HR4pmhuriarWKaaFBGMLAB13EVo60eF6
	VkxPYJXKJY5I7K362vBCOJ1DDoAoDc3MOppGfnGyj0aQ==
X-Google-Smtp-Source: AGHT+IHUAgcMk8bKJDdOhQ/v5qGlnIq+otz2YbimDj6aAcoys0jfZs+7+hhNNkCF/JH+RDCpE4irYw==
X-Received: by 2002:a05:600c:1c9a:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4776bcbf80emr31516085e9.28.1762515689819;
        Fri, 07 Nov 2025 03:41:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcdd833sm43040705e9.9.2025.11.07.03.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:41:29 -0800 (PST)
Date: Fri, 7 Nov 2025 11:41:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-patches@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage
 calculation
Message-ID: <20251107114127.4e130fb2@pumpkin>
In-Reply-To: <20251107100310.61478-1-a.safin@rosa.ru>
References: <20251107100310.61478-1-a.safin@rosa.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 13:03:05 +0300
Alexei Safin <a.safin@rosa.ru> wrote:

> The intermediate product value_size * num_possible_cpus() is evaluated
> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> large value_size and many possible CPUs this can overflow and lead to
> an underestimated memory usage.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

That code is insane.
The size being calculated looks like a kernel memory size.
You really don't want to be allocating single structures that exceed 4GB.

	David

> 
> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
> Cc: stable@vger.kernel.org
> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
> ---
> v2: Promote value_size to u64 at declaration to avoid 32-bit overflow
> in all arithmetic using this variable (suggested by Yafang Shao)
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 570e2f723144..1f0add26ba3f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2252,7 +2252,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
>  static u64 htab_map_mem_usage(const struct bpf_map *map)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> -	u32 value_size = round_up(htab->map.value_size, 8);
> +	u64 value_size = round_up(htab->map.value_size, 8);
>  	bool prealloc = htab_is_prealloc(htab);
>  	bool percpu = htab_is_percpu(htab);
>  	bool lru = htab_is_lru(htab);



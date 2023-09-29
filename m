Return-Path: <bpf+bounces-11143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242E97B3BF9
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2AB481C20869
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C46728D;
	Fri, 29 Sep 2023 21:30:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596616669B
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:30:48 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E8B1AB
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:30:45 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D664421D0
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696023043;
	bh=fv2iCeZ2NmNQFv4pKAf5lzvluEcz2y7p9+53OPsfRqU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JGpLQjfwzGFFrxUn8ar2YgYbbxEprSQ/kniudfCUj9hZqLWTZr6/8jBR8c6mSiCIr
	 AQJ1cBfoDJdV9EM28ahqsLN90VuhuX2ZtSnGYhYOJQrPWHf2nCxe/ryUed37Bk/adO
	 /hgNb73rq1x5eafkNR439XfuoYekXIohfzk2/9QKWkdsHq6u/u0fbzg9iqsweouJhI
	 Q+HPfdBm5+jFgBVXNIoZnm8j7sthptQOpIjZkgjAqwKXJdDpcgfFnqy1AYcIZnCUho
	 V522h9LS9gbWnFLY70YotNI8r/NtCL+T9QsJPOC0ksO0/V28IcG6WWplLRA7qK4BbF
	 kbVEbXNLjHj5Q==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41977b9970dso16960501cf.3
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696023041; x=1696627841;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fv2iCeZ2NmNQFv4pKAf5lzvluEcz2y7p9+53OPsfRqU=;
        b=Evz7XDN/GFR1jrhNGBhqFK7FusHFhLe9JFuw+GaKIUjNeERW1aMVS1/0lI6yfv1uTW
         jUbefrgeZFyvigv/GNjXcYuVwRijbo8cwnQsPVeLNIIaA+9zZ/pKnxRHWM4wYw3aK7A3
         v4yvQB9ortMVszLXB9v3wAHOMuxUo+7hW1KKGw62AhR/YcxyNnofgwO+7h2dzwPzVDKF
         V06avFdu9Z6NR5ANYtw+v0bsUMElDyQtdHI3rvhnv4qVvGVWEYIvPKJCx5t5duLwkIEA
         y90U4ycxd1XmbZsAUQjlBFNDgfufgfH6Br1TuGC8E4Sa5VO1bGLkPasx2vnBx8aYY/uH
         o34A==
X-Gm-Message-State: AOJu0YxQ/UKw6uJrfhbz65G5NqcYjpjY7bM2AWx0osZG1KK48pMf8Tzw
	Tw9mvldZZzQKWFEsMm/mo4veSdd4575Ao8GRkd+/gZHJZeXcELppVC598RyP2i212JvTcV+ca8E
	l00IWsYEDtZJ3OP7o6VNhFk9O+Q1XPirUtPau6NwY6utjww==
X-Received: by 2002:a05:622a:1ce:b0:419:6a24:ef97 with SMTP id t14-20020a05622a01ce00b004196a24ef97mr6778027qtw.2.1696023041377;
        Fri, 29 Sep 2023 14:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgTRvMfSDpwi6xBtds14Ynjqo/IMbUPblRJ3qCioAimIh+rowpsGMBUiq3MZp2wXIzJwpzGHp/X0KODFTBJHc=
X-Received: by 2002:a05:622a:1ce:b0:419:6a24:ef97 with SMTP id
 t14-20020a05622a01ce00b004196a24ef97mr6778020qtw.2.1696023041148; Fri, 29 Sep
 2023 14:30:41 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Sep 2023 14:30:40 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230928101558.2594068-1-houtao@huaweicloud.com>
References: <20230928101558.2594068-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 29 Sep 2023 14:30:40 -0700
Message-ID: <CAJM55Z-Qkc5+BzwB3d_7OcSLt+1u_Cu37=suqW1scxiRDaynmg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Use kmalloc_size_roundup() to adjust size_index
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, houtao1@huawei.com, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Commit d52b59315bf5 ("bpf: Adjust size_index according to the value of
> KMALLOC_MIN_SIZE") uses KMALLOC_MIN_SIZE to adjust size_index, but as
> reported by Nathan, the adjustment is not enough, because
> __kmalloc_minalign() also decides the minimal alignment of slab object
> as shown in new_kmalloc_cache() and its value may be greater than
> KMALLOC_MIN_SIZE (e.g., 64 bytes vs 8 bytes under a riscv QEMU VM).
>
> Instead of invoking __kmalloc_minalign() in bpf subsystem to find the
> maximal alignment, just using kmalloc_size_roundup() directly to get the
> corresponding slab object size for each allocation size. If these two
> sizes are unmatched, adjust size_index to select a bpf_mem_cache with
> unit_size equal to the object_size of the underlying slab cache for the
> allocation size.

I applied this to 6.6-rc3 and it fixes the warning on my Nezha board (Allwinner
D1) and also boots fine on my VisionFive 2 (JH7110) which didn't show the error
before. I didn't do any other testing beyond that though, but for basic boot
testing:

Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/bpf/20230914181407.GA1000274@dev-arch.thelio-3990X/
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/memalloc.c | 44 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 1c22b90e754a..06fbb5168482 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -958,37 +958,31 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
>  	return !ret ? NULL : ret + LLIST_NODE_SZ;
>  }
>
> -/* Most of the logic is taken from setup_kmalloc_cache_index_table() */
>  static __init int bpf_mem_cache_adjust_size(void)
>  {
> -	unsigned int size, index;
> +	unsigned int size;
>
> -	/* Normally KMALLOC_MIN_SIZE is 8-bytes, but it can be
> -	 * up-to 256-bytes.
> +	/* Adjusting the indexes in size_index() according to the object_size
> +	 * of underlying slab cache, so bpf_mem_alloc() will select a
> +	 * bpf_mem_cache with unit_size equal to the object_size of
> +	 * the underlying slab cache.
> +	 *
> +	 * The maximal value of KMALLOC_MIN_SIZE and __kmalloc_minalign() is
> +	 * 256-bytes, so only do adjustment for [8-bytes, 192-bytes].
>  	 */
> -	size = KMALLOC_MIN_SIZE;
> -	if (size <= 192)
> -		index = size_index[(size - 1) / 8];
> -	else
> -		index = fls(size - 1) - 1;
> -	for (size = 8; size < KMALLOC_MIN_SIZE && size <= 192; size += 8)
> -		size_index[(size - 1) / 8] = index;
> +	for (size = 192; size >= 8; size -= 8) {
> +		unsigned int kmalloc_size, index;
>
> -	/* The minimal alignment is 64-bytes, so disable 96-bytes cache and
> -	 * use 128-bytes cache instead.
> -	 */
> -	if (KMALLOC_MIN_SIZE >= 64) {
> -		index = size_index[(128 - 1) / 8];
> -		for (size = 64 + 8; size <= 96; size += 8)
> -			size_index[(size - 1) / 8] = index;
> -	}
> +		kmalloc_size = kmalloc_size_roundup(size);
> +		if (kmalloc_size == size)
> +			continue;
>
> -	/* The minimal alignment is 128-bytes, so disable 192-bytes cache and
> -	 * use 256-bytes cache instead.
> -	 */
> -	if (KMALLOC_MIN_SIZE >= 128) {
> -		index = fls(256 - 1) - 1;
> -		for (size = 128 + 8; size <= 192; size += 8)
> +		if (kmalloc_size <= 192)
> +			index = size_index[(kmalloc_size - 1) / 8];
> +		else
> +			index = fls(kmalloc_size - 1) - 1;
> +		/* Only overwrite if necessary */
> +		if (size_index[(size - 1) / 8] != index)
>  			size_index[(size - 1) / 8] = index;
>  	}
>


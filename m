Return-Path: <bpf+bounces-22745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE265868494
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9A71F22990
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3521350EC;
	Mon, 26 Feb 2024 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3yOn2aF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE7136644
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989716; cv=none; b=LNAzfrH0/MoJQ8CEKl6qS29ZSSVDIfi5cj38rSFI4pY30CHYYsjJihzrSHdfOxWxDQU+8ByqKPSrXdlcZlmhFRdhAaaoFkSrPy8cFoTUi59ZdcTUBjo/OAPTtZzhi41Pr5CqlVMK0MkFl+B0QN3TNYxkwjke49OqVCCNkggLJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989716; c=relaxed/simple;
	bh=63VUCTsdbNVV3tDtB+omVaSIJLkPyQ4+YO/ZyzgvHfE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pMe2CjZKMei9crQCawzIztWJJNpFNv2YtT0oJo8hkd6SlO/jGVBvCoZmDY5YLOjFGAH6oEQrSDGTT+va3b5QVYBVvrkFgPQm3aoljvBrU38K+SNrx9iz4mTW0nLBgX48YYHean8EQ+Q/AtlcVkvFRHsInfwUEkWNs9dDurbTLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3yOn2aF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3487833a12.3
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708989711; x=1709594511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bkM6YFUNeZU0ZlzY4wYAPOeEphgLdA/s3R6WSC004w=;
        b=m3yOn2aFX9/WtKZBV0ztSdF2IRGH4eKH/ALus52hzZMm2UhPA37jb9HfAhObRU/aNu
         MTB9CxspnrC+D6gwJZpuU9gG8xCUZWPXe9myiv1kMKLfnQxMXedsfegUzatrmfMfjaRe
         iwCdOtVBxudaWNpAsKOLzFlHZjT39e6GaCOHrH+1ht5aGKTCWfX+YMeCLXoudoKLUdXn
         4k6EwGSIm0MLLhOht7EjgeX2iLEo7cX25HOEM9r8J6ssBY/wBCjvhHGKlMI9olMMcggN
         mYdDxTgR78EtcUnf5ITmeZLu/ufoyc+SePx6MjfTRz+1GGy2ju9L+0KaXDj58rsACo7B
         Fqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708989711; x=1709594511;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4bkM6YFUNeZU0ZlzY4wYAPOeEphgLdA/s3R6WSC004w=;
        b=MsFh2KqGYklSsD6VdSoJrS3tt6DD7BmAEdj/x9lYZWj3MfDCnk0oTpdLila5LGCzmT
         MhWC6YJBcCfGz7OcYnH+DoW8fibidWFijy5po8IqxCzMYjyifPCy6YdoYaWogPkCu7F8
         0gYezv6wzgQP0xBpZ++Z0DwnmGLSxejUxGv8gwiGo40xMnIbdGwVESCznFnX5DKhfuOp
         euBIWnZOKR1jpRg+3bKV2KwK5c97kwXdOwygw8amXsiTn+f2us6l2svTkqCZcjs1elBy
         jfO96j5Qhdv/7t1ewtOvIv8qZTVT7M+Oz6E89iy41rCzFxTAdcjuHnYZjJtFErGzZLpe
         gwCg==
X-Gm-Message-State: AOJu0Yz2RmCLXq4lxxJ3dmCKmghUiT8AieATle4gxVnsgewGuDhuVte5
	iIBWTGac14fFV0O8EnOEo8ZJGgg4Yv1KP6iUCm0YnKWOHBxXriRhMd7vYzfg
X-Google-Smtp-Source: AGHT+IFBD3BxNTteRPkMDtbdXI9w5G2+7P9kLBYpKpzKIli7SWSmoBXP+wypXtEYIwaCBJ1WXGh1gA==
X-Received: by 2002:a17:903:1211:b0:1db:be98:e9a with SMTP id l17-20020a170903121100b001dbbe980e9amr10464190plh.26.1708989711140;
        Mon, 26 Feb 2024 15:21:51 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id g17-20020a170902c99100b001d9aa663282sm208920plc.266.2024.02.26.15.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:21:50 -0800 (PST)
Date: Mon, 26 Feb 2024 15:21:49 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 Yafang Shao <laoar.shao@gmail.com>
Message-ID: <65dd1d0d6e41b_20e0a208a9@john.notmuch>
In-Reply-To: <20240218114818.13585-2-laoar.shao@gmail.com>
References: <20240218114818.13585-1-laoar.shao@gmail.com>
 <20240218114818.13585-2-laoar.shao@gmail.com>
Subject: RE: [PATCH bpf-next 1/2] bpf: Add bits iterator
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yafang Shao wrote:
> Add three new kfuncs for the bits iterator:
> - bpf_iter_bits_new
>   Initialize a new bits iterator for a given memory area. Due to the
>   limitation of bpf memalloc, the max number of bits that can be iterated
>   over is limited to (4096 * 8).
> - bpf_iter_bits_next
>   Get the next bit in a bpf_iter_bits
> - bpf_iter_bits_destroy
>   Destroy a bpf_iter_bits
> 
> The bits iterator facilitates the iteration of the bits of a memory area,
> such as cpumask. It can be used in any context and on any address.

Just curious as I see more and a more kfuncs. Did you try to implement
this with existing BPF? The main trick looks to be to get an implementation
of FIND_NEXT_BIT? Without trying seems doable with one of the bpf loop
iterators?

Also this requires a bpf_iter_bits_new across every iteration of the
BPF program or anytime we need to pick up the changes. Any reason
we can't just read the memory directly?

Thanks,
John

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 93edf730d288..052f63891834 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>  
> +struct bpf_iter_bits {
> +	__u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_bits_kern {
> +	unsigned long *bits;
> +	u32 nr_bits;
> +	int bit;
> +} __aligned(8);
> +
> +/**
> + * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
> + * @it: The new bpf_iter_bits to be created
> + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated over
> + * @nr_bits: The number of bits to be iterated over. Due to the limitation of
> + * memalloc, it can't greater than (4096 * 8).
> + *
> + * This function initializes a new bpf_iter_bits structure for iterating over
> + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bits. It
> + * copy the data of the memory area to the newly created bpf_iter_bits @it for
> + * subsequent iteration operations.
> + *
> + * On success, 0 is returned. On failure, ERR is returned.
> + */
> +__bpf_kfunc int
> +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign, u32 nr_bits)
> +{
> +	struct bpf_iter_bits_kern *kit = (void *)it;
> +	u32 size = BITS_TO_BYTES(nr_bits);
> +	int err;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
> +		     __alignof__(struct bpf_iter_bits));
> +
> +	if (!unsafe_ptr__ign || !nr_bits) {
> +		kit->bits = NULL;
> +		return -EINVAL;
> +	}
> +
> +	kit->bits = bpf_mem_alloc(&bpf_global_ma, size);
> +	if (!kit->bits)
> +		return -ENOMEM;
> +
> +	err = bpf_probe_read_kernel_common(kit->bits, size, unsafe_ptr__ign);

Specifically, this why can't we iterate over unsafe_ptr__ign?

> +	if (err) {
> +		bpf_mem_free(&bpf_global_ma, kit->bits);
> +		kit->bits = NULL;
> +		return err;
> +	}
> +
> +	kit->nr_bits = nr_bits;
> +	kit->bit = -1;
> +	return 0;
> +}
> +
> +/**
> + * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
> + * @it: The bpf_iter_bits to be checked
> + *
> + * This function returns a pointer to a number representing the value of the
> + * next bit in the bits.
> + *
> + * If there are no further bit available, it returns NULL.
> + */
> +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> +{
> +	struct bpf_iter_bits_kern *kit = (void *)it;
> +	const unsigned long *bits = kit->bits;
> +	int bit;
> +
> +	if (!bits)
> +		return NULL;
> +
> +	bit = find_next_bit(bits, kit->nr_bits, kit->bit + 1);

Seems like this should be ok over unsafe memory as long as find_next_bit
is bounded?

> +	if (bit >= kit->nr_bits)
> +		return NULL;
> +
> +	kit->bit = bit;
> +	return &kit->bit;
> +}


Thanks for working on this looks useful to me.


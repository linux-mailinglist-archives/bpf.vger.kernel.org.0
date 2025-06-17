Return-Path: <bpf+bounces-60852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC98ADDD34
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6323A7E05
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2225485A;
	Tue, 17 Jun 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiXcT499"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC322EFDA7;
	Tue, 17 Jun 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192144; cv=none; b=FJ2F2f1DGEt/MMli63yuecnQXfOw71ty3J4BF4t1mj6TELvpi4evZAwFi1+HCWMoVmJ4iHLEmNKv4v6k+wPukeFp6spcrlp4cc4gbKKYHWXAo81osp7MgvTQAkJC76X2/agLagP/nvQpdp/4w1DFHeKMDgGO8EfVXpWDapmmtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192144; c=relaxed/simple;
	bh=834L2oUtc8IBHzlNjnTwizk/BR2t6HbuiPczq60jj7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKDH6Ofagayxm4gzs0Lvi4At6ipq7RttNtOJrN7PO4GO1QL544qDTp2H7efk8V2WIx3alySKoM/s9xDqkehoEC8SIXeHy70paeozKWHJZnIcJG+Yf4AISZWYfdDK3bD+wHyDlndTGqInyzTvfJWd2XZ0axrQ57i5dPzmRmCcvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiXcT499; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b1fd59851baso4056486a12.0;
        Tue, 17 Jun 2025 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750192142; x=1750796942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCFICuHIUq5TVb5nnUkEoI/+uU3rfH7JcqUPXwv9pFw=;
        b=EiXcT499iCHw1AXLuRpNh7eBUYCOT5L3YujTCwstKXijnXYCthf7lVmw8Fcx2oKV7K
         fx+oANK+U4b3W8YEY37u2RlJD2sedaVDDpjU/kAZmsjXVEjSE0wwSO82gU2b7scd29Yx
         nwAI4Zq7OCjHzGlLCgnoyupX7HwD/Vp/D49ENbHezaVKD2VcWpxuUAXxmUChRJXY3hva
         4I35KhEu0Y2iFl2Zs4wcLN9R9cLf7yNBd4oLMvUkrq5NSaLrDiMWeQnjWkHwH0r3o1Bi
         naxntSdP/KJR/9SiGpAODVj+e5Pi2wFvdSVMwtYennwvReBbhTfvTfmLQ9STHgmo1GXF
         1oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750192142; x=1750796942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCFICuHIUq5TVb5nnUkEoI/+uU3rfH7JcqUPXwv9pFw=;
        b=QXZxgfg82NOiAhtT6mc4yRV2QAfVFlrNHFIablec4K5T5/ZJZaQcze7p6ls/kePq1h
         THwLwBITab25YRwpAB5jKoZQNLAK7tMe9h0ROJe7y7nqC1teua4NHRL4AcMoLXox5j2F
         lRhULEsRWsNC6fXcPKSB0R2WavH4kD6KoJXnInDFLHf3+u4EIAu1Krn0dvfGegCqx04/
         iUJgkzr6e/3w1ukm8g8Aw/ewfSqnJdeuiIuVwaus8R8qHVPwmMgyxuUlttSQLai2nRrW
         CZfyHo4LYKVBtKv0JJ4gUGRCfHGpFXxiCbjQ/6nA7J8zfIGW3neLXzCXMbdi0G1TRjR5
         E2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTFhbxh9IIoQw/75L+UYVZy5ckhAOKULgv48PJOee0bl6ncb3N04p4RPImpd/PEkc9KR01iD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGfYQwsjDUi49QiWRaKC8M2H6Z8FHGYYaU84L7B4hAstytE/A
	TB7NFrdJrk23qAXXPMapLR3DyWT4FzgmVwiJj0wvuGsqXsgaRmAgnco=
X-Gm-Gg: ASbGncsJDMeEn6Qi9Hgus9530vfiXxVqLnPdHuZBvJUM0YVUz71whPH5BwGFRkax7Hm
	mEVYrAmY2JgIRrx4GLfpsam9G8RtRSmAc42ctT4vPWuMnyUDznePvnNJW3/2GajlNw1QQCtfIxE
	d2FbtTg2QTEBUFnYRQNNmlnDNUj22bIC/6gadJ0dPWb60rnqTpmH/E/1VonB91SAoypuFAaYAHV
	wRy965zyZHgXy+1HTrN75FE2i1nzcBU3ECYdkwoE4G5rYcC3mrog/Yegr1pucwsNRnWUDFVEEXE
	1dMdwObDM1FQa9GEfIZG4I5PzAbifVHCZBeWP3g04tMj/XqIE82MJ+dt9g8dJe1+wJ2+eqdkMMR
	Cej1Z6LKxfXZgWHDb9q7DnIk=
X-Google-Smtp-Source: AGHT+IFT4G5rDol98JGw6UhjlT4FfrtiidMnS3EkkWsOBeYKg3s/W/a7X+sngCQCAXbfez0oUlW+FA==
X-Received: by 2002:a17:90b:3148:b0:313:31ca:a69 with SMTP id 98e67ed59e1d1-313f1daa79emr26515744a91.18.1750192141944;
        Tue, 17 Jun 2025 13:29:01 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-313c1bdc49asm11171635a91.17.2025.06.17.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:29:01 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:29:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	martin.lau@linux.dev, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf-next] bpf: lru: adjust free target to avoid global
 table starvation
Message-ID: <aFHQDO9pJSCK0uq9@mini-arch>
References: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>
 <aFGoUWgo09Gfk-Dt@mini-arch>
 <6851cb4dcdae7_2f713f294e4@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6851cb4dcdae7_2f713f294e4@willemb.c.googlers.com.notmuch>

On 06/17, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > On 06/16, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > > 
> > > BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> > > map is full, due to percpu reservations and force shrink before
> > > neighbor stealing. Once a CPU is unable to borrow from the global map,
> > > it will once steal one elem from a neighbor and after that each time
> > > flush this one element to the global list and immediately recycle it.
> > > 
> > > Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> > > with 79 CPUs. CPU 79 will observe this behavior even while its
> > > neighbors hold 78 * 127 + 1 * 15 == 9921 free elements (99%).
> > > 
> > > CPUs need not be active concurrently. The issue can appear with
> > > affinity migration, e.g., irqbalance. Each CPU can reserve and then
> > > hold onto its 128 elements indefinitely.
> > > 
> > > Avoid global list exhaustion by limiting aggregate percpu caches to
> > > half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
> > > This change has no effect on sufficiently large tables.
> > 
> > The code and rationale look good to me!
> 
> Great :)
> 
> > There is also
> > Documentation/bpf/map_lru_hash_update.dot which mentions
> > LOCAL_FREE_TARGET, not sure if it's easy to convey these clamping
> > details in there? Or, instead, maybe expand on it in
> > Documentation/bpf/map_hash.rst?
> 
> Good catch. How about in the graph I replace LOCAL_FREE_TARGET by
> target_free and in map_hash.rst something like the following diff:
> 
>  - Attempt to use CPU-local state to batch operations
> -- Attempt to fetch free nodes from global lists
> +- Attempt to fetch ``target_free`` free nodes from global lists
>  - Attempt to pull any node from a global list and remove it from the hashmap
>  - Attempt to pull any node from any CPU's list and remove it from the hashmap
>  
> +The number of nodes to borrow from the global list in a batch, ``target_free``,
> +depends on the size of the map. Larger batch size reduces lock contention, but
> +may also exhaust the global structure. The value is computed at map init to
> +avoid exhaustion, by limiting aggregate reservation by all CPUs to half the map
> +size. Bounded by a minimum of 1 and maximum budget of 128 at a time.
> 
> Btw, there is also great documentation on
> https://docs.ebpf.io/linux/map-type/BPF_MAP_TYPE_LRU_HASH/. That had a
> small error in the order of those Attempt operations above that I
> fixed up this week. I'll also update the LOCAL_FREE_TARGET there.
> Since it explains the LRU mechanism well, should I link to it as well?

SG, yeah, let's do both (add info + link the doc), thanks!
 
> > This <size>/<nrcpu>/2 is a heuristic,
> > so maybe we can give some guidance on the recommended fill level for
> > small (size/nrcpu < 128) maps?
> 
> I don't know if we can suggest a size that works for all cases. It depends on
> factors like the number of CPUs that actively update the map and how tolerable
> prematurely removed elements are to the workload.

Makes sense!


Return-Path: <bpf+bounces-20605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D137B840A5F
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014B61C20400
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD24154441;
	Mon, 29 Jan 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NM1PbGMW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3415442B
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543088; cv=none; b=SQiWmr4+II22TH/GcE6TS1Odxt10Htjbp34sBNUSTwajlvML4HvsubTYhe/JcRMGDJPd6TRlJ4fdB2TKzdbopTEVDj6eJ3hnWFey2amKCAL7yijcHNMgMsb9FeVZJaH56SOp38GLxVkkpcOxERe7fLaVhMKMZ0r2WNzuas7v1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543088; c=relaxed/simple;
	bh=hc9w6fHB6GNc2uSOz6ErX7jduiBxLNfZzksxtRecrAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhPQo4Pqb/0ForNLhKFpMTUu6VOO+q3LlWsem+NiKlXH7G5XCFEB7gdr8Q7oCQrHwbSXffOeGJEFABDIiO85QCPXRypW9q1fav2yHKAAtzK+fy4DJcCCnI37Ww2Rl2YrClQsudP/SkFxm2NAFC84h70Nqq9m9uwvyFInPRJaKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NM1PbGMW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706543085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDC7vuXA9lRBLGT1HPb1LtCn5oK4rQZH3750GlIB9Gs=;
	b=NM1PbGMWyDJ2LBNaReZ0CfnxTUrhYqJ6n8BMiV7NJcuAlo2tecuckm8DF+k8hhe7zJa1Wq
	yo2dBEim86Mav9K+eNcbXeyETcPQZxCmNWltKwQu8gl4gHYbG6/I8HDIxqjtIljHOIZsK6
	R0D72lQK/5X4p6U4a5Hw0b87bZuBVTc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-yuE0X_-NPeO-7Ue3uWGNYA-1; Mon, 29 Jan 2024 10:44:44 -0500
X-MC-Unique: yuE0X_-NPeO-7Ue3uWGNYA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5101e82696bso2109995e87.0
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 07:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543082; x=1707147882;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDC7vuXA9lRBLGT1HPb1LtCn5oK4rQZH3750GlIB9Gs=;
        b=pxh1UFGw1ULGOgGjanTuI6M/rEL32gIoJAQOLMCswI1kCe6MalJiPzGfV9eilcbdcF
         UQtR7fdx3Xp4eKX0npUXMpnZ4NYJ+YQptSozjO9wJ+CVnRfrtAm9y0di2tWScO1DA4AV
         3yObMMVSQkgcwIXJ2hTTn1/9Wyb2zA/BLMpxI0XxAs9DgXPyFk8XKN1gsZqb6Nm7gmup
         HGC7UfdVKMLtb5rzrSWmKnb3EqyicYrc77fIWNrVKU9OK7xPjTd5pYOrNJ28ShXkD4qx
         8oAjddYWfFHLB7Z1RgslzRfkofUrjzxuo5/aIzRfTsYWDAbyebk5ra+HJoXHREC/btJ4
         rR6w==
X-Gm-Message-State: AOJu0YzmbHxCT1cQCu8X+H/SFL+aKWwO+y4qymyytCFMzhnD3JIUfUEk
	YnEbccPbqhSbBLB3lwOTfZ8DwP4Xdb/rD0dSZJA2vTgE+JykXGeKO1GbaezN4Nklm6sKOgY/Os9
	G0IpZk5BorSI7/Kz7V0IvC7pIkUWUlOWdP2wXKExQ1UsW2Wd6Xg==
X-Received: by 2002:ac2:5dd5:0:b0:50e:4fcb:dc28 with SMTP id x21-20020ac25dd5000000b0050e4fcbdc28mr3663347lfq.35.1706543082455;
        Mon, 29 Jan 2024 07:44:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXOf5GKJqQt9EEoWWWjHDzHTLeOkDX165FBk5E6e9jH/XuSgJ8s/voFvPCMEEQIIbYcaVbpw==
X-Received: by 2002:ac2:5dd5:0:b0:50e:4fcb:dc28 with SMTP id x21-20020ac25dd5000000b0050e4fcbdc28mr3663322lfq.35.1706543082105;
        Mon, 29 Jan 2024 07:44:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gy14-20020a170906f24e00b00a28f51adc39sm4048229ejb.61.2024.01.29.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:44:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 389A8108A04D; Mon, 29 Jan 2024 16:44:41 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
In-Reply-To: <ZbefjZvKUMtaCbm1@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <87jzns1f71.fsf@toke.dk> <ZbefjZvKUMtaCbm1@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jan 2024 16:44:41 +0100
Message-ID: <87bk9416vq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Introduce generic percpu page_pools allocator.
>> > Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
>> > in order to recycle the page in the page_pool "hot" cache if
>> > napi_pp_put_page() is running on the same cpu.
>> > This is a preliminary patch to add xdp multi-buff support for xdp running
>> > in generic mode.
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> >  include/net/page_pool/types.h |  3 +++
>> >  net/core/dev.c                | 40 +++++++++++++++++++++++++++++++++++
>> >  net/core/page_pool.c          | 23 ++++++++++++++++----
>> >  net/core/skbuff.c             |  5 +++--
>> >  4 files changed, 65 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>> > index 76481c465375..3828396ae60c 100644
>> > --- a/include/net/page_pool/types.h
>> > +++ b/include/net/page_pool/types.h
>> > @@ -128,6 +128,7 @@ struct page_pool_stats {
>> >  struct page_pool {
>> >  	struct page_pool_params_fast p;
>> >  
>> > +	int cpuid;
>> >  	bool has_init_callback;
>> >  
>> >  	long frag_users;
>> > @@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>> >  struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
>> >  				  unsigned int size, gfp_t gfp);
>> >  struct page_pool *page_pool_create(const struct page_pool_params *params);
>> > +struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
>> > +					  int cpuid);
>> >  
>> >  struct xdp_mem_info;
>> >  
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index cb2dab0feee0..bf9ec740b09a 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -153,6 +153,8 @@
>> >  #include <linux/prandom.h>
>> >  #include <linux/once_lite.h>
>> >  #include <net/netdev_rx_queue.h>
>> > +#include <net/page_pool/types.h>
>> > +#include <net/page_pool/helpers.h>
>> >  
>> >  #include "dev.h"
>> >  #include "net-sysfs.h"
>> > @@ -442,6 +444,8 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
>> >  DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>> >  EXPORT_PER_CPU_SYMBOL(softnet_data);
>> >  
>> > +DEFINE_PER_CPU_ALIGNED(struct page_pool *, page_pool);
>> 
>> I think we should come up with a better name than just "page_pool" for
>> this global var. In the code below it looks like it's a local variable
>> that's being referenced. Maybe "global_page_pool" or "system_page_pool"
>> or something along those lines?
>
> ack, I will fix it. system_page_pool seems better, agree?

Yeah, agreed :)

-Toke



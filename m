Return-Path: <bpf+bounces-20829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC4844314
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346691C21DF3
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A9128382;
	Wed, 31 Jan 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx1gY7cj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F731272BA
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715127; cv=none; b=AUKwqff2zF9+fwAIxL7QGnSe4ckxU6awdyKydE/Qb26RfyAsl0dqFbnt58xv7m1VYYVckaTFus5LdNg4Qm0DThY2TBF2U7I+A8llVl7ZqKHxsAYYNQqHP1Qc3Jz58e28BHl/uHwRmbiyFN9UnSuzvpAQOGpaXDKWG6zHGHf4Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715127; c=relaxed/simple;
	bh=7XG9+ZkiD/dg6Vc2IcOCrel6XfLZQXkSscP5YlJTJfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Es1K3jw6yIYR/Th6VDKX5pkK8Ijep+JqbA+TdNomMyPuBoRA30dCpI3+FTzHexi+FTfg9UGDWMXQTOVd5OBCB6hL4pkc+wAskdYhSfOamVzinEedOa3aL4nTiqAT6ZGpj/JtHaf/VDGkKRUO8FQDBuJPdbt948gXj/fs7DEGiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx1gY7cj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706715125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3OkKTKiI71jMccUTxGs7zx4mOX1sEJG3zIuh/sFpVs=;
	b=Gx1gY7cjwyuzbT1Zgptu/aEvWI1xd9xgBte1e/I7B7Br6gE+XWptGdfpGF60CkD766n0aC
	ken4gG7mJAjcbJrzi+JpKVKqtuudG/FH8IVNZ6A8T/SWfTSUTrmRUhqeLLBbsAyuIAwzL+
	t1VY2BpvfnOvEwhSdTW2QJgkJOh9CTc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-y9hrhdqrPkGcC1Sqm6owVA-1; Wed, 31 Jan 2024 10:32:03 -0500
X-MC-Unique: y9hrhdqrPkGcC1Sqm6owVA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e9e5c8f49so6011302e87.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715122; x=1707319922;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3OkKTKiI71jMccUTxGs7zx4mOX1sEJG3zIuh/sFpVs=;
        b=VKSugdXYGxIDU1Xoe5Q3vunLbys5McFz/6ztiDbAyRGG1O6jimFRuVF7rCGBFLI5Co
         1+hHF/U1ywqJgebfyO613oGTZ31HCgORnUFLe2COZD5vbb7GU2CYRXSsQ8jz+MTumQa6
         zAZLy3J2SxR4LGUCHzFHqhY6kLsihwfXFg71Q5TFBg9ZyAlb6kwnAHy1Lkln7scaNsFU
         A0NXHAmaGBlteXl+505VvHOjH11fDGiivHcyg5PXTYbaYZ1+FRSPia2DknvxKXE65xGG
         paBX+yhFvk8zUCpU7Mly5glym9gnQUpvgXFlWdjlR3VaJXHpVQfm7pOveETha9hlA6Pb
         kFiQ==
X-Gm-Message-State: AOJu0YwcemWPOgakzdl9TEWTS0Kvv67IeVAiwzW4k8e097at7AVqZ1FV
	fYGntkHASMKm5ZpnCHHmIkIH5bNVxQrCZMmEXY1kSZCqF9OgiD4J129tubfpX/hYm2PDD9HXVmf
	bNhfeP3gZVJC0BMfFfd8GIAbBrWvXhMRLiDTFEfKxecjidQBdQQ==
X-Received: by 2002:a19:ae07:0:b0:511:1775:5a1b with SMTP id f7-20020a19ae07000000b0051117755a1bmr1255702lfc.38.1706715121911;
        Wed, 31 Jan 2024 07:32:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEoECeHFUgDCVTi1EZbLxF3rcSnI5tI4RBiG/CN6lr6IBT71vYl6qATLy0AYB3nRjCTTojGg==
X-Received: by 2002:a19:ae07:0:b0:511:1775:5a1b with SMTP id f7-20020a19ae07000000b0051117755a1bmr1255688lfc.38.1706715121524;
        Wed, 31 Jan 2024 07:32:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSqw7KlB7u9EwhopF17qFeIsKqIfqqxmHRmuy5U1YTmyE09a1/IhP2Em06LF27Wb7m17/jhnBK3GS+ACzzu0pnI4Xd7BT6juzstQ3ySMRtwYTcBS35yaz8zZRNaIOF6ZEJeU7M+pBqKMvHf6pDOw1EzJ39bIbiIjdrkecKpm3raMWKDjghYSPU3qZATIhNUvKIqTzmHEjV3c9YR0kMPU8cMJOE9S933OPp79FFnyCc6J+Cht1qbR+tEw2qqpbjjYxatZ7Uw9v3pwdSLEMbpTBUMUOw2aGnDGZwcdDrZO8vHa6FBUVXvYIAEPPvCPAdiHyPYWfjpWwb+25QTb7qf4+crSAQwKjzyTraGq5RQumAmKVK/Udo7kQa+jMmHhdnhey/bFtNDxmbrEpq10VXcDBPzg==
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a3687cde34asm476328ejc.5.2024.01.31.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:32:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C466D108A4B2; Wed, 31 Jan 2024 16:32:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
In-Reply-To: <ZbkdblTwF19lBYbf@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
 <Zbj_Cb9oHRseTa3u@lore-desk>
 <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
 <ZbkdblTwF19lBYbf@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 31 Jan 2024 16:32:00 +0100
Message-ID: <877cjpzfgv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> 
>> 
>> On 30/01/2024 14.52, Lorenzo Bianconi wrote:
>> > > On 2024/1/29 21:07, Lorenzo Bianconi wrote:
>> > > > > On 2024/1/28 22:20, Lorenzo Bianconi wrote:
>> > > > > > Move page_pool stats allocation in page_pool_create routine and get rid
>> > > > > > of it for percpu page_pools.
>> > > > > 
>> > > > > Is there any reason why we do not need those kind stats for per cpu
>> > > > > page_pool?
>> > > > > 
>> > > > 
>> > > > IIRC discussing with Jakub, we decided to not support them since the pool is not
>> > > > associated to any net_device in this case.
>> > > 
>> > > It seems what jakub suggested is to 'extend netlink to dump unbound page pools'?
>> > 
>> > I do not have a strong opinion about it (since we do not have any use-case for
>> > it at the moment).
>> > In the case we want to support stats for per-cpu page_pools, I think we should
>> > not create a per-cpu recycle_stats pointer and add a page_pool_recycle_stats field
>> > in page_pool struct since otherwise we will endup with ncpu^2 copies, right?
>> > Do we want to support it now?
>> > 
>> > @Jakub, Jesper: what do you guys think?
>> > 
>> 
>> 
>> I do see an need for being able to access page_pool stats for all
>> page_pool's in the system.
>> And I do like Jakub's netlink based stats.
>
> ack from my side if you have some use-cases in mind.
> Some questions below:
> - can we assume ethtool will be used to report stats just for 'global'
>   page_pool (not per-cpu page_pool)?
> - can we assume netlink/yaml will be used to report per-cpu page_pool stats?
>
> I think in the current series we can fix the accounting part (in particular
> avoiding memory wasting) and then we will figure out how to report percpu
> page_pool stats through netlink/yaml. Agree?

Deferring the export API to a separate series after this is merged is
fine with me. In which case the *gathering* of statistics could also be
deferred (it's not really useful if it can't be exported).

-Toke



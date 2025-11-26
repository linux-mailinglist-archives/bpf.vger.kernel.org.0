Return-Path: <bpf+bounces-75563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22989C88E3E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 710B34E4412
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072F2EDD40;
	Wed, 26 Nov 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy3BemnR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD258309F02
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148493; cv=none; b=K9qQtZn84hg0Q1nsQQFwwWUu52hmqdSBvLZuTc+SwDBPXccznYQNXW84brmYGmnZWFq1hODBJyPpU1b2HBr8+0KRCrEmm0zQCloWexqxzrbZlinPZJ90Le5lni/sq1UMjUzcYm9j3MdWUWEtZrEbI3DPpY43Cb7LRxfrLwVSErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148493; c=relaxed/simple;
	bh=C7u5TaIFYxCrpu4dYTWLHkvOWIUo764ll9nIVkmUeUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyPlY4I4GyZQ1PCIbXquBNa6c4QXPe6pNQRLrRBURR1UjAVKX4wBjEVkqNE3jm0n5+/w3J6IzKRdnqaQh9b6SzTJ2vZ1D0miyZ533clNnLzN4T1qfsONPqYfev5oXs/BgNyp8CIEl+7UydVdegiKk/VPH5N7SWYVWhZ4qqTObnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy3BemnR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-794e300e20dso374715b3a.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764148491; x=1764753291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsAxxdgt6IXuSxrdWBozCg8XdMM7lBgDlsl70F68Y1Y=;
        b=Uy3BemnRhp93t3By2uJPWoAgD4iwm0ztHeTg4uNKLR3KLhfWjKaxtuEssCd6b9jHxl
         uXBlDm+ZEQtwbfCbhQvjfMa0MDuCJIXuJtLE3CYojhDjeX4p+TI+1Uav2gJT03IulEo7
         0lzeFgZFnKaq7Rf4+paJpbtf5S2NdewY5c6CIOnGWvluHH7E6rXjdFlXhK5peRtQWusR
         ylsf9OV3RlQZP5QOogfiPyaRy9nv8QS6vtggDEQIEtzNPDQMb8lCfaEAHlCvjFxV5UVy
         3AgRdbDazMiOxW/6G8mp420ryyFaWm0bxhmMeu3XGNREY/VXZkTZEJYHeCt+aQTDA/6Q
         g+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148491; x=1764753291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsAxxdgt6IXuSxrdWBozCg8XdMM7lBgDlsl70F68Y1Y=;
        b=qzuf1aacOuaKFK8BtJw2+20swAerE9yXxAyC1IFa6epQ3blH52wPU9LBATDGZhTWqU
         NnQk+L6G/n2uPK+dFh1vUzwTtlBJRtyHGloI0EFAq26FpDPG1GAdTwSSzZ8nnO8TgDp+
         w0FHBr7rgVGHVyOAXca3fbCUzIeKGQ6G1odnFxcnaPast7NjDK+t7QIfDpe9ZtGeNXm9
         lVtcNGaeyvhEEXITbpDfscY1BHrfHnW60ROaixwe6RcEIApWw/3R40xacR5dsF9+URd7
         p7M2o6vaBLLt2C5RNRvWtlOUReYaS/uff2MFrixAsbDrip6tTS6CB2aMqpTlImJsBUvO
         93fA==
X-Forwarded-Encrypted: i=1; AJvYcCXzvonKzBCh9TmzJDRtFdd9Do0zM90aNQTMCvPZ5Rz5DGUdNHSutKEmS9Qu+/9zkHCQxf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gbu0RkpJ+HTsslmygOTClsplSziM6+TvsVaOeNqul80wVasO
	54KxmicNBYNmtWUgvpZ3gDKh/psDX80rLVT6gq+jyaMULw8hSKwxGD7E
X-Gm-Gg: ASbGncuRtkQJDJFkvJm4tPYHN52QNVal9ei+jSvUfOBKpHNGFIU+FhvJ+bwZpNyu4NG
	B9GRUaYfvtvpNJpAQ4TxUdEdhU9AyMmiR/TYprdgZFXgwizgeDebPiN6bAqS2oBdGacVijYwZTE
	bWzU4UvjIJZ46TlcNA96TWDJ4rynfs5W1O0ruh0mk5GzRz4GAbPW0umQgewUn7mj1YNxGuXBnOk
	b4VGKsGm6dIXBHCEeT26I2h2YgxZ0BXvcJzyR0Y/Vi4L36N+9PdR89YTaYPsAFHllr/liBc2Pba
	mjmUXCv/m2RAmWNXTtdYpJOrkGV7XXhKaOFdx+yhVEhg9Tt/+G+lvaFokU/kndDIEKPcLes983D
	qI8mGntV8HfKhqaAMfU81MZ4nLSgGlUMGBIU08hDa1fccMM2k+sOK1VoTIrwf9jnBOxhGWcU/Ao
	Osiby2Ha8as+bdEQ+I+rE9/ZKyGvM8zw==
X-Google-Smtp-Source: AGHT+IGT8gd70TCQi63rsPWx+UIJ4mcNla5iKtS6p8pWOc51DUh5MCPHup9N3N3lGRYqyvIBZTUYDg==
X-Received: by 2002:a05:6a20:a114:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3614f5aec2cmr19183971637.30.1764148490926;
        Wed, 26 Nov 2025 01:14:50 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d849sm20690335b3a.14.2025.11.26.01.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:14:50 -0800 (PST)
Message-ID: <2da95607-9b21-4d21-8926-9463021a6f33@gmail.com>
Date: Wed, 26 Nov 2025 17:14:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "cem@kernel.org" <cem@kernel.org>
Cc: "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-7-ckulkarnilinux@gmail.com>
 <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
 <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/25 16:07, Chaitanya Kulkarni via Linux-f2fs-devel wrote:
> On 11/25/25 18:37, Yongpeng Yang wrote:
>>> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
>>> index 6917de832191..b6ffe4807a11 100644
>>> --- a/fs/xfs/xfs_discard.c
>>> +++ b/fs/xfs/xfs_discard.c
>>> @@ -108,7 +108,7 @@ xfs_discard_endio(
>>>     * list. We plug and chain the bios so that we only need a single
>>> completion
>>>     * call to clear all the busy extents once the discards are complete.
>>>     */
>>> -int
>>> +void
>>>    xfs_discard_extents(
>>>        struct xfs_mount    *mp,
>>>        struct xfs_busy_extents    *extents)
>>> @@ -116,7 +116,6 @@ xfs_discard_extents(
>>>        struct xfs_extent_busy    *busyp;
>>>        struct bio        *bio = NULL;
>>>        struct blk_plug        plug;
>>> -    int            error = 0;
>>>          blk_start_plug(&plug);
>>>        list_for_each_entry(busyp, &extents->extent_list, list) {
>>> @@ -126,18 +125,10 @@ xfs_discard_extents(
>>>              trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
>>>    -        error = __blkdev_issue_discard(btp->bt_bdev,
>>> +        __blkdev_issue_discard(btp->bt_bdev,
>>>                    xfs_gbno_to_daddr(xg, busyp->bno),
>>>                    XFS_FSB_TO_BB(mp, busyp->length),
>>>                    GFP_KERNEL, &bio);
>>
>> If blk_alloc_discard_bio() fails to allocate a bio inside
>> __blkdev_issue_discard(), this may lead to an invalid loop in
>> list_for_each_entry{}. Instead of using __blkdev_issue_discard(), how
>> about allocate and submit the discard bios explicitly in
>> list_for_each_entry{}?
>>
>> Yongpeng,
> 
> 
> Calling __blkdev_issue_discard() keeps managing all the bio with the
> appropriate GFP mask, so the semantics stay the same. You are just
> moving memory allocation to the caller and potentially looking at
> implementing retry on bio allocation failure.
> 
> The retry for discard bio memory allocation is not desired I think,
> since it's only a hint to the controller.

Agreed. I'm not trying to retry bio allocation inside the
list_for_each_entry{} loop. Instead, since blk_alloc_discard_bio()
returning NULL cannot reliably indicate whether the failure is due to
bio allocation failure, it could also be caused by 'bio_sects == 0', I'd
like to allocate the bio explicitly.

> 
> This patch is simply cleaning up dead error-handling branches at the
> callers no behavioral changes intended.
> 
> What maybe useful is to stop iterating once we fail to allocate the
> bio [1].
> 
> -ck
> 
> [1] Potential addition on the top of this to exit early in discard loop
>       on bio allocation failure.
> 
> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
> index b6ffe4807a11..1519f708bb79 100644
> --- a/fs/xfs/xfs_discard.c
> +++ b/fs/xfs/xfs_discard.c
> @@ -129,6 +129,13 @@ xfs_discard_extents(
>                                   xfs_gbno_to_daddr(xg, busyp->bno),
>                                   XFS_FSB_TO_BB(mp, busyp->length),
>                                   GFP_KERNEL, &bio);
> +               /*
> +                * We failed to allocate bio instead of continuing the loop
> +                * so it will lead to inconsistent discards to the disk
> +                * exit early and jump into xfs_discard_busy_clear().
> +                */
> +               if (!bio)
> +                       break;

I noticed that as long as XFS_FSB_TO_BB(mp, busyp->length) is greater
than 0 and there is no bio allocation failure, __blkdev_issue_discard()
will never return NULL. I'm not familiar with this part of the xfs, so
I'm not sure whether there are cases where 'XFS_FSB_TO_BB(mp,
busyp->length)' could be 0. If such cases do not exist, then
checking whether the bio is NULL should be sufficient.

Yongpeng,

>           }
>    
>           if (bio) {
> > If we keep looping after the first bio == NULL, the rest of the range is
> guaranteed to be inconsistent anyways, because every subsequent iteration
> will fall into one of three cases:
> 
> - The allocator keeps returning NULL, so none of the remaining LBAs receive
>     discard.
> - Rest of the allocator succeeds, but we’ve already skipped a chunk, leaving
>     a hole in the discard range.
> - We get intermittent successes, which produces alternating chunks of
>     discarded and undiscarded blocks.
> 
> In each of those scenarios, the disk ends up with a partially discarded
> range, so the correct fix is to break out of the loop immediately and
> proceed to xfs_discard_busy_clear() once the very first allocation fails.




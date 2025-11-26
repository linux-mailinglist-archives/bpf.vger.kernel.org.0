Return-Path: <bpf+bounces-75570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 914A9C8935C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35FEF4E3FD6
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871572FD1B0;
	Wed, 26 Nov 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKGA0L3B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CF270ED9
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152081; cv=none; b=EODQ3UTU/CZDU2ZE9GY+gTTe88lsSE68KUa3schyOfxG2ntHxEYpL0Iw3PttaIcpwZ+rvRFBHXAWO3HfgtbhHjzw9V1l/CtKUI8Uom8UfSRgWw5hGDLDMS5Qb40pZetHt4cxUVdPhwuwvqoN1m5Jkm2vTxeq8J2JZE9kQRwGUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152081; c=relaxed/simple;
	bh=J+H9DXT5OBV9m6l8dZrD5CNRbbY6UAu1yGdzlonCIWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezUeAP7u8eFykomY4lZO7Ia6CF18UE4IB8+dLDe4aj8HVIlkgxglIisEq0urimoik0cMFtn4ZQNFuwAuPZfUCeOxELYREQshi5EFTeti+6jhfOg3pXoDs1iNsPXjgw/TCee7LyVwn/nrtI6HUr2YaV9x9i+crML0EAHQYbiUHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKGA0L3B; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3410c86070dso5194470a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764152079; x=1764756879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=;
        b=WKGA0L3B057Gzll6INdvfCucFox8sUOKbK0/xptzAEm1CtM9N4d2y1HnTsntkU6aex
         QwULs9giNnQJgj0lLAwf6jb9TMdh8rhIrhxj2ZBk8VWIubRFMN5IEYLHsGExA7rqfoT8
         IqbcmzFzuRYhb3u54QqtQ/3Z3aGPoMznKVorGwct82G2lAihPCezhij3gzVE+Mm39slW
         89ipbSmYhJqZ4VVgA6mvg8+I2YnZnE9zqFEjiTglC8mrfX62oELo1kejbqZGdz1DnV4Z
         te5AyAaA4Xse9d9F332mXtoOz7T5uK74nTxGY0pae7my0MYBsMVTWhQRCSu902mvILRG
         vxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764152079; x=1764756879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=;
        b=ASugEUz8+nXvh2mgCml7eWB8xVyB+R4/cLXN1ohzY5PhEoxdefXqZCIKjwIPiKmDA+
         KM9zMeZ+lb9NxodGN2ZLtwGz4UfPyKNAzTjnDKcakVzzjUCWQDtnhckscaEL7Oo6lXmM
         bNjhzOyQo0n0EzVk6DUrW93nVItoUmmOBTqGZdph4wzRJGNqtK2R6ua+lliYCl7E0fYX
         CAJS1z+kXnP/SYYyhJTU8OmKuP3Y5hMhc5yzGVrljPaQuGq8YmHj51wTIqS9/JCKzJlq
         +plQ2D4svBanlm2vIapPGQEO32gStlDd8m9KNZs4kMHZZefqGzJQZ0vpOOLJIGrs5PGm
         YdLg==
X-Forwarded-Encrypted: i=1; AJvYcCVjIil6Awkw+HpWLyA50AIVu65wcRe49HDpbj7u99trIC6PX9QofVZws9gcUg+Jfn46Tgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzWnXQ3jugYakDMguDlrFxK8UuMRDA9l9uk5uJZ7IWn2bMESF
	THvA5i1cgU8mVs4IF8+cCyYN8CVtvyP3469YIYdXugmMNgixDXrDJXpU
X-Gm-Gg: ASbGncvwGnKt5s8qJM30Uz5uw1QdgU0/6pKgU0Xua4YpxFO0BCDQweHrL49L/LgWG0B
	1Z/crIUo4JGSJ3Kzsn/KDGDRlhN2igl49eTmtLfdYnNKCOZE4jmrd120Y3CVl6jjbSQlFGWMoy5
	MeaS/qZ9A3IaFKOO2FH6OA8JoTzdW/wLwHGUzIj5V2iDHAxrzrmOVKcgU6OuNRcJ4iMt9SWTu/N
	nc/l9HQGrVZ+LzNExLbT+ktkrmXSALujorY7HpzV59Z2lY8IfqBTqROT7Bk4L0ZXEEyaQb5+MAP
	HdJ/fIlbAZbp+xNS5A8et1OOm777HzzCzeJnCab/XCNeqjdFdVX6iFOjahQhcWpfIiArUC4ouWN
	5tHlR1ahlkbFqVUZ6+EghvwvrgxCtEMsHFSS6gtJanekRHNMnCmS6AmnqNeg1BhplXta82U1pQ1
	CQ4EDfrFKCiNy110lrQNp33TF4/tmgCQ==
X-Google-Smtp-Source: AGHT+IFQEabv4PNtolwpa8n5AuKpK1H58aTBlKZdu0dHQlwrZWrJMaYnh5FBOmSumqqz/nyBBS5z/A==
X-Received: by 2002:a17:90b:1c91:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-34733f3e84fmr16715848a91.34.1764152078789;
        Wed, 26 Nov 2025 02:14:38 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm20905512b3a.50.2025.11.26.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 02:14:38 -0800 (PST)
Message-ID: <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
Date: Wed, 26 Nov 2025 18:14:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 4/6] nvmet: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org
Cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-5-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251124234806.75216-5-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/25/25 07:48, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error checking
> in nvmet_bdev_discard_range() dead code.
> 
> Kill the function nvmet_bdev_discard_range() and call
> __blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
> since no error handling is needed anymore for __blkdev_issue_discard()
> call.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 8d246b8ca604..ca7731048940 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -362,29 +362,14 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
>   	return 0;
>   }
>   
> -static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
> -		struct nvme_dsm_range *range, struct bio **bio)
> -{
> -	struct nvmet_ns *ns = req->ns;
> -	int ret;
> -
> -	ret = __blkdev_issue_discard(ns->bdev,
> -			nvmet_lba_to_sect(ns, range->slba),
> -			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
> -			GFP_KERNEL, bio);
> -	if (ret && ret != -EOPNOTSUPP) {
> -		req->error_slba = le64_to_cpu(range->slba);
> -		return errno_to_nvme_status(req, ret);
> -	}
> -	return NVME_SC_SUCCESS;
> -}
> -
>   static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   {
> +	struct nvmet_ns *ns = req->ns;
>   	struct nvme_dsm_range range;
>   	struct bio *bio = NULL;
> +	sector_t nr_sects;
>   	int i;
> -	u16 status;
> +	u16 status = NVME_SC_SUCCESS;
>   
>   	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
>   		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
> @@ -392,9 +377,10 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   		if (status)
>   			break;
>   
> -		status = nvmet_bdev_discard_range(req, &range, &bio);
> -		if (status)
> -			break;
> +		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
> +		__blkdev_issue_discard(ns->bdev,
> +				nvmet_lba_to_sect(ns, range.slba), nr_sects,
> +				GFP_KERNEL, &bio);

We also need to check for memory allocation errors in
__blkdev_issue_discard(). However, this cannot be done by simply
checking if bio is NULL. Similar to the issue with xfs_discard_extents,
once __blkdev_issue_discard()->blk_alloc_discard_bio() succeeds once,
any subsequent memory allocation failures cannot be detected by checking
if bio is NULL.

Yongpeng,

>   	}
>   
>   	if (bio) {



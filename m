Return-Path: <bpf+bounces-75532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83DC87DCF
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BD833553E1
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5C30BF68;
	Wed, 26 Nov 2025 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4K8BnfB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2F800;
	Wed, 26 Nov 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125263; cv=none; b=dp/SEd4Cx7V5XI8fJT6qKNS5iyhjnNItXFtRyGRNn56ZX8I9XYqd5rt0f7jukUJxspuzwj8A5ZreRVLqc76pYLNWvBLJjHfO2dTQBawiZPPjidCsJc6nGN1YFV/KKwp2cAbOG+MkNDD5FEnvdfG3te/0WO28fSC7VKbTxViARj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125263; c=relaxed/simple;
	bh=1oNBzvNf2gAnqRUnior1QIt69ZATe3IeVffGuLQOlxw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vs5ekfHdJB+yD48P9aiKAYkQBxwRfdo0N3wFIS1shUR37tXGiHX+THRAe6DJwvcZYr80G25XlUL8pufaMpqrX4GKxZTCZAURkDGrvLNUtJSDSEfe2OzmBMFiPtNxSfVtf2WAvbX3Glt3181wohU7oWoh3TBh0H/hQJ4tWIKR98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4K8BnfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30622C4CEF1;
	Wed, 26 Nov 2025 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764125262;
	bh=1oNBzvNf2gAnqRUnior1QIt69ZATe3IeVffGuLQOlxw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=D4K8BnfBegX3TznlV3lhq2+xjh9BYEp+0UbR+3lwBOmuZUG9EK+QqAzB+IOe74JYg
	 Ai5MX7dXbkGB196M8hWzezrEbznSDh+eihzkL/4QobubgwlVZPcc20BnKt3l/pr5v3
	 o3NENGCan5q+u8n9+hmbYk3G5UzwFu2kOmhBYYtkcr1n/cMQMGAH68V5lKQh9NjTOO
	 jJx+PTorrzdDGTlHjeSqP5LkmMD+bV9vK3yGO/LXxAf+6HJXKaxNAlI8YZCBAzQ/Cu
	 VPahFm/SBiANIwY5Ue0zwbrgMmjACZSL4KvPf5z/fvM1mcXwZY9QtT+PfIHRjG8se/
	 ifIIBihadXhYg==
Message-ID: <09e48eba-6f00-455a-8299-8b8bb4122c7e@kernel.org>
Date: Wed, 26 Nov 2025 10:47:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 bpf@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, cem@kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 07:48, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error assignment
> in __submit_discard_cmd() dead code.
> 
> Initialize err to 0 and remove the error assignment from the
> __blkdev_issue_discard() call to err. Move fault injection code into
> already present if branch where err is set to -EIO.
> 
> This preserves the fault injection behavior while removing dead error
> handling.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  fs/f2fs/segment.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45eace879d7..22b736ec9c51 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  
>  		dc->di.len += len;
>  
> +		err = 0;
>  		if (time_to_inject(sbi, FAULT_DISCARD)) {
>  			err = -EIO;
> -		} else {
> -			err = __blkdev_issue_discard(bdev,
> -					SECTOR_FROM_BLOCK(start),
> -					SECTOR_FROM_BLOCK(len),
> -					GFP_NOFS, &bio);
> -		}
> -		if (err) {
>  			spin_lock_irqsave(&dc->lock, flags);
>  			if (dc->state == D_PARTIAL)
>  				dc->state = D_SUBMIT;
> @@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  			break;
>  		}
>  
> +		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
> +				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);

Oh, wait, bio can be NULL? Then below f2fs_bug_on() will trigger panic or warning.

Thanks,

>  		f2fs_bug_on(sbi, !bio);
>  
>  		/*



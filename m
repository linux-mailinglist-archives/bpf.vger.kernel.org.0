Return-Path: <bpf+bounces-75537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16060C87FF9
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 04:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C2694E5362
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6030E0FD;
	Wed, 26 Nov 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI/8poQl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B38F4A;
	Wed, 26 Nov 2025 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129516; cv=none; b=NCFpzGuMABtYKK3sfzve3f/QdGuniG+KyRLhgEH70xYzXxjXq6b3IzB3mKTYAQ62o56O4iqwdDyArRCh7imPkWvEdRE7tIYlzr2IkMZnehM54oeEToZj1PVnHh4HqTX0AXpLxvmhDtKveqG8eqQu3rTpnB+Ed8uBq3kIDte8+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129516; c=relaxed/simple;
	bh=KdLpd3BCuvaHXYnuSJAbmb1GBZZRwfUT2tS8l4PNC9s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M0ig14hUtEpqmtOcXyKKi3ZxjQOnYN6aVzHk2fMEgZVaGG/RQG0ggQtHevESHcspuVIzjEmeGIW8ox2Pp73D7O4zEGCP7fJxMpUHFYX39/oqa2CcT7eHvb/J6Qs3TyXwIjaeehs/WaA90XKPfdOkxpepL4rpbAZSj4FzTgSNLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI/8poQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09B0C113D0;
	Wed, 26 Nov 2025 03:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129515;
	bh=KdLpd3BCuvaHXYnuSJAbmb1GBZZRwfUT2tS8l4PNC9s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EI/8poQlKmZbCCoEeSJA01JZSZicswrBMCQ89iVxK+isXC/HcIMwn6Q1zvZv/jngg
	 Q9Usm8mf3V6RejWap0iav0EnrhYkC1NXND2m5cMEdSxUMndC5Ka78RidgwO5Mt2P4L
	 DTVLhROyox1pkRb5RDF/z6dQkoEq341p2F8d0zJxWlJYkBkMMknFQrce2Zy76Ptn9E
	 688f3CQxKN47semLWexiSKvInNtg9CQ4HA/vvwumRco7RjXp9lt5p8AlNCKswctOYq
	 t6g/Nbg5iYAJrVN29ePmnyKMCBQpV2L7mzZp5WREnyFEj/E4RGtxkac3Tqbqy9gpEA
	 BYOQQntNmr40A==
Message-ID: <9079ffb8-3b66-415f-bb2a-4d3f79dc9cb4@kernel.org>
Date: Wed, 26 Nov 2025 11:58:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "hch@lst.de" <hch@lst.de>, "song@kernel.org" <song@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, "cem@kernel.org" <cem@kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "yukuai@fnnas.com"
 <yukuai@fnnas.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "agk@redhat.com" <agk@redhat.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
 <09e48eba-6f00-455a-8299-8b8bb4122c7e@kernel.org>
 <820ffbc8-56cb-4f47-9112-2f4a79524025@nvidia.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <820ffbc8-56cb-4f47-9112-2f4a79524025@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 11:37, Chaitanya Kulkarni wrote:
> On 11/25/25 18:47, Chao Yu wrote:
>> On 11/25/25 07:48, Chaitanya Kulkarni wrote:
>>> __blkdev_issue_discard() always returns 0, making the error assignment
>>> in __submit_discard_cmd() dead code.
>>>
>>> Initialize err to 0 and remove the error assignment from the
>>> __blkdev_issue_discard() call to err. Move fault injection code into
>>> already present if branch where err is set to -EIO.
>>>
>>> This preserves the fault injection behavior while removing dead error
>>> handling.
>>>
>>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
>>> ---
>>>   fs/f2fs/segment.c | 10 +++-------
>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index b45eace879d7..22b736ec9c51 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>   
>>>   		dc->di.len += len;
>>>   
>>> +		err = 0;
>>>   		if (time_to_inject(sbi, FAULT_DISCARD)) {
>>>   			err = -EIO;
>>> -		} else {
>>> -			err = __blkdev_issue_discard(bdev,
>>> -					SECTOR_FROM_BLOCK(start),
>>> -					SECTOR_FROM_BLOCK(len),
>>> -					GFP_NOFS, &bio);
>>> -		}
>>> -		if (err) {
>>>   			spin_lock_irqsave(&dc->lock, flags);
>>>   			if (dc->state == D_PARTIAL)
>>>   				dc->state = D_SUBMIT;
>>> @@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>   			break;
>>>   		}
>>>   
>>> +		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
>>> +				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
>> Oh, wait, bio can be NULL? Then below f2fs_bug_on() will trigger panic or warning.
>>
>> Thanks,
> 
> That will happen without this patch also or not ?
> 
> Since __blkdev_issue_discard() is always returning 0 irrespective of bio
> is null or not.
> 
> The following condition in original code will only execute when err is set to
> -EIO and that will only happen when time_to_inject() -> true.
> Original call to __blkdev_issue_discard() without this patch will always
> return 0 even for bio == NULL after __blkdev_issue_discard().
> 
> This is what we are trying to fix so caller should not rely on
> __blkdev_issue_discard() return value  :-
> 
> 354                 if (err) {
> 1355                         spin_lock_irqsave(&dc->lock, flags);
> 1356                         if (dc->state == D_PARTIAL)
> 1357                                 dc->state = D_SUBMIT;
> 1358                         spin_unlock_irqrestore(&dc->lock, flags);
> 1359
> 1360                         break;
> 1361                 }
> 
> which will lead f2fs_bug_on() for bio == NULL even without this patch.
> 
> This patch is not changing exiting behavior, correct me if I'm wrong.

Yes, I think you're right, thanks for the explanation.

So it's fine to leave this cleanup patch as it is, and let's fix this bug in
a separated patch.

Thanks,

> 
> 
>>
>>>   		f2fs_bug_on(sbi, !bio);
>>>   
>>>   		/*
> 
> -ck
> 
> 



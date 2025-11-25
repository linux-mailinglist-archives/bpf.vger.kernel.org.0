Return-Path: <bpf+bounces-75489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C6C86BCF
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9773AFF7A
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30059224AF2;
	Tue, 25 Nov 2025 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlOgYsPb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6E2F692F
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097779; cv=none; b=i2nfQjY5ifkih+XgG5w2AqCLZDmgLtXc4SOiqtQgTSIWTQ2hvy8sxYKUsg/px/KTxyy4Lwqgbr7PDb3GgkUIAgEgXVpli38MFsHZrsNwUIDQD8BN80v/S90R2UqkCkmOw2gCV0r5/jHJ2CBSdoEBM8LAiFs9/oEzP6mTdB3hsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097779; c=relaxed/simple;
	bh=WhPVHCJW76FGJUYswsjQFNbMTK7L4YrF4FJlMHrzrPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW+shfXmw50fm1ZAgVErli09nYvVBUJDW1KE111YtFLf1zd8FMjmFqYyF96TonUs5XdvlxydrLOy3YvR6yBtw0GLB5My0KT0Cl33AKl8HNfozXuZgBZXSwVLRV9y5Ok+LX3qAUIYEN00TqUgJLzzFVRMvx8R9VtAOLUjjzOdwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlOgYsPb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297d4a56f97so87574595ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764097777; x=1764702577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqV4ea26VpNRnNDOYj3v3FWNR4t9iRrjXWCFY4hl9NI=;
        b=NlOgYsPbCXU9ejFGWz4GDe2nHBW8zxMR8CehaM3nG60xRZqeNQQXfZUlIRkmIFBfbZ
         mQWQbA7O+kmym/wi4PrFU4ZAQXNrFPiHsXlJhlk1uPhITqoDH67Zp22ytXmSmlj9tEPQ
         LC7BfDQV6eDnsK7dq9Lxu+YRLW9mOq9my6XatCYFQLcGdGlymd9YZzGwmUaNvMWAWTbK
         6RvmofRhZd5VLG/eYu7+akPmBR5qKQ8fqVjyxt27WJOmTtBQiL9ae51YLAA0Ax7zzv5+
         x9kobiSDBPcjegvtSyNJ7g64XdvF9FEjsRef9ExNv194OhegnXLgMN3m9EEuRX7VNDyQ
         PRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097777; x=1764702577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqV4ea26VpNRnNDOYj3v3FWNR4t9iRrjXWCFY4hl9NI=;
        b=fLSc6vBBy/uf3/nOmyspElVuXXc9SrkjNVMt5P1GC1xanpBZ+d48aYOaWhdet2S4bR
         ASshfwJXOHjfaBGRYRO6xzokczrZY237BqYsyD36IhAnVHoy2RN0TzzEwaYgWRMEB11F
         FfcJH96zJRzEj9DGnW5P1Zye0NWI7mC9C8tYu55exX2OskwFm8miyJXUJcF/4CCoGUCz
         up7cRPhZsopX7TPuCmFBHPlzHgX8Y2Itclu9zT0yUk1AtCrLHGSEL4HLFc0MwkE3NPSI
         r4if5VQWm76k5teuudGH/LCPodFChJRuuVzYQhCk/cPxqKZVWuGBVbWQ1w5yEaG/3BCR
         vhBg==
X-Forwarded-Encrypted: i=1; AJvYcCXcmM0k+99umjAz+ES+Xc+foOCtTp+oK1z/NQykhd+vDxja4WYo8N1CqPJiIH78P87FwGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7HcuOoRPSlBv2RAgpJVvCKsjUhIc0dilgrU+CkhfSyb4/FMO
	ecbVJ1XBSZU16aXPCWYD2rOl35virWh2sQOUzetmtOyMtjJM0WUocCQa
X-Gm-Gg: ASbGncsjIV4tIEfk/BiAN2msHEwuzYDzWwNx1fA4Z/co3DhPEdj7yzRyT/BnrASMIE2
	tcQvtMPynkDWEGNC83qjmgTfGQ0n1Lf29YY8K1+EOuS1hYEyLfGX2NsUo/2azTYPPyurHM+J+8G
	hdFXf6ERy9+Vp23wd31WRvJvjPVbsVxRJ/ba7y331JhnO3SmCcWZMj659EQWtku7saHLNvA6HD8
	03AB/L8tbR9JOZtKM1K7gzbLdJnqY7n2tuwlppmxntWKs5wE6QvAlGrKPQA7rL3bRDt9jkgr2Gu
	p/Jjmv6rp8HbEdCsyukMxFPyU+2kY78rwHbhvUOX/sjehYRnFGt3VyK/INy7s8Cm1HlhLToQbdp
	veaoXm0jbxX76NnfuLodA/Owo8ZV8UGpG7MtKEFQoxaG0HkVMM8Swzwyt+qR+UMaMdSMPWY6kFk
	5LpyLeNkbg6paK1X+9HcgYUqh20Qx5qqdUwTq12unUWQnghxop3zJ5gB1NfELeTFkb
X-Google-Smtp-Source: AGHT+IHuIf8IdstsNtTBrFtuIhxYayVPP9kbYzco+dRdLBQVBBJBvJGBn5Q65xamj5HkAzoQXFriDQ==
X-Received: by 2002:a17:903:2acb:b0:294:fc77:f021 with SMTP id d9443c01a7336-29b6c6b32f7mr194870325ad.49.1764097777372;
        Tue, 25 Nov 2025 11:09:37 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:a9c6:421a:26c5:f914? ([2600:8802:b00:9ce0:a9c6:421a:26c5:f914])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107cc2sm176518725ad.16.2025.11.25.11.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 11:09:37 -0800 (PST)
Message-ID: <851516d5-a5e8-47dd-82e0-3e34090e600d@gmail.com>
Date: Tue, 25 Nov 2025 11:09:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Jens Axboe <axboe@kernel.dk>, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org,
 cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
 <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 09:38, Jens Axboe wrote:
> On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
>> __blkdev_issue_discard() always returns 0, making the error check
>> in blkdev_issue_discard() dead code.
> Shouldn't it be a void instead then?
>
Yes, we have decided to clean up the callers first [1]. Once they are
merged safely, after rc1 I'll send a patch [2] to make it void since
it touches many different subsystems.

-ck

[1]
https://marc.info/?l=linux-block&m=176405170918235&w=2
https://marc.info/?l=dm-devel&m=176345232320530&w=2

[2]
 From abdf4d1863a02d4be816aaab9a789f44bfca568f Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date: Tue, 18 Nov 2025 10:35:58 -0800
Subject: [PATCH 6/6] block: change discar return type to  void

Now that all callers have been updated to not check the return value
of __blkdev_issue_discard(), change its return type from int to void
and remove the return 0 statement.

This completes the cleanup of dead error checking code around
__blkdev_issue_discard().

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
  block/blk-lib.c        | 3 +--
  include/linux/blkdev.h | 2 +-
  2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 19e0203cc18a..0a5f39325b2d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -60,7 +60,7 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
  	return bio;
  }
  
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+void __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
  {
  	struct bio *bio;
@@ -68,7 +68,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  	while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
  			gfp_mask)))
  		*biop = bio_chain_and_submit(*biop, bio);
-	return 0;
  }
  EXPORT_SYMBOL(__blkdev_issue_discard);
  
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f0ab02e0a673..b05c37d20b09 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1258,7 +1258,7 @@ extern void blk_io_schedule(void);
  
  int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp_mask);
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+void __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
  		sector_t nr_sects, gfp_t gfp);
-- 
2.40.0



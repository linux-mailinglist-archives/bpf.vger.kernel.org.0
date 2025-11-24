Return-Path: <bpf+bounces-75306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D6C7ED55
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 03:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA6A74E1A2C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E829ACD8;
	Mon, 24 Nov 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es3r2e5j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F594296BBA
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763953068; cv=none; b=W2sIqHC7MZki6muZDgLqwPjDKGwvf5l15iObAtsCilSgPfWr9owxcpec+9kMjijzovadWm6bKmaQ8WC2g8Lk1p6084Wm7dKVsQCqJjN7qXrG9UVG4EhBIgauPnIIaewiLzEurS8pRfgDyoK6hNZhaqlaSDkGsJqk3O9V/2tNoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763953068; c=relaxed/simple;
	bh=W39EvEsOKZnDPgVc3vjL1URC280/rs9OxMSKpDWz+C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fF5a6aFRJHiK85qyFNGOqd4V+xK8+uF8PPiTfkUu4Nzj1fCICJ/iLbJ2oIqOjuL4el0HZMVCDgpaGpQPv3aaGMIunV2iK1yapxAuqoyPjyOQFc78nd7lQplvonhFe47HG9YQTTz8b5Prucod3XrFVAHBGp5R4oJZcmDcdVawUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es3r2e5j; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo4384814b3a.2
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953064; x=1764557864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkWhYF4f1lhsSHEbmYsrWUEDoM/XD4r0C+XpnxkiI8c=;
        b=es3r2e5jxI9XJcfPMggIH8P8nNDiDjsJ0Me9LddzgHyb1i3TMSJtaOT3/jRq3q83mZ
         O5R7VNra46ae/nXXcqHGRvbakFLvXVvWpqHttaumyNkJLv4Zb+XqcrO9csRKskEcZyrv
         zhSoSAEjliIrWF/OsSQq/t/1hosJJam+Butbg/YZhSj6E8yc6gSq1lWWg4Cw3sBgkg1M
         0we5vkxSFzU1RmteCbQwkMDswnkYpujwZsa6/YCxINQBoGxFgr5FFGrfPMRUG/vSjZ0o
         ASgA9iSHxvsS2dFmSUo1PjqiW7Utmp9ZrcYM66hXfsmuMnrQrO8uuH6nB0cm7EDVLIdt
         ImsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953064; x=1764557864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RkWhYF4f1lhsSHEbmYsrWUEDoM/XD4r0C+XpnxkiI8c=;
        b=jjpRVcsc4fKa/6uoIUJ4lzSz7wSFIdnZh6VAMewLZwuc7rW5P+PvbBEvoKh+B/yja+
         FdNa/oV4RPDZ7EVqJTs9sdoMeD8GaRjVdcWfm1+75bNY0WfSPPn2niaTV+1dAsVAiV5J
         Qk84F/wFhCXyNmkCoXkK3+BUjJilrVOOYcUax3tX7azYJUyNAcnUhN+oolp5s7a4byc3
         iiComa/S9RGNBsyLMWelXMrTCMED+uKAsYODZDF55yE/kj7Lms4/tVMYJLJSA44rfqps
         rQUsUK2/KcbTl7YcCKjQJmfhDom46kFa56csZDDu9NmidRvC2s1JcRvB0gHMOc5V2cCF
         /COg==
X-Forwarded-Encrypted: i=1; AJvYcCXqLKM8x5UYb03N8BMX628qHxQ/F28jKJSpJ7kmWG2V7TEiFvAx9XhXiO606Wsn4WHwkbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4sFZi9merjAeOrzC4/N6yVdsdviNp7z5OctuSa797aGIw+of
	5XEDhI6ze64DUHSedf9fzGxeRls0w5JCkdTIsG3WcBN+m6pJh/W4T2CV
X-Gm-Gg: ASbGncsbsVNw9bQS4oLLr5M4LB2RFFwt17JrdKmM5M3AQLg18ZIw+GbJn8Violy7vDl
	GPTXZWj7OnkxIuaJ5obYxl/H9Veg4u8Dad7VLKkbk238CvN4dmlyI0TwDZ+4XvkkeGZFv/HalJH
	t7/AX/6BiGKJN5CUdUvAZgbHiUNOW9LDRm0rQRbyBTfcyjJ6AO96z7f4Lw+cEqqmzuOnX22ffey
	42XH8eyZ7EDPnSOxGAQDy8ZZOT2TmXJlAK6V7Zz5RmJrKcXxnUfvych2ygaXaNOc9A/d6NjEKwV
	ahDL3qjf3Uaw71C4T3fmY3CBligFI2Ny4Cguoundh473giH1ZNCIuBI4Jgy/uoAVk3widWmEYuJ
	qt7ob9w696tkGVrGwbEbW0kdfgRHL9v5B1To1PBkDrMNZRbO/+0hbcR4YCG97LaIxSNveLL2HuN
	9+uvCcVvhM2yXkDfs21rrtfQEiinXqmghSOiEbHEwkuajtzSI=
X-Google-Smtp-Source: AGHT+IH2vl9a4qHa0wFFFsUNbzMzey1IZwx6tJlzdt+jREZgI3T8WYYR2vo3qAu15ZJ2v/Ev109wPg==
X-Received: by 2002:a05:701b:2803:b0:11b:2138:476a with SMTP id a92af1059eb24-11c9d8539eamr4726588c88.27.1763953064432;
        Sun, 23 Nov 2025 18:57:44 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm65938624c88.10.2025.11.23.18.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:44 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 1/5] block: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:33 -0800
Message-Id: <20251124025737.203571-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__blkdev_issue_discard() always returns 0, making the error check
in blkdev_issue_discard() dead code.

In function blkdev_issue_discard() initialize ret = 0, remove ret
assignment from __blkdev_issue_discard(), rely on bio == NULL check to
call submit_bio_wait(), preserve submit_bio_wait() error handling, and
preserve -EOPNOTSUPP to 0 mapping.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 block/blk-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3030a772d3aa..19e0203cc18a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -87,11 +87,11 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct bio *bio = NULL;
 	struct blk_plug plug;
-	int ret;
+	int ret = 0;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
-	if (!ret && bio) {
+	__blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
-- 
2.40.0



Return-Path: <bpf+bounces-75405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D2C82DDB
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B16A834BE9E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7E2FD67C;
	Mon, 24 Nov 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyRvwB0P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE22D6E66
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028105; cv=none; b=u8hExsWO6srOYKZAcNrTOzo2Z5uc4bbtiPYYWu29Y40m/79c6tBv5hGrZFBMnnhk9KXnZDrRFcgGfZpjpVomlZcnFBlymkBPk1LNC17RxKBK22mb534Uhxvq5U1JRattsewW0SfzTCHyWHGfKLSaCgSiwUt4feTlrLPdR3aqR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028105; c=relaxed/simple;
	bh=O/JUDf1xQdyUKKqPMxOm/ySwho1/juV+ixb/yhr4OcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDboGCFA8WNoq4/K/fXZIZEUcHLP4J7T521TRshimn8F+YiIeahwSEcF8UB6bBopkjT1oNTRGYTnY9rzW2ypO7DNcNXJ6ogHXXRPvR7ysybY8nQYAqHhAuDF0lPlM3j9MffvNjnevpQhD8L4cqitX+biFL8mqbris4tcOHZaaMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyRvwB0P; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343684a06b2so4906938a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028103; x=1764632903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=;
        b=fyRvwB0PwJyRFVMmj9BwngRdyh1FxB+k80U4l3kSgDZisjLtKwedeBZ3WsHlXzv4LW
         smguUguTqO4ye5EUVlnlvpwehhBTfYAqQ/x5sNJHqkipIoz1rFFOO/xvS/2DbnpZKGWU
         NT7VSCuaOqINYCuFj77EXlZa539ZIvO0qNkghSekpJ5G0ksAQiFu5ykpDGTAVN31tJfk
         64rRkgLXr7NPb8V3l2WHWDXRrJhsD4fRRbJez9GqQhUbppDygfJEiz8/8/j6tRnC4bcU
         2SvXeNYZLlS+Zu8IJeuLKXeJkDs+fSU0LrJknD6fbkf69ZraKuFmm52FKSe5bUPXEgYv
         Qv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028103; x=1764632903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=;
        b=k0wnpZSRo1Gl8WWPHQrrHJEGpnWQqqFA6XF9mMGaAsKmgSAVwt8umrU6tJ5YvHRr4Q
         80DbSVGoBImeF4aMm9usa/kI6btLdAID4MoYFwWYTz67dg9AEm110Rehpf/NyM1VDMWQ
         QTYe8HAFzl5FzUU5Ubf28wFgRSoJF7re3qtINmvpIrCoCCOeOfvDh9OLqM5HTf2u3zAw
         569Q9qErBEO9khFwVQCPId8zk+hZQMJMrcU+DVOQfy+JwbA1aGG6kfhPNk3LZ1k5TXeE
         nnV3LpSvQS/i0hl3SGImpgHCRAwBYiVnOs5flvMakeJVxUaNJVSD0ruPG4DlvtF+sWgx
         QGtw==
X-Forwarded-Encrypted: i=1; AJvYcCVBPUNNdeuCRxj4eFPWCgpQIQsMNMGPnyAUkmpPoolPCo5gWARo3M6WCOeKNsjBjjV4TJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RSoWj7Zbl19IN6T5gQW5YB9RS2QcULvSIDxv7PAgwwPEEG91
	HyE0hfjXn4MHmbgC1ga9cO7M1VOzO16s+3W5tygr4nKT7nyBa0ay26a1
X-Gm-Gg: ASbGnctB6CNfo+boJAaCn2j0LZF1NdqlVm1aPHDcUGpVrDPubgeitcZzgpgxKFWU4nc
	i8Co9KylL/StpQ467NICRsNY4jjbyz7RXjqySxkNaRv5C3BjTkIQeY6S4sFXCfIsf+6qiLgdhS4
	PVkQLmfN/fESQ2ELia4aMvqdrQOiLOK4i8zD9D9X91m9c3vFuiOLDF7Z4x3KFE6nVK8vFdf5Z+Q
	Wd4zUWxyWGoWFa5CwVZCWL9H75doSENhL2VoqBRcqiyZS0CTnLAyp7RVSkQQchvkiKWOTWfYS1o
	9JrcIkLDu6k+Uai4k7+Tdau4Os46zGm4FVSfV3Ze3YDAvhW9E49utFJXmc29/kPUyZit56tCB7N
	G48WOjXzsSbZw+WkJHlvqCwZPcTfOiJqH+ni3KO3PtV5rUiih5qva95aW2vePFvMwsYXxQaCeq2
	eiZVLUlAphfh93LPIFNqOm13JtXwL+o5lG/emX3k2T0Vm31zE=
X-Google-Smtp-Source: AGHT+IH9F80PvdpBpbojg7Y02KngkDHXsfXBdGLUzofDSvSvFO71NKJ3uHp3bN/w9c26If04NsQEQQ==
X-Received: by 2002:a05:7022:d45:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-11c9d863a0amr6183635c88.35.1764028102624;
        Mon, 24 Nov 2025 15:48:22 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm72215056c88.0.2025.11.24.15.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:22 -0800 (PST)
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
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V3 1/6] block: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:01 -0800
Message-Id: <20251124234806.75216-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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



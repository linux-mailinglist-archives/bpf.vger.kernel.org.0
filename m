Return-Path: <bpf+bounces-75408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075CC82E29
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42AE3B0008
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C5335079;
	Mon, 24 Nov 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1p+HPxt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4669335073
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028111; cv=none; b=CRT/8vl8eRdZ5QcZYsmlSnNcR2WhpV4gV9crq1ooDKGllhYrtLNpWMRXu23y18oNQflLvd8PAdgHwjc6zOfwkiMzr02ORpUfIcSWdHeV7Eigh680l7JIAWBGDQhP/ID916TewWEzPfr8fJX/zC0K127Li1YtejwHJxL5g2Rc9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028111; c=relaxed/simple;
	bh=Am7Xg6QJV818HftQaQoJheIX+hzBGkDxL1hHod2VREY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH65WDOhWDUGJIzJSyq1t3NPY6mfPD8oYdZyhgYdSZpDq0SPAQT3rlqKXnFHP4srKPcedMshCL6KmjPyKMuITtJhu/lsRU5ua8in0a0CELo4oyYjYf9XRArwMZorAwrYj/6sZ32dvOsRAq3vLmMnBiNarb6AB9PQY4d+wDnfJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1p+HPxt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b75e366866so2205685b3a.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028108; x=1764632908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=;
        b=j1p+HPxtmEJXq1utE07WkQkG5flpsDtFoeQM2jUrBDC6qKWM1nLMeIlhSLC9+NpIYi
         n4/q62g+t8PqkUImUcZdYWQ9E+IqnqzXK8BOc4daG66olSGcgd8vESZhU183lgbFGWLw
         bJzyz8FQm1wBtTjkNmWGsBwkrAjSUYPQOuyRvgnuslbcOXS8E7wf8QMGnFn9hXpPg2Uf
         B7kaMI0ZMw6Nc8ClKDSeJUBWafnApBQlQ8Lb1HDdWYiWqtk5yUaH3XIBnavJX/JbYKOZ
         yIoeSjOpsBKfdDTkwXA5EHzUnajxEViGSyFL297Yd+gPgWO5Zs6qAg3Wa4VWJ2hkvR42
         32SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028108; x=1764632908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=;
        b=pUvy18MJAoRAU1dRhsBmbDkWxBDFmOfx0S2E0gZKYFNR/SNLGD/2oZl7XTW072cn1h
         optV6ttfjKPcxQeVXXrnrBilixjGVp17qAFshjGeUiGAAgBlD9btMjRPU9UQ8go1onfP
         h9AoOPTc9xUCgB3jATdBgHAoJRp1s76BSehtpK1PO0h6Q1Gn1ehnyAWicSXLBQlvjqdb
         mhv9AmEFpUp7xp1HR27884yPwG/H3tWpJgmeKGGmvhW04nUlkPW5I3/Su1MGRiKzRwuL
         4ugiDkgHiTDGormW5IPDEYsYQN/DLILk1n9ptfzXIlzS/F6nKgUMLxodbq7GbOARIjKC
         ocgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAt4+WiA6twQ1FJWWGrWVtAG/hPlUaCHodzbSjCbAJxDu4RkT1p1EFE5MVK0iqg13ps/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6F1vEwfcxCf3dwRE+9yuctd8ypxkZhtmGPczovXdBGsluqkQb
	I9niobAJ+eHB1CL4+WsEpV7C+DW0CgdI111zO6ItZcVFKCdsm8TZb20W
X-Gm-Gg: ASbGnctbiULP6dyQfQhNVAwOQbRd98yHQxJk0YvM90SLFUUnzDYBVEMUm0wgztvzx9W
	Gpi8Sa4ysoOHmQdKPutOlc2OJb4R1y86DCKPEFsrsU+gL380RMZu4CG/B2XcNc3KE6xjgLQrr+W
	9jS4/frV6Jwl1Gzy9Ovne157DJ6bov6rchmBUjrxnQrROttmVSokdy3AjWbg04/dx6oisILTPVe
	aMkddh9/8q32FSbAJIQwlfsO92Zxy80w4OEUp1wwgy98G7Bo/6EzEtQcmuDEBEWaCRE1TkN5jMU
	qZhnJm9XNKwL3x/ranX/vFiYKYmrBbaU8f8dnlQZWN2xty6EXE3d25SqAEzHag4TjxjwyOG7sVc
	+EUCYB6iBH4wxYdntlTD91eU/sXpby7E9sofKOVA4HSBXGNNaFCHDrqRDx2VPTWmfaYia3evc3D
	a9LrVNNJNR4qdEAYo9j/ikixknVHo5i7j9Oc3f16SF9qd0jO0=
X-Google-Smtp-Source: AGHT+IFryzmc/XiOW9LSO9isjtYB1LRYx6LJmKSX/rJnv82E/9f71NMvnHJMZsWalBLPhm0XU6n7Vg==
X-Received: by 2002:a05:7022:ec88:b0:119:e55a:9bf5 with SMTP id a92af1059eb24-11cb3ef2594mr558577c88.17.1764028108043;
        Mon, 24 Nov 2025 15:48:28 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm50934844c88.4.2025.11.24.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:27 -0800 (PST)
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
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 5/6] f2fs: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:05 -0800
Message-Id: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
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

__blkdev_issue_discard() always returns 0, making the error assignment
in __submit_discard_cmd() dead code.

Initialize err to 0 and remove the error assignment from the
__blkdev_issue_discard() call to err. Move fault injection code into
already present if branch where err is set to -EIO.

This preserves the fault injection behavior while removing dead error
handling.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/f2fs/segment.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..22b736ec9c51 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->di.len += len;
 
+		err = 0;
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			err = -EIO;
-		} else {
-			err = __blkdev_issue_discard(bdev,
-					SECTOR_FROM_BLOCK(start),
-					SECTOR_FROM_BLOCK(len),
-					GFP_NOFS, &bio);
-		}
-		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
 			if (dc->state == D_PARTIAL)
 				dc->state = D_SUBMIT;
@@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 		}
 
+		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
+				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);
 
 		/*
-- 
2.40.0



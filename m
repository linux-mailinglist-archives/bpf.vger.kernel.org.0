Return-Path: <bpf+bounces-75307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B530C7ED80
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 03:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6293A4E51
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774F29C321;
	Mon, 24 Nov 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yeo6oPz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A9298CB7
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763953069; cv=none; b=tavOwDTi7md/Sg3J6JyXa4tx5iWw4P89JBeHsflRIPmBaogeEvay/NyI5jefLvAqf7C/tMwRsPIHT9CmOeoTBI/IVfMYudjmMSc/y8Yu0GmhU1jUITU7ZfLDLwW8x9CyH+JjYlPon8KZh9xAlR0LjYEuHABMBsGLWXsx4Anp4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763953069; c=relaxed/simple;
	bh=2HTt3IkiR546p3idCOAeAAYwiLr2TwU90SfwMF9g4b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwtDq3lElsFpRsUnmGRNJSxodn9ZUoHPoCQN3cAZh357KAc/Bpo8uQB2f7pRbTLU7zhItGF4Ez8xb/ToQTZQXkYxkt90FExfouJiHfWzlOOD4kqTPclTSUHFjDogtUtUq4ipVg2BBjyzpArtJ7XedQWCjJytgIZL29Sr+Yhs0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yeo6oPz5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b98a619f020so3045123a12.2
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 18:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953066; x=1764557866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v5MRSjdziMsNVvfMkn8flY57vC+Pu/WImeTNAJo+ww=;
        b=Yeo6oPz584vBtJ6zPEdZMLt7QUMuLgPNXUpBZWa4vqP5bhFW6ju30vZxyUw8e+VSpT
         S+97vu6RoK8+qjTZcjTZdER0e5proYP/mbsKrW8RJpgN9JXG1bJOFdQoso4Na0wJBfZ7
         G2Q9fr7WhvVHWQSUuN0sZVze5DQ/08SZhH98mRLeJcMM8VjGVJoDEhXx7zAtCu9BJ4tc
         VnRelf7Hu8l/uL7c8pSKWXhE4OT9W2206sEzVECcVvP/Tz4u/Oho37s4OeN/RuFkrnSl
         rFUEFE4f9L1Md9walOzbYtdjtUf9LZhDZcVFO79oH1RQaDHzAMSBD+g01704RJGpWdti
         8B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953066; x=1764557866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4v5MRSjdziMsNVvfMkn8flY57vC+Pu/WImeTNAJo+ww=;
        b=PKsR0P0qDqdVA4fAQ3W6MgY5vPANUYKgcf7JMrfKV4p3kEOzvZ4iiinEO42gtds+/9
         247Ze3EQfG9vboaBwUphtdFwyZp9ZCWUyeApNW+UKZqhZUewljnvja9Gx4IoVttuCo9b
         iYu0xelqva9ZIiVUbRpMGNbh/Jdt/A4bdfpjLv9dFKKzSMO6hnvBDbo1d7r9KBhpSDDi
         W4VFx/yzUzlS1y4EXUe/KYw/M767bIFW3ZC+DS51e1F2w1Jo57trQJmB2SvKSBmIlPQI
         e+ovardS8yZjyk3sSEL7upDykDoXQfMTVbduccPAoyY+Z/Z+v22hb0xDTjF72ChuJoxg
         hh5A==
X-Forwarded-Encrypted: i=1; AJvYcCVni7CjhgBwzQl5m6fUNOE3MRbWLgDn4ZnPia0RsqmuRiw0VODul+Tge8xbIiJhwWlQ0Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuW8BMFOt5G6BOl0v389nlo0JOJGRM4dOpQv+dRM97ylr2GOFp
	CHO0Gpih3OnGuCOgBZovt4p/d/PdOukLVG5E/myJn+FjJ+UdO4WeXIls
X-Gm-Gg: ASbGncsWoCGN4fAXt2U7MATgl24oMuFUUI/gCr5crD+PazG9DQ+54bx1HHlqA80e6EJ
	hEkqrrLaEGIfZD/grMyRPgCFxGSzLCnfad2v3wNZhO54aL98G+u0tUavJM4pNi86mD5eXCbBJKJ
	1PsvQgzJKOtzwNNq2hpMILidMW1tEgy/tlqo8zkNBBMpyOU03D9nSHAANU+PSjnchCsPbWrePsN
	snzkavtPu/usmzUI/AbpbpjJYpHGo2DwPJCkmLk2YFTPEVKer6mu4A5iv+slbgyBqoRkjYZBWuu
	DEM90nthBKzkDwrJAjEh1VInbtMyU1+1N39AAfFZEL3pb3Jg+5OjeEtT0H7Yo1c2Bt/AVijQDOP
	j4fLbsrHBzxGGNZVcDwLKFlEs5Vq9N48MNCKZ2fxlRgSb0iL7lQuTCZRintCgJkLV2SWHTDzh4X
	CgIFEbNMrDhVRwhzzuC98yUSWgdapF742XH1pHznb/9UwZeXc=
X-Google-Smtp-Source: AGHT+IE2F0nLiNeIHq2g4zMVJnIfiBv34S3msVGeqkx0u3CUtdU5YuLkC01czcghjZ+E6ydM6GCvrQ==
X-Received: by 2002:a05:7022:6391:b0:11b:79f1:847 with SMTP id a92af1059eb24-11c9d712bd4mr5835461c88.12.1763953065943;
        Sun, 23 Nov 2025 18:57:45 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm43367228c88.4.2025.11.23.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:45 -0800 (PST)
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
Subject: [PATCH V2 2/5] dm: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:34 -0800
Message-Id: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
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

__blkdev_issue_discard() always returns 0, making all error checking
at call sites dead code.

For dm-thin change issue_discard() return type to void, in
passdown_double_checking_shared_status() remove the r assignment from
return value of the issue_discard(), for end_discard() hardcod value
of r to 0 that matches only value returned from
__blkdev_issue_discard().

md part is simplified to only check !discard_bio by ignoring the
__blkdev_issue_discard() value.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/dm-thin.c | 12 +++++-------
 drivers/md/md.c      |  4 ++--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index c84149ba4e38..77c76f75c85f 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -395,13 +395,13 @@ static void begin_discard(struct discard_op *op, struct thin_c *tc, struct bio *
 	op->bio = NULL;
 }
 
-static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
+static void issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
 {
 	struct thin_c *tc = op->tc;
 	sector_t s = block_to_sectors(tc->pool, data_b);
 	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
+	__blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
 }
 
 static void end_discard(struct discard_op *op, int r)
@@ -1113,9 +1113,7 @@ static void passdown_double_checking_shared_status(struct dm_thin_new_mapping *m
 				break;
 		}
 
-		r = issue_discard(&op, b, e);
-		if (r)
-			goto out;
+		issue_discard(&op, b, e);
 
 		b = e;
 	}
@@ -1188,8 +1186,8 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 		struct discard_op op;
 
 		begin_discard(&op, tc, discard_parent);
-		r = issue_discard(&op, m->data_block, data_end);
-		end_discard(&op, r);
+		issue_discard(&op, m->data_block, data_end);
+		end_discard(&op, 0);
 	}
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7b5c5967568f..aeb62df39828 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9132,8 +9132,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio);
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
-- 
2.40.0



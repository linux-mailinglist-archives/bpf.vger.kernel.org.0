Return-Path: <bpf+bounces-75406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A3C82DE4
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5294334BF6C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADE30EF9D;
	Mon, 24 Nov 2025 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb345Nfg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F12FABE7
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028107; cv=none; b=FKni3glkSdHCJy+9569fPfxb0UOfl3U+c2jNY0TA+C3TtNvhFIv5EvC863EPM3e4Ue7RuiR92n/j/rtaXNDRY/HPjHUUbSlEMCu4Gsfpvw+wu9gahBiYIHHpCufH3dk/UwelYouSGjiMAUoSZWFP6lODXAzJd2WTQ48gNeO2+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028107; c=relaxed/simple;
	bh=ZSqWbY8pVyhLaY6mUuy6f+COqFQf+G+FnHH6zSesNgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBIqpTyz1zweSBuIHxwY5VFzRBpbCgfagO2DSXmCS9hojoTduqpCs1KrTnq2QZvz2bA3B3aybT+hvfDurLgma7gUhzcNl3rH/fmrJA2RUZ24ZlyIeWqk7IWlq+WrJfFE0cQg5gOr8u/H8q+5zkAeT/eZix6qSHxdWtUaSE74d14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb345Nfg; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11b6bc976d6so6067021c88.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028104; x=1764632904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=;
        b=Qb345Nfgcp4/TxX2cohDRFWy4A7Z8bs6C7M20K9EPkPwIvIIqvJcVU5QcCx/pVLHI3
         +nhvatqStEz4oKY8azbMrTkKu3oSrZpEK5Ep0VUn2e2LA+//TqGUJQZ507mggj2l6Q8h
         2k2JC3xiaANHCMK93YTjPDulC/6vXvv/WCeAbIsdWXjd7eeVQs3amslApCRGHRF67apk
         mIDoYKUYSfblcY8ACgSg3xqpnfQ79aAxC/mH5xofaBHX61fKsqoUtGA44+Jfut+P3fn1
         ovfpu1tJJC1qqmeWtiozD/8WxYkFXA3pOrKSpv2x0jJJMl/7tfoY8LWsML2YZEJzoVfO
         F4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028104; x=1764632904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=;
        b=BRvXqedhBS+MmxMVPsy9WL583cJbRKWtIh2GAIPt4EByDOML3WcT5fR5FdJq5QCbeo
         rH/cRqS89XZC6YWq/DxrHWmalCXP7N1searGNd86qNwmSKdLFtvLsUWjWqY2TgwZdpPy
         rKmkOMVfgn9/RHVGMuWneuLj1xnZ/2rErXaEu1TfxQs51bsJ0lcdVMmdp0K5nSWekfKk
         w/xSGvFDkaY3kEco1Nf9We0qCUJQ17lW0KH8dap7Mmi4DWpDfD4sJjBBhogsvw0boN3h
         E6DROQR/LyY7CCbt/Yi4aUhEmmSVxzAj+RJrqI8DZt/uvrYU2LAnX7a/2jj2RBNsZsTq
         e98A==
X-Forwarded-Encrypted: i=1; AJvYcCVolz6VzDn6Qes3NZye6dJbFDAH9GYB70kl3qndoAugdB1BhQEHq937ch1YMYoE8nCgH7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjJQkI/rYbX9fW1uHwRh2M+1JKFhV1F274BtSmV4bjbkZZWR9
	NbnsK+ab8upyQGqqOWUN7qvKPzh61tlc1HIqGYs43cCyMhCLgtxUfDZ5
X-Gm-Gg: ASbGncvZSdfEkbUm4QMMIwiNvY8baq+hCignWd9EUThQRgFq1UbJ61ogA3PkQuFiSzY
	i/y/alB5LDFJmqJZEKUkMuuAYuNV8u2X1uElBhhk4ABeZTDnS9jVG7LJsths/5L8Aj/9y4Tqv8p
	QrtRjYWjxm69zxG6C+EvOZnBGaI0nC583EiR8U3i16gIvaGA/kdzzQSH5loPIiShUUkvPD1sFM/
	OteXzYumVXqGWUIETZfJdSSWWXVwnaLaLWgx8YzIF1Aho6yaLTpdtIF7V/Kr2KtKNa6R2jkS/oB
	0y9gHxsBKviepxeGqzvuXUF/eeByQvDjKQ1XYP285PaTMA9/2/MZLsJ5opEz4lBYXOve6LxaEt4
	Y9twtO3ZCJaJPgyxqWIPglDuMrV99zB+IWjFC44O8wMB7oxGWMpWCMLRlLJDGA6bWY1yM9ZyqLc
	np8hmqTceBDiGYOC7ytqsFENazWwxbeaPsxIZO+zwb3cO3Zxc=
X-Google-Smtp-Source: AGHT+IG0os1yUTB1U8y0wFQR2JhU9wfG8RKwx2eS9+a2sORTH4Ie8rtwmUzrvPIYkCFTBjjRJcm4Ew==
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id a92af1059eb24-11c9cabc4f0mr8878128c88.21.1764028103912;
        Mon, 24 Nov 2025 15:48:23 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm72215229c88.0.2025.11.24.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:23 -0800 (PST)
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
Subject: [PATCH V3 2/6] md: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:02 -0800
Message-Id: <20251124234806.75216-3-ckulkarnilinux@gmail.com>
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

__blkdev_issue_discard() always returns 0, making all error checking at
call sites dead code.

Simplify md to only check !discard_bio by ignoring the
__blkdev_issue_discard() value.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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



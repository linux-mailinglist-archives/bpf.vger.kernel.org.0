Return-Path: <bpf+bounces-75310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEECC7EDA6
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 03:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EF9F345843
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0507D29B8E8;
	Mon, 24 Nov 2025 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azIjdVI3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D429B8E0
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763953072; cv=none; b=Ylg6p5HeVMY6m+VbsPKWwwBaGg8Bqprv3WmVr8Wph1w4GMPEy2+KGwM9tpP/7V3bdClL5v0DGvsywhx7XeNc93jgvOpuZAheF4zf8ZxoSN6gTe8AoPKxRuJF4FXQkv5b9dx/9Ps2wKO31UPnKscOHZJkS0xXP6DzroRlaNx3XHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763953072; c=relaxed/simple;
	bh=1rxomFQWvF3IATN9kucOuHHGa2FB/YCgzDqnGWQM12I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBdfwADcVzRLNaNMMdsaVwPrAoqOuO4FiKx6dHCkguCo/++aU2RVSzu0ZSeLHS0CY0OPG4gTWrPH4wn/PdxTzGfWeK91suq7MHt14hUE5I5j4eapFko30Skq75UlHjdOpMPQVYcOwhgsXKZNKSrjMHx5rTmigH6cwnG7PPPeWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azIjdVI3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ba2450aba80so2173926a12.1
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953069; x=1764557869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A/o1KMdHnERZPkaP005IU3nW52A8GrE+BEL9651kiM=;
        b=azIjdVI34KdCDfW4btCpFmAICXA7gD8DN3FA10SiAzUACJZ146vWSjuI6oEtkye28F
         zJIhsxt3btUYjxbiupNX8VLujqiH7qQ2s9iaxtoHfHD/6jlG+sirrXUWQp5LF7PFoNSR
         sIipqOcsR9kEA9S+/+D2kRyJNdccpwTsNS1UIqzy0d43FO7DQ5t8DzqkICEBy8S/obNF
         5SO3ILAiFwWwKmiBuG5py/BU0pKzvRIlDoOclvB0EEnA4YPIlUU+TfO9j755NT5OzLAA
         ofABhdoKpj3fzVuWJtdCkZkLZYFw0fy25FF3M2Gj6hcbHEdCp28wEVQ95thYDK9TSo9H
         Mp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953069; x=1764557869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7A/o1KMdHnERZPkaP005IU3nW52A8GrE+BEL9651kiM=;
        b=uP7lq1ZjO14w9jRAnf2fUnQmdWETWrVtASrsl3poEsoLFjejGGyJqyqtHHj+E9ox1W
         kpXwChSdFUiyc4UNjSd+q2k6LmdIxLSiV1+PEIxUqQMc5uCZAu4EWJo6KLDWyQ9NZ+M+
         mYxiq9q+7TlT10KlKeMiKsZi7y7fLeQJDZmegY0/tw6lg4DCy9otFvGS1Y+AOD6XkwBZ
         t5LOWqJC5lsF+9SEfxjgkUi7GysAM6ig/khhDAMhRR/rGlshhTwXF7PFxwUpXmXXSyse
         /SbIQzW4rNsUmNqbY5mjHYewPJ5afmA1IpM1zPAnaTDJLbKWYOwmwI1yF8XfQk+D2OyX
         g1/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4Op5W7By9qSzBgEzW0hNu2o0bLkBjFW09ZWwTdOOjZ229JbwkvKw1egSsRBC+Pd7JbqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYv4C1zYsY/IATEpWs21fUUGDDVfUY2hZPg8HWafJAaGzvkc+W
	6qYERRxYJT1IMCkvpcfiajUX7ry9+ZDOSemjgxV2notVWmbQ2aX/neax
X-Gm-Gg: ASbGncuRtX2MhiAdFXwdszM9/0hjCgoLshsadHAC9S7KxdaIvADOkfsj0ccaLiP2ODR
	QfHPrh2EFWnyuEvCYSvpRYmLxBT4NzepftB1QO5Cuxu+PeHFSiEYuqD/+vYSZuJ2YDgY4IJ74ae
	n8LiE5Yh2dUprNtUqO4BGi3+OFcJocPT+caRXbbfYQ5bGSrxqksfz4wnaWuSIAkGcJyHlCmxmL0
	EYTITGh4ZAgTprRFQJeVQrWM6SG2QfafBOJ69p4mBrlUHyyhBYjLUeml1GaDAiz3gCTlnGDbyI0
	wnMLQy5IfpltTdVMYN96/uHrQo/HTC3B7vGi4cjsk2iuspx9pxEEIeGI7h+c4xULXPrqtfRdt/D
	a+oEWvjOWJHC9NT+7OHhxgZMYi+SPXM42Hv6o6U4GbwexNfMQtJSGiiNxQZGd3iFVGyZwD2eCsv
	aMR1BPfLLL2lMg4kUHG0RIZj0vtNzw1XINml2PKU5qtUcJNYk=
X-Google-Smtp-Source: AGHT+IEmMLANDAnmsBNCneTvCZSlRusetXy+m9HCywmHN66AM/499qf8PoyOZ4xW94y10CRf7NdkQA==
X-Received: by 2002:a05:7300:538c:b0:2a4:7cb9:b7da with SMTP id 5a478bee46e88-2a71927d85amr6563682eec.25.1763953068821;
        Sun, 23 Nov 2025 18:57:48 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm67532109eec.2.2025.11.23.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:48 -0800 (PST)
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
Subject: [PATCH V2 4/5] f2fs: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:36 -0800
Message-Id: <20251124025737.203571-5-ckulkarnilinux@gmail.com>
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

__blkdev_issue_discard() always returns 0, making the error assignment
in __submit_discard_cmd() dead code.

Initialize err to 0 and remove the error assignment from the
__blkdev_issue_discard() call tp err. Move fault injection code into
already present if branch where err is set to -EIO.

This preserves the fault injection behavior while removing dead error
handling.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/f2fs/segment.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..3dbcfb9067e9 100644
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
@@ -1360,6 +1354,10 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 		}
 
+		__blkdev_issue_discard(bdev,
+				SECTOR_FROM_BLOCK(start),
+				SECTOR_FROM_BLOCK(len),
+				GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);
 
 		/*
-- 
2.40.0



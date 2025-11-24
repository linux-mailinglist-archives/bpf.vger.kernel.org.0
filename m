Return-Path: <bpf+bounces-75407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB81AC82E0E
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCA4F4E8C66
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340333555C;
	Mon, 24 Nov 2025 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWk8Up6s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB082FC031
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028108; cv=none; b=SwrwpUDzHbsVRvaVZzpy1Io2RJeveKQemLXmJzKE1VIUyiVY/gXuN41DqApY/WfAWgkumo9Hdlrr5HQ1LB/p4MEjkN3vFIY+BeBdqou1zfgq9b0ms5ytHtqyIUaANw3oRQehuAldAPsJT6hgNtnFz9BtmQ5Qga/DfpLrcm/3t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028108; c=relaxed/simple;
	bh=LiJgbQPzVCy/nNKtdgxFtiNJpUa7IyMaSDSo31f8t5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbHyln55CEqw3dksK1oMLNNsgC+qsCRAqEGbTUA2oXoC9sqO6d9yV5v/18GVVCXSAuI137Blru1nsWv2fF/DaFH6t7CgGbl8ijpLr7zCG8GIN8+ieG+MKVZ2hnNyTRxCyPYvhFsAYIcyU6+9iuP3ES2I0K1Vlx7DF1CtsWOuznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWk8Up6s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298039e00c2so68051155ad.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028105; x=1764632905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5IpKKGvYwA44MA2SdIRqzoysh0eqDWrauHh/IuigN8=;
        b=QWk8Up6sn3lYBV/iB9lZxGmffbRvzawOFw5BgJ2PYx9NHD+dLKfyI3JTqNp513mBEV
         vrxwKhuZvodq3ta/8e4Xw5HFvIU3H7v0KYCuuUctkaSPfrE0kSCNUQgtQ+u9zI4mJNlR
         9JXIbL7tPP5otS/iH/1e1KJW/G0Fae76007IVjPvsLWohUyZ/1bqGEzeiRa5Sr5fu9S1
         6c2+gnEtNhBQpacrDuwF0WcYEIRDiSmoF3icXb3ZZUFcoh31hsAyvty0UVz/c3gHwQQh
         UpRwTviaUPAqYFlZrZd5CHzBVfcGHREOtF3zC0bY4WYeylVTQn3LlTzZSOnjHYrK0m0T
         TsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028105; x=1764632905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5IpKKGvYwA44MA2SdIRqzoysh0eqDWrauHh/IuigN8=;
        b=CGUxLV92oe2SJfWCRm0MzfU+gKGp3n0Go9QDPxyMxUzJmUQB6ubs8y3Aaoki9wjSMl
         zHBR+eEZyebUflgl+lRruv/DL4WtQ7cV+YDX+fCSV1om/RdgQXILVgs47rZ4DbxCaHNk
         +4GMIW2M2gbqE8wipLXDA5lIA8FMnXw0f3wbPL+XJ07xaP2xw6h5cwY+K5iea7PSLxCs
         TzH7GgZWueY1RpeysHTY5SpHEIT1quHwZU2Y0/zGNjDLV6d9lpj34ELnU7i+7zjSCBl1
         eMPUeZ5XnIOyyuoOa8Ld5TKr5raBQvuZDGZPcOMXkwsxKbM/jtQjA07mh70RNaTBbvyA
         xGzA==
X-Forwarded-Encrypted: i=1; AJvYcCXPN+vUU9b6BfAxYHCCEiwtM38acqHL4b1T8ExhUZEkkhdqPY7T7J6TF49Eubc7pkG1UYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMKRMpUCKpRvXa6GD0vTZSPRBUkzMwu5a8S+GwqvoOMsGhvHz
	N8KjH+7f41uPtOzS8+cAHA7RZ5eC6lMurHeqG1LTxfCU7KaBzucK3qZm
X-Gm-Gg: ASbGncuBkdPWJWiGTgL4fvSMvjscdZqyiMUB72ooOq+3as8+GwlldMAtfAeAe1BIYu2
	U9kP6sX7OR23yp1RwKBlcii22eeKjXCUhDatRz4wocMsaTU8fNGKWNJ5Ewa4cfbuf92GMv1wx4f
	E4Tj3MC5sHMMi0E5STfX1QfFiY+8rBuZm+TEB+TTZ5jUZqgFXahZPMg9laf8iETDcKcLrti7Hl9
	MlZkracZyGSdc5/57fAgIzAVh2PdwbFXMSLJsdpKO1R5H2gYuBhLZPt4+tFTF9JCHUF66pp0hJM
	ets4sMl+AEfMpNPGKu/5kcbByusaIDgYiTsWVGaxGze7PvMvob9v5k9JhNI/QO54KmaJOUjd1wr
	cYgHFTeMqKDwkKk7pnSyV28/4Hxf7566Kqs3r+t7Hcibj0HTbeqAVuuzhoq4HktAQLJXiS5eYfy
	bsdggK+hPIpI4KTWGj8/N4kvS1w/iCFxM4aGd0gy05s/xaSi9zRUtfhlAVMg==
X-Google-Smtp-Source: AGHT+IGUjnYuQU4uZ65RexnKMVsIkRo4SljblPDkF73f7cjoVp9uAJMvqcbsbNcZ8FiTC+XwEcc2Xg==
X-Received: by 2002:a05:7022:6610:b0:11b:9386:a37b with SMTP id a92af1059eb24-11c9d870ef7mr10566206c88.42.1764028105314;
        Mon, 24 Nov 2025 15:48:25 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm50934572c88.4.2025.11.24.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:25 -0800 (PST)
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
Subject: [PATCH V3 3/6] dm: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:03 -0800
Message-Id: <20251124234806.75216-4-ckulkarnilinux@gmail.com>
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

__blkdev_issue_discard() always returns 0, making all error checking
at call sites dead code.

For dm-thin change issue_discard() return type to void, in
passdown_double_checking_shared_status() remove the r assignment from
return value of the issue_discard(), for end_discard() hardcode value of 
r to 0 that matches only value returned from __blkdev_issue_discard().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/dm-thin.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

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
 
-- 
2.40.0



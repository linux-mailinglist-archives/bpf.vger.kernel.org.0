Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE35FC2C8
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJLJOH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJLJN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88370BC46D;
        Wed, 12 Oct 2022 02:13:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so23641413edj.0;
        Wed, 12 Oct 2022 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kW5MauxS98pwWXxx4M/kTdbKrwsWsdXlDypkIhrENA=;
        b=HC3zbbp+P9LikbMl5NHcR5Xlp2Jr32+oOCPK5NKcvSaEv+Hc8CB6hJ2v3zbeXI9HoE
         8hBRhgAHifaM9NDHaglA+LqT8c+gm24cFgKF6iyb6LHqlspso3/U1TyhZF1G4GtX4o71
         lbY/wC2Ko+RQa9krVsVe3qjv6eLyrstVkH/v1HXGIyqCQhmqXQvVy0qQA1GkjCzS/DfG
         WMP3ahZIxZqSGbgz5Iu6dAcWScOkT+mfYpLN78AcRfuvKFyp1WwaFCuhZnrRq1zUHmJN
         gddhem/P1u29YWHQaC+Cu1qDl8cYReIRaPET2HFgKQw+gHJYSM3pPlhamJTTT14PKh/l
         Y6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kW5MauxS98pwWXxx4M/kTdbKrwsWsdXlDypkIhrENA=;
        b=oRqw+Wv9iOjSQvk2HFn1hk05Lrf/Hg9PWnFobLfz50P0yDkdS770QoU2xnbBLniZLv
         O1VYq/c9bXFzBuziwdSU8WrMUupmTMFouxvDyIjwmwx5O9pesZrb/EpMTyzQEluEnOr6
         GSbipmJQRC8VaMdu5s4F1QXIj7T/d10wU1ZhUj0TQmFdvxy52WBaSnAp0XZet4v0C3QI
         X8XhSsyjofpsBeDSts04Nty7anEOyQtMl/R2dvxGMbjD2FaKFw+en9jRtjqHYAIKtobT
         pKs2yVX1dqXiSRTFkOy18L9wpd6gDmkQoqIjIEa5EbuvTm5xaamVXjmwXEWwIUUyFh7F
         arxw==
X-Gm-Message-State: ACrzQf2mfa4agCGOo18h/uEgLYLBBYXy7YbtkmzrjXYjGNycamQFV97S
        8Tp1OoRIZfbEBzVTycjANVQ=
X-Google-Smtp-Source: AMsMyM5ZzG8H5P8U3mM7yxBrerHruhHdjGDmY2mYKH037ZFXENct6Wq3iJID5vNgwKT4r1tIqshkDA==
X-Received: by 2002:a05:6402:1bc6:b0:45c:7611:d86e with SMTP id ch6-20020a0564021bc600b0045c7611d86emr7030281edb.194.1665566031975;
        Wed, 12 Oct 2022 02:13:51 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-81-193.retail.telecomitalia.it. [87.17.81.193])
        by smtp.gmail.com with ESMTPSA id lt2-20020a170906fa8200b00779cde476e4sm929649ejb.62.2022.10.12.02.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:13:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
Date:   Wed, 12 Oct 2022 11:13:56 +0200
Message-Id: <20221012091356.16632-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/cramfs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instead
of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/cramfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 61ccf7722fc3..c17cbba5d45e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -238,8 +238,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 		struct page *page = pages[i];
 
 		if (page) {
-			memcpy(data, kmap(page), PAGE_SIZE);
-			kunmap(page);
+			memcpy_from_page(data, page, 0, PAGE_SIZE);
 			put_page(page);
 		} else
 			memset(data, 0, PAGE_SIZE);
@@ -815,7 +814,7 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 
 	maxblock = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	bytes_filled = 0;
-	pgdata = kmap(page);
+	pgdata = kmap_local_page(page);
 
 	if (page->index < maxblock) {
 		struct super_block *sb = inode->i_sb;
@@ -903,13 +902,13 @@ static int cramfs_read_folio(struct file *file, struct folio *folio)
 
 	memset(pgdata + bytes_filled, 0, PAGE_SIZE - bytes_filled);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_local(pgdata);
 	SetPageUptodate(page);
 	unlock_page(page);
 	return 0;
 
 err:
-	kunmap(page);
+	kunmap_local(pgdata);
 	ClearPageUptodate(page);
 	SetPageError(page);
 	unlock_page(page);
-- 
2.37.3


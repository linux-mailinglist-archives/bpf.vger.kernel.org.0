Return-Path: <bpf+bounces-9698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F179C17F
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 03:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206AD1C20A9B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F7138C;
	Tue, 12 Sep 2023 01:14:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194E63E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 01:14:51 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1011DBC5C
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:14:50 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2be5e2a3c86so73510781fa.0
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694480988; x=1695085788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M16+2E8wcnDYfnBnujhnE2VKZFLJ7zKQf3q40r06mbo=;
        b=T6/QxCd6QWSKidzpEMJstiuMa60q+MMCV1O1WuksgEz2AmJlikL9tAi2iyN3VLo79G
         V398A7hfqFIcryLvicwPwyd07Y8/cRyu2zk7VOon5gRF6toU6yrL6nwOIxlpLzPFfYG3
         sxTxymMcCSUQmyd0gUryD7F6sAD06BxRVfy5Wx+FstJYOd4EL4E9JadhKc4A8Sjmc56y
         ATiEZCSRHcOYADVUaCahpxAE+MYLoK+EzBOYhlm8luHHJMj2U8wCTpruSqdw1ldfomdF
         he6Q91J57p84ANKg7CZEgLhym44qrNP9wIrPGS48Fi/QnBcDr2uTSI47DloZiPci4jXA
         EF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480988; x=1695085788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M16+2E8wcnDYfnBnujhnE2VKZFLJ7zKQf3q40r06mbo=;
        b=amcz6NPQt0gl7cH+ie1z5f9zKxw9u1Li7BK4KIda19YpEWuDmfXaLm3ac3CjlHLq0L
         aI+AsHBjrp3ocSSAsjoVjcXcaWl8Fd3r4xWfuPglTY01ZlgZtlZLvTEwVwwgwsUNvZyd
         j2loIZBALb9UGoQNhylqoRv0ow1oAMyNylqYwRtTUCbFIxy3LRmC87W4d5yplIWV1aPn
         fGJ2pl7xkQfdy5YTVv9Fz+xRE15y5Jx48lqInAMQXsrtzUwa5euYNGpq1to17gjMXkd0
         8wVykiMIo4i93BFmFNvdu5koOamEDoPPM9fuTiu7MLmjE+wSAJ5exqF7Y7MCu1KB8z8i
         p/KA==
X-Gm-Message-State: AOJu0YyD/oOsKASMoTrAd0h32lhuIkwYAfWWIeXQnbxTYSAtS6aIHkJv
	9hVBPOlvGLWh00BH5icEivi95xSzuBMvvg==
X-Google-Smtp-Source: AGHT+IF2epIA19NfMUZAHHndnKRj/aDisJDacGO6QonppTFVBI4dVLCAtVs5vpOP0jFOEk/umhLcug==
X-Received: by 2002:a17:906:8a77:b0:9a5:f038:a4c1 with SMTP id hy23-20020a1709068a7700b009a5f038a4c1mr1507888ejc.26.1694480210797;
        Mon, 11 Sep 2023 17:56:50 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gt33-20020a1709072da100b009ad854daea6sm272153ejc.132.2023.09.11.17.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 17:56:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sdf@google.com,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
Date: Tue, 12 Sep 2023 03:55:37 +0300
Message-ID: <20230912005539.2248244-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912005539.2248244-1-eddyz87@gmail.com>
References: <20230912005539.2248244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix for a bug observable under the following sequence of events:
1. Create a network device that does not support XDP offload.
2. Load a device bound XDP program with BPF_F_XDP_DEV_BOUND_ONLY flag
   (such programs are not offloaded).
3. Load a device bound XDP program with zero flags
   (such programs are offloaded).

At step (2) __bpf_prog_dev_bound_init() associates with device (1)
a dummy bpf_offload_netdev struct with .offdev field set to NULL.
At step (3) __bpf_prog_dev_bound_init() would reuse dummy struct
allocated at step (2).
However, downstream usage of the bpf_offload_netdev assumes that
.offdev field can't be NULL, e.g. in bpf_prog_offload_verifier_prep().

Adjust __bpf_prog_dev_bound_init() to require bpf_offload_netdev
with non-NULL .offdev for offloaded BPF programs.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3e4f2ec1af06..87d6693d8233 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -199,12 +199,14 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
 	offload->netdev = netdev;
 
 	ondev = bpf_offload_find_netdev(offload->netdev);
+	/* When program is offloaded require presence of "true"
+	 * bpf_offload_netdev, avoid the one created for !ondev case below.
+	 */
+	if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev)) {
+		err = -EINVAL;
+		goto err_free;
+	}
 	if (!ondev) {
-		if (bpf_prog_is_offloaded(prog->aux)) {
-			err = -EINVAL;
-			goto err_free;
-		}
-
 		/* When only binding to the device, explicitly
 		 * create an entry in the hashtable.
 		 */
-- 
2.41.0



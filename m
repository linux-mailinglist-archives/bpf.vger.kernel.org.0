Return-Path: <bpf+bounces-42523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A79A5399
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC321F21E28
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44418E028;
	Sun, 20 Oct 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jQ7WF2uL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04F1C6B8
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422264; cv=none; b=brcoJmh36dPFsln1q4h/sKGmjc5a+PDYcqrc6v2isAdazdMgrQjh+0T/PbO4RPoSyIx4gTuUkMnSMxLqjLbbNwv+nYK7vMRRAcsk/QIyot8jFEBFJj32phspwQh83n3iPcXYs+ZxN8gSMUe8hkpYKeav1aI+UWoiNmgyc+rYfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422264; c=relaxed/simple;
	bh=vbnyCZDPi0zxXqkZxpf3RXMi4uB9UNpHTfu0NnfuXGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9tkQvDN/Tj8st4d243wUS+rkBdrO0Ecj9cskpjB+HR0xmL0NApS9L2+Svdlr3LGR+ugY6IpykZeOeB5Fi1lBXrEA0tpMd5H1azIGaoD7sXjzWnEMVxbJYm7nameNfvfsxre5aVqV2yq+DAYH5AdtjQXW32cLGJGsjfGwBgHNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jQ7WF2uL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7ac83a98e5eso288707785a.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422261; x=1730027061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpCp30CARU+D+6JrWwiyU223m/ZLXiiJT/XtdCgb+VQ=;
        b=jQ7WF2uLUo2icgGhLvgIVvrRO5P7cvvVf5ulb400eHBT3XqxMvxDI2zW5A85TK+vlX
         8fFWvJxAgWPZM9uPqQOCqRe+AVcdIEesCvBlaM3/z6N0ezviEGuhyu97jmLnDKjrmKZN
         dexROWQreetjuBSM2EQdcNDYaL4C7m+79TUnInhRmE3oI0xmoi2waRqWxuHsVgbVi7+e
         q49GhdeVSNVdNBwNm8W19v0PgCatYcPIicuWaOBVLHgTK3ym5xzMxao8o8zLepbPOlLJ
         dKPyH49zIk8jrHwGZpsfyX7YYZmhIXESNQU316lriX9ugEE/32gU0s2djR3lHxx5ZglL
         eeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422261; x=1730027061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpCp30CARU+D+6JrWwiyU223m/ZLXiiJT/XtdCgb+VQ=;
        b=l8yKG8u/AKktoBkn5XRPqAfFHu8qDSwR6zW9vvbHGQPMKf9GuZYWbxd/mweQymXeuk
         Mc0zDeHWo8pg8d2Hef4pP6xoDiXcJvOARnnF58pMPdlgD0Wx6u8IJWSb0vK5NGfKIQ/Q
         DEkF8FcxP0iFCtqkEUZDJroytqCtX+sKnvwvVBySentnnQV+0BG0zkfbNo9yGa6AkaaL
         ahJjKkmolKIKZVCswBzuNmUhT7lbK6NQ86WGsfYlJ2a9DHUEQ+eB1J3qTZQzwutsRmy+
         RCfeKnyiEeSRNrPUQsk/yWdhX/QdRxWBEGcXIB3yhThUXxcry9eZQR8EqgXrvhWIn0Wa
         ofIg==
X-Gm-Message-State: AOJu0YyvtnkT8LLxR5K7Curv5VBEemGFQRrjOUP7LlwI1cpc120aBOmG
	aPxUzs8/aHEAsFt54JBTJxlF3U8WT/05cI4fsV/cbu7LcySivGVGzvVMbb9r03O/2IRdPzScoto
	4
X-Google-Smtp-Source: AGHT+IHr1ZfdD2gJ+Y+xR81kZMoSHdr4acx7tOmi09UC5YgF8jGfwO1b1UjOB3H7tPJCD7Oc1u//Qw==
X-Received: by 2002:a05:620a:46a2:b0:7b1:4762:8a with SMTP id af79cd13be357-7b14d4e46c9mr2053239885a.3.1729422261251;
        Sun, 20 Oct 2024 04:04:21 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:20 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf 3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
Date: Sun, 20 Oct 2024 11:03:40 +0000
Message-Id: <20241020110345.1468595-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241020110345.1468595-1-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

total_bytes in msg_loop_rx should also take push into account, otherwise
total_bytes will be a smaller value, which makes the msg_loop_rx end early.

Besides, total_bytes has already taken pop, so we don't need to subtract
some bytes from iov_buf in sendmsg_test. The additional subtraction may
make total_bytes a negative number, and msg_loop_rx will just end without
checking anything.

Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 1d59bed90d80..5f4558f1f004 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -606,8 +606,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		clock_gettime(CLOCK_MONOTONIC, &s->end);
 	} else {
+		float total_bytes, txmsg_pop_total, txmsg_push_total;
 		int slct, recvp = 0, recv, max_fd = fd;
-		float total_bytes, txmsg_pop_total;
 		int fd_flags = O_NONBLOCK;
 		struct timeval timeout;
 		unsigned char k = 0;
@@ -628,10 +628,14 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		total_bytes = (float)iov_length * (float)cnt;
 		if (!opt->sendpage)
 			total_bytes *= (float)iov_count;
-		if (txmsg_apply)
+		if (txmsg_apply) {
+			txmsg_push_total = txmsg_end_push * (total_bytes / txmsg_apply);
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
-		else
+		} else {
+			txmsg_push_total = txmsg_end_push * cnt;
 			txmsg_pop_total = txmsg_pop * cnt;
+		}
+		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
@@ -800,8 +804,6 @@ static int sendmsg_test(struct sockmap_options *opt)
 
 	rxpid = fork();
 	if (rxpid == 0) {
-		if (txmsg_pop || txmsg_start_pop)
-			iov_buf -= (txmsg_pop - txmsg_start_pop + 1);
 		if (opt->drop_expected || txmsg_ktls_skb_drop)
 			_exit(0);
 
-- 
2.20.1



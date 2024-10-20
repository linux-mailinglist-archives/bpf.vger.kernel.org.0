Return-Path: <bpf+bounces-42521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989449A5397
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FE3B211DD
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4937187560;
	Sun, 20 Oct 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PDu9mQk0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DA1C6B8
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422260; cv=none; b=s1RmY8RmNCTE3E58BwCaur99BRMwHC42hW1rJWIJyXG4DwtDjTdpf5KVgahvO9GIMY9fYBTmo545rNULnzao0vmXTcoHyOiFTGsJYEr9nAcmRk8uwQtQ7oueiYgBkxyrp1aELZlD86S3+haezpDJKPu3vhrpXJe7IUHr/Ib1nXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422260; c=relaxed/simple;
	bh=XTpMv+VF8cOdRbUAlZ5ZznC9z7BQObqwvKwaZgZ+cbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbLDdkhMBH7VgmuYnzVJM1AW+YzewF5WWkacBrs8j8bhoWz7gDQjkGozl3IZ5CpJi5ffjH2empLGiZYnnLm9NaNT15np0ihGdVbc0KSMB6k+INUNtoE/dlaa9nd+iQ/7eE3N504zd+QWH6qa3wLF++0KjHOWMbSQ/HczKd+xd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PDu9mQk0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb82317809so24862966d6.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422256; x=1730027056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sem2IxJaLw9T/IpmjkFV4In0NxMLK+X+ObaA09ucrMY=;
        b=PDu9mQk0oDD4WlrmkNt+ACJ6QYI1k/GzFOtdgV4I+NjYo6BVjR3kQ7gyVbtUmTHTrT
         U1xzDFOK65LDfiwMOUs+hjdyIxDCUh6jQbAk18u6sa6qMcdnutGuaqPKnwwo+6DFgoBk
         APHqNCkdHSGJYnrH6JxqigpgHCvcx3gBSyOzhXR68c4jwZsiRtjyU9+kPZBtVCWUHk7L
         2BlGogsI4XMA1FgYSkmgPHEV2K7k01gTHXxqigWl0JRjeK99wL3SuslDvprWwqCHIEGK
         fBZCM8fYbIEI3WNgEMiS66oFGnDcH82AkuihXUUAq0T6+AVf3ttpzBg2VZjl5qhF5UdB
         aalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422256; x=1730027056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sem2IxJaLw9T/IpmjkFV4In0NxMLK+X+ObaA09ucrMY=;
        b=IOaP7HxZKtF3nBS7XK5HB3SIH4cTTccla5g35ovKpxUZtxT0xZr4I15YZZV++If8jD
         Va1O3uTH0AiIH3GhjDYZB0aRaBW3byAtgET0EXAz4Ab2TilLZWaSK1dmDEI0s0Cdi9Rm
         kSzP7ZahhBwguWz7X6uoaphwlVS6kcbHM3uwtlmyPj9FQI+b5S7i+HAoJGoXC7eDQEv+
         FLBKJjy530ili09WQLZhRaOUQrey1GDHoIXdNlMP2Y0UHqxDK6IPcLETyUfwKENFnyxG
         Y5lJcLFc3JMqTJP+wMUwcG/WVe9TG1H4z56tZnDToN4IAr+19+15uDhgmm9/a/2RisxR
         FKEQ==
X-Gm-Message-State: AOJu0YxtE8vFvElnHind6LrBDxxt0PxePePXOkA47HjPAGCc4YIxtHxq
	kaxZo2yO/BdFsyznAgSQyEaIjqVxJ04gv99EfH+dcWIga8BROvSIv8GP+W3O2Za9v5gBU8GkNnS
	/
X-Google-Smtp-Source: AGHT+IF6+YByGgbPRWlbJ73+fFpp1ToHLFms00K5F02eMeKLvO2RpjTdPB903e80437zTYigtaT6AQ==
X-Received: by 2002:a05:6214:33c2:b0:6cd:3a48:5767 with SMTP id 6a1803df08f44-6cde151b8e9mr136733296d6.18.1729422255766;
        Sun, 20 Oct 2024 04:04:15 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:14 -0700 (PDT)
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
Subject: [PATCH bpf 1/8] selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
Date: Sun, 20 Oct 2024 11:03:38 +0000
Message-Id: <20241020110345.1468595-2-zijianzhang@bytedance.com>
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

Add txmsg_pass to test_txmsg_pull/push/pop. If txmsg_pass is missing,
tx_prog will be NULL, and no program will be attached to the sockmap.
As a result, pull/push/pop are never invoked.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 075c93ed143e..0f065273fde3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1596,11 +1596,13 @@ static void test_txmsg_cork_hangs(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic start/end */
+	txmsg_pass = 1;
 	txmsg_start = 1;
 	txmsg_end = 2;
 	test_send(opt, cgrp);
 
 	/* Test >4k pull */
+	txmsg_pass = 1;
 	txmsg_start = 4096;
 	txmsg_end = 9182;
 	test_send_large(opt, cgrp);
@@ -1629,11 +1631,13 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic pop */
+	txmsg_pass = 1;
 	txmsg_start_pop = 1;
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
 
 	/* Test pop with >4k */
+	txmsg_pass = 1;
 	txmsg_start_pop = 4096;
 	txmsg_pop = 4096;
 	test_send_large(opt, cgrp);
@@ -1662,11 +1666,13 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 {
 	/* Test basic push */
+	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 1;
 	test_send(opt, cgrp);
 
 	/* Test push 4kB >4k */
+	txmsg_pass = 1;
 	txmsg_start_push = 4096;
 	txmsg_end_push = 4096;
 	test_send_large(opt, cgrp);
@@ -1687,6 +1693,7 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
-- 
2.20.1



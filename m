Return-Path: <bpf+bounces-43084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C690C9AF35D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6882846E2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678C2003C3;
	Thu, 24 Oct 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VR51Lljd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865F1FC7FE
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800803; cv=none; b=OTWM7TncWOO5zSdsz9QJuGicp8FS4dmku+kRSIPIOxapMcdLgzMWR9FrIrXdjJ7XRv+XE779PeYmZL5clcL56l0JcBvVxMPd+TCvqYmT2e0U7UyjsUogKC1f20rlSQItMEyFvsflW8c6EEGW7tXp3L1AsHb40NWm0bmn42VC51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800803; c=relaxed/simple;
	bh=XTpMv+VF8cOdRbUAlZ5ZznC9z7BQObqwvKwaZgZ+cbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmN5NeJdGKiZCI5APmq7c/ct+l6dXkQVAeqAXkxX0SyDhEAr6o6dOU08yfMBdtsI2hU0PQzt+V1QzxEFwXg8vICcjKfUyWbqt6tmOzYqneJOk30oeUPeIFJFX+6jCyEndU/71HtTIoLq5wTBeMt+/3M+HmAMNIVIkOTH/7HZ8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VR51Lljd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b15416303aso86455185a.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800799; x=1730405599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sem2IxJaLw9T/IpmjkFV4In0NxMLK+X+ObaA09ucrMY=;
        b=VR51LljdIVTKbide2JrZyWUvtrZcPs76byXWaMBDwnyBoZlSRlTCqhTFI4BaFdN/Mv
         0K/0mL3Z50YkO6T8kMZwi5o2+amUUs0vpYaKFZU9UmMErX/3FK3NtQxqx+Mb00IWIZ9f
         2zD0THoeCRcPGDxnu25hjHswko6Y4tzYKIRqDeSqdq6g1myrtPyzWPR4khW2tjeEQTEb
         4zx6Z3Jc4K45W/6GS6yNd50YlFEWtsM7YRCyvu0oGnun1Phrz7M7RQiGsqJft5o2pikx
         SVWYCn3KM850+G3higecIRuZBWkzwXcCaVw6vPooxRQEfb2pjnCG7NIeyPJG+LajUlnY
         ZheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800799; x=1730405599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sem2IxJaLw9T/IpmjkFV4In0NxMLK+X+ObaA09ucrMY=;
        b=EoCvbaOBHw9/tNtyXKd75L6piwbNeOfzE7zz1mpA5xf/qHNxd1ncKrdAzHbv/qzL2a
         46GoxYbZqe+eBmEAMeYpqKNWSnJvHZXXWUQHKsuBpDNLw1TSi+9xJf6yY+l2QONAPbo1
         ZPzNAV+CTkYy/mL06FZfrp+z0ltj/5D7MPVCDElMlnphfRKd+FKPbS6t3aUs7hqnZ4rE
         AIgoDGthYhOC8jmlFhsNgDIhZ+or36t62xf7aDsnLb7Oi3CE/cfxK7jaFLEt7vqVdiLZ
         KPBgRi8CEG26Gf4Cpzm/UqAKz8gGCrqvnivgMhC0auNyVS+8hKQOQTAHf5Mxu58moPo8
         Vtiw==
X-Gm-Message-State: AOJu0Ywm55gX4UCmmb4r4tcQpOpJfsFqSr36Xp7vhNXWpc5yP8GdLm/F
	5/sV620JjnV9lHyCpJgmXaGlBD5Z+kDkzi3fU3HsD6/iLbrmx8LaS7CvI7EyNEw+jkeD7YO/qy1
	a
X-Google-Smtp-Source: AGHT+IHgzHo5DMf4DntM1vXreBcOxEAzqm1HxEDL99lbldhMAbxSM1gSrj85zqYqGaYP7UVtKEVIbg==
X-Received: by 2002:a05:620a:1793:b0:7a9:bc46:2d26 with SMTP id af79cd13be357-7b17e540493mr979266685a.13.1729800798790;
        Thu, 24 Oct 2024 13:13:18 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:18 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next/net 1/8] selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
Date: Thu, 24 Oct 2024 20:12:59 +0000
Message-Id: <20241024201306.3429177-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024201306.3429177-1-zijianzhang@bytedance.com>
References: <20241024201306.3429177-1-zijianzhang@bytedance.com>
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



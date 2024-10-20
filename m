Return-Path: <bpf+bounces-42525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22A99A539B
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E537B2134C
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82B18EFC1;
	Sun, 20 Oct 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XaVxe/E3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC61C6B8
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422271; cv=none; b=hK4Fb2W1jspjHacpw+RY152diLUCYRggSk2e5wcwpFGhsJlytKNK7KYyMZB/72+YdKNdikJmDuqiWNhi15X7LeUOjwnZVNh3uy0Y9c3xsMYagF236JZKNIfAdVE/4wfSWRWGVoN7Nn9DXQa67yBcBsUh1OsMuokamNPjJpaqEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422271; c=relaxed/simple;
	bh=XzjJ1kgr9qogiAQ273Sl4papScGSzlIxPbiDYvIV6wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mh6kGBJCfUkRlMAEPozuyiruNRtLetk+NDvBzLCVZBxBkqGMB8aoqXvhaDlMSzEEAuj4Iu/XIbdZdT1z/pTMhXoNdf8aPOM/XNeSR1RUVAUGHmuC97FdG5sv1VsE9aoPnlqUrJXuSqcbJH3HD6XNif5flhwyJrwypopMHqvgRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XaVxe/E3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so24727856d6.2
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422268; x=1730027068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHPkfNuTBPUIpsuetIE1UELY1k60fVDFIDgPf/g9e4Y=;
        b=XaVxe/E3SDkMPUb4jmrA7A2Vt6BdmAo0/G7R02uI5hR+GK9VMHzOv6NdiC5UOzngKN
         HbJCFXdzDWXJs5IhIN7C+Kw6Hw61UTaQRjeTK2qyvHkenRvyWwBrt7/QHjB38eZ2HW8y
         Dys30Hr9LPUQRA3VbfB6xTTZllSEyJJ0KJ5IJQIzvaSNZBc/tekxK+kg2e9om1REWH6u
         +4KlBNim6e868Mip1j4DSJWFHQHTQQpYRpCu/FzoeRXWIHM4teTQbpk151+rkgCp8EU9
         4T8v+T62eEXj6Ohn2V83TV+MfCcWl7LXeCUofuKd6cA07ugMRAIfGoxxc2r7Vzrpkd12
         sdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422268; x=1730027068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHPkfNuTBPUIpsuetIE1UELY1k60fVDFIDgPf/g9e4Y=;
        b=ilTlr9fK0pkfqcGEN35Tef//k2wHDiZfywXNs4rVsPRooTPyPtD5+PlD/Kk48qzFR0
         VJDcczdbfiKx0U93fxGHJXw1fmkcYISZ4U/fv9MNvrouWfyd99IHaHsUv0VKYUFllYwF
         8DU10qsJZzFFekXt8zpfsJwsGF4QZZqEoIV5/4Ihx7YQn7wsnFH5UnweMpFwDUwq62zf
         vEnzERLiJTiJ5NHocpKhHSpBRR7p9eC7u6ywqcQAjkIPYZ+SFIb2vq0amjgzt++8mqBm
         QmjFI0UO0792stieCuWHutnNJ5gPKzp2YYYPgCMPp5r82rGcdB7vWCbNgWTurbvWVtsc
         BWxA==
X-Gm-Message-State: AOJu0YyfjKaIVBt3Ev430T/C0Jrr4oR9bAilM44L9nJqgOSoN7CNPfyS
	+fYPhMN8tT6D/jiN4XtChcKhvqJvn0G+NFZw27DohoTyj8yuwQ9trc03Iq9oCokafXhvRdMQTFW
	1
X-Google-Smtp-Source: AGHT+IHDc7Nl5OiuDiciocG+1Gk+zLOH0J+ikyJ0/KSvjM6v6waduHysDLfcMjwaIhkmI56X328UQQ==
X-Received: by 2002:a05:6214:5b0e:b0:6cb:ff04:655f with SMTP id 6a1803df08f44-6cde15244f7mr148082536d6.22.1729422267744;
        Sun, 20 Oct 2024 04:04:27 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:26 -0700 (PDT)
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
Subject: [PATCH bpf 5/8] selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
Date: Sun, 20 Oct 2024 11:03:42 +0000
Message-Id: <20241020110345.1468595-6-zijianzhang@bytedance.com>
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

Add more tests for test_txmsg_push_pop in test_sockmap for stricter tests.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 61a747afcd05..e5c7ecbe57e3 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1795,12 +1795,49 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
 {
+	/* Test push/pop range overlapping */
 	txmsg_pass = 1;
 	txmsg_start_push = 1;
 	txmsg_end_push = 10;
 	txmsg_start_pop = 5;
 	txmsg_pop = 4;
 	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 16;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 4;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 5;
+	txmsg_end_push = 16;
+	txmsg_start_pop = 1;
+	txmsg_pop = 10;
+	test_send_large(opt, cgrp);
+
+	/* Test push/pop range non-overlapping */
+	txmsg_pass = 1;
+	txmsg_start_push = 1;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 16;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
+
+	txmsg_pass = 1;
+	txmsg_start_push = 16;
+	txmsg_end_push = 10;
+	txmsg_start_pop = 5;
+	txmsg_pop = 4;
+	test_send_large(opt, cgrp);
 }
 
 static void test_txmsg_apply(int cgrp, struct sockmap_options *opt)
-- 
2.20.1



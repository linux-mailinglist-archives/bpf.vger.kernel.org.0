Return-Path: <bpf+bounces-9159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55589790CBB
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835B71C20510
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBD524E;
	Sun,  3 Sep 2023 15:15:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A993FFA
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 15:15:42 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4CC11A
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:15:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a41031768so235845b3a.3
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693754107; x=1694358907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNbHWkKMSWF0MkfvOVW01X7N7A6c1TKJXXvSUMdDdlg=;
        b=COaisbThRbscR9cri0p7fhuo24HxHe4Avz4mrKAiUsA8H3BmzdqiK9KwabP6DyFNrT
         ucLvDzbDjTQHtJ0DI/os1ovRsgi6dYAvP92ixUTHJgHTbhu/NNJI5xCBDDOf+l6/15gH
         pEgX6rqV3zIlm3Yf7XvKX/IpEOWpYMCHwsAS25rOckykm7OtKonhaR3YFaAEJzsJk9Cv
         dkFdJmfAboaBiiSH5Dd8NLXYmw0s9Htco9d+1oAI0vklK6+/XfgCcV3UG+/LTPcKLW8R
         k+wFOMfbLFil+OBrou7Cl8JvSwgO+PTGHsnXF/G9c6hUmxWNs6BJFqnFLZsogkePM2kK
         QkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754107; x=1694358907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNbHWkKMSWF0MkfvOVW01X7N7A6c1TKJXXvSUMdDdlg=;
        b=Th62uHXqKHEQNhNDQOUo05mFIjWdM8lSYJ1OnJPkMZd7/wQn29DAkmf9uJicnwmTRJ
         nBafT+Srl/CVS6/qzY0LIT5qbqqTuOtx8/irVNxdwsqWgOZ6Frr/gBXt14jyzdJE9rep
         ryXQVVuiWuW7B6BtQYoluYxMTWSShPs0PEw6InDNFWtuRbqzTzpiubHYyMv8er2pt2LF
         JnA+ilrEaJNEID9d2c0KnOsWYhojJMOlRW642ailre5I1z5Pecnzb1hh0Z62IBVE+aqQ
         nW/R6VR2aAqW6gJsL7Styfebxw1UTxOCfwjb0Pvf240M5+2oiMp79Kww+Kv0FQ4QHcNG
         Sq4g==
X-Gm-Message-State: AOJu0Yx67VXaEvMQ7pqRZovhY/M3n32qjei6Aehd0UcYPwC/NH/Orouc
	q5odulVOziJZKPjdCBviZ+JKMB47/kI=
X-Google-Smtp-Source: AGHT+IGt8XdqS+wvtzrJ8CKK7WATg9dKqoe1MmcAOpSteCeQBrFCoLDKiknJZ5mNgsxOCGXvoFqdaQ==
X-Received: by 2002:a05:6a20:9493:b0:122:10f9:f635 with SMTP id hs19-20020a056a20949300b0012210f9f635mr6166972pzb.19.1693754106855;
        Sun, 03 Sep 2023 08:15:06 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id x17-20020aa784d1000000b00686940bfb77sm5882268pfn.71.2023.09.03.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:15:06 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	iii@linux.ibm.com,
	jakub@cloudflare.com,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v4 3/4] selftests/bpf: Correct map_fd to data_fd in tailcalls
Date: Sun,  3 Sep 2023 23:14:47 +0800
Message-ID: <20230903151448.61696-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903151448.61696-1-hffilwlqm@gmail.com>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Get and check data_fd. It should not to check map_fd again.

Fixes: 79d49ba048ec ("bpf, testing: Add various tail call test cases")
Fixes: 3b0379111197 ("selftests/bpf: Add tailcall_bpf2bpf tests")
Fixes: 5e0b0a4c52d3 ("selftests/bpf: Test tail call counting with bpf2bpf and data on stack")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 58fe2c586ed76..b20d7f77a5bce 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -274,7 +274,7 @@ static void test_tailcall_count(const char *which)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	i = 0;
@@ -355,7 +355,7 @@ static void test_tailcall_4(void)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
@@ -445,7 +445,7 @@ static void test_tailcall_5(void)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
@@ -634,7 +634,7 @@ static void test_tailcall_bpf2bpf_2(void)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	i = 0;
@@ -808,7 +808,7 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	i = 0;
@@ -872,7 +872,7 @@ static void test_tailcall_bpf2bpf_6(void)
 	ASSERT_EQ(topts.retval, 0, "tailcall retval");
 
 	data_fd = bpf_map__fd(obj->maps.bss);
-	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
+	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
 		goto out;
 
 	i = 0;
-- 
2.41.0



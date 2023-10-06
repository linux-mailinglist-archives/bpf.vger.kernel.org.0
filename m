Return-Path: <bpf+bounces-11520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299527BB28A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F761C20B52
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9497487;
	Fri,  6 Oct 2023 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgt2ysfG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3A163DD;
	Fri,  6 Oct 2023 07:45:51 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCBE9;
	Fri,  6 Oct 2023 00:45:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4060b623e64so11143055e9.0;
        Fri, 06 Oct 2023 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696578348; x=1697183148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=mgt2ysfGtfukjAUw0i6w98rvnTg+cJqc8FMme4TnNAQRDhRZSYXx4Uu4gFUciMBHEl
         Xh4T+r/cirZEcOKIdjvGC6UDvalvP6fYgVd2iJSAq2SWlOYfAVaZdrGExe9tbtYyNGvB
         tLlVwRjk3hP1VnXtUo7F2B6SSfEKdhYyxaOlXu/qS4MgBbFDrcn+ulJB7eOICzepjK3m
         z8ETUYdoXQq67BB2hZKHwhYixiXi5Z6SueDnZnktnYKZPcLg9PhxZn0aaws1c/rQD8tf
         fuWvq6W63slZmnjP4vfQyip6IrUsrorldCp21hkOo0XLzeS1NHXvfdzlA9WIwJ1bO06s
         eK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696578348; x=1697183148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=XNy1KtJqjY84xG9Sbw3zlMLMkxtkSWcMxXvyiCFrDnvnA7/daInbZ9sqLliKL83Tw/
         FNFjGYDvS01b7E48umCI4zU/zZzoNxQV3HB5jd9TW1/YBTo1vndvfe3A9spghbgTGMCu
         d3WIvZwoH6APIt8kq4541GlHBzr1Qek5InkFJqOeea3ZlMyxYUFUh0/hxDWjZIZ00tvL
         IfVLNlgzbaDskcN4mHKNJnVOcG+nKgk2bvUjl+0J1Vof4unzxWUssGUczwvI84EOv73G
         JRWfdJvu/OwqMkvcPt4YC+1elcQAqEhufjSrtJsyCHbEFE0TU74VUrNrGhcXdYCOswTX
         DDDw==
X-Gm-Message-State: AOJu0Yy7GI1TcGVeJ9fM6+IrH2Ruu1J49kzN6i0pqDL5wnxRVBxlqj93
	A65/91XsQXwYkRtibcDFDhA6RsxAAmzKps4c
X-Google-Smtp-Source: AGHT+IEuOf1IrVgmRGjyU3neCiT4/qXroG80mPHUOuJm9HhY8eSap1+BeYtxHLAwMdCCQnCc0adIQA==
X-Received: by 2002:a05:600c:3ba7:b0:405:3ab3:e640 with SMTP id n39-20020a05600c3ba700b004053ab3e640mr2646201wms.20.1696578347426;
        Fri, 06 Oct 2023 00:45:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm3126888wmi.27.2023.10.06.00.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:45:46 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v9 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Fri,  6 Oct 2023 09:44:55 +0200
Message-ID: <20231006074530.892825-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These were missed when these hooks were first added so add them now
instead to make sure every sockaddr hook has a matching section name
test.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../selftests/bpf/prog_tests/section_names.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..fc5248e94a01 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,26 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/getpeername4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME},
+		{0, BPF_CGROUP_INET4_GETPEERNAME},
+	},
+	{
+		"cgroup/getpeername6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
+		{0, BPF_CGROUP_INET6_GETPEERNAME},
+	},
+	{
+		"cgroup/getsockname4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
+		{0, BPF_CGROUP_INET4_GETSOCKNAME},
+	},
+	{
+		"cgroup/getsockname6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
+		{0, BPF_CGROUP_INET6_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.41.0



Return-Path: <bpf+bounces-11779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B542F7BF099
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 04:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE1E281AC9
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7ECA5C;
	Tue, 10 Oct 2023 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfDFt3MU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073E38E
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 02:02:44 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13FD7;
	Mon,  9 Oct 2023 19:02:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so4605182b3a.3;
        Mon, 09 Oct 2023 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696903361; x=1697508161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtdXd8zzfUQBn/Ye5tSm8UdJuve0zGYoqRvrat58Hz4=;
        b=YfDFt3MUbqGgM/HZkE2Z0BZgFPz4kxIntfVYoquRfJYLracZLwXn07A04W9v4+ckGR
         mzUZQmMdivzFvfdFTRvMaWVf5rLsoXu6UAmhhUzJpBI3xm2Tr0q4jKvggb6E7tXVWV1G
         HRLcABEPJUld8TujAJNhhkVYbxc3XziO21zCwwNV0ZOHwe8WW5wIK3bp8SKt7k9nmRji
         ZF+gzl3KBkjyXGSVmsudoQi2Nvje5Nydc0MOYvVpZgbZPdcKxXGKLyyPp7yMTrZt9WTF
         a7XGLEkv/lbL9+iJ4+1MLbsqT/RubTpOUEsOezmxrlMkRFwNZGOg9ewAS4q/nWfskEX0
         tLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903361; x=1697508161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtdXd8zzfUQBn/Ye5tSm8UdJuve0zGYoqRvrat58Hz4=;
        b=PUtOR1Bm7vaIcsblnY6/bXIgcT6jg16MKZhazdHLjXYsP5/52cHNpPCVLd9dzrFxN4
         Qk+CfF0LwJj447g0efMEUxKeHzSPXdFNSvoWMU6peFpjAoSxxREoczYu3/fiIgxlKCmc
         zuUHuTRcQbplQ42QkB6fwaeHwDtvtVZyF0S2imfS4gdQBV9PSpwypTPPiRACHHmp4xnY
         Rt/5PE/jfZoHlr/WlEUSqgHLKpKzGTzOh3A3tSm1KoEwmQNwe/on+zNDCU/6iG0UYJw3
         QM6AcG1OfXwUWxlCFxdn3kFyLnaL98Sxr+mBaSnjpl2vL82A1DDSAZZz39J97Ej0W6ZV
         FCrQ==
X-Gm-Message-State: AOJu0YwyM5chVCeZ/NhucUr6UhLTvcQrJvAr18hNwpo32L0sIzjj0GjA
	yAJxT5kDV3eEDJo5EEVekxbqXlSruMcgyg==
X-Google-Smtp-Source: AGHT+IGE/Wvfh56YqXKHMKN/e88TuB1AvEwjGLel0rS8MBBVQu8zPnmg96buRkkUG1bSlMZFjoikMw==
X-Received: by 2002:a05:6a00:2405:b0:68f:cd71:45d5 with SMTP id z5-20020a056a00240500b0068fcd7145d5mr19253361pfh.3.1696903361038;
        Mon, 09 Oct 2023 19:02:41 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.112])
        by smtp.googlemail.com with ESMTPSA id t28-20020aa7939c000000b0068a46cd4120sm7044809pfe.199.2023.10.09.19.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 19:02:40 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH 4/4] selftests/seccomp: Test SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER
Date: Mon,  9 Oct 2023 12:40:46 +0000
Message-Id: <20231009124046.74710-5-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009124046.74710-1-hengqi.chen@gmail.com>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a testcase to exercise the newly added SECCOMP_LOAD_FILTER
and SECCOMP_ATTACH_FILTER operations.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 38f651469968..8f7010482194 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4735,6 +4735,26 @@ TEST(user_notification_wait_killable_fatal)
 	EXPECT_EQ(SIGTERM, WTERMSIG(status));
 }
 
+TEST(seccomp_filter_load_and_attach)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	int fd, ret;
+
+	fd = seccomp(SECCOMP_LOAD_FILTER, 0, &prog);
+	ASSERT_GT(fd, -1);
+
+	ret = seccomp(SECCOMP_ATTACH_FILTER, 0, &fd);
+	ASSERT_EQ(ret, 0);
+
+	close(fd);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.34.1



Return-Path: <bpf+bounces-12245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813437C9D09
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5632816B6
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017017C6;
	Mon, 16 Oct 2023 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDvJWz5S"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3D1842
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 01:47:49 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB3E3;
	Sun, 15 Oct 2023 18:47:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27cefb5ae1fso2052772a91.3;
        Sun, 15 Oct 2023 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420867; x=1698025667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzhM/tCHpGy9FYSH/tZ16wiAC3i6sgxn/Z+el+7Dm1k=;
        b=YDvJWz5SUv42X86EguqALMrurSGYJkzgaoj0EjkR1f4Kk28BlUTPX/3ubuM/P125+S
         96cSveMxU0Wp4TPi4vGTgqfyqC4UD81CGmyVvAzxrZ068nypxtcfyPLB02P6NHnNCwfZ
         X91N9QTRMOF3oTvXb/2i41QtMcDAYfU50CC0HGLyigzAc2rrDprnkAzGYkkGCn0YaGDu
         hg9wlu+sHT4ybbgRM5pN91ILrvCNfm4ZSFOA7WCzdPC/VaSV2WiCyeRr01Od0NvZk1pz
         BDkqishN7C46/anPZgiEIhbYPC6bIxMoWjvwbydIzcnAvUWUvDutleSPamdltv8q/IVn
         TFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420867; x=1698025667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzhM/tCHpGy9FYSH/tZ16wiAC3i6sgxn/Z+el+7Dm1k=;
        b=ucL8t3qXJMkrSHEJvsjQih2KRmjeHCVzf/vdMTDlUHLdcu192D7xQeqgW/NJLWBo4h
         y1SGy3iFFvTN6AHaEDkBkJMjaJ8DcNycb2EgADBir72+FvjxgvsXd/JOivXcAJeX0ygM
         YISqC0P8yvAPAr+uKFbOBhKJdjjTv8uuoLsPvzL7TvNgPZVx1w1ASTnGtKJrbEnTzlal
         10oMw14ZLrnQuyNl0Req2xkVgxTddnF/0p0fUxO60CJSPXnjdeYCbP8Na/mnE9cvcG64
         88Wsvt35cgXW9WbKGHfuUI6XSr7Wb/qdfQj29e4RZSV6WNSfgmx5tNRwPN2Nimc4R7PQ
         B6oQ==
X-Gm-Message-State: AOJu0YyNRbBzUtGIVSObQjXvWq1uMe2HU2PjTgEZD0zzfE+xZLV7JXfG
	EhYXvV4f44PIu33a9ytNZgFxtPS8CfXtLw==
X-Google-Smtp-Source: AGHT+IHSVwNqssEMUtYCFYaIs6EUfdbJpktqLxGmk4ZEISa8uxTbyvKHI+bTGiJs64H2y879QLfg4w==
X-Received: by 2002:a17:90b:23cc:b0:27d:2364:44f6 with SMTP id md12-20020a17090b23cc00b0027d236444f6mr7416596pjb.6.1697420866960;
        Sun, 15 Oct 2023 18:47:46 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:46 -0700 (PDT)
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
Subject: [PATCH v2 4/5] selftests/seccomp: Test seccomp filter load and attach
Date: Sun, 15 Oct 2023 23:29:52 +0000
Message-Id: <20231015232953.84836-5-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015232953.84836-1-hengqi.chen@gmail.com>
References: <20231015232953.84836-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add testcases to exercise the newly added seccomp filter
load and attach functionalities.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 38f651469968..86600d40d01f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4735,6 +4735,50 @@ TEST(user_notification_wait_killable_fatal)
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
+	int fd, ret, flags;
+
+	flags = 0;
+	fd = seccomp(SECCOMP_LOAD_FILTER, flags, &prog);
+	ASSERT_GT(fd, -1);
+
+	flags = SECCOMP_FILTER_FLAG_BPF_PROG_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, 0);
+
+	close(fd);
+}
+
+TEST(seccomp_attach_fd_failed)
+{
+	int fd, ret, flags;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GT(fd, -1);
+
+	/* copy a sock_fprog from a fd */
+	flags = 0;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* pass a non seccomp bpf prog fd */
+	flags = SECCOMP_FILTER_FLAG_BPF_PROG_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBADF);
+
+	close(fd);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.34.1



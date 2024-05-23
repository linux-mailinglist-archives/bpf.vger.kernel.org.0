Return-Path: <bpf+bounces-30444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A58CDD25
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A151F21808
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BBB12882E;
	Thu, 23 May 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcs+RBAt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA9127E29
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505745; cv=none; b=V82HZKH8//YNQQMouvybleiDIZRkXvk2RKCJrcgGA4xAPM1IYKevqj9F/TOzI2McAeItUWGrzS0bAfdsGx+Vaun9UzKbxkYBR2V9bp/c45gqOddStXUdgU/jbkHYD62zltpAnLnFtI+WAw9OCVRCOkNnfNg0hxLfVvBoe5HidX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505745; c=relaxed/simple;
	bh=AOuolpRVxv8BKwP/7SBIG5zYThDowJbKd4TrLSOyZRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpZuCHkXUR3ri4ihtjs0XKcj8BJuSOR2NVQaoTYub1egM64Z6GXsY5ADslnzNpz9ne2lMtdmI3Pm8O3r698a0iojIKqcVYvUkJzQy/XWoGCZTc28L49PVT8FYKjgezraTwPXB2kudxj7v6HQXRfelW02ii51wtyp+jtNmIv78dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcs+RBAt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-627ebbefd85so26882297b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505742; x=1717110542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=gcs+RBAtCA1ERANON4UzozrBVoTX+dwoK87nlCLq4U+jqVV/n+UL/OYoy3vicF3jdM
         P+JMKvPnPKVicteMfGy3m2z97GCqqDTa/+riInEYbjCBdRcxzKYewijUXNLAlNwKaaFm
         rP6LQa7wdfYfvvAatXAK+acNKk4QEeZjRhh1QW5f8Sal8YYTkhqOibShsoAFu0bjQnA0
         p2qBof3Gm2XzeaRcPo/Cr9uAUDiES5sS2yQbLJ6kbQCHdGXLaCfUi/x75Ub/kCB8/dYl
         xwTdqo1sAuAwumpz9cWwTxfaJa85sZBijro5Mu1g751rYJq3CvOmg4dFg4M0Q4L7xE9e
         eu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505742; x=1717110542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=JUSBSnECR2hg9XQCNdRoKJHMa/9XX4j9R4uj5n4ey5iSIzLheeO76Z0o/X5ionUQm3
         sBcJ0D6VoQxh/ucn5wwErm67pllgYXMG/RxXMR4Na0XbRqdUi0EbLP6kaYIyTk6GOkAu
         r4Q+LJ5NnafF+q3Kcgu34vu5iKNy/evOf692fMTi64fCFVPZl8En2U2+UObinc2hc+QM
         cf6WAZvKapGCJsHalQ8k9++jjk88xxrCGPPWFl06jVChiV/cpXcBNcyWAxfCfeh3CV99
         WH0ns54FJiVk5lmpERu6rmltJ1UdWwAgO+d83O3lwrxOnQWj2iuCdGmqfmuz02ZiuLfM
         1/pg==
X-Gm-Message-State: AOJu0YwAKsxVkSBTHeuTmT7vM9LhkABhQDBYf5V51p/h2dDrdmrI+YLy
	dXzvtZzeqKL5pdWPMYk8yHocEPFLn/Dq105SUJ50ZRG5jIZBbzcziwtwPA==
X-Google-Smtp-Source: AGHT+IEZz3vvM22e0uweJE+BWcZN6CE5NV924cYmp+63qflulyoXVj1RASt0BksNFzc5gml+jaD49A==
X-Received: by 2002:a0d:e657:0:b0:627:a382:a0fa with SMTP id 00721157ae682-62a08f487e7mr5839517b3.52.1716505742473;
        Thu, 23 May 2024 16:09:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:09:00 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 7/8] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
Date: Thu, 23 May 2024 16:08:47 -0700
Message-Id: <20240523230848.2022072-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do detachment from the subsystem after a link being closed/freed.  This
test make sure the pattern implemented by bpf_dummy_do_link_detach() works
correctly.

Refer to bpf_dummy_do_link_detach() in bpf_testmod.c for more details.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index f4000bf04752..3a8cdf440edd 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -362,6 +362,48 @@ static void test_subsystem_detach(void)
 	struct_ops_detach__destroy(skel);
 }
 
+/* A subsystem detaches a link while the link is going to be free. */
+static void test_subsystem_detach_free(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4));
+	struct struct_ops_detach *skel;
+	struct bpf_link *link = NULL;
+	int prog_fd;
+	int err;
+
+	skel = struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+
+	prog_fd = bpf_program__fd(skel->progs.start_detach);
+	if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
+		goto cleanup;
+
+	/* Do detachment from the registered subsystem */
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "start_detach_run"))
+		goto cleanup;
+
+	/* The link has zeroed refcount value or even has been
+	 * unregistered, so the detachment from the subsystem should fail.
+	 */
+	ASSERT_EQ(topts.retval, (u32)-ENOENT, "start_detach_run_retval");
+
+	/* Sync RCU to make sure the link is freed without any crash */
+	ASSERT_OK(kern_sync_rcu(), "kern_sync_rcu");
+
+cleanup:
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("struct_ops_load"))
@@ -378,5 +420,7 @@ void serial_test_struct_ops_module(void)
 		test_detach_link();
 	if (test__start_subtest("test_subsystem_detach"))
 		test_subsystem_detach();
+	if (test__start_subtest("test_subsystem_detach_free"))
+		test_subsystem_detach_free();
 }
 
-- 
2.34.1



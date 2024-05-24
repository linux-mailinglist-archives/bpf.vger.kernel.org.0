Return-Path: <bpf+bounces-30544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C58CEC6E
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9557B1F219F0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B81272A3;
	Fri, 24 May 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTwd+6cS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51E8614D
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589851; cv=none; b=RKrfMLGoj37KrVzulFpgcTgTcPjwDXEajUYAQnJtWFJ28+t4MZny+0vB3mfxCM37U5WC7eXKgLP3a7JgC613xvOeNLF9tuR7pxaJFHtrW/rnS5WzTdfVI7+UEuLX66xkBeQ0+hiu/1hCob5wFpiHD2GOJgF+jOE8qyqV2ARLQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589851; c=relaxed/simple;
	bh=AOuolpRVxv8BKwP/7SBIG5zYThDowJbKd4TrLSOyZRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OH1PUtbwSmXJhjlzmiKT+nslK1eCt8IBSjGTcvyQGaB34nFHL0kDG164FvKwTLyfNd7NLisfLMLDTDGnIo2o7ZeQi8Ol6SQq1p+zq+pe1gIg1yjz4A8sQ2TbNGCXKIpTwsXzhnMXmlNuNICKiW/cfhFee+hT+B6c1LZNHE2L0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTwd+6cS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a088f80f6so10217347b3.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589848; x=1717194648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=jTwd+6cSXAIMZJRw7jJ5tdN/386+0tBmfFdqPptan8d8Y2+Eqcp6wJL1dtb5djqPlf
         PTDuQK2UTRm9zrRLGPQ2rbdbwQ0wDF0Moy9B0LHerFgQIh4WI1X3P0hP2ylep/zJjQoD
         7OZAD6Zay5zEhUYC2WrpqvG1GSPkKcG8KmiyTshWc+/PraP7LZFscnsHK3BIX9cmgaG9
         HSZYL6To5OA9UOKCMlPtg2dkyCjqthdWsIIqDZVpKlNWb+hsUGi2qlAm1xk2HejcFGlo
         LsJsThwCg4txr7GnxtMe/1V99KHMufopeBQzUFEUZ0SoOv3URjePEAEMrMJK3VDj9CQ9
         z9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589848; x=1717194648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=ismsoOXXk2B2OMef5L4sO/3j7prPU+fw556sliBXR2GxQpZETjmsyO4Novg71XGokN
         3Zp4x6ux/ISzN7bVH+cG/DOva5brYBd+wBCU+fEicLG1WSVJtb9kFhloSLJsS30M05NQ
         jopZfZ/z+e6QTBmo9CIgXR0kI6tRo+9bDQmjM/HwGjzA7WtY5roYopZZi/uskrE6cQHk
         i9CWsT9W6wkcgHd1TYA1m+wNZv9PCeraBk3+AhMBI55eOCootifsckEVO/eN/3Kl88aV
         z9D+FbxoSUsmD5k4Snx/sACW6/i6Id9h/TZYTdaC0DHdHd9FGpu+zJM38EjNWKhrNWg9
         ta2A==
X-Gm-Message-State: AOJu0Ywo8SwWi9qRuE281epbRHJ06MWElvLEvKoLNYNdxrhIKbdifAhY
	9QDc4hLdtGijyQf4buZUf7y1yl0mYXbxGYkdz4ahWdb9BJWbxCob6CVZQg==
X-Google-Smtp-Source: AGHT+IEHjyhFsORbOlXJgzYqXQzU6lvtDGkA2el/SjMUQw58x1WzOFbJ32gzitMLSkWfw2aMQ22Vlg==
X-Received: by 2002:a0d:ea0a:0:b0:627:e3ba:2ad7 with SMTP id 00721157ae682-62a0732cef8mr28620187b3.9.1716589847967;
        Fri, 24 May 2024 15:30:47 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 7/8] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
Date: Fri, 24 May 2024 15:30:35 -0700
Message-Id: <20240524223036.318800-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524223036.318800-1-thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
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



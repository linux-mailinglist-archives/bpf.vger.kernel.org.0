Return-Path: <bpf+bounces-30178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103468CB632
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0DA282AAE
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2B6149E1A;
	Tue, 21 May 2024 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbY8uZX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09252262B
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331993; cv=none; b=QRg3F2yNokS2dAYx37DjNy8vbWR1f5oW7mhnubL9mupmPHw30lEwdpC0+S3d+fKx/d92E6ZMiu1umrQF/k6CZ3AbEVcWKKxeRorzZ9/rHtTTaeHTjepMZWlyfjGewTssUG/NArDM4uSyjMKDrJqPnh8F4HeAtEqJtggLH2uN+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331993; c=relaxed/simple;
	bh=AOuolpRVxv8BKwP/7SBIG5zYThDowJbKd4TrLSOyZRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke7+6yASahBnU3klIfpYd4fsL9mVCuACfa3BGCz47RZjbhi1zj+v8ZWtjoTttiz+HpXYipNhHFDzk5IJKYfNIM5JPpE4GH6qKei6tBzpD0oya17eIwodLWPIYtTjKiKpGzpNiDsO8q+tePrrKfzfeOfbXuxk1Kju+QpCuicwk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbY8uZX7; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-620314aa1d7so44627887b3.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331990; x=1716936790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=UbY8uZX7BTQbnF5Zu7SPcPBXRFNdNzt5LswSN1AV7xLK3h8mFhg8giFHOd4xLMJI1B
         EFCEEg5VW8dNJoCdBf9U6fxmU7RS4P8BHdOw9NhPFtqioRzYO44pfc+bIee8yYjO83Qs
         G9xlTmAud+TKN/VfizCXlrl2LAkeKZCR7FyxfVnVQgz6rI9PHhWg06bV7aV9wPQiAdhJ
         Te6QQRyWRmbYNTPA1OzZFAOXl/a6ros2CPtHXOU/4jO+dJWe+o4DtCLsEZWUuW70Xmpf
         SGnq9+f5PL2wbpUk3HllXLAbDtk9sVn1MVOBt2/U+eT1h5B4GBKxIs1051nMUJ3MFRvO
         4NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331990; x=1716936790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=WZco96/G4zZm3pUvLmCKIMagIuF3kNqJr8ZFwTguHDw/1fa5G6oo/pZAKP/WaM2Qlw
         iet3oVlj8JxbqM+9re3iAjOzzdWVAmKmhDEJ3wKSOw9EQ4A0oLpn2oBEdj6ERYcOcBhD
         HilloxFXEP3G/PNyBk7veEole6WovY1WnJfg4LW1FMAoAjB7nB5zKBwoXmllkoA3dpG4
         2zOsuU/KWjC+NKKvxEZKB+Ehgen9pGcTgnFiemz7/hkwp0gosU9LEOGTdSGEHlhB7nRP
         RuH4Zjh4yfcHnDAlCe/yGHaW258XBL1eX9URwpHf28k4zqAnkXUGvqJBs5Q3gJeQ1c36
         AUrQ==
X-Gm-Message-State: AOJu0YwZtRIRPfXdXOCOv8z+/fYp3AIQKMMp3WwjoteLxO384QNCMOgs
	uPfEoIjzI85I3fDjw3yrxVLIqnTN/xCvLdKQ+lhH0lqUNT8JEe+w3kMcQA==
X-Google-Smtp-Source: AGHT+IFrDOZu3EHYguaNMVxdf6kntbGrJnCULTSAHl+wHA3r34j1mQYZ3RbmtfBmY0lDGZtHpf3grQ==
X-Received: by 2002:a25:aea1:0:b0:df4:ab39:8c1f with SMTP id 3f1490d57ef6-df4e0dd1f85mr487427276.53.1716331990127;
        Tue, 21 May 2024 15:53:10 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
Date: Tue, 21 May 2024 15:51:21 -0700
Message-Id: <20240521225121.770930-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
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



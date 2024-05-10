Return-Path: <bpf+bounces-29419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F98C1BC5
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC831C21ADD
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAB53E2B;
	Fri, 10 May 2024 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxZQ5cQW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54E53E07
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300995; cv=none; b=eBYnFX8SVShj8fCHB8FmLXCaFSJgkil+gZDNOgYRwviv7xnq08PJvKimrhuct9kmNzbHo1qHSTh5DEDbtgVCLrCBZSnmvlSapx7M+sVr20JQBpdJzmxV6Wz9Oejzy3rw7Mu4ExAEGYi5J0WmgYeKw/m7l60avHe7AMDWN6sfmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300995; c=relaxed/simple;
	bh=AOuolpRVxv8BKwP/7SBIG5zYThDowJbKd4TrLSOyZRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsTK8mf09bESxOlGwS8IHOkh+m9/LDvhU76hdzGhXqgBpjYB+nTsvA37Pz60ijyIsSSanAmTLTL4x2psDvL/gW/AW5q6VKeO7Zubx6WfWPH32LT1tpjamNS5JbaTOcgFjQFMXbib6/AyK02DtnoBSrApLS7Idf0o/6XvNcUzawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxZQ5cQW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9936cb7a8so546550b6e.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300993; x=1715905793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=dxZQ5cQWo4rjT0+wkguOCBjB49uAcu+BTU9DSum/juXCGE/j9xN2VlJt+8+KzBbt/+
         bSJCXoSLk4I0UJmE+e1wUJpXRWc5rGE+BCxxirsKtc3n6Etu5cA3O3evav8Bkl0ISjB5
         1Pq40a4Qaqvf0ztcgQ5cqCzi3imQqEj5lUQ5jHCvBtmJYOycOUBTJTkvYGG1aeC0BRLh
         Y/DUrjq3SvldcRqgWMs37gDlyVC4FVr6PmSOkfewAE+/FQ87TgE7ngt8zw/U/F7Gc3UK
         dQa4HWz0R745JVoztmB62OpHVu5Z3szWvR5MRC+Y7ODh1i1u2KICuxW//FDp9LGrhjli
         sF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300993; x=1715905793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYcqFYutho0m48sKDHLd4sCd0cqM9g/XMnashe1IAHo=;
        b=dqCO+WIDaDNwu4RKuHEZAIVQo3PTt2nsYJ62TLJ7zrN7un1q+khRMNRh1qaa0R6pyO
         9kwYo1u6bTZ3BGWnKzfdiuYJDTKS42ltyzp+1YeUMoPAKqpUxf0LxecsCkrIoIgBedAk
         LmLbBVKXMwlTfh93l0QSxX/yKuriUvNOOKlXD8kqUdzSMTTFz7cQLGUmMlYNpaHmcKkS
         K2jXhXiTzdlxZSzrOIPgRB1iphaJtRnUHpx7sn3HinD8nFmk+Lf4J1ZrbqN14ABlqsa2
         4E8klxm+qXMPDXaKsD0lILpLq7Sl8jX1RRpTgqO8/BL5oQv5f/eQl3wmrwCJiMxQIuUi
         g1gQ==
X-Gm-Message-State: AOJu0YyVCYDrQ6dCN5SxDFsirsWsBJhrxc0P1d64hq3tWC6K8DE9DxYn
	vHfHkqGCbaDDypXabhDIeVs5SiHaca1Y1sRZQTWrrqvTJyZys2N4SVMQDA==
X-Google-Smtp-Source: AGHT+IH35Jn1nWuKEDPnDE4RhB27h9nO+1cQ2wKCd1cI180qnD1G1e8cV7h46f4LZHto5nnB/uGVjw==
X-Received: by 2002:a05:6808:299:b0:3c9:7ce6:3b14 with SMTP id 5614622812f47-3c9970ce763mr1132955b6e.52.1715300992688;
        Thu, 09 May 2024 17:29:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: make sure bpf_testmod handling racing link destroying well.
Date: Thu,  9 May 2024 17:29:42 -0700
Message-Id: <20240510002942.1253354-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510002942.1253354-1-thinker.li@gmail.com>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
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



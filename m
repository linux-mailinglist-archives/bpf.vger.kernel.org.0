Return-Path: <bpf+bounces-22795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0686A104
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3221F24D35
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A314EFF3;
	Tue, 27 Feb 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfZ7P4A3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C214EFE3
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066801; cv=none; b=I/8Fygy8GW3QvLq1OzxJA3KRwSuy3PgzYjgfB483FJzXZQfkR45D14Q5LYG7PEd6dBcyGYxs/R40zLx29ZJffRs3igGQgKMQ98b5wX75jwYFgvbZDDTqN3Jqe0u9VSr59xx9Lerf1GsuqsHpcbxmPC1ty8gpd9xNZ1B8nafaHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066801; c=relaxed/simple;
	bh=AUauZGL5+/rh5GG4zk54y7kpunQscNTEQCjLu4uOP+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHTrE+Eb21hKvaRHvXnsidNMw66GYm60SP1oNQZ2yh35g79YhiIz0a3MFKJIuWzDD3b8R4IT14q/3rF0ye9y59gDiZM/PKRotjJS11B/0T/5Q23QdsKgLJlL/09jXRGwPIPm6xpGI27PlxzVl14r9lLfOncqseruRwkzGq5J3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfZ7P4A3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso4187469a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066797; x=1709671597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liH9xyX1tymvM6hgRgnjazV5iOyyvCduV1ZAdTONLmQ=;
        b=RfZ7P4A3UKKUr5zV+l0kcDraoJHTNHQoex2wyuaw57iC8YmkD3UVJO3EcYP9sfxRE1
         c7WwtEVhqmq+rArP7fN6wbukD86XLKRJssTh8SN8HosHWH8YfhVn9kk3eBadwz2bwlkK
         JaSqStFCMudHaX7+S6kKlgjWgHuTo8ds32YFYajjol0/r9SC99EuoNSUgAf26AsSTVNK
         JA6ysMj5cQIiOVcvWndaBhtH1N2Zl28nBAxIvl5ISD3iulFltWDTIRyFDsTGDeTuIkyt
         DUA1p3vO/PsYWsiLkXd/X2K7f7chRlBFRG8XfuOayPIlprsGkXRMiCo+J3JtUsxtE/lb
         1bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066797; x=1709671597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liH9xyX1tymvM6hgRgnjazV5iOyyvCduV1ZAdTONLmQ=;
        b=nJk20jV6KMu7Puy+mGutXQV39PzG5TI4y+w4YjKolUiymKZRRHOQogvEVzIjhHdnMv
         xdOva0WxQd8OSEY3S8HAI5uVp3l5tgXIrbFaWLdtcPo9cldkYLKsiMwv7lm77Gz5STB+
         2DMZkfVj2Ez/N77/FjsOAJDHBO1pTV3T0mEhCaEAOy+fv6knLEU3xrkleMWcAV2cjXmW
         5d5y/SueTmqTnZEK5MPT4oG4b+9UVTo7U5JnhskMbuDYSWJ5cNVyB4+ny+x6ck0kP/Ch
         o14p20HRUctgHe+jwSRxf4ytT8JwxmTete/hfnBXNTfwSoF4KoyunGyaRn9KJz26FZqB
         Duhg==
X-Gm-Message-State: AOJu0YyjmsaRwVeOjvnQ/hQdznNiJC1a4lNIFkNexKxj0HVgOS3COm+Z
	OcgKlFzJu6OyolMK0AYJbFjpYY7ZoE3Rsz6uId1LLKat8+vuG30zVml/Ofcg6Lg=
X-Google-Smtp-Source: AGHT+IErzoO/LnaIc4qmRfJzZUcsWM01YcbOQiB+OeyYsGD/f7xXLl4ZI7eJxX8pMiwEPh8q07X/tw==
X-Received: by 2002:a17:906:565a:b0:a3e:6a25:2603 with SMTP id v26-20020a170906565a00b00a3e6a252603mr7837736ejr.33.1709066797437;
        Tue, 27 Feb 2024 12:46:37 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:37 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 8/8] selftests/bpf: tests for struct_ops autoload/autocreate toggling
Date: Tue, 27 Feb 2024 22:45:56 +0200
Message-ID: <20240227204556.17524-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify automatic interaction between struct_ops map autocreate flag
and struct_ops programs autoload flags.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 65 +++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index b21b10f94fc2..ace296aae8c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -46,10 +46,6 @@ static void can_load_partial_object(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
 		return;
 
-	err = bpf_program__set_autoload(skel->progs.test_2, false);
-	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
-		goto cleanup;
-
 	err = bpf_map__set_autocreate(skel->maps.testmod_2, false);
 	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
 		goto cleanup;
@@ -70,8 +66,69 @@ static void can_load_partial_object(void)
 	struct_ops_autocreate__destroy(skel);
 }
 
+static void autoload_toggles(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct bpf_map *testmod_1, *testmod_2;
+	struct bpf_program *test_1, *test_2;
+	struct struct_ops_autocreate *skel;
+
+	skel = struct_ops_autocreate__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
+		return;
+
+	testmod_1 = skel->maps.testmod_1;
+	testmod_2 = skel->maps.testmod_2;
+	test_1 = skel->progs.test_1;
+	test_2 = skel->progs.test_2;
+
+	/* testmod_1 on, testmod_2 on */
+	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #1");
+	ASSERT_TRUE(bpf_program__autoload(test_2), "autoload(test_2) #1");
+
+	/* testmod_1 off, testmod_2 on */
+	bpf_map__set_autocreate(testmod_1, false);
+	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #2");
+	ASSERT_TRUE(bpf_program__autoload(test_2), "autoload(test_2) #2");
+
+	/* testmod_1 off, testmod_2 off,
+	 * setting same state several times should not confuse internal state.
+	 */
+	bpf_map__set_autocreate(testmod_2, false);
+	bpf_map__set_autocreate(testmod_2, false);
+	ASSERT_FALSE(bpf_program__autoload(test_1), "autoload(test_1) #3");
+	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #3");
+
+	/* testmod_1 on, testmod_2 off */
+	bpf_map__set_autocreate(testmod_1, true);
+	bpf_map__set_autocreate(testmod_1, true);
+	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #4");
+	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #4");
+
+	/* testmod_1 on, testmod_2 on */
+	bpf_map__set_autocreate(testmod_2, true);
+	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #5");
+	ASSERT_TRUE(bpf_program__autoload(test_2), "autoload(test_2) #5");
+
+	/* testmod_1 on, testmod_2 off */
+	bpf_map__set_autocreate(testmod_2, false);
+	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #6");
+	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #6");
+
+	/* setting autoload manually overrides automatic toggling */
+	bpf_program__set_autoload(test_2, false);
+	/* testmod_1 on, testmod_2 off */
+	bpf_map__set_autocreate(testmod_2, true);
+	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #7");
+	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #7");
+
+	struct_ops_autocreate__destroy(skel);
+}
+
 void serial_test_struct_ops_autocreate(void)
 {
+	if (test__start_subtest("autoload_toggles"))
+		autoload_toggles();
 	if (test__start_subtest("cant_load_full_object"))
 		cant_load_full_object();
 	if (test__start_subtest("can_load_partial_object"))
-- 
2.43.0



Return-Path: <bpf+bounces-71693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EFDBFAC99
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F96463CB7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027730216C;
	Wed, 22 Oct 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js39pTVm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EB302176
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120391; cv=none; b=Leb4aZE1Fp2dSSjTDnpBjS3sV2qxMHJsXjZ/z9M1pf44PClBibHj/tBzj+lus92u8BJR4Ow/leGjOdujOMLKPSFBObIkZwlPfokE++3+cRc1cTTijEU9ITZb6Qzis2VyMcmQR6Vqc7JZykX5B83YSVXW19h1yDMePNkDygDRU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120391; c=relaxed/simple;
	bh=B0JQqDRKxWcBxPXaAw62FhVtQnrslzaQ3xhWOIHDjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv3HLsZivG/UCj3ufb4+aU1Hdol2YPBMckCyumdtnw9pmwX1RhfOBsr2+dsHm/VI6Kfh4fSzoSPCaiV58ylbEfM3La8s6or4qSuk2RzcLeJDOvrSeymccIbgiFJmsL0Irkv/UWXmEtekuwpEZnY1VQSJ3rF/vjS+zLUuyeqbywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js39pTVm; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-33e27cda4d7so467677a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120388; x=1761725188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHIaGixaxA7xmdcTs4um3PPNmbROplwQ3SgulV73VAE=;
        b=js39pTVmKBh0qrcGsb2uVbZOU/bbZb6vfUA0qpj+BbIRHuxajjaHRHpln1TpKg3cl5
         zjj86un+TfkwWfHID5cPx0407dYwhIDBtoqSl7xmDn1BBDnU4rsEWVaCJgtJvmJusZu1
         0zLVzLF9OmMjWkAh+lC/8He3mUFbMT02Lq2FOqdA6fui2YtNYcv6rt3tMeIGs0tYJHGo
         knga6Z9KQMlf1GT4JZp+PTMYK1U1e+n+KAofuyYPSAaFe22z0FZfyZNpYH3Kknilh6J2
         kb0hTTN/APQhbDtftG2u63OkN1bRCb3EJcdPFb+zm/mhcWdz+3h5NW7JHgc/GSnoLy74
         O0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120388; x=1761725188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHIaGixaxA7xmdcTs4um3PPNmbROplwQ3SgulV73VAE=;
        b=qXt/uHclPlxShVcG+P0M+zAr15NDk1fg2a+tbe3O/z0YMRgHwXVA7EgIpNwUXFk2dw
         BOfSElGhx+gAXhqLWRd1z+usV+b/05aPwXrLEY6F4wqYVXHqd1qzhsqIE78bdkJwPYIu
         rfI0rNNy1D6gvEcYRIcWrlyhM9y5FQD15rgQdbD2dZjMWbuaTC/kBl9ihKDGeBhznryC
         eaRH6fT1FTQBxhOcIvnfs8WcIaB8z9oXD3MTzKNsq+IfbZ+3f0q1yoOU1KaiELDVAAOL
         gzIrq5NCZKo875l+EFB4X/gEH6AjOoB359pI+9zBpt4E3AqVEgVHgY7qFuvocU2k2Svc
         /OiA==
X-Forwarded-Encrypted: i=1; AJvYcCWpuFq3qajGZWnjoAkMcz2FQAU2nbQ4gipRbXEuXwVUexSBlDBPvx2TxrD9B5fLt6ob5Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeL75XNQ9M9Ht9O9nBDsQdBAsyS9WYroX1NJMwggP7qd57abpE
	tfDvdFie7D1IrB5VfQKnzul7Rq5ufm+3FzfxmKjIXOI6uiP/GMkBjtkh
X-Gm-Gg: ASbGnctSYNCgmGL/YJE/FNEocjdmOdmb8znJH6ba8eO/KdLtLjUQcwS7Lxi6epE1SKJ
	AvWMQflD2/GASEpUYK2PoZ+07ZTcJj96ZhS+88SWjztrVdA7jbmUH5ul7sEYmHW7rlnA4z6nNgG
	ByXaCxgWyOLitja4wcviASrDD1mdGiXACqyggWuYkV8etsF9jWTtSqOh8DMaTG/lLhcQ+dR7/CI
	cjHu6VbfrQX7ued+RRYUmmFOYY6ry5scCOdVT9IYHKAP/9UVs4RYWlyQGhx4/BTTQnkxMWFvwh4
	q/TSXOksgH0rFOlC+3DWHu3VF9rLOXj2+NAoBQshH1wEjWtPB1n6x5w9zNBQr1aYB+n8P2saDs3
	j7C/h2XvQiuP7UUt98rabCigAA/aVW4sUmHT/anHETme02ps560DszahVu6c82LWUv7B49mcz9B
	sYyp8HiPY=
X-Google-Smtp-Source: AGHT+IERyb93JkjscfYhmv50eNGlTcSbffWgXk4M3VQqoMdjpjdztgQz3+2IY6J0m01vh+DMSEmNnA==
X-Received: by 2002:a17:90b:48cf:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-33e21ec327bmr3586322a91.2.1761120388000;
        Wed, 22 Oct 2025 01:06:28 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:27 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 09/10] selftests/bpf: add session cookie testcase for fsession
Date: Wed, 22 Oct 2025 16:06:12 +0800
Message-ID: <20251022080613.555463-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080613.555463-1-dongml2@chinatelecom.cn>
References: <20251022080613.555463-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the session cookie for fsession. Multiple fsession BPF progs is
attached to bpf_fentry_test1() and session cookie is read and write in
this testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 34 +++++++++++++
 .../selftests/bpf/progs/fsession_cookie.c     | 49 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_cookie.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index d70bdb683691..549b6fdd6167 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 ChinaTelecom */
 #include <test_progs.h>
 #include "fsession_test.skel.h"
+#include "fsession_cookie.skel.h"
 
 static int check_result(struct fsession_test *skel)
 {
@@ -82,6 +83,37 @@ static void test_fsession_reattach(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_cookie(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct fsession_cookie *skel = NULL;
+	int err, prog_fd;
+
+	skel = fsession_cookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_cookie__open_and_load"))
+		goto cleanup;
+
+	err = fsession_cookie__attach(skel);
+	if (!ASSERT_OK(err, "fsession_cookie_attach"))
+		goto cleanup;
+
+	/* Trigger target once */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto cleanup;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto cleanup;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			goto cleanup;
+	}
+
+cleanup:
+	fsession_cookie__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -92,4 +124,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_cookie.c b/tools/testing/selftests/bpf/progs/fsession_cookie.c
new file mode 100644
index 000000000000..93a120fb62e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_cookie.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_ok = 0;
+__u64 test1_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		if (cookie) {
+			*cookie = 0xAAAABBBBCCCCDDDDull;
+			test1_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test1_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test2_entry_ok = 0;
+__u64 test2_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test2, int a)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		if (cookie) {
+			*cookie = 0x1111222233334444ull;
+			test2_entry_ok = *cookie == 0x1111222233334444ull;
+		}
+		return 0;
+	}
+
+	if (cookie)
+		test2_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
-- 
2.51.1.dirty



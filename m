Return-Path: <bpf+bounces-63957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1AB0CC79
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2347A1AA61D5
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092302459D5;
	Mon, 21 Jul 2025 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUkeVJVq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E022D785;
	Mon, 21 Jul 2025 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132834; cv=none; b=kzt19uyptjReMNHb8+ngpNyOh1FLzgYd73c38YDGwJRZ80csyqMFmR+X9JsduqQZwPIEoJDOy1aylcMLwZ+pQfqoHTFvc4/aXOx7MfBTvM4F8vBlkoNemXb4YlgFSF1EiDiCJzzBol/GaToClNj4s3DKG6ylKBoqHN27Egcxdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132834; c=relaxed/simple;
	bh=4Jj9YEw8izELwPJmD1u2s79IYCPn0vJipaSRP2dhUnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubP1NnC0ZzgZ3Vw7Wce1Cav/E9vd5aKPZAHN2RkIxeW2h1Fte9kfa1PXh3E11oJoa6cQJDezslx3H0qHXdre0DdhgehBINw6K4WPcWXTiGgjl0J5sh3mBhz67EErg4Y5jIru3lzQFWjICH94NRldjJNp49g3uq7q/cYed+874Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUkeVJVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB70C4CEED;
	Mon, 21 Jul 2025 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132834;
	bh=4Jj9YEw8izELwPJmD1u2s79IYCPn0vJipaSRP2dhUnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUkeVJVq7Jk9IE4wRYbtJFLNVeLRQtqF0CcYJZT3HHIUBlgLCmYixADIzzKDZ5JL1
	 fW1Q1pp05r3kj8jkao1yAbzSjXTEeHZqWmmUUhrNgsGrfo20zqmwH6NGPJZV+VcrKB
	 X7iMe+KoWj2Tg9eW6fBSpcvzRVuy7OCUrlVbRUOYMXiTgqXdYubjnk0z+67Vji7EHL
	 4404yekV+eYqGHaZtEnsmvGs5m4ILwBhqttKBa1mLUXTRzm8T/TtZSANvw2BoV12Ey
	 tg6e53d8okYm71W8vqVdmYM834ThTsnRzEJRoSVjv41UdoXeu7wN0Krurq9L3wzqgG
	 Mz5oK9NmP2bPQ==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 13/13] selftests/bpf: Add test for signed programs
Date: Mon, 21 Jul 2025 23:19:58 +0200
Message-ID: <20250721211958.1881379-14-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721211958.1881379-1-kpsingh@kernel.org>
References: <20250721211958.1881379-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a basic test that checks of bpf_prog_verify_signature is called
and returns a success for a valid program by loading a program that
captures the return value of bpf_prog_verify_signature and then loading
a signed skeleton

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../selftests/bpf/prog_tests/signing.c        | 36 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/signing.c   | 16 +++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/signing.c
 create mode 100644 tools/testing/selftests/bpf/progs/signing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/signing.c b/tools/testing/selftests/bpf/prog_tests/signing.c
new file mode 100644
index 000000000000..0c4fca8cd86f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/signing.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google */
+#include <test_progs.h>
+#include "signing.skel.h"
+#include "fentry_test.lskel.h"
+
+void test_signing(void)
+{
+	struct signing *skel = NULL;
+	struct fentry_test_lskel *lskel = NULL;
+	int err;
+
+	/* load a program that verifies the result of signing */
+	skel = signing__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "signing_skel_load"))
+		goto close_prog;
+
+	err = signing__attach(skel);
+	if (!ASSERT_OK(err, "signing_attach"))
+		goto close_prog;
+
+	/* Load a signed light skeleton */
+	lskel = fentry_test_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(lskel, "signing_skel_load"))
+		goto close_prog;
+
+	err = fentry_test_lskel__attach(lskel);
+	if (!ASSERT_OK(err, "signing_attach"))
+		goto close_prog;
+
+	ASSERT_OK(skel->data->sig_verify_retval, "bpf_prog_verify_signature");
+
+close_prog:
+	signing__destroy(skel);
+	fentry_test_lskel__destroy(lskel);
+}
diff --git a/tools/testing/selftests/bpf/progs/signing.c b/tools/testing/selftests/bpf/progs/signing.c
new file mode 100644
index 000000000000..cc03f6363975
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/signing.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google */
+#include "vmlinux.h"
+#include <limits.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 sig_verify_retval = -INT_MAX;
+
+SEC("fexit/bpf_prog_verify_signature")
+int BPF_PROG(bpf_sign, struct bpf_prog *prog, union bpf_attr *attr, bool is_kernel, int ret)
+{
+	sig_verify_retval = ret;
+	return 0;
+}
-- 
2.43.0



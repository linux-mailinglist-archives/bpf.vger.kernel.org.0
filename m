Return-Path: <bpf+bounces-31382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A0A8FBCFF
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8269B1C231E0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24314D432;
	Tue,  4 Jun 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/+697IZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6214C591;
	Tue,  4 Jun 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531452; cv=none; b=skASpARdZ/hka4NBss1X8O7MCQUdYOhzmDLgPKCjejrphncDnx/q2CHGFHUf7zG49o5At22SZcuW+mf4FIk9iV4ePCyB2iBeKAe80ShRA9ZEp/pFrc2QzmE60f1CXSnuuU9efi17x70iAT3ea5dUroILp5pTuPBi/luwHWZuRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531452; c=relaxed/simple;
	bh=Eyepo33ZgEJx5F82DIOiokqpWa7VYfHyqJCUfqfW9s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGQfO7WIscjK1MrMk6niQIkdtGZPvNeKiN87F8JKDQkTfAaBS2WiG64gJ5UDNbZoWlMpBpMljnS/uxLmfUzSpEYgxyTTw2qzXl3EhLNRqzhuu17dXIXkXdGpo3TvnVOi1p2Yxn+7gCFqEgPhhuDTVqtS5k/hp9YbhaV4FCSkOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/+697IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5706AC2BBFC;
	Tue,  4 Jun 2024 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531452;
	bh=Eyepo33ZgEJx5F82DIOiokqpWa7VYfHyqJCUfqfW9s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/+697IZS5yZlx4HkhHOFsu+OT/bcBT6vV/4RBLyz0iaGRrXJGZpr9qJUsPnnnI5m
	 5//PVnlh6+yuA5/wq5GGAL0oaiRaMYFZEYTzHyRw14Kng85lq4gVuIRpj+zre0UOsF
	 ke//8s7g7KG4w7xLhfvdqXp6J72HK3pQ4za6MelrVWjau/LbK0MT3LpJDLgPlge6sv
	 Rc5vt+I0fIsrYEkh9qWAi76inXpFKGlvBqM2P4vUwJuLjPDeckpFe0mQZis13Pa6z2
	 02qgRTkXk9g8IzYPGHs0Bgi2a2A4/E6Cjs3y7DfGpKQ1U8szk24d8qysZXNY8a3FiG
	 Z/duCKPOhVGGg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 08/10] selftests/bpf: Add uprobe session errors test
Date: Tue,  4 Jun 2024 22:02:19 +0200
Message-ID: <20240604200221.377848-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test to check that just single
session instance is allowed or single uprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index fddca2597818..4bff681f0d7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -533,6 +533,31 @@ static void test_session_skel_api(void)
 	uprobe_multi_session__destroy(skel);
 }
 
+static void test_session_error_multiple_instances(void)
+{
+	struct uprobe_multi_session *skel_1 = NULL, *skel_2 = NULL;
+	int err;
+
+	skel_1 = uprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel_1, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	err = uprobe_multi_session__attach(skel_1);
+	if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
+		goto cleanup;
+
+	skel_2 = uprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel_2, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	err = uprobe_multi_session__attach(skel_2);
+	ASSERT_EQ(err, -EBUSY, " kprobe_multi_session__attach");
+
+cleanup:
+	uprobe_multi_session__destroy(skel_1);
+	uprobe_multi_session__destroy(skel_2);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -623,4 +648,6 @@ void test_uprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("session"))
 		test_session_skel_api();
+	if (test__start_subtest("session_errors"))
+		test_session_error_multiple_instances();
 }
-- 
2.45.1



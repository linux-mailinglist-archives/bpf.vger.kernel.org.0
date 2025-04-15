Return-Path: <bpf+bounces-55942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAAA89863
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AC7A5B3D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7C28DF13;
	Tue, 15 Apr 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X4bwkQzw"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C128DF0B;
	Tue, 15 Apr 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710048; cv=none; b=gf0tkZ+kOI+lorhrGsxA0pC21dG8kM2RdDPtXROBD+3c9HAGkOC7CUYiiRx7Op3kBIQUJInMMB6lhKE6IIic5V+3lZgT0zsDcqKbzXVj3VrO/fY+BBJhM6X+RyU7P6TbIsoq3NUTyvOs0SPzCWOqwy1vDTBwE3LZWOHFG37qI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710048; c=relaxed/simple;
	bh=F/5d1IghKb0pg2zSrK+aro4P7knuhG6MLhzJzvNfyUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAJtntwPnQrJtzTjBcAx+vrmPYOzyaxa8U6BGt4mHv7tngHcXnuIS32WMlTcmiMpdS9DK3KqEoVgIhTCo0SXZBJP1r/yEtQxIytH7P+A3gumzOOlYP2MJy+0/yorJL1x++tUqtKxX/K0tKYo9mNx07xR+AtklO07oKfs8tCV+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X4bwkQzw; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OC0HT
	YodGB+352Xa0PvGM8HnRnVdjQBVMt67uxyrdSA=; b=X4bwkQzw4kIerqCYig/yS
	Wt7uxt/Wo1fIu6He2t/PjtuWoN2prr28jZ4xxbODnvRdZEeb0yKBsQ3PCIgH69Ps
	Ljij/2XU5bsUsag19Nm7Qpsaog8GGlpyss8i+AJLeshVz9drkqJCc8lOjP4knqUJ
	shxOFcys/yaXc9cezOmZyo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnT4k_Kf5ncYDjAA--.39887S4;
	Tue, 15 Apr 2025 17:39:13 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hengqi.chen@gmail.com,
	olsajiri@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next 2/3] selftests/bpf: Add test for attaching uprobe with long event names
Date: Tue, 15 Apr 2025 17:39:06 +0800
Message-Id: <20250415093907.280501-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415093907.280501-1-yangfeng59949@163.com>
References: <20250415093907.280501-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT4k_Kf5ncYDjAA--.39887S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4DCw4fXF13GFyDWFW8Xrb_yoW5WF4fpa
	1v9ryYkF45X3W29FZ8G34qkr4rtr18Gr1xGr1Dtr13XF4UWF1xXry7AF4YyFnxJrZav3W5
	A3y3tryUWay7ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOWrXUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgUweGf+Jo9lFwAAsN

From: Feng Yang <yangfeng@kylinos.cn>

This test verifies that attaching uprobe/uretprobe with long event names
does not trigger EINVAL errors.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 329c7862b52d..9b7f36f39c32 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -122,6 +122,52 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* attach uprobe/uretprobe long event name testings */
+static void test_attach_uprobe_long_event_name(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct bpf_link *uprobe_link, *uretprobe_link;
+	struct test_attach_probe_manual *skel;
+	ssize_t uprobe_offset;
+	char path[PATH_MAX] = {0};
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
+		return;
+
+	uprobe_offset = get_uprobe_offset(&trigger_func);
+	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
+		goto cleanup;
+
+	if (!ASSERT_GT(readlink("/proc/self/exe", path, PATH_MAX - 1), 0, "readlink"))
+		goto cleanup;
+
+	/* manual-attach uprobe/uretprobe */
+	uprobe_opts.attach_mode = PROBE_ATTACH_MODE_LEGACY;
+	uprobe_opts.ref_ctr_offset = 0;
+	uprobe_opts.retprobe = false;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
+						      0 /* self pid */,
+						      path,
+						      uprobe_offset,
+						      &uprobe_opts);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe_long_event_name"))
+		goto cleanup;
+	skel->links.handle_uprobe = uprobe_link;
+
+	uprobe_opts.retprobe = true;
+	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
+							 -1 /* any pid */,
+							 path,
+							 uprobe_offset, &uprobe_opts);
+	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe_long_event_name"))
+		goto cleanup;
+	skel->links.handle_uretprobe = uretprobe_link;
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
+}
+
 static void test_attach_probe_auto(struct test_attach_probe *skel)
 {
 	struct bpf_link *uprobe_err_link;
@@ -323,6 +369,9 @@ void test_attach_probe(void)
 	if (test__start_subtest("uprobe-ref_ctr"))
 		test_uprobe_ref_ctr(skel);
 
+	if (test__start_subtest("uprobe-long_name"))
+		test_attach_uprobe_long_event_name();
+
 cleanup:
 	test_attach_probe__destroy(skel);
 	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_cleanup");
-- 
2.43.0



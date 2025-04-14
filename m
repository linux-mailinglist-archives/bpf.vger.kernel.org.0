Return-Path: <bpf+bounces-55844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E330A87BF5
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CF41892CA3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F92261381;
	Mon, 14 Apr 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ehn8t9YI"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BDC25DAF4;
	Mon, 14 Apr 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623318; cv=none; b=DlKPdUhLaoTi2DSA7eZe4Kj4IzDf02QSqFpGSDNa1VgOalLlvcT0Oe2bzK0nK7QLchSct8+9FEgOOWIr6iJz9XhTJgSd3YYTToL2pjGLmRkKHMfnAEeVS2XH1WCF+PEYNyIZKHX4Sz+w4tFRueLvUmvpyf0KGzvMiiZiWAfNozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623318; c=relaxed/simple;
	bh=F/5d1IghKb0pg2zSrK+aro4P7knuhG6MLhzJzvNfyUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sq9+SH2ANUv9Aa/zHQQR2b07GHKMWxdxTT6e41OG89HrQxqZa3+ocJOf17QiGv796xJIlESdPH07tMCpqv3MUBRhQTB6XOA4Ocoz/ZXZoqumgLlqNwexNOreTrDEXouUxHr6eoJ6OEUSMI3bbFpQjTTbP8NPqKBxpIObGGB8WdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ehn8t9YI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OC0HT
	YodGB+352Xa0PvGM8HnRnVdjQBVMt67uxyrdSA=; b=ehn8t9YIhv7ibOc7sb/E0
	OyYbg8zrqvJGpkcYejDrqE5QIUkspA8J8jj2RcGcZNKmyIKHuSU+Sths1ZRPSG3A
	+C8dmBdrrfXpt7YCluGbllj+pY7FdInR+FYD5EERcp9EWhmLspHKMo7VFTI3XjLL
	Y6ZRkwjDKHCkwxfgB4yKR4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnj1Sb1vxnxkYWGg--.23370S4;
	Mon, 14 Apr 2025 17:34:23 +0800 (CST)
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
	hengqi.chen@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 2/3] selftests/bpf: Add test for attaching uprobe with long event names
Date: Mon, 14 Apr 2025 17:34:01 +0800
Message-Id: <20250414093402.384872-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414093402.384872-1-yangfeng59949@163.com>
References: <20250414093402.384872-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj1Sb1vxnxkYWGg--.23370S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4DCw4fXF13GFyDWFW8Xrb_yoW5WF4fpa
	1v9ryYkF45X3W29FZ8G34qkr4rtr18Gr1xGr1Dtr13XF4UWF1xXry7AF4YyFnxJrZav3W5
	A3y3tryUWay7ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7R6rUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwhwveGf808xdSAABsZ

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



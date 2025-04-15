Return-Path: <bpf+bounces-55941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF0A89864
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AAF189E6EC
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788B28DEE0;
	Tue, 15 Apr 2025 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IR2rJI6h"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2A280A37;
	Tue, 15 Apr 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710043; cv=none; b=XKTTyx4snzrbjAZrmiBtCeBcfoQuCkjnfchAJkJlb9lbUk9X7I2/QsS79kkI8joF7PA4ixyiRcTN46I+UsAl1a6A/kvNpb1q5W07FLY/grPuaXGo0DfzBvC18WvijPBcmhbuoADKLtEXYPa9T4x8c/A8QcSbyC+1P85ZGsi3pZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710043; c=relaxed/simple;
	bh=nxBmcEC9tEKMKGUxizdT0/NEVnEyQVbch0HawmetrSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3hFCnQE3777W2xqyI7R3N3PaGlJEAB4BoFF5HGv9veP8RUXcz4uniYSTCpibQN8aNNlGshrh+HYiSoUHM+wSvKLKKIQFDwLItjZmrrhLUVZ3CB/KtlO2RsDFVXV/fsJ0YFaGk/2RFZjnFz5fRI5dGqAqSzycz4Ea5Qp2cEW5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IR2rJI6h; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p7iK1
	CJWNePY4vhNgohUPE7z5ZSyXEeHmHaDDWb6cPY=; b=IR2rJI6hwWgsJy4h3cMrU
	5pPlLh25WJJpYl/EouHNLLhNseIptis5lmjjqY2nPO2FSoAPmFfinhQW/u3nDgsq
	gQz/Fksyietob5U4n9K2Jz3k/RBrxpPYfCz+pkVrqOr65TukMro2ycAeWP13/qWI
	P03rrk7nphqL2gG9eLqh/E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnT4k_Kf5ncYDjAA--.39887S5;
	Tue, 15 Apr 2025 17:39:14 +0800 (CST)
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
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: Add test for attaching kprobe with long event names
Date: Tue, 15 Apr 2025 17:39:07 +0800
Message-Id: <20250415093907.280501-4-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wDnT4k_Kf5ncYDjAA--.39887S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DGw18Zr18Ary3Kr1rJFb_yoW5ZrW7pa
	yDZ34Ykr4rX3W7WF98G34UZr4Fvr1kur17Cr1Dtrn8ZF4UWw1xXF17tF4jyrn8JrZaq3Wa
	va1Utry5uayxZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSzuAUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgUweGf+Jo9lFwABsM

From: Feng Yang <yangfeng@kylinos.cn>

This test verifies that attaching kprobe/kretprobe with long event names
does not trigger EINVAL errors.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9b7f36f39c32..cabc51c2ca6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -168,6 +168,39 @@ static void test_attach_uprobe_long_event_name(void)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* attach kprobe/kretprobe long event name testings */
+static void test_attach_kprobe_long_event_name(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct bpf_link *kprobe_link, *kretprobe_link;
+	struct test_attach_probe_manual *skel;
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
+		return;
+
+	/* manual-attach kprobe/kretprobe */
+	kprobe_opts.attach_mode = PROBE_ATTACH_MODE_LEGACY;
+	kprobe_opts.retprobe = false;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      "bpf_testmod_looooooooooooooooooooooooooooooong_name",
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_long_event_name"))
+		goto cleanup;
+	skel->links.handle_kprobe = kprobe_link;
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 "bpf_testmod_looooooooooooooooooooooooooooooong_name",
+							 &kprobe_opts);
+	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_long_event_name"))
+		goto cleanup;
+	skel->links.handle_kretprobe = kretprobe_link;
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
+}
+
 static void test_attach_probe_auto(struct test_attach_probe *skel)
 {
 	struct bpf_link *uprobe_err_link;
@@ -371,6 +404,8 @@ void test_attach_probe(void)
 
 	if (test__start_subtest("uprobe-long_name"))
 		test_attach_uprobe_long_event_name();
+	if (test__start_subtest("kprobe-long_name"))
+		test_attach_kprobe_long_event_name();
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f38eaf0d35ef..13b0dc7a4a7e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -134,6 +134,10 @@ bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name(void)
+{
+}
+
 __bpf_kfunc void
 bpf_testmod_test_mod_kfunc(int i)
 {
-- 
2.43.0



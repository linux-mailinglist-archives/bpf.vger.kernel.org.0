Return-Path: <bpf+bounces-55845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F6A87BF9
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878911708E7
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751B2265628;
	Mon, 14 Apr 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CVH/qfK0"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AF25A2BE;
	Mon, 14 Apr 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623321; cv=none; b=TdeqpoBMgz93V3h/n18Ik17qE8RzWqNLtBdMolfoMJdj43J0N/SBNR98R/jkAa9GkwlnuJb2BTfwn9tDe1BP/dvuj60USXQppliGCGvrASphgkpslWxLPqvKPEIeLj+fXx4IkDa3ey0Fb88yXdrs6Pi1bLkve+AMz0aEt/EP1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623321; c=relaxed/simple;
	bh=c+389MJKPs27TYfDg/OFgrBDXKQOsRG0HssWonSEiy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKyCQdaP6xMpC05ZAuysuFXVtB+RQX6ZcGG3ZzRBWIJ3SXZ2dvwHUJuF7T27+fUU7Vna7h+47XgtwMVqzL37YVa8YUbDT0T1IjREWlVQTZC78xBmZs4ZRpvjoMQDYidBDiBcDwJlpUKIPaLwaAQ7QTBYeqqgwMsQW7evufDt5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CVH/qfK0; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nT45e
	g9rXt1xUDg7Gdzq2GiV1r1g0jLNnnJoKJ3jlI8=; b=CVH/qfK0Rob88YM04Gaxk
	gw1sx22oCqxLkED2IYVahYPstnXwq9S2ggpH635GaQejY8nU4XPva1d3m24BDBkP
	4D4J5Cc95oTE2z+G3sRtSnsuotaxDoF6G9wdDFlw/ZxT+SZlIwZe2V+oMNiu7RNe
	+Na/XkrGoLc4Itmq68wOnU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnj1Sb1vxnxkYWGg--.23370S5;
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
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: Add test for attaching kprobe with long event names
Date: Mon, 14 Apr 2025 17:34:02 +0800
Message-Id: <20250414093402.384872-4-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wDnj1Sb1vxnxkYWGg--.23370S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DGw18Zr15XFWrtrWDJwb_yoWruF4fpa
	yDZr1Ykrn5X3W7XFy3GayUZr4Fvrn7Zr17GF1DJr98ZF4UXw1xXF1IyF4jvwn5GrZava13
	Z3y0qry5ua4xXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyVbkUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwhwveGf808xdSAACsa

From: Feng Yang <yangfeng@kylinos.cn>

This test verifies that attaching kprobe/kretprobe with long event names
does not trigger EINVAL errors.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  5 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9b7f36f39c32..633b5eb4379b 100644
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
+						      "bpf_kfunc_looooooooooooooooooooooooooooooong_name",
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_long_event_name"))
+		goto cleanup;
+	skel->links.handle_kprobe = kprobe_link;
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 "bpf_kfunc_looooooooooooooooooooooooooooooong_name",
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
index f38eaf0d35ef..439f6c2b2456 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1053,6 +1053,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 	return args->a;
 }
 
+__bpf_kfunc void bpf_kfunc_looooooooooooooooooooooooooooooong_name(void)
+{
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1093,6 +1097,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_looooooooooooooooooooooooooooooong_name)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b58817938deb..e5b833140418 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -159,4 +159,6 @@ void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
 
+void bpf_kfunc_looooooooooooooooooooooooooooooong_name(void) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.43.0



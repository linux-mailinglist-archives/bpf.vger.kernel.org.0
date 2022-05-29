Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E775372BF
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiE2WGa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2WG2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:06:28 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79537980D;
        Sun, 29 May 2022 15:06:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CDFB45C00DF;
        Sun, 29 May 2022 18:06:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 29 May 2022 18:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1653861985; x=1653948385; bh=o5
        Io0TbLicI9bF16Sf8cW9EWMZ3JMY7fjlIo1Z3Xc7o=; b=SBDRcitWGQXvRvn+aO
        Wrd50+ZmOERLrrs5kT5xhO7yukm6NrgDpKs2fvhNvuGDsZq2q9a1t8GcJuDP7exV
        O12nPS9pjKTtZacs6aVEeJd5HLlsAZ4DZoLnibt2z08kw7Ca0jXjcub7lkPD1zvk
        3W5QB+bC8t03gtTkxQaCRDdiwUeFt996+Og63uFjNpGjvZXWmYsAwc6UfGLO+OCA
        WR1F/yK/UFMrVzWrS/7VNbaprMSy3hTten0cRF0F0zQj0cRSnG5eeFCag0wrkvkh
        DJVSet7gYpj6IOm54B4r3R8lHk/A1oboIGHty/mtEjkDOfkGZZZxpsG4MLupqhil
        T9dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653861985; x=1653948385; bh=o5Io0TbLicI9b
        F16Sf8cW9EWMZ3JMY7fjlIo1Z3Xc7o=; b=jKBR/C6gzd+WaOh+plsLpqQ4IZX91
        po4sRDtLHDVzPpWLUDypf26UcKO3eYhP2r5df6O1f/+y4zChNQRFWSoYVarQUkHd
        9YyYoFu48wB1CSUGaH5GjRaZPUQaizidYxs/t1rKSwtoFPn2Gs8eBrmysLww573S
        qlhFgjSfJpKbLX5dQQbpcUG8okeXYDVA1q32s6aIlLS0P+9AAeKUQJy+vwTPQTpw
        ZVSqvu7d7CsrXqlDMT7dow6knq0+8VMXsmbWu6bMAH75/wnnI0ETZ1eq/FAMx3Zt
        LZGiVMgbzt1dFA3ml3dqiF2YTqFWnd3lgNa0I1524DUku1jD5IoBHTWtQ==
X-ME-Sender: <xms:Ye6TYqpSNXlAXoBi5FscljcWhdCj2rJU1B16jeOEoXXhu-xcZnLlig>
    <xme:Ye6TYooKp2xHRVGkUbuzsbKaWdhVcXTzMsjsL8CVmlBEXJc1hxi7w6QkgNkcM4I4j
    Qcj46rDBWkB-AzyKw>
X-ME-Received: <xmr:Ye6TYvPQL7G52Rc4zVt8b7dw7f-KtCzCFsjy4jVLr1gp8wSEdLvB_jwjSay7Fb4K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Ye6TYp61_QX39yfiYcoIAUXVRvrFDScWUR6A74xVo-1MGJVLkW69Pw>
    <xmx:Ye6TYp4MHixciA3eVXTp9MET5f8Z8SfCdqGY_34LRIMr7aDGfzrgEw>
    <xmx:Ye6TYpjvr-7f1zlA1iGoIMzUkrguSqVaHGWvPbLxm3w0HXMV2aMI4Q>
    <xmx:Ye6TYs3dFnlPC6yHANyfVe6ujcmV1GphzdPWxgacQXTc4AydgI8f0Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 May 2022 18:06:25 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add PROG_TEST_RUN selftest for BPF_PROG_TYPE_KPROBE
Date:   Sun, 29 May 2022 17:06:06 -0500
Message-Id: <a8f5faada9b96218d79beb7b7ddebe6a837a5536.1653861287.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653861287.git.dxu@dxuuu.xyz>
References: <cover.1653861287.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds a selftest to test that we can both PROG_TEST_RUN a
kprobe prog and set its context.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/kprobe_ctx.c     | 57 +++++++++++++++++++
 .../testing/selftests/bpf/progs/kprobe_ctx.c  | 33 +++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c b/tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
new file mode 100644
index 000000000000..260966fd4506
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <linux/ptrace.h>
+#include "kprobe_ctx.skel.h"
+
+/*
+ * x86_64 happens to be one of the architectures that exports the
+ * kernel `struct pt_regs` to userspace ABI. For the architectures
+ * that don't, users will have to extract `struct pt_regs` from vmlinux
+ * BTF in order to use BPF_PROG_TYPE_KPROBE's BPF_PROG_RUN functionality.
+ *
+ * We choose to only test x86 here to keep the test simple.
+ */
+void test_kprobe_ctx(void)
+{
+#ifdef __x86_64__
+	struct pt_regs regs = {
+		.rdi = 1,
+		.rsi = 2,
+		.rdx = 3,
+		.rcx = 4,
+		.r8 = 5,
+	};
+
+	LIBBPF_OPTS(bpf_test_run_opts, tattr,
+		.ctx_in = &regs,
+		.ctx_size_in = sizeof(regs),
+	);
+
+	struct kprobe_ctx *skel = NULL;
+	int prog_fd;
+	int err;
+
+	skel = kprobe_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->expected_p1 = (void *)1;
+	skel->bss->expected_p2 = (void *)2;
+	skel->bss->expected_p3 = (void *)3;
+	skel->bss->expected_p4 = (void *)4;
+	skel->bss->expected_p5 = (void *)5;
+
+	prog_fd = bpf_program__fd(skel->progs.prog);
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+	if (!ASSERT_OK(err, "bpf_prog_test_run"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(skel->bss->ret, "ret"))
+		goto cleanup;
+
+	if (!ASSERT_GT(tattr.duration, 0, "duration"))
+		goto cleanup;
+cleanup:
+	kprobe_ctx__destroy(skel);
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/kprobe_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_ctx.c
new file mode 100644
index 000000000000..98063c549930
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_ctx.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+volatile void *expected_p1;
+volatile void *expected_p2;
+volatile void *expected_p3;
+volatile void *expected_p4;
+volatile void *expected_p5;
+volatile bool ret = false;
+
+SEC("kprobe/this_function_does_not_exist")
+int prog(struct pt_regs *ctx)
+{
+	void *p1, *p2, *p3, *p4, *p5;
+
+	p1 = (void *)PT_REGS_PARM1(ctx);
+	p2 = (void *)PT_REGS_PARM2(ctx);
+	p3 = (void *)PT_REGS_PARM3(ctx);
+	p4 = (void *)PT_REGS_PARM4(ctx);
+	p5 = (void *)PT_REGS_PARM5(ctx);
+
+	if (p1 != expected_p1 || p2 != expected_p2 || p3 != expected_p3 ||
+	    p4 != expected_p4 || p5 != expected_p5)
+		return 0;
+
+	ret = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.36.1


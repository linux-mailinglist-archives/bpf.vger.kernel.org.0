Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C52A756E
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 03:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgKEC0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 21:26:11 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50127 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387593AbgKEC0J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 21:26:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7ACA85C01CA;
        Wed,  4 Nov 2020 21:26:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Nov 2020 21:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=d921gZrveLgVW
        10+cFYgvJSXNaGtEusR13nH1+m1Jf0=; b=NHLemwZ2SFJVN2DDESiS+inFiQTxo
        qozfwGi1E4c/jSGV5fN/iXRqHyd1Ot3fCXgsPhpEDC+HQyyewpnsKj5tRsxcUdK/
        nYn4YPCZebptPuqGxizveVIbFW20E4YgCEpajJL555BTU0IzjBggYRp6LJuJ1aFi
        oL4HdSKlGwB3f//JA/MnsCqym9HUQIdSkkLEdBXmRyiE95YoMVRK+6Z3ffENd0v6
        eodXi29zfOp9rNboh0nEX3hTC5Q6J7bRzehdrgF11iszGM/sMlUu2/oycm9Ahzk8
        0L9xqK1fHEzeThMgz0boO2cZfAd4107U9uOt0PFj2jfykDSw92R4bQhsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=d921gZrveLgVW10+cFYgvJSXNaGtEusR13nH1+m1Jf0=; b=PqvG9s5K
        hay7O1tv73p3Y7tBEWNLWfU7RFtb1XnZVILYE34g42SqCoxa2W6Fugs967Mvtjz3
        +ePu27QYMee5D0Uv7j0Mo/aMLUW1Su8hawM2OpfHVZIVJANX1ffoTVF9SaqO++KL
        uVJFEPROZ/FbTSnPp7+IyAuuPI93K6T/BJCmLmmF9zKNs7NeYauwbNIPWzZlbSqK
        jRJAm9Owd3cqxbiLA88JW2JLaODXTCWqJBzDUeVwRi3jVTkbPUUhXR4fiPo4FGkq
        dEtuJ/R04/k2s3gXz9XuSWSVLpjVzGPJP4kzLdoGgBWFiKPM55WJ/QcHhpXYY6wL
        A8cYHIrPm0wSsg==
X-ME-Sender: <xms:wGKjX8x3t0GvZ3DTNFqM1W0q_QXeTDYPOKonl4Sd886LVvStt7DhjA>
    <xme:wGKjXwRmxXBxktGaWN6HX4v9NCk24oVy6D0HJDzhjaWphwflJTwBytNHb6MS0S0Ed
    T2a0oE_bwVjWyAYUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucfkphepieelrddukedurddu
    tdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:wGKjX-VfxNg6Kjobcm0SQgzp_eRZj-pDG43INXfGmorda6gJtcH0Eg>
    <xmx:wGKjX6j-w_uzhkSHD4LbZgoi1A0iju5b9AurAFbcSy31-YSNsTqWiA>
    <xmx:wGKjX-AhYviP-1tCfDqdDtq9pPfsdVIGPTQ2BMi8OTM8AXUPXPdzcQ>
    <xmx:wGKjX5NS8B8CL-9EHx0Mo1s0iT6t7AfhBDTv20hhQWzpYnzoRCZrlA>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id A37AA32801D7;
        Wed,  4 Nov 2020 21:26:07 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
Date:   Wed,  4 Nov 2020 18:25:38 -0800
Message-Id: <4e3e8b9b525c8bed39c0ee2aa68f2dff701f56a4.1604542786.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604542786.git.dxu@dxuuu.xyz>
References: <cover.1604542786.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, bpf_probe_read_user_str() could potentially overcopy the
trailing bytes after the NUL due to how do_strncpy_from_user() does the
copy in long-sized strides. The issue has been fixed in the previous
commit.

This commit adds a selftest that ensures we don't regress
bpf_probe_read_user_str() again.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/prog_tests/probe_read_user_str.c      | 60 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 34 +++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
new file mode 100644
index 000000000000..597a166e6c8d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_probe_read_user_str.skel.h"
+
+static const char str[] = "mestring";
+
+void test_probe_read_user_str(void)
+{
+	struct test_probe_read_user_str *skel;
+	int fd, err, duration = 0;
+	char buf[256];
+	ssize_t n;
+
+	skel = test_probe_read_user_str__open_and_load();
+	if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
+		  "skeleton open and load failed\n"))
+		goto out;
+
+	err = test_probe_read_user_str__attach(skel);
+	if (CHECK(err, "test_probe_read_user_str__attach",
+		  "skeleton attach failed: %d\n", err))
+		goto out;
+
+	fd = open("/dev/null", O_WRONLY);
+	if (CHECK(fd < 0, "open", "open /dev/null failed: %d\n", fd))
+		goto out;
+
+	/* Give pid to bpf prog so it doesn't read from anyone else */
+	skel->bss->pid = getpid();
+
+	/* Ensure bytes after string are ones */
+	memset(buf, 1, sizeof(buf));
+	memcpy(buf, str, sizeof(str));
+
+	/* Trigger tracepoint */
+	n = write(fd, buf, sizeof(buf));
+	if (CHECK(n != sizeof(buf), "write", "write failed: %ld\n", n))
+		goto fd_out;
+
+	/* Did helper fail? */
+	if (CHECK(skel->bss->ret < 0, "prog ret", "prog returned: %d\n",
+		  skel->bss->ret))
+		goto fd_out;
+
+	/* Check that string was copied correctly */
+	err = memcmp(skel->bss->buf, str, sizeof(str));
+	if (CHECK(err, "memcmp", "prog copied wrong string"))
+		goto fd_out;
+
+	/* Now check that no extra trailing bytes were copied */
+	memset(buf, 0, sizeof(buf));
+	err = memcmp(skel->bss->buf + sizeof(str), buf, sizeof(buf) - sizeof(str));
+	if (CHECK(err, "memcmp", "trailing bytes were not stripped"))
+		goto fd_out;
+
+fd_out:
+	close(fd);
+out:
+	test_probe_read_user_str__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
new file mode 100644
index 000000000000..41c3e296566e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include <sys/types.h>
+
+struct sys_enter_write_args {
+	unsigned long long pad;
+	int syscall_nr;
+	int pad1; /* 4 byte hole */
+	unsigned int fd;
+	int pad2; /* 4 byte hole */
+	const char *buf;
+	size_t count;
+};
+
+pid_t pid = 0;
+int ret = 0;
+char buf[256] = {};
+
+SEC("tracepoint/syscalls/sys_enter_write")
+int on_write(struct sys_enter_write_args *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	ret = bpf_probe_read_user_str(buf, sizeof(buf), ctx->buf);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.28.0


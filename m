Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0C2A8739
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgKETaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:30:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42139 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732221AbgKETaC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 14:30:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 584F75C00EE;
        Thu,  5 Nov 2020 14:30:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 14:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UaRy2DWi1Qyi7
        0CmV76MDvFDVaBQWoSa3U4IeMYvayk=; b=VPiHMAX8AxaRcDsnYJuMYh6LJ8OmO
        tJlAFYbBdcKOC30FEd8RlfQeBTUCo10ognGTdCcfdF7nBDqhOUXUx63uA/0Hgny3
        cwHx4LUfyHkB3FMLy2RzumApgQNl7hnPqmir61iF3nyX3Uyko/fnNGBvkSXQDj0u
        NOvYgu0apKy4efOLWG/4wM9dAAfNQMOqRhISUQktZfTtk0waLjZUgp+Um+7wq+rU
        3juRJP9zS0p46cn2jSiKiyr72DO7SLrshGvRYHwGwJbg1Gsi1eaDxhBHxEOpeFQi
        0FQEsNPfptj7V5spo9E0+kzsxK4gWZVsyae/zTETokUMcDINeVeTFwjfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UaRy2DWi1Qyi70CmV76MDvFDVaBQWoSa3U4IeMYvayk=; b=VNo5c8pL
        Ti21zzMd69rfdSckNc74sNZtRjD3nj0AvNVZW4jlEkaxCG1fHhroyP+bcOLkyBHk
        UWszZ2DvP1oYWs/Hg2UmMt/kPLit1oBsQDN8yGGeFoCRIFgq8MBCOdz4w7e71E+N
        yMg82nXTITzEJB4ViUjzkeIqUtpW1FHrnO3NYmG4RIOSaEuwMnZ7pBo6BqYyzCtE
        bB0D56E42HT0lR1bKyJclWsabVQh7ScojjEGpRwxBSs/dQbIX7IDr3lpeCqDajYc
        JM5O/svObJQxL4xArS7GrLkz4LsfJ86kzrT5vdgh13uH3WF9zsRJKmv2DlpFl8I/
        DJQBKFzw8pTKoA==
X-ME-Sender: <xms:uVKkX_vBd-G8Ckdtp9bFOHnGQ79fipBt3Lp66SwlMpo_QNxI_jiIkA>
    <xme:uVKkXwc2n12KsnYTdBMQ9Jt1QBDireb8v7KpryQ5ILVLLOMA0BwTXH-LYZgdjxTy5
    B0KGWRaM9BYk56ZBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhf
    eggfdvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecukfhppeeiledrudekuddr
    uddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:uVKkXyyjKL_MBKPZZjX89dvJElQXw2maP3iZB5gcASd_CF79sJ_Xew>
    <xmx:uVKkX-NtWsDB2jLSIuoEQaphTDkyazXgUSwBf2EZ5KiOA9ijUv6xmA>
    <xmx:uVKkX_9_woi_dHSsgq7Z-qY2wjxFwzX78Ea75MfBAJoIHu7xsh47fQ>
    <xmx:uVKkX7Zq_cT0jMGcUKBbOSDeFzH2pAABDGakSnttviHvBRRFoDS_-g>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 578A53280394;
        Thu,  5 Nov 2020 14:30:00 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v3 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
Date:   Thu,  5 Nov 2020 11:29:22 -0800
Message-Id: <1d76e240e7b4fa264b3a50ebd391c4f0cc814919.1604604240.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604604240.git.dxu@dxuuu.xyz>
References: <cover.1604604240.git.dxu@dxuuu.xyz>
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
index 000000000000..7c6422901b78
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
+		return;
+
+	/* Give pid to bpf prog so it doesn't read from anyone else */
+	skel->bss->pid = getpid();
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
+	if (CHECK(skel->bss->ret < 0, "prog_ret", "prog returned: %ld\n",
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
index 000000000000..5da764a8bf85
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
+long ret = 0;
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


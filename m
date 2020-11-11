Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193AD2AFD34
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgKLBcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:05 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42209 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbgKKWqi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 17:46:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1EC889F4;
        Wed, 11 Nov 2020 17:46:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 11 Nov 2020 17:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=e+edu/6Q4wBbY
        YEXH8t+dOvgpbiWbWHOudleytAG4Gc=; b=wRAitTtIJLZuVX0UUBkgTz3WmQexj
        QHFccGR2MaKPp6jHmBkRqw3NZdocg14ROBnUNYwaHfMfSX5qt+YoKjMu007arqrW
        7g7PNKJ8QJo6I2oWbUlFWmU9JIvxmM4eX7JioYfwldjdUXQ0JqFMlZnxP8Yql8i/
        K/uywSbjbl4zTJC+2VrB1oWoDGaPQgkgtzAfcjs4opTKZ5OjBWSATi/Px0Wvm172
        luMptdwsE/RmWE93wOUkt+gitBgiaVTeJV6/PVH5iyjj8MLW6hRVsNzf37LSm1Fk
        nGkCtblAmkClRMzvlrgt2IatK0UotHdhAH3p/Zars7zzW2cZpck+LzqJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=e+edu/6Q4wBbYYEXH8t+dOvgpbiWbWHOudleytAG4Gc=; b=OgQn8tFz
        3IRVTygna6cMt3a7jB2fpoSLEH4heXyUZUHfHYz8g+n7+HJi3vthXHIetOxW+dJX
        eXC5lOY6JoG4biEsvLAHQuyGm8uSJ/OKutlfpmy4JXLZxziawxVSmXu8QqgpIP2H
        s1uY5WtHHfV8pqHahdnMZA12rvangT6cVYCY6xSHPp8SRRBb2BFYR22UsOuZRnzS
        KgPJkRcJgtXvGIDpXW1I60o48N0IbYmCF7y6PL3I3T2f/yRBxMrTPMhc7RdtdUhc
        okcDJV3bHCMTsddT+0OQ1nscWt7+XRxprUINF3NEPb890e4WqgW5H8ER8sAcUe2f
        9X26n+DdbUI25g==
X-ME-Sender: <xms:zGmsX7HmQkCso20j_AXD77jSobsBos1-34i9c9QjIpMotwgdeDE5UA>
    <xme:zGmsX4Vb4ejQ4dIAj9U6bw1HSMKu6pEX0HsUGkCCgQDlzFYXDtaQH4risCe2No4D3
    MKZFa1zDCPCbON0MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgkeduleekhfetvefhgefgvdegfeejfefguedvuddthffggffh
    hedtueeuteefieenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:zGmsX9LNKUxIOPG8R9O2Xa1Ur-qipNEJIA6vo-jQIMpgFBolbjpGzg>
    <xmx:zGmsX5G6Mhv38Xl2sJF3kLWf71gRIwiMRczMLooMIW9n4jFaaJ-5xg>
    <xmx:zGmsXxV6JyCYhh2SEz_h2LpTvq0v1m7oAqzZC4Z_81-GJBcC6rsUuA>
    <xmx:zGmsXzJaa2oZ9fzMOrxYQqC-71uu_HdK5Foezboz3zfpmqwHz5bDrg>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA98C3063067;
        Wed, 11 Nov 2020 17:46:35 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v5 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
Date:   Wed, 11 Nov 2020 14:45:55 -0800
Message-Id: <76d760cf4013887b9238c965564ae7c2415720db.1605134506.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605134506.git.dxu@dxuuu.xyz>
References: <cover.1605134506.git.dxu@dxuuu.xyz>
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

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
new file mode 100644
index 000000000000..e419298132b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_probe_read_user_str.skel.h"
+
+static const char str1[] = "mestring";
+static const char str2[] = "mestringalittlebigger";
+static const char str3[] = "mestringblubblubblubblubblub";
+
+static int test_one_str(struct test_probe_read_user_str *skel, const char *str,
+			size_t len)
+{
+	int err, duration = 0;
+	char buf[256];
+
+	/* Ensure bytes after string are ones */
+	memset(buf, 1, sizeof(buf));
+	memcpy(buf, str, len);
+
+	/* Give prog our userspace pointer */
+	skel->bss->user_ptr = buf;
+
+	/* Trigger tracepoint */
+	usleep(1);
+
+	/* Did helper fail? */
+	if (CHECK(skel->bss->ret < 0, "prog_ret", "prog returned: %ld\n",
+		  skel->bss->ret))
+		return 1;
+
+	/* Check that string was copied correctly */
+	err = memcmp(skel->bss->buf, str, len);
+	if (CHECK(err, "memcmp", "prog copied wrong string"))
+		return 1;
+
+	/* Now check that no extra trailing bytes were copied */
+	memset(buf, 0, sizeof(buf));
+	err = memcmp(skel->bss->buf + len, buf, sizeof(buf) - len);
+	if (CHECK(err, "memcmp", "trailing bytes were not stripped"))
+		return 1;
+
+	return 0;
+}
+
+void test_probe_read_user_str(void)
+{
+	struct test_probe_read_user_str *skel;
+	int err, duration = 0;
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
+	if (test_one_str(skel, str1, sizeof(str1)))
+		goto out;
+	if (test_one_str(skel, str2, sizeof(str2)))
+		goto out;
+	if (test_one_str(skel, str3, sizeof(str3)))
+		goto out;
+
+out:
+	test_probe_read_user_str__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
new file mode 100644
index 000000000000..3ae398b75dcd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include <sys/types.h>
+
+pid_t pid = 0;
+long ret = 0;
+void *user_ptr = 0;
+char buf[256] = {};
+
+SEC("tracepoint/syscalls/sys_enter_nanosleep")
+int on_write(void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	ret = bpf_probe_read_user_str(buf, sizeof(buf), user_ptr);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.29.2


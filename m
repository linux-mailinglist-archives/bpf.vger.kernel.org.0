Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C72B6F92
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 21:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgKQUF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 15:05:59 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53751 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730094AbgKQUF7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 15:05:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B9A71C4E;
        Tue, 17 Nov 2020 15:05:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 17 Nov 2020 15:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=e+edu/6Q4wBbY
        YEXH8t+dOvgpbiWbWHOudleytAG4Gc=; b=USaN3eDeLtIP4HGV8RR1/MyzaMSxC
        TInaSQX7xI55CMmbEgf2H5Xo1XMmuQN/xslcU+2Bopac/NKaVHOX/QnWU4Doe/Kr
        HbMWMOu7QJy7VCi+VR/SbeMrS5nDx3OTjK5IOK0M1xUO/S6kixMqzwySs2znu3/t
        l+/7Z1OhjowI6uYzDX3s+qWtw7sHcpEIZe+pkzWHXyXcfxZ9z+n+ABdAj26z/OYO
        oGCHsC2P5llqIlfpewSRsHPOcUu84+We479H5ZFh/XgDut5jkjANrLJN11/l4Qii
        D1U+QLnmYNS+1nd2rjLiuzlffloz9lUHO0CtWfcBBoMVVfwadKzcZVuPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=e+edu/6Q4wBbYYEXH8t+dOvgpbiWbWHOudleytAG4Gc=; b=kKjnQ9UI
        SXPOD6i/SbXLTwrVgcszqONFoEpIm1T7ep8MVz3GHwYDoBRcOBtzRBLL+dpJi78b
        1RafK+zEe2ZzGjz7U80GtWieYkuacGGWzsfuE0HrSVME3I3aZBXQ9LTXmwqHynu9
        zmVlN0z60yodrZhm+PHRPXf/F/+CLtJ8zKDsSotSY02Z+CqMa2YsJ1b3x6EKb3HM
        H0OoPLX2hvrruQlKk8AG0AuxxPpuf9MDxupXmVY3niajHcW2JJ9EFJB5WUZt6ySu
        SGheovvJhHrntSMeruKh3+4Z5vLy9v3lblOAXEW17nv6PoVEQkx3lgXmNn/GrK70
        BhLRh8oCVcaz9g==
X-ME-Sender: <xms:JS20X7J5JFqoFDTJl57m1ZyXBYeaTbKvia0UREaPYe4ouxA92_D2eA>
    <xme:JS20X_LY6_oUECAyqSXbXfg9W3h3IX3fHNwgm-qGNvw5PPZQeFwfboOE6FGahA97h
    p4CKQniT6gDidm29g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeffedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhephffvufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfekudelkefhteevhfeggfdvgeefjeefgfeuvddutdfhgffg
    hfehtdeuueetfeeinecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:JS20XzsjzY2xCNLAr3WzoDMBoYvI_YnaAY30vm7WqP6daZpOLh0f2g>
    <xmx:JS20X0ZuRpddUekKA1kQL9X_lsxPZ_qh9jdlzAl16q5Y3dL6vR0yAA>
    <xmx:JS20Xyac20hkR9iT1icYoPzS-DgFQa0R1W8heGPhImIUcj_sqX0SXg>
    <xmx:JS20X66DpY3aYAtzWi-sFwdDU14JWPorO6LddC-lz_p9nkDZsNErqw>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3AE5C3064AB0;
        Tue, 17 Nov 2020 15:05:56 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v7 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
Date:   Tue, 17 Nov 2020 12:05:46 -0800
Message-Id: <4d977508fab4ec5b7b574b85bdf8b398868b6ee9.1605642949.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605642949.git.dxu@dxuuu.xyz>
References: <cover.1605642949.git.dxu@dxuuu.xyz>
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


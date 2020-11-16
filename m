Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8961D2B539C
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgKPVRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 16:17:52 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56501 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKPVRu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 16:17:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 865D6D3D;
        Mon, 16 Nov 2020 16:17:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 Nov 2020 16:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=e+edu/6Q4wBbY
        YEXH8t+dOvgpbiWbWHOudleytAG4Gc=; b=ZyeRn45KhNZPyKfrFOUYMW2Z1tIcd
        G/AdXINYADc+YmzDKlYxZ1rjCgpV9GsEKOGjPd0OLHIlbkwo5JbtmcAayg9+F1H0
        IQyrffwlNAjSFayyN4TibHMUxTMBjT5e6BFcMjhcwgjwXkZ4A9RGNzQ53EiKNXRo
        Cpeybi7jhD90EzeuUfK4WjHY0iF7OO9/6lzbPFy8sjM1yPditmiiVn3Ul0OBg4No
        KRHAJBCrH6D/DBczToqxLHVXfOvuASicidfwUmnjpxbzskXy9zff+O960DJYkvA0
        WLmFEF88wKlGGy/iVKSCcRtiT1To+/mEnxgAFpJvg6CWh+6aSNrgkTWSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=e+edu/6Q4wBbYYEXH8t+dOvgpbiWbWHOudleytAG4Gc=; b=Ro8PCpDM
        ll0q3vvStJBNmj7mx0Bj3AdKGhT/5eMakCu+ZIaV2LIsvJOxJQ+2S49denIBBGjz
        6W+nxbIPXlHRiaMqEtki5ne04tnI6qeZenBTNFrLpW0bWFtcJz/vHC8JfiTIzCew
        EhvgMuvZHOwM/DM7r6m7eiYFq2xyOrPYySs6TGfeEN0Qzh8fZWxqH1pvhLPC7vB3
        ByFhhgjtA551KC5QXCcxNta+P9kSl82g1H5Y8NiH6ucAdTGAm2iiQdH5FV5GWzr7
        X0XK2LUB1yj/CJwzR1v6nzvX7/41RqS8Ym4cgtOIYW4Uy5Q11W7CvxFgAhPPu2KH
        jcLZJ5ozgfHGrw==
X-ME-Sender: <xms:feyyX98fguWICnzxJ3mIRy6kdkoOEberptSU7WrNhCqfMF_4geLWXw>
    <xme:feyyXxsIlKwVZAKjshwxrVy8ogIJva83HSLB_peMtAhNKIp8BNfMh9CbvSRBoIuTH
    AFP9au0_WyHXRBkSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhephffvufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfekudelkefhteevhfeggfdvgeefjeefgfeuvddutdfhgffg
    hfehtdeuueetfeeinecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:feyyX7ANlFRLiP1wuLFNkn8Zx0txheVjJ-mDcZcjuQooLiHq-f-t_Q>
    <xmx:feyyXxdgeYojbwYqLPGq0vedQYXuh-QZ972Zq9MnjS35H4Cg4ME8Hg>
    <xmx:feyyXyNYesXT8Xwtwi8J2HU_zRjZc_xP43cI5Wpg3x0R5HQJVmrttg>
    <xmx:feyyXxfPS7jsobd0SNLtdLMN97hCeYs1Ka66G_or06eKaP4m1GHcPA>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A9383280067;
        Mon, 16 Nov 2020 16:17:47 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v6 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
Date:   Mon, 16 Nov 2020 13:17:32 -0800
Message-Id: <fdeb232fd596dbc70760b18a32a0a91cefd3028e.1605560917.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605560917.git.dxu@dxuuu.xyz>
References: <cover.1605560917.git.dxu@dxuuu.xyz>
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


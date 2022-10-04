Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCB85F425B
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 13:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJDLui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 07:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJDLuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 07:50:15 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29032409A;
        Tue,  4 Oct 2022 04:50:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MhbSw1Vs8z9xHwF;
        Tue,  4 Oct 2022 19:44:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXU16kHTxjYVKaAA--.62750S8;
        Tue, 04 Oct 2022 12:49:45 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 6/6] selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()
Date:   Tue,  4 Oct 2022 13:48:39 +0200
Message-Id: <20221004114839.2302206-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004114839.2302206-1-roberto.sassu@huaweicloud.com>
References: <20221004114839.2302206-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXU16kHTxjYVKaAA--.62750S8
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rJF43GFW8uF4UGryUKFg_yoW7Zry8pa
        93Cr1akryFqr4093sxJF43Gw4xKF18Z34Ut3s7WF15Zr10q3Z7W348GF13tF9xuFZ5Cwsx
        u3y3trWUGrW7uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4POuwADsO
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the data_input map, write-protected with a small eBPF program
implementing the lsm/bpf_map hook.

Then, ensure that bpf_map_get_fd_by_id() and bpf_map_get_fd_by_id_opts()
with NULL opts don't succeed due to requesting read-write access to the
write-protected map. Also, ensure that bpf_map_get_fd_by_id_opts() with
open_flags in opts set to BPF_F_RDONLY instead succeeds.

After obtaining a read-only fd, ensure that only map lookup succeeds and
not update. Ensure that update works only with the read-write fd obtained
at program loading time, when the write protection was not yet enabled.

Finally, ensure that the other _opts variants of bpf_*_get_fd_by_id() don't
work if the BPF_F_RDONLY flag is set in opts (due to the kernel not
handling the open_flags member of bpf_attr).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../bpf/prog_tests/libbpf_get_fd_opts.c       | 88 +++++++++++++++++++
 .../bpf/progs/test_libbpf_get_fd_opts.c       | 36 ++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
new file mode 100644
index 000000000000..2d4ba8f80d55
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <test_progs.h>
+
+#include "test_libbpf_get_fd_opts.skel.h"
+
+void test_libbpf_get_fd_opts(void)
+{
+	struct test_libbpf_get_fd_opts *skel;
+	struct bpf_map_info info_m = { 0 };
+	__u32 len = sizeof(info_m), value;
+	struct bpf_map *map;
+	int ret, zero = 0, fd = -1;
+
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, fd_opts_rdonly,
+		.open_flags = BPF_F_RDONLY,
+	);
+
+	skel = test_libbpf_get_fd_opts__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_libbpf_get_fd_opts__open_and_load"))
+		return;
+
+	ret = test_libbpf_get_fd_opts__attach(skel);
+	if (!ASSERT_OK(ret, "test_libbpf_get_fd_opts__attach"))
+		goto close_prog;
+
+	map = bpf_object__find_map_by_name(skel->obj, "data_input");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
+		goto close_prog;
+
+	ret = bpf_obj_get_info_by_fd(bpf_map__fd(map), &info_m, &len);
+	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
+		goto close_prog;
+
+	fd = bpf_map_get_fd_by_id(info_m.id);
+	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id"))
+		goto close_prog;
+
+	fd = bpf_map_get_fd_by_id_opts(info_m.id, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id_opts"))
+		goto close_prog;
+
+	fd = bpf_map_get_fd_by_id_opts(info_m.id, &fd_opts_rdonly);
+	if (!ASSERT_GE(fd, 0, "bpf_map_get_fd_by_id_opts"))
+		goto close_prog;
+
+	/* Map lookup should work with read-only fd. */
+	ret = bpf_map_lookup_elem(fd, &zero, &value);
+	if (!ASSERT_OK(ret, "bpf_map_lookup_elem"))
+		goto close_prog;
+
+	if (!ASSERT_EQ(value, 0, "map value mismatch"))
+		goto close_prog;
+
+	/* Map update should not work with read-only fd. */
+	ret = bpf_map_update_elem(fd, &zero, &len, BPF_ANY);
+	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem"))
+		goto close_prog;
+
+	/* Map update should work with read-write fd. */
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &len, BPF_ANY);
+	if (!ASSERT_OK(ret, "bpf_map_update_elem"))
+		goto close_prog;
+
+	/* Prog get fd with opts set should not work (no kernel support). */
+	ret = bpf_prog_get_fd_by_id_opts(0, &fd_opts_rdonly);
+	if (!ASSERT_EQ(ret, -EINVAL, "bpf_prog_get_fd_by_id_opts"))
+		goto close_prog;
+
+	/* Link get fd with opts set should not work (no kernel support). */
+	ret = bpf_link_get_fd_by_id_opts(0, &fd_opts_rdonly);
+	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
+		goto close_prog;
+
+	/* BTF get fd with opts set should not work (no kernel support). */
+	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
+	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
+
+close_prog:
+	close(fd);
+	test_libbpf_get_fd_opts__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c
new file mode 100644
index 000000000000..f5ac5f3e8919
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* From include/linux/mm.h. */
+#define FMODE_WRITE	0x2
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} data_input SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm/bpf_map")
+int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
+{
+	if (map != (struct bpf_map *)&data_input)
+		return 0;
+
+	if (fmode & FMODE_WRITE)
+		return -EACCES;
+
+	return 0;
+}
-- 
2.25.1


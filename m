Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD3585782
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 02:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiG3AIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 20:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 20:08:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340012DD2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:08:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s186-20020a255ec3000000b0067162ed1bd3so4905421ybb.8
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ygYl5hGZ24k4L+KNLWiCjZLerg9rcrzN2XqVmkrfAqI=;
        b=lRW6K6xsNU098e9/CzalGgViIHKpHRG5NVC2/eGInDRQas8UZK2jh3f+JXHi52zWRe
         qdkgWOPGNvv8kpY94i8PJ4dafwW9WGgpmS05HO7cwEJ9LJDZ+/i+019NwLq/CDi4b4bR
         749VCJBE97ZCVkAKrqib9ZcBiXEMEBaecbohh26jaNnCiIHcr+Dt22HCE7YnJIvd5H+8
         d9wTKuXRkEX2OjidVZnugsc7HjCLeVOcEvihIkRAT4NJlt43fwCWQ7QEdIUAfxLhnW/Z
         QbGTI0Z3Ta2dfieOig27J2SzXZ3T8JzhlrutqFLyR/KEf5Y14iBAhLRf1D6J59rzFN2R
         xAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ygYl5hGZ24k4L+KNLWiCjZLerg9rcrzN2XqVmkrfAqI=;
        b=OSfgNpbicBcb68P/sb7WJA5Du29zWrfkXgD9q9jprsHGOT57GxnBRSQ8L2i7JfATyR
         dEgwidCCe71Rc30LKhiOFyj5K3Jgbk+azGjPDbkw8wgvoBQokw1+trOeYx79DnS6a0Nv
         ztU6T+DzeSlv6AazFkymOxLEyBLJBYDRNYYND61sRyFx02nCyvJ49U2guqoMXB3uEEMv
         KAq44Yrg/x41s8BoAHsavwgnpb/afW1MW0AebZ5gab70V3pAKN5TUpWV1SBVH3bnKlS4
         ldNdI7AzbjHela2EdnWYbGS7jdW19sH7niCQplVNKW1ZpFDLMxp6R7xyfK+BDAa0hWv0
         dnAQ==
X-Gm-Message-State: ACgBeo0+Z9DeGPGiCIsfoFI0WnO/5VKDync5k1ljbVKOKmd8vyhPqzqX
        774v9DzdDyjM/Gy7qU8Mz1xMIQX4EvE+qpdaN1pYHnho3uoVJgUHFETDkJY2GegovE9tfzfmmUS
        yLNcQzRHu6PAuAWTqKJfvzpRPX27zbgu+8OpOU0LzQHxSgCDLTA==
X-Google-Smtp-Source: AA6agR4MtEXVw6YNpH0DwpqrZTk1HTCqpD9WIXG4rRmYAG6eiNgxzdeHCLD6uXtgfPIWLlaqhwxgTFU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:3841:0:b0:670:a1b9:f18e with SMTP id
 f62-20020a253841000000b00670a1b9f18emr4498939yba.480.1659139693332; Fri, 29
 Jul 2022 17:08:13 -0700 (PDT)
Date:   Fri, 29 Jul 2022 17:08:09 -0700
In-Reply-To: <20220730000809.312891-1-sdf@google.com>
Message-Id: <20220730000809.312891-2-sdf@google.com>
Mime-Version: 1.0
References: <20220730000809.312891-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
 for bpf2bpf
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Apparently, no existing selftest covers it. Add a new one where
we load cgroup/bind4 program and attach fentry to it.
Calling bpf_obj_get_info_by_fd on the fentry program
should return non-zero btf_id/btf_obj_id instead of crashing the kernel.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/attach_to_bpf.c  | 109 ++++++++++++++++++
 .../selftests/bpf/progs/attach_to_bpf.c       |  12 ++
 2 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
new file mode 100644
index 000000000000..fcf726c5ff0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "attach_to_bpf.skel.h"
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct btf *btf;
+	int err;
+
+	err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
+	if (err)
+		return err;
+
+	if (!info.btf_id)
+		return -EINVAL;
+
+	btf = btf__load_from_kernel_by_id(info.btf_id);
+	err = libbpf_get_error(btf);
+	if (err)
+		return err;
+
+	err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
+	btf__free(btf);
+	if (err <= 0)
+		return err;
+
+	return err;
+}
+
+int load_fentry(int attach_prog_fd, int attach_btf_id)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .expected_attach_type = BPF_TRACE_FENTRY,
+		    .attach_prog_fd = attach_prog_fd,
+		    .attach_btf_id = attach_btf_id,
+		    .log_buf = bpf_log_buf,
+		    .log_size = sizeof(bpf_log_buf),
+	);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_TRACING,
+			    "bind4_fentry",
+			    "GPL",
+			    insns,
+			    ARRAY_SIZE(insns),
+			    &opts);
+	if (ret)
+		printf("verifier log: %s\n", bpf_log_buf);
+	return ret;
+}
+
+void test_attach_to_bpf(void)
+{
+	struct attach_to_bpf *skel = NULL;
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int cgroup_fd = -1;
+	int fentry_fd = -1;
+	int btf_id;
+
+	cgroup_fd = test__join_cgroup("/attach_to_bpf");
+	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
+		return;
+
+	skel = attach_to_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto cleanup;
+
+	skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
+		goto cleanup;
+
+	btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
+	if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
+		goto cleanup;
+
+	fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
+	if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
+		goto cleanup;
+
+	/* Make sure bpf_obj_get_info_by_fd works correctly when attaching
+	 * to another BPF program.
+	 */
+
+	if (!ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
+		       "bpf_obj_get_info_by_fd"))
+		goto cleanup;
+
+	ASSERT_EQ(info.btf_id, 0, "info.btf_id");
+	ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
+	ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
+
+cleanup:
+	close(cgroup_fd);
+	close(fentry_fd);
+	attach_to_bpf__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
new file mode 100644
index 000000000000..3f111fe96f8f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("cgroup/bind4")
+int bind4(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.37.1.455.g008518b4e5-goog


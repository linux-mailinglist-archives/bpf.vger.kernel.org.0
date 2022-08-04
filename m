Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B958A1BC
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiHDULs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDULr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 16:11:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBB37198
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 13:11:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u10-20020a170903124a00b0016ec85be3b7so417773plh.4
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=30Emi3SMrXwu+b6cWsFjLfn6+oKpZm9q+MSWjpuMsbk=;
        b=h8Fp5ZK1kS+GoM9qNzV1iz37NbKYwoycgcw51gUqzO9YTxmebS26b7ekeIcn/DUHOu
         ka3YGfZR4siHJgiOlFOgKk6MB8B/JhbAe6GLgkZi74AtC1JUoQf6RKdLaReP/Cr1Pxff
         YDAvV6CdvtOHPcGQR5Z4rgS2SuVFGiOmx/zpNWO0Z5iV17QfaGES21APyD1PEDUb7brC
         ycb0/80eawjEL13+QMY9oQQqI8xqJWv9ZKauX1jjzmww789Dt+YHRf/tpUouvyBBuc+I
         ZhHNq3zpoedEfAABsrBm4goqlViAMvXDJFUMtQ4ZLArBPhhZBpZgWJYdJnIRje7IW3is
         I6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=30Emi3SMrXwu+b6cWsFjLfn6+oKpZm9q+MSWjpuMsbk=;
        b=AqwoRwK/hgsp/dYNUHslaaBBZ4X4VYN1LNZVazJZuf5oew3agTqEAYnwLTTUdriNXE
         GPIpDC/i1M8Rdqs7IzoTUaggP4zbC199DD/VVNWH0PF5+CC8Ke6qrVyp8ImVihBMQQWn
         pHZcudo+Dfl6FRBibH/r55RW0ViLZ+qnl5XV3kX77dakPj6tW5rWbuSQvuGHYgJuxgFw
         OXJ77m/sFx84o/lVQnYVh4izjWoY3gcMNzRraXPm8I54o21htOTwUerwxxZJlQBKoLu4
         YYixnrNsxyVCQM7BE7ohAqFWOpEmLHgHIVdIxp4+ien/ZSHwst6tQOucTE12qq5ln8GG
         pXbA==
X-Gm-Message-State: ACgBeo2EqVuJwbB/VUh7eBUQslT2aq3xLDO+RjwX+7O4Q7W/o915G+pp
        NiYSc08GqwrSYnll9Kr4w3M0+0JtsHKC9a3t1YahZ/elCQ38Mmd0D93ViRJhzRYInO3orWslNxz
        Qef71dv8UZs/UK9kpb93GUZKiVIxxZHH9J4wuCcsef4cEYSaalA==
X-Google-Smtp-Source: AA6agR5T4F1sB8rEzkk8jQC9eIC50zgO9oi3WkiWsZuj8gQ/NB8XyJtmtq7ZWbJJCVuVyN3VZYWTfyI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:1e50:b0:1f5:4f69:d6b8 with SMTP id
 pi16-20020a17090b1e5000b001f54f69d6b8mr9295250pjb.34.1659643904163; Thu, 04
 Aug 2022 13:11:44 -0700 (PDT)
Date:   Thu,  4 Aug 2022 13:11:40 -0700
In-Reply-To: <20220804201140.1340684-1-sdf@google.com>
Message-Id: <20220804201140.1340684-2-sdf@google.com>
Mime-Version: 1.0
References: <20220804201140.1340684-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
 for bpf2bpf
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
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

v3:
- move into fexit_bpf2bpf.c (Martin)
- assert on skel->links.bind_v4_prog (Andrii)
- do no close(-1) unconditionally (Andrii)

v2:
- use ret instead of err in find_prog_btf_id (Hao)
- remove verifier log (Hao)
- drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 02bb8cbf9194..da860b07abb5 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <bpf/btf.h>
+#include "bind4_prog.skel.h"
 
 typedef int (*test_cb)(struct bpf_object *obj);
 
@@ -407,6 +408,98 @@ static void test_func_replace_global_func(void)
 				  prog_name, false, NULL);
 }
 
+static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct btf *btf;
+	int ret;
+
+	ret = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
+	if (ret)
+		return ret;
+
+	if (!info.btf_id)
+		return -EINVAL;
+
+	btf = btf__load_from_kernel_by_id(info.btf_id);
+	ret = libbpf_get_error(btf);
+	if (ret)
+		return ret;
+
+	ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
+	btf__free(btf);
+	return ret;
+}
+
+static int load_fentry(int attach_prog_fd, int attach_btf_id)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .expected_attach_type = BPF_TRACE_FENTRY,
+		    .attach_prog_fd = attach_prog_fd,
+		    .attach_btf_id = attach_btf_id,
+	);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return bpf_prog_load(BPF_PROG_TYPE_TRACING,
+			     "bind4_fentry",
+			     "GPL",
+			     insns,
+			     ARRAY_SIZE(insns),
+			     &opts);
+}
+
+static void test_fentry_to_cgroup_bpf(void)
+{
+	struct bind4_prog *skel = NULL;
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int cgroup_fd = -1;
+	int fentry_fd = -1;
+	int btf_id;
+
+	cgroup_fd = test__join_cgroup("/fentry_to_cgroup_bpf");
+	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
+		return;
+
+	skel = bind4_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto cleanup;
+
+	skel->links.bind_v4_prog = bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bind_v4_prog, "bpf_program__attach_cgroup"))
+		goto cleanup;
+
+	btf_id = find_prog_btf_id("bind_v4_prog", bpf_program__fd(skel->progs.bind_v4_prog));
+	if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
+		goto cleanup;
+
+	fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind_v4_prog), btf_id);
+	if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
+		goto cleanup;
+
+	/* Make sure bpf_obj_get_info_by_fd works correctly when attaching
+	 * to another BPF program.
+	 */
+
+	ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
+		  "bpf_obj_get_info_by_fd");
+
+	ASSERT_EQ(info.btf_id, 0, "info.btf_id");
+	ASSERT_EQ(info.attach_btf_id, btf_id, "info.attach_btf_id");
+	ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
+
+cleanup:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	if (fentry_fd >= 0)
+		close(fentry_fd);
+	bind4_prog__destroy(skel);
+}
+
 /* NOTE: affect other tests, must run in serial mode */
 void serial_test_fexit_bpf2bpf(void)
 {
@@ -430,4 +523,6 @@ void serial_test_fexit_bpf2bpf(void)
 		test_fmod_ret_freplace();
 	if (test__start_subtest("func_replace_global_func"))
 		test_func_replace_global_func();
+	if (test__start_subtest("fentry_to_cgroup_bpf"))
+		test_fentry_to_cgroup_bpf();
 }
-- 
2.37.1.559.g78731f0fdb-goog


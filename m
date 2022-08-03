Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AD589091
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiHCQc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiHCQcl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 12:32:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6413D49
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 09:32:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e15-20020a17090301cf00b0016dc94ddcc5so9879477plh.3
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=SukYyRBj0PBu8Y8CxenxhUH2n9Ih4HE5W3Jlsud6SuY=;
        b=O1BVSSlIXHvyKx+doLjw/vG7Bz5JG26IzeqJbUoO4mtgLWjs0KnD9sCUmIf0dXDaCz
         gysAAB/TgKCm3OLcse9pNAuxT4UEqE1VAorijZ4s0mJd1gTK/F1ifPchZr/GrhkHywjn
         YHxpNoDvh7QGW5/aIpaUlxRpXOaOg1xP1/MlmdnR/+T52TJYeNtWdYY7iQnChQ/splEm
         P4wC/MNidJRZdfGUpQ/s+M1/OaHuLs05OIJpEhMl9rN8kBdQPy3jOqpItJVb0Kxjk+6W
         +CUKtg1bwM+Mfx103MiSWNCBvjWZJExYrXN9bQhJ+SuG+/lyFHzXqW6OuCdThEEgP6BB
         ZRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=SukYyRBj0PBu8Y8CxenxhUH2n9Ih4HE5W3Jlsud6SuY=;
        b=nVx/YRJngz6c2TumlvGcyn7Q9eNfFvX88OxKjZMDGe7Q8/mH3kfR7XSzvvhgadI9lU
         ydBphKn17DfhrBPkPdd2QvGfztKhlDX7u70GLkhV8OE8X0tu+ncZsDwMkFESNQvuS+tt
         AG3ePmjpTCljG0U52uKeELtiJHwJtEBXqf5kYJbOgDQJwamidTGrawWTHxesdjgfUUos
         dvBSiwDhye1VZJgy8HLIxQkFnoSGVtgP1m2ZHfigR0pwnFZyROxQi/mr2rhj5OgwlQQs
         4AZ6xr0G4b7X8Z3ma4X0XBk27WVItk1VrxkQ+36/uKicAA+JlPaFsR7F6TyETwoe36V0
         EZwA==
X-Gm-Message-State: ACgBeo2SXeO3qaM/mDUlFDSEPPzsA9MYsndYs00UiY/ZtA4JWKflt6Fb
        XrAxMJJ2xkviMeIcDMPBf4MI65g1iKqQRzzvybt+rbyGD4frmPRnsV1icef0olzNosaGoESlbJx
        67hmFsSJCd/+TS6JFo70mwyvAQIa3l/QUhbE1surbXmJJgFxlMw==
X-Google-Smtp-Source: AA6agR5QgfRqQIaDOxHtipqC2inCO0Lu4JEotQIAQEn/5NP+KntnVOT6YGuPU8n8LXA2mxLiFHR9U0E=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:3b43:b0:1f4:e3ad:e45a with SMTP id
 ot3-20020a17090b3b4300b001f4e3ade45amr5720625pjb.87.1659544346576; Wed, 03
 Aug 2022 09:32:26 -0700 (PDT)
Date:   Wed,  3 Aug 2022 09:32:23 -0700
In-Reply-To: <20220803163223.3747004-1-sdf@google.com>
Message-Id: <20220803163223.3747004-2-sdf@google.com>
Mime-Version: 1.0
References: <20220803163223.3747004-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
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

v3:
- move into fexit_bpf2bpf.c (Martin)
- assert on skel->links.bind_v4_prog (Andrii)
- do no close(-1) unconditionally (Andrii)

v2:
- use ret instead of err in find_prog_btf_id (Hao)
- remove verifier log (Hao)
- drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 02bb8cbf9194..fb62cef35e42 100644
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
+	ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
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
2.37.1.455.g008518b4e5-goog


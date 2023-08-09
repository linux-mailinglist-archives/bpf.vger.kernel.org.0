Return-Path: <bpf+bounces-7347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC6D775E12
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAF3281148
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E902418000;
	Wed,  9 Aug 2023 11:44:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA97154B4
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:44:37 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B09B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:44:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so177397866b.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581472; x=1692186272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLXU92UH2ZvHSkyu6SiYNwHbPWtUAEB+uZUUM4BB628=;
        b=Nes576yikwYwQC6nxYlKX0fsVNt6idny/ZAHc+2Z6gwFgk1Brg2nmTccCbAL5BE/r/
         srzapPCVh+0T/vGv57fGzAYe1tZ/IvDjmCD4GUijd5R846+NJnWfcBFSJ91MYBryd4l0
         fWD8+4UZ5L9Vx0YvYResrWFzV3tMufxi2Pl+AlZkvRY1VzStEYotsoGhIuakS4H4/FF2
         9fJRYkYHqOKjKD9iBeU7fOF/XMrP0SSzJHT8VWAWSkmH1gA0uPrx90wZTzRlgQWV0lvn
         DXyhSfPmQq/MuhU1VMR8JI+2aWU3KhpOs59e+gzuLRNgmquzCofOiDb7vQ1zQsOXHGHv
         EbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581472; x=1692186272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLXU92UH2ZvHSkyu6SiYNwHbPWtUAEB+uZUUM4BB628=;
        b=F1se0bfbY7sP3HGPwG+RluG6WQagD0+S0yjLysSiHdmDYRlbiYrunFp9pAPNTZJ5f1
         r8RuSIJULExfB2qjyT7U8K6GoaVGyU75YlO1av0hHXu8qwfn1V2kB1mxvYT6nRURA+OG
         3XIfZsJUOWtsueeexGuWQsqkCIVUoay4vdpwYz4/SdiRkCHLObhYPeYmgHvpoZGIZotT
         tk4xuUUuau4p4WCAKAc7OrwyfrUc7rOZy4bxN6erE3TH9ETwM0XYvtQf1NpiWV478XoR
         STU/fNaW7L2iD6k/23skbDgHThcKAZjdVlI5wM3pHOZcpX9qY4xgPtrTPBdq7KjQ4daL
         JlzA==
X-Gm-Message-State: AOJu0YzU14Pn1x9S6aUD+E+2oNFND/gjcDdR8N2T+FD6LKhzJIHLGpoo
	UEzroITEkJzUUmOoR/boTzfT8u+99iOlIduLPOQ=
X-Google-Smtp-Source: AGHT+IHVZps0tBC/yEP/8OttK8JS/CW18gJGzsv42Rl94KlgB8n5H1oK695WjQP0LcFhlb57k6FoQw==
X-Received: by 2002:a17:907:6096:b0:974:fb94:8067 with SMTP id ht22-20020a170907609600b00974fb948067mr14903278ejc.23.1691581472372;
        Wed, 09 Aug 2023 04:44:32 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090685cf00b0099d4bfa87a7sm272609ejy.199.2023.08.09.04.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:44:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 14/14] selftests/bpf: Add tests for BPF exceptions
Date: Wed,  9 Aug 2023 17:11:16 +0530
Message-ID: <20230809114116.3216687-15-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=37831; i=memxor@gmail.com; h=from:subject; bh=6AbUaD+cL0MCUKe2a8zqLMJkKunZj53iars50LCf2Dc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJ9dqD89oEfPbcr+eHBZxL5t4jqH3JboNVj YKU/tUVxNyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R ymasD/9VfTTvJdHCDaq7sjiTHptI3Cj9PUEE0Kdkkeshkp6xQ8YVS+fIzSECXekYCRplcMSzkuJ rDLUb4f0FNmI7y1BLILaJK6IM25sK4yjCb4aguV+UZ6hQDbmTWe9Mdth0ciAVIdp5+xpokVlQ0T AIRa5yGAVHJQW2TOdoAS149OiRjBSp5SqDy67ntD6gbC+1Ogix6bTWUywZan63no9pIx2RQN8QC PqK3RB7vidtiBls7KnrDK+BUpeswo2YaI61Hcu6LePq0FOhv+RG6oa5HGF5fHzH+8eHbA1EFRfU M87cbP1ZBSsOFSA1NkRLi0EdOXPT61vMuFkpstxkfArUPHBbb9tnRYBmS60zk9XB6ptA2ETeYOF vzTJEH8GE12iZ/GEfyYK1E7wiNB4d0pDTIj7+HkHdVpXRh2765yIiU7aVE2gQpthOKbNKUn9twS DzuLcO8DaYl1qCkIF9oZAtVvqCuqwNBpImh1w7SyA893csoCZB1iJ0zfgd0MSphY5wGSW0w86Sc 2r5oIl28MOQ7udDcUxpytxjGodAOBIl3QgdEmwhSR9vUPyntRTji9JjMFpwFi8VE65aDtpO1IPT 0f6AelN46KpRuislCuTNuRshhdPLyaJ39VKvzY/0G4q0H2uT0tlR4aw0vEVH9z5OQ1YmGre71VK rIx0EyzEFs1rusw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftests to cover success and failure cases of API usage, runtime
behavior and invariants that need to be maintained for implementation
correctness.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/exceptions.c     | 324 +++++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 368 ++++++++++++++++++
 .../selftests/bpf/progs/exceptions_assert.c   | 135 +++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  59 +++
 .../selftests/bpf/progs/exceptions_fail.c     | 347 +++++++++++++++++
 7 files changed, 1235 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 3b61e8b35d62..432af22973b1 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,5 +1,6 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
+exceptions					 # JIT does not support calling kfunc bpf_throw: -524
 fexit_sleep                                      # The test never returns. The remaining tests cannot start.
 kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 5061d9e24c16..ce6f291665cf 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -6,6 +6,7 @@ bpf_loop                                 # attaches to __x64_sys_nanosleep
 cgrp_local_storage                       # prog_attach unexpected error: -524                                          (trampoline)
 dynptr/test_dynptr_skb_data
 dynptr/test_skb_readonly
+exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 fexit_sleep                              # fexit_skel_load fexit skeleton failed                                       (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 iters/testmod_seq*                       # s390x doesn't support kfuncs in modules yet
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
new file mode 100644
index 000000000000..4a0b9910dab3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "exceptions.skel.h"
+#include "exceptions_ext.skel.h"
+#include "exceptions_fail.skel.h"
+#include "exceptions_assert.skel.h"
+
+static char log_buf[1024 * 1024];
+
+static void test_exceptions_failure(void)
+{
+	RUN_TESTS(exceptions_fail);
+}
+
+static void test_exceptions_success(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, ropts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct exceptions_ext *eskel = NULL;
+	struct exceptions *skel;
+	int ret;
+
+	skel = exceptions__open();
+	if (!ASSERT_OK_PTR(skel, "exceptions__open"))
+		return;
+
+	ret = exceptions__load(skel);
+	if (!ASSERT_OK(ret, "exceptions__load"))
+		goto done;
+
+	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.jmp_table), &(int){0},
+					   &(int){bpf_program__fd(skel->progs.exception_tail_call_target)}, BPF_ANY),
+		       "bpf_map_update_elem jmp_table"))
+		goto done;
+
+#define RUN_SUCCESS(_prog, return_val)						  \
+	if (!test__start_subtest(#_prog)) goto _prog##_##return_val;		  \
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs._prog), &ropts); \
+	ASSERT_OK(ret, #_prog " prog run ret");					  \
+	ASSERT_EQ(ropts.retval, return_val, #_prog " prog run retval");		  \
+	_prog##_##return_val:
+
+	RUN_SUCCESS(exception_throw_always_1, 64);
+	RUN_SUCCESS(exception_throw_always_2, 32);
+	RUN_SUCCESS(exception_throw_unwind_1, 16);
+	RUN_SUCCESS(exception_throw_unwind_2, 32);
+	RUN_SUCCESS(exception_throw_default, 0);
+	RUN_SUCCESS(exception_throw_default_value, 5);
+	RUN_SUCCESS(exception_tail_call, 24);
+	RUN_SUCCESS(exception_ext, 0);
+	RUN_SUCCESS(exception_ext_mod_cb_runtime, 35);
+	RUN_SUCCESS(exception_throw_subprog, 1);
+	RUN_SUCCESS(exception_assert_nz_gfunc, 1);
+	RUN_SUCCESS(exception_assert_zero_gfunc, 1);
+	RUN_SUCCESS(exception_assert_neg_gfunc, 1);
+	RUN_SUCCESS(exception_assert_pos_gfunc, 1);
+	RUN_SUCCESS(exception_assert_negeq_gfunc, 1);
+	RUN_SUCCESS(exception_assert_poseq_gfunc, 1);
+	RUN_SUCCESS(exception_assert_nz_gfunc_with, 1);
+	RUN_SUCCESS(exception_assert_zero_gfunc_with, 1);
+	RUN_SUCCESS(exception_assert_neg_gfunc_with, 1);
+	RUN_SUCCESS(exception_assert_pos_gfunc_with, 1);
+	RUN_SUCCESS(exception_assert_negeq_gfunc_with, 1);
+	RUN_SUCCESS(exception_assert_poseq_gfunc_with, 1);
+	RUN_SUCCESS(exception_bad_assert_nz_gfunc, 0);
+	RUN_SUCCESS(exception_bad_assert_zero_gfunc, 0);
+	RUN_SUCCESS(exception_bad_assert_neg_gfunc, 0);
+	RUN_SUCCESS(exception_bad_assert_pos_gfunc, 0);
+	RUN_SUCCESS(exception_bad_assert_negeq_gfunc, 0);
+	RUN_SUCCESS(exception_bad_assert_poseq_gfunc, 0);
+	RUN_SUCCESS(exception_bad_assert_nz_gfunc_with, 100);
+	RUN_SUCCESS(exception_bad_assert_zero_gfunc_with, 105);
+	RUN_SUCCESS(exception_bad_assert_neg_gfunc_with, 200);
+	RUN_SUCCESS(exception_bad_assert_pos_gfunc_with, 0);
+	RUN_SUCCESS(exception_bad_assert_negeq_gfunc_with, 101);
+	RUN_SUCCESS(exception_bad_assert_poseq_gfunc_with, 99);
+	RUN_SUCCESS(exception_assert_range, 1);
+	RUN_SUCCESS(exception_assert_range_with, 1);
+	RUN_SUCCESS(exception_bad_assert_range, 0);
+	RUN_SUCCESS(exception_bad_assert_range_with, 10);
+
+#define RUN_EXT(load_ret, attach_err, expr, msg, after_link)			  \
+	{									  \
+		LIBBPF_OPTS(bpf_object_open_opts, o, .kernel_log_buf = log_buf,		 \
+						     .kernel_log_size = sizeof(log_buf), \
+						     .kernel_log_level = 2);		 \
+		exceptions_ext__destroy(eskel);					  \
+		eskel = exceptions_ext__open_opts(&o);				  \
+		struct bpf_program *prog = NULL;				  \
+		struct bpf_link *link = NULL;					  \
+		if (!ASSERT_OK_PTR(eskel, "exceptions_ext__open"))		  \
+			goto done;						  \
+		(expr);								  \
+		ASSERT_OK_PTR(bpf_program__name(prog), bpf_program__name(prog));  \
+		if (!ASSERT_EQ(exceptions_ext__load(eskel), load_ret,		  \
+			       "exceptions_ext__load"))	{			  \
+			printf("%s\n", log_buf);				  \
+			goto done;						  \
+		}								  \
+		if (load_ret != 0) {						  \
+			printf("%s\n", log_buf);				  \
+			if (!ASSERT_OK_PTR(strstr(log_buf, msg), "strstr"))	  \
+				goto done;					  \
+		}								  \
+		if (!load_ret && attach_err) {					  \
+			if (!ASSERT_ERR_PTR(link = bpf_program__attach(prog), "attach err")) \
+				goto done;					  \
+		} else if (!load_ret) {						  \
+			if (!ASSERT_OK_PTR(link = bpf_program__attach(prog), "attach ok"))  \
+				goto done;					  \
+			(void)(after_link);					  \
+			bpf_link__destroy(link);				  \
+		}								  \
+	}
+
+	if (test__start_subtest("throwing extension with exception_cb"))
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_ext),
+				       "exception_ext_global"), "set_attach_target"))
+				goto done;
+		}), "", ({ RUN_SUCCESS(exception_ext, 128); }));
+
+	if (test__start_subtest("throwing exception_cb extension with exception_cb"))
+		RUN_EXT(-EINVAL, true, ({
+			prog = eskel->progs.throwing_exception_cb_extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
+				       "exception_cb_mod"), "set_attach_target"))
+				goto done;
+		}), "Extension programs cannot replace exception callback", 0);
+
+	if (test__start_subtest("throwing extension with exception_cb global"))
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_exception_cb_extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
+				       "exception_cb_mod_global"), "set_attach_target"))
+				goto done;
+		}), "", ({ RUN_SUCCESS(exception_ext_mod_cb_runtime, 131); }));
+
+	if (test__start_subtest("non-throwing fexit -> non-throwing subprog"))
+		/* non-throwing fexit -> non-throwing subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.pfexit;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("throwing fexit -> non-throwing subprog"))
+		/* throwing fexit -> non-throwing subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_fexit;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("non-throwing fexit -> throwing subprog"))
+		/* non-throwing fexit -> throwing subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.pfexit;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "throwing_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("throwing fexit -> throwing subprog"))
+		/* throwing fexit -> throwing subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_fexit;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "throwing_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	/* fmod_ret not allowed for subprog - Check so we remember to handle its
+	 * throwing specification compatibility with target when supported.
+	 */
+	if (test__start_subtest("non-throwing fmod_ret -> non-throwing subprog"))
+		RUN_EXT(-EINVAL, true, ({
+			prog = eskel->progs.pfmod_ret;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "subprog"), "set_attach_target"))
+				goto done;
+		}), "can't modify return codes of BPF program", 0);
+
+	/* fmod_ret not allowed for subprog - Check so we remember to handle its
+	 * throwing specification compatibility with target when supported.
+	 */
+	if (test__start_subtest("non-throwing fmod_ret -> non-throwing global subprog"))
+		RUN_EXT(-EINVAL, true, ({
+			prog = eskel->progs.pfmod_ret;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "global_subprog"), "set_attach_target"))
+				goto done;
+		}), "can't modify return codes of BPF program", 0);
+
+	if (test__start_subtest("non-throwing extension -> non-throwing subprog"))
+		/* non-throwing extension -> non-throwing subprog : BAD (!global) */
+		RUN_EXT(-EINVAL, true, ({
+			prog = eskel->progs.extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "subprog"), "set_attach_target"))
+				goto done;
+		}), "subprog() is not a global function", 0);
+
+	if (test__start_subtest("non-throwing extension -> throwing subprog"))
+		/* non-throwing extension -> throwing subprog : BAD (!global) */
+		RUN_EXT(-EINVAL, true, ({
+			prog = eskel->progs.extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "throwing_subprog"), "set_attach_target"))
+				goto done;
+		}), "throwing_subprog() is not a global function", 0);
+
+	if (test__start_subtest("non-throwing extension -> non-throwing subprog"))
+		/* non-throwing extension -> non-throwing global subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "global_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("non-throwing extension -> throwing global subprog"))
+		/* non-throwing extension -> throwing global subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "throwing_global_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("throwing extension -> throwing global subprog"))
+		/* throwing extension -> throwing global subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "throwing_global_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("throwing extension -> non-throwing global subprog"))
+		/* throwing extension -> non-throwing global subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "global_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("non-throwing extension -> main subprog"))
+		/* non-throwing extension -> main subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "exception_throw_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+	if (test__start_subtest("throwing extension -> main subprog"))
+		/* throwing extension -> main subprog : OK */
+		RUN_EXT(0, false, ({
+			prog = eskel->progs.throwing_extension;
+			bpf_program__set_autoload(prog, true);
+			if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+				       bpf_program__fd(skel->progs.exception_throw_subprog),
+				       "exception_throw_subprog"), "set_attach_target"))
+				goto done;
+		}), "", 0);
+
+done:
+	exceptions_ext__destroy(eskel);
+	exceptions__destroy(skel);
+}
+
+static void test_exceptions_assertions(void)
+{
+	RUN_TESTS(exceptions_assert);
+}
+
+void test_exceptions(void)
+{
+	test_exceptions_success();
+	test_exceptions_failure();
+	test_exceptions_assertions();
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
new file mode 100644
index 000000000000..2811ee842b01
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#ifndef ETH_P_IP
+#define ETH_P_IP 0x0800
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 4);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+static __noinline int static_func(u64 i)
+{
+	bpf_throw(32);
+	return i;
+}
+
+__noinline int global2static_simple(u64 i)
+{
+	static_func(i + 2);
+	return i - 1;
+}
+
+__noinline int global2static(u64 i)
+{
+	if (i == ETH_P_IP)
+		bpf_throw(16);
+	return static_func(i);
+}
+
+static __noinline int static2global(u64 i)
+{
+	return global2static(i) + i;
+}
+
+SEC("tc")
+int exception_throw_always_1(struct __sk_buff *ctx)
+{
+	bpf_throw(64);
+	return 0;
+}
+
+/* In this case, the global func will never be seen executing after call to
+ * static subprog, hence verifier will DCE the remaining instructions. Ensure we
+ * are resilient to that.
+ */
+SEC("tc")
+int exception_throw_always_2(struct __sk_buff *ctx)
+{
+	return global2static_simple(ctx->protocol);
+}
+
+SEC("tc")
+int exception_throw_unwind_1(struct __sk_buff *ctx)
+{
+	return static2global(bpf_ntohs(ctx->protocol));
+}
+
+SEC("tc")
+int exception_throw_unwind_2(struct __sk_buff *ctx)
+{
+	return static2global(bpf_ntohs(ctx->protocol) - 1);
+}
+
+SEC("tc")
+int exception_throw_default(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 1;
+}
+
+SEC("tc")
+int exception_throw_default_value(struct __sk_buff *ctx)
+{
+	bpf_throw(5);
+	return 1;
+}
+
+SEC("tc")
+int exception_tail_call_target(struct __sk_buff *ctx)
+{
+	bpf_throw(16);
+	return 0;
+}
+
+static __noinline
+int exception_tail_call_subprog(struct __sk_buff *ctx)
+{
+	volatile int ret = 10;
+
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return ret;
+}
+
+SEC("tc")
+int exception_tail_call(struct __sk_buff *ctx) {
+	volatile int ret = 0;
+
+	ret = exception_tail_call_subprog(ctx);
+	return ret + 8;
+}
+
+__noinline int exception_ext_global(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	return ret;
+}
+
+static __noinline int exception_ext_static(struct __sk_buff *ctx)
+{
+	return exception_ext_global(ctx);
+}
+
+SEC("tc")
+int exception_ext(struct __sk_buff *ctx)
+{
+	return exception_ext_static(ctx);
+}
+
+__noinline int exception_cb_mod_global(u64 cookie)
+{
+	volatile int ret = 0;
+
+	return ret;
+}
+
+/* Example of how the exception callback supplied during verification can still
+ * introduce extensions by calling to dummy global functions, and alter runtime
+ * behavior.
+ *
+ * Right now we don't allow freplace attachment to exception callback itself,
+ * but if the need arises this restriction is technically feasible to relax in
+ * the future.
+ */
+__noinline int exception_cb_mod(u64 cookie)
+{
+	return exception_cb_mod_global(cookie) + cookie + 10;
+}
+
+SEC("tc")
+__exception_cb(exception_cb_mod)
+int exception_ext_mod_cb_runtime(struct __sk_buff *ctx)
+{
+	bpf_throw(25);
+	return 0;
+}
+
+__noinline static int subprog(struct __sk_buff *ctx)
+{
+	return bpf_ktime_get_ns();
+}
+
+__noinline static int throwing_subprog(struct __sk_buff *ctx)
+{
+	if (ctx->tstamp)
+		bpf_throw(0);
+	return bpf_ktime_get_ns();
+}
+
+__noinline int global_subprog(struct __sk_buff *ctx)
+{
+	return bpf_ktime_get_ns();
+}
+
+__noinline int throwing_global_subprog(struct __sk_buff *ctx)
+{
+	if (ctx->tstamp)
+		bpf_throw(0);
+	return bpf_ktime_get_ns();
+}
+
+SEC("tc")
+int exception_throw_subprog(struct __sk_buff *ctx)
+{
+	switch (ctx->protocol) {
+	case 1:
+		return subprog(ctx);
+	case 2:
+		return global_subprog(ctx);
+	case 3:
+		return throwing_subprog(ctx);
+	case 4:
+		return throwing_global_subprog(ctx);
+	default:
+		break;
+	}
+	bpf_throw(1);
+	return 0;
+}
+
+__noinline int assert_nz_gfunc(u64 c)
+{
+	volatile u64 cookie = c;
+
+	bpf_assert(cookie != 0);
+	return 0;
+}
+
+__noinline int assert_zero_gfunc(u64 c)
+{
+	volatile u64 cookie = c;
+
+	bpf_assert_eq(cookie, 0);
+	return 0;
+}
+
+__noinline int assert_neg_gfunc(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_lt(cookie, 0);
+	return 0;
+}
+
+__noinline int assert_pos_gfunc(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_gt(cookie, 0);
+	return 0;
+}
+
+__noinline int assert_negeq_gfunc(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_le(cookie, -1);
+	return 0;
+}
+
+__noinline int assert_poseq_gfunc(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_ge(cookie, 1);
+	return 0;
+}
+
+__noinline int assert_nz_gfunc_with(u64 c)
+{
+	volatile u64 cookie = c;
+
+	bpf_assert_with(cookie != 0, cookie + 100);
+	return 0;
+}
+
+__noinline int assert_zero_gfunc_with(u64 c)
+{
+	volatile u64 cookie = c;
+
+	bpf_assert_eq_with(cookie, 0, cookie + 100);
+	return 0;
+}
+
+__noinline int assert_neg_gfunc_with(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_lt_with(cookie, 0, cookie + 100);
+	return 0;
+}
+
+__noinline int assert_pos_gfunc_with(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_gt_with(cookie, 0, cookie + 100);
+	return 0;
+}
+
+__noinline int assert_negeq_gfunc_with(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_le_with(cookie, -1, cookie + 100);
+	return 0;
+}
+
+__noinline int assert_poseq_gfunc_with(s64 c)
+{
+	volatile s64 cookie = c;
+
+	bpf_assert_ge_with(cookie, 1, cookie + 100);
+	return 0;
+}
+
+#define check_assert(name, cookie, tag)				\
+SEC("tc")							\
+int exception##tag##name(struct __sk_buff *ctx)			\
+{								\
+	return name(cookie) + 1;				\
+}
+
+check_assert(assert_nz_gfunc, 5, _);
+check_assert(assert_zero_gfunc, 0, _);
+check_assert(assert_neg_gfunc, -100, _);
+check_assert(assert_pos_gfunc, 100, _);
+check_assert(assert_negeq_gfunc, -1, _);
+check_assert(assert_poseq_gfunc, 1, _);
+
+check_assert(assert_nz_gfunc_with, 5, _);
+check_assert(assert_zero_gfunc_with, 0, _);
+check_assert(assert_neg_gfunc_with, -100, _);
+check_assert(assert_pos_gfunc_with, 100, _);
+check_assert(assert_negeq_gfunc_with, -1, _);
+check_assert(assert_poseq_gfunc_with, 1, _);
+
+check_assert(assert_nz_gfunc, 0, _bad_);
+check_assert(assert_zero_gfunc, 5, _bad_);
+check_assert(assert_neg_gfunc, 100, _bad_);
+check_assert(assert_pos_gfunc, -100, _bad_);
+check_assert(assert_negeq_gfunc, 1, _bad_);
+check_assert(assert_poseq_gfunc, -1, _bad_);
+
+check_assert(assert_nz_gfunc_with, 0, _bad_);
+check_assert(assert_zero_gfunc_with, 5, _bad_);
+check_assert(assert_neg_gfunc_with, 100, _bad_);
+check_assert(assert_pos_gfunc_with, -100, _bad_);
+check_assert(assert_negeq_gfunc_with, 1, _bad_);
+check_assert(assert_poseq_gfunc_with, -1, _bad_);
+
+SEC("tc")
+int exception_assert_range(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_range(time, 0, ~0ULL);
+	return 1;
+}
+
+SEC("tc")
+int exception_assert_range_with(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_range_with(time, 0, ~0ULL, 10);
+	return 1;
+}
+
+SEC("tc")
+int exception_bad_assert_range(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_range(time, -100, 100);
+	return 1;
+}
+
+SEC("tc")
+int exception_bad_assert_range_with(struct __sk_buff *ctx)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	bpf_assert_range_with(time, -1000, 1000, 10);
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
new file mode 100644
index 000000000000..fa35832e6748
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <limits.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define check_assert(type, op, name, value)				\
+	SEC("?tc")							\
+	__log_level(2) __failure					\
+	int check_assert_##op##_##name(void *ctx)			\
+	{								\
+		type num = bpf_ktime_get_ns();				\
+		bpf_assert_##op(num, value);				\
+		return *(u64 *)num;					\
+	}
+
+__msg(": R0_w=-2147483648 R10=fp0")
+check_assert(s64, eq, int_min, INT_MIN);
+__msg(": R0_w=2147483647 R10=fp0")
+check_assert(s64, eq, int_max, INT_MAX);
+__msg(": R0_w=0 R10=fp0")
+check_assert(s64, eq, zero, 0);
+__msg(": R0_w=-9223372036854775808 R1_w=-9223372036854775808 R10=fp0")
+check_assert(s64, eq, llong_min, LLONG_MIN);
+__msg(": R0_w=9223372036854775807 R1_w=9223372036854775807 R10=fp0")
+check_assert(s64, eq, llong_max, LLONG_MAX);
+
+__msg(": R0_w=scalar(smax=2147483646) R10=fp0")
+check_assert(s64, lt, pos, INT_MAX);
+__msg(": R0_w=scalar(umin=9223372036854775808,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+check_assert(s64, lt, zero, 0);
+__msg(": R0_w=scalar(umin=9223372036854775808,umax=18446744071562067967,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+check_assert(s64, lt, neg, INT_MIN);
+
+__msg(": R0_w=scalar(smax=2147483647) R10=fp0")
+check_assert(s64, le, pos, INT_MAX);
+__msg(": R0_w=scalar(smax=0) R10=fp0")
+check_assert(s64, le, zero, 0);
+__msg(": R0_w=scalar(umin=9223372036854775808,umax=18446744071562067968,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+check_assert(s64, le, neg, INT_MIN);
+
+__msg(": R0_w=scalar(umin=2147483648,umax=9223372036854775807,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, gt, pos, INT_MAX);
+__msg(": R0_w=scalar(umin=1,umax=9223372036854775807,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, gt, zero, 0);
+__msg(": R0_w=scalar(smin=-2147483647) R10=fp0")
+check_assert(s64, gt, neg, INT_MIN);
+
+__msg(": R0_w=scalar(umin=2147483647,umax=9223372036854775807,var_off=(0x0; 0x7fffffffffffffff))")
+check_assert(s64, ge, pos, INT_MAX);
+__msg(": R0_w=scalar(umax=9223372036854775807,var_off=(0x0; 0x7fffffffffffffff)) R10=fp0")
+check_assert(s64, ge, zero, 0);
+__msg(": R0_w=scalar(smin=-2147483648) R10=fp0")
+check_assert(s64, ge, neg, INT_MIN);
+
+SEC("?tc")
+__log_level(2) __failure
+__msg(": R0=0 R1=ctx(off=0,imm=0) R2=scalar(smin=-2147483646,smax=2147483645) R10=fp0")
+int check_assert_range_s64(struct __sk_buff *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	s64 num;
+
+	_Static_assert(_Generic((sk->rx_queue_mapping), s32: 1, default: 0), "type match");
+	if (!sk)
+		return 0;
+	num = sk->rx_queue_mapping;
+	bpf_assert_range(num, INT_MIN + 2, INT_MAX - 2);
+	return *((u8 *)ctx + num);
+}
+
+SEC("?tc")
+__log_level(2) __failure
+__msg(": R1=ctx(off=0,imm=0) R2=scalar(umin=4096,umax=8192,var_off=(0x0; 0x3fff))")
+int check_assert_range_u64(struct __sk_buff *ctx)
+{
+	u64 num = ctx->len;
+
+	bpf_assert_range(num, 4096, 8192);
+	return *((u8 *)ctx + num);
+}
+
+SEC("?tc")
+__log_level(2) __failure
+__msg(": R0=0 R1=ctx(off=0,imm=0) R2=4096 R10=fp0")
+int check_assert_single_range_s64(struct __sk_buff *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	s64 num;
+
+	_Static_assert(_Generic((sk->rx_queue_mapping), s32: 1, default: 0), "type match");
+	if (!sk)
+		return 0;
+	num = sk->rx_queue_mapping;
+
+	bpf_assert_range(num, 4096, 4096);
+	return *((u8 *)ctx + num);
+}
+
+SEC("?tc")
+__log_level(2) __failure
+__msg(": R1=ctx(off=0,imm=0) R2=4096 R10=fp0")
+int check_assert_single_range_u64(struct __sk_buff *ctx)
+{
+	u64 num = ctx->len;
+
+	bpf_assert_range(num, 4096, 4096);
+	return *((u8 *)ctx + num);
+}
+
+SEC("?tc")
+__log_level(2) __failure
+__msg(": R1=pkt(off=64,r=64,imm=0) R2=pkt_end(off=0,imm=0) R6=pkt(off=0,r=64,imm=0) R10=fp0")
+int check_assert_generic(struct __sk_buff *ctx)
+{
+	u8 *data_end = (void *)(long)ctx->data_end;
+	u8 *data = (void *)(long)ctx->data;
+
+	bpf_assert(data + 64 <= data_end);
+	return data[128];
+}
+
+SEC("?fentry/bpf_check")
+__failure __msg("At program exit the register R0 has value (0x40; 0x0)")
+int check_assert_with_return(void *ctx)
+{
+	bpf_assert_with(!ctx, 64);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_ext.c b/tools/testing/selftests/bpf/progs/exceptions_ext.c
new file mode 100644
index 000000000000..e37f05a03d86
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_ext.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+__noinline int exception_cb(u64 cookie)
+{
+	return cookie + 64;
+}
+
+SEC("?freplace")
+int extension(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+SEC("?freplace")
+__exception_cb(exception_cb)
+int throwing_exception_cb_extension(u64 cookie)
+{
+	bpf_throw(32);
+	return 0;
+}
+
+SEC("?freplace")
+__exception_cb(exception_cb)
+int throwing_extension(struct __sk_buff *ctx)
+{
+	bpf_throw(64);
+	return 0;
+}
+
+SEC("?fexit")
+int pfexit(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fexit")
+int throwing_fexit(void *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?fmod_ret")
+int pfmod_ret(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fmod_ret")
+int throwing_fmod_ret(void *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
new file mode 100644
index 000000000000..4c39e920dac2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+extern void bpf_rcu_read_lock(void) __ksym;
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
+struct foo {
+	struct bpf_rb_node node;
+};
+
+struct hmap_elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap SEC(".maps");
+
+private(A) struct bpf_spin_lock lock;
+private(A) struct bpf_rb_root rbtree __contains(foo, node);
+
+__noinline void *exception_cb_bad_ret_type(u64 cookie)
+{
+	return NULL;
+}
+
+__noinline int exception_cb_bad_arg_0(void)
+{
+	return 0;
+}
+
+__noinline int exception_cb_bad_arg_2(int a, int b)
+{
+	return 0;
+}
+
+__noinline int exception_cb_ok_arg_small(int a)
+{
+	return 0;
+}
+
+SEC("?tc")
+__exception_cb(exception_cb_bad_ret_type)
+__failure __msg("Global function exception_cb_bad_ret_type() doesn't return scalar.")
+int reject_exception_cb_type_1(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__exception_cb(exception_cb_bad_arg_0)
+__failure __msg("exception cb only supports single integer argument")
+int reject_exception_cb_type_2(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__exception_cb(exception_cb_bad_arg_2)
+__failure __msg("exception cb only supports single integer argument")
+int reject_exception_cb_type_3(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__exception_cb(exception_cb_ok_arg_small)
+__success
+int reject_exception_cb_type_4(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+__noinline
+static int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback subprog")
+int reject_async_callback_throw(struct __sk_buff *ctx)
+{
+	struct hmap_elem *elem;
+
+	elem = bpf_map_lookup_elem(&hmap, &(int){0});
+	if (!elem)
+		return 0;
+	return bpf_timer_set_callback(&elem->timer, timer_cb);
+}
+
+__noinline static int subprog_lock(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_spin_lock(&lock);
+	if (ctx->len)
+		bpf_throw(0);
+	return ret;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed while holding a lock")
+int reject_with_lock(void *ctx)
+{
+	bpf_spin_lock(&lock);
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed while holding a lock")
+int reject_subprog_with_lock(void *ctx)
+{
+	return subprog_lock(ctx);
+}
+
+SEC("?tc")
+__failure __msg("bpf_rcu_read_unlock is missing")
+int reject_with_rcu_read_lock(void *ctx)
+{
+	bpf_rcu_read_lock();
+	bpf_throw(0);
+	return 0;
+}
+
+__noinline static int throwing_subprog(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_rcu_read_unlock is missing")
+int reject_subprog_with_rcu_read_lock(void *ctx)
+{
+	bpf_rcu_read_lock();
+	return throwing_subprog(ctx);
+}
+
+static bool rbless(struct bpf_rb_node *n1, const struct bpf_rb_node *n2)
+{
+	bpf_throw(0);
+	return true;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed while holding a lock")
+int reject_with_rbtree_add_throw(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&lock);
+	bpf_rbtree_add(&rbtree, &f->node, rbless);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_with_reference(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_throw(0);
+	return 0;
+}
+
+__noinline static int subprog_ref(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_throw(0);
+	return 0;
+}
+
+__noinline static int subprog_cb_ref(u32 i, void *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_with_cb_reference(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_loop(5, subprog_cb_ref, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback")
+int reject_with_cb(void *ctx)
+{
+	bpf_loop(5, subprog_cb_ref, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_with_subprog_reference(void *ctx)
+{
+	return subprog_ref(ctx) + 1;
+}
+
+__noinline int throwing_exception_cb(u64 c)
+{
+	bpf_throw(0);
+	return c;
+}
+
+__noinline int exception_cb1(u64 c)
+{
+	return c;
+}
+
+__noinline int exception_cb2(u64 c)
+{
+	return c;
+}
+
+static __noinline int static_func(struct __sk_buff *ctx)
+{
+	return exception_cb1(ctx->tstamp);
+}
+
+__noinline int global_func(struct __sk_buff *ctx)
+{
+	return exception_cb1(ctx->tstamp);
+}
+
+SEC("?tc")
+__exception_cb(throwing_exception_cb)
+__failure __msg("cannot be called from callback subprog")
+int reject_throwing_exception_cb(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+SEC("?tc")
+__exception_cb(exception_cb1)
+__failure __msg("cannot call exception cb directly")
+int reject_exception_cb_call_global_func(struct __sk_buff *ctx)
+{
+	return global_func(ctx);
+}
+
+SEC("?tc")
+__exception_cb(exception_cb1)
+__failure __msg("cannot call exception cb directly")
+int reject_exception_cb_call_static_func(struct __sk_buff *ctx)
+{
+	return static_func(ctx);
+}
+
+SEC("?tc")
+__exception_cb(exception_cb1)
+__exception_cb(exception_cb2)
+__failure __msg("multiple exception callback tags for main subprog")
+int reject_multiple_exception_cb(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 16;
+}
+
+__noinline int exception_cb_bad_ret(u64 c)
+{
+	return c;
+}
+
+SEC("?fentry/bpf_check")
+__exception_cb(exception_cb_bad_ret)
+__failure __msg("At program exit the register R0 has unknown scalar value should")
+int reject_set_exception_cb_bad_ret1(void *ctx)
+{
+	return 0;
+}
+
+SEC("?fentry/bpf_check")
+__failure __msg("At program exit the register R0 has value (0x40; 0x0) should")
+int reject_set_exception_cb_bad_ret2(void *ctx)
+{
+	bpf_throw(64);
+	return 0;
+}
+
+__noinline static int loop_cb1(u32 index, int *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+__noinline static int loop_cb2(u32 index, int *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback")
+int reject_exception_throw_cb(struct __sk_buff *ctx)
+{
+	bpf_loop(5, loop_cb1, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback")
+int reject_exception_throw_cb_diff(struct __sk_buff *ctx)
+{
+	if (ctx->protocol)
+		bpf_loop(5, loop_cb1, NULL, 0);
+	else
+		bpf_loop(5, loop_cb2, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0



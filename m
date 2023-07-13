Return-Path: <bpf+bounces-4905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9775165D
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F36F1C20F00
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD09A5D;
	Thu, 13 Jul 2023 02:33:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91187C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:33:19 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF429E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3942c6584f0so208274b6e.3
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215596; x=1691807596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfjD7bMV19cFL/Jauzq65OPqBLLmv1KgbJTYePqjgWI=;
        b=Veo7fcW/t+rrgtRXqX7nZMOrnj/0TTjSUazbd5v4r2cG5gZ5ckMzCEJjCdhNRvC4/a
         08Af4Jg8Vn4QbObKNwaW3B6RZJ3LK1i13+9QwOTR3J/sci1Ify0GC4IpQhg5A+hmcOvi
         VZB0PB68yBDzFozLRUkNxrnC0qWLbXZohKa2GTEo1i01L6I6fNqsAF0419Cs8ryAds1r
         Cz1DLXK+wUckloKvKM1bbZn68bLJ7DYpIry4FOTfcRbe8cXPGXkVGAEuRx/67nl5IY61
         ghoKgjAmmwYBe99bcGbBfWzTctnrANx8f2xd7THd9atV3ToXxX3JMaogeklcpHwkpbbt
         54Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215596; x=1691807596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfjD7bMV19cFL/Jauzq65OPqBLLmv1KgbJTYePqjgWI=;
        b=btcpF8w9yBm/gpXqT/IbkFhIS9/YgTsSnJjVT2ToMqj+RpQlxJaso9ktzvU3gXupS0
         JPaM0Oa09ljG9zYnmuXHlxRr3atk4Rrfo1k45svVe7DBukxozQrdfKcn7zV+yGHaVR53
         n1ZX8Rt/YhSdTyPLtweEWowleNeBwuRqjxc5Cv3imsctIKHKg+2FAHohJftjSCO+c2QM
         s8VCQb0woZKBhB+H3fX1Y8XmMk6dKv6KreSZ2YfNM/CBgFQcUX1qMA8MtR8WJ8oFncJM
         zAdl/WWAFPahLkeACNYgb3X1N1wLlfeeH+nsxS5eiOubjtws692q+tntm4v6U4Lj8KJ6
         xT6g==
X-Gm-Message-State: ABy/qLafZ1WXArnMNnT7cFGhmxWPykBH+AXhTMi1wG2fCa8/VOcrLGPI
	EzlnUrNjRv4T1rsGAbd55NbTp/kPwJBQ3A==
X-Google-Smtp-Source: APBJJlHObZ8cdVmqlC5HRNeQSI8kUmPEgiYcOckjwNYk7qnuxJIJ1YtmKZu0RNjuO0k/p5TIYM3+ZA==
X-Received: by 2002:a05:6808:10c1:b0:3a3:f92c:3f38 with SMTP id s1-20020a05680810c100b003a3f92c3f38mr498538ois.6.1689215595561;
        Wed, 12 Jul 2023 19:33:15 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b00682bec0b680sm4259625pfh.89.2023.07.12.19.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:33:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 10/10] selftests/bpf: Add tests for BPF exceptions
Date: Thu, 13 Jul 2023 08:02:32 +0530
Message-Id: <20230713023232.1411523-11-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28734; i=memxor@gmail.com; h=from:subject; bh=ua20QwhudnRSjTCZgLbr9dJ+pra2cbA1mpaybPmsf80=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HJgvHGGy3Fhptd8wxSI4tjmmJQk8m+tDAZA Zi1zoxUQqWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hyQAKCRBM4MiGSL8R ykcpEAC5IaBC+RdE98mTM7OM7uWPwYEcmDkIc3qoLddk1P/NHgOg6qN0uHclvQYtstRzeCYeXIP wTeedSO6Qh3fwuYwKv9HamOlkC2fw2L9uKYyDKjJLGX0xlAg+U4N9ZCn9G71QKe1U2y1G63YlWK Knk1FlFv3yxoz3CQUvRM4WkF5n6x+ZXnUetygicwmeExqzhs3tXVUMFdh67nYX7xt5ubOFQuiR4 VVlN53JCkZtWeTYGmn4Dxoz0JMEl+S6uqB8iOaJSITKP1MnJ8rgIjdsocOT5cFkgdY1lKtYeGRl DViSUXPuanaehohQBuH150SouPjqFXcfXzQOULArCKqvCgZhCA2oPTAVYm/EVjogdKQ7S6jvhh7 tAM3JieCzvSDbYGviYoiv75PhQD+c6pENMRn3WpIAYM73k/4wnHJbmGFryEkXoCY5grKKESiH0I DGa5vcdrdDv7mzx+44jTvT1ZJhqgd5y7YIJN5Ps14p1QxgVoAXuHq8z7a/rCSRfWWgf6Luf39dH 43GTVWXJd5FZ6cU6QMIfHBmK5KZDLtzaQI6KnDAM6PtbR2gqjAHgVB501CnJNor1e3jXMf0MLMt hhTgBLaYDotnpf58y7YjEb1zRL/w4C1uONwrVcJESHCNaxFXR/Mu/ckkfab3hqUNtqBzfJ/aGny FcDGBW7ZzK6DMsg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add selftests to cover success and failure cases of API usage, runtime
behavior and invariants that need to be maintained for implementation
correctness.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/exceptions.c     | 272 +++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 450 ++++++++++++++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  42 ++
 .../selftests/bpf/progs/exceptions_fail.c     | 311 ++++++++++++
 4 files changed, 1075 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
new file mode 100644
index 000000000000..e6a906ef6852
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "exceptions.skel.h"
+#include "exceptions_ext.skel.h"
+#include "exceptions_fail.skel.h"
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
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs._prog), &ropts); \
+	ASSERT_OK(ret, #_prog " prog run ret");					  \
+	ASSERT_EQ(ropts.retval, return_val, #_prog " prog run retval");
+
+	RUN_SUCCESS(exception_throw_subprog, 16);
+	RUN_SUCCESS(exception_throw, 0);
+	RUN_SUCCESS(exception_throw_gfunc1, 1);
+	RUN_SUCCESS(exception_throw_gfunc2, 0);
+	RUN_SUCCESS(exception_throw_gfunc3, 1);
+	RUN_SUCCESS(exception_throw_gfunc4, 0);
+	RUN_SUCCESS(exception_throw_gfunc5, 1);
+	RUN_SUCCESS(exception_throw_gfunc6, 16);
+	RUN_SUCCESS(exception_throw_func1, 1);
+	RUN_SUCCESS(exception_throw_func2, 0);
+	RUN_SUCCESS(exception_throw_func3, 1);
+	RUN_SUCCESS(exception_throw_func4, 0);
+	RUN_SUCCESS(exception_throw_func5, 1);
+	RUN_SUCCESS(exception_throw_func6, 16);
+	RUN_SUCCESS(exception_tail_call, 50);
+	RUN_SUCCESS(exception_ext, 5);
+	RUN_SUCCESS(exception_throw_value, 60);
+	RUN_SUCCESS(exception_assert_eq, 16);
+	RUN_SUCCESS(exception_assert_ne, 16);
+	RUN_SUCCESS(exception_assert_lt, 16);
+	RUN_SUCCESS(exception_assert_gt, 16);
+	RUN_SUCCESS(exception_assert_le, 16);
+	RUN_SUCCESS(exception_assert_ge, 16);
+	RUN_SUCCESS(exception_assert_eq_ok, 6);
+	RUN_SUCCESS(exception_assert_ne_ok, 6);
+	RUN_SUCCESS(exception_assert_lt_ok, 6);
+	RUN_SUCCESS(exception_assert_gt_ok, 6);
+	RUN_SUCCESS(exception_assert_le_ok, 6);
+	RUN_SUCCESS(exception_assert_ge_ok, 6);
+	RUN_SUCCESS(exception_assert_eq_value, 42);
+	RUN_SUCCESS(exception_assert_ne_value, 42);
+	RUN_SUCCESS(exception_assert_lt_value, 42);
+	RUN_SUCCESS(exception_assert_gt_value, 42);
+	RUN_SUCCESS(exception_assert_le_value, 42);
+	RUN_SUCCESS(exception_assert_ge_value, 42);
+	RUN_SUCCESS(exception_assert_eq_ok_value, 5);
+	RUN_SUCCESS(exception_assert_ne_ok_value, 5);
+	RUN_SUCCESS(exception_assert_lt_ok_value, 5);
+	RUN_SUCCESS(exception_assert_gt_ok_value, 5);
+	RUN_SUCCESS(exception_assert_le_ok_value, 5);
+	RUN_SUCCESS(exception_assert_ge_ok_value, 5);
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
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_ext),
+			       "exception_ext_global"), "set_attach_target"))
+			goto done;
+	}), "", ({ RUN_SUCCESS(exception_ext, 0); }));
+
+	/* non-throwing fexit -> non-throwing subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.pfexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* throwing fexit -> non-throwing subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_fexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* non-throwing fexit -> throwing subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.pfexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* throwing fexit -> throwing subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_fexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* fmod_ret not allowed for subprog - Check so we remember to handle its
+	 * throwing specification compatibility with target when supported.
+	 */
+	RUN_EXT(-EINVAL, false, ({
+		prog = eskel->progs.pfmod_ret;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "can't modify return codes of BPF program", (void)0);
+
+	/* fmod_ret not allowed for subprog - Check so we remember to handle its
+	 * throwing specification compatibility with target when supported.
+	 */
+	RUN_EXT(-EINVAL, false, ({
+		prog = eskel->progs.pfmod_ret;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "global_subprog"), "set_attach_target"))
+			goto done;
+	}), "can't modify return codes of BPF program", (void)0);
+
+	/* non-throwing extension -> non-throwing subprog : BAD (!global) */
+	RUN_EXT(-EINVAL, true, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "subprog() is not a global function", (void)0);
+
+	/* non-throwing extension -> throwing subprog : BAD (!global) */
+	RUN_EXT(-EINVAL, true, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_subprog"), "set_attach_target"))
+			goto done;
+	}), "throwing_subprog() is not a global function", (void)0);
+
+	/* non-throwing extension -> non-throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "global_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* non-throwing extension -> throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_global_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* throwing extension -> throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_global_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* throwing extension -> main subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "exception_throw_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+
+	/* throwing extension -> non-throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "global_subprog"), "set_attach_target"))
+			goto done;
+	}), "", (void)0);
+done:
+	exceptions_ext__destroy(eskel);
+	exceptions__destroy(skel);
+}
+
+void test_exceptions(void)
+{
+	test_exceptions_success();
+	test_exceptions_failure();
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
new file mode 100644
index 000000000000..f8c2727f4584
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -0,0 +1,450 @@
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
+#define ETH_P_IP	0x0800		/* Internet Protocol packet	*/
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 4);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("tc")
+int exception_throw(struct __sk_buff *ctx)
+{
+	volatile int ret = 1;
+
+	if (ctx->protocol)
+		throw;
+	return ret;
+}
+
+
+static __noinline int subprog(struct __sk_buff *ctx)
+{
+	return ctx->len;
+}
+
+static __noinline int throwing_subprog(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	if (ctx->protocol)
+		throw;
+	return ret;
+}
+
+__noinline int global_subprog(struct __sk_buff *ctx)
+{
+	return subprog(ctx) + 1;
+}
+
+__noinline int throwing_global_subprog(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	if (ctx->protocol)
+		throw;
+	return ret;
+}
+
+__noinline int throwing_global_subprog_value(struct __sk_buff *ctx, u64 value)
+{
+	volatile int ret = 0;
+
+	if (ctx->protocol)
+		throw_value(value);
+	return ret;
+}
+
+static __noinline int exception_cb(u64 c)
+{
+	volatile int ret = 16;
+
+	return ret;
+}
+
+SEC("tc")
+int exception_throw_subprog(struct __sk_buff *ctx)
+{
+	volatile int i;
+
+	bpf_set_exception_callback(exception_cb);
+	i = subprog(ctx);
+	i += global_subprog(ctx) - 1;
+	if (!i)
+		return throwing_global_subprog(ctx);
+	else
+		return throwing_subprog(ctx);
+	throw;
+	return 0;
+}
+
+__noinline int throwing_gfunc(volatile int i)
+{
+	volatile int ret = 1;
+
+	bpf_assert_eq(i, 0);
+	return ret;
+}
+
+__noinline static int throwing_func(volatile int i)
+{
+	volatile int ret = 1;
+
+	bpf_assert_lt(i, 1);
+	return ret;
+}
+
+SEC("tc")
+int exception_throw_gfunc1(void *ctx)
+{
+	return throwing_gfunc(0);
+}
+
+SEC("tc")
+__noinline int exception_throw_gfunc2()
+{
+	return throwing_gfunc(1);
+}
+
+__noinline int throwing_gfunc_2(volatile int i)
+{
+	return throwing_gfunc(i);
+}
+
+SEC("tc")
+int exception_throw_gfunc3(void *ctx)
+{
+	return throwing_gfunc_2(0);
+}
+
+SEC("tc")
+int exception_throw_gfunc4(void *ctx)
+{
+	return throwing_gfunc_2(1);
+}
+
+SEC("tc")
+int exception_throw_gfunc5(void *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	return throwing_gfunc_2(0);
+}
+
+SEC("tc")
+int exception_throw_gfunc6(void *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	return throwing_gfunc_2(1);
+}
+
+
+SEC("tc")
+int exception_throw_func1(void *ctx)
+{
+	return throwing_func(0);
+}
+
+SEC("tc")
+int exception_throw_func2(void *ctx)
+{
+	return throwing_func(1);
+}
+
+__noinline static int throwing_func_2(volatile int i)
+{
+	return throwing_func(i);
+}
+
+SEC("tc")
+int exception_throw_func3(void *ctx)
+{
+	return throwing_func_2(0);
+}
+
+SEC("tc")
+int exception_throw_func4(void *ctx)
+{
+	return throwing_func_2(1);
+}
+
+SEC("tc")
+int exception_throw_func5(void *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	return throwing_func_2(0);
+}
+
+SEC("tc")
+int exception_throw_func6(void *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	return throwing_func_2(1);
+}
+
+static int exception_cb_nz(u64 cookie)
+{
+	volatile int ret = 42;
+
+	return ret;
+}
+
+SEC("tc")
+int exception_tail_call_target(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_nz);
+	throw;
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
+	bpf_set_exception_callback(exception_cb);
+	ret = exception_tail_call_subprog(ctx);
+	return ret + 8;
+}
+
+__noinline int exception_ext_global(struct __sk_buff *ctx)
+{
+	volatile int ret = 5;
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
+	bpf_set_exception_callback(exception_cb_nz);
+	return exception_ext_static(ctx);
+}
+
+static __noinline int exception_cb_value(u64 cookie)
+{
+	return cookie - 4;
+}
+
+SEC("tc")
+int exception_throw_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	return throwing_global_subprog_value(ctx, 64);
+}
+
+SEC("tc")
+int exception_assert_eq(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_eq(ctx->protocol, IPPROTO_UDP);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_ne(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_ne(ctx->protocol, __bpf_htons(ETH_P_IP));
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_lt(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_lt(ctx->protocol, __bpf_htons(ETH_P_IP) - 1);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_gt(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_gt(ctx->protocol, __bpf_htons(ETH_P_IP) + 1);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_le(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_le(ctx->protocol, __bpf_htons(ETH_P_IP) - 1);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_ge(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_ge(ctx->protocol, __bpf_htons(ETH_P_IP) + 1);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_eq_ok(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_eq(ctx->protocol, __bpf_htons(ETH_P_IP));
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_ne_ok(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_ne(ctx->protocol, IPPROTO_UDP);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_lt_ok(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_lt(ctx->protocol, __bpf_htons(ETH_P_IP) + 1);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_gt_ok(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_gt(ctx->protocol, __bpf_htons(ETH_P_IP) - 1);
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_le_ok(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_le(ctx->protocol, __bpf_htons(ETH_P_IP));
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_ge_ok(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_assert_ge(ctx->protocol, __bpf_htons(ETH_P_IP));
+	return 6;
+}
+
+SEC("tc")
+int exception_assert_eq_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_eq_value(ctx->protocol, IPPROTO_UDP, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_ne_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_ne_value(ctx->protocol, __bpf_htons(ETH_P_IP), 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_lt_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_lt_value(ctx->protocol, __bpf_htons(ETH_P_IP) - 1, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_gt_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_gt_value(ctx->protocol, __bpf_htons(ETH_P_IP) + 1, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_le_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_le_value(ctx->protocol, __bpf_htons(ETH_P_IP) - 1, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_ge_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_ge_value(ctx->protocol, __bpf_htons(ETH_P_IP) + 1, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_eq_ok_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_eq_value(ctx->protocol, __bpf_htons(ETH_P_IP), 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_ne_ok_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_ne_value(ctx->protocol, IPPROTO_UDP, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_lt_ok_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_lt_value(ctx->protocol, __bpf_htons(ETH_P_IP) + 1, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_gt_ok_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_gt_value(ctx->protocol, __bpf_htons(ETH_P_IP) - 1, 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_le_ok_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_le_value(ctx->protocol, __bpf_htons(ETH_P_IP), 46);
+	return 5;
+}
+
+SEC("tc")
+int exception_assert_ge_ok_value(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_value);
+	bpf_assert_ge_value(ctx->protocol, __bpf_htons(ETH_P_IP), 46);
+	return 5;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_ext.c b/tools/testing/selftests/bpf/progs/exceptions_ext.c
new file mode 100644
index 000000000000..9ce9752254bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_ext.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+SEC("?freplace")
+int extension(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int throwing_extension(struct __sk_buff *ctx)
+{
+	throw;
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
+	throw;
+}
+
+SEC("?fmod_ret")
+int pfmod_ret(void *ctx)
+{
+	return 1;
+}
+
+SEC("?fmod_ret")
+int throwing_fmod_ret(void *ctx)
+{
+	throw;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
new file mode 100644
index 000000000000..94ee6ae452c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -0,0 +1,311 @@
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
+private(A) struct bpf_spin_lock lock;
+private(A) struct bpf_rb_root rbtree __contains(foo, node);
+
+__noinline static int subprog_lock(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	bpf_spin_lock(&lock);
+	if (ctx->len)
+		throw;
+	return ret;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed while holding a lock")
+int reject_with_lock(void *ctx)
+{
+	bpf_spin_lock(&lock);
+	throw;
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
+	throw;
+}
+
+__noinline static int throwing_subprog(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		throw;
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
+	throw;
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
+	throw;
+}
+
+__noinline static int subprog_ref(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	throw;
+}
+
+__noinline static int subprog_cb_ref(u32 i, void *ctx)
+{
+	throw;
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
+static __noinline int throwing_exception_cb(u64 c)
+{
+	if (!c)
+		throw;
+	return c;
+}
+
+static __noinline int exception_cb1(u64 c)
+{
+	volatile int i = 0;
+
+	bpf_assert_eq(i, 0);
+	return i;
+}
+
+static __noinline int exception_cb2(u64 c)
+{
+	volatile int i = 0;
+
+	bpf_assert_eq(i, 0);
+	return i;
+}
+
+__noinline int throwing_exception_gfunc(struct __sk_buff *ctx)
+{
+	return throwing_exception_cb(ctx->protocol);
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback")
+int reject_throwing_exception_cb_1(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(throwing_exception_cb);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot call exception cb directly")
+int reject_throwing_exception_cb_2(struct __sk_buff *ctx)
+{
+	throwing_exception_gfunc(ctx);
+	bpf_set_exception_callback(throwing_exception_cb);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("can only be called once to set exception callback")
+int reject_throwing_exception_cb_3(struct __sk_buff *ctx)
+{
+	if (ctx->protocol)
+		bpf_set_exception_callback(exception_cb1);
+	else
+		bpf_set_exception_callback(exception_cb2);
+	throw;
+}
+
+__noinline int gfunc_set_exception_cb(u64 c)
+{
+	bpf_set_exception_callback(exception_cb1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("can only be called from main prog")
+int reject_set_exception_cb_gfunc(struct __sk_buff *ctx)
+{
+	gfunc_set_exception_cb(0);
+	return 0;
+}
+
+static __noinline int exception_cb_rec(u64 c)
+{
+	bpf_set_exception_callback(exception_cb_rec);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("can only be called from main prog")
+int reject_set_exception_cb_rec1(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_rec);
+	return 0;
+}
+
+static __noinline int exception_cb_rec2(u64 c);
+
+static __noinline int exception_cb_rec1(u64 c)
+{
+	bpf_set_exception_callback(exception_cb_rec2);
+	return 0;
+}
+
+static __noinline int exception_cb_rec2(u64 c)
+{
+	bpf_set_exception_callback(exception_cb_rec2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("can only be called from main prog")
+int reject_set_exception_cb_rec2(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_rec1);
+	return 0;
+}
+
+static __noinline int exception_cb_rec3(u64 c)
+{
+	bpf_set_exception_callback(exception_cb1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("can only be called from main prog")
+int reject_set_exception_cb_rec3(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_rec3);
+	return 0;
+}
+
+static __noinline int exception_cb_bad_ret(u64 c)
+{
+	return 4242;
+}
+
+SEC("?fentry/bpf_check")
+__failure __msg("At program exit the register R0 has value")
+int reject_set_exception_cb_bad_ret(void *ctx)
+{
+	bpf_set_exception_callback(exception_cb_bad_ret);
+	return 0;
+}
+
+__noinline static int loop_cb1(u32 index, int *ctx)
+{
+	throw;
+	return 0;
+}
+
+__noinline static int loop_cb2(u32 index, int *ctx)
+{
+	throw;
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback")
+int reject_exception_throw_cb(struct __sk_buff *ctx)
+{
+	volatile int ret = 1;
+
+	bpf_loop(5, loop_cb1, NULL, 0);
+	return ret;
+}
+
+SEC("?tc")
+__failure __msg("cannot be called from callback")
+int exception_throw_cb_diff(struct __sk_buff *ctx)
+{
+	volatile int ret = 1;
+
+	if (ctx->protocol)
+		bpf_loop(5, loop_cb1, NULL, 0);
+	else
+		bpf_loop(5, loop_cb2, NULL, 0);
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C016D7198
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjDEAnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbjDEAnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:43:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8470F3
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1546754wmo.0
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMrAvEXr/1JHkqOmtR/28cms2jsyiziijxpUrZXMEkI=;
        b=J3GWYeHTM7U5Mo1dWcqVhwsQ1Xs+jlGLcpn9l7Y+8UExjWVme6V3QF1eHO7kdaa8zV
         fozwcFs77jdbFqbrtNHLMmx2Pyyx23z/mDGw9U6BkE8T6vK0hh6GjDVJQf6yt0cRIufS
         xpGf0dNMjTZurbDxlsh5n/6dO1ns3eRoiFT++qjRVdaWhjDfut8ueR6RfuOl2d++OaRE
         Lln6Npc2z+lV0lIyDqeneDw2aa3ODymNrWK2dqhTcLSUWPTv/fgsG2sEdanNou2yoxOu
         Bc/oiRG3KjgBuxqc1ZyaSeInznKuKUZ+eZXt0dGOMIg5rtznhZ7NiUWSAoppA9HO5vnm
         BC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMrAvEXr/1JHkqOmtR/28cms2jsyiziijxpUrZXMEkI=;
        b=banOXKw2pxNwE0TKckNI5oZBMO2CHi7T0m5eRqC37iDzgW2AX+RzNwfTE1JW4lPfLR
         cJk7F0OYOxYWSr9Yb8oCfLlZW++lHc5MOcamHg7+/zLG/l3V8IW5nSXuOw+D8RQxB+p/
         SBFliSwMnJ9hUgofzKKmQ2P6bbaTktv5D49ys7AVUxpmCzyBCKy2zhJY51Wu038+tiuz
         0UhUs9mvFXD4SZnsu2Y/tRa+WJuy37U2dbTuiXBAiUU46mH9vd0uLUPjkHq3eh28D8RL
         HlHkiNAZHos6V6yVGBcKix6xlhMccr1u4IDYAxlOcJ04zjfjlcunqckD4dqKyi3tPWaq
         5qeA==
X-Gm-Message-State: AAQBX9cOMKP2ckDB+r6tgD+Rg7ED+a8jmwM3pW0wuPyIkPL8BnLOwOr1
        5XDFoRRfCqdr8hzG1sImoGAlIz92SnYRsA==
X-Google-Smtp-Source: AKy350Zh3jG06CaLj7LamYR4sGVqwQ8+oXWt2CSAzDF0wUcSslcw0XTwEULg9xsUfezb8Ws8xyQKjw==
X-Received: by 2002:a7b:cbda:0:b0:3ed:8360:e54 with SMTP id n26-20020a7bcbda000000b003ed83600e54mr3648554wmi.8.1680655375151;
        Tue, 04 Apr 2023 17:42:55 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b003eda46d6792sm414036wmo.32.2023.04.04.17.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:54 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 9/9] selftests/bpf: Add tests for BPF exceptions
Date:   Wed,  5 Apr 2023 02:42:39 +0200
Message-Id: <20230405004239.1375399-10-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21184; i=memxor@gmail.com; h=from:subject; bh=F09Ds31b3RkPW3UAWnWy73rK7E06qICpDaIG+Vsh6Ng=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPwm+7LMPXf8kBCp1s+2TFHQIRvIr3R4X0yq oCVuwvBdyCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD8AAKCRBM4MiGSL8R yjRuEACQkpfdNU7pUdfcaBr0WOm3W7BY+bDtPx7UBKdTZLDn6r9KBcad0CVzAhnqZIodPdJQTCo SBGNBtQlhY3rqlK9TE/MVEjXJJiKTarnMnssu3WHQ4MMuirKpGbov7LzNUpZL1WazSI/RTKqdJC x2bOjotsPxe2JRmtVraFE++a7O26EKFq1zvDZkg8RDWLBp4gsHic2xe6xiBD/JYEU91ocKZoqLn XRIaALZgxLylbARm7q0eeZ80HawPsl4/+QmkpNbbAuY/wJP5GgsHAKCYEJhxLMhuGHhpmhWlPZU sEcCmfoPJtuWtohXDR0vTANJxqUx6valz8Wdvoq9TS+k/q+LRzBFVOI++qcpZhmt2uMcetgyGFs 46V/mILlpx1nD7fgSIZYubLLlr9GrWS60homx5RlACcSfoZHkTc1NJxbv6DyH2ebCC8FDIMNbtf O05ll7ePWCRJpB7Tf0MBn+0+Q73oZCU2LFFV5aDowBcFxVFfFhaK0H8CSfOyhLmfQEHOvPhRqWp SWKpKgbBmWtlSXIPipIiPUbNTtLqtUd3tyfgc1tt9ccsvkMejSg6t7Z2ndAciWQLOzKlk7W7/GT ga1eObAiKb9KCrCG2EWOHlBUF94VmnerEcrQ+4Ve6bWhYpfZW7Astt5u24uca+q2kw5du/BCwJh +/U5r6Otl78P4Uw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests to cover success and failure cases of API usage, runtime
behavior and invariants that need to be maintained for implementation
correctness.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/exceptions.c     | 240 ++++++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 218 ++++++++++++++
 .../selftests/bpf/progs/exceptions_ext.c      |  42 +++
 .../selftests/bpf/progs/exceptions_fail.c     | 267 ++++++++++++++++++
 4 files changed, 767 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
new file mode 100644
index 000000000000..342f44a12c65
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -0,0 +1,240 @@
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
+	skel = exceptions__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "exceptions__open_and_load"))
+		return;
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
+	RUN_SUCCESS(exception_throw_cb1, 0);
+	RUN_SUCCESS(exception_throw_cb2, 16);
+	RUN_SUCCESS(exception_throw_cb_diff, 16);
+	RUN_SUCCESS(exception_throw_kfunc1, 0);
+	RUN_SUCCESS(exception_throw_kfunc2, 1);
+
+#define RUN_EXT(load_ret, attach_err, expr, msg)				  \
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
+			bpf_link__destroy(link);				  \
+		}								  \
+	}
+
+	/* non-throwing fexit -> non-throwing subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.pfexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "");
+
+	/* throwing fexit -> non-throwing subprog : BAD */
+	RUN_EXT(0, true, ({
+		prog = eskel->progs.throwing_fexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "");
+
+	/* non-throwing fexit -> throwing subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.pfexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_subprog"), "set_attach_target"))
+			goto done;
+	}), "");
+
+	/* throwing fexit -> throwing subprog : BAD */
+	RUN_EXT(0, true, ({
+		prog = eskel->progs.throwing_fexit;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_subprog"), "set_attach_target"))
+			goto done;
+	}), "");
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
+	}), "can't modify return codes of BPF program");
+
+	/* fmod_ret not allowed for global subprog - Check so we remember to
+	 * handle its throwing specification compatibility with target when
+	 * supported.
+	 */
+	RUN_EXT(-EINVAL, false, ({
+		prog = eskel->progs.pfmod_ret;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "global_subprog"), "set_attach_target"))
+			goto done;
+	}), "can't modify return codes of BPF program");
+
+	/* non-throwing extension -> non-throwing subprog : BAD (!global)
+	 * We need to handle and reject it for static subprogs when supported
+	 * when extension is throwing as not all callsites are marked to handle
+	 * them.
+	 */
+	RUN_EXT(-EINVAL, true, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "subprog"), "set_attach_target"))
+			goto done;
+	}), "subprog() is not a global function");
+
+	/* non-throwing extension -> throwing subprog : BAD (!global)
+	 * We need to handle and reject it for static subprogs when supported
+	 * when extension is throwing as not all callsites are marked to handle
+	 * them.
+	 */
+	RUN_EXT(-EINVAL, true, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_subprog"), "set_attach_target"))
+			goto done;
+	}), "throwing_subprog() is not a global function");
+
+	/* non-throwing extension -> non-throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "global_subprog"), "set_attach_target"))
+			goto done;
+	}), "");
+
+	/* non-throwing extension -> throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_global_subprog"), "set_attach_target"))
+			goto done;
+	}), "");
+
+	/* throwing extension -> throwing global subprog : OK */
+	RUN_EXT(0, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "throwing_global_subprog"), "set_attach_target"))
+			goto done;
+	}), "");
+
+	/* throwing extension -> main subprog : BAD (OUTER vs INNER mismatch) */
+	RUN_EXT(-EINVAL, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "exception_throw_subprog"), "set_attach_target"))
+			goto done;
+	}), "Cannot attach throwing extension to main subprog");
+
+	/* throwing extension -> non-throwing global subprog : BAD */
+	RUN_EXT(-EINVAL, false, ({
+		prog = eskel->progs.throwing_extension;
+		bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(bpf_program__set_attach_target(prog,
+			       bpf_program__fd(skel->progs.exception_throw_subprog),
+			       "global_subprog"), "set_attach_target"))
+			goto done;
+	}), "Cannot attach throwing extension to non-throwing subprog");
+done:
+	exceptions_ext__destroy(eskel);
+	exceptions__destroy(skel);
+}
+
+void test_exceptions(void)
+{
+	test_exceptions_failure();
+	test_exceptions_success();
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
new file mode 100644
index 000000000000..9a33f88e7e2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+SEC("tc")
+int exception_throw(struct __sk_buff *ctx)
+{
+	if (ctx->data)
+		bpf_throw();
+	return 1;
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
+	if (ctx)
+		bpf_throw();
+	return 0;
+}
+
+__noinline int global_subprog(struct __sk_buff *ctx)
+{
+	return subprog(ctx) + 1;
+}
+
+__noinline int throwing_global_subprog(struct __sk_buff *ctx)
+{
+	if (ctx)
+		bpf_throw();
+	return 0;
+}
+
+static __noinline int exception_cb(void)
+{
+	return 16;
+}
+
+SEC("tc")
+int exception_throw_subprog(struct __sk_buff *ctx)
+{
+	volatile int i;
+
+	exception_cb();
+	bpf_set_exception_callback(exception_cb);
+	i = subprog(ctx);
+	i += global_subprog(ctx) - 1;
+	if (!i)
+		return throwing_global_subprog(ctx);
+	else
+		return throwing_subprog(ctx);
+	bpf_throw();
+	return 0;
+}
+
+__noinline int throwing_gfunc(volatile int i)
+{
+	bpf_assert_eq(i, 0);
+	return 1;
+}
+
+__noinline static int throwing_func(volatile int i)
+{
+	bpf_assert_lt(i, 1);
+	return 1;
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
+__noinline static int loop_cb1(u32 index, int *ctx)
+{
+	bpf_throw();
+	return 0;
+}
+
+__noinline static int loop_cb2(u32 index, int *ctx)
+{
+	bpf_throw();
+	return 0;
+}
+
+SEC("tc")
+int exception_throw_cb1(struct __sk_buff *ctx)
+{
+	bpf_loop(5, loop_cb1, NULL, 0);
+	return 1;
+}
+
+SEC("tc")
+int exception_throw_cb2(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	bpf_loop(5, loop_cb1, NULL, 0);
+	return 0;
+}
+
+SEC("tc")
+int exception_throw_cb_diff(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb);
+	if (ctx->protocol)
+		bpf_loop(5, loop_cb1, NULL, 0);
+	else
+		bpf_loop(5, loop_cb2, NULL, 0);
+	return 1;
+}
+
+extern void bpf_kfunc_call_test_always_throws(void) __ksym;
+extern void bpf_kfunc_call_test_never_throws(void) __ksym;
+
+SEC("tc")
+int exception_throw_kfunc1(struct __sk_buff *ctx)
+{
+	bpf_kfunc_call_test_always_throws();
+	return 1;
+}
+
+SEC("tc")
+int exception_throw_kfunc2(struct __sk_buff *ctx)
+{
+	bpf_kfunc_call_test_never_throws();
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_ext.c b/tools/testing/selftests/bpf/progs/exceptions_ext.c
new file mode 100644
index 000000000000..d3b9e32681ec
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
+	bpf_throw();
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
+	bpf_throw();
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
+	bpf_throw();
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
new file mode 100644
index 000000000000..d8459c3840e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -0,0 +1,267 @@
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
+	bpf_spin_lock(&lock);
+	if (ctx->len)
+		bpf_throw();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("function calls are not allowed while holding a lock")
+int reject_with_lock(void *ctx)
+{
+	bpf_spin_lock(&lock);
+	bpf_throw();
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
+	bpf_throw();
+}
+
+__noinline static int throwing_subprog(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		bpf_throw();
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
+	bpf_throw();
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
+	bpf_throw();
+}
+
+__noinline static int subprog_ref(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_throw();
+}
+
+__noinline static int subprog_cb_ref(u32 i, void *ctx)
+{
+	bpf_throw();
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
+__failure __msg("Unreleased reference")
+int reject_with_subprog_reference(void *ctx)
+{
+	return subprog_ref(ctx) + 1;
+}
+
+static __noinline int throwing_exception_cb(void)
+{
+	int i = 0;
+
+	bpf_assert_ne(i, 0);
+	return i;
+}
+
+static __noinline int exception_cb1(void)
+{
+	int i = 0;
+
+	bpf_assert_eq(i, 0);
+	return i;
+}
+
+static __noinline int exception_cb2(void)
+{
+	int i = 0;
+
+	bpf_assert_eq(i, 0);
+	return i;
+}
+
+__noinline int throwing_exception_gfunc(void)
+{
+	return throwing_exception_cb();
+}
+
+SEC("?tc")
+__failure __msg("is used as exception callback, cannot throw")
+int reject_throwing_exception_cb_1(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(throwing_exception_cb);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("exception callback can throw, which is not allowed")
+int reject_throwing_exception_cb_2(struct __sk_buff *ctx)
+{
+	throwing_exception_gfunc();
+	bpf_set_exception_callback(throwing_exception_cb);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("different exception callback subprogs for same insn 7: 2 and 1")
+int reject_throwing_exception_cb_3(struct __sk_buff *ctx)
+{
+	if (ctx->protocol)
+		bpf_set_exception_callback(exception_cb1);
+	else
+		bpf_set_exception_callback(exception_cb2);
+	bpf_throw();
+}
+
+__noinline int gfunc_set_exception_cb(void)
+{
+	bpf_set_exception_callback(exception_cb1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("exception callback cannot be set within global function or extension program")
+int reject_set_exception_cb_gfunc(struct __sk_buff *ctx)
+{
+	gfunc_set_exception_cb();
+	return 0;
+}
+
+static __noinline int exception_cb_rec(void)
+{
+	bpf_set_exception_callback(exception_cb_rec);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("exception callback cannot be set from within exception callback")
+int reject_set_exception_cb_rec1(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_rec);
+	return 0;
+}
+
+static __noinline int exception_cb_rec2(void);
+
+static __noinline int exception_cb_rec1(void)
+{
+	bpf_set_exception_callback(exception_cb_rec2);
+	return 0;
+}
+
+static __noinline int exception_cb_rec2(void)
+{
+	bpf_set_exception_callback(exception_cb_rec2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("exception callback cannot be set from within exception callback")
+int reject_set_exception_cb_rec2(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_rec1);
+	return 0;
+}
+
+static __noinline int exception_cb_rec3(void)
+{
+	bpf_set_exception_callback(exception_cb1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("exception callback cannot be set from within exception callback")
+int reject_set_exception_cb_rec3(struct __sk_buff *ctx)
+{
+	bpf_set_exception_callback(exception_cb_rec3);
+	return 0;
+}
+
+static __noinline int exception_cb_bad_ret(void)
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
+char _license[] SEC("license") = "GPL";
-- 
2.40.0


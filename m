Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79664F6FE
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 03:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLQCRo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 21:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLQCRn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 21:17:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DD1D30E
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z26so6141123lfu.8
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5yiYxctgJ/8XywwUq+Qp9WWoytLhycOEtr4Q3oaz/c=;
        b=TJ1dfOhQ5P23E7I7THB6RLFEMa0ODJokkbmi1wOshi09BAta3ne9ufDeO+ARg+8RW8
         LjjQ1LO0sASNg+7RBMw/3MTHM89Jef5NpT/hEHdXGTD1EG2+fc/fmFjviRxVakP2VeLu
         p6OvFt3KxPwwQj8GWUDNnQCNHu5BkGH+xP5VFVfraW3Xl1B67j0gUBkXk264fBPVg6F9
         Hn3lP6ia+dy/QDG9TOboviraT7iFWZEJxZGLAJHLrbuyQRXKEcpb3f4QL1xVmJLJhhud
         s1OXEcKZYaqGKOHzdk9Gx18SogcloruUdQb+gtqOCb6xfg0Uu1s/eoOpqOhuE5lrFv9Q
         +9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5yiYxctgJ/8XywwUq+Qp9WWoytLhycOEtr4Q3oaz/c=;
        b=k4fQhkaKjwaXh6RBXl7Z+pXZUJ7d/Ys6+cwdrFFLDHrsAT8rbs3F4BheSrWsPeNdyD
         z0qIEwtaujeU6pRJE6YvkMAGFWo3lhGkg2xM3A1F9tZAYlgpW31NleUBV7bTiNqIQisS
         2TcjMBoxmlUW3uc/D0IlBG2jBy371vXYz7dochdHib3FDhVF9C7WzZrW/+tn0sBrte1j
         AdUY3LzYoEx+GA9mV2VzegOPntraxg4PDPgy1dkSNm2/wx/WcRtJZeLQ//O1C6VSdc/u
         rXe8610pNNg0RV0Iqj4g3eGKLMNUTxoRQ/XpaZDGvP/cp54+0lYhwC8Z75jTMpQZL4Jm
         wtiQ==
X-Gm-Message-State: ANoB5pm2diNsoaXhvkxRj8ub5FxeJ1maTWRF/EEJ2cslKysS1jjSMmGL
        Y0o5ONHuuZv0YzkaOY/74jaYZX90BGY=
X-Google-Smtp-Source: AA0mqf5b3+VNoo+n37EONtxrhf52vYwg73Nk0kO4jFDH5XMcgk4AWLPei2Dlg4h6b40hisIlinGbRg==
X-Received: by 2002:ac2:5189:0:b0:4b5:b705:9bf7 with SMTP id u9-20020ac25189000000b004b5b7059bf7mr7906382lfi.11.1671243460203;
        Fri, 16 Dec 2022 18:17:40 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b0049e9122bd0esm370850lfn.114.2022.12.16.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 18:17:39 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: check if verifier.c:check_ids() handles 64+5 ids
Date:   Sat, 17 Dec 2022 04:17:11 +0200
Message-Id: <20221217021711.172247-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221217021711.172247-1-eddyz87@gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A simple program that allocates a bunch of unique register ids than
branches. The goal is to confirm that idmap used in verifier.c:check_ids()
has sufficient capacity to verify that branches converge to a same state.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       | 12 +++
 .../selftests/bpf/progs/check_ids_limits.c    | 77 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/check_ids_limits.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
new file mode 100644
index 000000000000..3933141928a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+
+#include "check_ids_limits.skel.h"
+
+#define TEST_SET(skel)			\
+	void test_##skel(void)		\
+	{				\
+		RUN_TESTS(skel);	\
+	}
+
+TEST_SET(check_ids_limits)
diff --git a/tools/testing/selftests/bpf/progs/check_ids_limits.c b/tools/testing/selftests/bpf/progs/check_ids_limits.c
new file mode 100644
index 000000000000..36c4a8bbe8ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/check_ids_limits.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct map_struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} map SEC(".maps");
+
+/* Make sure that verifier.c:check_ids() can handle (almost) maximal
+ * number of ids.
+ */
+SEC("?raw_tp")
+__naked __test_state_freq __log_level(2) __msg("43 to 45: safe")
+int allocate_many_ids(void)
+{
+	/* Use bpf_map_lookup_elem() as a way to get a bunch of values
+	 * with unique ids.
+	 */
+#define __lookup(dst)				\
+		"r1 = %[map] ll;"		\
+		"r2 = r10;"			\
+		"r2 += -8;"			\
+		"call %[bpf_map_lookup_elem];"	\
+		dst " = r0;"
+	asm volatile(
+		"r0 = 0;"
+		"*(u64*)(r10 - 8) = r0;"
+		"r7 = r10;"
+		"r8 = 0;"
+		/* Spill 64 bpf_map_lookup_elem() results to stack,
+		 * each lookup gets its own unique id.
+		 */
+	"write_loop:"
+		"r7 += -8;"
+		"r8 += -8;"
+		__lookup("*(u64*)(r7 + 0)")
+		"if r8 != -512 goto write_loop;"
+		/* No way to source unique ids for r1-r5 as these
+		 * would be clobbered by bpf_map_lookup_elem call,
+		 * so make do with 64+5 unique ids.
+		 */
+		__lookup("r6")
+		__lookup("r7")
+		__lookup("r8")
+		__lookup("r9")
+		__lookup("r0")
+		/* Create a branching point for states comparison. */
+/* 43: */	"if r0 != 0 goto skip_one;"
+		/* Read all registers and stack spills to make these
+		 * persist in the checkpoint state.
+		 */
+		"r0 = r0;"
+	"skip_one:"
+/* 45: */	"r0 = r6;"
+		"r0 = r7;"
+		"r0 = r8;"
+		"r0 = r9;"
+		"r0 = r10;"
+		"r1 = 0;"
+	"read_loop:"
+		"r0 += -8;"
+		"r1 += -8;"
+		"r2 = *(u64*)(r0 + 0);"
+		"if r1 != -512 goto read_loop;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map)
+		: __clobber_all);
+#undef __lookup
+}
-- 
2.38.2


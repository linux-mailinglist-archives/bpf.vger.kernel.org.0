Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C730CC70
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 20:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhBBT43 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhBBNut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 08:50:49 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90108C0613ED
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 05:50:08 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o16so4507628qkj.15
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=paDnnRUZgFLJW6O0aJLXVvHItkFJZQG5OI0wx8WFRDk=;
        b=Qy/q/+H2CEHwHD8Qpqz5e8CzV1q/kaW1SYbvkDYJZA19qB5/8x/cv4GBqG6x13wMVI
         oycMy0iqViP7WXLLwB7QSyQVboNpLfhZYnNzDD6bA9l1bDcU8RnhEoUwZ5ueCCgXK1Xt
         MdASwdn1NYJiamDTiGX9c90F5+Jw5P9XmZlO/OQhcTMQOaW+BULPqTFEz8IeLCr78fOk
         MRA8Ud4qHr08X8YBJJs3puMNEateyTJxjnfDfm5riak1dbiVnqjy1Ip8DuWtN/D7NXdE
         WsnpZ+d2ksNlN4lBkccTcSk3m2WN9FHY8Vsf5k7kJMVGmPRbqD/hVXlFim4J4ta1xmbn
         rYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=paDnnRUZgFLJW6O0aJLXVvHItkFJZQG5OI0wx8WFRDk=;
        b=pVxyIlNmGdl4uyZYPTbSq0HpRk7X7J6+0SPpcJQwlhxiv41SD1pBURv8v5dtfiEUAT
         9zLoKGPnnMgLpdzbj06Ei4fcKk4yY6UzfujKk+iPw4bucI3UaO86Yd+oCXqtcK+EvsCy
         i8GPMb/ycgQR6cKbGUR1kcl0EqtAEOpb8nU7ltnRVEIAAKWYJnLjpm4qp8HotenF6ykX
         K/L+2248YTDtDJaYzB8XUHoWoubwk0uDbtssu7Yq8VX77IZG3NzNjXyUQ1ZanU8iqQyC
         exggVVXVd8WRk/t3IDVJN5As6lHl+c1ZIh73/qTATBeOgPxT2A78PtH8XUDnN5tS0pyh
         8hpA==
X-Gm-Message-State: AOAM53258ZW4xtSTG9ohxQogvtA4iZrfYPYq8+3opBl5R+YZecWr8s3C
        9/dQ02ahqqQv3C5MxxUvJT9uKU3SuTvyq5plRe4PGCdNU7yBFMjhPQlp0Gvn9V+aUlHb+I+f70a
        zybG4RmK4f4RBuol2qniufQKbPj3b7rBkdjVwRiv8avBglJ5DWsdlp6f6fRY6o3s=
X-Google-Smtp-Source: ABdhPJxdmOVEfHyty+oRjH4/+bJcKQP8dsrF1DlnRj1Cn/OtoNCWi/IlXZqZx13WCUeU8gn2PErBVfv8Xsvs4Q==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:c3c9:: with SMTP id
 p9mr20112733qvi.49.1612273807536; Tue, 02 Feb 2021 05:50:07 -0800 (PST)
Date:   Tue,  2 Feb 2021 13:50:02 +0000
Message-Id: <20210202135002.4024825-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH bpf-next v3] bpf: Propagate stack bounds to registers in
 atomics w/ BPF_FETCH
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When BPF_FETCH is set, atomic instructions load a value from memory
into a register. The current verifier code first checks via
check_mem_access whether we can access the memory, and then checks
via check_reg_arg whether we can write into the register.

For loads, check_reg_arg has the side-effect of marking the
register's value as unkonwn, and check_mem_access has the side effect
of propagating bounds from memory to the register. This currently only
takes effect for stack memory.

Therefore with the current order, bounds information is thrown away,
but by simply reversing the order of check_reg_arg
vs. check_mem_access, we can instead propagate bounds smartly.

A simple test is added with an infinite loop that can only be proved
unreachable if this propagation is present. This is implemented both
with C and directly in test_verifier using assembly.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

Difference from v2->v3 [1]:

 * Fixed missing ENABLE_ATOMICS_TESTS check.

Difference from v1->v2:

 * Reworked commit message to clarify this only affects stack memory
 * Added the Suggested-by
 * Added a C-based test.

[1]: https://lore.kernel.org/bpf/CA+i-1C2ZWUbGxWJ8kAxbri9rBboyuMaVj_BBhg+2Zf_Su9BOJA@mail.gmail.com/T/#t

 kernel/bpf/verifier.c                         | 32 +++++++++++--------
 .../selftests/bpf/prog_tests/atomic_bounds.c  | 15 +++++++++
 .../selftests/bpf/progs/atomic_bounds.c       | 24 ++++++++++++++
 .../selftests/bpf/verifier/atomic_bounds.c    | 27 ++++++++++++++++
 4 files changed, 84 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomic_bounds.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_bounds.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 972fc38eb62d..5e09632efddb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3665,9 +3665,26 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return -EACCES;
 	}

+	if (insn->imm & BPF_FETCH) {
+		if (insn->imm == BPF_CMPXCHG)
+			load_reg = BPF_REG_0;
+		else
+			load_reg = insn->src_reg;
+
+		/* check and record load of old value */
+		err = check_reg_arg(env, load_reg, DST_OP);
+		if (err)
+			return err;
+	} else {
+		/* This instruction accesses a memory location but doesn't
+		 * actually load it into a register.
+		 */
+		load_reg = -1;
+	}
+
 	/* check whether we can read the memory */
 	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, -1, true);
+			       BPF_SIZE(insn->code), BPF_READ, load_reg, true);
 	if (err)
 		return err;

@@ -3677,19 +3694,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;

-	if (!(insn->imm & BPF_FETCH))
-		return 0;
-
-	if (insn->imm == BPF_CMPXCHG)
-		load_reg = BPF_REG_0;
-	else
-		load_reg = insn->src_reg;
-
-	/* check and record load of old value */
-	err = check_reg_arg(env, load_reg, DST_OP);
-	if (err)
-		return err;
-
 	return 0;
 }

diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
new file mode 100644
index 000000000000..addf127068e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "atomic_bounds.skel.h"
+
+void test_atomic_bounds(void)
+{
+	struct atomic_bounds *skel;
+	__u32 duration = 0;
+
+	skel = atomic_bounds__open_and_load();
+	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
+		return;
+}
diff --git a/tools/testing/selftests/bpf/progs/atomic_bounds.c b/tools/testing/selftests/bpf/progs/atomic_bounds.c
new file mode 100644
index 000000000000..e5fff7fc7f8f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/atomic_bounds.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+
+#ifdef ENABLE_ATOMICS_TESTS
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(sub, int x)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	int a = 0;
+	int b = __sync_fetch_and_add(&a, 1);
+	/* b is certainly 0 here. Can the verifier tell? */
+	while (b)
+		continue;
+#endif
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
new file mode 100644
index 000000000000..e82183e4914f
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
@@ -0,0 +1,27 @@
+{
+	"BPF_ATOMIC bounds propagation, mem->reg",
+	.insns = {
+		/* a = 0; */
+		/*
+		 * Note this is implemented with two separate instructions,
+		 * where you might think one would suffice:
+		 *
+		 * BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		 *
+		 * This is because BPF_ST_MEM doesn't seem to set the stack slot
+		 * type to 0 when storing an immediate.
+		 */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+		/* b = atomic_fetch_add(&a, 1); */
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
+		/* Verifier should be able to tell that this infinite loop isn't reachable. */
+		/* if (b) while (true) continue; */
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "back-edge",
+},

base-commit: 61ca36c8c4eb3bae35a285b1ae18c514cde65439
--
2.30.0.365.g02bc693789-goog


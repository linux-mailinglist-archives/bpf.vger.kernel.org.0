Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C929430AAD3
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBAPON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 10:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBAPB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 10:01:29 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D70C061786
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 07:00:35 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y9so454195wmj.7
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OnUlgQXic23J1KvXsr/ViVLBUAJAIV22sf87uiL75+w=;
        b=USBu4V2zW1xZPkBuLbe4LugxWWhi5ilT0p1DK5LgmTbQ0ldhGTd6ssuFYCWPZIghg8
         9kCOe+STqSWw51H6krjnrvuP0ZGZ4IZmAxDywAjEAXlUHKXA5ZE1JI5oTXqLQsboDG/T
         z0EGLSKNakNxazByddOfEaM3+EqDZKskBVjlqRzkNkaDLEp0M4tBS6b+75QZ5W7Fbx1U
         pwqFZYW8NzFcoIeYxVhSxUn4yF6IwXQXHbrRxKxMP9y9aamzyjy+Y8geV5iL7taQ9vLw
         QAUahrfj3u+vOhfM9ik5RhPHnSlRVbjY2zmpzdwt0t9wKdYVLPB6j0a2fMOGHRpoLWe6
         2CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OnUlgQXic23J1KvXsr/ViVLBUAJAIV22sf87uiL75+w=;
        b=DRdrOOKVr6wfyw8EklZtcYfN42k+pCNGCZPYzoWTcAS0Ct7LZ4bFOa8vn7rj6d6Zzc
         VIEB+H+GWkz+KyxNARoKe1yYBCIOC/uOaESSBXrEGbTNvLJoXcOgHyHzHscqPxiZJWjJ
         at2bN6YDz9QUd7LH8kJOFpLgF9/zJXI+LcfDUIpsVmrOFfnPPzJ4zGOl5WYlB9O2fTOH
         9R1SklfPP1fChiHlre+qBOPkOATz2A0uxKkLTTrT3MX6TBMYzDN8X3NQrtWptz2v2ru+
         wLPVRK0VMgMGizOfNQDcrMpXZoWJ1DwMTgoMbv8k9qO74b7S+L8I1jw/o3HxqDVHhfw0
         Gpyw==
X-Gm-Message-State: AOAM530lPgZ98D3vJ2Qfw5mjXJNk3Lovantwj6y5mU3Qdu2iUrLrSU8n
        f/6hv3RnUNut3LsEycDO/NYdF/XErKDJfntX2hEIZukT0TzX8Pey02VoD5fboVCipvEEKDUd939
        e4830LO/mNCDLC6b23U2B/Wu/YBn781YYfaIylE9CjMRhrImiuGPny18Lp0KVqjY=
X-Google-Smtp-Source: ABdhPJxnEpIwlj8pyrCLCDkUtKrT6vWsNtt8NC7VPoPzFgqZiFGSDXa7SBdgltrBCTMPnpdmP4EtYZtzqAO/dA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:678a:: with SMTP id
 b132mr3318499wmc.35.1612191633878; Mon, 01 Feb 2021 07:00:33 -0800 (PST)
Date:   Mon,  1 Feb 2021 15:00:28 +0000
Message-Id: <20210201150028.2279522-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH bpf-next v2] bpf: Propagate memory bounds to registers in
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
of propagating bounds from memory to the register.

Therefore with the current order, bounds information is thrown away,
but by simply reversing the order of check_reg_arg
vs. check_mem_access, we can instead propagate bounds smartly.

A simple test is added with an infinite loop that can only be proved
unreachable if this propagation is present. This is implemented both
with C and directly in test_verifier using assembly.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>

---

Difference from v1->v2:

 * Reworked commit message to clarify this only affects stack memory
 * Added the Suggested-by
 * Added a C-based test.

 kernel/bpf/verifier.c                         | 32 +++++++++++--------
 .../selftests/bpf/prog_tests/atomic_bounds.c  | 15 +++++++++
 .../selftests/bpf/progs/atomic_bounds.c       | 15 +++++++++
 .../selftests/bpf/verifier/atomic_bounds.c    | 27 ++++++++++++++++
 4 files changed, 75 insertions(+), 14 deletions(-)
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
index 000000000000..ea2e982c7f3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/atomic_bounds.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(sub, int x)
+{
+	int a = 0;
+	int b = __sync_fetch_and_add(&a, 1);
+	/* b is certainly 0 here. Can the verifier tell? */
+	while (b)
+		continue;
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


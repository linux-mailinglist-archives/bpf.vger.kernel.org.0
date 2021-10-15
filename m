Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1FD42EDBE
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhJOJfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhJOJfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 05:35:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926CC061753
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 02:33:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso4041737yba.3
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6myK6WnI6dJ3vgs3FhgJcImZgK4luWhZru749g0AYEM=;
        b=rGL6DqoXuJLBeaNawkHojQD7EDvEZGyvkXsfO18Q3++92kGCrOllm0bBEpvg4I7nsI
         YfWbkz8lI7OSGeVEmpvHkw6wIVklrXxOU/4OuAVlmW33XU+M4LgiZ0mm4wYGUuOIH9KH
         qp0maWA7PJjgTfWstyEo7TUSAVMoJ9b+5NGpQxcYHhm08BTcMvJyb0gTp3FqVAVE/A7j
         gHIGhu94L5UWaE83SXmtLCjUBVQzKXjgwkRSSrVE+xxXLgt9kIvtGL4HHJUDUGcydMXo
         ufaHlAtFmsl2tjdoOhNwV/SDkjr/Iw8dRVZZnoN2FYEk2QnYKZp3i27apZ0QncWWTJPo
         Yp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6myK6WnI6dJ3vgs3FhgJcImZgK4luWhZru749g0AYEM=;
        b=YFa482q/ELRrKNPBGOjr1xAG7c7rSPwWCnYak7D96TfuN+Zz6NvB47WSuk39RiOJ9b
         IEVG1wazA4SjHrKrIH8L3b/5qWmhf1+2kzl7QyZKu7eVaVk9oojlPYnunUmam5Egmui9
         9IE+CErX2/uPMpPqeIHIe2SsLPyIXycmEU7gjcb0LQPQfkoRZTfd+VNEIk+HjZ3eVnRL
         ZN5B0EXzZ7K2hn2NqyZqxrxjEuN51CMYfF11snhf9PuoCVMSzU8qaI6pFK4jCsTTYQbP
         qDAM7Rwu7Gk+GtElhfcDUNS0u2AZcmpGUcA9P0X5CnAdqlqlrwxywjIsy0vFohJ+pMhQ
         EAcg==
X-Gm-Message-State: AOAM531Uu/t4ZZlcnCL7R0/WBLYxY8hA7m5tYUUSlK70wsr9vepayOcf
        HrYpiX6SK1ReKvMpNvtYlrM3yylv2kOr8SWeA2DpWHAoms5rx5MEChdBOkOo/NDAn0FZ1ECy1AO
        nY450lrBQT2hVmwNUjbCPvrOxLRaalHvktpRn+AwAhxpFTuifuxSC1VlaFM/173A=
X-Google-Smtp-Source: ABdhPJw0cWvVwG/eQ+2pTAA9FuOD8iTsTNLXdLHhlfF3wP4k06jKbAivbM/OuxLD1XL/kblT/6f2qQ2WYcnAhQ==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:707:: with SMTP id
 k7mr13103612ybt.545.1634290403688; Fri, 15 Oct 2021 02:33:23 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:33:18 +0000
Message-Id: <20211015093318.1273686-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [[PATCH bpf-next]] selftests/bpf: Some more atomic tests
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some new verifier tests that hit some important gaps in the parameter
space for atomic ops.

There are already exhaustive tests for the JIT part in
lib/test_bpf.c, but these exercise the verifier too.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 38 +++++++++++++
 .../selftests/bpf/verifier/atomic_fetch.c     | 57 +++++++++++++++++++
 .../selftests/bpf/verifier/atomic_invalid.c   | 25 ++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_invalid.c

diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index 6e52dfc64415..c22dc83a41fd 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -119,3 +119,41 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"Dest pointer in r0 - fail",
+	.insns = {
+		/* val = 0; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		/* r0 = &val */
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
+		/* r0 = atomic_cmpxchg(&val, r0, 1); */
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
+		/* if (r0 != 0) exit(1); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"Dest pointer in r0 - succeed",
+	.insns = {
+		/* r0 = &val */
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_10),
+		/* val = r0; */
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+		/* r0 = atomic_cmpxchg(&val, r0, 0); */
+		BPF_MOV64_IMM(BPF_REG_1, 0),
+		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
+		/* r1 = *r0 */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, -8),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_fetch.c b/tools/testing/selftests/bpf/verifier/atomic_fetch.c
new file mode 100644
index 000000000000..3bc9ff7a860b
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_fetch.c
@@ -0,0 +1,57 @@
+#define __ATOMIC_FETCH_OP_TEST(src_reg, dst_reg, operand1, op, operand2, expect) \
+	{								\
+		"atomic fetch " #op ", src=" #dst_reg " dst=" #dst_reg,	\
+		.insns = {						\
+			/* u64 val = operan1; */			\
+			BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, operand1),	\
+			/* u64 old = atomic_fetch_add(&val, operand2); */ \
+			BPF_MOV64_REG(dst_reg, BPF_REG_10),		\
+			BPF_MOV64_IMM(src_reg, operand2),		\
+			BPF_ATOMIC_OP(BPF_DW, op,			\
+				      dst_reg, src_reg, -8),		\
+			/* if (old != operand1) exit(1); */		\
+			BPF_JMP_IMM(BPF_JEQ, src_reg, operand1, 2),	\
+			BPF_MOV64_IMM(BPF_REG_0, 1),			\
+			BPF_EXIT_INSN(),				\
+			/* if (val != result) exit (2); */		\
+			BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),	\
+			BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, expect, 2),	\
+			BPF_MOV64_IMM(BPF_REG_0, 2),			\
+			BPF_EXIT_INSN(),				\
+			/* exit(0); */					\
+			BPF_MOV64_IMM(BPF_REG_0, 0),			\
+			BPF_EXIT_INSN(),				\
+		},							\
+		.result = ACCEPT,					\
+	}
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 1, BPF_ADD | BPF_FETCH, 2, 3),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 1, BPF_ADD | BPF_FETCH, 2, 3),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_0, 1, BPF_ADD | BPF_FETCH, 2, 3),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_2, BPF_REG_3, 1, BPF_ADD | BPF_FETCH, 2, 3),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_4, BPF_REG_5, 1, BPF_ADD | BPF_FETCH, 2, 3),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_9, BPF_REG_8, 1, BPF_ADD | BPF_FETCH, 2, 3),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 0x010, BPF_AND | BPF_FETCH, 0x011, 0x010),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 0x010, BPF_AND | BPF_FETCH, 0x011, 0x010),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_0, 0x010, BPF_AND | BPF_FETCH, 0x011, 0x010),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_2, BPF_REG_3, 0x010, BPF_AND | BPF_FETCH, 0x011, 0x010),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_4, BPF_REG_5, 0x010, BPF_AND | BPF_FETCH, 0x011, 0x010),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_9, BPF_REG_8, 0x010, BPF_AND | BPF_FETCH, 0x011, 0x010),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 0x010, BPF_OR | BPF_FETCH, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 0x010, BPF_OR | BPF_FETCH, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_0, 0x010, BPF_OR | BPF_FETCH, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_2, BPF_REG_3, 0x010, BPF_OR | BPF_FETCH, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_4, BPF_REG_5, 0x010, BPF_OR | BPF_FETCH, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_9, BPF_REG_8, 0x010, BPF_OR | BPF_FETCH, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 0x010, BPF_XOR | BPF_FETCH, 0x011, 0x001),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 0x010, BPF_XOR | BPF_FETCH, 0x011, 0x001),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_0, 0x010, BPF_XOR | BPF_FETCH, 0x011, 0x001),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_2, BPF_REG_3, 0x010, BPF_XOR | BPF_FETCH, 0x011, 0x001),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_4, BPF_REG_5, 0x010, BPF_XOR | BPF_FETCH, 0x011, 0x001),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_9, BPF_REG_8, 0x010, BPF_XOR | BPF_FETCH, 0x011, 0x001),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 0x010, BPF_XCHG, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 0x010, BPF_XCHG, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_0, 0x010, BPF_XCHG, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_2, BPF_REG_3, 0x010, BPF_XCHG, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_4, BPF_REG_5, 0x010, BPF_XCHG, 0x011, 0x011),
+__ATOMIC_FETCH_OP_TEST(BPF_REG_9, BPF_REG_8, 0x010, BPF_XCHG, 0x011, 0x011),
+#undef __ATOMIC_FETCH_OP_TEST
diff --git a/tools/testing/selftests/bpf/verifier/atomic_invalid.c b/tools/testing/selftests/bpf/verifier/atomic_invalid.c
new file mode 100644
index 000000000000..39272720b2f6
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_invalid.c
@@ -0,0 +1,25 @@
+#define __INVALID_ATOMIC_ACCESS_TEST(op)					\
+	{								\
+		"atomic " #op " access through non-pointer ",			\
+		.insns = {						\
+			BPF_MOV64_IMM(BPF_REG_0, 1),			\
+			BPF_MOV64_IMM(BPF_REG_1, 0),			\
+			BPF_ATOMIC_OP(BPF_DW, op, BPF_REG_1, BPF_REG_0, -8), \
+			BPF_MOV64_IMM(BPF_REG_0, 0),			\
+			BPF_EXIT_INSN(),				\
+		},							\
+		.result = REJECT,					\
+		.errstr = "R1 invalid mem access 'inv'"			\
+	}
+__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD | BPF_FETCH),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_ADD | BPF_FETCH),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_AND),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_AND | BPF_FETCH),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_OR),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_OR | BPF_FETCH),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_XOR),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_XOR | BPF_FETCH),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_XCHG),
+__INVALID_ATOMIC_ACCESS_TEST(BPF_CMPXCHG),
-- 
2.33.0.1079.g6e70778dc9-goog


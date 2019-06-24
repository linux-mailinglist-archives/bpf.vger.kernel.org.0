Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9F51F5C
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 01:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfFXX5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 19:57:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55329 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfFXX5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 19:57:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so10528605pfo.22
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AvvLLB8A0iI06VA1j5j+vTzVvGJk1Op1AW1IdCduR9s=;
        b=laV3jsqXk7tQgx/M2ghVE2rpd2papyjM29Q9rcnqLLdX6k3Ks7PPI4uu6JNGAvLCj5
         Jkrb2gnArJr/LMtJa741+MnmgKUgLoHQWUIszZEzh9FhL5hVldYSrLmXRAm1CqIkXf3I
         DdAaKCoN52jYmAizGlXvbvOcM3cevF34NmC+/k/1Vi0uxwhnsKaETpOyDHqjeOJkEcL8
         VgREBK03CBAZ3bPR+4M4ebEBgO+hBcki+nTyyB1piJK9jF96q/I8kYmfMfkEisXFg9eM
         YdVY2gIzOXihi68d0EeCgg2CF7BGDW6cRRkfzaR8DYv9hBJEMemvspyWKwMC8nYSYC62
         tslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AvvLLB8A0iI06VA1j5j+vTzVvGJk1Op1AW1IdCduR9s=;
        b=OfpLzCX9O6eaTjWM6giqemPBuJIcprCsv4n91GdEhEJp2pg7pBVh8tCNIhXnnh1CLA
         N5of2ESaGxJXL1Fwz8FgZF9vmrJRXjxTIvvy0JA0SE/yArfjFs3eBYjXYRbFAPqKp74Q
         v7LMSPBsCYHhgaZnO2jEVfPt57yEtocSy98GRhQL9JqP2k9K8GFYurg5UDdpr8eBawrB
         5G5mgu11MESQAxSJ8G7qodm+KsSJIMOhxcecq+sq6Yt8QdWQK5XD6nOunmR9D2kUtvk+
         5PP76FSUTyCcsJAdUIwwhGA/r/6fF6jt/D5qST0KN/dPV30zpdJGR1E1QXRTT+Sglwk6
         SwkA==
X-Gm-Message-State: APjAAAW5gtS2rBzM143DY0gRw6ZzLAK4GOCB/kh2FjgH4/Fa7tZSAgX9
        YND+Y5Mhb7kwtkXodmHcm2E8FngNsXLRZ/re
X-Google-Smtp-Source: APXvYqwciweaPxQBqIDKxYnTBrKlbUTohzpzGvfyPxaGOGrQzq4SzlUgMih0FyyS7RPyykctxIJwYsnCe44fPOfI
X-Received: by 2002:a63:9143:: with SMTP id l64mr24700877pge.65.1561420649647;
 Mon, 24 Jun 2019 16:57:29 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:57:20 -0700
In-Reply-To: <20190624235720.167067-1-allanzhang@google.com>
Message-Id: <20190624235720.167067-3-allanzhang@google.com>
Mime-Version: 1.0
References: <20190624235720.167067-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 2/2] bpf: Add selftests for bpf_perf_event_output
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Software event output is only enabled by a few prog types.
This test is to ensure that all supported types are enbled for
bpf_perf_event_output sucessfully.

Signed-off-by: allanzhang <allanzhang@google.com>
---
 tools/testing/selftests/bpf/test_verifier.c   | 33 ++++++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c5514daf8865..901a188e1eea 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	18
+#define MAX_NR_MAPS	19
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -84,6 +84,7 @@ struct bpf_test {
 	int fixup_map_array_wo[MAX_FIXUPS];
 	int fixup_map_array_small[MAX_FIXUPS];
 	int fixup_sk_storage_map[MAX_FIXUPS];
+	int fixup_map_event_output[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval, retval_unpriv, insn_processed;
@@ -604,6 +605,28 @@ static int create_sk_storage_map(void)
 	return fd;
 }
 
+static int create_event_output_map(void)
+{
+	struct bpf_create_map_attr attr = {
+		.name = "test_map",
+		.map_type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+		.key_size = 4,
+		.value_size = 4,
+		.max_entries = 1,
+	};
+	int fd, btf_fd;
+
+	btf_fd = load_btf();
+	if (btf_fd < 0)
+		return -1;
+	attr.btf_fd = btf_fd;
+	fd = bpf_create_map_xattr(&attr);
+	close(attr.btf_fd);
+	if (fd < 0)
+		printf("Failed to create event_output\n");
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
@@ -627,6 +650,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_array_wo = test->fixup_map_array_wo;
 	int *fixup_map_array_small = test->fixup_map_array_small;
 	int *fixup_sk_storage_map = test->fixup_sk_storage_map;
+	int *fixup_map_event_output = test->fixup_map_event_output;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -788,6 +812,13 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_sk_storage_map++;
 		} while (*fixup_sk_storage_map);
 	}
+	if (*fixup_map_event_output) {
+		map_fds[18] = create_event_output_map();
+		do {
+			prog[*fixup_map_event_output].imm = map_fds[18];
+			fixup_map_event_output++;
+		} while (*fixup_map_event_output);
+	}
 }
 
 static int set_admin(bool admin)
diff --git a/tools/testing/selftests/bpf/verifier/event_output.c b/tools/testing/selftests/bpf/verifier/event_output.c
new file mode 100644
index 000000000000..b25eabcfaa56
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/event_output.c
@@ -0,0 +1,94 @@
+/* instructions used to output a skb based software event, produced
+ * from code snippet:
+struct TMP {
+  uint64_t tmp;
+} tt;
+tt.tmp = 5;
+bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
+		      &tt, sizeof(tt));
+return 1;
+
+the bpf assembly from llvm is:
+       0:       b7 02 00 00 05 00 00 00         r2 = 5
+       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) = r2
+       2:       bf a4 00 00 00 00 00 00         r4 = r10
+       3:       07 04 00 00 f8 ff ff ff         r4 += -8
+       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 = 0ll
+       6:       b7 03 00 00 00 00 00 00         r3 = 0
+       7:       b7 05 00 00 08 00 00 00         r5 = 8
+       8:       85 00 00 00 19 00 00 00         call 25
+       9:       b7 00 00 00 01 00 00 00         r0 = 1
+      10:       95 00 00 00 00 00 00 00         exit
+
+    The reason I put the code here instead of fill_helpers is that map fixup is
+    against the insns, instead of filled prog.
+*/
+
+#define __PERF_EVENT_INSNS__					\
+	BPF_MOV64_IMM(BPF_REG_2, 5),				\
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),		\
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),			\
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),			\
+	BPF_LD_MAP_FD(BPF_REG_2, 0),				\
+	BPF_MOV64_IMM(BPF_REG_3, 0),				\
+	BPF_MOV64_IMM(BPF_REG_5, 8),				\
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,		\
+		     BPF_FUNC_perf_event_output),		\
+	BPF_MOV64_IMM(BPF_REG_0, 1),				\
+	BPF_EXIT_INSN(),
+{
+	"perfevent for sockops",
+	.insns = { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for tc",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for lwt out",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_LWT_OUT,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for xdp",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for socket filter",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for sk_skb",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SK_SKB,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for cgroup skb",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
-- 
2.22.0.410.gd8fdbe21b5-goog


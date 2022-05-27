Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7F53693C
	for <lists+bpf@lfdr.de>; Sat, 28 May 2022 01:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355195AbiE0Xwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 May 2022 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiE0Xwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 May 2022 19:52:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853866AD9
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 16:52:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c19so9007683lfv.5
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivCBvAOxglFxtPQJjRRu8/TQgtXiBIXx/YmrRv9mEI4=;
        b=ZEii5bJVWxmfGVvbuT6llqlmyNGAEb8eDEceIIHxhKFR5k5F3HZ0DrccUWh6ZUXK1C
         0P6mJ2Lq4c0PhdxeRfa6OAd4qxYmgVS4H7I1lw/5XaIv0wGyW26vEszwFMfupOjAgs0F
         LSCWCGi7TryKYHGOWxaiUwO5aCGBuyWwfYERqoANf6H2CMjbEXT6909RKadWhtMaC9/c
         EObNBLfbDmwmzJdjD+0SmY+9AeEBhuyrFgRA9GvZf9Jp742NWrowyEVdTFv8n+GiXK+B
         Yqb5vqPiv816wvhQpz5xZpHUzMzBEgyceDWUGZ8Tq3VAmySHfDwowR3gKsCwlF/SOxCE
         n6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivCBvAOxglFxtPQJjRRu8/TQgtXiBIXx/YmrRv9mEI4=;
        b=m2ki3bLmOkxMe9gdAzyvYoNCOR4uMgLaxrRYzb7W0gCLxydbNDzNFKOyXJW8WBpp1E
         94dwU8+E4JzTMXBsDvEBaT1RoUE+Nm/35UGc4vXPXCYXTOfvTCwT4fh4p6tObG+bd8Pg
         hB1NdVbQ/tspiSCWUwsqU2n0wZNzNK6BArIqtmUG2Kt4vd8rFH3E53zTDBNCWq6X1ijI
         HvWjRgJdsbUrfDq5WCnMn48km61ZckDkk5LxI7QF9ePxJgVInzqKDga24wx2/g60l+/8
         snvWECO4IMysB3b6DxKTa2hGKrAq6pQgQASEN4OhRT4AbvDELBZRmcPXXzfaCB46dfxu
         zdag==
X-Gm-Message-State: AOAM5334uw4O3TFkHDhzPpzaLC8CeyOZenncmD1ugJtt7cmMpVaMfYl+
        Bpwy2BFxgAS0Jx5wgvOLyWndkz/GyLI=
X-Google-Smtp-Source: ABdhPJzPKKkpYzuMI3SU+CK9B4FK4adBRJGvpZDkyVqWOr+u1qJsmEXWud9/x3o/Uqys7A/Yu2+gQQ==
X-Received: by 2002:a05:6512:1051:b0:478:8351:6665 with SMTP id c17-20020a056512105100b0047883516665mr15374942lfb.390.1653695549352;
        Fri, 27 May 2022 16:52:29 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id s28-20020a19771c000000b00477a287438csm1071017lfc.2.2022.05.27.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 16:52:28 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next 1/3] selftests/bpf: specify expected instructions in test_verifier tests
Date:   Sat, 28 May 2022 02:51:45 +0300
Message-Id: <20220527235228.224879-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1653474626.git.eddyz87@gmail.com>
References: <cover.1653474626.git.eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allows to specify expected and unexpected instruction sequences in
test_verifier test cases. The instructions are requested from kernel
after BPF program loading, thus allowing to check some of the
transformations applied by BPF verifier.

- `expected_insn` field specifies a sequences of instructions expected
  to be found in the program;
- `unexpected_insn` field specifies a sequences of instructions that
  are not expected to be found in the program;
- INSN_OFF_MASK and INSN_IMM_MASK values could be used to mask `off`
  and `imm` fields.

The intended usage is as follows:

  {
	"inline simple bpf_loop call",
	.insns = {
	/* main */
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2,
                        BPF_PSEUDO_FUNC, 0, 6),
    ...
	BPF_EXIT_INSN(),
	/* callback */
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
	BPF_EXIT_INSN(),
	},
	.expected_insns = {
        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 8, 1)
	},
	.unexpected_insns = {
        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0,
                        INSN_OFF_MASK, INSN_IMM_MASK),
	},
	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
	.result = ACCEPT,
	.runs = 0,
  },

Here it is expected that helper function call instruction would be
replaced by a relative call instruction.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 182 ++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 372579c9f45e..01ee92932bb9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -51,6 +51,8 @@
 #endif
 
 #define MAX_INSNS	BPF_MAXINSNS
+#define MAX_EXPECTED_INSNS	32
+#define MAX_UNEXPECTED_INSNS	32
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
 #define MAX_NR_MAPS	23
@@ -58,6 +60,9 @@
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
+#define INSN_OFF_MASK	((s16)0xFFFF)
+#define INSN_IMM_MASK	((s32)0xFFFFFFFF)
+
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
 
@@ -79,6 +84,15 @@ struct bpf_test {
 	const char *descr;
 	struct bpf_insn	insns[MAX_INSNS];
 	struct bpf_insn	*fill_insns;
+	/* If specified, test engine looks for this sequence of
+	 * instructions in the BPF program after loading. Allows to
+	 * test rewrites applied by verifier.  Use values
+	 * INSN_OFF_MASK and INSN_IMM_MASK to mask `off` and `imm`
+	 * fields if content does not matter.  The test case fails if
+	 * specified instructions are not found.
+	 */
+	struct bpf_insn	expected_insns[MAX_EXPECTED_INSNS];
+	struct bpf_insn	unexpected_insns[MAX_UNEXPECTED_INSNS];
 	int fixup_map_hash_8b[MAX_FIXUPS];
 	int fixup_map_hash_48b[MAX_FIXUPS];
 	int fixup_map_hash_16b[MAX_FIXUPS];
@@ -1126,6 +1140,171 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
+static __u32 roundup_u32(__u32 number, __u32 divisor)
+{
+	if (number % divisor == 0)
+		return number / divisor;
+	else
+		return number / divisor + 1;
+}
+
+static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int err = 0;
+
+	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
+		err = errno;
+		perror("bpf_obj_get_info_by_fd failed");
+		goto out;
+	}
+
+	__u32 xlated_prog_len = info.xlated_prog_len;
+	*cnt = roundup_u32(xlated_prog_len, sizeof(**buf));
+	*buf = calloc(*cnt, sizeof(**buf));
+	if (!buf) {
+		err = -ENOMEM;
+		perror("can't allocate xlated program buffer");
+		goto out;
+	}
+
+	bzero(&info, sizeof(info));
+	info.xlated_prog_len = xlated_prog_len;
+	info.xlated_prog_insns = (__u64)*buf;
+
+	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
+		err = errno;
+		perror("second bpf_obj_get_info_by_fd failed");
+		goto out_free_buf;
+	}
+
+	goto out;
+
+ out_free_buf:
+	free(*buf);
+ out:
+	return err;
+}
+
+static bool is_null_insn(struct bpf_insn *insn)
+{
+	struct bpf_insn null_insn = {};
+
+	return memcmp(insn, &null_insn, sizeof(null_insn)) == 0;
+}
+
+static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
+{
+	for (int i = 0; i < max_len; ++i) {
+		if (is_null_insn(&seq[i]))
+			return i;
+	}
+	return max_len;
+}
+
+static bool compare_masked_insn(struct bpf_insn *orig, struct bpf_insn *masked)
+{
+	struct bpf_insn orig_masked;
+
+	memcpy(&orig_masked, orig, sizeof(orig_masked));
+	if (masked->imm == INSN_IMM_MASK)
+		orig_masked.imm = INSN_IMM_MASK;
+	if (masked->off == INSN_OFF_MASK)
+		orig_masked.off = INSN_OFF_MASK;
+
+	return memcmp(&orig_masked, masked, sizeof(orig_masked)) == 0;
+}
+
+static int find_insn_subseq(struct bpf_insn *seq, struct bpf_insn *subseq,
+			    int seq_len, int subseq_len)
+{
+	if (subseq_len > seq_len)
+		return -1;
+
+	for (int i = 0; i < seq_len - subseq_len + 1; ++i) {
+		bool found = true;
+
+		for (int j = 0; j < subseq_len; ++j) {
+			if (!compare_masked_insn(&seq[i + j], &subseq[j])) {
+				found = false;
+				break;
+			}
+		}
+		if (found)
+			return i;
+	}
+
+	return -1;
+}
+
+static void print_insn(struct bpf_insn *buf, int cnt,
+		       int mark_start, int mark_count)
+{
+	printf("  addr  op d s off  imm\n");
+	for (int i = 0; i < cnt; ++i) {
+		bool at_mark = (mark_start >= 0) &&
+			(i >= mark_start) &&
+			(i < mark_start + mark_count);
+		char *mark = at_mark ? "*" : " ";
+
+		struct bpf_insn *insn = &buf[i];
+
+		printf(" %s%04x: %02x %1x %x %04hx %08x\n",
+		       mark, i, insn->code, insn->dst_reg,
+		       insn->src_reg, insn->off, insn->imm);
+	}
+}
+
+static bool check_xlated_program(struct bpf_test *test, int fd_prog)
+{
+	struct bpf_insn *buf;
+	int cnt;
+	bool result = true;
+	int expected_insn_cnt =
+		null_terminated_insn_len(test->expected_insns,
+					 ARRAY_SIZE(test->expected_insns));
+	int unexpected_insn_cnt =
+		null_terminated_insn_len(test->unexpected_insns,
+					 ARRAY_SIZE(test->unexpected_insns));
+
+	if (expected_insn_cnt == 0 && unexpected_insn_cnt == 0)
+		goto out;
+
+	if (get_xlated_program(fd_prog, &buf, &cnt)) {
+		printf("FAIL: can't get xlated program\n");
+		result = false;
+		goto out;
+	}
+
+	int expected_idx = find_insn_subseq(buf, test->expected_insns,
+					    cnt, expected_insn_cnt);
+	int unexpected_idx = find_insn_subseq(buf, test->unexpected_insns,
+					      cnt, unexpected_insn_cnt);
+
+	if (expected_insn_cnt > 0 && expected_idx < 0) {
+		printf("FAIL: can't find expected subsequence of instructions\n");
+		result = false;
+		if (verbose) {
+			printf("Program:\n");
+			print_insn(buf, cnt, -1, -1);
+			printf("Expected subsequence:\n");
+			print_insn(test->expected_insns, expected_insn_cnt, -1, -1);
+		}
+	}
+
+	if (unexpected_insn_cnt > 0 && unexpected_idx >= 0) {
+		printf("FAIL: found unexpected subsequence of instructions\n");
+		result = false;
+		if (verbose)
+			print_insn(buf, cnt, unexpected_idx, unexpected_insn_cnt);
+	}
+
+	free(buf);
+ out:
+	return result;
+}
+
 static void do_test_single(struct bpf_test *test, bool unpriv,
 			   int *passes, int *errors)
 {
@@ -1262,6 +1441,9 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (verbose)
 		printf(", verifier log:\n%s", bpf_vlog);
 
+	if (!check_xlated_program(test, fd_prog))
+		goto fail_log;
+
 	run_errs = 0;
 	run_successes = 0;
 	if (!alignment_prevented_execution && fd_prog >= 0 && test->runs >= 0) {
-- 
2.25.1


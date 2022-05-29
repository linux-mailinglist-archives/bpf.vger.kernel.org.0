Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0D5372CC
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiE2Whx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiE2Whw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:37:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D952509
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 5so1322963lju.10
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXnvEClLQ0vrOSjnRmEB/c0kRUYDc+F4wwFzJ553DXc=;
        b=fS0hE31+NY2nlGmrumT8jdWFVN1WNp9+rw+dQMomWhh0/IUdl2dV0OX3gOjpAcG5p5
         IX06v5GAHJZP96KK/LU04ChslRo7i96qzTFLntHE0pP1iSe9mdQqi5/dmwXsBnJ7Pt2n
         ZITLYA3VZgUemeElNzZGMEPmNaVAiYbegj2HNtku9NBlirnM8GyNaYyyBZ1SRgkJwCOK
         uCSfE6TU/15lc5bhB4SOR/4JUakeAroiErxwhI+iH/cLlDV4c5wYFUL0fO4aNSu17wYt
         8LXAfL9fkZZHRjsu+GBBo38slIcT17mO930zr6UgSBygw65hGr6siRcCieCKZ020lK4h
         8viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXnvEClLQ0vrOSjnRmEB/c0kRUYDc+F4wwFzJ553DXc=;
        b=LC39ZMOPuu1RFy7abYoRvAu+XuAQQw2iE8r8E7c0uvhUzZU2qE7nci/MEN1okuL6uo
         jD8meR7TXUtkVFiQ+u0aEjdo7/qIKYGQfLKX8BkK6+CPogisT9kTPOiOkQZL8L/e93oK
         3y8vCt4A22UA6ZWukIrbC7y/mgnLYcLZFcK+dM3dxe8MXQtcniecVnL3uR9dFaxD+GJ/
         y1ei8kBkzQvNiAv+65K0KqphljZSuaQiL9tlUCJA9z1p0ZzoQyoyVGbjjRsMI04+5wkG
         VKSZMJQy0M3K5KyKzFAunGXZPhmGeoSKgpcxP8pWeGbDehtkXaXAF0J2RPs/sni8XyZh
         Feaw==
X-Gm-Message-State: AOAM533zAFVxNKhtZXhMQ1LJP2UjH96yqN2zMnVbQnPtzws1aT7vZKiz
        Up3H6deqjL0/88MGvULsXiFJ+pnTBUU=
X-Google-Smtp-Source: ABdhPJx5BQVJfptAg81Gybi4iJnROjMIlllfEakCoDp1+9y7DnheEYtJI5v6C0mVRGQ+fCgKRLhl3g==
X-Received: by 2002:a2e:8511:0:b0:253:db51:ad17 with SMTP id j17-20020a2e8511000000b00253db51ad17mr28888664lji.180.1653863868149;
        Sun, 29 May 2022 15:37:48 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d8-20020ac24c88000000b0047255d211a7sm1962861lfl.214.2022.05.29.15.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 15:37:47 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: specify expected instructions in test_verifier tests
Date:   Mon, 30 May 2022 01:36:44 +0300
Message-Id: <20220529223646.862464-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529223646.862464-1-eddyz87@gmail.com>
References: <20220529223646.862464-1-eddyz87@gmail.com>
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

- `expected_insn` field specifies a sequence of instructions expected
  to be found in the program;
- `unexpected_insn` field specifies a sequence of instructions that
  are not expected to be found in the program;
- `INSN_OFF_MASK` and `INSN_IMM_MASK` values could be used to mask
  `off` and `imm` fields.
- `SKIP_INSNS` could be used to specify that some instructions in the
  (un)expected pattern are not important (behavior similar to usage of
  `\t` in `errstr` field).

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
		BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
		SKIP_INSN(),
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

Here it is expected that move of 1 to register 1 would remain in place
and helper function call instruction would be replaced by a relative
call instruction.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 228 ++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 372579c9f45e..13468221d227 100644
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
@@ -58,6 +60,10 @@
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
+#define INSN_OFF_MASK	((s16)0xFFFF)
+#define INSN_IMM_MASK	((s32)0xFFFFFFFF)
+#define SKIP_INSNS()	BPF_RAW_INSN(0xde, 0xa, 0xd, 0xbeef, 0xdeadbeef)
+
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
 
@@ -79,6 +85,19 @@ struct bpf_test {
 	const char *descr;
 	struct bpf_insn	insns[MAX_INSNS];
 	struct bpf_insn	*fill_insns;
+	/* If specified, test engine looks for this sequence of
+	 * instructions in the BPF program after loading. Allows to
+	 * test rewrites applied by verifier.  Use values
+	 * INSN_OFF_MASK and INSN_IMM_MASK to mask `off` and `imm`
+	 * fields if content does not matter.  The test case fails if
+	 * specified instructions are not found.
+	 *
+	 * The sequence could be split into sub-sequences by adding
+	 * SKIP_INSNS instruction at the end of each sub-sequence. In
+	 * such case sub-sequences are searched for one after another.
+	 */
+	struct bpf_insn expected_insns[MAX_EXPECTED_INSNS];
+	struct bpf_insn unexpected_insns[MAX_UNEXPECTED_INSNS];
 	int fixup_map_hash_8b[MAX_FIXUPS];
 	int fixup_map_hash_48b[MAX_FIXUPS];
 	int fixup_map_hash_16b[MAX_FIXUPS];
@@ -1126,6 +1145,212 @@ static bool cmp_str_seq(const char *log, const char *exp)
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
+static bool is_skip_insn(struct bpf_insn *insn)
+{
+	struct bpf_insn skip_insn = SKIP_INSNS();
+
+	return memcmp(insn, &skip_insn, sizeof(skip_insn)) == 0;
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
+static int find_skip_insn_marker(struct bpf_insn *seq, int len)
+{
+	for (int i = 0; i < len; ++i)
+		if (is_skip_insn(&seq[i]))
+			return i;
+
+	return -1;
+}
+
+/* Return true if all sub-sequences in `subseqs` could be found in
+ * `seq` one after another. Sub-sequences are separated by a single
+ * nil instruction.
+ */
+static bool find_all_insn_subseqs(struct bpf_insn *seq, struct bpf_insn *subseqs,
+				  int seq_len, int max_subseqs_len)
+{
+	int subseqs_len = null_terminated_insn_len(subseqs, max_subseqs_len);
+
+	while (subseqs_len > 0) {
+		int skip_idx = find_skip_insn_marker(subseqs, subseqs_len);
+		int cur_subseq_len = skip_idx < 0 ? subseqs_len : skip_idx;
+		int subseq_idx = find_insn_subseq(seq, subseqs,
+						  seq_len, cur_subseq_len);
+
+		if (subseq_idx < 0)
+			return false;
+		seq += subseq_idx + cur_subseq_len;
+		seq_len -= subseq_idx + cur_subseq_len;
+		subseqs += cur_subseq_len + 1;
+		subseqs_len -= cur_subseq_len + 1;
+	}
+
+	return true;
+}
+
+static void print_insn(struct bpf_insn *buf, int cnt)
+{
+	printf("  addr  op d s off  imm\n");
+	for (int i = 0; i < cnt; ++i) {
+		struct bpf_insn *insn = &buf[i];
+
+		if (is_null_insn(insn))
+			break;
+
+		if (is_skip_insn(insn))
+			printf("  ...\n");
+		else
+			printf("  %04x: %02x %1x %x %04hx %08x\n",
+			       i, insn->code, insn->dst_reg,
+			       insn->src_reg, insn->off, insn->imm);
+	}
+}
+
+static bool check_xlated_program(struct bpf_test *test, int fd_prog)
+{
+	struct bpf_insn *buf;
+	int cnt;
+	bool result = true;
+	bool check_expected = !is_null_insn(test->expected_insns);
+	bool check_unexpected = !is_null_insn(test->unexpected_insns);
+
+	if (!check_expected && !check_unexpected)
+		goto out;
+
+	if (get_xlated_program(fd_prog, &buf, &cnt)) {
+		printf("FAIL: can't get xlated program\n");
+		result = false;
+		goto out;
+	}
+
+	if (check_expected &&
+	    !find_all_insn_subseqs(buf, test->expected_insns,
+				   cnt, MAX_EXPECTED_INSNS)) {
+		printf("FAIL: can't find expected subsequence of instructions\n");
+		result = false;
+		if (verbose) {
+			printf("Program:\n");
+			print_insn(buf, cnt);
+			printf("Expected subsequence:\n");
+			print_insn(test->expected_insns, MAX_EXPECTED_INSNS);
+		}
+	}
+
+	if (check_unexpected &&
+	    find_all_insn_subseqs(buf, test->unexpected_insns,
+				  cnt, MAX_UNEXPECTED_INSNS)) {
+		printf("FAIL: found unexpected subsequence of instructions\n");
+		result = false;
+		if (verbose) {
+			printf("Program:\n");
+			print_insn(buf, cnt);
+			printf("Un-expected subsequence:\n");
+			print_insn(test->unexpected_insns, MAX_UNEXPECTED_INSNS);
+		}
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
@@ -1262,6 +1487,9 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
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


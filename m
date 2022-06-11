Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AA547458
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiFKLmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Jun 2022 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiFKLmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jun 2022 07:42:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12921CB30
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 04:42:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s6so2135704lfo.13
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FfHmQjx4mtPcF8La0NIopHbF6tNLW/oeLpWOZtmNGg=;
        b=YRHAHvfDbrC6K7yASz0kTfzM2+bmuZtr5hmIGHt58FUM7/AG6NiNlzZ4cE44UF5H5+
         TDB7Eu1tqUyFn7K2rYAAuFluA/SyePaw2POiuhUsXw1ncDCIdaMrriumHlUjrd8cHso9
         ewpJb014KnAhaI1wIJH1yBo//6pzaK4Q/p5VNeP/vl7wStQimssKT8XkgLRUFyLwtFVh
         lubXmTdarw/pIJX589ZrABNvSFlwDYzPZ4Ogn1Sm6GOjEAczlK+sfXm4+HE3Acc8ojnc
         lOFcU/RTgUib5mVxRbht35wBcfcw56jyqOsIF2u3Yi5zb8y+8LALYwhBpaB3hOYoVXea
         SuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FfHmQjx4mtPcF8La0NIopHbF6tNLW/oeLpWOZtmNGg=;
        b=eMTsPO2d+bC3QvCGF8wBRUEqxwr+wSA9O2glR0/2WfUo+HrebgOMQJgoQQ5N3A5lDX
         wYVhMDxR7aAfe68rWlsJGBw9FpLJabAy/vn4jcVBIO1InBuDmM4TwP0mbKGdu/oZySws
         KCX7vO9Y525oslMYERWeq0Q4OnkPO8ODMbg2HlMKXN0ALlORC+B/nf7mRHPIkIJwcFP9
         doTLu4p89oV0Jg8MgtrkWPt2iNX+Rg3/19wM3eCPq6xGsHto8uZQ1y+UKnZ4tD0Me7GZ
         lHtkECtBeG+C4WCv0t4NT/LsRm+IO27bUaMxhpuZ1e5NsWSaBLsiAEBFWNQ4yPbQLBm5
         UhYA==
X-Gm-Message-State: AOAM530ua8CVC+DaL8gRjIiVZi0iPCNygLj/9q37iACktMEo+mww0Xpo
        Lgl5VtMcpU6I/tcIwATwXt59Q4nwRzA2cfMv
X-Google-Smtp-Source: ABdhPJxiuyhskkvf9FR+RSzb7D6VI80xgmjRVWf4rS0hSuvQSC3aHnn2YdJLTH7A/F2ERmJym3wdAA==
X-Received: by 2002:a05:6512:282b:b0:47a:e70d:8723 with SMTP id cf43-20020a056512282b00b0047ae70d8723mr8893438lfb.557.1654947749204;
        Sat, 11 Jun 2022 04:42:29 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u18-20020ac25bd2000000b004795d64f37dsm229303lfn.105.2022.06.11.04.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:42:28 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
        joannelkoong@gmail.com
Cc:     eddyz87@gmail.com, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v5 1/5] selftests/bpf: specify expected instructions in test_verifier tests
Date:   Sat, 11 Jun 2022 14:40:17 +0300
Message-Id: <20220611114021.484408-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611114021.484408-1-eddyz87@gmail.com>
References: <20220611114021.484408-1-eddyz87@gmail.com>
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
	SKIP_INSNS(),
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
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 234 ++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 372579c9f45e..1f24eae9e16e 100644
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
 
+#define INSN_OFF_MASK	((__s16)0xFFFF)
+#define INSN_IMM_MASK	((__s32)0xFFFFFFFF)
+#define SKIP_INSNS()	BPF_RAW_INSN(0xde, 0xa, 0xd, 0xbeef, 0xdeadbeef)
+
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
 
@@ -79,6 +85,23 @@ struct bpf_test {
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
+	/* If specified, test engine applies same pattern matching
+	 * logic as for `expected_insns`. If the specified pattern is
+	 * matched test case is marked as failed.
+	 */
+	struct bpf_insn unexpected_insns[MAX_UNEXPECTED_INSNS];
 	int fixup_map_hash_8b[MAX_FIXUPS];
 	int fixup_map_hash_48b[MAX_FIXUPS];
 	int fixup_map_hash_16b[MAX_FIXUPS];
@@ -1126,6 +1149,214 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
+static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 xlated_prog_len;
+	__u32 buf_element_size = sizeof(struct bpf_insn);
+
+	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("bpf_obj_get_info_by_fd failed");
+		return -1;
+	}
+
+	xlated_prog_len = info.xlated_prog_len;
+	if (xlated_prog_len % buf_element_size) {
+		printf("Program length %d is not multiple of %d\n",
+		       xlated_prog_len, buf_element_size);
+		return -1;
+	}
+
+	*cnt = xlated_prog_len / buf_element_size;
+	*buf = calloc(*cnt, buf_element_size);
+	if (!buf) {
+		perror("can't allocate xlated program buffer");
+		return -ENOMEM;
+	}
+
+	bzero(&info, sizeof(info));
+	info.xlated_prog_len = xlated_prog_len;
+	info.xlated_prog_insns = (__u64)*buf;
+	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("second bpf_obj_get_info_by_fd failed");
+		goto out_free_buf;
+	}
+
+	return 0;
+
+out_free_buf:
+	free(*buf);
+	return -1;
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
+	int i;
+
+	for (i = 0; i < max_len; ++i) {
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
+	int i, j;
+
+	if (subseq_len > seq_len)
+		return -1;
+
+	for (i = 0; i < seq_len - subseq_len + 1; ++i) {
+		bool found = true;
+
+		for (j = 0; j < subseq_len; ++j) {
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
+	int i;
+
+	for (i = 0; i < len; ++i)
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
+	int i;
+
+	printf("  addr  op d s off  imm\n");
+	for (i = 0; i < cnt; ++i) {
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
@@ -1262,6 +1493,9 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
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


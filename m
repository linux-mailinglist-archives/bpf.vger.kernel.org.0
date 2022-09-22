Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5C5E7017
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 01:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIVXIG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 22 Sep 2022 19:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiIVXIC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 19:08:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C7410E5C7
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:08:01 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MKiLqk014997
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:08:01 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrayp8xf4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:08:01 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:07:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5D0F31F3844DD; Thu, 22 Sep 2022 16:07:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: allow to adjust BPF verifier log level in veristat
Date:   Thu, 22 Sep 2022 16:07:39 -0700
Message-ID: <20220922230739.1288536-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922230739.1288536-1-andrii@kernel.org>
References: <20220922230739.1288536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bT_tYjiqfPnCfl3rpKqtQy5U838VsY1B
X-Proofpoint-ORIG-GUID: bT_tYjiqfPnCfl3rpKqtQy5U838VsY1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_15,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add -l (--log-level) flag to override default BPF verifier log lever.
This only matters in verbose mode, which is the mode in which veristat
emits verifier log for each processed BPF program.

This is important because for successfully verified BPF programs
log_level 1 is empty, as BPF verifier truncates all the successfully
verified paths. So -l2 is the only way to actually get BPF verifier log
in practice. It looks sometihng like this:

  [vmuser@archvm bpf]$ sudo ./veristat xdp_tx.bpf.o -vl2
  Processing 'xdp_tx.bpf.o'...
  PROCESSING xdp_tx.bpf.o/xdp_tx, DURATION US: 19, VERDICT: success, VERIFIER LOG:
  func#0 @0
  0: R1=ctx(off=0,imm=0) R10=fp0
  ; return XDP_TX;
  0: (b4) w0 = 3                        ; R0_w=3
  1: (95) exit
  verification time 19 usec
  stack depth 0
  processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

  File          Program  Verdict  Duration (us)  Total insns  Total states  Peak states
  ------------  -------  -------  -------------  -----------  ------------  -----------
  xdp_tx.bpf.o  xdp_tx   success             19            2             0            0
  ------------  -------  -------  -------------  -----------  ------------  -----------
  Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b92c017364b2..c4caaaaeab9e 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -64,6 +64,7 @@ static struct env {
 	int filename_cnt;
 	bool verbose;
 	bool quiet;
+	int log_level;
 	enum resfmt out_fmt;
 	bool comparison_mode;
 
@@ -108,6 +109,7 @@ const char argp_program_doc[] =
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
+	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -156,6 +158,14 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -EINVAL;
 		}
 		break;
+	case 'l':
+		errno = 0;
+		env.log_level = strtol(arg, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "invalid log level: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
 	case 'C':
 		env.comparison_mode = true;
 		break;
@@ -526,7 +536,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 		if (!buf)
 			return -ENOMEM;
 		bpf_program__set_log_buf(prog, buf, buf_sz);
-		bpf_program__set_log_level(prog, 1 | 4); /* stats + log */
+		bpf_program__set_log_level(prog, env.log_level | 4); /* stats + log */
 	} else {
 		bpf_program__set_log_buf(prog, buf, buf_sz);
 		bpf_program__set_log_level(prog, 4); /* only verifier stats */
@@ -1280,6 +1290,8 @@ int main(int argc, char **argv)
 		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
 		return 1;
 	}
+	if (env.verbose && env.log_level == 0)
+		env.log_level = 1;
 
 	if (env.output_spec.spec_cnt == 0)
 		env.output_spec = default_output_spec;
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DD6EEB14
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjDYXtc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjDYXtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F57B219
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:30 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEj6T031710
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:30 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6hju3dg2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:30 -0700
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C4ED32F2D8336; Tue, 25 Apr 2023 16:49:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 01/10] veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag
Date:   Tue, 25 Apr 2023 16:49:02 -0700
Message-ID: <20230425234911.2113352-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rmdqclNKOe4y2LCixxzTDxcABZctX0yh
X-Proofpoint-ORIG-GUID: rmdqclNKOe4y2LCixxzTDxcABZctX0yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sometimes during debugging it's important that BPF program is loaded
with BPF_F_TEST_STATE_FREQ flag set to force verifier to do frequent
state checkpointing. Teach veristat to do this when -t ("test state")
flag is specified.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1db7185181da..655095810d4a 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -141,6 +141,7 @@ static struct env {
 	bool verbose;
 	bool debug;
 	bool quiet;
+	bool force_checkpoints;
 	enum resfmt out_fmt;
 	bool show_version;
 	bool comparison_mode;
@@ -209,6 +210,8 @@ static const struct argp_option opts[] = {
 	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
 	{ "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rotation" },
 	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (default to 16MB)" },
+	{ "test-states", 't', NULL, 0,
+	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STATE_FREQ program flag)" },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -284,6 +287,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			argp_usage(state);
 		}
 		break;
+	case 't':
+		env.force_checkpoints = true;
+		break;
 	case 'C':
 		env.comparison_mode = true;
 		break;
@@ -989,6 +995,9 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	/* increase chances of successful BPF object loading */
 	fixup_obj(obj, prog, base_filename);
 
+	if (env.force_checkpoints)
+		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_STATE_FREQ);
+
 	err = bpf_object__load(obj);
 	env.progs_processed++;
 
-- 
2.34.1


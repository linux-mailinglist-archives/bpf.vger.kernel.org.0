Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED135F5814
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJEQPI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 5 Oct 2022 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJEQPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 12:15:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064A29370
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 09:15:06 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295EjkGn013468
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 09:15:06 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k0ehwud1g-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 09:15:05 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 09:15:05 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 09:15:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A5F211FBED494; Wed,  5 Oct 2022 09:14:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: allow requesting log level 2 in test_verifier
Date:   Wed, 5 Oct 2022 09:14:48 -0700
Message-ID: <20221005161450.1064469-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mHoQzRR9_Tk9Q_CArK78UFBpsatkTu9J
X-Proofpoint-GUID: mHoQzRR9_Tk9Q_CArK78UFBpsatkTu9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Log level 1 on successfully verified programs are basically equivalent
to log level 4 (stats-only), so it's useful to be able to request more
verbose logs at log level 2. Teach test_verifier to recognize -vv as
"very verbose" mode switch and use log level 2 in such mode.

Also force verifier stats regradless of -v or -vv, they are very minimal
and useful to be always emitted in verbose mode.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 2dbcbf363c18..9c7091100b7f 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -68,7 +68,6 @@
 #define SKIP_INSNS()	BPF_RAW_INSN(0xde, 0xa, 0xd, 0xbeef, 0xdeadbeef)
 
 #define DEFAULT_LIBBPF_LOG_LEVEL	4
-#define VERBOSE_LIBBPF_LOG_LEVEL	1
 
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
@@ -81,6 +80,7 @@
 static bool unpriv_disabled = false;
 static int skips;
 static bool verbose = false;
+static int verif_log_level = 0;
 
 struct kfunc_btf_id_pair {
 	const char *kfunc;
@@ -759,7 +759,7 @@ static int load_btf_spec(__u32 *types, int types_len,
 		    .log_buf = bpf_vlog,
 		    .log_size = sizeof(bpf_vlog),
 		    .log_level = (verbose
-				  ? VERBOSE_LIBBPF_LOG_LEVEL
+				  ? verif_log_level
 				  : DEFAULT_LIBBPF_LOG_LEVEL),
 	);
 
@@ -1491,7 +1491,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (verbose)
-		opts.log_level = VERBOSE_LIBBPF_LOG_LEVEL;
+		opts.log_level = verif_log_level | 4; /* force stats */
 	else if (expected_ret == VERBOSE_ACCEPT)
 		opts.log_level = 2;
 	else
@@ -1746,6 +1746,13 @@ int main(int argc, char **argv)
 	if (argc > 1 && strcmp(argv[1], "-v") == 0) {
 		arg++;
 		verbose = true;
+		verif_log_level = 1;
+		argc--;
+	}
+	if (argc > 1 && strcmp(argv[1], "-vv") == 0) {
+		arg++;
+		verbose = true;
+		verif_log_level = 2;
 		argc--;
 	}
 
-- 
2.30.2


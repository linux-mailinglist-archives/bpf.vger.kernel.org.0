Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED456260EB
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKSND convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Nov 2022 13:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiKKSM6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 13:12:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DD6CA2C
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:12:57 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABHX9O3019437
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:12:57 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ksa44pqp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:12:56 -0800
Received: from twshared18509.43.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 10:12:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A157F218AC82D; Fri, 11 Nov 2022 10:12:45 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix veristat's singular file-or-prog filter
Date:   Fri, 11 Nov 2022 10:12:42 -0800
Message-ID: <20221111181242.2101192-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BRCmyw46tnBnpbaVhwWUadOdFvnoCcQR
X-Proofpoint-GUID: BRCmyw46tnBnpbaVhwWUadOdFvnoCcQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_10,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the bug of filtering out filename too early, before we know the
program name, if using unified file-or-prog filter (i.e., -f
<any-glob>). Because we try to filter BPF object file early without
opening and parsing it, if any_glob (file-or-prog) filter is used we
have to accept any filename just to get program name, which might match
any_glob.

Fixes: 10b1b3f3e56a ("selftests/bpf: consolidate and improve file/prog filtering in veristat")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9e3811ab4866..f961b49b8ef4 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -367,7 +367,13 @@ static bool should_process_file_prog(const char *filename, const char *prog_name
 		if (f->any_glob) {
 			if (glob_matches(filename, f->any_glob))
 				return true;
-			if (prog_name && glob_matches(prog_name, f->any_glob))
+			/* If we don't know program name yet, any_glob filter
+			 * has to assume that current BPF object file might be
+			 * relevant; we'll check again later on after opening
+			 * BPF object file, at which point program name will
+			 * be known finally.
+			 */
+			if (!prog_name || glob_matches(prog_name, f->any_glob))
 				return true;
 		} else {
 			if (f->file_glob && !glob_matches(filename, f->file_glob))
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F64BCB67
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 01:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbiBTApQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 19 Feb 2022 19:45:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiBTApP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 19:45:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A95621D
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 16:44:56 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21K0ZSQm017214
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 16:44:55 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eb0r7j03y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 16:44:55 -0800
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Feb 2022 16:44:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1A1BD119BD964; Sat, 19 Feb 2022 16:44:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
Subject: [PATCH bpf-next] selftests/bpf: use bootstrap bpftool for core_reloc tests
Date:   Sat, 19 Feb 2022 16:44:45 -0800
Message-ID: <20220220004445.2132567-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: o92M54xwccBuLKP3ri4XD3jqqQDhVeM5
X-Proofpoint-GUID: o92M54xwccBuLKP3ri4XD3jqqQDhVeM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-19_04,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1034
 lowpriorityscore=0 mlxlogscore=944 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202200002
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use minimal bootstrap version of bpftool for testing min_core_btf
functionality in core_reloc tests. This avoids unnecessary dependencies
on libbfd, libcap, etc that full bpftool might have in build host
differs from the one in which the test is actually run. This is
currently the case for BPF CI, where build host has libbfd, but stripped
down Linux image inside QEMU doesn't, which causes CI tests to fail.

Cc: Mauricio Vásquez <mauricio@kinvolk.io>
Fixes: 704c91e59fe0 ("selftests/bpf: Test "bpftool gen min_core_btf")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 8fbb40a832d5..a503ca4433cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -843,7 +843,7 @@ static int run_btfgen(const char *src_btf, const char *dst_btf, const char *objp
 	int n;
 
 	n = snprintf(command, sizeof(command),
-		     "./tools/build/bpftool/bpftool gen min_core_btf %s %s %s",
+		     "./tools/build/bpftool/bootstrap/bpftool gen min_core_btf %s %s %s",
 		     src_btf, dst_btf, objpath);
 	if (n < 0 || n >= sizeof(command))
 		return -1;
-- 
2.30.2


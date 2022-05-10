Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09952245F
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 20:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiEJSwO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 10 May 2022 14:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbiEJSwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 14:52:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98350E20
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:52:13 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLirT007221
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:52:13 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fxywsugu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:52:12 -0700
Received: from twshared18213.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 11:52:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 73F0C19BA92A1; Tue, 10 May 2022 11:52:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH bpf-next] libbpf: clean up ringbuf size adjustment implementation
Date:   Tue, 10 May 2022 11:51:59 -0700
Message-ID: <20220510185159.754299-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1LGwyxW7b1RkDcqNNunxVJwvAve82Fse
X-Proofpoint-ORIG-GUID: 1LGwyxW7b1RkDcqNNunxVJwvAve82Fse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_05,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop unused iteration variable, move overflow prevention check into the
for loop.

Fixes: 0087a681fa8c ("libbpf: Automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 15117b9a4d1e..eb4565a89eab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4951,7 +4951,7 @@ static bool is_pow_of_2(size_t x)
 static size_t adjust_ringbuf_sz(size_t sz)
 {
 	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
-	__u32 i, mul;
+	__u32 mul;
 
 	/* if user forgot to set any size, make sure they see error */
 	if (sz == 0)
@@ -4967,9 +4967,7 @@ static size_t adjust_ringbuf_sz(size_t sz)
 	 * user-set size to satisfy both user size request and kernel
 	 * requirements and substitute correct max_entries for map creation.
 	 */
-	for (i = 0, mul = 1; ; i++, mul <<= 1) {
-		if (mul > UINT_MAX / page_sz) /* prevent __u32 overflow */
-			break;
+	for (mul = 1; mul <= UINT_MAX / page_sz; mul <<= 1) {
 		if (mul * page_sz > sz)
 			return mul * page_sz;
 	}
-- 
2.30.2


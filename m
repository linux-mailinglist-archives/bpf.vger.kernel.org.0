Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39DB567A4E
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiGEWuB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 5 Jul 2022 18:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiGEWtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 18:49:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A91EC5E
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 15:48:39 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 265JJTx9022959
        for <bpf@vger.kernel.org>; Tue, 5 Jul 2022 15:48:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h4ubnh77y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 15:48:38 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 15:48:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C202E1BF1EC0B; Tue,  5 Jul 2022 15:48:31 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] libbpf: remove unnecessary usdt_rel_ip assignments
Date:   Tue, 5 Jul 2022 15:48:18 -0700
Message-ID: <20220705224818.4026623-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220705224818.4026623-1-andrii@kernel.org>
References: <20220705224818.4026623-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I5LCKSRh4POpHY7zmSX6xYiZ3F337s7f
X-Proofpoint-ORIG-GUID: I5LCKSRh4POpHY7zmSX6xYiZ3F337s7f
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_18,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Coverity detected that usdt_rel_ip is unconditionally overwritten
anyways, so there is no need to unnecessarily initialize it with unused
value. Clean this up.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 5159207cbfd9..d18e37982344 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -652,11 +652,9 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		 *
 		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
 		 */
-		usdt_rel_ip = usdt_abs_ip = note.loc_addr;
-		if (base_addr) {
+		usdt_abs_ip = note.loc_addr;
+		if (base_addr)
 			usdt_abs_ip += base_addr - note.base_addr;
-			usdt_rel_ip += base_addr - note.base_addr;
-		}
 
 		/* When attaching uprobes (which is what USDTs basically are)
 		 * kernel expects file offset to be specified, not a relative
-- 
2.30.2


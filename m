Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945C5F5812
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJEQPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 5 Oct 2022 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJEQO7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 12:14:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381A1B9F7
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 09:14:58 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295Drr1g011262
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 09:14:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k0xhpvpfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 09:14:58 -0700
Received: from twshared29845.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 09:14:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B61C51FBED499; Wed,  5 Oct 2022 09:14:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: avoid reporting +100% difference in veristat for actual 0%
Date:   Wed, 5 Oct 2022 09:14:49 -0700
Message-ID: <20221005161450.1064469-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005161450.1064469-1-andrii@kernel.org>
References: <20221005161450.1064469-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WuWuOyGMDtoOIOnWxFNO8huFzR5Ie-U-
X-Proofpoint-ORIG-GUID: WuWuOyGMDtoOIOnWxFNO8huFzR5Ie-U-
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

In special case when both base and comparison values are 0, veristat
currently reports "+0 (+100%)" difference, which is quite confusing. Fix
it up to be "+0 (+0%)".

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b0d83a28e348..38f678122a7d 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1104,17 +1104,21 @@ static void output_comp_stats(const struct verif_stats *base, const struct verif
 			else
 				snprintf(diff_buf, sizeof(diff_buf), "%s", "MISMATCH");
 		} else {
+			double p = 0.0;
+
 			snprintf(base_buf, sizeof(base_buf), "%ld", base_val);
 			snprintf(comp_buf, sizeof(comp_buf), "%ld", comp_val);
 
 			diff_val = comp_val - base_val;
 			if (base == &fallback_stats || comp == &fallback_stats || base_val == 0) {
-				snprintf(diff_buf, sizeof(diff_buf), "%+ld (%+.2lf%%)",
-					 diff_val, comp_val < base_val ? -100.0 : 100.0);
+				if (comp_val == base_val)
+					p = 0.0; /* avoid +0 (+100%) case */
+				else
+					p = comp_val < base_val ? -100.0 : 100.0;
 			} else {
-				snprintf(diff_buf, sizeof(diff_buf), "%+ld (%+.2lf%%)",
-					 diff_val, diff_val * 100.0 / base_val);
+				 p = diff_val * 100.0 / base_val;
 			}
+			snprintf(diff_buf, sizeof(diff_buf), "%+ld (%+.2lf%%)", diff_val, p);
 		}
 
 		switch (fmt) {
-- 
2.30.2


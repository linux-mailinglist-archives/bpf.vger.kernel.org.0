Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C956D0E3C
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjC3TB3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 30 Mar 2023 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC3TB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 15:01:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CC3EE
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:01:27 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UFTBT3003930
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:01:27 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmyn5wt4x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:01:27 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Mar 2023 12:01:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 256992C7B7F7A; Thu, 30 Mar 2023 12:01:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] veristat: change guess for __sk_buff from CGROUP_SKB to SCHED_CLS
Date:   Thu, 30 Mar 2023 12:01:15 -0700
Message-ID: <20230330190115.3942962-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -mtYdeAGsGm1_27356A12omYQfl4y5qX
X-Proofpoint-ORIG-GUID: -mtYdeAGsGm1_27356A12omYQfl4y5qX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_12,2023-03-30_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SCHED_CLS seems to be a better option as a default guess for freplace
programs that have __sk_buff as a context type.

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 055df1abd7ca..7888c03ba631 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -798,7 +798,7 @@ static int guess_prog_type_by_ctx_name(const char *ctx_name,
 		enum bpf_attach_type attach_type;
 	} ctx_map[] = {
 		/* __sk_buff is most ambiguous, for now we assume cgroup_skb */
-		{ "__sk_buff", "sk_buff", BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_INGRESS },
+		{ "__sk_buff", "sk_buff", BPF_PROG_TYPE_SCHED_CLS },
 		{ "bpf_sock", "sock", BPF_PROG_TYPE_CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND },
 		{ "bpf_sock_addr", "bpf_sock_addr_kern",  BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND },
 		{ "bpf_sock_ops", "bpf_sock_ops_kern", BPF_PROG_TYPE_SOCK_OPS, BPF_CGROUP_SOCK_OPS },
-- 
2.34.1


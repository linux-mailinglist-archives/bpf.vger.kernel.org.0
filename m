Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3B6D2B45
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 00:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCaWYX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 31 Mar 2023 18:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjCaWYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 18:24:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80620C1B
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:24:19 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VIiYUn022297
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:24:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pnr3fwtth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:24:19 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 31 Mar 2023 15:24:18 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 952E32CA0A30D; Fri, 31 Mar 2023 15:24:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 4/4] veristat: small fixed found in -O2 mode
Date:   Fri, 31 Mar 2023 15:24:05 -0700
Message-ID: <20230331222405.3468634-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331222405.3468634-1-andrii@kernel.org>
References: <20230331222405.3468634-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5uDtyi941fqrA_7wgCuB_G7B07UqJ7We
X-Proofpoint-ORIG-GUID: 5uDtyi941fqrA_7wgCuB_G7B07UqJ7We
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few potentially unitialized variables uses, found while building
veristat.c in release (-O2) mode.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e592d05bccb2..53d7ec168268 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -810,7 +810,7 @@ static int guess_prog_type_by_ctx_name(const char *ctx_name,
 		enum bpf_prog_type prog_type;
 		enum bpf_attach_type attach_type;
 	} ctx_map[] = {
-		/* __sk_buff is most ambiguous, for now we assume cgroup_skb */
+		/* __sk_buff is most ambiguous, we assume TC program */
 		{ "__sk_buff", "sk_buff", BPF_PROG_TYPE_SCHED_CLS },
 		{ "bpf_sock", "sock", BPF_PROG_TYPE_CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND },
 		{ "bpf_sock_addr", "bpf_sock_addr_kern",  BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND },
@@ -1045,6 +1045,7 @@ static int process_obj(const char *filename)
 			goto cleanup;
 		}
 
+		lprog = NULL;
 		bpf_object__for_each_program(tprog, tobj) {
 			const char *tprog_name = bpf_program__name(tprog);
 
@@ -1855,6 +1856,7 @@ static int handle_comparison_mode(void)
 one_more_time:
 	output_comp_headers(cur_fmt);
 
+	last_idx = -1;
 	for (i = 0; i < env.join_stat_cnt; i++) {
 		const struct verif_stats_join *join = &env.join_stats[i];
 
-- 
2.34.1


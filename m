Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3025A71EA
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiH3Xhc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 30 Aug 2022 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiH3XhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 19:37:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B66B15A
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:35:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjH9K020581
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:22:49 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9ynchb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:22:49 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 16:22:48 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id DCEE18ADC688; Tue, 30 Aug 2022 16:19:53 -0700 (PDT)
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next 2/2] selftest/bpf: Ensure no module loading in bpf_setsockopt(TCP_CONGESTION)
Date:   Tue, 30 Aug 2022 16:19:53 -0700
Message-ID: <20220830231953.792412-1-martin.lau@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830231946.791504-1-martin.lau@linux.dev>
References: <20220830231946.791504-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E4tkKqdhBNrxlNIjTDsq6-ovnJQfi5IG
X-Proofpoint-GUID: E4tkKqdhBNrxlNIjTDsq6-ovnJQfi5IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test to ensure
bpf_setsockopt(TCP_CONGESTION, "not_exist")
will not trigger the kernel module autoload.

Before the fix:
[   40.535829] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
...
[   40.552134]  tcp_ca_find_autoload.constprop.0+0xcb/0x200
[   40.552689]  tcp_set_congestion_control+0x99/0x7b0
[   40.553203]  do_tcp_setsockopt+0x3ed/0x2240
...
[   40.556041]  __bpf_setsockopt+0x124/0x640

Signed-off-by: Martin KaFai Lau <martin.lau@linux.dev>
---
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 40606ef47a38..79debf3c2f44 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -32,6 +32,7 @@ struct sockopt_test {
 	unsigned int flip:1;
 };
 
+static const char not_exist_cc[] = "not_exist";
 static const char cubic_cc[] = "cubic";
 static const char reno_cc[] = "reno";
 
@@ -307,6 +308,9 @@ static int bpf_test_tcp_sockopt(__u32 i, struct loop_ctx *lc)
 		const char *new_cc;
 		int new_cc_len;
 
+		if (!bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION,
+				    (void *)not_exist_cc, sizeof(not_exist_cc)))
+			return 1;
 		if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, old_cc, sizeof(old_cc)))
 			return 1;
 		if (!bpf_strncmp(old_cc, sizeof(old_cc), cubic_cc)) {
-- 
2.30.2


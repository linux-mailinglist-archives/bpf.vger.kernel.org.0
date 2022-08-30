Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED05A71EB
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiH3Xhg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 30 Aug 2022 19:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiH3XhQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 19:37:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D375CC5
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:35:54 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjEZU014336
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:22:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9fhvw9b4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:22:44 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 16:22:43 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 93D138ADC662; Tue, 30 Aug 2022 16:19:46 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf: net: Avoid loading module when calling bpf_setsockopt(TCP_CONGESTION)
Date:   Tue, 30 Aug 2022 16:19:46 -0700
Message-ID: <20220830231946.791504-1-martin.lau@linux.dev>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nkJ6J-5297chrXmWT5bhgmKA7pHURm__
X-Proofpoint-ORIG-GUID: nkJ6J-5297chrXmWT5bhgmKA7pHURm__
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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

When bpf prog changes tcp-cc by calling bpf_setsockopt(TCP_CONGESTION),
it should not try to load module which may be a blocking
operation.  This details was correct in the v1 [0] but missed by
mistake in the later revision in
commit cb388e7ee3a8 ("bpf: net: Change do_tcp_setsockopt() to use the sockopt's lock_sock() and capable()")

This patch fixes it by checking the has_current_bpf_ctx().

[0]: https://lore.kernel.org/bpf/20220727060921.2373314-1-kafai@fb.com/

Fixes: cb388e7ee3a8 ("bpf: net: Change do_tcp_setsockopt() to use the sockopt's lock_sock() and capable()")
Signed-off-by: Martin KaFai Lau <martin.lau@linux.dev>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a6986f201f92..f0d79ea45ac8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3503,7 +3503,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		name[val] = 0;
 
 		sockopt_lock_sock(sk);
-		err = tcp_set_congestion_control(sk, name, true,
+		err = tcp_set_congestion_control(sk, name, !has_current_bpf_ctx(),
 						 sockopt_ns_capable(sock_net(sk)->user_ns,
 								    CAP_NET_ADMIN));
 		sockopt_release_sock(sk);
-- 
2.30.2


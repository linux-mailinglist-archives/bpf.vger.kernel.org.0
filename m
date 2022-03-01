Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E64C8344
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 06:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiCAFhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 00:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiCAFho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 00:37:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D074638
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 21:37:04 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21SMwb2j010594
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 21:37:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Xpom6SUyvE63iMeneZRPmXaSRtLBrkFiIEIQNxzxRS0=;
 b=NEQxRy0ZrOsFaKXvhj3m5PvQ3QpFCoCVmpnpgNYCxM3SEmjG4xQL7RKVtAV30+V7Hldu
 q39oN4ZeXQhNF6O88tvmuJ3bhRmfz4KghXsmlJ1+f38eWkFv0yCxgxFlJUzTcdU2GdCk
 xvaJReO1xt0ixfHx/KoWL0JwSg5tMQhnD+w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eh681ahkn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 21:37:04 -0800
Received: from twshared33860.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 21:37:01 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id B19247A89584; Mon, 28 Feb 2022 21:36:56 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH v5 net-next 04/13] net: Clear mono_delivery_time bit in __skb_tstamp_tx()
Date:   Mon, 28 Feb 2022 21:36:56 -0800
Message-ID: <20220301053656.931606-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301053631.930498-1-kafai@fb.com>
References: <20220301053631.930498-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YBnJZ0SrEEYxD_YrRiF2CXuou9fQk7O3
X-Proofpoint-ORIG-GUID: YBnJZ0SrEEYxD_YrRiF2CXuou9fQk7O3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=967
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010026
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In __skb_tstamp_tx(), it may clone the egress skb and queues the clone to
the sk_error_queue.  The outgoing skb may have the mono delivery_time
while the (rcv) timestamp is expected for the clone, so the
skb->mono_delivery_time bit needs to be cleared from the clone.

This patch adds the skb->mono_delivery_time clearing to the existing
__net_timestamp() and use it in __skb_tstamp_tx().
The __net_timestamp() fast path usage in dev.c is changed to directly
call ktime_get_real() since the mono_delivery_time bit is not set at
that point.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/skbuff.h | 1 +
 net/core/dev.c         | 4 ++--
 net/core/skbuff.c      | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7e2d796ece80..8e8a4af4f9e2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3981,6 +3981,7 @@ static inline void skb_get_new_timestampns(const st=
ruct sk_buff *skb,
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp =3D ktime_get_real();
+	skb->mono_delivery_time =3D 0;
 }
=20
 static inline ktime_t net_timedelta(ktime_t t)
diff --git a/net/core/dev.c b/net/core/dev.c
index 6d81b5a7ef3f..3ff686cc8c84 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2084,13 +2084,13 @@ static inline void net_timestamp_set(struct sk_bu=
ff *skb)
 	skb->tstamp =3D 0;
 	skb->mono_delivery_time =3D 0;
 	if (static_branch_unlikely(&netstamp_needed_key))
-		__net_timestamp(skb);
+		skb->tstamp =3D ktime_get_real();
 }
=20
 #define net_timestamp_check(COND, SKB)				\
 	if (static_branch_unlikely(&netstamp_needed_key)) {	\
 		if ((COND) && !(SKB)->tstamp)			\
-			__net_timestamp(SKB);			\
+			(SKB)->tstamp =3D ktime_get_real();	\
 	}							\
=20
 bool is_skb_forwardable(const struct net_device *dev, const struct sk_bu=
ff *skb)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9abb0028309f..e5082836295b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4851,7 +4851,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (hwtstamps)
 		*skb_hwtstamps(skb) =3D *hwtstamps;
 	else
-		skb->tstamp =3D ktime_get_real();
+		__net_timestamp(skb);
=20
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
--=20
2.30.2


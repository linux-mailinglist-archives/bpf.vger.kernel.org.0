Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD954CAF2C
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiCBT5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 14:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiCBT5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 14:57:12 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC2D21D6
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 11:56:24 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMfUW011943
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 11:56:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1xEk1X++uv3kxKRCeq0wSZwgM+EHtEHdbJ1AbZJwfgc=;
 b=rPx+apMSuRfSKP8bBywPYiE2fruF1Mx4cdfXzBN3U8F7qWn/5jRNhlCuffUbPNt4YI3t
 FJEHmtGKiiYQJZMFLLsLBdpHq5m8uyVjBTQzVH1iJ22WJBmrR+wXOizHfggYzJdLHhhV
 ekI+l662c69l6ojR1JdW5z6M3cZMnRsznp4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehyr6r9m5-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 11:56:24 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 11:56:22 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id EB2CF7BD36F6; Wed,  2 Mar 2022 11:56:15 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH v6 net-next 09/13] net: Get rcv tstamp if needed in nfnetlink_{log, queue}.c
Date:   Wed, 2 Mar 2022 11:56:15 -0800
Message-ID: <20220302195615.3483495-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302195519.3479274-1-kafai@fb.com>
References: <20220302195519.3479274-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xCsSp1fFvWR_SfR-x_iECH37-rnH6UT_
X-Proofpoint-ORIG-GUID: xCsSp1fFvWR_SfR-x_iECH37-rnH6UT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020084
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

If skb has the (rcv) timestamp available, nfnetlink_{log, queue}.c
logs/outputs it to the userspace.  When the locally generated skb is
looping from egress to ingress over a virtual interface (e.g. veth,
loopback...),  skb->tstamp may have the delivery time before it is
known that will be delivered locally and received by another sk.  Like
handling the delivery time in network tapping,  use ktime_get_real() to
get the (rcv) timestamp.  The earlier added helper skb_tstamp_cond() is
used to do this.  false is passed to the second 'cond' arg such
that doing ktime_get_real() or not only depends on the
netstamp_needed_key static key.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/netfilter/nfnetlink_log.c   | 6 ++++--
 net/netfilter/nfnetlink_queue.c | 8 +++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.=
c
index ae9c0756bba5..d97eb280cb2e 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -460,6 +460,7 @@ __build_packet_message(struct nfnl_log_net *log,
 	sk_buff_data_t old_tail =3D inst->skb->tail;
 	struct sock *sk;
 	const unsigned char *hwhdrp;
+	ktime_t tstamp;
=20
 	nlh =3D nfnl_msg_put(inst->skb, 0, 0,
 			   nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
@@ -588,9 +589,10 @@ __build_packet_message(struct nfnl_log_net *log,
 			goto nla_put_failure;
 	}
=20
-	if (hooknum <=3D NF_INET_FORWARD && skb->tstamp) {
+	tstamp =3D skb_tstamp_cond(skb, false);
+	if (hooknum <=3D NF_INET_FORWARD && tstamp) {
 		struct nfulnl_msg_packet_timestamp ts;
-		struct timespec64 kts =3D ktime_to_timespec64(skb->tstamp);
+		struct timespec64 kts =3D ktime_to_timespec64(tstamp);
 		ts.sec =3D cpu_to_be64(kts.tv_sec);
 		ts.usec =3D cpu_to_be64(kts.tv_nsec / NSEC_PER_USEC);
=20
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_qu=
eue.c
index 8c15978d9258..db9b5357f2ca 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -392,6 +392,7 @@ nfqnl_build_packet_message(struct net *net, struct nf=
qnl_instance *queue,
 	bool csum_verify;
 	char *secdata =3D NULL;
 	u32 seclen =3D 0;
+	ktime_t tstamp;
=20
 	size =3D nlmsg_total_size(sizeof(struct nfgenmsg))
 		+ nla_total_size(sizeof(struct nfqnl_msg_packet_hdr))
@@ -407,7 +408,8 @@ nfqnl_build_packet_message(struct net *net, struct nf=
qnl_instance *queue,
 		+ nla_total_size(sizeof(u_int32_t))	/* skbinfo */
 		+ nla_total_size(sizeof(u_int32_t));	/* cap_len */
=20
-	if (entskb->tstamp)
+	tstamp =3D skb_tstamp_cond(entskb, false);
+	if (tstamp)
 		size +=3D nla_total_size(sizeof(struct nfqnl_msg_packet_timestamp));
=20
 	size +=3D nfqnl_get_bridge_size(entry);
@@ -582,9 +584,9 @@ nfqnl_build_packet_message(struct net *net, struct nf=
qnl_instance *queue,
 	if (nfqnl_put_bridge(entry, skb) < 0)
 		goto nla_put_failure;
=20
-	if (entry->state.hook <=3D NF_INET_FORWARD && entskb->tstamp) {
+	if (entry->state.hook <=3D NF_INET_FORWARD && tstamp) {
 		struct nfqnl_msg_packet_timestamp ts;
-		struct timespec64 kts =3D ktime_to_timespec64(entskb->tstamp);
+		struct timespec64 kts =3D ktime_to_timespec64(tstamp);
=20
 		ts.sec =3D cpu_to_be64(kts.tv_sec);
 		ts.usec =3D cpu_to_be64(kts.tv_nsec / NSEC_PER_USEC);
--=20
2.30.2


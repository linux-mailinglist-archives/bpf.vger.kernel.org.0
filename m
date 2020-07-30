Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527F9233A22
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 22:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgG3U5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 16:57:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6542 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbgG3U5K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 16:57:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06UKslWB031868
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 13:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uRxcA3sfO6554mAXLJMnJuQ9YOnJTTZmLVsONknmcHo=;
 b=Pr7cKoiYOVlV6cJzOjTwpmx9ttKHaLqNbakhXI0I4f5X+DrHWi7vG7OpWvIR+J+tVGJ5
 5Opru9L4HrDLbZ8xUEh6Q1QaNxRFqWEj3GPANVmhcbAGqT98EWQRqnTd97BgVz0HS/hm
 8htdcPVIaM685EWPsuHBI1MPjshIxd8mTrM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32jp0uvedj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 13:57:09 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 13:57:08 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 0C1702943DF6; Thu, 30 Jul 2020 13:57:04 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>, <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 1/9] tcp: Use a struct to represent a saved_syn
Date:   Thu, 30 Jul 2020 13:57:04 -0700
Message-ID: <20200730205704.3352619-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200730205657.3351905-1-kafai@fb.com>
References: <20200730205657.3351905-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_15:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=38 malwarescore=0
 mlxlogscore=719 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300147
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The TCP_SAVE_SYN has both the network header and tcp header.
The total length of the saved syn packet is currently stored in
the first 4 bytes (u32) of an array and the actual packet data is
stored after that.

A latter patch will add a bpf helper that allows to get the tcp header
alone from the saved syn without the network header.  It will be more
convenient to have a direct offset to a specific header instead of
re-parsing it.  This requires to separately store the network hdrlen.
The total header length (i.e. network + tcp) is still needed for the
current usage in getsockopt.  Although this total length can be obtained
by looking into the tcphdr and then get the (th->doff << 2), this patch
chooses to directly store the tcp hdrlen in the second four bytes of
this newly created "struct saved_syn".  By using a new struct, it can
give a readable name to each individual header length.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/tcp.h        |  7 ++++++-
 include/net/request_sock.h |  8 +++++++-
 net/core/filter.c          |  4 ++--
 net/ipv4/tcp.c             |  9 +++++----
 net/ipv4/tcp_input.c       | 15 ++++++++-------
 5 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 527d668a5275..5528912dc468 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -406,7 +406,7 @@ struct tcp_sock {
 	 * socket. Used to retransmit SYNACKs etc.
 	 */
 	struct request_sock __rcu *fastopen_rsk;
-	u32	*saved_syn;
+	struct saved_syn *saved_syn;
 };
=20
 enum tsq_enum {
@@ -484,6 +484,11 @@ static inline void tcp_saved_syn_free(struct tcp_soc=
k *tp)
 	tp->saved_syn =3D NULL;
 }
=20
+static inline u32 tcp_saved_syn_len(const struct saved_syn *saved_syn)
+{
+	return saved_syn->network_hdrlen + saved_syn->tcp_hdrlen;
+}
+
 struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk);
=20
 static inline u16 tcp_mss_clamp(const struct tcp_sock *tp, u16 mss)
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index cf8b33213bbc..b1b101814ecb 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -41,6 +41,12 @@ struct request_sock_ops {
=20
 int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req=
);
=20
+struct saved_syn {
+	u32 network_hdrlen;
+	u32 tcp_hdrlen;
+	u8 data[];
+};
+
 /* struct request_sock - mini sock to represent a connection request
  */
 struct request_sock {
@@ -60,7 +66,7 @@ struct request_sock {
 	struct timer_list		rsk_timer;
 	const struct request_sock_ops	*rsk_ops;
 	struct sock			*sk;
-	u32				*saved_syn;
+	struct saved_syn		*saved_syn;
 	u32				secid;
 	u32				peer_secid;
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 7124f0fe6974..250b5552a148 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4550,9 +4550,9 @@ static int _bpf_getsockopt(struct sock *sk, int lev=
el, int optname,
 			tp =3D tcp_sk(sk);
=20
 			if (optlen <=3D 0 || !tp->saved_syn ||
-			    optlen > tp->saved_syn[0])
+			    optlen > tcp_saved_syn_len(tp->saved_syn))
 				goto err_clear;
-			memcpy(optval, tp->saved_syn + 1, optlen);
+			memcpy(optval, tp->saved_syn->data, optlen);
 			break;
 		default:
 			goto err_clear;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 27de9380ed14..8a774b5094e9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3791,20 +3791,21 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
=20
 		lock_sock(sk);
 		if (tp->saved_syn) {
-			if (len < tp->saved_syn[0]) {
-				if (put_user(tp->saved_syn[0], optlen)) {
+			if (len < tcp_saved_syn_len(tp->saved_syn)) {
+				if (put_user(tcp_saved_syn_len(tp->saved_syn),
+					     optlen)) {
 					release_sock(sk);
 					return -EFAULT;
 				}
 				release_sock(sk);
 				return -EINVAL;
 			}
-			len =3D tp->saved_syn[0];
+			len =3D tcp_saved_syn_len(tp->saved_syn);
 			if (put_user(len, optlen)) {
 				release_sock(sk);
 				return -EFAULT;
 			}
-			if (copy_to_user(optval, tp->saved_syn + 1, len)) {
+			if (copy_to_user(optval, tp->saved_syn->data, len)) {
 				release_sock(sk);
 				return -EFAULT;
 			}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a018bafd7bdf..6c38ca9de17e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6598,13 +6598,14 @@ static void tcp_reqsk_record_syn(const struct soc=
k *sk,
 {
 	if (tcp_sk(sk)->save_syn) {
 		u32 len =3D skb_network_header_len(skb) + tcp_hdrlen(skb);
-		u32 *copy;
-
-		copy =3D kmalloc(len + sizeof(u32), GFP_ATOMIC);
-		if (copy) {
-			copy[0] =3D len;
-			memcpy(&copy[1], skb_network_header(skb), len);
-			req->saved_syn =3D copy;
+		struct saved_syn *saved_syn;
+
+		saved_syn =3D kmalloc(len + sizeof(*saved_syn), GFP_ATOMIC);
+		if (saved_syn) {
+			saved_syn->network_hdrlen =3D skb_network_header_len(skb);
+			saved_syn->tcp_hdrlen =3D tcp_hdrlen(skb);
+			memcpy(saved_syn->data, skb_network_header(skb), len);
+			req->saved_syn =3D saved_syn;
 		}
 	}
 }
--=20
2.24.1


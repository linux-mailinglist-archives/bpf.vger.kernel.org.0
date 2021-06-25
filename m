Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2EE3B49A1
	for <lists+bpf@lfdr.de>; Fri, 25 Jun 2021 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFYUHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Jun 2021 16:07:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32737 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229831AbhFYUHn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Jun 2021 16:07:43 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15PK4JUw001642
        for <bpf@vger.kernel.org>; Fri, 25 Jun 2021 13:05:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PjRtIq2lwdfr6jQlWN1rqSauL6MjzsyAin4/GjXSODc=;
 b=Y/cbgm+PuI6bazl2LirxCThGjCivmXkDD2S28mKjnuGZKEdcUDTVrhfW8BnN3fJzuaez
 kRULIjFs1VZ5YDrx4seXwHgEify4KdBzzaExf9sVhZKzZMy7u9AnDkXtB0BXNVf7yIfZ
 FIriBe3gkgJnLODaxS+oPnsPBJA/Fmzla8U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 39d253xpg0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 25 Jun 2021 13:05:22 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 13:05:20 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 8148329422B0; Fri, 25 Jun 2021 13:05:17 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Neal Cardwell <ncardwell@google.com>, <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Yuchung Cheng <ycheng@google.com>
Subject: [PATCH bpf-next 5/8] tcp: seq_file: Replace listening_hash with lhash2
Date:   Fri, 25 Jun 2021 13:05:17 -0700
Message-ID: <20210625200517.726679-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210625200446.723230-1-kafai@fb.com>
References: <20210625200446.723230-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: imOfE8zRovk09QtfylRctdKvQ5QBEiKO
X-Proofpoint-GUID: imOfE8zRovk09QtfylRctdKvQ5QBEiKO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_07:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=706 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch moves the tcp seq_file iteration on listeners
from the port only listening_hash to the port+addr lhash2.

When iterating from the bpf iter, the next patch will need to
lock the socket such that the bpf iter with netadmin cap can do
setsockopt (e.g. to change the TCP_CONGESTION).  To avoid locking the
bucket and then locking the sock, the bpf iter will first batch some
sockets from the same bucket and then unlock the bucket.  If the bucket
size is small (which usually is), it is easier to batch the whole
bucket such that it is less likely to miss a setsockopt on a socket
due to changes in the bucket.

However, the port only listening_hash could have many listeners
hashed to a bucket (e.g. many individual VIP(s):443 and also
multiple by the number of SO_REUSEPORT).  We have seen bucket size in
tens of thousands range.  Also, the chance of having changes
in some popular port buckets (e.g. 443) is also high.

The port+addr lhash2 was introduced to solve this large listener bucket
issue.  Also, the listening_hash usage has already been replaced with
lhash2 in the fast path inet[6]_lookup_listener().  This patch follows
the same direction on moving to lhash2 and iterates the lhash2
instead of listening_hash.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/inet_hashtables.h |  6 ++++++
 net/ipv4/tcp_ipv4.c           | 35 ++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
index ca6a3ea9057e..f72ec113ae56 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -160,6 +160,12 @@ struct inet_hashinfo {
 					____cacheline_aligned_in_smp;
 };
=20
+#define inet_lhash2_for_each_icsk_continue(__icsk) \
+	hlist_for_each_entry_continue(__icsk, icsk_listen_portaddr_node)
+
+#define inet_lhash2_for_each_icsk(__icsk, list) \
+	hlist_for_each_entry(__icsk, list, icsk_listen_portaddr_node)
+
 #define inet_lhash2_for_each_icsk_rcu(__icsk, list) \
 	hlist_for_each_entry_rcu(__icsk, list, icsk_listen_portaddr_node)
=20
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 693bda155876..0d851289a89e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2296,21 +2296,22 @@ static void *listening_get_first(struct seq_file =
*seq)
 	struct tcp_iter_state *st =3D seq->private;
=20
 	st->offset =3D 0;
-	for (; st->bucket < INET_LHTABLE_SIZE; st->bucket++) {
-		struct inet_listen_hashbucket *ilb;
-		struct hlist_nulls_node *node;
+	for (; st->bucket <=3D tcp_hashinfo.lhash2_mask; st->bucket++) {
+		struct inet_listen_hashbucket *ilb2;
+		struct inet_connection_sock *icsk;
 		struct sock *sk;
=20
-		ilb =3D &tcp_hashinfo.listening_hash[st->bucket];
-		if (hlist_nulls_empty(&ilb->nulls_head))
+		ilb2 =3D &tcp_hashinfo.lhash2[st->bucket];
+		if (hlist_empty(&ilb2->head))
 			continue;
=20
-		spin_lock(&ilb->lock);
-		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
+		spin_lock(&ilb2->lock);
+		inet_lhash2_for_each_icsk(icsk, &ilb2->head) {
+			sk =3D (struct sock *)icsk;
 			if (seq_sk_match(seq, sk))
 				return sk;
 		}
-		spin_unlock(&ilb->lock);
+		spin_unlock(&ilb2->lock);
 	}
=20
 	return NULL;
@@ -2324,22 +2325,22 @@ static void *listening_get_first(struct seq_file =
*seq)
 static void *listening_get_next(struct seq_file *seq, void *cur)
 {
 	struct tcp_iter_state *st =3D seq->private;
-	struct inet_listen_hashbucket *ilb;
-	struct hlist_nulls_node *node;
+	struct inet_listen_hashbucket *ilb2;
+	struct inet_connection_sock *icsk;
 	struct sock *sk =3D cur;
=20
 	++st->num;
 	++st->offset;
=20
-	sk =3D sk_nulls_next(sk);
-
-	sk_nulls_for_each_from(sk, node) {
+	icsk =3D inet_csk(sk);
+	inet_lhash2_for_each_icsk_continue(icsk) {
+		sk =3D (struct sock *)icsk;
 		if (seq_sk_match(seq, sk))
 			return sk;
 	}
=20
-	ilb =3D &tcp_hashinfo.listening_hash[st->bucket];
-	spin_unlock(&ilb->lock);
+	ilb2 =3D &tcp_hashinfo.lhash2[st->bucket];
+	spin_unlock(&ilb2->lock);
 	++st->bucket;
 	return listening_get_first(seq);
 }
@@ -2456,7 +2457,7 @@ static void *tcp_seek_last_pos(struct seq_file *seq=
)
=20
 	switch (st->state) {
 	case TCP_SEQ_STATE_LISTENING:
-		if (st->bucket >=3D INET_LHTABLE_SIZE)
+		if (st->bucket > tcp_hashinfo.lhash2_mask)
 			break;
 		st->state =3D TCP_SEQ_STATE_LISTENING;
 		rc =3D listening_get_first(seq);
@@ -2541,7 +2542,7 @@ void tcp_seq_stop(struct seq_file *seq, void *v)
 	switch (st->state) {
 	case TCP_SEQ_STATE_LISTENING:
 		if (v !=3D SEQ_START_TOKEN)
-			spin_unlock(&tcp_hashinfo.listening_hash[st->bucket].lock);
+			spin_unlock(&tcp_hashinfo.lhash2[st->bucket].lock);
 		break;
 	case TCP_SEQ_STATE_ESTABLISHED:
 		if (v)
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113562028EA
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgFUFzE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbgFUFzD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5onED003671
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9tkT5IZd256zAt286gxF0Go74BEIw2yWSn/HUxO5LY0=;
 b=gV68WcDu0wdT3xQbveB2nxK7pZkDM1xc1B3N8xnhdKVoPVgDSQ/i0+kkJN0dV77gkKlN
 zslSGlKt/RExgS8jwzb9gX2qstcbclFjnoNyt4ozB2kotZ7ScARFsJAyzWTF/QFRmz9B
 o/i9DgXrSxtHhJ772x8nkrjRzLe2hMF968Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31segatsu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:02 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:01 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3AFC337054A1; Sat, 20 Jun 2020 22:55:00 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 01/15] bpf: add bpf_seq_afinfo in tcp_iter_state
Date:   Sat, 20 Jun 2020 22:55:00 -0700
Message-ID: <20200621055500.2629177-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=676 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=13 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new field bpf_seq_afinfo is added to tcp_iter_state
to provide bpf tcp iterator afinfo. There are two
reasons on why we did this.

First, the current way to get afinfo from PDE_DATA
does not work for bpf iterator as its seq_file
inode does not conform to /proc/net/{tcp,tcp6}
inode structures. More specifically, anonymous
bpf iterator will use an anonymous inode which
is shared in the system and we cannot change inode
private data structure at all.

Second, bpf iterator for tcp/tcp6 wants to
traverse all tcp and tcp6 sockets in one pass
and bpf program can control whether they want
to skip one sk_family or not. Having a different
afinfo with family AF_UNSPEC make it easier
to understand in the code.

This patch does not change /proc/net/{tcp,tcp6} behavior
as the bpf_seq_afinfo will be NULL for these two proc files.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/net/tcp.h   |  1 +
 net/ipv4/tcp_ipv4.c | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4de9485f73d9..eab1c7d0facb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1935,6 +1935,7 @@ struct tcp_iter_state {
 	struct seq_net_private	p;
 	enum tcp_seq_states	state;
 	struct sock		*syn_wait_sk;
+	struct tcp_seq_afinfo	*bpf_seq_afinfo;
 	int			bucket, offset, sbucket, num;
 	loff_t			last_pos;
 };
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ad6435ba6d72..9cb65ee4ec63 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2211,13 +2211,18 @@ EXPORT_SYMBOL(tcp_v4_destroy_sock);
  */
 static void *listening_get_next(struct seq_file *seq, void *cur)
 {
-	struct tcp_seq_afinfo *afinfo =3D PDE_DATA(file_inode(seq->file));
+	struct tcp_seq_afinfo *afinfo;
 	struct tcp_iter_state *st =3D seq->private;
 	struct net *net =3D seq_file_net(seq);
 	struct inet_listen_hashbucket *ilb;
 	struct hlist_nulls_node *node;
 	struct sock *sk =3D cur;
=20
+	if (st->bpf_seq_afinfo)
+		afinfo =3D st->bpf_seq_afinfo;
+	else
+		afinfo =3D PDE_DATA(file_inode(seq->file));
+
 	if (!sk) {
 get_head:
 		ilb =3D &tcp_hashinfo.listening_hash[st->bucket];
@@ -2235,7 +2240,8 @@ static void *listening_get_next(struct seq_file *se=
q, void *cur)
 	sk_nulls_for_each_from(sk, node) {
 		if (!net_eq(sock_net(sk), net))
 			continue;
-		if (sk->sk_family =3D=3D afinfo->family)
+		if (afinfo->family =3D=3D AF_UNSPEC ||
+		    sk->sk_family =3D=3D afinfo->family)
 			return sk;
 	}
 	spin_unlock(&ilb->lock);
@@ -2272,11 +2278,16 @@ static inline bool empty_bucket(const struct tcp_=
iter_state *st)
  */
 static void *established_get_first(struct seq_file *seq)
 {
-	struct tcp_seq_afinfo *afinfo =3D PDE_DATA(file_inode(seq->file));
+	struct tcp_seq_afinfo *afinfo;
 	struct tcp_iter_state *st =3D seq->private;
 	struct net *net =3D seq_file_net(seq);
 	void *rc =3D NULL;
=20
+	if (st->bpf_seq_afinfo)
+		afinfo =3D st->bpf_seq_afinfo;
+	else
+		afinfo =3D PDE_DATA(file_inode(seq->file));
+
 	st->offset =3D 0;
 	for (; st->bucket <=3D tcp_hashinfo.ehash_mask; ++st->bucket) {
 		struct sock *sk;
@@ -2289,7 +2300,8 @@ static void *established_get_first(struct seq_file =
*seq)
=20
 		spin_lock_bh(lock);
 		sk_nulls_for_each(sk, node, &tcp_hashinfo.ehash[st->bucket].chain) {
-			if (sk->sk_family !=3D afinfo->family ||
+			if ((afinfo->family !=3D AF_UNSPEC &&
+			     sk->sk_family !=3D afinfo->family) ||
 			    !net_eq(sock_net(sk), net)) {
 				continue;
 			}
@@ -2304,19 +2316,25 @@ static void *established_get_first(struct seq_fil=
e *seq)
=20
 static void *established_get_next(struct seq_file *seq, void *cur)
 {
-	struct tcp_seq_afinfo *afinfo =3D PDE_DATA(file_inode(seq->file));
+	struct tcp_seq_afinfo *afinfo;
 	struct sock *sk =3D cur;
 	struct hlist_nulls_node *node;
 	struct tcp_iter_state *st =3D seq->private;
 	struct net *net =3D seq_file_net(seq);
=20
+	if (st->bpf_seq_afinfo)
+		afinfo =3D st->bpf_seq_afinfo;
+	else
+		afinfo =3D PDE_DATA(file_inode(seq->file));
+
 	++st->num;
 	++st->offset;
=20
 	sk =3D sk_nulls_next(sk);
=20
 	sk_nulls_for_each_from(sk, node) {
-		if (sk->sk_family =3D=3D afinfo->family &&
+		if ((afinfo->family =3D=3D AF_UNSPEC ||
+		     sk->sk_family =3D=3D afinfo->family) &&
 		    net_eq(sock_net(sk), net))
 			return sk;
 	}
--=20
2.24.1


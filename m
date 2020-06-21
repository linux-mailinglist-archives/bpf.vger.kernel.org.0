Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742362028F0
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgFUFzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6356 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729312AbgFUFzN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5mZj4031154
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BFb/AGI4CUufTSdKR+g2tOOd/whWg5Ac05UTOz9gqp8=;
 b=jcekyS/1AD61npxGil1cbSOWe6Utznfd+3utn9t+CF7KzWz8iQrdVregtRq9opT1S7hS
 ZaN4qP1VtFOkRSn/aQiCwReHL6SiK/jrqR9+FiZWaL/hgjINNO+W7G08CbjEupv6P57h
 Ohn8fqPqTNlTfmNKCVBsALVFEs2V1x9o0ME= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sg9fagfr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:11 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:11 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5B67137052DE; Sat, 20 Jun 2020 22:55:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 07/15] bpf: add bpf_seq_afinfo in udp_iter_state
Date:   Sat, 20 Jun 2020 22:55:07 -0700
Message-ID: <20200621055507.2629951-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 suspectscore=13 mlxlogscore=523 mlxscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to tcp_iter_state, a new field bpf_seq_afinfo is
added to udp_iter_state to provide bpf udp iterator
afinfo.

This does not change /proc/net/{udp, udp6} behavior. But
it enables bpf iterator to avoid get afinfo from PDE_DATA
and iterate through all udp and udp6 sockets in one pass.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/net/udp.h |  1 +
 net/ipv4/udp.c    | 28 +++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index a8fa6c0c6ded..67c8b7368845 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -440,6 +440,7 @@ struct udp_seq_afinfo {
 struct udp_iter_state {
 	struct seq_net_private  p;
 	int			bucket;
+	struct udp_seq_afinfo	*bpf_seq_afinfo;
 };
=20
 void *udp_seq_start(struct seq_file *seq, loff_t *pos);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1b7ebbcae497..90355301b266 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2826,10 +2826,15 @@ EXPORT_SYMBOL(udp_prot);
 static struct sock *udp_get_first(struct seq_file *seq, int start)
 {
 	struct sock *sk;
-	struct udp_seq_afinfo *afinfo =3D PDE_DATA(file_inode(seq->file));
+	struct udp_seq_afinfo *afinfo;
 	struct udp_iter_state *state =3D seq->private;
 	struct net *net =3D seq_file_net(seq);
=20
+	if (state->bpf_seq_afinfo)
+		afinfo =3D state->bpf_seq_afinfo;
+	else
+		afinfo =3D PDE_DATA(file_inode(seq->file));
+
 	for (state->bucket =3D start; state->bucket <=3D afinfo->udp_table->mas=
k;
 	     ++state->bucket) {
 		struct udp_hslot *hslot =3D &afinfo->udp_table->hash[state->bucket];
@@ -2841,7 +2846,8 @@ static struct sock *udp_get_first(struct seq_file *=
seq, int start)
 		sk_for_each(sk, &hslot->head) {
 			if (!net_eq(sock_net(sk), net))
 				continue;
-			if (sk->sk_family =3D=3D afinfo->family)
+			if (afinfo->family =3D=3D AF_UNSPEC ||
+			    sk->sk_family =3D=3D afinfo->family)
 				goto found;
 		}
 		spin_unlock_bh(&hslot->lock);
@@ -2853,13 +2859,20 @@ static struct sock *udp_get_first(struct seq_file=
 *seq, int start)
=20
 static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 {
-	struct udp_seq_afinfo *afinfo =3D PDE_DATA(file_inode(seq->file));
+	struct udp_seq_afinfo *afinfo;
 	struct udp_iter_state *state =3D seq->private;
 	struct net *net =3D seq_file_net(seq);
=20
+	if (state->bpf_seq_afinfo)
+		afinfo =3D state->bpf_seq_afinfo;
+	else
+		afinfo =3D PDE_DATA(file_inode(seq->file));
+
 	do {
 		sk =3D sk_next(sk);
-	} while (sk && (!net_eq(sock_net(sk), net) || sk->sk_family !=3D afinfo=
->family));
+	} while (sk && (!net_eq(sock_net(sk), net) ||
+			(afinfo->family !=3D AF_UNSPEC &&
+			 sk->sk_family !=3D afinfo->family)));
=20
 	if (!sk) {
 		if (state->bucket <=3D afinfo->udp_table->mask)
@@ -2904,9 +2917,14 @@ EXPORT_SYMBOL(udp_seq_next);
=20
 void udp_seq_stop(struct seq_file *seq, void *v)
 {
-	struct udp_seq_afinfo *afinfo =3D PDE_DATA(file_inode(seq->file));
+	struct udp_seq_afinfo *afinfo;
 	struct udp_iter_state *state =3D seq->private;
=20
+	if (state->bpf_seq_afinfo)
+		afinfo =3D state->bpf_seq_afinfo;
+	else
+		afinfo =3D PDE_DATA(file_inode(seq->file));
+
 	if (state->bucket <=3D afinfo->udp_table->mask)
 		spin_unlock_bh(&afinfo->udp_table->hash[state->bucket].lock);
 }
--=20
2.24.1


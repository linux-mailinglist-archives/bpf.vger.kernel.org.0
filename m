Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74432CC8F9
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 22:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgLBVci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 16:32:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729462AbgLBVci (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Dec 2020 16:32:38 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B2LTiRP018265
        for <bpf@vger.kernel.org>; Wed, 2 Dec 2020 13:31:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YDUvfLHR9cAJeUA6Iv/OgojwUZrXZKVoVE7c7BJ1+I4=;
 b=TqyV4XD2wV20kmixvcExdZz8BSXda7i7cicIyab3hJiiN5FmLyDHD6QxoePxxB6uSyXC
 mBZgBNw1AQqzbmwG/W81sClPkeqUOAoyZzIPphzAJUnES3r++8CkOINbZckpQNbd3Mxa
 DDM5n+IGO8LN/a4Cc+6cKFi597fWgreqk6M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 355pr6txfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 13:31:57 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 13:31:56 -0800
Received: by devvm3178.ftw3.facebook.com (Postfix, from userid 201728)
        id 27307476377BA; Wed,  2 Dec 2020 13:31:53 -0800 (PST)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 bpf-next 1/2] bpf: Adds support for setting window clamp
Date:   Wed, 2 Dec 2020 13:31:51 -0800
Message-ID: <20201202213152.435886-2-prankgup@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201202213152.435886-1-prankgup@fb.com>
References: <20201202213152.435886-1-prankgup@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_13:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=13 spamscore=0 adultscore=0 clxscore=1015
 mlxlogscore=981 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds a new bpf_setsockopt for TCP sockets, TCP_BPF_WINDOW_CLAMP,
which sets the maximum receiver window size. It will be useful for
limiting receiver window based on RTT.

Signed-off-by: Prankur gupta <prankgup@fb.com>
---
 include/net/tcp.h |  1 +
 net/core/filter.c |  3 +++
 net/ipv4/tcp.c    | 25 ++++++++++++++++---------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4aba0f069b05..347a76f176b4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -406,6 +406,7 @@ void tcp_syn_ack_timeout(const struct request_sock *r=
eq);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int non=
block,
 		int flags, int *addr_len);
 int tcp_set_rcvlowat(struct sock *sk, int val);
+int tcp_set_window_clamp(struct sock *sk, int val);
 void tcp_data_ready(struct sock *sk);
 #ifdef CONFIG_MMU
 int tcp_mmap(struct file *file, struct socket *sock,
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ca5eecebacf..6273883dfeb2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4910,6 +4910,9 @@ static int _bpf_setsockopt(struct sock *sk, int lev=
el, int optname,
 				tp->notsent_lowat =3D val;
 				sk->sk_write_space(sk);
 				break;
+			case TCP_WINDOW_CLAMP:
+				ret =3D tcp_set_window_clamp(sk, val);
+				break;
 			default:
 				ret =3D -EINVAL;
 			}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b2bc3d7fe9e8..17379f6dd955 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3022,6 +3022,21 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_sock_set_keepcnt);
=20
+int tcp_set_window_clamp(struct sock *sk, int val)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	if (!val) {
+		if (sk->sk_state !=3D TCP_CLOSE)
+			return -EINVAL;
+		tp->window_clamp =3D 0;
+	} else {
+		tp->window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
+			SOCK_MIN_RCVBUF / 2 : val;
+	}
+	return 0;
+}
+
 /*
  *	Socket option code for TCP.
  */
@@ -3235,15 +3250,7 @@ static int do_tcp_setsockopt(struct sock *sk, int =
level, int optname,
 		break;
=20
 	case TCP_WINDOW_CLAMP:
-		if (!val) {
-			if (sk->sk_state !=3D TCP_CLOSE) {
-				err =3D -EINVAL;
-				break;
-			}
-			tp->window_clamp =3D 0;
-		} else
-			tp->window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
-						SOCK_MIN_RCVBUF / 2 : val;
+		err =3D tcp_set_window_clamp(sk, val);
 		break;
=20
 	case TCP_QUICKACK:
--=20
2.24.1


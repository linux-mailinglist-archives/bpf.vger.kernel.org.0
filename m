Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDD5A03F7
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiHXW3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHXW3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:29:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81707F081
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:08 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHB88016033
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=05vpDrfcU8csmA37MNi4Z9madzcPIsVkrSu2HrsRRvw=;
 b=ETKrQQ5lKmW3I8ZwXKpXOTwpEvJGo+g+cFsMAao4XniJdcHjgfj6hjNwg0iPTA2kmZUn
 TZDpH3hKUk/jVGCJoKDNm0cZF4iPKoenuxld7wndSQ7uz99rrhOIqLL8UeqpdU7TtjdW
 HZXGO7cfqiDh8+oRbYPIM7TzpSUryLH++2I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5ab0q1dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:07 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:29:07 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 34C9D871C92A; Wed, 24 Aug 2022 15:26:27 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next 04/17] bpf: net: Change do_tcp_getsockopt() to take the sockptr_t argument
Date:   Wed, 24 Aug 2022 15:26:27 -0700
Message-ID: <20220824222627.1919265-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F5fo5O6q1lHdlCgyYWLxOZwGbF9IaaTV
X-Proofpoint-GUID: F5fo5O6q1lHdlCgyYWLxOZwGbF9IaaTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_13,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to the earlier patch that changes sk_getsockopt() to
take the sockptr_t argument .  This patch also changes
do_tcp_getsockopt() to take the sockptr_t argument such that
a latter patch can make bpf_getsockopt(SOL_TCP) to reuse
do_tcp_getsockopt().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv4/tcp.c | 72 ++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a6986f201f92..7cd04f357873 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4044,14 +4044,14 @@ struct sk_buff *tcp_get_timestamping_opt_stats(co=
nst struct sock *sk,
 }
=20
 static int do_tcp_getsockopt(struct sock *sk, int level,
-		int optname, char __user *optval, int __user *optlen)
+			     int optname, sockptr_t optval, sockptr_t optlen)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct net *net =3D sock_net(sk);
 	int val, len;
=20
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
=20
 	len =3D min_t(unsigned int, len, sizeof(int));
@@ -4101,15 +4101,15 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 	case TCP_INFO: {
 		struct tcp_info info;
=20
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
=20
 		tcp_get_info(sk, &info);
=20
 		len =3D min_t(unsigned int, len, sizeof(info));
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &info, len))
+		if (copy_to_sockptr(optval, &info, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -4119,7 +4119,7 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 		size_t sz =3D 0;
 		int attr;
=20
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
=20
 		ca_ops =3D icsk->icsk_ca_ops;
@@ -4127,9 +4127,9 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 			sz =3D ca_ops->get_info(sk, ~0U, &attr, &info);
=20
 		len =3D min_t(unsigned int, len, sz);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &info, len))
+		if (copy_to_sockptr(optval, &info, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -4138,27 +4138,28 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 		break;
=20
 	case TCP_CONGESTION:
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len =3D min_t(unsigned int, len, TCP_CA_NAME_MAX);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, icsk->icsk_ca_ops->name, len))
+		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
 			return -EFAULT;
 		return 0;
=20
 	case TCP_ULP:
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len =3D min_t(unsigned int, len, TCP_ULP_NAME_MAX);
 		if (!icsk->icsk_ulp_ops) {
-			if (put_user(0, optlen))
+			len =3D 0;
+			if (copy_to_sockptr(optlen, &len, sizeof(int)))
 				return -EFAULT;
 			return 0;
 		}
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, icsk->icsk_ulp_ops->name, len))
+		if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
 			return -EFAULT;
 		return 0;
=20
@@ -4166,15 +4167,15 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 		u64 key[TCP_FASTOPEN_KEY_BUF_LENGTH / sizeof(u64)];
 		unsigned int key_len;
=20
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
=20
 		key_len =3D tcp_fastopen_get_cipher(net, icsk, key) *
 				TCP_FASTOPEN_KEY_LENGTH;
 		len =3D min_t(unsigned int, len, key_len);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, key, len))
+		if (copy_to_sockptr(optval, key, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -4200,7 +4201,7 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 	case TCP_REPAIR_WINDOW: {
 		struct tcp_repair_window opt;
=20
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
=20
 		if (len !=3D sizeof(opt))
@@ -4215,7 +4216,7 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 		opt.rcv_wnd	=3D tp->rcv_wnd;
 		opt.rcv_wup	=3D tp->rcv_wup;
=20
-		if (copy_to_user(optval, &opt, len))
+		if (copy_to_sockptr(optval, &opt, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -4261,14 +4262,14 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 		val =3D tp->save_syn;
 		break;
 	case TCP_SAVED_SYN: {
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
=20
 		lock_sock(sk);
 		if (tp->saved_syn) {
 			if (len < tcp_saved_syn_len(tp->saved_syn)) {
-				if (put_user(tcp_saved_syn_len(tp->saved_syn),
-					     optlen)) {
+				len =3D tcp_saved_syn_len(tp->saved_syn);
+				if (copy_to_sockptr(optlen, &len, sizeof(int))) {
 					release_sock(sk);
 					return -EFAULT;
 				}
@@ -4276,11 +4277,11 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 				return -EINVAL;
 			}
 			len =3D tcp_saved_syn_len(tp->saved_syn);
-			if (put_user(len, optlen)) {
+			if (copy_to_sockptr(optlen, &len, sizeof(int))) {
 				release_sock(sk);
 				return -EFAULT;
 			}
-			if (copy_to_user(optval, tp->saved_syn->data, len)) {
+			if (copy_to_sockptr(optval, tp->saved_syn->data, len)) {
 				release_sock(sk);
 				return -EFAULT;
 			}
@@ -4289,7 +4290,7 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 		} else {
 			release_sock(sk);
 			len =3D 0;
-			if (put_user(len, optlen))
+			if (copy_to_sockptr(optlen, &len, sizeof(int)))
 				return -EFAULT;
 		}
 		return 0;
@@ -4300,21 +4301,21 @@ static int do_tcp_getsockopt(struct sock *sk, int=
 level,
 		struct tcp_zerocopy_receive zc =3D {};
 		int err;
=20
-		if (get_user(len, optlen))
+		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		if (len < 0 ||
 		    len < offsetofend(struct tcp_zerocopy_receive, length))
 			return -EINVAL;
 		if (unlikely(len > sizeof(zc))) {
-			err =3D check_zeroed_user(optval + sizeof(zc),
-						len - sizeof(zc));
+			err =3D check_zeroed_sockptr(optval, sizeof(zc),
+						   len - sizeof(zc));
 			if (err < 1)
 				return err =3D=3D 0 ? -EINVAL : err;
 			len =3D sizeof(zc);
-			if (put_user(len, optlen))
+			if (copy_to_sockptr(optlen, &len, sizeof(int)))
 				return -EFAULT;
 		}
-		if (copy_from_user(&zc, optval, len))
+		if (copy_from_sockptr(&zc, optval, len))
 			return -EFAULT;
 		if (zc.reserved)
 			return -EINVAL;
@@ -4354,7 +4355,7 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 zerocopy_rcv_inq:
 		zc.inq =3D tcp_inq_hint(sk);
 zerocopy_rcv_out:
-		if (!err && copy_to_user(optval, &zc, len))
+		if (!err && copy_to_sockptr(optval, &zc, len))
 			err =3D -EFAULT;
 		return err;
 	}
@@ -4363,9 +4364,9 @@ static int do_tcp_getsockopt(struct sock *sk, int l=
evel,
 		return -ENOPROTOOPT;
 	}
=20
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	if (copy_to_sockptr(optval, &val, len))
 		return -EFAULT;
 	return 0;
 }
@@ -4390,7 +4391,8 @@ int tcp_getsockopt(struct sock *sk, int level, int =
optname, char __user *optval,
 	if (level !=3D SOL_TCP)
 		return icsk->icsk_af_ops->getsockopt(sk, level, optname,
 						     optval, optlen);
-	return do_tcp_getsockopt(sk, level, optname, optval, optlen);
+	return do_tcp_getsockopt(sk, level, optname, USER_SOCKPTR(optval),
+				 USER_SOCKPTR(optlen));
 }
 EXPORT_SYMBOL(tcp_getsockopt);
=20
--=20
2.30.2


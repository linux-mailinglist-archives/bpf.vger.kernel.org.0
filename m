Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B35A03FA
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiHXW3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiHXW3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:29:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9277EFC3
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:11 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMH7FE015278
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4v+XWTck8JL19Yzneags/8Bg15GJzmexqw/CK/LgpqE=;
 b=HyVQbsDQGvfsZ89Ld2RHMLLBfD6aQ0SgK25EgNJCbK08zC84akili4936yzpbPTH8dRi
 ZRhUpWcqy9z/tFfzw4AkiddGvZrvCu6SSpB7LtdUvIum5vnic/jHxK2uK1b0GVqUs9bd
 +EpfjhYwPguzPw3ACwKYpW660CfawV8rC/I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5u570ps9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:10 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:28:57 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 9665B871C8FD; Wed, 24 Aug 2022 15:26:14 -0700 (PDT)
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
Subject: [PATCH bpf-next 02/17] bpf: net: Change sk_getsockopt() to take the sockptr_t argument
Date:   Wed, 24 Aug 2022 15:26:14 -0700
Message-ID: <20220824222614.1918332-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mZWpBSPhR6qc0Ez9gJ_CfN94dmIZ-aIe
X-Proofpoint-ORIG-GUID: mZWpBSPhR6qc0Ez9gJ_CfN94dmIZ-aIe
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

This patch changes sk_getsockopt() to take the sockptr_t argument
such that it can be used by bpf_getsockopt(SOL_SOCKET) in a
latter patch.

security_socket_getpeersec_stream() is not changed.  It stays
with the __user ptr (optval.user and optlen.user) to avoid changes
to other security hooks.  bpf_getsockopt(SOL_SOCKET) also does not
support SO_PEERSEC.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/filter.h  |  3 +--
 include/linux/sockptr.h |  5 +++++
 net/core/filter.c       |  5 ++---
 net/core/sock.c         | 43 +++++++++++++++++++++++------------------
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..527ae1d64e27 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -900,8 +900,7 @@ int sk_reuseport_attach_filter(struct sock_fprog *fpr=
og, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
 void sk_reuseport_prog_free(struct bpf_prog *prog);
 int sk_detach_filter(struct sock *sk);
-int sk_get_filter(struct sock *sk, struct sock_filter __user *filter,
-		  unsigned int len);
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
=20
 bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index d45902fb4cad..bae5e2369b4f 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -64,6 +64,11 @@ static inline int copy_to_sockptr_offset(sockptr_t dst=
, size_t offset,
 	return 0;
 }
=20
+static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t=
 size)
+{
+	return copy_to_sockptr_offset(dst, 0, src, size);
+}
+
 static inline void *memdup_sockptr(sockptr_t src, size_t len)
 {
 	void *p =3D kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
diff --git a/net/core/filter.c b/net/core/filter.c
index 63e25d8ce501..0f6f86b9e487 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10712,8 +10712,7 @@ int sk_detach_filter(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_detach_filter);
=20
-int sk_get_filter(struct sock *sk, struct sock_filter __user *ubuf,
-		  unsigned int len)
+int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
 	struct sock_fprog_kern *fprog;
 	struct sk_filter *filter;
@@ -10744,7 +10743,7 @@ int sk_get_filter(struct sock *sk, struct sock_fi=
lter __user *ubuf,
 		goto out;
=20
 	ret =3D -EFAULT;
-	if (copy_to_user(ubuf, fprog->filter, bpf_classic_proglen(fprog)))
+	if (copy_to_sockptr(optval, fprog->filter, bpf_classic_proglen(fprog)))
 		goto out;
=20
 	/* Instead of bytes, the API requests to return the number
diff --git a/net/core/sock.c b/net/core/sock.c
index 21bc4bf6b485..7fa30fd4b37f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -712,8 +712,8 @@ static int sock_setbindtodevice(struct sock *sk, sock=
ptr_t optval, int optlen)
 	return ret;
 }
=20
-static int sock_getbindtodevice(struct sock *sk, char __user *optval,
-				int __user *optlen, int len)
+static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
+				sockptr_t optlen, int len)
 {
 	int ret =3D -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -737,12 +737,12 @@ static int sock_getbindtodevice(struct sock *sk, ch=
ar __user *optval,
 	len =3D strlen(devname) + 1;
=20
 	ret =3D -EFAULT;
-	if (copy_to_user(optval, devname, len))
+	if (copy_to_sockptr(optval, devname, len))
 		goto out;
=20
 zero:
 	ret =3D -EFAULT;
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		goto out;
=20
 	ret =3D 0;
@@ -1568,20 +1568,23 @@ static void cred_to_ucred(struct pid *pid, const =
struct cred *cred,
 	}
 }
=20
-static int groups_to_user(gid_t __user *dst, const struct group_info *sr=
c)
+static int groups_to_user(sockptr_t dst, const struct group_info *src)
 {
 	struct user_namespace *user_ns =3D current_user_ns();
 	int i;
=20
-	for (i =3D 0; i < src->ngroups; i++)
-		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
+	for (i =3D 0; i < src->ngroups; i++) {
+		gid_t gid =3D from_kgid_munged(user_ns, src->gid[i]);
+
+		if (copy_to_sockptr_offset(dst, i * sizeof(gid), &gid, sizeof(gid)))
 			return -EFAULT;
+	}
=20
 	return 0;
 }
=20
 static int sk_getsockopt(struct sock *sk, int level, int optname,
-			 char __user *optval, int __user *optlen)
+			 sockptr_t optval, sockptr_t optlen)
 {
 	struct socket *sock =3D sk->sk_socket;
=20
@@ -1600,7 +1603,7 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 	int lv =3D sizeof(int);
 	int len;
=20
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1735,7 +1738,7 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
 		spin_unlock(&sk->sk_peer_lock);
=20
-		if (copy_to_user(optval, &peercred, len))
+		if (copy_to_sockptr(optval, &peercred, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1753,11 +1756,11 @@ static int sk_getsockopt(struct sock *sk, int lev=
el, int optname,
 		if (len < n * sizeof(gid_t)) {
 			len =3D n * sizeof(gid_t);
 			put_cred(cred);
-			return put_user(len, optlen) ? -EFAULT : -ERANGE;
+			return copy_to_sockptr(optlen, &len, sizeof(int)) ? -EFAULT : -ERANGE=
;
 		}
 		len =3D n * sizeof(gid_t);
=20
-		ret =3D groups_to_user((gid_t __user *)optval, cred->group_info);
+		ret =3D groups_to_user(optval, cred->group_info);
 		put_cred(cred);
 		if (ret)
 			return ret;
@@ -1773,7 +1776,7 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_user(optval, address, len))
+		if (copy_to_sockptr(optval, address, len))
 			return -EFAULT;
 		goto lenout;
 	}
@@ -1790,7 +1793,7 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 		break;
=20
 	case SO_PEERSEC:
-		return security_socket_getpeersec_stream(sock, optval, optlen, len);
+		return security_socket_getpeersec_stream(sock, optval.user, optlen.use=
r, len);
=20
 	case SO_MARK:
 		v.val =3D sk->sk_mark;
@@ -1822,7 +1825,7 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 		return sock_getbindtodevice(sk, optval, optlen, len);
=20
 	case SO_GET_FILTER:
-		len =3D sk_get_filter(sk, (struct sock_filter __user *)optval, len);
+		len =3D sk_get_filter(sk, optval, len);
 		if (len < 0)
 			return len;
=20
@@ -1870,7 +1873,7 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 		sk_get_meminfo(sk, meminfo);
=20
 		len =3D min_t(unsigned int, len, sizeof(meminfo));
-		if (copy_to_user(optval, &meminfo, len))
+		if (copy_to_sockptr(optval, &meminfo, len))
 			return -EFAULT;
=20
 		goto lenout;
@@ -1939,10 +1942,10 @@ static int sk_getsockopt(struct sock *sk, int lev=
el, int optname,
=20
 	if (len > lv)
 		len =3D lv;
-	if (copy_to_user(optval, &v, len))
+	if (copy_to_sockptr(optval, &v, len))
 		return -EFAULT;
 lenout:
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		return -EFAULT;
 	return 0;
 }
@@ -1950,7 +1953,9 @@ static int sk_getsockopt(struct sock *sk, int level=
, int optname,
 int sock_getsockopt(struct socket *sock, int level, int optname,
 		    char __user *optval, int __user *optlen)
 {
-	return sk_getsockopt(sock->sk, level, optname, optval, optlen);
+	return sk_getsockopt(sock->sk, level, optname,
+			     USER_SOCKPTR(optval),
+			     USER_SOCKPTR(optlen));
 }
=20
 /*
--=20
2.30.2


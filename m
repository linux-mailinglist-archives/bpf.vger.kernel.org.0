Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA655AA474
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIBAby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiIBAbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:31:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D49DF94
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:31:51 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208ocX028365
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:31:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aP2OBVN+akzVT2AV6a72yF+an8WRLYR7F5XMlfpKNHc=;
 b=C25b1GcHcH5cGzDM6sKg9hNtW78aNCed0KZcdXjWe7GgsBMUfbGf2dkgi5lUZsijmHJl
 Gg6V3UCr56uqxy5Ogrvp/fNqumpC8Hse81TCUGTv7v6vyub6CMYT/r1Gmbu9psoxGQ6T
 4+eFfEZHeoergpPx+Jj13XVt+5oCOGJOiy4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jaf2n0ppb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:31:51 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:31:50 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 4A8E58C47B84; Thu,  1 Sep 2022 17:28:53 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v2 bpf-next 10/17] bpf: net: Change do_ipv6_getsockopt() to take the sockptr_t argument
Date:   Thu, 1 Sep 2022 17:28:53 -0700
Message-ID: <20220902002853.2892532-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UpB2WHeElE8wv2_7IdqcyCrWTiX03YCi
X-Proofpoint-ORIG-GUID: UpB2WHeElE8wv2_7IdqcyCrWTiX03YCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

Similar to the earlier patch that changes sk_getsockopt() to
take the sockptr_t argument .  This patch also changes
do_ipv6_getsockopt() to take the sockptr_t argument such that
a latter patch can make bpf_getsockopt(SOL_IPV6) to reuse
do_ipv6_getsockopt().

Note on the change in ip6_mc_msfget().  This function is to
return an array of sockaddr_storage in optval.  This function
is shared between ipv6_get_msfilter() and compat_ipv6_get_msfilter().
However, the sockaddr_storage is stored at different offset of the
optval because of the difference between group_filter and
compat_group_filter.  Thus, a new 'ss_offset' argument is
added to ip6_mc_msfget().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/mroute6.h  |  4 +--
 include/net/ipv6.h       |  2 +-
 net/ipv6/ip6mr.c         | 10 +++---
 net/ipv6/ipv6_sockglue.c | 69 ++++++++++++++++++++++------------------
 net/ipv6/mcast.c         |  8 ++---
 5 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/include/linux/mroute6.h b/include/linux/mroute6.h
index bc351a85ce9b..8f2b307fb124 100644
--- a/include/linux/mroute6.h
+++ b/include/linux/mroute6.h
@@ -27,7 +27,7 @@ struct sock;
=20
 #ifdef CONFIG_IPV6_MROUTE
 extern int ip6_mroute_setsockopt(struct sock *, int, sockptr_t, unsigned=
 int);
-extern int ip6_mroute_getsockopt(struct sock *, int, char __user *, int =
__user *);
+extern int ip6_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_=
t);
 extern int ip6_mr_input(struct sk_buff *skb);
 extern int ip6mr_ioctl(struct sock *sk, int cmd, void __user *arg);
 extern int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __=
user *arg);
@@ -42,7 +42,7 @@ static inline int ip6_mroute_setsockopt(struct sock *so=
ck, int optname,
=20
 static inline
 int ip6_mroute_getsockopt(struct sock *sock,
-			  int optname, char __user *optval, int __user *optlen)
+			  int optname, sockptr_t optval, sockptr_t optlen)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c110d9032083..a4f24573ed7a 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1209,7 +1209,7 @@ int ip6_mc_source(int add, int omode, struct sock *=
sk,
 int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 		  struct sockaddr_storage *list);
 int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
-		  struct sockaddr_storage __user *p);
+		  sockptr_t optval, size_t ss_offset);
=20
 #ifdef CONFIG_PROC_FS
 int ac6_proc_init(struct net *net);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a9ba41648e36..516e83b52f26 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1827,8 +1827,8 @@ int ip6_mroute_setsockopt(struct sock *sk, int optn=
ame, sockptr_t optval,
  *	Getsock opt support for the multicast routing system.
  */
=20
-int ip6_mroute_getsockopt(struct sock *sk, int optname, char __user *opt=
val,
-			  int __user *optlen)
+int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval=
,
+			  sockptr_t optlen)
 {
 	int olr;
 	int val;
@@ -1859,16 +1859,16 @@ int ip6_mroute_getsockopt(struct sock *sk, int op=
tname, char __user *optval,
 		return -ENOPROTOOPT;
 	}
=20
-	if (get_user(olr, optlen))
+	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
=20
 	olr =3D min_t(int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
=20
-	if (put_user(olr, optlen))
+	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
-	if (copy_to_user(optval, &val, olr))
+	if (copy_to_sockptr(optval, &val, olr))
 		return -EFAULT;
 	return 0;
 }
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4ab284a4adf8..4d9fadef2d3e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1030,7 +1030,7 @@ int ipv6_setsockopt(struct sock *sk, int level, int=
 optname, sockptr_t optval,
 EXPORT_SYMBOL(ipv6_setsockopt);
=20
 static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions=
 *opt,
-				  int optname, char __user *optval, int len)
+				  int optname, sockptr_t optval, int len)
 {
 	struct ipv6_opt_hdr *hdr;
=20
@@ -1058,45 +1058,44 @@ static int ipv6_getsockopt_sticky(struct sock *sk=
, struct ipv6_txoptions *opt,
 		return 0;
=20
 	len =3D min_t(unsigned int, len, ipv6_optlen(hdr));
-	if (copy_to_user(optval, hdr, len))
+	if (copy_to_sockptr(optval, hdr, len))
 		return -EFAULT;
 	return len;
 }
=20
-static int ipv6_get_msfilter(struct sock *sk, void __user *optval,
-		int __user *optlen, int len)
+static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
+			     sockptr_t optlen, int len)
 {
 	const int size0 =3D offsetof(struct group_filter, gf_slist_flex);
-	struct group_filter __user *p =3D optval;
 	struct group_filter gsf;
 	int num;
 	int err;
=20
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gsf, p, size0))
+	if (copy_from_sockptr(&gsf, optval, size0))
 		return -EFAULT;
 	if (gsf.gf_group.ss_family !=3D AF_INET6)
 		return -EADDRNOTAVAIL;
 	num =3D gsf.gf_numsrc;
 	lock_sock(sk);
-	err =3D ip6_mc_msfget(sk, &gsf, p->gf_slist_flex);
+	err =3D ip6_mc_msfget(sk, &gsf, optval, size0);
 	if (!err) {
 		if (num > gsf.gf_numsrc)
 			num =3D gsf.gf_numsrc;
-		if (put_user(GROUP_FILTER_SIZE(num), optlen) ||
-		    copy_to_user(p, &gsf, size0))
+		len =3D GROUP_FILTER_SIZE(num);
+		if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
+		    copy_to_sockptr(optval, &gsf, size0))
 			err =3D -EFAULT;
 	}
 	release_sock(sk);
 	return err;
 }
=20
-static int compat_ipv6_get_msfilter(struct sock *sk, void __user *optval=
,
-		int __user *optlen, int len)
+static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
+				    sockptr_t optlen, int len)
 {
 	const int size0 =3D offsetof(struct compat_group_filter, gf_slist_flex)=
;
-	struct compat_group_filter __user *p =3D optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
 	int err;
@@ -1105,7 +1104,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk=
, void __user *optval,
 	if (len < size0)
 		return -EINVAL;
=20
-	if (copy_from_user(&gf32, p, size0))
+	if (copy_from_sockptr(&gf32, optval, size0))
 		return -EFAULT;
 	gf.gf_interface =3D gf32.gf_interface;
 	gf.gf_fmode =3D gf32.gf_fmode;
@@ -1116,22 +1115,24 @@ static int compat_ipv6_get_msfilter(struct sock *=
sk, void __user *optval,
 		return -EADDRNOTAVAIL;
=20
 	lock_sock(sk);
-	err =3D ip6_mc_msfget(sk, &gf, p->gf_slist_flex);
+	err =3D ip6_mc_msfget(sk, &gf, optval, size0);
 	release_sock(sk);
 	if (err)
 		return err;
 	if (num > gf.gf_numsrc)
 		num =3D gf.gf_numsrc;
 	len =3D GROUP_FILTER_SIZE(num) - (sizeof(gf)-sizeof(gf32));
-	if (put_user(len, optlen) ||
-	    put_user(gf.gf_fmode, &p->gf_fmode) ||
-	    put_user(gf.gf_numsrc, &p->gf_numsrc))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter,=
 gf_fmode),
+				   &gf.gf_fmode, sizeof(gf32.gf_fmode)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter,=
 gf_numsrc),
+				   &gf.gf_numsrc, sizeof(gf32.gf_numsrc)))
 		return -EFAULT;
 	return 0;
 }
=20
 static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, int __user *optlen)
+			      sockptr_t optval, sockptr_t optlen)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
 	int len;
@@ -1140,7 +1141,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 	if (ip6_mroute_opt(optname))
 		return ip6_mroute_getsockopt(sk, optname, optval, optlen);
=20
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	switch (optname) {
 	case IPV6_ADDRFORM:
@@ -1164,10 +1165,15 @@ static int do_ipv6_getsockopt(struct sock *sk, in=
t level, int optname,
 		if (sk->sk_type !=3D SOCK_STREAM)
 			return -ENOPROTOOPT;
=20
-		msg.msg_control_user =3D optval;
+		if (optval.is_kernel) {
+			msg.msg_control_is_user =3D false;
+			msg.msg_control =3D optval.kernel;
+		} else {
+			msg.msg_control_is_user =3D true;
+			msg.msg_control_user =3D optval.user;
+		}
 		msg.msg_controllen =3D len;
 		msg.msg_flags =3D 0;
-		msg.msg_control_is_user =3D true;
=20
 		lock_sock(sk);
 		skb =3D np->pktoptions;
@@ -1210,7 +1216,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 			}
 		}
 		len -=3D msg.msg_controllen;
-		return put_user(len, optlen);
+		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
 	case IPV6_MTU:
 	{
@@ -1270,7 +1276,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 		/* check if ipv6_getsockopt_sticky() returns err code */
 		if (len < 0)
 			return len;
-		return put_user(len, optlen);
+		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
=20
 	case IPV6_RECVHOPOPTS:
@@ -1324,9 +1330,9 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
=20
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &mtuinfo, len))
+		if (copy_to_sockptr(optval, &mtuinfo, len))
 			return -EFAULT;
=20
 		return 0;
@@ -1403,7 +1409,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 		if (len < sizeof(freq))
 			return -EINVAL;
=20
-		if (copy_from_user(&freq, optval, sizeof(freq)))
+		if (copy_from_sockptr(&freq, optval, sizeof(freq)))
 			return -EFAULT;
=20
 		if (freq.flr_action !=3D IPV6_FL_A_GET)
@@ -1418,9 +1424,9 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 		if (val < 0)
 			return val;
=20
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &freq, len))
+		if (copy_to_sockptr(optval, &freq, len))
 			return -EFAULT;
=20
 		return 0;
@@ -1472,9 +1478,9 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 		return -ENOPROTOOPT;
 	}
 	len =3D min_t(unsigned int, sizeof(int), len);
-	if (put_user(len, optlen))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
 		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	if (copy_to_sockptr(optval, &val, len))
 		return -EFAULT;
 	return 0;
 }
@@ -1490,7 +1496,8 @@ int ipv6_getsockopt(struct sock *sk, int level, int=
 optname,
 	if (level !=3D SOL_IPV6)
 		return -ENOPROTOOPT;
=20
-	err =3D do_ipv6_getsockopt(sk, level, optname, optval, optlen);
+	err =3D do_ipv6_getsockopt(sk, level, optname,
+				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_2292PKTOPTIONS) {
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 87c699d57b36..0566ab03ddbe 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -580,7 +580,7 @@ int ip6_mc_msfilter(struct sock *sk, struct group_fil=
ter *gsf,
 }
=20
 int ip6_mc_msfget(struct sock *sk, struct group_filter *gsf,
-		  struct sockaddr_storage __user *p)
+		  sockptr_t optval, size_t ss_offset)
 {
 	struct ipv6_pinfo *inet6 =3D inet6_sk(sk);
 	const struct in6_addr *group;
@@ -612,8 +612,7 @@ int ip6_mc_msfget(struct sock *sk, struct group_filte=
r *gsf,
=20
 	copycount =3D count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
 	gsf->gf_numsrc =3D count;
-
-	for (i =3D 0; i < copycount; i++, p++) {
+	for (i =3D 0; i < copycount; i++) {
 		struct sockaddr_in6 *psin6;
 		struct sockaddr_storage ss;
=20
@@ -621,8 +620,9 @@ int ip6_mc_msfget(struct sock *sk, struct group_filte=
r *gsf,
 		memset(&ss, 0, sizeof(ss));
 		psin6->sin6_family =3D AF_INET6;
 		psin6->sin6_addr =3D psl->sl_addr[i];
-		if (copy_to_user(p, &ss, sizeof(ss)))
+		if (copy_to_sockptr_offset(optval, ss_offset, &ss, sizeof(ss)))
 			return -EFAULT;
+		ss_offset +=3D sizeof(ss);
 	}
 	return 0;
 }
--=20
2.30.2


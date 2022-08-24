Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218275A03F6
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiHXW3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHXW3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:29:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FFE7EFE2
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:59 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27OMHBDH017409
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lM/oeBFsB6ww2iis+HmVcLeZjG1NtPaiJf5uMRBbf8g=;
 b=iAFhbdDkHkMqK2rk7z7yTkBUBAZ+ULmc9ifRrEkXIq+MIJzVy3YHzPFAVx6MhilDkFvK
 9ay5VOx2Mcfv61WO1SonJlO36QNgBnvW59Jtw+0ZMgu5/I2YMSGT6KE+cNn27d+IEKzW
 32I3ODNEq2E/TZnT3UUzXTPG0kRI30S4tBE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j4x1yvj5h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:58 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:28:56 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id E3C95871C94B; Wed, 24 Aug 2022 15:26:39 -0700 (PDT)
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
Subject: [PATCH bpf-next 06/17] bpf: net: Change do_ip_getsockopt() to take the sockptr_t argument
Date:   Wed, 24 Aug 2022 15:26:39 -0700
Message-ID: <20220824222639.1920256-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pAFrJr0OywzJFjKnWrxV6xOtPGIR-6pt
X-Proofpoint-ORIG-GUID: pAFrJr0OywzJFjKnWrxV6xOtPGIR-6pt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_14,2022-08-22_02,2022-06-22_01
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
take the sockptr_t argument.  This patch also changes
do_ip_getsockopt() to take the sockptr_t argument such that
a latter patch can make bpf_getsockopt(SOL_IP) to reuse
do_ip_getsockopt().

Note on the change in ip_mc_gsfget().  This function is to
return an array of sockaddr_storage in optval.  This function
is shared between ip_get_mcast_msfilter() and
compat_ip_get_mcast_msfilter().  However, the sockaddr_storage
is stored at different offset of the optval because of
the difference between group_filter and compat_group_filter.
Thus, a new 'ss_offset' argument is added to ip_mc_gsfget().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/igmp.h   |  4 +--
 include/linux/mroute.h |  6 ++--
 net/ipv4/igmp.c        | 22 +++++++-----
 net/ipv4/ip_sockglue.c | 80 ++++++++++++++++++++++++------------------
 net/ipv4/ipmr.c        |  9 ++---
 5 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 93c262ecbdc9..78890143f079 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -118,9 +118,9 @@ extern int ip_mc_source(int add, int omode, struct so=
ck *sk,
 		struct ip_mreq_source *mreqs, int ifindex);
 extern int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf,int i=
findex);
 extern int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-		struct ip_msfilter __user *optval, int __user *optlen);
+			sockptr_t optval, sockptr_t optlen);
 extern int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-			struct sockaddr_storage __user *p);
+			sockptr_t optval, size_t offset);
 extern int ip_mc_sf_allow(struct sock *sk, __be32 local, __be32 rmt,
 			  int dif, int sdif);
 extern void ip_mc_init_dev(struct in_device *);
diff --git a/include/linux/mroute.h b/include/linux/mroute.h
index 6cbbfe94348c..80b8400ab8b2 100644
--- a/include/linux/mroute.h
+++ b/include/linux/mroute.h
@@ -17,7 +17,7 @@ static inline int ip_mroute_opt(int opt)
 }
=20
 int ip_mroute_setsockopt(struct sock *, int, sockptr_t, unsigned int);
-int ip_mroute_getsockopt(struct sock *, int, char __user *, int __user *=
);
+int ip_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_t);
 int ipmr_ioctl(struct sock *sk, int cmd, void __user *arg);
 int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *ar=
g);
 int ip_mr_init(void);
@@ -29,8 +29,8 @@ static inline int ip_mroute_setsockopt(struct sock *soc=
k, int optname,
 	return -ENOPROTOOPT;
 }
=20
-static inline int ip_mroute_getsockopt(struct sock *sock, int optname,
-				       char __user *optval, int __user *optlen)
+static inline int ip_mroute_getsockopt(struct sock *sk, int optname,
+				       sockptr_t optval, sockptr_t optlen)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index e3ab0cb61624..df0660d818ac 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2529,11 +2529,10 @@ int ip_mc_msfilter(struct sock *sk, struct ip_msf=
ilter *msf, int ifindex)
 		err =3D ip_mc_leave_group(sk, &imr);
 	return err;
 }
-
 int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
-	struct ip_msfilter __user *optval, int __user *optlen)
+		 sockptr_t optval, sockptr_t optlen)
 {
-	int err, len, count, copycount;
+	int err, len, count, copycount, msf_size;
 	struct ip_mreqn	imr;
 	__be32 addr =3D msf->imsf_multiaddr;
 	struct ip_mc_socklist *pmc;
@@ -2575,12 +2574,15 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfil=
ter *msf,
 	copycount =3D count < msf->imsf_numsrc ? count : msf->imsf_numsrc;
 	len =3D flex_array_size(psl, sl_addr, copycount);
 	msf->imsf_numsrc =3D count;
-	if (put_user(IP_MSFILTER_SIZE(copycount), optlen) ||
-	    copy_to_user(optval, msf, IP_MSFILTER_SIZE(0))) {
+	msf_size =3D IP_MSFILTER_SIZE(copycount);
+	if (copy_to_sockptr(optlen, &msf_size, sizeof(int)) ||
+	    copy_to_sockptr(optval, msf, IP_MSFILTER_SIZE(0))) {
 		return -EFAULT;
 	}
 	if (len &&
-	    copy_to_user(&optval->imsf_slist_flex[0], psl->sl_addr, len))
+	    copy_to_sockptr_offset(optval,
+				   offsetof(struct ip_msfilter, imsf_slist_flex),
+				   psl->sl_addr, len))
 		return -EFAULT;
 	return 0;
 done:
@@ -2588,7 +2590,7 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilte=
r *msf,
 }
=20
 int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
-	struct sockaddr_storage __user *p)
+		 sockptr_t optval, size_t ss_offset)
 {
 	int i, count, copycount;
 	struct sockaddr_in *psin;
@@ -2618,15 +2620,17 @@ int ip_mc_gsfget(struct sock *sk, struct group_fi=
lter *gsf,
 	count =3D psl ? psl->sl_count : 0;
 	copycount =3D count < gsf->gf_numsrc ? count : gsf->gf_numsrc;
 	gsf->gf_numsrc =3D count;
-	for (i =3D 0; i < copycount; i++, p++) {
+	for (i =3D 0; i < copycount; i++) {
 		struct sockaddr_storage ss;
=20
 		psin =3D (struct sockaddr_in *)&ss;
 		memset(&ss, 0, sizeof(ss));
 		psin->sin_family =3D AF_INET;
 		psin->sin_addr.s_addr =3D psl->sl_addr[i];
-		if (copy_to_user(p, &ss, sizeof(ss)))
+		if (copy_to_sockptr_offset(optval, ss_offset,
+					   &ss, sizeof(ss)))
 			return -EFAULT;
+		ss_offset +=3D sizeof(ss);
 	}
 	return 0;
 }
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 751fa69cb557..5310def20e0c 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1462,37 +1462,37 @@ static bool getsockopt_needs_rtnl(int optname)
 	return false;
 }
=20
-static int ip_get_mcast_msfilter(struct sock *sk, void __user *optval,
-		int __user *optlen, int len)
+static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
+				 sockptr_t optlen, int len)
 {
 	const int size0 =3D offsetof(struct group_filter, gf_slist_flex);
-	struct group_filter __user *p =3D optval;
 	struct group_filter gsf;
-	int num;
+	int num, gsf_size;
 	int err;
=20
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gsf, p, size0))
+	if (copy_from_sockptr(&gsf, optval, size0))
 		return -EFAULT;
=20
 	num =3D gsf.gf_numsrc;
-	err =3D ip_mc_gsfget(sk, &gsf, p->gf_slist_flex);
+	err =3D ip_mc_gsfget(sk, &gsf, optval,
+			   offsetof(struct group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gsf.gf_numsrc < num)
 		num =3D gsf.gf_numsrc;
-	if (put_user(GROUP_FILTER_SIZE(num), optlen) ||
-	    copy_to_user(p, &gsf, size0))
+	gsf_size =3D GROUP_FILTER_SIZE(num);
+	if (copy_to_sockptr(optlen, &gsf_size, sizeof(int)) ||
+	    copy_to_sockptr(optval, &gsf, size0))
 		return -EFAULT;
 	return 0;
 }
=20
-static int compat_ip_get_mcast_msfilter(struct sock *sk, void __user *op=
tval,
-		int __user *optlen, int len)
+static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optva=
l,
+					sockptr_t optlen, int len)
 {
 	const int size0 =3D offsetof(struct compat_group_filter, gf_slist_flex)=
;
-	struct compat_group_filter __user *p =3D optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
 	int num;
@@ -1500,7 +1500,7 @@ static int compat_ip_get_mcast_msfilter(struct sock=
 *sk, void __user *optval,
=20
 	if (len < size0)
 		return -EINVAL;
-	if (copy_from_user(&gf32, p, size0))
+	if (copy_from_sockptr(&gf32, optval, size0))
 		return -EFAULT;
=20
 	gf.gf_interface =3D gf32.gf_interface;
@@ -1508,21 +1508,24 @@ static int compat_ip_get_mcast_msfilter(struct so=
ck *sk, void __user *optval,
 	num =3D gf.gf_numsrc =3D gf32.gf_numsrc;
 	gf.gf_group =3D gf32.gf_group;
=20
-	err =3D ip_mc_gsfget(sk, &gf, p->gf_slist_flex);
+	err =3D ip_mc_gsfget(sk, &gf, optval,
+			   offsetof(struct compat_group_filter, gf_slist_flex));
 	if (err)
 		return err;
 	if (gf.gf_numsrc < num)
 		num =3D gf.gf_numsrc;
 	len =3D GROUP_FILTER_SIZE(num) - (sizeof(gf) - sizeof(gf32));
-	if (put_user(len, optlen) ||
-	    put_user(gf.gf_fmode, &p->gf_fmode) ||
-	    put_user(gf.gf_numsrc, &p->gf_numsrc))
+	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter,=
 gf_fmode),
+				   &gf.gf_fmode, sizeof(gf.gf_fmode)) ||
+	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter,=
 gf_numsrc),
+				   &gf.gf_numsrc, sizeof(gf.gf_numsrc)))
 		return -EFAULT;
 	return 0;
 }
=20
 static int do_ip_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, int __user *optlen)
+			    sockptr_t optval, sockptr_t optlen)
 {
 	struct inet_sock *inet =3D inet_sk(sk);
 	bool needs_rtnl =3D getsockopt_needs_rtnl(optname);
@@ -1535,7 +1538,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 	if (ip_mroute_opt(optname))
 		return ip_mroute_getsockopt(sk, optname, optval, optlen);
=20
-	if (get_user(len, optlen))
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
@@ -1560,15 +1563,17 @@ static int do_ip_getsockopt(struct sock *sk, int =
level, int optname,
 			       inet_opt->opt.optlen);
 		release_sock(sk);
=20
-		if (opt->optlen =3D=3D 0)
-			return put_user(0, optlen);
+		if (opt->optlen =3D=3D 0) {
+			len =3D 0;
+			return copy_to_sockptr(optlen, &len, sizeof(int));
+		}
=20
 		ip_options_undo(opt);
=20
 		len =3D min_t(unsigned int, len, opt->optlen);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, opt->__data, len))
+		if (copy_to_sockptr(optval, opt->__data, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -1659,9 +1664,9 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 		addr.s_addr =3D inet->mc_addr;
 		release_sock(sk);
=20
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &addr, len))
+		if (copy_to_sockptr(optval, &addr, len))
 			return -EFAULT;
 		return 0;
 	}
@@ -1673,12 +1678,11 @@ static int do_ip_getsockopt(struct sock *sk, int =
level, int optname,
 			err =3D -EINVAL;
 			goto out;
 		}
-		if (copy_from_user(&msf, optval, IP_MSFILTER_SIZE(0))) {
+		if (copy_from_sockptr(&msf, optval, IP_MSFILTER_SIZE(0))) {
 			err =3D -EFAULT;
 			goto out;
 		}
-		err =3D ip_mc_msfget(sk, &msf,
-				   (struct ip_msfilter __user *)optval, optlen);
+		err =3D ip_mc_msfget(sk, &msf, optval, optlen);
 		goto out;
 	}
 	case MCAST_MSFILTER:
@@ -1700,8 +1704,13 @@ static int do_ip_getsockopt(struct sock *sk, int l=
evel, int optname,
 		if (sk->sk_type !=3D SOCK_STREAM)
 			return -ENOPROTOOPT;
=20
-		msg.msg_control_is_user =3D true;
-		msg.msg_control_user =3D optval;
+		if (optval.is_kernel) {
+			msg.msg_control_is_user =3D false;
+			msg.msg_control =3D optval.kernel;
+		} else {
+			msg.msg_control_is_user =3D true;
+			msg.msg_control_user =3D optval.user;
+		}
 		msg.msg_controllen =3D len;
 		msg.msg_flags =3D in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
=20
@@ -1722,7 +1731,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
 		}
 		len -=3D msg.msg_controllen;
-		return put_user(len, optlen);
+		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
 	case IP_FREEBIND:
 		val =3D inet->freebind;
@@ -1742,15 +1751,15 @@ static int do_ip_getsockopt(struct sock *sk, int =
level, int optname,
 	if (len < sizeof(int) && len > 0 && val >=3D 0 && val <=3D 255) {
 		unsigned char ucval =3D (unsigned char)val;
 		len =3D 1;
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &ucval, 1))
+		if (copy_to_sockptr(optval, &ucval, 1))
 			return -EFAULT;
 	} else {
 		len =3D min_t(unsigned int, sizeof(int), len);
-		if (put_user(len, optlen))
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_user(optval, &val, len))
+		if (copy_to_sockptr(optval, &val, len))
 			return -EFAULT;
 	}
 	return 0;
@@ -1767,7 +1776,8 @@ int ip_getsockopt(struct sock *sk, int level,
 {
 	int err;
=20
-	err =3D do_ip_getsockopt(sk, level, optname, optval, optlen);
+	err =3D do_ip_getsockopt(sk, level, optname,
+			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
=20
 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >=3D BPFILTER_IPT_SO_GET_INFO &&
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 73651d17e51f..95eefbe2e142 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1546,7 +1546,8 @@ int ip_mroute_setsockopt(struct sock *sk, int optna=
me, sockptr_t optval,
 }
=20
 /* Getsock opt support for the multicast routing system. */
-int ip_mroute_getsockopt(struct sock *sk, int optname, char __user *optv=
al, int __user *optlen)
+int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
+			 sockptr_t optlen)
 {
 	int olr;
 	int val;
@@ -1577,14 +1578,14 @@ int ip_mroute_getsockopt(struct sock *sk, int opt=
name, char __user *optval, int
 		return -ENOPROTOOPT;
 	}
=20
-	if (get_user(olr, optlen))
+	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
 	olr =3D min_t(unsigned int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
-	if (put_user(olr, optlen))
+	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
-	if (copy_to_user(optval, &val, olr))
+	if (copy_to_sockptr(optval, &val, olr))
 		return -EFAULT;
 	return 0;
 }
--=20
2.30.2


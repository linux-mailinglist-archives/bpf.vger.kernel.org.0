Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC513346A3
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhCJSZD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 13:25:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232734AbhCJSYf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 13:24:35 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AIFSbg014237
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 10:24:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=7UjuIrVYRjfu443Bw8P1YuzVFEAKbf9ouLxCsnI3qm4=;
 b=Hmt3mcoM8llUcpcdlWFPzMhBdTKUTjzMbMK011aQ+w7zHX8F6UeUXQnvVyPCqK6EJE8M
 //1Kz844lK5R/N1LY+KFXMejLav4npq13IGfZ1MFRVtl8WCT8iMWDYpDdgFhfjU2yLF0
 EFbYBHph4HiA97Zq7CuE7X/5yDrVxmZ80os= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 376c07qc11-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 10:24:34 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 10 Mar 2021 10:24:32 -0800
Received: by devvm4456.prn0.facebook.com (Postfix, from userid 6343)
        id ABAAF85B544; Wed, 10 Mar 2021 10:24:18 -0800 (PST)
From:   Manu Bretelle <chantra@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Manu Bretelle <chantra@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        <bpf@vger.kernel.org>
Subject: [PATCH] bpf: Add getter and setter for SO_REUSEPORT through bpf_{g,s}etsockopt
Date:   Wed, 10 Mar 2021 10:23:05 -0800
Message-ID: <20210310182305.1910312-1-chantra@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=872
 mlxscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100088
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Augment the current set of options that are accessible via
bpf_{g,s}etsockopt to also support SO_REUSEPORT.

Signed-off-by: Manu Bretelle <chantra@fb.com>
---
 net/core/filter.c                             |  6 +++++
 .../testing/selftests/bpf/progs/bind4_prog.c  | 27 +++++++++++++++++++
 .../testing/selftests/bpf/progs/bind6_prog.c  | 27 +++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 588b19ba0da8..ac67495af585 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4786,6 +4786,9 @@ static int _bpf_setsockopt(struct sock *sk, int lev=
el, int optname,
 				sk->sk_prot->keepalive(sk, valbool);
 			sock_valbool_flag(sk, SOCK_KEEPOPEN, valbool);
 			break;
+		case SO_REUSEPORT:
+			sk->sk_reuseport =3D valbool;
+			break;
 		default:
 			ret =3D -EINVAL;
 		}
@@ -4955,6 +4958,9 @@ static int _bpf_getsockopt(struct sock *sk, int lev=
el, int optname,
 		case SO_BINDTOIFINDEX:
 			*((int *)optval) =3D sk->sk_bound_dev_if;
 			break;
+		case SO_REUSEPORT:
+			*((int *)optval) =3D sk->sk_reuseport;
+			break;
 		default:
 			goto err_clear;
 		}
diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testi=
ng/selftests/bpf/progs/bind4_prog.c
index 115a3b0ad984..b65a5e2481e6 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -57,6 +57,29 @@ static __inline int bind_to_device(struct bpf_sock_add=
r *ctx)
 	return 0;
 }
=20
+static __inline int bind_reuseport(struct bpf_sock_addr *ctx)
+{
+
+	int val =3D 1;
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)))
+		return 1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)) || !val)
+		return 1;
+	val =3D 0;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)))
+		return 1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)) || val)
+		return 1;
+
+
+	return 0;
+}
+
 static __inline int misc_opts(struct bpf_sock_addr *ctx, int opt)
 {
 	int old, tmp, new =3D 0xeb9f;
@@ -127,6 +150,10 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
 	if (misc_opts(ctx, SO_MARK) || misc_opts(ctx, SO_PRIORITY))
 		return 0;
=20
+	/* Set reuseport and unset */
+	if (bind_reuseport(ctx))
+		return 0;
+
 	ctx->user_ip4 =3D bpf_htonl(SERV4_REWRITE_IP);
 	ctx->user_port =3D bpf_htons(SERV4_REWRITE_PORT);
=20
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testi=
ng/selftests/bpf/progs/bind6_prog.c
index 4c0d348034b9..68e7ede67b6d 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -63,6 +63,29 @@ static __inline int bind_to_device(struct bpf_sock_add=
r *ctx)
 	return 0;
 }
=20
+static __inline int bind_reuseport(struct bpf_sock_addr *ctx)
+{
+
+	int val =3D 1;
+
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)))
+		return 1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)) || !val)
+		return 1;
+	val =3D 0;
+	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)))
+		return 1;
+	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
+			   &val, sizeof(val)) || val)
+		return 1;
+
+
+	return 0;
+}
+
 static __inline int misc_opts(struct bpf_sock_addr *ctx, int opt)
 {
 	int old, tmp, new =3D 0xeb9f;
@@ -141,6 +164,10 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
 	if (misc_opts(ctx, SO_MARK) || misc_opts(ctx, SO_PRIORITY))
 		return 0;
=20
+	/* Set reuseport and unset */
+	if (bind_reuseport(ctx))
+		return 0;
+
 	ctx->user_ip6[0] =3D bpf_htonl(SERV6_REWRITE_IP_0);
 	ctx->user_ip6[1] =3D bpf_htonl(SERV6_REWRITE_IP_1);
 	ctx->user_ip6[2] =3D bpf_htonl(SERV6_REWRITE_IP_2);
--=20
2.24.1


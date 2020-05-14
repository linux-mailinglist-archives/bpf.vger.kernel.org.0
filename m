Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61A1D24F1
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 03:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgENBu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 21:50:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29246 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENBu6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 21:50:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E1ou2o006254
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 18:50:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BE9CifM+cwp0/XhwgISs6naNCTfpmH492M6Zg+HknoY=;
 b=W1oZcHW3rTS+Uve5WNBPBVcEcUvjJfr4oPHUqZwt9uo/uQUxws4i2IsdbtImfNU5LEAb
 KOniejJj9os2tibm0Q2LnFwshvluZJ++PXfaZBK3pCYE/6CMoTwGuJTIAnmudipxibOg
 Vn0UNsU6FT/j5E9qePxzLR4uZr+Q67zudXM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1rmrn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 18:50:58 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 18:50:54 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 9FB053700963; Wed, 13 May 2020 18:50:51 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test narrow loads for bpf_sock_addr.user_port
Date:   Wed, 13 May 2020 18:50:28 -0700
Message-ID: <e5c734a58cca4041ab30cb5471e644246f8cdb5a.1589420814.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589420814.git.rdna@fb.com>
References: <cover.1589420814.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=15 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140015
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test 1,2,4-byte loads from bpf_sock_addr.user_port in sock_addr
programs.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 38 ++++++++++++++------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing=
/selftests/bpf/test_sock_addr.c
index 61fd95b89af8..0358814c67dc 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -677,7 +677,7 @@ static int bind4_prog_load(const struct sock_addr_tes=
t *test)
 		uint8_t u4_addr8[4];
 		uint16_t u4_addr16[2];
 		uint32_t u4_addr32;
-	} ip4;
+	} ip4, port;
 	struct sockaddr_in addr4_rw;
=20
 	if (inet_pton(AF_INET, SERV4_IP, (void *)&ip4) !=3D 1) {
@@ -685,6 +685,8 @@ static int bind4_prog_load(const struct sock_addr_tes=
t *test)
 		return -1;
 	}
=20
+	port.u4_addr32 =3D htons(SERV4_PORT);
+
 	if (mk_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
 			(struct sockaddr *)&addr4_rw, sizeof(addr4_rw)) =3D=3D -1)
 		return -1;
@@ -696,49 +698,65 @@ static int bind4_prog_load(const struct sock_addr_t=
est *test)
 		/* if (sk.family =3D=3D AF_INET && */
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, family)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, AF_INET, 24),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, AF_INET, 32),
=20
 		/*     (sk.type =3D=3D SOCK_DGRAM || sk.type =3D=3D SOCK_STREAM) && */
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, type)),
 		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, SOCK_DGRAM, 1),
 		BPF_JMP_A(1),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, SOCK_STREAM, 20),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, SOCK_STREAM, 28),
=20
 		/*     1st_byte_of_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[0], 18),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[0], 26),
=20
 		/*     2nd_byte_of_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4) + 1),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[1], 16),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[1], 24),
=20
 		/*     3rd_byte_of_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4) + 2),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[2], 14),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[2], 22),
=20
 		/*     4th_byte_of_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4) + 3),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[3], 12),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr8[3], 20),
=20
 		/*     1st_half_of_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr16[0], 10),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr16[0], 18),
=20
 		/*     2nd_half_of_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4) + 2),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr16[1], 8),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, ip4.u4_addr16[1], 16),
=20
-		/*     whole_user_ip4 =3D=3D expected) { */
+		/*     whole_user_ip4 =3D=3D expected && */
 		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
 			    offsetof(struct bpf_sock_addr, user_ip4)),
 		BPF_LD_IMM64(BPF_REG_8, ip4.u4_addr32), /* See [2]. */
+		BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_8, 12),
+
+		/*     1st_byte_of_user_port =3D=3D expected && */
+		BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_6,
+			    offsetof(struct bpf_sock_addr, user_port)),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, port.u4_addr8[0], 10),
+
+		/*     1st_half_of_user_port =3D=3D expected && */
+		BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_6,
+			    offsetof(struct bpf_sock_addr, user_port)),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, port.u4_addr16[0], 8),
+
+		/*     user_port =3D=3D expected) { */
+		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
+			    offsetof(struct bpf_sock_addr, user_port)),
+		BPF_LD_IMM64(BPF_REG_8, port.u4_addr32), /* See [2]. */
 		BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_8, 4),
=20
 		/*      user_ip4 =3D addr4_rw.sin_addr */
--=20
2.24.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155B91D24EF
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 03:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgENBuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 21:50:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENBuy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 21:50:54 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E1ix6c018810
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 18:50:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QrbLMJEK5d+YH3aJxVI0M4vvJ2h6iagiVRe9tWU77+I=;
 b=Bc9nsHAwAgfZmol1gW4CM6s8xNWdcNq14MVRdsydJtjuKAD8P++XCWcnqnNN1YcW4G+k
 OaP2lp/sQAP5mCK4H6DjN6ywJGMl51mYVO9reJ+skBnuhHR8JUAk3X663DtF6mcwLyYD
 lrKzTlzb8QRdePiCUdnI+lNw1CWv4b1Nd2k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100wy8nfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 18:50:53 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 18:50:51 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id E4F1F3700963; Wed, 13 May 2020 18:50:47 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/2] bpf: Support narrow loads from bpf_sock_addr.user_port
Date:   Wed, 13 May 2020 18:50:27 -0700
Message-ID: <c1e983f4c17573032601d0b2b1f9d1274f24bc16.1589420814.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589420814.git.rdna@fb.com>
References: <cover.1589420814.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999
 cotscore=-2147483648 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140014
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_sock_addr.user_port supports only 4-byte load and it leads to ugly
code in BPF programs, like:

	volatile __u32 user_port =3D ctx->user_port;
	__u16 port =3D bpf_ntohs(user_port);

Since otherwise clang may optimize the load to be 2-byte and it's
rejected by verifier.

Add support for 1- and 2-byte loads same way as it's supported for other
fields in bpf_sock_addr like user_ip4, msg_src_ip4, etc.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/uapi/linux/bpf.h       |  2 +-
 net/core/filter.c              | 15 +++++++--------
 tools/include/uapi/linux/bpf.h |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bfb31c1be219..85cfdffde182 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3728,7 +3728,7 @@ struct bpf_sock_addr {
 	__u32 user_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 user_port;	/* Allows 4-byte read and write.
+	__u32 user_port;	/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order
 				 */
 	__u32 family;		/* Allows 4-byte read, but no write */
diff --git a/net/core/filter.c b/net/core/filter.c
index da0634979f53..1fe8c0c2d408 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7029,6 +7029,7 @@ static bool sock_addr_is_valid_access(int off, int =
size,
 	case bpf_ctx_range(struct bpf_sock_addr, msg_src_ip4):
 	case bpf_ctx_range_till(struct bpf_sock_addr, msg_src_ip6[0],
 				msg_src_ip6[3]):
+	case bpf_ctx_range(struct bpf_sock_addr, user_port):
 		if (type =3D=3D BPF_READ) {
 			bpf_ctx_record_field_size(info, size_default);
=20
@@ -7059,10 +7060,6 @@ static bool sock_addr_is_valid_access(int off, int=
 size,
 				return false;
 		}
 		break;
-	case bpf_ctx_range(struct bpf_sock_addr, user_port):
-		if (size !=3D size_default)
-			return false;
-		break;
 	case offsetof(struct bpf_sock_addr, sk):
 		if (type !=3D BPF_READ)
 			return false;
@@ -7958,8 +7955,8 @@ static u32 sock_addr_convert_ctx_access(enum bpf_ac=
cess_type type,
 					struct bpf_insn *insn_buf,
 					struct bpf_prog *prog, u32 *target_size)
 {
+	int off, port_size =3D sizeof_field(struct sockaddr_in6, sin6_port);
 	struct bpf_insn *insn =3D insn_buf;
-	int off;
=20
 	switch (si->off) {
 	case offsetof(struct bpf_sock_addr, user_family):
@@ -7994,9 +7991,11 @@ static u32 sock_addr_convert_ctx_access(enum bpf_a=
ccess_type type,
 			     offsetof(struct sockaddr_in6, sin6_port));
 		BUILD_BUG_ON(sizeof_field(struct sockaddr_in, sin_port) !=3D
 			     sizeof_field(struct sockaddr_in6, sin6_port));
-		SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD(struct bpf_sock_addr_kern,
-						     struct sockaddr_in6, uaddr,
-						     sin6_port, tmp_reg);
+		/* Account for sin6_port being smaller than user_port. */
+		port_size =3D min(port_size, BPF_LDST_BYTES(si));
+		SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD_SIZE_OFF(
+			struct bpf_sock_addr_kern, struct sockaddr_in6, uaddr,
+			sin6_port, bytes_to_bpf_size(port_size), 0, tmp_reg);
 		break;
=20
 	case offsetof(struct bpf_sock_addr, family):
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index bfb31c1be219..85cfdffde182 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3728,7 +3728,7 @@ struct bpf_sock_addr {
 	__u32 user_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 user_port;	/* Allows 4-byte read and write.
+	__u32 user_port;	/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order
 				 */
 	__u32 family;		/* Allows 4-byte read, but no write */
--=20
2.24.1


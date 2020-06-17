Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37E1FD6E8
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 23:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFQVQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 17:16:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgFQVQH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 17:16:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05HLG12S020562
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 14:16:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/5jbCeYBJqjAoT36cHfE6mDjCm+XVA8x3vZCxPZRIY8=;
 b=Llg+qG/jxJRj1Bg7V81krxSEkT55vXWDpppOUEfdfVFwNFI1j3a1xPKNdImZH7yo/9cf
 I1vXar05IU2RXxOnxKB5s9zc/Icb5AiA9GocRVUZR8hh3bLtWxDEMYrq1fhoNSl4bTgF
 DOPWK/JEcGrU7Cl8LvUCIsCvcM6w/dBZz5w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31q644r26g-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 14:16:05 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 14:15:50 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 11ACC3704B9E; Wed, 17 Jun 2020 14:15:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 09/13] bpf: add bpf_skc_to_udp6_sock() helper
Date:   Wed, 17 Jun 2020 14:15:48 -0700
Message-ID: <20200617211548.1856431-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617211536.1854348-1-yhs@fb.com>
References: <20200617211536.1854348-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_12:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=15 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170159
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper is used in tracing programs to cast a socket
pointer to a udp6_sock pointer.
The return value could be NULL if the casting is illegal.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 ++++++++-
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 26 ++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h |  9 ++++++++-
 6 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 64059f91e8d7..ca4c7816a2e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1642,6 +1642,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp6_=
sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
=20
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e256417d94c2..3f4b12c5c563 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3276,6 +3276,12 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct udp6_sock *bpf_skc_to_udp6_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3417,7 +3423,8 @@ union bpf_attr {
 	FN(skc_to_tcp6_sock),		\
 	FN(skc_to_tcp_sock),		\
 	FN(skc_to_tcp_timewait_sock),	\
-	FN(skc_to_tcp_request_sock),
+	FN(skc_to_tcp_request_sock),	\
+	FN(skc_to_udp6_sock),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index de5fbe66e1ca..d10ab16c4a2f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1523,6 +1523,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 		return &bpf_skc_to_tcp_timewait_sock_proto;
 	case BPF_FUNC_skc_to_tcp_request_sock:
 		return &bpf_skc_to_tcp_request_sock_proto;
+	case BPF_FUNC_skc_to_udp6_sock:
+		return &bpf_skc_to_udp6_sock_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type =3D=3D BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 03c0e2e34805..a5f41a6852af 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9301,6 +9301,28 @@ const struct bpf_func_proto bpf_skc_to_tcp_request=
_sock_proto =3D {
 	.ret_btf_id		=3D &bpf_skc_to_tcp_request_sock_ret_btf_id,
 };
=20
+BPF_CALL_1(bpf_skc_to_udp6_sock, struct sock *, sk)
+{
+	/* add an explicit cast to struct udp6_sock to force
+	 * debug_info type generation for it.
+	 */
+	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_UDP &&
+	    sk->sk_family =3D=3D AF_INET6)
+		return (unsigned long)(struct udp6_sock *)sk;
+
+	return (unsigned long)NULL;
+}
+
+static int bpf_skc_to_udp6_sock_ret_btf_id;
+const struct bpf_func_proto bpf_skc_to_udp6_sock_proto =3D {
+	.func			=3D bpf_skc_to_udp6_sock,
+	.gpl_only		=3D true,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &bpf_skc_to_udp6_sock_ret_btf_id,
+};
+
 void init_sock_cast_types(struct btf *btf)
 {
 	char *ret_type_name;
@@ -9325,4 +9347,8 @@ void init_sock_cast_types(struct btf *btf)
 	ret_type_name =3D "tcp_request_sock";
 	find_array_of_btf_ids(btf, &ret_type_name,
 			      &bpf_skc_to_tcp_request_sock_ret_btf_id, 1);
+
+	ret_type_name =3D "udp6_sock";
+	find_array_of_btf_ids(btf, &ret_type_name,
+			      &bpf_skc_to_udp6_sock_ret_btf_id, 1);
 }
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index d886657c6aaa..6bab40ff442e 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -425,6 +425,7 @@ class PrinterHelpers(Printer):
             'struct tcp_sock',
             'struct tcp_timewait_sock',
             'struct tcp_request_sock',
+            'struct udp6_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -466,6 +467,7 @@ class PrinterHelpers(Printer):
             'struct tcp_sock',
             'struct tcp_timewait_sock',
             'struct tcp_request_sock',
+            'struct udp6_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index e256417d94c2..3f4b12c5c563 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3276,6 +3276,12 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct udp6_sock *bpf_skc_to_udp6_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *udp6_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3417,7 +3423,8 @@ union bpf_attr {
 	FN(skc_to_tcp6_sock),		\
 	FN(skc_to_tcp_sock),		\
 	FN(skc_to_tcp_timewait_sock),	\
-	FN(skc_to_tcp_request_sock),
+	FN(skc_to_tcp_request_sock),	\
+	FN(skc_to_udp6_sock),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
--=20
2.24.1


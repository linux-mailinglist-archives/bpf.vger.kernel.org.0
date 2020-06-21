Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B072028F9
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgFUFzk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbgFUFzk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5tc8U021532
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hUXhBLAo1x7DJDr0LDxWbuprCm3JNcwqJkMx6Ekyv6g=;
 b=QXJPv6LfzqDy3jquJCtCda8zwMkhnTSaQU8ZfQ9SQ66mmNKnbdb72yrwernRg1QvatCi
 fwD6daAfavTvHPvNViJ0ig6MNmUnsbOaM1FAAjP1ppjgNc1pWKQ/FX4xRC2i9tY6hkBz
 3uuGZ7pqN/GPjmFnFPLj3z44EXiIitLGFxk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sdskax7e-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:39 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:14 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D39EA37052DE; Sat, 20 Jun 2020 22:55:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 09/15] bpf: add bpf_skc_to_udp6_sock() helper
Date:   Sat, 20 Jun 2020 22:55:10 -0700
Message-ID: <20200621055510.2630175-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=15 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210048
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
 net/core/filter.c              | 22 ++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h |  9 ++++++++-
 6 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b17e682454e5..378b6748a8ec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1640,6 +1640,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp6_=
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
index d26ce3b5e3d5..4ecdadc4aee9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9322,3 +9322,25 @@ const struct bpf_func_proto bpf_skc_to_tcp_request=
_sock_proto =3D {
 	.check_btf_id		=3D check_arg_btf_id,
 	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_TCP_REQ_SOCK],
 };
+
+BPF_CALL_1(bpf_skc_to_udp6_sock, struct sock *, sk)
+{
+	/* udp6_sock type is not generated in dwarf and hence btf,
+	 * trigger an explicit type generation here.
+	 */
+	BTF_TYPE_EMIT(struct udp6_sock);
+	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_UDP &&
+	    sk->sk_family =3D=3D AF_INET6)
+		return (unsigned long)sk;
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_udp6_sock_proto =3D {
+	.func			=3D bpf_skc_to_udp6_sock,
+	.gpl_only		=3D true,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_UDP6_SOCK],
+};
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F22028EE
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgFUFzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729309AbgFUFzM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5onEE003671
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=I1ejqpgqNCJ9a9de5B7uVwaqG+djYbbzznnOjaguHsY=;
 b=mugOBjFrYlComKobaQfxyM0iGf4rv3w24EeOhoWwhxy1EXLAZKBuVOEcizuYJBcSzgfl
 nHvMOwuaMd63q3JsTEC+lvCHfUZP2OUqmJHqVrHin9CBBLO3icMBgKYXUVE34Olps00A
 UqIDe2UF8xAPyCS5LisltVHwt8Rs5EzzZXA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31segatsug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:11 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:10 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7760437052DE; Sat, 20 Jun 2020 22:55:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 06/15] bpf: add bpf_skc_to_{tcp,tcp_timewait,tcp_request}_sock() helpers
Date:   Sat, 20 Jun 2020 22:55:06 -0700
Message-ID: <20200621055506.2629891-1-yhs@fb.com>
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
 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=15 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Three more helpers are added to cast a sock_common pointer to
an tcp_sock, tcp_timewait_sock or a tcp_request_sock for
tracing programs.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  3 ++
 include/uapi/linux/bpf.h       | 23 ++++++++++++++-
 kernel/trace/bpf_trace.c       |  6 ++++
 net/core/filter.c              | 51 ++++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  6 ++++
 tools/include/uapi/linux/bpf.h | 23 ++++++++++++++-
 6 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0c658f78e939..b17e682454e5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1637,6 +1637,9 @@ extern const struct bpf_func_proto bpf_ringbuf_subm=
it_proto;
 extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
 extern const struct bpf_func_proto bpf_ringbuf_query_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
=20
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 394fcba27b6a..e256417d94c2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3258,6 +3258,24 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct tcp_sock *bpf_skc_to_tcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *tcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct tcp_timewait_sock *bpf_skc_to_tcp_timewait_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *tcp_timewait_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct tcp_request_sock *bpf_skc_to_tcp_request_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3396,7 +3414,10 @@ union bpf_attr {
 	FN(ringbuf_discard),		\
 	FN(ringbuf_query),		\
 	FN(csum_level),			\
-	FN(skc_to_tcp6_sock),
+	FN(skc_to_tcp6_sock),		\
+	FN(skc_to_tcp_sock),		\
+	FN(skc_to_tcp_timewait_sock),	\
+	FN(skc_to_tcp_request_sock),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 478c10d1ec33..de5fbe66e1ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1517,6 +1517,12 @@ tracing_prog_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
 		return &bpf_xdp_output_proto;
 	case BPF_FUNC_skc_to_tcp6_sock:
 		return &bpf_skc_to_tcp6_sock_proto;
+	case BPF_FUNC_skc_to_tcp_sock:
+		return &bpf_skc_to_tcp_sock_proto;
+	case BPF_FUNC_skc_to_tcp_timewait_sock:
+		return &bpf_skc_to_tcp_timewait_sock_proto;
+	case BPF_FUNC_skc_to_tcp_request_sock:
+		return &bpf_skc_to_tcp_request_sock_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type =3D=3D BPF_TRACE_ITER ?
diff --git a/net/core/filter.c b/net/core/filter.c
index 8ca365c5bd10..d26ce3b5e3d5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9271,3 +9271,54 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_p=
roto =3D {
 	.check_btf_id		=3D check_arg_btf_id,
 	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_TCP6_SOCK],
 };
+
+BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
+{
+	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
+		return (unsigned long)sk;
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_tcp_sock_proto =3D {
+	.func			=3D bpf_skc_to_tcp_sock,
+	.gpl_only		=3D true,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_TCP_SOCK],
+};
+
+BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
+{
+	if (sk->sk_state =3D=3D TCP_TIME_WAIT)
+		return (unsigned long)sk;
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto =3D {
+	.func			=3D bpf_skc_to_tcp_timewait_sock,
+	.gpl_only		=3D true,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_TCP_TW_SOCK],
+};
+
+BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
+{
+	if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
+		return (unsigned long)sk;
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto =3D {
+	.func			=3D bpf_skc_to_tcp_request_sock,
+	.gpl_only		=3D true,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &sock_cast_btf_ids[SOCK_CAST_TCP_REQ_SOCK],
+};
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 6c2f64118651..d886657c6aaa 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -422,6 +422,9 @@ class PrinterHelpers(Printer):
             'struct tcphdr',
             'struct seq_file',
             'struct tcp6_sock',
+            'struct tcp_sock',
+            'struct tcp_timewait_sock',
+            'struct tcp_request_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -460,6 +463,9 @@ class PrinterHelpers(Printer):
             'struct tcphdr',
             'struct seq_file',
             'struct tcp6_sock',
+            'struct tcp_sock',
+            'struct tcp_timewait_sock',
+            'struct tcp_request_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 394fcba27b6a..e256417d94c2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3258,6 +3258,24 @@ union bpf_attr {
  *		Dynamically cast a *sk* pointer to a *tcp6_sock* pointer.
  *	Return
  *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct tcp_sock *bpf_skc_to_tcp_sock(void *sk)
+ *	Description
+ *		Dynamically cast a *sk* pointer to a *tcp_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct tcp_timewait_sock *bpf_skc_to_tcp_timewait_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *tcp_timewait_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
+ *
+ * struct tcp_request_sock *bpf_skc_to_tcp_request_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *tcp_request_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or NULL otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3396,7 +3414,10 @@ union bpf_attr {
 	FN(ringbuf_discard),		\
 	FN(ringbuf_query),		\
 	FN(csum_level),			\
-	FN(skc_to_tcp6_sock),
+	FN(skc_to_tcp6_sock),		\
+	FN(skc_to_tcp_sock),		\
+	FN(skc_to_tcp_timewait_sock),	\
+	FN(skc_to_tcp_request_sock),
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
  * function eBPF program intends to call
--=20
2.24.1


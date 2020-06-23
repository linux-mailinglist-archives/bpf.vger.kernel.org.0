Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89C120570F
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbgFWQSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 12:18:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1540 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733030AbgFWQSo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Jun 2020 12:18:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NG4tpq009315
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 09:18:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bpOv0iOrk8hFrfzwLT0MU/SlWu0hD9phDmLJEtvxpA8=;
 b=g3KIPvtTkxFa+Q4FdCkimnmMyMh5KdNTKVsWzxqkSV36NBf4QaQRtUEnLZxBgquxjotS
 aocBQLs3uoAhreMCMp8RETBCf27aQdC1DBsjX3vJrNTO7fCEsomI68kTDcH8EI/bZqyP
 gKCEgg44/IC9+TTtDMrqc3WjHQSoGYCYEuM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk26gq2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 09:18:42 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 09:17:59 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6A8C2370330A; Tue, 23 Jun 2020 09:17:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v4 06/15] bpf: add bpf_skc_to_{tcp,tcp_timewait,tcp_request}_sock() helpers
Date:   Tue, 23 Jun 2020 09:17:57 -0700
Message-ID: <20200623161757.2500803-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623161749.2500196-1-yhs@fb.com>
References: <20200623161749.2500196-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=9 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230120
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
 include/uapi/linux/bpf.h       | 23 ++++++++++++-
 kernel/trace/bpf_trace.c       |  6 ++++
 net/core/filter.c              | 62 ++++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  6 ++++
 tools/include/uapi/linux/bpf.h | 23 ++++++++++++-
 6 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c0e38ad07848..c23998cf6699 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1650,6 +1650,9 @@ extern const struct bpf_func_proto bpf_ringbuf_subm=
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
index cdcc62f4e2eb..a285a2d00edc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -74,6 +74,7 @@
 #include <net/lwtunnel.h>
 #include <net/ipv6_stubs.h>
 #include <net/bpf_sk_storage.h>
+#include <net/transp_v6.h>
=20
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -9273,3 +9274,64 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_p=
roto =3D {
 	.check_btf_id		=3D check_arg_btf_id,
 	.ret_btf_id		=3D &btf_sock_ids[BTF_SOCK_TYPE_TCP6],
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
+	.gpl_only		=3D false,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &btf_sock_ids[BTF_SOCK_TYPE_TCP],
+};
+
+BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
+{
+	if (sk->sk_prot =3D=3D &tcp_prot && sk->sk_state =3D=3D TCP_TIME_WAIT)
+		return (unsigned long)sk;
+
+#if IS_BUILTIN(CONFIG_IPV6)
+	if (sk->sk_prot =3D=3D &tcpv6_prot && sk->sk_state =3D=3D TCP_TIME_WAIT=
)
+		return (unsigned long)sk;
+#endif
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto =3D {
+	.func			=3D bpf_skc_to_tcp_timewait_sock,
+	.gpl_only		=3D false,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &btf_sock_ids[BTF_SOCK_TYPE_TCP_TW],
+};
+
+BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
+{
+	if (sk->sk_prot =3D=3D &tcp_prot  && sk->sk_state =3D=3D TCP_NEW_SYN_RE=
CV)
+		return (unsigned long)sk;
+
+#if IS_BUILTIN(CONFIG_IPV6)
+	if (sk->sk_prot =3D=3D &tcpv6_prot && sk->sk_state =3D=3D TCP_NEW_SYN_R=
ECV)
+		return (unsigned long)sk;
+#endif
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto =3D {
+	.func			=3D bpf_skc_to_tcp_request_sock,
+	.gpl_only		=3D false,
+	.ret_type		=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		=3D ARG_PTR_TO_BTF_ID,
+	.check_btf_id		=3D check_arg_btf_id,
+	.ret_btf_id		=3D &btf_sock_ids[BTF_SOCK_TYPE_TCP_REQ],
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


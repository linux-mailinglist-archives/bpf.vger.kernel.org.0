Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FCE12D68C
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2019 07:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfLaGVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Dec 2019 01:21:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10404 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbfLaGU7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Dec 2019 01:20:59 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBV6Fp0I018912
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 22:20:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=s1EWI33qxOMEY3yrqRFwaTeHlIvnpyjUV/s43Yv8kng=;
 b=irTRye8DyDpupr1mTcP+MjsdyiH3+1n9glSIfR6wvCFTlFDNvgd8w+An31sEMLJIEy3X
 deNjuCfppttm7pypzEJ0bEzdLn6R4aeuI6KCl5//8Y9FEqUO1sAzxtd3ooG/j8QEMGtb
 mfrZAOxOjOsTZL/7BN3DwtOm+j5kCbA6iiU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2x65nu1gf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 22:20:57 -0800
Received: from intmgw004.05.ash5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 22:20:56 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 57790294410B; Mon, 30 Dec 2019 22:20:55 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 08/11] bpf: Add BPF_FUNC_tcp_send_ack helper
Date:   Mon, 30 Dec 2019 22:20:55 -0800
Message-ID: <20191231062055.282209-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231062037.280596-1-kafai@fb.com>
References: <20191231062037.280596-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-30_08:2019-12-27,2019-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=13
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912310050
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a helper to send out a tcp-ack.  It will be used in the later
bpf_dctcp implementation that requires to send out an ack
when the CE state changed.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/uapi/linux/bpf.h | 11 ++++++++++-
 net/ipv4/bpf_tcp_ca.c    | 24 +++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 38059880963e..2d6a2e572f56 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2837,6 +2837,14 @@ union bpf_attr {
  * 	Return
  * 		On success, the strictly positive length of the string,	including
  * 		the trailing NUL character. On error, a negative value.
+ *
+ * int bpf_tcp_send_ack(void *tp, u32 rcv_nxt)
+ *	Description
+ *		Send out a tcp-ack. *tp* is the in-kernel struct tcp_sock.
+ *		*rcv_nxt* is the ack_seq to be sent out.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2954,7 +2962,8 @@ union bpf_attr {
 	FN(probe_read_user),		\
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
-	FN(probe_read_kernel_str),
+	FN(probe_read_kernel_str),	\
+	FN(tcp_send_ack),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 142cf3ad8755..81fdc2c1e0d6 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -143,11 +143,33 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	return NOT_INIT;
 }
 
+BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
+{
+	/* bpf_tcp_ca prog cannot have NULL tp */
+	__tcp_send_ack((struct sock *)tp, rcv_nxt);
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_tcp_send_ack_proto = {
+	.func		= bpf_tcp_send_ack,
+	.gpl_only	= false,
+	/* In case we want to report error later */
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg2_type	= ARG_ANYTHING,
+	.btf_id		= &tcp_sock_id,
+};
+
 static const struct bpf_func_proto *
 bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 			  const struct bpf_prog *prog)
 {
-	return bpf_base_func_proto(func_id);
+	switch (func_id) {
+	case BPF_FUNC_tcp_send_ack:
+		return &bpf_tcp_send_ack_proto;
+	default:
+		return bpf_base_func_proto(func_id);
+	}
 }
 
 static const struct bpf_verifier_ops bpf_tcp_ca_verifier_ops = {
-- 
2.17.1


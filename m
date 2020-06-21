Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE32028F4
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 07:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgFUFzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 01:55:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729318AbgFUFzX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Jun 2020 01:55:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05L5ol7Q007675
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Yl4n5UzIuuWhr+TSJzNv6mIjW4bQIkqFrdRSkv8DV5M=;
 b=Y4NyFJ6YlxeW7xz7Vl8WQhIhOujNDJBQ9YFEtIXYiZW+RoMtS1weX3zAmeDAv+UMjYJR
 WhsIUsClUsy60oGWK1zPMxxP//zZVkg0NBU+J/DeCi2a7WxZA/kFOBf5YztEySsnFmVn
 CSkBOsva1MJnEbImlwMLzD7V9ZkgYNwO93E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfjh2n0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 22:55:22 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 22:55:22 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 88D3E37052EE; Sat, 20 Jun 2020 22:55:14 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 12/15] tools/libbpf: add more common macros to bpf_tracing_net.h
Date:   Sat, 20 Jun 2020 22:55:14 -0700
Message-ID: <20200621055514.2630502-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_16:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=13 bulkscore=0 mlxlogscore=581 spamscore=0
 cotscore=-2147483648 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006210047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These newly added macros will be used in subsequent bpf iterator
tcp{4,6} and udp{4,6} programs.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf_tracing_net.h | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing_net.h b/tools/lib/bpf/bpf_tracing_=
net.h
index 1f38a1098727..01378911252b 100644
--- a/tools/lib/bpf/bpf_tracing_net.h
+++ b/tools/lib/bpf/bpf_tracing_net.h
@@ -2,15 +2,50 @@
 #ifndef __BPF_TRACING_NET_H__
 #define __BPF_TRACING_NET_H__
=20
+#define AF_INET			2
+#define AF_INET6		10
+
+#define ICSK_TIME_RETRANS	1
+#define ICSK_TIME_PROBE0	3
+#define ICSK_TIME_LOSS_PROBE	5
+#define ICSK_TIME_REO_TIMEOUT	6
+
 #define IFNAMSIZ		16
=20
 #define RTF_GATEWAY		0x0002
=20
+#define TCP_INFINITE_SSTHRESH	0x7fffffff
+#define TCP_PINGPONG_THRESH	3
+
 #define fib_nh_dev		nh_common.nhc_dev
 #define fib_nh_gw_family	nh_common.nhc_gw_family
 #define fib_nh_gw6		nh_common.nhc_gw.ipv6
=20
+#define inet_daddr		sk.__sk_common.skc_daddr
+#define inet_rcv_saddr		sk.__sk_common.skc_rcv_saddr
+#define inet_dport		sk.__sk_common.skc_dport
+
+#define ir_loc_addr		req.__req_common.skc_rcv_saddr
+#define ir_num			req.__req_common.skc_num
+#define ir_rmt_addr		req.__req_common.skc_daddr
+#define ir_rmt_port		req.__req_common.skc_dport
+#define ir_v6_rmt_addr		req.__req_common.skc_v6_daddr
+#define ir_v6_loc_addr		req.__req_common.skc_v6_rcv_saddr
+
+#define sk_family		__sk_common.skc_family
 #define sk_rmem_alloc		sk_backlog.rmem_alloc
 #define sk_refcnt		__sk_common.skc_refcnt
+#define sk_state		__sk_common.skc_state
+#define sk_v6_daddr		__sk_common.skc_v6_daddr
+#define sk_v6_rcv_saddr		__sk_common.skc_v6_rcv_saddr
+
+#define s6_addr32		in6_u.u6_addr32
+
+#define tw_daddr		__tw_common.skc_daddr
+#define tw_rcv_saddr		__tw_common.skc_rcv_saddr
+#define tw_dport		__tw_common.skc_dport
+#define tw_refcnt		__tw_common.skc_refcnt
+#define tw_v6_daddr		__tw_common.skc_v6_daddr
+#define tw_v6_rcv_saddr		__tw_common.skc_v6_rcv_saddr
=20
 #endif
--=20
2.24.1


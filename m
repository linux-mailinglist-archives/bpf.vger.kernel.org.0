Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F11D3E6B
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgENUEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:04:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgENUEX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:04:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EK1gL1000652
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8I79L/Xc893fECFjKbGmezW++K1/4Kqa9/26Tfe3icw=;
 b=F8OIOjxzxnkgff7BxJrWcDMasrjn1sq9zr+FAm7tQRb0dGvmCabfg8tyhL636NfM3Ge5
 Na24/Kyd0I6b5uRBOnQeOc2nMqAewwvq4945wJZ38u2H7mGbrwUG/lrMSJLuBfGM3JWj
 y5yp55zLJTrFvsIpS2RyRKlLxrv3yQ7fVeM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xbdgaq-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:22 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 13:04:11 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id D370337009C6; Thu, 14 May 2020 13:04:07 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 1/5] bpf: Allow sk lookup helpers in cgroup skb
Date:   Thu, 14 May 2020 13:03:45 -0700
Message-ID: <f8c7ee280f1582b586629436d777b6db00597d63.1589486450.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589486450.git.rdna@fb.com>
References: <cover.1589486450.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=13 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140177
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently sk lookup helpers are allowed in tc, xdp, sk skb, and cgroup
sock_addr programs.

But they would be useful in cgroup skb as well so that for example
cgroup skb ingress program can lookup a peer socket a packet comes from
on same host and make a decision whether to allow or deny this packet
based on the properties of that socket, e.g. cgroup that peer socket
belongs to.

Allow the following sk lookup helpers in cgroup skb:
* bpf_sk_lookup_tcp;
* bpf_sk_lookup_udp;
* bpf_sk_release;
* bpf_skc_lookup_tcp.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 net/core/filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index da0634979f53..ccb560c1a1db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6159,6 +6159,14 @@ cg_skb_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 		return &bpf_skb_cgroup_id_proto;
 #endif
 #ifdef CONFIG_INET
+	case BPF_FUNC_sk_lookup_tcp:
+		return &bpf_sk_lookup_tcp_proto;
+	case BPF_FUNC_sk_lookup_udp:
+		return &bpf_sk_lookup_udp_proto;
+	case BPF_FUNC_sk_release:
+		return &bpf_sk_release_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_skc_lookup_tcp_proto;
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 	case BPF_FUNC_get_listener_sock:
--=20
2.24.1


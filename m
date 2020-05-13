Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2E1D0366
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgEMAEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 20:04:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAEk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 May 2020 20:04:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D00kG5004253
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 17:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gsd1Ma9qkAk5/SoJFjtAaQwbrA4Ik1DMjK9FZITRhVM=;
 b=NV/geV4xtnVPRgQcHxHXfKbrlsY9T3fIIj43CyARGH2wXxl0CsISaGOFzilwuS0WWbN0
 tZArY/3nXj8meqC2R0W1IaEUnEZKsPticuML3t6vOEy3+Djl7rKNp4L6hQVj09zyXYaO
 3s4Ff7xW6t3lPJur5J0MR6++WSrCvaGg50Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1hpt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 17:04:40 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 12 May 2020 17:04:05 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 64542370093A; Tue, 12 May 2020 17:04:04 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/5] bpf: Allow sk lookup helpers in cgroup skb
Date:   Tue, 12 May 2020 17:03:11 -0700
Message-ID: <29221a3f52fd4b26c2291970f45a20b18ba58655.1589327873.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589327873.git.rdna@fb.com>
References: <cover.1589327873.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005120180
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


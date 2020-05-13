Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5486D1D0365
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 02:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgEMAEU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 20:04:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21839 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAEU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 May 2020 20:04:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CNxAZp013805
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 17:04:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HVQ3990WjpbaWCgFcvn3XTTFJfrdrTNmoKGaSUojKU0=;
 b=SizEB/wPVIrJ1J6Ravn9xMKMOEmnXKCn4QYnRAmWh1dKCWVZoQsTqQGEUpryKA9Tq2Kt
 hsbuYVCWscPYaA7ohQsscK7cCOGMeg69gjRfomaGUcplc6CASIVkuyskrtXC5I6aANYE
 Am86FbKzckL9WtIqUn6LS3A5eBkop4+Svhw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x6spka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 17:04:19 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 12 May 2020 17:04:18 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 31B68370093A; Tue, 12 May 2020 17:04:14 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/5] bpf: Allow skb_ancestor_cgroup_id helper in cgroup skb
Date:   Tue, 12 May 2020 17:03:12 -0700
Message-ID: <83dd4e80edd7b870520066c23f0564706469c2d7.1589327873.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1589327873.git.rdna@fb.com>
References: <cover.1589327873.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=738 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=13 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005120180
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup skb programs already can use bpf_skb_cgroup_id. Allow
bpf_skb_ancestor_cgroup_id as well so that container policies can be
implemented for a container that can have sub-cgroups dynamically
created, but policies should still be implemented based on cgroup id of
container itself not on an id of a sub-cgroup.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ccb560c1a1db..f88df77d0ad4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6157,6 +6157,8 @@ cg_skb_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	case BPF_FUNC_skb_cgroup_id:
 		return &bpf_skb_cgroup_id_proto;
+	case BPF_FUNC_skb_ancestor_cgroup_id:
+		return &bpf_skb_ancestor_cgroup_id_proto;
 #endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
--=20
2.24.1


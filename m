Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514D1D3E68
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgENUEP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:04:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729006AbgENUEP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:04:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EK1jJZ000742
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LfldMDJ6u78b7Ht+TLk7TGpDjv3utoKNhmS0vibvowg=;
 b=ULTv7ckkRq+o6EmJUO9MSkXe2Ntxg1h0S+VKZ7k4IqntzHfqMxARxGetme5Zb1cKRgTi
 f7oMoul8mvVwi6dg/J9QGXGrLU4UTmWVgijZsFkjUxUMkOELbXE4u7Ts1Y1kI2bsDHTu
 qbJeC3u679+gVJNYnG2EtAf2001J5mHvW7I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xbdgaf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:04:14 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 13:04:13 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id BCE5337009C6; Thu, 14 May 2020 13:04:11 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 2/5] bpf: Allow skb_ancestor_cgroup_id helper in cgroup skb
Date:   Thu, 14 May 2020 13:03:46 -0700
Message-ID: <8874194d6041eba190356453ea9f6071edf5f658.1589486450.git.rdna@fb.com>
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
 malwarescore=0 adultscore=0 mlxlogscore=767 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140177
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
Acked-by: Yonghong Song <yhs@fb.com>
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


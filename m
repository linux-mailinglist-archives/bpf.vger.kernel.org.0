Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249102B583C
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 04:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgKQDmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 22:42:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgKQDlT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 22:41:19 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AH3dSB7013761
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 19:41:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tMQYn86M7mCJgJxwvphLPq/LNJFFW191W8A4gy995js=;
 b=md5jCkif4jEGH3RfDqWpG7jdrSZcyjrpklF1l1dC+Q0lpS25FiZtgzJ9dp8n8pk088wW
 /8FKPoSSqNt2fJLPsAuS28ak2inD+AOGNcGFIKdgi5ts3+KJbA2M9PJ1gZ9+Nr18bCV/
 u6v02dLOsISmVfeZm8kJlk1VR8QtrYqBObM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34tbm4usqg-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 19:41:18 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 19:41:13 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3B864C63A68; Mon, 16 Nov 2020 19:41:10 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v6 09/34] bpf: refine memcg-based memory accounting for cpumap maps
Date:   Mon, 16 Nov 2020 19:40:43 -0800
Message-ID: <20201117034108.1186569-10-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201117034108.1186569-1-guro@fb.com>
References: <20201117034108.1186569-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_01:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 mlxlogscore=959 bulkscore=0 suspectscore=13 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include metadata and percpu data into the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c61a23b564aa..563f96cc8a9d 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -97,7 +97,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *at=
tr)
 	    attr->map_flags & ~BPF_F_NUMA_NODE)
 		return ERR_PTR(-EINVAL);
=20
-	cmap =3D kzalloc(sizeof(*cmap), GFP_USER);
+	cmap =3D kzalloc(sizeof(*cmap), GFP_USER | __GFP_ACCOUNT);
 	if (!cmap)
 		return ERR_PTR(-ENOMEM);
=20
@@ -415,7 +415,7 @@ static struct bpf_cpu_map_entry *
 __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u32 cpu, int map_id)
 {
 	int numa, err, i, fd =3D value->bpf_prog.fd;
-	gfp_t gfp =3D GFP_KERNEL | __GFP_NOWARN;
+	gfp_t gfp =3D GFP_KERNEL_ACCOUNT | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	struct xdp_bulk_queue *bq;
=20
--=20
2.26.2


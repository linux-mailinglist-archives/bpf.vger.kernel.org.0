Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F624D850
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHUPSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:18:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55640 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbgHUPR5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:17:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFABsd016906
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:17:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gCLOpqUXHAWE2sGF7OqGp2MScbZ8CmithNn8XFEXBiY=;
 b=WUeme+rc/0sNvbxTnQa1HNm2mBc7PHYYK3invql6HpY3mokwVt8V2jIGZPvtkkj+44zW
 o6d2+fePEw9tOSH6OCr3wT56s6Hzc5wX9mteVVGs8Il6Wov9SS/ZRqoW0NEgncNZ78/3
 CWUm9tM3s7A20DLd99YUsHf1UCn4bbtyvLU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3318g0udvn-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:17:56 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:17:52 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 926D13441071; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v4 21/30] bpf: eliminate rlimit-based memory accounting for queue_stack_maps maps
Date:   Fri, 21 Aug 2020 08:01:25 -0700
Message-ID: <20200821150134.2581465-22-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=13 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for queue_stack maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/queue_stack_maps.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
index 44184f82916a..92e73c35a34a 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -66,29 +66,21 @@ static int queue_stack_map_alloc_check(union bpf_attr=
 *attr)
=20
 static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
 {
-	int ret, numa_node =3D bpf_map_attr_numa_node(attr);
-	struct bpf_map_memory mem =3D {0};
+	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct bpf_queue_stack *qs;
-	u64 size, queue_size, cost;
+	u64 size, queue_size;
=20
 	size =3D (u64) attr->max_entries + 1;
-	cost =3D queue_size =3D sizeof(*qs) + size * attr->value_size;
-
-	ret =3D bpf_map_charge_init(&mem, cost);
-	if (ret < 0)
-		return ERR_PTR(ret);
+	queue_size =3D sizeof(*qs) + size * attr->value_size;
=20
 	qs =3D bpf_map_area_alloc(queue_size, numa_node);
-	if (!qs) {
-		bpf_map_charge_finish(&mem);
+	if (!qs)
 		return ERR_PTR(-ENOMEM);
-	}
=20
 	memset(qs, 0, sizeof(*qs));
=20
 	bpf_map_init_from_attr(&qs->map, attr);
=20
-	bpf_map_charge_move(&qs->map.memory, &mem);
 	qs->size =3D size;
=20
 	raw_spin_lock_init(&qs->lock);
--=20
2.26.2


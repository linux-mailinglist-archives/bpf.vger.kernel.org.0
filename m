Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA4F24D89B
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgHUPac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:30:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63846 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbgHUP2s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:28:48 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFAR16028399
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:28:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iKZyyMQdqjb721f824+HvXtzTc/696L14IN6lwMaMGA=;
 b=nTR+WjuzvECmDZdu9trhFmpelT8qPF2vM+JbSpQDztSbVs7QLNNZrLFAT1cgv7AeSHVJ
 C20Xf2X7O1UPVyEP9eLsHyGlK29C612Mck5a720dvDI0MaepZ6jTR1/EAGgYH2miVBIK
 o6IHHdBlZ6P67lMcbrEFQMSw2/2HJHqn6oY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 332gp8031f-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:28:47 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:28:43 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 8DC22344106F; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 20/30] bpf: eliminate rlimit-based memory accounting for lpm_trie maps
Date:   Fri, 21 Aug 2020 08:01:24 -0700
Message-ID: <20200821150134.2581465-21-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=725
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=38 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for lpm_trie maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/lpm_trie.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index d85e0fc2cafc..c747f0835eb1 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -540,8 +540,6 @@ static int trie_delete_elem(struct bpf_map *map, void=
 *_key)
 static struct bpf_map *trie_alloc(union bpf_attr *attr)
 {
 	struct lpm_trie *trie;
-	u64 cost =3D sizeof(*trie), cost_per_node;
-	int ret;
=20
 	if (!bpf_capable())
 		return ERR_PTR(-EPERM);
@@ -567,20 +565,9 @@ static struct bpf_map *trie_alloc(union bpf_attr *at=
tr)
 			  offsetof(struct bpf_lpm_trie_key, data);
 	trie->max_prefixlen =3D trie->data_size * 8;
=20
-	cost_per_node =3D sizeof(struct lpm_trie_node) +
-			attr->value_size + trie->data_size;
-	cost +=3D (u64) attr->max_entries * cost_per_node;
-
-	ret =3D bpf_map_charge_init(&trie->map.memory, cost);
-	if (ret)
-		goto out_err;
-
 	spin_lock_init(&trie->lock);
=20
 	return &trie->map;
-out_err:
-	kfree(trie);
-	return ERR_PTR(ret);
 }
=20
 static void trie_free(struct bpf_map *map)
--=20
2.26.2


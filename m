Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC6233A95
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgG3VYC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 17:24:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730750AbgG3VX0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 17:23:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ULDShH001149
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iKZyyMQdqjb721f824+HvXtzTc/696L14IN6lwMaMGA=;
 b=eUjtLl7b+3LucbAcyzQ7uWm9m1zUPjixdx3UrD3daBlBv0UE+RDp86QZ/+NgBi2/pqY7
 KukVhBncVSSgR9dK/19eV8UavNt6uSJ/GzkKzG7FJAmXxp/G6nJSGBmCvvst7L09fbmT
 2X67n2PWUH77YILIra2zJdTE8iIyTQLH9w8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32kxekateq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:25 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 14:23:19 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 0106620B00C2; Thu, 30 Jul 2020 14:23:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v3 19/29] bpf: eliminate rlimit-based memory accounting for lpm_trie maps
Date:   Thu, 30 Jul 2020 14:23:00 -0700
Message-ID: <20200730212310.2609108-20-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200730212310.2609108-1-guro@fb.com>
References: <20200730212310.2609108-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_15:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=770 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=38 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300150
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


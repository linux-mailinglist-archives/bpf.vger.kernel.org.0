Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582BF2E9FD
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 03:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfE3BEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 21:04:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727256AbfE3BEM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 May 2019 21:04:12 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4U122k0028647
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=m7Qas8kCT32MZkpw+1c5ZCKmwBaZZ4a9XLMi9+IJyGc=;
 b=Ju4qFt3eAJdLR6jnXfhB+wVhhta+P+/rOCEOKBvzZoevWOY5T3yMMecvSbFP7wwxEj1o
 VlqmBiZOz9L5XmSISDDFE0avkBzQkBlQ88B/eCdrGgkyDri+0ipwp/VKXQ39VfeV4FxP
 CG71ZV8Jimr4MtqWs5vg9es387CBnyJd9WU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2ssypk15dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:11 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 May 2019 18:04:09 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id A8459129321E3; Wed, 29 May 2019 18:04:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/5] bpf: add memlock precharge for socket local storage
Date:   Wed, 29 May 2019 18:03:56 -0700
Message-ID: <20190530010359.2499670-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530010359.2499670-1-guro@fb.com>
References: <20190530010359.2499670-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Socket local storage maps lack the memlock precharge check,
which is performed before the memory allocation for
most other bpf map types.

Let's add it in order to unify all map types.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 net/core/bpf_sk_storage.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index cc9597a87770..9a8aaf8e235d 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -626,7 +626,9 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	struct bpf_sk_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
+	u32 pages;
 	u64 cost;
+	int ret;
 
 	smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
 	if (!smap)
@@ -635,13 +637,19 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 
 	smap->bucket_log = ilog2(roundup_pow_of_two(num_possible_cpus()));
 	nbuckets = 1U << smap->bucket_log;
+	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
+	pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
+
+	ret = bpf_map_precharge_memlock(pages);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
 				 GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		kfree(smap);
 		return ERR_PTR(-ENOMEM);
 	}
-	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
@@ -651,7 +659,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
 	smap->cache_idx = (unsigned int)atomic_inc_return(&cache_idx) %
 		BPF_SK_STORAGE_CACHE_SIZE;
-	smap->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
+	smap->map.pages = pages;
 
 	return &smap->map;
 }
-- 
2.20.1


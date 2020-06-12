Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324961F7134
	for <lists+bpf@lfdr.de>; Fri, 12 Jun 2020 02:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFLAJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jun 2020 20:09:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2056 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgFLAJZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Jun 2020 20:09:25 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05C03o9O013704
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 17:09:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=yoRFtuqgldzuDicKT65vnkwZGGHZUQjfmNf9aNVXl6o=;
 b=oofH6C6AMAoW4G7vTihKjAteN9uhij+SAu3k+V7z66hyWN190Of+NQpJ76aij+2wvIDL
 AMlPAY92LaCib4AHwlZBs0fNuQB4KCPknQ/WxR6kwIlhrHsZWyIMk5qgN/YgtUd43TK3
 ee9KLuGqXA9lHyU6v5li4BHXpg2GBArx7Ls= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31k322fyt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2020 17:09:23 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 11 Jun 2020 17:09:22 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id D51FD37008C7; Thu, 11 Jun 2020 17:09:12 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] bpf: Fix memlock accounting for sock_hash
Date:   Thu, 11 Jun 2020 17:08:57 -0700
Message-ID: <20200612000857.2881453-1-rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 priorityscore=1501 suspectscore=38 impostorscore=0 mlxlogscore=470
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110188
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add missed bpf_map_charge_init() in sock_hash_alloc() and
correspondingly bpf_map_charge_finish() on ENOMEM.

It was found accidentally while working on unrelated selftest that
checks "map->memory.pages > 0" is true for all map types.

Before:
	# bpftool m l
	...
	3692: sockhash  name m_sockhash  flags 0x0
		key 4B  value 4B  max_entries 8  memlock 0B

After:
	# bpftool m l
	...
	84: sockmap  name m_sockmap  flags 0x0
		key 4B  value 4B  max_entries 8  memlock 4096B

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 17a40a947546..3a2dc6af1d78 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -989,11 +989,15 @@ static struct bpf_map *sock_hash_alloc(union bpf_at=
tr *attr)
 		err =3D -EINVAL;
 		goto free_htab;
 	}
+	err =3D bpf_map_charge_init(&htab->map.memory, cost);
+	if (err)
+		goto free_htab;
=20
 	htab->buckets =3D bpf_map_area_alloc(htab->buckets_num *
 					   sizeof(struct bpf_htab_bucket),
 					   htab->map.numa_node);
 	if (!htab->buckets) {
+		bpf_map_charge_finish(&htab->map.memory);
 		err =3D -ENOMEM;
 		goto free_htab;
 	}
--=20
2.24.1


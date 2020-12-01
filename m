Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C369C2CAF5B
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 23:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbgLAWAH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 17:00:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34088 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390570AbgLAWAH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 17:00:07 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1LnqL3027017
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 13:59:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kxkjB6Nz8ZK6LGhP0EkOecQD80sPWP9YJ8aS87kUdss=;
 b=U9AboL+VgYl9pGybvHJUbC0H9FDHRzdn8mta+63eWLC3ri/VSuevYMoQBVqQQ/CWsqbn
 D6F5p5jH3Zy04we5EDj2ZrQP8Iv4dOyjB6yN6EhTYzxtYZSTO3FfIYLrrzuH3u8imc9a
 amth8Qf1eAeHw1nr8LROWhUDRU+IR6YSajM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfk0tan-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 13:59:25 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 13:59:11 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 718ED19702B4; Tue,  1 Dec 2020 13:59:06 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v9 11/34] bpf: refine memcg-based memory accounting for devmap maps
Date:   Tue, 1 Dec 2020 13:58:37 -0800
Message-ID: <20201201215900.3569844-12-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201215900.3569844-1-guro@fb.com>
References: <20201201215900.3569844-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_11:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=839 malwarescore=0 spamscore=0 suspectscore=13 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include map metadata and the node size (struct bpf_dtab_netdev)
into the accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/devmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2b5ca93c17de..b43ab247302d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -175,7 +175,7 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *=
attr)
 	if (!capable(CAP_NET_ADMIN))
 		return ERR_PTR(-EPERM);
=20
-	dtab =3D kzalloc(sizeof(*dtab), GFP_USER);
+	dtab =3D kzalloc(sizeof(*dtab), GFP_USER | __GFP_ACCOUNT);
 	if (!dtab)
 		return ERR_PTR(-ENOMEM);
=20
@@ -602,8 +602,9 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(s=
truct net *net,
 	struct bpf_prog *prog =3D NULL;
 	struct bpf_dtab_netdev *dev;
=20
-	dev =3D kmalloc_node(sizeof(*dev), GFP_ATOMIC | __GFP_NOWARN,
-			   dtab->map.numa_node);
+	dev =3D bpf_map_kmalloc_node(&dtab->map, sizeof(*dev),
+				   GFP_ATOMIC | __GFP_NOWARN,
+				   dtab->map.numa_node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
=20
--=20
2.26.2


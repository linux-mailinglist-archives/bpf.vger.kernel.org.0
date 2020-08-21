Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D06924D86A
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHUPRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:17:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38492 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728017AbgHUPRt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:17:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LF9iwc016946
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:17:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e2ojmGdAXN/pi/PSfQUa46nBXC9EwlxjxEiNBa1My1c=;
 b=E/vo9Ew4cQEd8ZY/5/dKu3FGkLMv4eqClqmMPCEvhKNkpraopPoYzmc3iqNKCGK6KCPy
 kPCwi7vEe5boCEtDtKmQRbeOS6+o18BACiB4bVg7lGTYXWoXv0FJmSTBGNT/rrYZa2rY
 TS3U7KUOpvBUEynegJA9ARH3x2CxMsRrtQU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 331crbj8nc-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:17:49 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:17:46 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 4859C3441053; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 07/30] bpf: refine memcg-based memory accounting for devmap maps
Date:   Fri, 21 Aug 2020 08:01:11 -0700
Message-ID: <20200821150134.2581465-8-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=858 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include map metadata and the node size (struct bpf_dtab_netdev) on
element update into the accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/devmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 10abb06065bb..05bf93088063 100644
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
@@ -603,7 +603,8 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(s=
truct net *net,
 	struct bpf_prog *prog =3D NULL;
 	struct bpf_dtab_netdev *dev;
=20
-	dev =3D kmalloc_node(sizeof(*dev), GFP_ATOMIC | __GFP_NOWARN,
+	dev =3D kmalloc_node(sizeof(*dev),
+			   GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT,
 			   dtab->map.numa_node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
--=20
2.26.2


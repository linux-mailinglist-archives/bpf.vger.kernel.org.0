Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCE24D84E
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgHUPR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:17:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728017AbgHUPRw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:17:52 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07LFAj0w005593
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:17:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jE0vXs+gQW10rH0feF6C0U96CAqBPpOSd/wymRApFnE=;
 b=BGSxFzTdnbZouXRg0rNlsSzQUd/iwLHy2be5ZDLkhPUa1a3FY3VA1k33Q7talXKUmqC+
 qXS+KBm03wEpcZb/Azxd4BPbN/q0qUVuiERcYxfUayhXCSoPsUFCHGtYkEV9Y9sdwdxI
 NDxsb841hJVrWm/a2w4AjFLmXpBBVnTKucg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 331hcc14ku-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:17:45 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:17:45 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 67E5B344105F; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 13/30] bpf: refine memcg-based memory accounting for xskmap maps
Date:   Fri, 21 Aug 2020 08:01:17 -0700
Message-ID: <20200821150134.2581465-14-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=13 bulkscore=0 mlxlogscore=762 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend xskmap memory accounting to include the memory taken by
the xsk_map_node structure.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 net/xdp/xskmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 8367adbbe9df..e574b22defe5 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -28,7 +28,8 @@ static struct xsk_map_node *xsk_map_node_alloc(struct x=
sk_map *map,
 	struct xsk_map_node *node;
 	int err;
=20
-	node =3D kzalloc(sizeof(*node), GFP_ATOMIC | __GFP_NOWARN);
+	node =3D kzalloc(sizeof(*node),
+		       GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!node)
 		return ERR_PTR(-ENOMEM);
=20
--=20
2.26.2


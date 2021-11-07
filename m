Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52249447438
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhKGQ6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 11:58:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55918 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232211AbhKGQ6N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 11:58:13 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A7FU5GZ004247
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 08:55:30 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c67uebpj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:55:30 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 08:55:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 90DBD8394B85; Sun,  7 Nov 2021 08:55:26 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 bpf-next 2/9] libbpf: free up resources used by inner map definition
Date:   Sun, 7 Nov 2021 08:55:14 -0800
Message-ID: <20211107165521.9240-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107165521.9240-1-andrii@kernel.org>
References: <20211107165521.9240-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: nxncS5-b56xw5bp--rUj474JCVpcuM7D
X-Proofpoint-ORIG-GUID: nxncS5-b56xw5bp--rUj474JCVpcuM7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_09,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=1 lowpriorityscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=676 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's not enough to just free(map->inner_map), as inner_map itself can
have extra memory allocated, like map name.

Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dfd15cc60ea7..d869ebee1e27 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9009,7 +9009,10 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 		pr_warn("error: inner_map_fd already specified\n");
 		return libbpf_err(-EINVAL);
 	}
-	zfree(&map->inner_map);
+	if (map->inner_map) {
+		bpf_map__destroy(map->inner_map);
+		zfree(&map->inner_map);
+	}
 	map->inner_map_fd = fd;
 	return 0;
 }
-- 
2.30.2


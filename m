Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B629B4A7B5A
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiBBW7b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 17:59:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27964 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbiBBW7b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 17:59:31 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212Lx9C5028418
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 14:59:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyrahvqdw-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:59:31 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:59:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2237C103F6E3A; Wed,  2 Feb 2022 14:59:22 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/6] libbpf: stop using deprecated bpf_map__is_offload_neutral()
Date:   Wed, 2 Feb 2022 14:59:11 -0800
Message-ID: <20220202225916.3313522-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
References: <20220202225916.3313522-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9j_e3g5HlYWb_UlhbMAJfF7Om2oBF7sY
X-Proofpoint-ORIG-GUID: 9j_e3g5HlYWb_UlhbMAJfF7Om2oBF7sY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=910 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Open-code bpf_map__is_offload_neutral() logic in one place in
to-be-deprecated bpf_prog_load_xattr2.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1b0936b016d9..81605de8654e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9505,7 +9505,7 @@ static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
 	}
 
 	bpf_object__for_each_map(map, obj) {
-		if (!bpf_map__is_offload_neutral(map))
+		if (map->def.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
 			map->map_ifindex = attr->ifindex;
 	}
 
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC98C487FFF
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 01:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiAHAnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 19:43:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232041AbiAHAnA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 19:43:00 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207M2caO017545
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 16:43:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3p6+FUPnszJZHNl85rg2No3smGcVuEkLrtAk9IA8IIY=;
 b=eviZpzcwWUhKc1rZ1Y9cpuj2NvGdXLkmJ1SVBOkGGQTsOdopP4o7ay1IGUbA/Amt+XGv
 WDKBy4fYGUSLCz1jImoY8xsnHcqCPV+21DxrFSDyl+8zpOp1t8ArWHt6m9HEeTKVMM20
 jO+Xu/hEXs6b1EZ8iJHHEvH6M8Qyg5lN2Ew= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3deud7hqyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 16:43:00 -0800
Received: from twshared14302.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:43:00 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 9B6711694BCE; Fri,  7 Jan 2022 16:42:39 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next v2 5/5] libbpf: deprecate bpf_map__def() API
Date:   Fri, 7 Jan 2022 16:42:18 -0800
Message-ID: <20220108004218.355761-6-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108004218.355761-1-christylee@fb.com>
References: <20220108004218.355761-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: a92fOxZSLsrsUNNJKF_oAO4-bEY9YFUM
X-Proofpoint-ORIG-GUID: a92fOxZSLsrsUNNJKF_oAO4-bEY9YFUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201080001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All fields accessed via bpf_map_def can now be accessed via
appropirate getters and setters. Mark bpf_map__def() API as deprecated.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8b9bc5e90c2b..9728551501ae 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -706,7 +706,8 @@ bpf_object__prev_map(const struct bpf_object *obj, co=
nst struct bpf_map *map);
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
 /* get map definition */
-LIBBPF_API const struct bpf_map_def *bpf_map__def(const struct bpf_map *=
map);
+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "use appropriate getters or set=
ters instead")
+const struct bpf_map_def *bpf_map__def(const struct bpf_map *map);
 /* get map name */
 LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
 /* get/set map type */
--=20
2.30.2


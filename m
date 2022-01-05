Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44044485C01
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 00:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbiAEXBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 18:01:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245258AbiAEXB3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 Jan 2022 18:01:29 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 205KwFCH023711
        for <bpf@vger.kernel.org>; Wed, 5 Jan 2022 15:01:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=J2dJqQC5SFfm+sDjISYlMAjVZDj1mAyXKjHSwp07Zw0=;
 b=Px0lYpJPppvzgx0bTMyIyAfmiBbaaDCFHwgjZ55kKK1fWHgxl9O9fZ5mzeZMcTI8jbyV
 PConX/GM49MCeMM0imPUkgMn3Vd9uq6MMnlXZkIFvVtmIoqe2mFH1ttFFxDOc/LK9uHv
 fEGvjKm4TnZpMJRSUh7Ikp2VE9U4hECslmE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dcxpr77sj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 15:01:29 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 15:01:26 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 81BBA15060B8; Wed,  5 Jan 2022 15:01:10 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 5/5] libbpf: deprecate bpf_map__def() API
Date:   Wed, 5 Jan 2022 15:00:57 -0800
Message-ID: <20220105230057.853163-6-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105230057.853163-1-christylee@fb.com>
References: <20220105230057.853163-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M1VqRlXelFO1FHLP0jEYrWT3B-YBf5p3
X-Proofpoint-GUID: M1VqRlXelFO1FHLP0jEYrWT3B-YBf5p3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050145
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
index 85dfef88b3d2..f6c1bc7d3de0 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -705,7 +705,8 @@ bpf_object__prev_map(const struct bpf_object *obj, co=
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


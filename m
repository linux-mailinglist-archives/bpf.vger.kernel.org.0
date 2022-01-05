Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA67B484BBC
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 01:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiAEAbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 19:31:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42982 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233341AbiAEAbu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 19:31:50 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204KIG3O032003
        for <bpf@vger.kernel.org>; Tue, 4 Jan 2022 16:31:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=p5HTSUFYytYERF0C4L741qm96DdHbBElWFZRlcWAC5o=;
 b=S9whoz7ttjrGlh3jzd8fN0rj6lLAe+DREfTp5NEH0oMXHPUWDXMwNMr78eeu3kDOJaOV
 sX4H+FteBzbSHbMAYplJGBwgxWfDzjZQABUI1Rug9wyQVVTh+k+j+JtjZPzvxMlNVyvC
 oVMSxEqweA3kyqEVLyi0nMs5t4AB6aY9amY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dct1a2qg7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 16:31:49 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:31:30 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id D040F1454E52; Tue,  4 Jan 2022 16:31:28 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next] libbpf 1.0: deprecate bpf_object__find_map_by_offset() API
Date:   Tue, 4 Jan 2022 16:31:20 -0800
Message-ID: <20220105003120.2222673-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: KFAK88SHgtHxM6nw1jzXc_IlHkEsZ_-y
X-Proofpoint-ORIG-GUID: KFAK88SHgtHxM6nw1jzXc_IlHkEsZ_-y
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_11,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201050000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

API created with simplistic assumptions about BPF map definitions.
It hasn=E2=80=99t worked for a while, deprecate it in preparation for
libbpf 1.0.

[0] Closes: https://github.com/libbpf/libbpf/issues/302

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 85dfef88b3d2..8a86d7e614bc 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -677,7 +677,8 @@ bpf_object__find_map_fd_by_name(const struct bpf_object=
 *obj, const char *name);
  * Get bpf_map through the offset of corresponding struct bpf_map_def
  * in the BPF object file.
  */
-LIBBPF_API struct bpf_map *
+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "function has no effect")
+struct bpf_map *
 bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
=20
 LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_map() inste=
ad")
--=20
2.30.2


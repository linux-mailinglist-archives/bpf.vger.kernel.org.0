Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BC482050
	for <lists+bpf@lfdr.de>; Thu, 30 Dec 2021 21:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbhL3Un1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Dec 2021 15:43:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242114AbhL3Un1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Dec 2021 15:43:27 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BUJftFO018865
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 12:43:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NqAWawOjhHq2ffZBsJpUsM8oQgNP977sH4hh5RMr0r0=;
 b=TcBzTdlnBfZJDOUmR8NMMNIwGqJmvBwhzJotkOjgWLdvBoA4B3dnPLQ7JNB9SYmqQ1ER
 13ZyZdWsgZ3d30WdJEhDhxqduhjuNwLp4otCIV+iSEXhegCrJAF35FfDl+3As/nDf5w8
 h23pW+wZsGPyZlZ+4qTS+rrHRuDRJ7TE710= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3d9h1n256x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 12:43:26 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 12:43:24 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 25A6A10BC074; Thu, 30 Dec 2021 12:40:33 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <ast@kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 3/3] libbpf: deprecate bpf_object__open_xattr() API
Date:   Thu, 30 Dec 2021 12:40:08 -0800
Message-ID: <20211230204008.3136565-4-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211230204008.3136565-1-christylee@fb.com>
References: <20211230204008.3136565-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HEFdAVSuQ33sDoyN9zTmZLWZNVsuxs2A
X-Proofpoint-ORIG-GUID: HEFdAVSuQ33sDoyN9zTmZLWZNVsuxs2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-30_08,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112300117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate bpf_object__open_xattr() in favor of
bpf_object__open_mem() instead.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 tools/lib/bpf/libbpf.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9cb99d1e2385..25b571a297f8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9443,7 +9443,7 @@ static int bpf_prog_load_xattr2(const struct bpf_pr=
og_load_attr *attr,
 	open_attr.file =3D attr->file;
 	open_attr.prog_type =3D attr->prog_type;
=20
-	obj =3D bpf_object__open_xattr(&open_attr);
+	obj =3D libbpf_ptr(__bpf_object__open_xattr(&open_attr, 0));
 	err =3D libbpf_get_error(obj);
 	if (err)
 		return libbpf_err(-ENOENT);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 063639a109aa..aa507a330b61 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -185,6 +185,7 @@ LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_m=
em() instead")
 LIBBPF_API struct bpf_object *
 bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
 			const char *name);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_mem() instead")
 LIBBPF_API struct bpf_object *
 bpf_object__open_xattr(struct bpf_object_open_attr *attr);
=20
--=20
2.30.2


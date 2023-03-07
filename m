Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3129C6AFA78
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCGXdm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCGXdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:33:24 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F37C3D9
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:33:22 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327MC21K017984
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 15:33:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=/uTYSplSXCjXotfkzKZLj02SzJ7+QIAxw/a1bKfpHOk=;
 b=g4eo9etn34zif/lssMDaQDUFqS3mruekU9yLnwIA5U2fKHbrJKJ44dcdlrRwLVtCJygu
 /1rnYogZ6zv35w/lrFqISlZ1BIx+CuEgG2cjjKucqMCjyDRA5wSaHN5SfQlYKpug+A3s
 8MW6DQqQKxP9Rq6LroVRUbgOocTKRLbnAYCFrZJR6HO38Edcc5GgoyeAuvicdNo9V1hw
 q/szoSh/wfKiTv5FJw0PK5HehLT2D1yHV6Omuzi+6qrw/u+C6BvGAhOnqrZj02Lx8rki
 vZEp21H4myFC/N40Xr8GWO7pAobN+WN2j/cgRm7thGEKxlQgp49FrP0h4Zn3hG9r6s4o jA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6cp38y6m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:33:21 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 15:33:20 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 38EF26C7C9BB; Tue,  7 Mar 2023 15:33:13 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v4 4/9] bpf: Validate kdata of a struct_ops before transiting to READY.
Date:   Tue, 7 Mar 2023 15:33:02 -0800
Message-ID: <20230307233307.3626875-5-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307233307.3626875-1-kuifeng@meta.com>
References: <20230307233307.3626875-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Yj1Ah0WH8nXFjLWkWvFt5NsZhIqT5aUu
X-Proofpoint-GUID: Yj1Ah0WH8nXFjLWkWvFt5NsZhIqT5aUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

By utilizing this check, we can avoid creating a struct_ops that
cannot be registered afterward. This way, future complications can be
avoided with ease.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 kernel/bpf/bpf_struct_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index dcb7a408d4e9..c71c8d73c7ad 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -504,6 +504,11 @@ static int bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
=20
 	set_memory_rox((long)st_map->image, 1);
 	if (st_map->map.map_flags & BPF_F_LINK) {
+		if (st_ops->validate) {
+			err =3D st_ops->validate(kdata);
+			if (err)
+				goto unlock;
+		}
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
--=20
2.34.1


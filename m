Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0C60D65F
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiJYVyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJYVyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 17:54:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52790DBE5E
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJjkEt029299
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=r0PWFa4lb3z85e4eyA3svLiqT+n1JUXsUoNor92U37k=;
 b=aNguuM6r3CBDhpc/W8te2pWjNilX+fL3WzkVE1dpBKXpWKxFDxIVO2FmVtZaia8EDa+v
 QIoAKyvCgsgla1anfGDafOv0DyWam4u5QGXDk/RghySqCg6XRGc21BcPA1CcyHdGgvbA
 DH9J2pzpo6UR9fSsSGolwWQ0pVHLP2emFL8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke64gtyy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:18 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 14:54:16 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AA51F112E9DE2; Tue, 25 Oct 2022 14:54:13 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v5 4/7] libbpf: Support new cgroup local storage
Date:   Tue, 25 Oct 2022 14:54:13 -0700
Message-ID: <20221025215413.4185766-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025215352.4184578-1-yhs@fb.com>
References: <20221025215352.4184578-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: M-zg_AJ4NqHMF1yvSZmI-u-jKmZPkZMw
X-Proofpoint-ORIG-GUID: M-zg_AJ4NqHMF1yvSZmI-u-jKmZPkZMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for new cgroup local storage.

Acked-by: David Vernet <void@manifault.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 027fd9565c16..5d7819edf074 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -164,6 +164,7 @@ static const char * const map_type_name[] =3D {
 	[BPF_MAP_TYPE_TASK_STORAGE]		=3D "task_storage",
 	[BPF_MAP_TYPE_BLOOM_FILTER]		=3D "bloom_filter",
 	[BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
+	[BPF_MAP_TYPE_CGRP_STORAGE]		=3D "cgrp_storage",
 };
=20
 static const char * const prog_type_name[] =3D {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
index f3a8e8e74eb8..bdb83d467f9a 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -221,6 +221,7 @@ static int probe_map_create(enum bpf_map_type map_typ=
e)
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
 	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CGRP_STORAGE:
 		btf_key_type_id =3D 1;
 		btf_value_type_id =3D 3;
 		value_size =3D 8;
--=20
2.30.2


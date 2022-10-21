Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21546608224
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJUXou (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJUXor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:44:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ABF34725
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:44 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29LMHmJR025647
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lSC1mUFyLMFfHenlGM12xTlidbMad6AnT8vuEwb1roo=;
 b=Z8CtdVLgbDE25N1evrDyQPnVpv1Z/+/zO/KkKGCTAvS5xkz9gZ+mNld8wRzGY6vig6eD
 3N2YMYuKurTM8gcCNE4edZMS9YiIGkss4hCwFUrdKEMFYNFSWe2jgyjkpAm4wCns4KHK
 KCkTyw5eu00nh/1XUllzfsKVbaYsWu0KTB0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kbs51794g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:44:43 -0700
Received: from twshared2001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:44:42 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E15F211011334; Fri, 21 Oct 2022 16:44:37 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v3 4/7] libbpf: Support new cgroup local storage
Date:   Fri, 21 Oct 2022 16:44:37 -0700
Message-ID: <20221021234437.2332358-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021234416.2328241-1-yhs@fb.com>
References: <20221021234416.2328241-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TN3nwOeQsScsLAV8lI8pPuTGRHc4nUqf
X-Proofpoint-ORIG-GUID: TN3nwOeQsScsLAV8lI8pPuTGRHc4nUqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for new cgroup local storage.

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


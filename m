Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC609552
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiJWSFy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiJWSFv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 14:05:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1195D884
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NAf0CZ005368
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LZgsahRgS2+ozMpcEZ97QsCPayPMplqJkGhaAaubtkc=;
 b=qBvp08E46LFxMEz4IrHDryTMX2NWmxUVJ+mymwIJIOS5VTLOungI76Iy+E1gB9+qzyNa
 82QmuaAttj+Y88xz2E9Ox7UQoeSEGVKn+vOuJn/r5KVxCg6X8jWRD0ne2bKysHi51KNy
 GJfrqC4UJwutpQgcLZPkUV9NvgqbVH9OeMA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kccjnbtkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:46 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 11:05:44 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 74EF8111597BB; Sun, 23 Oct 2022 11:05:40 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4 5/7] bpftool: Support new cgroup local storage
Date:   Sun, 23 Oct 2022 11:05:40 -0700
Message-ID: <20221023180540.2862924-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221023180514.2857498-1-yhs@fb.com>
References: <20221023180514.2857498-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3Wvl0rS36GlgChoQBhGM42lcFgSmai9w
X-Proofpoint-ORIG-GUID: 3Wvl0rS36GlgChoQBhGM42lcFgSmai9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for new cgroup local storage

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/=
bpftool/Documentation/bpftool-map.rst
index 7f3b67a8b48f..11250c4734fe 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,7 @@ MAP COMMANDS
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap*=
* | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_stor=
age**
 |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf=
** | **inode_storage**
-|		| **task_storage** | **bloom_filter** | **user_ringbuf** }
+|		| **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_sto=
rage** }
=20
 DESCRIPTION
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9a6ca9f31133..3a2a89912637 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1459,7 +1459,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | s=
ockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup=
_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | =
inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_st=
orage }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
--=20
2.30.2


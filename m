Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EC60DA48
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 06:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiJZE3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 00:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJZE3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 00:29:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F576AB805
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PMH1lU013607
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EXZqpHfQbBUvFMwBtPItfurM2TVtKOAq1Vc5BGMYzGs=;
 b=MMDqKRVICpXQISsmN8eSaNVgbtjQu8FIFwIuI9Oq641QFOF+p0g97GOMTMZFKD7qwCR4
 BS94ZCptNjk0oMnLWEJtOKh+aZeLcxj47n2lUPooc0N5pHiAqrm6k3pvoNHlIvNuloPI
 5cwWq422+hm6POHDw7JIWqF137+MZ3j/zKE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3keb4jum2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:06 -0700
Received: from twshared26494.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:29:05 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 69F6A1131B878; Tue, 25 Oct 2022 21:29:01 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v6 5/9] bpftool: Support new cgroup local storage
Date:   Tue, 25 Oct 2022 21:29:01 -0700
Message-ID: <20221026042901.674177-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026042835.672317-1-yhs@fb.com>
References: <20221026042835.672317-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: b19w0VircbyWnVwOvsTEauglB-ytLcAd
X-Proofpoint-ORIG-GUID: b19w0VircbyWnVwOvsTEauglB-ytLcAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_02,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 3087ced658ad..f941ac5c7b73 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1458,7 +1458,7 @@ static int do_help(int argc, char **argv)
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


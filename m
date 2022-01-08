Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101A9487FFC
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 01:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiAHAmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 19:42:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232038AbiAHAmy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 19:42:54 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 207M3nJ9010907
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 16:42:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1wa1OK3JKvoW4B/DfFr9rZgzzPSiLB7jLB9+r0+b+IU=;
 b=hWAE1ui7x6A6rd/ruc7Z2XH3FppBq9mbbBTbuGD4YFLOTdjUgJ4InYVUTYQ/UjYrHjjl
 4CUnWfXa8B/9DRBYiw/RLVG2nJlyx5BdHkBgA2TfCrXGkpJz6FKThc8eiccTL1Y6llAu
 xv/7V7m/ZqK8jICfs0XK+W7PeEWrskKrKxc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3de4xg1k89-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 16:42:53 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:42:51 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 83F491694BC7; Fri,  7 Jan 2022 16:42:39 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next v2 2/5] bpftool: stop using bpf_map__def() API
Date:   Fri, 7 Jan 2022 16:42:15 -0800
Message-ID: <20220108004218.355761-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108004218.355761-1-christylee@fb.com>
References: <20220108004218.355761-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jtQLU69Y5RM-mta_iWjbbYuGq5VZKuIX
X-Proofpoint-ORIG-GUID: jtQLU69Y5RM-mta_iWjbbYuGq5VZKuIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201080001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf bpf_map__def() API is being deprecated, replace bpftool's
usage with the appropriate getters and setters

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/bpf/bpftool/gen.c        | 12 ++++++------
 tools/bpf/bpftool/struct_ops.c |  4 +---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b4695df2ea3d..0b6f1553db0b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -227,7 +227,7 @@ static int codegen_datasecs(struct bpf_object *obj, c=
onst char *obj_name)
 		/* only generate definitions for memory-mapped internal maps */
 		if (!bpf_map__is_internal(map))
 			continue;
-		if (!(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
+		if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 			continue;
=20
 		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
@@ -468,7 +468,7 @@ static void codegen_destroy(struct bpf_object *obj, c=
onst char *obj_name)
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
-		    (bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
+		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 			printf("\tmunmap(skel->%1$s, %2$zd);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
@@ -536,7 +536,7 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
 			continue;
=20
 		if (!bpf_map__is_internal(map) ||
-		    !(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
+		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 			continue;
=20
 		codegen("\
@@ -600,10 +600,10 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
 			continue;
=20
 		if (!bpf_map__is_internal(map) ||
-		    !(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
+		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 			continue;
=20
-		if (bpf_map__def(map)->map_flags & BPF_F_RDONLY_PROG)
+		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
 			mmap_flags =3D "PROT_READ";
 		else
 			mmap_flags =3D "PROT_READ | PROT_WRITE";
@@ -962,7 +962,7 @@ static int do_skeleton(int argc, char **argv)
 				i, bpf_map__name(map), i, ident);
 			/* memory-mapped internal maps */
 			if (bpf_map__is_internal(map) &&
-			    (bpf_map__def(map)->map_flags & BPF_F_MMAPABLE)) {
+			    (bpf_map__map_flags(map) & BPF_F_MMAPABLE)) {
 				printf("\ts->maps[%zu].mmaped =3D (void **)&obj->%s;\n",
 				       i, ident);
 			}
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_op=
s.c
index 2f693b082bdb..e08a6ff2866c 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -480,7 +480,6 @@ static int do_unregister(int argc, char **argv)
 static int do_register(int argc, char **argv)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
-	const struct bpf_map_def *def;
 	struct bpf_map_info info =3D {};
 	__u32 info_len =3D sizeof(info);
 	int nr_errs =3D 0, nr_maps =3D 0;
@@ -510,8 +509,7 @@ static int do_register(int argc, char **argv)
 	}
=20
 	bpf_object__for_each_map(map, obj) {
-		def =3D bpf_map__def(map);
-		if (def->type !=3D BPF_MAP_TYPE_STRUCT_OPS)
+		if (bpf_map__type(map) !=3D BPF_MAP_TYPE_STRUCT_OPS)
 			continue;
=20
 		link =3D bpf_map__attach_struct_ops(map);
--=20
2.30.2


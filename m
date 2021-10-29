Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959FF440599
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhJ2WwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:52:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40360 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231539AbhJ2WwS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:52:18 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TMhe4d005777
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MoR7l8ATPBFCmhaQOMXfX0SWVw1OL/dbpDsfyZf0Xjk=;
 b=Bu19XNQWfUpXARLkhlxKh4f2iBBnDumkqZIPje2OXNV2mkC2OdJVYTYQqcXZ8+7MhQCb
 I7uywDtHUn7cZJ7ZuxDBopA9+Ap0f04vy9462swihlObHkiVliw0AbLUyCb+173Ztm6Z
 G37B1b4W9Bebi5hVxBvKTg37Dx28A+4BlnA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c098n81jv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:47 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:49:45 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 9B4DC437304E; Fri, 29 Oct 2021 15:49:36 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>, <yhs@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 2/3] bpf: Add alignment padding for "map_extra" + consolidate holes
Date:   Fri, 29 Oct 2021 15:49:08 -0700
Message-ID: <20211029224909.1721024-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029224909.1721024-1-joannekoong@fb.com>
References: <20211029224909.1721024-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: iZABkFZxoYF5mbZl1AkZj1FQZyel5cC9
X-Proofpoint-ORIG-GUID: iZABkFZxoYF5mbZl1AkZj1FQZyel5cC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=415 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110290127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch makes 2 changes regarding alignment padding
for the "map_extra" field.

1) In the kernel header, "map_extra" and "btf_value_type_id"
are rearranged to consolidate the hole.

Before:
struct bpf_map {
	...
        u32		max_entries;	/*    36     4	*/
        u32		map_flags;	/*    40     4	*/

        /* XXX 4 bytes hole, try to pack */

        u64		map_extra;	/*    48     8	*/
        int		spin_lock_off;	/*    56     4	*/
        int		timer_off;	/*    60     4	*/
        /* --- cacheline 1 boundary (64 bytes) --- */
        u32		id;		/*    64     4	*/
        int		numa_node;	/*    68     4	*/
	...
        bool		frozen;		/*   117     1	*/

        /* XXX 10 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
	...
        struct work_struct	work;	/*   144    72	*/

        /* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
	struct mutex	freeze_mutex;	/*   216   144 	*/

        /* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
        u64		writecnt; 	/*   360     8	*/

    /* size: 384, cachelines: 6, members: 26 */
    /* sum members: 354, holes: 2, sum holes: 14 */
    /* padding: 16 */
    /* forced alignments: 2, forced holes: 1, sum forced holes: 10 */

} __attribute__((__aligned__(64)));

After:
struct bpf_map {
	...
        u32		max_entries;	/*    36     4	*/
        u64		map_extra;	/*    40     8 	*/
        u32		map_flags;	/*    48     4	*/
        int		spin_lock_off;	/*    52     4	*/
        int		timer_off;	/*    56     4	*/
        u32		id;		/*    60     4	*/

        /* --- cacheline 1 boundary (64 bytes) --- */
        int		numa_node;	/*    64     4	*/
	...
	bool		frozen		/*   113     1  */

        /* XXX 14 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
	...
        struct work_struct	work;	/*   144    72	*/

        /* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
        struct mutex	freeze_mutex;	/*   216   144	*/

        /* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
        u64		writecnt;       /*   360     8	*/

    /* size: 384, cachelines: 6, members: 26 */
    /* sum members: 354, holes: 1, sum holes: 14 */
    /* padding: 16 */
    /* forced alignments: 2, forced holes: 1, sum forced holes: 14 */

} __attribute__((__aligned__(64)));

2) Add alignment padding to the bpf_map_info struct
More details can be found in commit 36f9814a494a ("bpf: fix uapi hole
for 32 bit compat applications")

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf.h            | 6 +++---
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6deebf8bf78f..d695b2ef67d5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -168,23 +168,23 @@ struct bpf_map {
 	u32 key_size;
 	u32 value_size;
 	u32 max_entries;
-	u32 map_flags;
 	u64 map_extra; /* any per-map-type extra fields */
+	u32 map_flags;
 	int spin_lock_off; /* >=3D0 valid offset, <0 error */
 	int timer_off; /* >=3D0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
 	u32 btf_key_type_id;
 	u32 btf_value_type_id;
+	u32 btf_vmlinux_value_type_id;
 	struct btf *btf;
 #ifdef CONFIG_MEMCG_KMEM
 	struct mem_cgroup *memcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	u32 btf_vmlinux_value_type_id;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 22 bytes hole */
+	/* 14 bytes hole */
=20
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bd0c9f0487f6..ba5af15e25f5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5662,6 +5662,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u32 :32;	/* alignment pad */
 	__u64 map_extra;
 } __attribute__((aligned(8)));
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index bd0c9f0487f6..ba5af15e25f5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5662,6 +5662,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u32 :32;	/* alignment pad */
 	__u64 map_extra;
 } __attribute__((aligned(8)));
=20
--=20
2.30.2


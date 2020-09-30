Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE74F27F430
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 23:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgI3V2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 17:28:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42086 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728660AbgI3V2j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 17:28:39 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08ULPlHB014740
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 14:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6o+g6CvLKaTKQuIHDUh/KcMdLPvg7ltHmTb/OOFUgJM=;
 b=DelnAIe1lN5giDjfnukB22YjXqbamaSGrxVJemYfvwAzWSyNIXJFnNcf6IgM5UA6+8cD
 38tS7W6LJgNNWc4wI1aQzK3BQHmG8Hft5vR8f6f/3k+CMLS68rVKHB5BP+b/Fpqxs7Lj
 57qRO47xeycNmL9LH4vn2LVw9dhgWqt6cnk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33vwu39mye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 14:28:38 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 14:28:38 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5C31262E585F; Wed, 30 Sep 2020 14:28:35 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 1/2] bpf: introduce BPF_F_PRESERVE_ELEMS for perf event array
Date:   Wed, 30 Sep 2020 14:28:23 -0700
Message-ID: <20200930212824.1418683-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930212824.1418683-1-songliubraving@fb.com>
References: <20200930212824.1418683-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_13:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=2 impostorscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300174
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, perf event in perf event array is removed from the array when
the map fd used to add the event is closed. This behavior makes it
difficult to the share perf events with perf event array.

Introduce perf event map that keeps the perf event open with a new flag
BPF_F_PRESERVE_ELEMS. With this flag set, perf events in the array are no=
t
removed when the original map fd is closed. Instead, the perf event will
stay in the map until 1) it is explicitly removed from the array; or 2)
the array is freed.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/arraymap.c          | 19 +++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  3 +++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1f17c6752debb..4f556cfcbfbee 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -414,6 +414,9 @@ enum {
=20
 /* Enable memory-mapping BPF map */
 	BPF_F_MMAPABLE		=3D (1U << 10),
+
+/* Share perf_event among processes */
+	BPF_F_PRESERVE_ELEMS	=3D (1U << 11),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index e5fd31268ae02..bd777dd6f9677 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -15,7 +15,8 @@
 #include "map_in_map.h"
=20
 #define ARRAY_CREATE_FLAG_MASK \
-	(BPF_F_NUMA_NODE | BPF_F_MMAPABLE | BPF_F_ACCESS_MASK)
+	(BPF_F_NUMA_NODE | BPF_F_MMAPABLE | BPF_F_ACCESS_MASK | \
+	 BPF_F_PRESERVE_ELEMS)
=20
 static void bpf_array_free_percpu(struct bpf_array *array)
 {
@@ -64,6 +65,10 @@ int array_map_alloc_check(union bpf_attr *attr)
 	    attr->map_flags & BPF_F_MMAPABLE)
 		return -EINVAL;
=20
+	if (attr->map_type !=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
+	    attr->map_flags & BPF_F_PRESERVE_ELEMS)
+		return -EINVAL;
+
 	if (attr->value_size > KMALLOC_MAX_SIZE)
 		/* if value_size is bigger, the user space won't be able to
 		 * access the elements.
@@ -1134,6 +1139,9 @@ static void perf_event_fd_array_release(struct bpf_=
map *map,
 	struct bpf_event_entry *ee;
 	int i;
=20
+	if (map->map_flags & BPF_F_PRESERVE_ELEMS)
+		return;
+
 	rcu_read_lock();
 	for (i =3D 0; i < array->map.max_entries; i++) {
 		ee =3D READ_ONCE(array->ptrs[i]);
@@ -1143,12 +1151,19 @@ static void perf_event_fd_array_release(struct bp=
f_map *map,
 	rcu_read_unlock();
 }
=20
+static void perf_event_fd_array_map_free(struct bpf_map *map)
+{
+	if (map->map_flags & BPF_F_PRESERVE_ELEMS)
+		bpf_fd_array_map_clear(map);
+	fd_array_map_free(map);
+}
+
 static int perf_event_array_map_btf_id;
 const struct bpf_map_ops perf_event_array_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
 	.map_alloc_check =3D fd_array_map_alloc_check,
 	.map_alloc =3D array_map_alloc,
-	.map_free =3D fd_array_map_free,
+	.map_free =3D perf_event_fd_array_map_free,
 	.map_get_next_key =3D array_map_get_next_key,
 	.map_lookup_elem =3D fd_array_map_lookup_elem,
 	.map_delete_elem =3D fd_array_map_delete_elem,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 1f17c6752debb..4f556cfcbfbee 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -414,6 +414,9 @@ enum {
=20
 /* Enable memory-mapping BPF map */
 	BPF_F_MMAPABLE		=3D (1U << 10),
+
+/* Share perf_event among processes */
+	BPF_F_PRESERVE_ELEMS	=3D (1U << 11),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
--=20
2.24.1


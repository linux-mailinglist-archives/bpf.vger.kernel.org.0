Return-Path: <bpf+bounces-30902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C98D45B7
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF6BB23F47
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3391A38CE;
	Thu, 30 May 2024 07:05:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F83DABE9
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052719; cv=none; b=CSqcsZDg/D8TuHEdhoduhG0IppBFgqBEiHV2Q4o649O00ISZcVvPxetIFhmrQWDhO/0DorbSdobIxnoTNxe9wJSTGTT8JQxOA9W4QsGxvh4PACa34gV/iYn6C6morQ8+bYW9pDvmWdsNaYFk+mrdNNd3F6f3Ri+EHvlxyUH4V/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052719; c=relaxed/simple;
	bh=9PLlNKT6Q7fpG82t2iQeXADfv5rFhkAWNrxAIZCFZXM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COq4IUIZihjvTDE6rk9Wjfzf/AHT3caYGF1HiqkmID8fpqKe6fXo0GGudmL8hzBWFe6vRkGWU0otVmHeuBBq+NfGWjH2au57CAf/IKv9nCggCvSXhJkuDqJc8iXldEAvIbscgMlmtewFKI62l4aVH4dbCdllYc7QB4TN8CHEUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U6hAuu030654
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yemec02cb-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 00:05:16 -0700
Received: from twshared15377.32.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 30 May 2024 07:05:05 +0000
Received: by devbig1475.frc2.facebook.com (Postfix, from userid 460691)
	id 1C3895DFFBF4; Thu, 30 May 2024 00:04:51 -0700 (PDT)
From: <thinker.li@gmail.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <kernel-team@meta.com>, <andrii@kernel.org>, <sinquersw@gmail.com>,
        <kuifeng@meta.com>, <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 3/8] bpf: support epoll from bpf struct_ops links.
Date: Wed, 29 May 2024 23:59:41 -0700
Message-ID: <20240530065946.979330-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530065946.979330-1-thinker.li@gmail.com>
References: <20240530065946.979330-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mSJv8he-1Tcv0hmnUqDbq3c52UlNjt8m
X-Proofpoint-ORIG-GUID: mSJv8he-1Tcv0hmnUqDbq3c52UlNjt8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01

From: Kui-Feng Lee <thinker.li@gmail.com>

Add epoll support to bpf struct_ops links to trigger EPOLLHUP event upon
detachment.

This patch implements the "poll" of the "struct file_operations" for BPF
links and introduces a new "poll" operator in the "struct bpf_link_ops". =
By
implementing "poll" of "struct bpf_link_ops" for the links of struct_ops,
the file descriptor of a struct_ops link can be added to an epoll file
descriptor to receive EPOLLHUP events.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++++++
 kernel/bpf/syscall.c        | 31 ++++++++++++++++++++++++++-----
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19f8836382fc..5eb61120e4f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1612,6 +1612,7 @@ struct bpf_link_ops {
 			      struct bpf_link_info *info);
 	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
 			  struct bpf_map *old_map);
+	__poll_t (*poll)(struct file *file, struct poll_table_struct *pts);
 };
=20
 struct bpf_tramp_link {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5ea35608326f..5e21bc917ba5 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/poll.h>
=20
 struct bpf_struct_ops_value {
 	struct bpf_struct_ops_common_value common;
@@ -56,6 +57,7 @@ struct bpf_struct_ops_map {
 struct bpf_struct_ops_link {
 	struct bpf_link link;
 	struct bpf_map __rcu *map;
+	wait_queue_head_t wait_hup;
 };
=20
 static DEFINE_MUTEX(update_mutex);
@@ -1167,15 +1169,28 @@ static int bpf_struct_ops_map_link_detach(struct =
bpf_link *link)
=20
 	mutex_unlock(&update_mutex);
=20
+	wake_up_interruptible_poll(&st_link->wait_hup, EPOLLHUP);
+
 	return 0;
 }
=20
+static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
+					     struct poll_table_struct *pts)
+{
+	struct bpf_struct_ops_link *st_link =3D file->private_data;
+
+	poll_wait(file, &st_link->wait_hup, pts);
+
+	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
 	.dealloc =3D bpf_struct_ops_map_link_dealloc,
 	.detach =3D bpf_struct_ops_map_link_detach,
 	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
 	.update_map =3D bpf_struct_ops_map_link_update,
+	.poll =3D bpf_struct_ops_map_link_poll,
 };
=20
 int bpf_struct_ops_link_create(union bpf_attr *attr)
@@ -1208,6 +1223,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
 	if (err)
 		goto err_out;
=20
+	init_waitqueue_head(&link->wait_hup);
+
 	mutex_lock(&update_mutex);
 	err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->li=
nk);
 	if (err) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2222c3ff88e7..81efa1944942 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3150,6 +3150,13 @@ static void bpf_link_show_fdinfo(struct seq_file *=
m, struct file *filp)
 }
 #endif
=20
+static __poll_t bpf_link_poll(struct file *file, struct poll_table_struc=
t *pts)
+{
+	struct bpf_link *link =3D file->private_data;
+
+	return link->ops->poll(file, pts);
+}
+
 static const struct file_operations bpf_link_fops =3D {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	=3D bpf_link_show_fdinfo,
@@ -3159,6 +3166,16 @@ static const struct file_operations bpf_link_fops =
=3D {
 	.write		=3D bpf_dummy_write,
 };
=20
+static const struct file_operations bpf_link_fops_poll =3D {
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	=3D bpf_link_show_fdinfo,
+#endif
+	.release	=3D bpf_link_release,
+	.read		=3D bpf_dummy_read,
+	.write		=3D bpf_dummy_write,
+	.poll		=3D bpf_link_poll,
+};
+
 static int bpf_link_alloc_id(struct bpf_link *link)
 {
 	int id;
@@ -3201,7 +3218,9 @@ int bpf_link_prime(struct bpf_link *link, struct bp=
f_link_primer *primer)
 		return id;
 	}
=20
-	file =3D anon_inode_getfile("bpf_link", &bpf_link_fops, link, O_CLOEXEC=
);
+	file =3D anon_inode_getfile("bpf_link",
+				  link->ops->poll ? &bpf_link_fops_poll : &bpf_link_fops,
+				  link, O_CLOEXEC);
 	if (IS_ERR(file)) {
 		bpf_link_free_id(id);
 		put_unused_fd(fd);
@@ -3229,7 +3248,9 @@ int bpf_link_settle(struct bpf_link_primer *primer)
=20
 int bpf_link_new_fd(struct bpf_link *link)
 {
-	return anon_inode_getfd("bpf-link", &bpf_link_fops, link, O_CLOEXEC);
+	return anon_inode_getfd("bpf-link",
+				link->ops->poll ? &bpf_link_fops_poll : &bpf_link_fops,
+				link, O_CLOEXEC);
 }
=20
 struct bpf_link *bpf_link_get_from_fd(u32 ufd)
@@ -3239,7 +3260,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
=20
 	if (!f.file)
 		return ERR_PTR(-EBADF);
-	if (f.file->f_op !=3D &bpf_link_fops) {
+	if (f.file->f_op !=3D &bpf_link_fops && f.file->f_op !=3D &bpf_link_fop=
s_poll) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
@@ -4971,7 +4992,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_a=
ttr *attr,
 					     uattr);
 	else if (f.file->f_op =3D=3D &btf_fops)
 		err =3D bpf_btf_get_info_by_fd(f.file, f.file->private_data, attr, uat=
tr);
-	else if (f.file->f_op =3D=3D &bpf_link_fops)
+	else if (f.file->f_op =3D=3D &bpf_link_fops || f.file->f_op =3D=3D &bpf=
_link_fops_poll)
 		err =3D bpf_link_get_info_by_fd(f.file, f.file->private_data,
 					      attr, uattr);
 	else
@@ -5106,7 +5127,7 @@ static int bpf_task_fd_query(const union bpf_attr *=
attr,
 	if (!file)
 		return -EBADF;
=20
-	if (file->f_op =3D=3D &bpf_link_fops) {
+	if (file->f_op =3D=3D &bpf_link_fops || file->f_op =3D=3D &bpf_link_fop=
s_poll) {
 		struct bpf_link *link =3D file->private_data;
=20
 		if (link->ops =3D=3D &bpf_raw_tp_link_lops) {
--=20
2.43.0



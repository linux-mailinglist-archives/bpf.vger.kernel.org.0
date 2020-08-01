Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20123539B
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHARDr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 1 Aug 2020 13:03:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31270 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgHARDq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 13:03:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-wd18hiHtNvWXWlVFjiMekw-1; Sat, 01 Aug 2020 13:03:39 -0400
X-MC-Unique: wd18hiHtNvWXWlVFjiMekw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 561A7106B242;
        Sat,  1 Aug 2020 17:03:37 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FCA05F7D8;
        Sat,  1 Aug 2020 17:03:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 bpf-next 03/14] bpf: Move btf_resolve_size into __btf_resolve_size
Date:   Sat,  1 Aug 2020 19:03:11 +0200
Message-Id: <20200801170322.75218-4-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-1-jolsa@kernel.org>
References: <20200801170322.75218-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving btf_resolve_size into __btf_resolve_size and
keeping btf_resolve_size public with just first 3
arguments, because the rest of the arguments are not
used by outside callers.

Following changes are adding more arguments, which
are not useful to outside callers. They will be added
to the __btf_resolve_size function.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/btf.h         |  3 +--
 kernel/bpf/bpf_struct_ops.c |  6 ++----
 kernel/bpf/btf.c            | 21 ++++++++++++++-------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 8b81fbb4497c..a9af5e7a7ece 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -64,8 +64,7 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 						 u32 id, u32 *res_id);
 const struct btf_type *
 btf_resolve_size(const struct btf *btf, const struct btf_type *type,
-		 u32 *type_size, const struct btf_type **elem_type,
-		 u32 *total_nelems);
+		 u32 *type_size);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 969c5d47f81f..4c3b543bb33b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -298,8 +298,7 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 			return -EINVAL;
 
 		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize,
-					 NULL, NULL);
+		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -396,8 +395,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			u32 msize;
 
 			mtype = btf_type_by_id(btf_vmlinux, member->type);
-			mtype = btf_resolve_size(btf_vmlinux, mtype, &msize,
-						 NULL, NULL);
+			mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
 			if (IS_ERR(mtype)) {
 				err = PTR_ERR(mtype);
 				goto reset_unlock;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0fd6bb62be3a..3c14c9b6676c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1088,10 +1088,10 @@ static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
  * *elem_type: same as return type ("struct X")
  * *total_nelems: 1
  */
-const struct btf_type *
-btf_resolve_size(const struct btf *btf, const struct btf_type *type,
-		 u32 *type_size, const struct btf_type **elem_type,
-		 u32 *total_nelems)
+static const struct btf_type *
+__btf_resolve_size(const struct btf *btf, const struct btf_type *type,
+		   u32 *type_size, const struct btf_type **elem_type,
+		   u32 *total_nelems)
 {
 	const struct btf_type *array_type = NULL;
 	const struct btf_array *array;
@@ -1150,6 +1150,13 @@ btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 	return array_type ? : type;
 }
 
+const struct btf_type *
+btf_resolve_size(const struct btf *btf, const struct btf_type *type,
+		 u32 *type_size)
+{
+	return __btf_resolve_size(btf, type, type_size, NULL, NULL);
+}
+
 /* The input param "type_id" must point to a needs_resolve type */
 static const struct btf_type *btf_type_id_resolve(const struct btf *btf,
 						  u32 *type_id)
@@ -3976,8 +3983,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		mtype = btf_type_by_id(btf_vmlinux, member->type);
 		mname = __btf_name_by_offset(btf_vmlinux, member->name_off);
 
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize,
-					 &elem_type, &total_nelems);
+		mtype = __btf_resolve_size(btf_vmlinux, mtype, &msize,
+					   &elem_type, &total_nelems);
 		if (IS_ERR(mtype)) {
 			bpf_log(log, "field %s doesn't have size\n", mname);
 			return -EFAULT;
@@ -3991,7 +3998,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		if (btf_type_is_array(mtype)) {
 			u32 elem_idx;
 
-			/* btf_resolve_size() above helps to
+			/* __btf_resolve_size() above helps to
 			 * linearize a multi-dimensional array.
 			 *
 			 * The logic here is treating an array
-- 
2.25.4


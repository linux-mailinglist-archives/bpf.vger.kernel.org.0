Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0096B5552
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCJXIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCJXID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:08:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF331284B
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:08:01 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AMXIv1000609
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:08:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6ecJVaK+1eQJBBDoPmSlxZHIKPeCG7kiAXjXv6RS+bA=;
 b=EAZ1ZrsPoyWGEzcgcvJqoe0EEmhGo6uZfRm/tojejU0OkpRpEqAVPmI6Vm7rpNaruQ1B
 4ETUakG8KOLoR63R/dWbb/OvFgArdWHgN9S/OjGx0XhiNgsjV+naUDDWCopsa6TLyE5c
 jER2cuqOlzm7+UDUDBwzM44Dam1o0hQSBX8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p7sp5f4d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:08:00 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 15:07:58 -0800
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 15:07:58 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D04E81902A1FF; Fri, 10 Mar 2023 15:07:44 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 1/3] bpf: Support __kptr to local kptrs
Date:   Fri, 10 Mar 2023 15:07:41 -0800
Message-ID: <20230310230743.2320707-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310230743.2320707-1-davemarchevsky@fb.com>
References: <20230310230743.2320707-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zcAZX9K6Qv43ZssCK3n9YZ6TIEeeGRJH
X-Proofpoint-GUID: zcAZX9K6Qv43ZssCK3n9YZ6TIEeeGRJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If a PTR_TO_BTF_ID type comes from program BTF - not vmlinux or module
BTF - it must have been allocated by bpf_obj_new and therefore must be
free'd with bpf_obj_drop. Such a PTR_TO_BTF_ID is considered a "local
kptr" and is tagged with MEM_ALLOC type tag by bpf_obj_new.

This patch adds support for treating __kptr-tagged pointers to "local
kptrs" as having an implicit bpf_obj_drop destructor for referenced kptr
acquire / release semantics. Consider the following example:

  struct node_data {
          long key;
          long data;
          struct bpf_rb_node node;
  };

  struct map_value {
          struct node_data __kptr *node;
  };

  struct {
          __uint(type, BPF_MAP_TYPE_ARRAY);
          __type(key, int);
          __type(value, struct map_value);
          __uint(max_entries, 1);
  } some_nodes SEC(".maps");

If struct node_data had a matching definition in kernel BTF, the verifier=
 would
expect a destructor for the type to be registered. Since struct node_data=
 does
not match any type in kernel BTF, the verifier knows that there is no kfu=
nc
that provides a PTR_TO_BTF_ID to this type, and that such a PTR_TO_BTF_ID=
 can
only come from bpf_obj_new. So instead of searching for a registered dtor=
,
a bpf_obj_drop dtor can be assumed.

This allows the runtime to properly destruct such kptrs in
bpf_obj_free_fields, which enables maps to clean up map_vals w/ such
kptrs when going away.

Implementation notes:
  * "kernel_btf" variable is renamed to "kptr_btf" in btf_parse_kptr.
    Before this patch, the variable would only ever point to vmlinux or
    module BTFs, but now it can point to some program BTF for local kptr
    type. It's later used to populate the (btf, btf_id) pair in kptr btf
    field.
  * It's necessary to btf_get the program BTF when populating btf_field
    for local kptr. btf_record_free later does a btf_put.
  * Behavior for non-local referenced kptrs is not modified, as
    bpf_find_btf_id helper only searches vmlinux and module BTFs for
    matching BTF type. If such a type is found, btf_field_kptr's btf will
    pass btf_is_kernel check, and the associated release function is
    some one-argument dtor. If btf_is_kernel check fails, associated
    release function is two-arg bpf_obj_drop_impl. Before this patch
    only btf_field_kptr's w/ kernel or module BTFs were created.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  | 11 ++++++++++-
 include/linux/btf.h  |  2 --
 kernel/bpf/btf.c     | 37 ++++++++++++++++++++++++++++---------
 kernel/bpf/helpers.c | 11 ++++++++---
 kernel/bpf/syscall.c | 14 +++++++++++++-
 5 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3a38db315f7f..756b85f0d0d3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -189,10 +189,19 @@ enum btf_field_type {
 				 BPF_RB_NODE | BPF_RB_ROOT,
 };
=20
+typedef void (*btf_dtor_kfunc_t)(void *);
+typedef void (*btf_dtor_obj_drop)(void *, const struct btf_record *);
+
 struct btf_field_kptr {
 	struct btf *btf;
 	struct module *module;
-	btf_dtor_kfunc_t dtor;
+	union {
+		/* dtor used if btf_is_kernel(btf), otherwise the type
+		 * is program-allocated and obj_drop is used
+		 */
+		btf_dtor_kfunc_t dtor;
+		btf_dtor_obj_drop obj_drop;
+	};
 	u32 btf_id;
 };
=20
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bba0827e8c4..d53b10cc55f2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -121,8 +121,6 @@ struct btf_struct_metas {
 	struct btf_struct_meta types[];
 };
=20
-typedef void (*btf_dtor_kfunc_t)(void *);
-
 extern const struct file_operations btf_fops;
=20
 void btf_get(struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 37779ceefd09..66fad7a16b6c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3551,12 +3551,17 @@ static int btf_find_field(const struct btf *btf, =
const struct btf_type *t,
 	return -EINVAL;
 }
=20
+extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
+
 static int btf_parse_kptr(const struct btf *btf, struct btf_field *field=
,
 			  struct btf_field_info *info)
 {
 	struct module *mod =3D NULL;
 	const struct btf_type *t;
-	struct btf *kernel_btf;
+	/* If a matching btf type is found in kernel or module BTFs, kptr_ref
+	 * is that BTF, otherwise it's program BTF
+	 */
+	struct btf *kptr_btf;
 	int ret;
 	s32 id;
=20
@@ -3565,7 +3570,20 @@ static int btf_parse_kptr(const struct btf *btf, s=
truct btf_field *field,
 	 */
 	t =3D btf_type_by_id(btf, info->kptr.type_id);
 	id =3D bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO=
_KIND(t->info),
-			     &kernel_btf);
+			     &kptr_btf);
+	if (id =3D=3D -ENOENT) {
+		/* btf_parse_kptr should only be called w/ btf =3D program BTF */
+		WARN_ON_ONCE(btf_is_kernel(btf));
+
+		/* Type exists only in program BTF. Assume that it's a MEM_ALLOC
+		 * kptr allocated via bpf_obj_new
+		 */
+		field->kptr.dtor =3D (void *)&__bpf_obj_drop_impl;
+		id =3D info->kptr.type_id;
+		kptr_btf =3D (struct btf *)btf;
+		btf_get(kptr_btf);
+		goto found_dtor;
+	}
 	if (id < 0)
 		return id;
=20
@@ -3582,20 +3600,20 @@ static int btf_parse_kptr(const struct btf *btf, =
struct btf_field *field,
 		 * can be used as a referenced pointer and be stored in a map at
 		 * the same time.
 		 */
-		dtor_btf_id =3D btf_find_dtor_kfunc(kernel_btf, id);
+		dtor_btf_id =3D btf_find_dtor_kfunc(kptr_btf, id);
 		if (dtor_btf_id < 0) {
 			ret =3D dtor_btf_id;
 			goto end_btf;
 		}
=20
-		dtor_func =3D btf_type_by_id(kernel_btf, dtor_btf_id);
+		dtor_func =3D btf_type_by_id(kptr_btf, dtor_btf_id);
 		if (!dtor_func) {
 			ret =3D -ENOENT;
 			goto end_btf;
 		}
=20
-		if (btf_is_module(kernel_btf)) {
-			mod =3D btf_try_get_module(kernel_btf);
+		if (btf_is_module(kptr_btf)) {
+			mod =3D btf_try_get_module(kptr_btf);
 			if (!mod) {
 				ret =3D -ENXIO;
 				goto end_btf;
@@ -3605,7 +3623,7 @@ static int btf_parse_kptr(const struct btf *btf, st=
ruct btf_field *field,
 		/* We already verified dtor_func to be btf_type_is_func
 		 * in register_btf_id_dtor_kfuncs.
 		 */
-		dtor_func_name =3D __btf_name_by_offset(kernel_btf, dtor_func->name_of=
f);
+		dtor_func_name =3D __btf_name_by_offset(kptr_btf, dtor_func->name_off)=
;
 		addr =3D kallsyms_lookup_name(dtor_func_name);
 		if (!addr) {
 			ret =3D -EINVAL;
@@ -3614,14 +3632,15 @@ static int btf_parse_kptr(const struct btf *btf, =
struct btf_field *field,
 		field->kptr.dtor =3D (void *)addr;
 	}
=20
+found_dtor:
 	field->kptr.btf_id =3D id;
-	field->kptr.btf =3D kernel_btf;
+	field->kptr.btf =3D kptr_btf;
 	field->kptr.module =3D mod;
 	return 0;
 end_mod:
 	module_put(mod);
 end_btf:
-	btf_put(kernel_btf);
+	btf_put(kptr_btf);
 	return ret;
 }
=20
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f9b7eeedce08..77d64b6951b9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1896,14 +1896,19 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type=
_id__k, void *meta__ign)
 	return p;
 }
=20
+void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
+{
+	if (rec)
+		bpf_obj_free_fields(rec, p);
+	bpf_mem_free(&bpf_global_ma, p);
+}
+
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	struct btf_struct_meta *meta =3D meta__ign;
 	void *p =3D p__alloc;
=20
-	if (meta)
-		bpf_obj_free_fields(meta->record, p);
-	bpf_mem_free(&bpf_global_ma, p);
+	__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
 }
=20
 static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_h=
ead *head, bool tail)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cc4b7684910c..0684febc447a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -659,8 +659,10 @@ void bpf_obj_free_fields(const struct btf_record *re=
c, void *obj)
 		return;
 	fields =3D rec->fields;
 	for (i =3D 0; i < rec->cnt; i++) {
+		struct btf_struct_meta *pointee_struct_meta;
 		const struct btf_field *field =3D &fields[i];
 		void *field_ptr =3D obj + field->offset;
+		void *xchgd_field;
=20
 		switch (fields[i].type) {
 		case BPF_SPIN_LOCK:
@@ -672,7 +674,17 @@ void bpf_obj_free_fields(const struct btf_record *re=
c, void *obj)
 			WRITE_ONCE(*(u64 *)field_ptr, 0);
 			break;
 		case BPF_KPTR_REF:
-			field->kptr.dtor((void *)xchg((unsigned long *)field_ptr, 0));
+			xchgd_field =3D (void *)xchg((unsigned long *)field_ptr, 0);
+			if (!btf_is_kernel(field->kptr.btf)) {
+				pointee_struct_meta =3D btf_find_struct_meta(field->kptr.btf,
+									   field->kptr.btf_id);
+				WARN_ON_ONCE(!pointee_struct_meta);
+				field->kptr.obj_drop(xchgd_field, pointee_struct_meta ?
+								  pointee_struct_meta->record :
+								  NULL);
+			} else {
+				field->kptr.dtor(xchgd_field);
+			}
 			break;
 		case BPF_LIST_HEAD:
 			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
--=20
2.34.1


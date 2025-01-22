Return-Path: <bpf+bounces-49433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3AA18A48
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC64167B6E
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E814C5AF;
	Wed, 22 Jan 2025 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="di821fAX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9D13CFB6
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514415; cv=none; b=t0gnoyWmaxxMYwFCRGLFPyPDF9yiIr3XgLlqk+QJZBU8WSiOGI1KUDekfknZ5RA9qOi+YvI+VAFyoLxrsw2LbdHar9RMVYce6dwIZ5VssTVxIUjnrueNabB/l29eNeiWZ0PTiwSWbFDT6RzjfUk76NrqKhfNJtLb050n6DHjfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514415; c=relaxed/simple;
	bh=K78PwEMKHGH1xEPpxglpbEOeg34rQf4DIPq8Jly1wTQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahHD6XiTNgKkfZwUCbhobczM7HMZ1FJ68HGG5PUJS32Rkd+vJbBvykaJJ4gD6VdG7PmhPyKn0PPMI8abdlCcRmiCn3HqgpNjE0gaU7Qj09JneuZ+KVvfB389r1LIj7wYDgr6qkqGFJo/OzUan1PfVmhW4hMJpr6zFKdf2ZSF7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=di821fAX; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737514405; x=1737773605;
	bh=ehQylJxmOOi/PrgbsrYzpgzuz45BLfJ1pDuXytVtzVI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=di821fAX96Exgly4W7rRWSd9pnuh+/EsT0nIF9uSQaM+PtIYw6hgGBPP95TLop6T1
	 4BM0C1o1mqwOQdxH2cyZfoxcg+anFBPRGbxzrzHKFbBWxV+RkzLOpvDJ1Q95trnW0b
	 Rvcd9EOo99b4ISOtuXZwBG5R18oHK6L7zUgVci0ht6daWFo9Xx+J1KNsq006i7C1jX
	 bPLiR917xOoCvv5HeqH3777gmF1PiZTZ20+VccfLQxGhCA13ClM2y7pq/E7Ijhb1Jt
	 2UcPzqQrcRrfhH4Altfd+JJim3T8miZOL5Qleo3tOVC4m6VJBsXGAH4TVw53bYpPMO
	 TArQjvmBDkKDg==
Date: Wed, 22 Jan 2025 02:53:18 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next 1/5] libbpf: introduce kflag for type_tags and decl_tags in BTF
Message-ID: <20250122025308.2717553-2-ihor.solodrai@pm.me>
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 316ffcb5da094fd73942d92c79268c5345c00efb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add the following functions to libbpf API:
* btf__add_type_attr()
* btf__add_decl_attr()

These functions allow to add to BTF the type tags and decl tags with
info->kflag set to 1. The kflag indicates that the tag directly
encodes an __attribute__ and not a normal tag.

See Documentation/bpf/btf.rst changes for details on the semantics.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 Documentation/bpf/btf.rst      | 27 +++++++++--
 tools/include/uapi/linux/btf.h |  3 +-
 tools/lib/bpf/btf.c            | 87 +++++++++++++++++++++++++---------
 tools/lib/bpf/btf.h            |  3 ++
 tools/lib/bpf/libbpf.map       |  2 +
 5 files changed, 93 insertions(+), 29 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 2478cef758f8..615ded7b2442 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -102,8 +102,9 @@ Each type contains the following common data::
          * bits 24-28: kind (e.g. int, ptr, array...etc)
          * bits 29-30: unused
          * bit     31: kind_flag, currently used by
-         *             struct, union, fwd, enum and enum64.
-         */
+=09 *             struct, union, enum, fwd, enum64,
+=09 *             DECL_TAG and TYPE_TAG
+=09 */
         __u32 info;
         /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
          * "size" tells the size of the type it is describing.
@@ -478,7 +479,7 @@ No additional type data follow ``btf_type``.
=20
 ``struct btf_type`` encoding requirement:
  * ``name_off``: offset to a non-empty string
- * ``info.kind_flag``: 0
+ * ``info.kind_flag``: 0 or 1
  * ``info.kind``: BTF_KIND_DECL_TAG
  * ``info.vlen``: 0
  * ``type``: ``struct``, ``union``, ``func``, ``var`` or ``typedef``
@@ -489,7 +490,6 @@ No additional type data follow ``btf_type``.
         __u32   component_idx;
     };
=20
-The ``name_off`` encodes btf_decl_tag attribute string.
 The ``type`` should be ``struct``, ``union``, ``func``, ``var`` or ``typed=
ef``.
 For ``var`` or ``typedef`` type, ``btf_decl_tag.component_idx`` must be ``=
-1``.
 For the other three types, if the btf_decl_tag attribute is
@@ -499,12 +499,21 @@ the attribute is applied to a ``struct``/``union`` me=
mber or
 a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
 valid index (starting from 0) pointing to a member or an argument.
=20
+If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
+``name_off`` encodes btf_decl_tag attribute string.
+
+If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
+__attribute__. In this case, ``name_off`` encodes a string
+representing the attribute-list of the attribute specifier. For
+example, for an ``__attribute__((aligned(4)))`` the string's contents
+is ``aligned(4)``.
+
 2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
=20
 ``struct btf_type`` encoding requirement:
  * ``name_off``: offset to a non-empty string
- * ``info.kind_flag``: 0
+ * ``info.kind_flag``: 0 or 1
  * ``info.kind``: BTF_KIND_TYPE_TAG
  * ``info.vlen``: 0
  * ``type``: the type with ``btf_type_tag`` attribute
@@ -522,6 +531,14 @@ type_tag, then zero or more const/volatile/restrict/ty=
pedef
 and finally the base type. The base type is one of
 int, ptr, array, struct, union, enum, func_proto and float types.
=20
+Similarly to decl tags, if the ``info.kind_flag`` is 0, then this is a
+normal type tag, and the ``name_off`` encodes btf_type_tag attribute
+string.
+
+If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
+__attribute__, and the ``name_off`` encodes a string representing the
+attribute-list of the attribute specifier.
+
 2.2.19 BTF_KIND_ENUM64
 ~~~~~~~~~~~~~~~~~~~~~~
=20
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.=
h
index ec1798b6d3ff..d602c26a0c2a 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -36,7 +36,8 @@ struct btf_type {
 =09 * bits 24-28: kind (e.g. int, ptr, array...etc)
 =09 * bits 29-30: unused
 =09 * bit     31: kind_flag, currently used by
-=09 *             struct, union, enum, fwd and enum64
+=09 *             struct, union, enum, fwd, enum64,
+=09 *             DECL_TAG and TYPE_TAG
 =09 */
 =09__u32 info;
 =09/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 48c66f3a9200..df2808cee009 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2090,7 +2090,7 @@ static int validate_type_id(int id)
 }
=20
 /* generic append function for PTR, TYPEDEF, CONST/VOLATILE/RESTRICT */
-static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, i=
nt ref_type_id)
+static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, i=
nt ref_type_id, int kflag)
 {
 =09struct btf_type *t;
 =09int sz, name_off =3D 0;
@@ -2113,7 +2113,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind=
, const char *name, int ref
 =09}
=20
 =09t->name_off =3D name_off;
-=09t->info =3D btf_type_info(kind, 0, 0);
+=09t->info =3D btf_type_info(kind, 0, kflag);
 =09t->type =3D ref_type_id;
=20
 =09return btf_commit_type(btf, sz);
@@ -2128,7 +2128,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind=
, const char *name, int ref
  */
 int btf__add_ptr(struct btf *btf, int ref_type_id)
 {
-=09return btf_add_ref_kind(btf, BTF_KIND_PTR, NULL, ref_type_id);
+=09return btf_add_ref_kind(btf, BTF_KIND_PTR, NULL, ref_type_id, 0);
 }
=20
 /*
@@ -2506,7 +2506,7 @@ int btf__add_fwd(struct btf *btf, const char *name, e=
num btf_fwd_kind fwd_kind)
 =09=09struct btf_type *t;
 =09=09int id;
=20
-=09=09id =3D btf_add_ref_kind(btf, BTF_KIND_FWD, name, 0);
+=09=09id =3D btf_add_ref_kind(btf, BTF_KIND_FWD, name, 0, 0);
 =09=09if (id <=3D 0)
 =09=09=09return id;
 =09=09t =3D btf_type_by_id(btf, id);
@@ -2536,7 +2536,7 @@ int btf__add_typedef(struct btf *btf, const char *nam=
e, int ref_type_id)
 =09if (!name || !name[0])
 =09=09return libbpf_err(-EINVAL);
=20
-=09return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id);
+=09return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id, 0);
 }
=20
 /*
@@ -2548,7 +2548,7 @@ int btf__add_typedef(struct btf *btf, const char *nam=
e, int ref_type_id)
  */
 int btf__add_volatile(struct btf *btf, int ref_type_id)
 {
-=09return btf_add_ref_kind(btf, BTF_KIND_VOLATILE, NULL, ref_type_id);
+=09return btf_add_ref_kind(btf, BTF_KIND_VOLATILE, NULL, ref_type_id, 0);
 }
=20
 /*
@@ -2560,7 +2560,7 @@ int btf__add_volatile(struct btf *btf, int ref_type_i=
d)
  */
 int btf__add_const(struct btf *btf, int ref_type_id)
 {
-=09return btf_add_ref_kind(btf, BTF_KIND_CONST, NULL, ref_type_id);
+=09return btf_add_ref_kind(btf, BTF_KIND_CONST, NULL, ref_type_id, 0);
 }
=20
 /*
@@ -2572,7 +2572,7 @@ int btf__add_const(struct btf *btf, int ref_type_id)
  */
 int btf__add_restrict(struct btf *btf, int ref_type_id)
 {
-=09return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id);
+=09return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id, 0);
 }
=20
 /*
@@ -2588,7 +2588,24 @@ int btf__add_type_tag(struct btf *btf, const char *v=
alue, int ref_type_id)
 =09if (!value || !value[0])
 =09=09return libbpf_err(-EINVAL);
=20
-=09return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
+=09return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 0);
+}
+
+/*
+ * Append new BTF_KIND_TYPE_TAG type with:
+ *   - *value*, non-empty/non-NULL tag value;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ * Set info->kflag to 1, indicating this tag is an __attribute__
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id=
)
+{
+=09if (!value || !value[0])
+=09=09return libbpf_err(-EINVAL);
+
+=09return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 1);
 }
=20
 /*
@@ -2610,7 +2627,7 @@ int btf__add_func(struct btf *btf, const char *name,
 =09    linkage !=3D BTF_FUNC_EXTERN)
 =09=09return libbpf_err(-EINVAL);
=20
-=09id =3D btf_add_ref_kind(btf, BTF_KIND_FUNC, name, proto_type_id);
+=09id =3D btf_add_ref_kind(btf, BTF_KIND_FUNC, name, proto_type_id, 0);
 =09if (id > 0) {
 =09=09struct btf_type *t =3D btf_type_by_id(btf, id);
=20
@@ -2845,18 +2862,9 @@ int btf__add_datasec_var_info(struct btf *btf, int v=
ar_type_id, __u32 offset, __
 =09return 0;
 }
=20
-/*
- * Append new BTF_KIND_DECL_TAG type with:
- *   - *value* - non-empty/non-NULL string;
- *   - *ref_type_id* - referenced type ID, it might not exist yet;
- *   - *component_idx* - -1 for tagging reference type, otherwise struct/u=
nion
- *     member or function argument index;
- * Returns:
- *   - >0, type ID of newly added BTF type;
- *   - <0, on error.
- */
-int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
-=09=09 int component_idx)
+
+static int __btf__add_decl_tag(struct btf *btf, const char *value,
+=09=09 int ref_type_id, int component_idx, int kflag)
 {
 =09struct btf_type *t;
 =09int sz, value_off;
@@ -2880,13 +2888,46 @@ int btf__add_decl_tag(struct btf *btf, const char *=
value, int ref_type_id,
 =09=09return value_off;
=20
 =09t->name_off =3D value_off;
-=09t->info =3D btf_type_info(BTF_KIND_DECL_TAG, 0, false);
+=09t->info =3D btf_type_info(BTF_KIND_DECL_TAG, 0, kflag);
 =09t->type =3D ref_type_id;
 =09btf_decl_tag(t)->component_idx =3D component_idx;
=20
 =09return btf_commit_type(btf, sz);
 }
=20
+/*
+ * Append new BTF_KIND_DECL_TAG type with:
+ *   - *value* - non-empty/non-NULL string;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ *   - *component_idx* - -1 for tagging reference type, otherwise struct/u=
nion
+ *     member or function argument index;
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
+=09=09 int component_idx)
+{
+=09return __btf__add_decl_tag(btf, value, ref_type_id, component_idx, 0);
+}
+
+/*
+ * Append new BTF_KIND_DECL_TAG type with:
+ *   - *value* - non-empty/non-NULL string;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ *   - *component_idx* - -1 for tagging reference type, otherwise struct/u=
nion
+ *     member or function argument index;
+ * Set info->kflag to 1, indicating this tag is an __attribute__
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id=
,
+=09=09 int component_idx)
+{
+=09return __btf__add_decl_tag(btf, value, ref_type_id, component_idx, 1);
+}
+
 struct btf_ext_sec_info_param {
 =09__u32 off;
 =09__u32 len;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 47ee8f6ac489..1c969a530a3e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -227,6 +227,7 @@ LIBBPF_API int btf__add_volatile(struct btf *btf, int r=
ef_type_id);
 LIBBPF_API int btf__add_const(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_restrict(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_type_tag(struct btf *btf, const char *value, int r=
ef_type_id);
+LIBBPF_API int btf__add_type_attr(struct btf *btf, const char *value, int =
ref_type_id);
=20
 /* func and func_proto construction APIs */
 LIBBPF_API int btf__add_func(struct btf *btf, const char *name,
@@ -243,6 +244,8 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *bt=
f, int var_type_id,
 /* tag construction API */
 LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int r=
ef_type_id,
 =09=09=09    int component_idx);
+LIBBPF_API int btf__add_decl_attr(struct btf *btf, const char *value, int =
ref_type_id,
+=09=09=09    int component_idx);
=20
 struct btf_dedup_opts {
 =09size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a8b2936a1646..8616e10b3c1b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,4 +436,6 @@ LIBBPF_1.6.0 {
 =09=09bpf_linker__add_buf;
 =09=09bpf_linker__add_fd;
 =09=09bpf_linker__new_fd;
+                btf__add_decl_attr;
+                btf__add_type_attr;
 } LIBBPF_1.5.0;
--=20
2.48.1




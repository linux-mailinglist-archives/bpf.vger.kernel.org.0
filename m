Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2253C311
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 04:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiFCB7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiFCB7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 21:59:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67739696
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 18:59:45 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2530r4Fn026169
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 18:59:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SKPu4rmu+wyqxiXtQ7nmLW7YwXudWrUCn9scGFAUG1I=;
 b=ksekO2BEi8Q85wtXhM/jOGfMdSuTjKdsFZeCHc3LqLFapJVkg7qFgGSU9oI/b6RaDuBu
 jDcZNd6Wnj4K/DC/1RPy8cduDjBh/R2Au951VbVm/BcS7ARm+kNjSOr5NfQkvG3iyM4H
 MRy0v8Vu5V7QlI0I8rdRJGKXR+Ke4MLneOE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge144wvqu-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 18:59:44 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 18:59:40 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3C77DB299F89; Thu,  2 Jun 2022 18:59:37 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 08/18] libbpf: Add enum64 sanitization
Date:   Thu, 2 Jun 2022 18:59:37 -0700
Message-ID: <20220603015937.1190992-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603015855.1187538-1-yhs@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -EJ0LDcg_GAveK7j1kVF_RrSnm-4gAWi
X-Proofpoint-ORIG-GUID: -EJ0LDcg_GAveK7j1kVF_RrSnm-4gAWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When old kernel does not support enum64 but user space btf
contains non-zero enum kflag or enum64, libbpf needs to
do proper sanitization so modified btf can be accepted
by the kernel.

Sanitization for enum kflag can be achieved by clearing
the kflag bit. For enum64, the type is replaced with an
union of integer member types and the integer member size
must be smaller than enum64 size. If such an integer
type cannot be found, a new type is created and used
for union members.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.h             |  3 +-
 tools/lib/bpf/libbpf.c          | 56 ++++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index dcb3f575a281..83312c34007a 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -395,9 +395,10 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 i=
d,
 #ifndef BTF_KIND_FLOAT
 #define BTF_KIND_FLOAT		16	/* Floating point	*/
 #endif
-/* The kernel header switched to enums, so these two were never #defined=
 */
+/* The kernel header switched to enums, so the following were never #def=
ined */
 #define BTF_KIND_DECL_TAG	17	/* Decl Tag */
 #define BTF_KIND_TYPE_TAG	18	/* Type Tag */
+#define BTF_KIND_ENUM64		19	/* Enum for up-to 64bit values */
=20
 static inline __u16 btf_kind(const struct btf_type *t)
 {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5afe4cbd684f..c4e3e2355a53 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2242,6 +2242,7 @@ static const char *__btf_kind_str(__u16 kind)
 	case BTF_KIND_FLOAT: return "float";
 	case BTF_KIND_DECL_TAG: return "decl_tag";
 	case BTF_KIND_TYPE_TAG: return "type_tag";
+	case BTF_KIND_ENUM64: return "enum64";
 	default: return "unknown";
 	}
 }
@@ -2770,12 +2771,13 @@ static bool btf_needs_sanitization(struct bpf_obj=
ect *obj)
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
+	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
=20
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag;
+	       !has_decl_tag || !has_type_tag || !has_enum64;
 }
=20
-static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*btf)
+static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *=
btf)
 {
 	bool has_func_global =3D kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
@@ -2783,6 +2785,8 @@ static void bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
+	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
+	__u32 enum64_placeholder_id =3D 0;
 	struct btf_type *t;
 	int i, j, vlen;
=20
@@ -2845,8 +2849,32 @@ static void bpf_object__sanitize_btf(struct bpf_ob=
ject *obj, struct btf *btf)
 			/* replace TYPE_TAG with a CONST */
 			t->name_off =3D 0;
 			t->info =3D BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
-		}
+		} else if (!has_enum64 && btf_is_enum(t)) {
+			/* clear the kflag */
+			t->info =3D btf_type_info(btf_kind(t), btf_vlen(t), false);
+		} else if (!has_enum64 && btf_is_enum64(t)) {
+			/* replace ENUM64 with a union */
+			struct btf_member *m;
+
+			if (enum64_placeholder_id =3D=3D 0) {
+				enum64_placeholder_id =3D btf__add_int(btf, "enum64_placeholder", 1,=
 0);
+				if (enum64_placeholder_id < 0)
+					return enum64_placeholder_id;
+
+				t =3D (struct btf_type *)btf__type_by_id(btf, i);
+			}
+
+			m =3D btf_members(t);
+			vlen =3D btf_vlen(t);
+			t->info =3D BTF_INFO_ENC(BTF_KIND_UNION, 0, vlen);
+			for (j =3D 0; j < vlen; j++, m++) {
+				m->type =3D enum64_placeholder_id;
+				m->offset =3D 0;
+			}
+                }
 	}
+
+	return 0;
 }
=20
 static bool libbpf_needs_btf(const struct bpf_object *obj)
@@ -3184,7 +3212,9 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
=20
 		/* enforce 8-byte pointers for BPF-targeted BTFs */
 		btf__set_pointer_size(obj->btf, 8);
-		bpf_object__sanitize_btf(obj, kern_btf);
+		err =3D bpf_object__sanitize_btf(obj, kern_btf);
+		if (err)
+			return err;
 	}
=20
 	if (obj->gen_loader) {
@@ -3691,6 +3721,10 @@ static enum kcfg_type find_kcfg_type(const struct =
btf *btf, int id,
 		if (strcmp(name, "libbpf_tristate"))
 			return KCFG_UNKNOWN;
 		return KCFG_TRISTATE;
+	case BTF_KIND_ENUM64:
+		if (strcmp(name, "libbpf_tristate"))
+			return KCFG_UNKNOWN;
+		return KCFG_TRISTATE;
 	case BTF_KIND_ARRAY:
 		if (btf_array(t)->nelems =3D=3D 0)
 			return KCFG_UNKNOWN;
@@ -4874,6 +4908,17 @@ static int probe_kern_bpf_cookie(void)
 	return probe_fd(ret);
 }
=20
+static int probe_kern_btf_enum64(void)
+{
+	static const char strs[] =3D "\0enum64";
+	__u32 types[] =3D {
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN =3D 0,
 	FEAT_SUPPORTED =3D 1,
@@ -4939,6 +4984,9 @@ static struct kern_feature_desc {
 	[FEAT_BPF_COOKIE] =3D {
 		"BPF cookie support", probe_kern_bpf_cookie,
 	},
+	[FEAT_BTF_ENUM64] =3D {
+		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
+	},
 };
=20
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 4abdbe2fea9d..10c16acfa8ae 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -351,6 +351,8 @@ enum kern_feature_id {
 	FEAT_MEMCG_ACCOUNT,
 	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
 	FEAT_BPF_COOKIE,
+	/* BTF_KIND_ENUM64 support and BTF_KIND_ENUM kflag support */
+	FEAT_BTF_ENUM64,
 	__FEAT_CNT,
 };
=20
--=20
2.30.2


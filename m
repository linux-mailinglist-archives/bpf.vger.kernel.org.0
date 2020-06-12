Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F11F7EEB
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLWeo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:34:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35262 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgFLWen (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 18:34:43 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CMYRXM012048
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QJ/KW2gD5FKYSIhUXtIOENoaEziJwTQ/8FJ/lfqrfvQ=;
 b=TZLdegdWvo0chrWzPXFJFL64GwGpdxhktECAUzBYMTsYK27tzoLuOph6xI4viPmw1N7/
 WtjRKvp4YDwybL86qhJX1GbL8zFPU3oyyLTkqvLjRJH3JXF7qQAX87U/AGHJhbs8TwNg
 TrhDcFaZ/RLBBYp6lDwZ2poZLdHPvNEApbU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31k6s3kp35-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:42 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 15:34:40 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 6A9742EC1D0B; Fri, 12 Jun 2020 15:32:02 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next 2/8] libbpf: add support for extracting kernel symbol addresses
Date:   Fri, 12 Jun 2020 15:31:44 -0700
Message-ID: <20200612223150.1177182-3-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200612223150.1177182-1-andriin@fb.com>
References: <20200612223150.1177182-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=8 malwarescore=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120168
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for another (in addition to existing Kconfig) special kind of
externs in BPF code, kernel symbol externs. Such externs allow BPF code t=
o
"know" kernel symbol address and either use it for comparisons with kerne=
l
data structures (e.g., struct file's f_op pointer, to distinguish differe=
nt
kinds of file), or, with the help of bpf_probe_user_kernel(), to follow
pointers and read data from global variables. Kernel symbol addresses are
found through /proc/kallsyms, which should be present in the system.

Currently, such kernel symbol variables are typeless: they have to be def=
ined
as `extern const void <symbol>` and the only operation you can do (in C c=
ode)
with them is to take its address. Such extern should reside in a special
section '.ksyms'. bpf_helpers.h header provides __ksym macro for this. St=
rong
vs weak semantics stays the same as with Kconfig externs. If symbol is no=
t
found in /proc/kallsyms, this will be a failure for strong (non-weak) ext=
ern,
but will be defaulted to 0 for weak externs.

If the same symbol is defined multiple times in /proc/kallsyms, then it w=
ill
be error if any of the associated addresses differs. In that case, addres=
s is
ambiguous, so libbpf falls on the side of caution, rather than confusing =
user
with randomly chosen address.

In the future, once kernel is extended with variables BTF information, su=
ch
ksym externs will be supported in a typed version, which will allow BPF
program to read variable's contents directly, similarly to how it's done =
for
fentry/fexit input arguments.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/bpf_helpers.h |   1 +
 tools/lib/bpf/btf.h         |   5 ++
 tools/lib/bpf/libbpf.c      | 138 ++++++++++++++++++++++++++++++++++--
 3 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index f67dce2af802..a510d8ed716f 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -75,5 +75,6 @@ enum libbpf_tristate {
 };
=20
 #define __kconfig __attribute__((section(".kconfig")))
+#define __ksym __attribute__((section(".ksyms")))
=20
 #endif
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 70c1b7ec2bd0..06cd1731c154 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -168,6 +168,11 @@ static inline bool btf_kflag(const struct btf_type *=
t)
 	return BTF_INFO_KFLAG(t->info);
 }
=20
+static inline bool btf_is_void(const struct btf_type *t)
+{
+	return btf_kind(t) =3D=3D BTF_KIND_UNKN;
+}
+
 static inline bool btf_is_int(const struct btf_type *t)
 {
 	return btf_kind(t) =3D=3D BTF_KIND_INT;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b1a36c965fc0..451fb0b5615b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -285,6 +285,7 @@ struct bpf_struct_ops {
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
 #define KCONFIG_SEC ".kconfig"
+#define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
=20
 enum libbpf_map_type {
@@ -329,6 +330,7 @@ struct bpf_map {
=20
 enum extern_type {
 	EXT_UNKNOWN,
+	EXT_KSYM,
 	EXT_KCFG,
 };
=20
@@ -357,6 +359,9 @@ struct extern_desc {
 			int data_off;
 			bool is_signed;
 		} kcfg;
+		struct {
+			unsigned long addr;
+		} ksym;
 	};
 };
=20
@@ -2812,9 +2817,25 @@ static int cmp_externs(const void *_a, const void =
*_b)
 	return strcmp(a->name, b->name);
 }
=20
+static int find_int_btf_id(const struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, n;
+
+	n =3D btf__get_nr_types(btf);
+	for (i =3D 1; i <=3D n; i++) {
+		t =3D btf__type_by_id(btf, i);
+
+		if (btf_is_int(t) && btf_int_bits(t) =3D=3D 32)
+			return i;
+	}
+
+	return 0;
+}
+
 static int bpf_object__collect_externs(struct bpf_object *obj)
 {
-	struct btf_type *sec, *kcfg_sec =3D NULL;
+	struct btf_type *sec, *kcfg_sec =3D NULL, *ksym_sec =3D NULL;
 	const struct btf_type *t;
 	struct extern_desc *ext;
 	int i, n, off;
@@ -2895,6 +2916,17 @@ static int bpf_object__collect_externs(struct bpf_=
object *obj)
 				pr_warn("kconfig extern '%s' type is unsupported\n", ext_name);
 				return -ENOTSUP;
 			}
+		} else if (strcmp(sec_name, KSYMS_SEC) =3D=3D 0) {
+			const struct btf_type *vt;
+
+			ksym_sec =3D sec;
+			ext->type =3D EXT_KSYM;
+
+			vt =3D skip_mods_and_typedefs(obj->btf, t->type, NULL);
+			if (!btf_is_void(vt)) {
+				pr_warn("ksym extern '%s' is not typeless (void)\n", ext_name);
+				return -ENOTSUP;
+			}
 		} else {
 			pr_warn("unrecognized extern section '%s'\n", sec_name);
 			return -ENOTSUP;
@@ -2908,6 +2940,43 @@ static int bpf_object__collect_externs(struct bpf_=
object *obj)
 	/* sort externs by type, for kcfg ones also by (align, size, name) */
 	qsort(obj->externs, obj->nr_extern, sizeof(*ext), cmp_externs);
=20
+	/* for .ksyms section, we need to turn all externs into allocated
+	 * variables in BTF to pass kernel verification; we do this by
+	 * pretending that each extern is a 8-byte variable
+	 */
+	if (ksym_sec) {
+		/* find existing 4-byte integer type in BTF to use for fake
+		 * extern variables in DATASEC
+		 */
+		int int_btf_id =3D find_int_btf_id(obj->btf);
+
+		for (i =3D 0; i < n; i++) {
+			pr_debug("extern #%d (ksym): symbol %d, name %s\n",
+				 i, ext->sym_idx, ext->name);
+		}
+
+		sec =3D ksym_sec;
+		n =3D btf_vlen(sec);
+		for (i =3D 0, off =3D 0; i < n; i++, off +=3D sizeof(int)) {
+			struct btf_var_secinfo *vs =3D btf_var_secinfos(sec) + i;
+			struct btf_type *vt;
+
+			vt =3D (void *)btf__type_by_id(obj->btf, vs->type);
+			ext_name =3D btf__name_by_offset(obj->btf, vt->name_off);
+			ext =3D find_extern_by_name(obj, ext_name);
+			if (!ext) {
+				pr_warn("failed to find extern definition for BTF var '%s'\n",
+					ext_name);
+				return -ESRCH;
+			}
+			btf_var(vt)->linkage =3D BTF_VAR_GLOBAL_ALLOCATED;
+			vt->type =3D int_btf_id;
+			vs->offset =3D off;
+			vs->size =3D sizeof(int);
+		}
+		sec->size =3D off;
+	}
+
 	if (kcfg_sec) {
 		sec =3D kcfg_sec;
 		/* for kcfg externs calculate their offsets within a .kconfig map */
@@ -5009,9 +5078,14 @@ bpf_program__relocate(struct bpf_program *prog, st=
ruct bpf_object *obj)
 			break;
 		case RELO_EXTERN:
 			ext =3D &obj->externs[relo->sym_off];
-			insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
-			insn[0].imm =3D obj->maps[obj->kconfig_map_idx].fd;
-			insn[1].imm =3D ext->kcfg.data_off;
+			if (ext->type =3D=3D EXT_KCFG) {
+				insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
+				insn[0].imm =3D obj->maps[obj->kconfig_map_idx].fd;
+				insn[1].imm =3D ext->kcfg.data_off;
+			} else /* EXT_KSYM */ {
+				insn[0].imm =3D (__u32)ext->ksym.addr;
+				insn[1].imm =3D ext->ksym.addr >> 32;
+			}
 			break;
 		case RELO_CALL:
 			err =3D bpf_program__reloc_text(prog, obj, relo);
@@ -5630,10 +5704,57 @@ static int bpf_object__sanitize_maps(struct bpf_o=
bject *obj)
 	return 0;
 }
=20
+static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
+{
+	char sym_type, sym_name[256];
+	unsigned long sym_addr;
+	struct extern_desc *ext;
+	int ret, err =3D 0;
+	FILE *f;
+
+	f =3D fopen("/proc/kallsyms", "r");
+	if (!f) {
+		err =3D -errno;
+		pr_warn("failed to open /proc/kallsyms: %d\n", err);
+		return err;
+	}
+
+	while (true) {
+		ret =3D fscanf(f, "%lx %c %s%*[^\n]\n",
+			     &sym_addr, &sym_type, sym_name);
+		if (ret =3D=3D EOF && feof(f))
+			break;
+		if (ret !=3D 3) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		ext =3D find_extern_by_name(obj, sym_name);
+		if (!ext || ext->type !=3D EXT_KSYM)
+			continue;
+
+		if (ext->is_set && ext->ksym.addr !=3D sym_addr) {
+			pr_warn("ksym extern '%s' resolution is ambiguous: 0x%lx or 0x%lx\n",
+				sym_name, ext->ksym.addr, sym_addr);
+			err =3D -EINVAL;
+			goto out;
+		}
+		if (!ext->is_set) {
+			ext->is_set =3D true;
+			ext->ksym.addr =3D sym_addr;
+			pr_debug("ksym extern %s=3D0x%lx\n", sym_name, sym_addr);
+		}
+	}
+
+out:
+	fclose(f);
+	return err;
+}
+
 static int bpf_object__resolve_externs(struct bpf_object *obj,
 				       const char *extra_kconfig)
 {
-	bool need_config =3D false;
+	bool need_config =3D false, need_kallsyms =3D false;
 	struct extern_desc *ext;
 	void *kcfg_data;
 	int err, i;
@@ -5663,6 +5784,8 @@ static int bpf_object__resolve_externs(struct bpf_o=
bject *obj,
 		} else if (ext->type =3D=3D EXT_KCFG &&
 			   strncmp(ext->name, "CONFIG_", 7) =3D=3D 0) {
 			need_config =3D true;
+		} else if (ext->type =3D=3D EXT_KSYM) {
+			need_kallsyms =3D true;
 		} else {
 			pr_warn("unrecognized extern '%s'\n", ext->name);
 			return -EINVAL;
@@ -5686,6 +5809,11 @@ static int bpf_object__resolve_externs(struct bpf_=
object *obj,
 		if (err)
 			return -EINVAL;
 	}
+	if (need_kallsyms) {
+		err =3D bpf_object__read_kallsyms_file(obj);
+		if (err)
+			return -EINVAL;
+	}
 	for (i =3D 0; i < obj->nr_extern; i++) {
 		ext =3D &obj->externs[i];
=20
--=20
2.24.1


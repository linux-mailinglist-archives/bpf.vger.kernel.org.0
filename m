Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF742201CEF
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392160AbgFSVMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:12:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392091AbgFSVMU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 17:12:20 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JKxuwc019892
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9lriCkqDcJaIFP3ka01msp0xfpHAWMWzXjhlUxEjJfY=;
 b=OyOZcCq/V6pUcf/zbnotSuN20z4mCstyUhA129t7eaD0r7RV60UhveX8ILD4615mTfoI
 wgGJNBxhY21bo+++cg15mPaqEULVrEoeyUq3ZvcBSOZj6raRKPNTXdxtjmEMpxmNSb1Q
 zaPoKSU5c5mh8lnFAdBMoQFyM0Nl6UPc5rc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q6616nm6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:18 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:12:16 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id A43AF3700BAE; Fri, 19 Jun 2020 14:12:14 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 3/5] bpf: Support access to bpf map fields
Date:   Fri, 19 Jun 2020 14:11:43 -0700
Message-ID: <6479686a0cd1e9067993df57b4c3eef0e276fec9.1592600985.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=38
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are multiple use-cases when it's convenient to have access to bpf
map fields, both `struct bpf_map` and map type specific struct-s such as
`struct bpf_array`, `struct bpf_htab`, etc.

For example while working with sock arrays it can be necessary to
calculate the key based on map->max_entries (some_hash % max_entries).
Currently this is solved by communicating max_entries via "out-of-band"
channel, e.g. via additional map with known key to get info about target
map. That works, but is not very convenient and error-prone while
working with many maps.

In other cases necessary data is dynamic (i.e. unknown at loading time)
and it's impossible to get it at all. For example while working with a
hash table it can be convenient to know how much capacity is already
used (bpf_htab.count.counter for BPF_F_NO_PREALLOC case).

At the same time kernel knows this info and can provide it to bpf
program.

Fill this gap by adding support to access bpf map fields from bpf
program for both `struct bpf_map` and map type specific fields.

Support is implemented via btf_struct_access() so that a user can define
their own `struct bpf_map` or map type specific struct in their program
with only necessary fields and preserve_access_index attribute, cast a
map to this struct and use a field.

For example:

	struct bpf_map {
		__u32 max_entries;
	} __attribute__((preserve_access_index));

	struct bpf_array {
		struct bpf_map map;
		__u32 elem_size;
	} __attribute__((preserve_access_index));

	struct {
		__uint(type, BPF_MAP_TYPE_ARRAY);
		__uint(max_entries, 4);
		__type(key, __u32);
		__type(value, __u32);
	} m_array SEC(".maps");

	SEC("cgroup_skb/egress")
	int cg_skb(void *ctx)
	{
		struct bpf_array *array =3D (struct bpf_array *)&m_array;
		struct bpf_map *map =3D (struct bpf_map *)&m_array;

		/* .. use map->max_entries or array->map.max_entries .. */
	}

Similarly to other btf_struct_access() use-cases (e.g. struct tcp_sock
in net/ipv4/bpf_tcp_ca.c) the patch allows access to any fields of
corresponding struct. Only reading from map fields is supported.

For btf_struct_access() to work there should be a way to know btf id of
a struct that corresponds to a map type. To get btf id there should be a
way to get a stringified name of map-specific struct, such as
"bpf_array", "bpf_htab", etc for a map type. Two new fields are added to
`struct bpf_map_ops` to handle it:
* .map_btf_name keeps a btf name of a struct returned by map_alloc();
* .map_btf_id is used to cache btf id of that struct.

To make btf ids calculation cheaper they're calculated once while
preparing btf_vmlinux and cached same way as it's done for btf_id field
of `struct bpf_func_proto`

While calculating btf ids, struct names are NOT checked for collision.
Collisions will be checked as a part of the work to prepare btf ids used
in verifier in compile time that should land soon. The only known
collision for `struct bpf_htab` (kernel/bpf/hashtab.c vs
net/core/sock_map.c) was fixed earlier.

Both new fields .map_btf_name and .map_btf_id must be set for a map type
for the feature to work. If neither is set for a map type, verifier will
return ENOTSUPP on a try to access map_ptr of corresponding type. If
just one of them set, it's verifier misconfiguration.

Only `struct bpf_array` for BPF_MAP_TYPE_ARRAY and `struct bpf_htab` for
BPF_MAP_TYPE_HASH are supported by this patch. Other map types will be
supported separately.

The feature is available only for CONFIG_DEBUG_INFO_BTF=3Dy and gated by
perfmon_capable() so that unpriv programs won't have access to bpf map
fields.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/linux/bpf.h                           |  9 ++
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/arraymap.c                         |  3 +
 kernel/bpf/btf.c                              | 40 +++++++++
 kernel/bpf/hashtab.c                          |  3 +
 kernel/bpf/verifier.c                         | 82 +++++++++++++++++--
 .../selftests/bpf/verifier/map_ptr_mixing.c   |  2 +-
 7 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 07052d44bca1..1e1501ee53ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -92,6 +92,10 @@ struct bpf_map_ops {
 	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
+
+	/* BTF name and id of struct allocated by map_alloc */
+	const char * const map_btf_name;
+	int *map_btf_id;
 };
=20
 struct bpf_map_memory {
@@ -1109,6 +1113,11 @@ static inline bool bpf_allow_ptr_leaks(void)
 	return perfmon_capable();
 }
=20
+static inline bool bpf_allow_ptr_to_map_access(void)
+{
+	return perfmon_capable();
+}
+
 static inline bool bpf_bypass_spec_v1(void)
 {
 	return perfmon_capable();
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ca08db4ffb5f..53c7bd568c5d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -379,6 +379,7 @@ struct bpf_verifier_env {
 	u32 used_map_cnt;		/* number of used maps */
 	u32 id_gen;			/* used to generate unique reg IDs */
 	bool allow_ptr_leaks;
+	bool allow_ptr_to_map_access;
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 11584618e861..e7caa48812fb 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -494,6 +494,7 @@ static int array_map_mmap(struct bpf_map *map, struct=
 vm_area_struct *vma)
 				   vma->vm_pgoff + pgoff);
 }
=20
+static int array_map_btf_id;
 const struct bpf_map_ops array_map_ops =3D {
 	.map_alloc_check =3D array_map_alloc_check,
 	.map_alloc =3D array_map_alloc,
@@ -510,6 +511,8 @@ const struct bpf_map_ops array_map_ops =3D {
 	.map_check_btf =3D array_map_check_btf,
 	.map_lookup_batch =3D generic_map_lookup_batch,
 	.map_update_batch =3D generic_map_update_batch,
+	.map_btf_name =3D "bpf_array",
+	.map_btf_id =3D &array_map_btf_id,
 };
=20
 const struct bpf_map_ops percpu_array_map_ops =3D {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3eb804618a53..e377d1981730 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3571,6 +3571,41 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log=
, struct btf *btf,
 	return ctx_type;
 }
=20
+static const struct bpf_map_ops * const btf_vmlinux_map_ops[] =3D {
+#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
+#define BPF_LINK_TYPE(_id, _name)
+#define BPF_MAP_TYPE(_id, _ops) \
+	[_id] =3D &_ops,
+#include <linux/bpf_types.h>
+#undef BPF_PROG_TYPE
+#undef BPF_LINK_TYPE
+#undef BPF_MAP_TYPE
+};
+
+static int btf_vmlinux_map_ids_init(const struct btf *btf,
+				    struct bpf_verifier_log *log)
+{
+	const struct bpf_map_ops *ops;
+	int i, btf_id;
+
+	for (i =3D 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
+		ops =3D btf_vmlinux_map_ops[i];
+		if (!ops || (!ops->map_btf_name && !ops->map_btf_id))
+			continue;
+		if (!ops->map_btf_name || !ops->map_btf_id) {
+			bpf_log(log, "map type %d is misconfigured\n", i);
+			return -EINVAL;
+		}
+		btf_id =3D btf_find_by_name_kind(btf, ops->map_btf_name,
+					       BTF_KIND_STRUCT);
+		if (btf_id < 0)
+			return btf_id;
+		*ops->map_btf_id =3D btf_id;
+	}
+
+	return 0;
+}
+
 static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 				     struct btf *btf,
 				     const struct btf_type *t,
@@ -3633,6 +3668,11 @@ struct btf *btf_parse_vmlinux(void)
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t =3D btf_type_by_id(btf, btf_id);
=20
+	/* find bpf map structs for map_ptr access checking */
+	err =3D btf_vmlinux_map_ids_init(btf, log);
+	if (err < 0)
+		goto errout;
+
 	bpf_struct_ops_init(btf, log);
=20
 	btf_verifier_env_free(env);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b4b288a3c3c9..2c5999e02060 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1614,6 +1614,7 @@ htab_lru_map_lookup_and_delete_batch(struct bpf_map=
 *map,
 						  true, false);
 }
=20
+static int htab_map_btf_id;
 const struct bpf_map_ops htab_map_ops =3D {
 	.map_alloc_check =3D htab_map_alloc_check,
 	.map_alloc =3D htab_map_alloc,
@@ -1625,6 +1626,8 @@ const struct bpf_map_ops htab_map_ops =3D {
 	.map_gen_lookup =3D htab_map_gen_lookup,
 	.map_seq_show_elem =3D htab_map_seq_show_elem,
 	BATCH_OPS(htab),
+	.map_btf_name =3D "bpf_htab",
+	.map_btf_id =3D &htab_map_btf_id,
 };
=20
 const struct bpf_map_ops htab_lru_map_ops =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 34cde841ab68..20e0637679a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1351,6 +1351,19 @@ static void mark_reg_not_init(struct bpf_verifier_=
env *env,
 	__mark_reg_not_init(env, regs + regno);
 }
=20
+static void mark_btf_ld_reg(struct bpf_verifier_env *env,
+			    struct bpf_reg_state *regs, u32 regno,
+			    enum bpf_reg_type reg_type, u32 btf_id)
+{
+	if (reg_type =3D=3D SCALAR_VALUE) {
+		mark_reg_unknown(env, regs, regno);
+		return;
+	}
+	mark_reg_known_zero(env, regs, regno);
+	regs[regno].type =3D PTR_TO_BTF_ID;
+	regs[regno].btf_id =3D btf_id;
+}
+
 #define DEF_NOT_SUBREG	(0)
 static void init_reg_state(struct bpf_verifier_env *env,
 			   struct bpf_func_state *state)
@@ -3182,19 +3195,68 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
 	if (ret < 0)
 		return ret;
=20
-	if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
-		if (ret =3D=3D SCALAR_VALUE) {
-			mark_reg_unknown(env, regs, value_regno);
-			return 0;
-		}
-		mark_reg_known_zero(env, regs, value_regno);
-		regs[value_regno].type =3D PTR_TO_BTF_ID;
-		regs[value_regno].btf_id =3D btf_id;
+	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
+		mark_btf_ld_reg(env, regs, value_regno, ret, btf_id);
+
+	return 0;
+}
+
+static int check_ptr_to_map_access(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *regs,
+				   int regno, int off, int size,
+				   enum bpf_access_type atype,
+				   int value_regno)
+{
+	struct bpf_reg_state *reg =3D regs + regno;
+	struct bpf_map *map =3D reg->map_ptr;
+	const struct btf_type *t;
+	const char *tname;
+	u32 btf_id;
+	int ret;
+
+	if (!btf_vmlinux) {
+		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_B=
TF\n");
+		return -ENOTSUPP;
+	}
+
+	if (!map->ops->map_btf_id || !*map->ops->map_btf_id) {
+		verbose(env, "map_ptr access not supported for map type %d\n",
+			map->map_type);
+		return -ENOTSUPP;
+	}
+
+	t =3D btf_type_by_id(btf_vmlinux, *map->ops->map_btf_id);
+	tname =3D btf_name_by_offset(btf_vmlinux, t->name_off);
+
+	if (!env->allow_ptr_to_map_access) {
+		verbose(env,
+			"%s access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+			tname);
+		return -EPERM;
 	}
=20
+	if (off < 0) {
+		verbose(env, "R%d is %s invalid negative access: off=3D%d\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
+	if (atype !=3D BPF_READ) {
+		verbose(env, "only read from %s is supported\n", tname);
+		return -EACCES;
+	}
+
+	ret =3D btf_struct_access(&env->log, t, off, size, atype, &btf_id);
+	if (ret < 0)
+		return ret;
+
+	if (value_regno >=3D 0)
+		mark_btf_ld_reg(env, regs, value_regno, ret, btf_id);
+
 	return 0;
 }
=20
+
 /* check whether memory at (regno + off) is accessible for t =3D (read |=
 write)
  * if t=3D=3Dwrite, value_regno is a register which value is stored into=
 memory
  * if t=3D=3Dread, value_regno is a register which will receive the valu=
e from memory
@@ -3363,6 +3425,9 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 	} else if (reg->type =3D=3D PTR_TO_BTF_ID) {
 		err =3D check_ptr_to_btf_access(env, regs, regno, off, size, t,
 					      value_regno);
+	} else if (reg->type =3D=3D CONST_PTR_TO_MAP) {
+		err =3D check_ptr_to_map_access(env, regs, regno, off, size, t,
+					      value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str[reg->type]);
@@ -10946,6 +11011,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr,
 		env->strict_alignment =3D false;
=20
 	env->allow_ptr_leaks =3D bpf_allow_ptr_leaks();
+	env->allow_ptr_to_map_access =3D bpf_allow_ptr_to_map_access();
 	env->bypass_spec_v1 =3D bpf_bypass_spec_v1();
 	env->bypass_spec_v4 =3D bpf_bypass_spec_v4();
 	env->bpf_capable =3D bpf_capable();
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c b/tool=
s/testing/selftests/bpf/verifier/map_ptr_mixing.c
index cd26ee6b7b1d..1f2b8c4cb26d 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
@@ -56,7 +56,7 @@
 	.fixup_map_in_map =3D { 16 },
 	.fixup_map_array_48b =3D { 13 },
 	.result =3D REJECT,
-	.errstr =3D "R0 invalid mem access 'map_ptr'",
+	.errstr =3D "only read from bpf_array is supported",
 },
 {
 	"cond: two branches returning different map pointers for lookup (tail, =
tail)",
--=20
2.24.1


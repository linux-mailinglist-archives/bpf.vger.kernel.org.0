Return-Path: <bpf+bounces-18461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C681AB0E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 00:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F1DB22203
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905B4AF7E;
	Wed, 20 Dec 2023 23:31:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43224A9B2
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKLuCaM007062
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 15:31:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v45gesqxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 15:31:49 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 15:31:47 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 165F13D86508A; Wed, 20 Dec 2023 15:31:43 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 7/8] libbpf: implement __arg_ctx fallback logic
Date: Wed, 20 Dec 2023 15:31:26 -0800
Message-ID: <20231220233127.1990417-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220233127.1990417-1-andrii@kernel.org>
References: <20231220233127.1990417-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EmMEHB0q-Vc5LblhqouIjfA-LgFLRmE_
X-Proofpoint-ORIG-GUID: EmMEHB0q-Vc5LblhqouIjfA-LgFLRmE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02

Out of all special global func arg tag annotations, __arg_ctx is
practically is the most immediately useful and most critical to have
working across multitude kernel version, if possible. This would allow
end users to write much simpler code if __arg_ctx semantics worked for
older kernels that don't natively understand btf_decl_tag("arg:ctx") in
verifier logic.

Luckily, it is possible to ensure __arg_ctx works on old kernels through
a bit of extra work done by libbpf, at least in a lot of common cases.

To explain the overall idea, we need to go back at how context argument
was supported in global funcs before __arg_ctx support was added. This
was done based on special struct name checks in kernel. E.g., for
BPF_PROG_TYPE_PERF_EVENT the expectation is that argument type `struct
bpf_perf_event_data *` mark that argument as PTR_TO_CTX. This is all
good as long as global function is used from the same BPF program types
only, which is often not the case. If the same subprog has to be called
from, say, kprobe and perf_event program types, there is no single
definition that would satisfy BPF verifier. Subprog will have context
argument either for kprobe (if using bpf_user_pt_regs_t struct name) or
perf_event (with bpf_perf_event_data struct name), but not both.

This limitation was the reason to add btf_decl_tag("arg:ctx"), making
the actual argument type not important, so that user can just define
"generic" signature:

  __noinline int global_subprog(void *ctx __arg_ctx) { ... }

I won't belabor how libbpf is implementing subprograms, see a huge
comment next to bpf_object__relocate_calls() function. The idea is that
each main/entry BPF program gets its own copy of global_subprog's code
appended.

This per-program copy of global subprog code *and* associated func_info
.BTF.ext information, pointing to FUNC -> FUNC_PROTO BTF type chain
allows libbpf to simulate __arg_ctx behavior transparently, even if the
kernel doesn't yet support __arg_ctx annotation natively.

The idea is straightforward: each time we append global subprog's code
and func_info information, we adjust its FUNC -> FUNC_PROTO type
information, if necessary (that is, libbpf can detect the presence of
btf_decl_tag("arg:ctx") just like BPF verifier would do it).

The rest is just mechanical and somewhat painful BTF manipulation code.
It's painful because we need to clone FUNC -> FUNC_PROTO, instead of
reusing it, as same FUNC -> FUNC_PROTO chain might be used by another
main BPF program within the same BPF object, so we can't just modify it
in-place (and cloning BTF types within the same struct btf object is
painful due to constant memory invalidation, see comments in code).
Uploaded BPF object's BTF information has to work for all BPF
programs at the same time.

Once we have FUNC -> FUNC_PROTO clones, we make sure that instead of
using some `void *ctx` parameter definition, we have an expected `struct
bpf_perf_event_data *ctx` definition (as far as BPF verifier and kernel
is concerned), which will mark it as context for BPF verifier. Same
global subprog relocated and copied into another main BPF program will
get different type information according to main program's type. It all
works out in the end in a completely transparent way for end user.

Libbpf maintains internal program type -> expected context struct name
mapping internally. Note, not all BPF program types have named context
struct, so this approach won't work for such programs (just like it
didn't before __arg_ctx). So native __arg_ctx is still important to have
in kernel to have generic context support across all BPF program types.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 239 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 231 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 92171bcf4c25..1a7354b6a289 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6168,7 +6168,7 @@ reloc_prog_func_and_line_info(const struct bpf_obje=
ct *obj,
 	int err;
=20
 	/* no .BTF.ext relocation if .BTF.ext is missing or kernel doesn't
-	 * supprot func/line info
+	 * support func/line info
 	 */
 	if (!obj->btf_ext || !kernel_supports(obj, FEAT_BTF_FUNC))
 		return 0;
@@ -6650,8 +6650,223 @@ static int bpf_prog_assign_exc_cb(struct bpf_obje=
ct *obj, struct bpf_program *pr
 	return 0;
 }
=20
-static int
-bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
+static struct {
+	enum bpf_prog_type prog_type;
+	const char *ctx_name;
+} global_ctx_map[] =3D {
+	{ BPF_PROG_TYPE_CGROUP_DEVICE,           "bpf_cgroup_dev_ctx" },
+	{ BPF_PROG_TYPE_CGROUP_SKB,              "__sk_buff" },
+	{ BPF_PROG_TYPE_CGROUP_SOCK,             "bpf_sock" },
+	{ BPF_PROG_TYPE_CGROUP_SOCK_ADDR,        "bpf_sock_addr" },
+	{ BPF_PROG_TYPE_CGROUP_SOCKOPT,          "bpf_sockopt" },
+	{ BPF_PROG_TYPE_CGROUP_SYSCTL,           "bpf_sysctl" },
+	{ BPF_PROG_TYPE_FLOW_DISSECTOR,          "__sk_buff" },
+	{ BPF_PROG_TYPE_KPROBE,                  "bpf_user_pt_regs_t" },
+	{ BPF_PROG_TYPE_LWT_IN,                  "__sk_buff" },
+	{ BPF_PROG_TYPE_LWT_OUT,                 "__sk_buff" },
+	{ BPF_PROG_TYPE_LWT_SEG6LOCAL,           "__sk_buff" },
+	{ BPF_PROG_TYPE_LWT_XMIT,                "__sk_buff" },
+	{ BPF_PROG_TYPE_NETFILTER,               "bpf_nf_ctx" },
+	{ BPF_PROG_TYPE_PERF_EVENT,              "bpf_perf_event_data" },
+	{ BPF_PROG_TYPE_RAW_TRACEPOINT,          "bpf_raw_tracepoint_args" },
+	{ BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, "bpf_raw_tracepoint_args" },
+	{ BPF_PROG_TYPE_SCHED_ACT,               "__sk_buff" },
+	{ BPF_PROG_TYPE_SCHED_CLS,               "__sk_buff" },
+	{ BPF_PROG_TYPE_SK_LOOKUP,               "bpf_sk_lookup" },
+	{ BPF_PROG_TYPE_SK_MSG,                  "sk_msg_md" },
+	{ BPF_PROG_TYPE_SK_REUSEPORT,            "sk_reuseport_md" },
+	{ BPF_PROG_TYPE_SK_SKB,                  "__sk_buff" },
+	{ BPF_PROG_TYPE_SOCK_OPS,                "bpf_sock_ops" },
+	{ BPF_PROG_TYPE_SOCKET_FILTER,           "__sk_buff" },
+	{ BPF_PROG_TYPE_XDP,                     "xdp_md" },
+	/* all other program types don't have "named" context structs */
+};
+
+/* Check if main program or global subprog's function prototype has `arg=
:ctx`
+ * argument tags, and, if necessary, substitute correct type to match wh=
at BPF
+ * verifier would expect, taking into account specific program type. Thi=
s
+ * allows to support __arg_ctx tag transparently on old kernels that don=
't yet
+ * have a native support for it in the verifier, making user's life much
+ * easier.
+ */
+static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bp=
f_program *prog)
+{
+	const char *ctx_name =3D NULL, *ctx_tag =3D "arg:ctx";
+	struct bpf_func_info_min *func_rec;
+	struct btf_type *fn_t, *fn_proto_t;
+	struct btf *btf =3D obj->btf;
+	const struct btf_type *t;
+	struct btf_param *p;
+	int ptr_id =3D 0, struct_id, tag_id, orig_fn_id;
+	int i, j, n, arg_idx, arg_cnt, err, name_off, rec_idx;
+	int *orig_ids;
+
+	/* no .BTF.ext, no problem */
+	if (!obj->btf_ext || !prog->func_info)
+		return 0;
+
+	/* some BPF program types just don't have named context structs, so
+	 * this fallback mechanism doesn't work for them
+	 */
+	for (i =3D 0; i < ARRAY_SIZE(global_ctx_map); i++) {
+		if (global_ctx_map[i].prog_type !=3D prog->type)
+			continue;
+		ctx_name =3D global_ctx_map[i].ctx_name;
+		break;
+	}
+	if (!ctx_name)
+		return 0;
+
+	/* remember original func BTF IDs to detect if we already cloned them *=
/
+	orig_ids =3D calloc(prog->func_info_cnt, sizeof(*orig_ids));
+	if (!orig_ids)
+		return -ENOMEM;
+	for (i =3D 0; i < prog->func_info_cnt; i++) {
+		func_rec =3D prog->func_info + prog->func_info_rec_size * i;
+		orig_ids[i] =3D func_rec->type_id;
+	}
+
+	/* go through each DECL_TAG with "arg:ctx" and see if it points to one
+	 * of our subprogs; if yes and subprog is global and needs adjustment,
+	 * clone and adjust FUNC -> FUNC_PROTO combo
+	 */
+	for (i =3D 1, n =3D btf__type_cnt(btf); i < n; i++) {
+		/* only DECL_TAG with "arg:ctx" value are interesting */
+		t =3D btf__type_by_id(btf, i);
+		if (!btf_is_decl_tag(t))
+			continue;
+		if (strcmp(btf__str_by_offset(btf, t->name_off), ctx_tag) !=3D 0)
+			continue;
+
+		/* only global funcs need adjustment, if at all */
+		orig_fn_id =3D t->type;
+		fn_t =3D btf_type_by_id(btf, orig_fn_id);
+		if (!btf_is_func(fn_t) || btf_func_linkage(fn_t) !=3D BTF_FUNC_GLOBAL)
+			continue;
+
+		/* sanity check FUNC -> FUNC_PROTO chain, just in case */
+		fn_proto_t =3D btf_type_by_id(btf, fn_t->type);
+		if (!fn_proto_t || !btf_is_func_proto(fn_proto_t))
+			continue;
+
+		/* find corresponding func_info record */
+		func_rec =3D NULL;
+		for (rec_idx =3D 0; rec_idx < prog->func_info_cnt; rec_idx++) {
+			if (orig_ids[rec_idx] =3D=3D t->type) {
+				func_rec =3D prog->func_info + prog->func_info_rec_size * rec_idx;
+				break;
+			}
+		}
+		/* current main program doesn't call into this subprog */
+		if (!func_rec)
+			continue;
+
+		/* some more sanity checking of DECL_TAG */
+		arg_cnt =3D btf_vlen(fn_proto_t);
+		arg_idx =3D btf_decl_tag(t)->component_idx;
+		if (arg_idx < 0 || arg_idx >=3D arg_cnt)
+			continue;
+
+		/* check if existing parameter already matches verifier expectations *=
/
+		p =3D &btf_params(fn_proto_t)[arg_idx];
+		t =3D skip_mods_and_typedefs(btf, p->type, NULL);
+		if (btf_is_ptr(t) &&
+		    (t =3D skip_mods_and_typedefs(btf, t->type, NULL)) &&
+		    btf_is_struct(t) &&
+		    strcmp(btf__str_by_offset(btf, t->name_off), ctx_name) =3D=3D 0) {
+			continue; /* no need for fix up */
+		}
+
+		/* clone fn/fn_proto, unless we already did it for another arg */
+		if (func_rec->type_id =3D=3D orig_fn_id) {
+			int fn_id, fn_proto_id, ret_type_id, orig_proto_id;
+
+			/* Note that each btf__add_xxx() operation invalidates
+			 * all btf_type and string pointers, so we need to be
+			 * very careful when cloning BTF types. BTF type
+			 * pointers have to be always refetched. And to avoid
+			 * problems with invalidated string pointers, we
+			 * add empty strings initially, then just fix up
+			 * name_off offsets in place. Offsets are stable for
+			 * existing strings, so that works out.
+			 */
+			name_off =3D fn_t->name_off; /* we are about to invalidate fn_t */
+			ret_type_id =3D fn_proto_t->type; /* and fn_proto_t as well */
+			orig_proto_id =3D fn_t->type; /* original FUNC_PROTO ID */
+
+			/* clone FUNC first, btf__add_func() enforces
+			 * non-empty name, so use entry program's name as
+			 * a placeholder, which we replace immediately
+			 */
+			fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage(fn_t), fn_t=
->type);
+			if (fn_id < 0)
+				return -EINVAL;
+			fn_t =3D btf_type_by_id(btf, fn_id);
+			fn_t->name_off =3D name_off; /* reuse original string */
+			fn_t->type =3D fn_id + 1; /* we can predict FUNC_PROTO ID */
+
+			/* clone FUNC_PROTO and its params now */
+			fn_proto_id =3D btf__add_func_proto(btf, ret_type_id);
+			if (fn_proto_id < 0) {
+				err =3D -EINVAL;
+				goto err_out;
+			}
+			for (j =3D 0; j < arg_cnt; j++) {
+				/* copy original parameter data */
+				t =3D btf_type_by_id(btf, orig_proto_id);
+				p =3D &btf_params(t)[j];
+				name_off =3D p->name_off;
+
+				err =3D btf__add_func_param(btf, "", p->type);
+				if (err)
+					goto err_out;
+				fn_proto_t =3D btf_type_by_id(btf, fn_proto_id);
+				p =3D &btf_params(fn_proto_t)[j];
+				p->name_off =3D name_off; /* use remembered str offset */
+			}
+
+			/* point func_info record to a cloned FUNC type */
+			func_rec->type_id =3D fn_id;
+		}
+
+		/* create PTR -> STRUCT type chain to mark PTR_TO_CTX argument;
+		 * we do it just once per main BPF program, as all global
+		 * funcs share the same program type, so need only PTR ->
+		 * STRUCT type chain
+		 */
+		if (ptr_id =3D=3D 0) {
+			struct_id =3D btf__add_struct(btf, ctx_name, 0);
+			ptr_id =3D btf__add_ptr(btf, struct_id);
+			if (ptr_id < 0 || struct_id < 0) {
+				err =3D -EINVAL;
+				goto err_out;
+			}
+		}
+
+		/* for completeness, clone DECL_TAG and point it to cloned param */
+		tag_id =3D btf__add_decl_tag(btf, ctx_tag, func_rec->type_id, arg_idx)=
;
+		if (tag_id < 0) {
+			err =3D -EINVAL;
+			goto err_out;
+		}
+
+		/* all the BTF manipulations invalidated pointers, refetch them */
+		fn_t =3D btf_type_by_id(btf, func_rec->type_id);
+		fn_proto_t =3D btf_type_by_id(btf, fn_t->type);
+
+		/* fix up type ID pointed to by param */
+		p =3D &btf_params(fn_proto_t)[arg_idx];
+		p->type =3D ptr_id;
+	}
+
+	free(orig_ids);
+	return 0;
+err_out:
+	free(orig_ids);
+	return err;
+}
+
+static int bpf_object_relocate(struct bpf_object *obj, const char *targ_=
btf_path)
 {
 	struct bpf_program *prog;
 	size_t i, j;
@@ -6732,19 +6947,28 @@ bpf_object__relocate(struct bpf_object *obj, cons=
t char *targ_btf_path)
 			}
 		}
 	}
-	/* Process data relos for main programs */
 	for (i =3D 0; i < obj->nr_programs; i++) {
 		prog =3D &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
 		if (!prog->autoload)
 			continue;
+
+		/* Process data relos for main programs */
 		err =3D bpf_object__relocate_data(obj, prog);
 		if (err) {
 			pr_warn("prog '%s': failed to relocate data references: %d\n",
 				prog->name, err);
 			return err;
 		}
+
+		/* Fix up .BTF.ext information, if necessary */
+		err =3D bpf_program_fixup_func_info(obj, prog);
+		if (err) {
+			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %d\n",
+				prog->name, err);
+			return err;
+		}
 	}
=20
 	return 0;
@@ -7456,8 +7680,7 @@ static int bpf_program_record_relos(struct bpf_prog=
ram *prog)
 	return 0;
 }
=20
-static int
-bpf_object__load_progs(struct bpf_object *obj, int log_level)
+static int bpf_object_load_progs(struct bpf_object *obj, int log_level)
 {
 	struct bpf_program *prog;
 	size_t i;
@@ -8093,10 +8316,10 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
 	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err =3D err ? : bpf_object__sanitize_maps(obj);
 	err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
-	err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : targ=
et_btf_path);
+	err =3D err ? : bpf_object_relocate(obj, obj->btf_custom_path ? : targe=
t_btf_path);
 	err =3D err ? : bpf_object_load_btf(obj);
 	err =3D err ? : bpf_object_create_maps(obj);
-	err =3D err ? : bpf_object__load_progs(obj, extra_log_level);
+	err =3D err ? : bpf_object_load_progs(obj, extra_log_level);
 	err =3D err ? : bpf_object_init_prog_arrays(obj);
 	err =3D err ? : bpf_object_prepare_struct_ops(obj);
=20
--=20
2.34.1



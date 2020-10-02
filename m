Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1045280BD1
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 03:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgJBBJY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 21:09:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44472 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733275AbgJBBJY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Oct 2020 21:09:24 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0920nwh0026438
        for <bpf@vger.kernel.org>; Thu, 1 Oct 2020 18:09:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SRfRz/faZf1RTgiCyP5ae6cSBlXeViA1iDZYxY/e1tk=;
 b=bwcPgGmf84HfDhWX8rJp+4/LWxuGoxZj8pRiQrgIBgfvQwaOPQWMORC9FmNAWr9SCEFj
 jrC5Ua/QkZIMmcibEOLHs306/ZF4Xnj3Z7RjOpvCxyrRtA/zRobklQVFH5m+hikRG5xt
 YFQf0D3Dr8OZ35q7sCEBOQ2XyptaJgcx0dg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33vvgrs4nm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 18:09:22 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 18:09:20 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 847DD2EC789D; Thu,  1 Oct 2020 18:09:17 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Tony Ambardar <tony.ambardar@gmail.com>
Subject: [PATCH bpf-next 1/3] libbpf: support safe subset of load/store instruction resizing with CO-RE
Date:   Thu, 1 Oct 2020 18:06:31 -0700
Message-ID: <20201002010633.3706122-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201002010633.3706122-1-andriin@fb.com>
References: <20201002010633.3706122-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=8 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010020002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for patching instructions of the following form:
  - rX =3D *(T *)(rY + <off>);
  - *(T *)(rX + <off>) =3D rY;
  - *(T *)(rX + <off>) =3D <imm>, where T is one of {u8, u16, u32, u64}.

For such instructions, if the actual kernel field recorded in CO-RE reloc=
ation
has a different size than the one recorded locally (e.g., from vmlinux.h)=
,
then libbpf will adjust T to an appropriate 1-, 2-, 4-, or 8-byte loads.

In general, such transformation is not always correct and could lead to
invalid final value being loaded or stored. But two classes of cases are
always safe:
  - if both local and target (kernel) types are unsigned integers, but of
  different sizes, then it's OK to adjust load/store instruction accordin=
g to
  the necessary memory size. Zero-extending nature of such instructions a=
nd
  unsignedness make sure that the final value is always correct;
  - pointer size mismatch between BPF target architecture (which is alway=
s
  64-bit) and 32-bit host kernel architecture can be similarly resolved
  automatically, because pointer is essentially an unsigned integer. Load=
ing
  32-bit pointer into 64-bit BPF register with zero extension will leave
  correct pointer in the register.

Both cases are necessary to support CO-RE on 32-bit kernels, as `unsigned
long` in vmlinux.h generated from 32-bit kernel is 32-bit, but when compi=
led
with BPF program for BPF target it will be treated by compiler as 64-bit
integer. Similarly, pointers in vmlinux.h are 32-bit for kernel, but trea=
ted
as 64-bit values by compiler for BPF target. Both problems are now resolv=
ed by
libbpf for direct memory reads.

But similar transformations are useful in general when kernel fields are
"resized" from, e.g., unsigned int to unsigned long (or vice versa).

Now, similar transformations for signed integers are not safe to perform =
as
they will result in incorrect sign extension of the value. If such situat=
ion
is detected, libbpf will emit helpful message and will poison the instruc=
tion.
Not failing immediately means that it's possible to guard the instruction
based on kernel version (or other conditions) and make sure it's not
reachable.

If there is a need to read signed integers that change sizes between diff=
erent
kernels, it's possible to use BPF_CORE_READ_BITFIELD() macro, which works=
 both
with bitfields and non-bitfield integers of any signedness and handles
sign-extension properly. Also, bpf_core_read() with proper size and/or us=
e of
bpf_core_field_size() relocation could allow to deal with such complicate=
d
situations explicitly, if not so conventiently as direct memory reads.

Selftests added in a separate patch in progs/test_core_autosize.c demonst=
rate
both direct memory and probed use cases.

BPF_CORE_READ() is not changed and it won't deal with such situations as
automatically as direct memory reads due to the signedness integer
limitations, which are much harder to detect and control with compiler ma=
cro
magic. So it's encouraged to utilize direct memory reads as much as possi=
ble.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 144 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a4f55f8a460d..20a47b729f7c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5017,16 +5017,19 @@ static int bpf_core_spec_match(struct bpf_core_sp=
ec *local_spec,
 static int bpf_core_calc_field_relo(const struct bpf_program *prog,
 				    const struct bpf_core_relo *relo,
 				    const struct bpf_core_spec *spec,
-				    __u32 *val, bool *validate)
+				    __u32 *val, __u32 *field_sz, __u32 *type_id,
+				    bool *validate)
 {
 	const struct bpf_core_accessor *acc;
 	const struct btf_type *t;
-	__u32 byte_off, byte_sz, bit_off, bit_sz;
+	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id;
 	const struct btf_member *m;
 	const struct btf_type *mt;
 	bool bitfield;
 	__s64 sz;
=20
+	*field_sz =3D 0;
+
 	if (relo->kind =3D=3D BPF_FIELD_EXISTS) {
 		*val =3D spec ? 1 : 0;
 		return 0;
@@ -5042,6 +5045,12 @@ static int bpf_core_calc_field_relo(const struct b=
pf_program *prog,
 	if (!acc->name) {
 		if (relo->kind =3D=3D BPF_FIELD_BYTE_OFFSET) {
 			*val =3D spec->bit_offset / 8;
+			/* remember field size for load/store mem size */
+			sz =3D btf__resolve_size(spec->btf, acc->type_id);
+			if (sz < 0)
+				return -EINVAL;
+			*field_sz =3D sz;
+			*type_id =3D acc->type_id;
 		} else if (relo->kind =3D=3D BPF_FIELD_BYTE_SIZE) {
 			sz =3D btf__resolve_size(spec->btf, acc->type_id);
 			if (sz < 0)
@@ -5058,7 +5067,7 @@ static int bpf_core_calc_field_relo(const struct bp=
f_program *prog,
 	}
=20
 	m =3D btf_members(t) + acc->idx;
-	mt =3D skip_mods_and_typedefs(spec->btf, m->type, NULL);
+	mt =3D skip_mods_and_typedefs(spec->btf, m->type, &field_type_id);
 	bit_off =3D spec->bit_offset;
 	bit_sz =3D btf_member_bitfield_size(t, acc->idx);
=20
@@ -5078,7 +5087,7 @@ static int bpf_core_calc_field_relo(const struct bp=
f_program *prog,
 			byte_off =3D bit_off / 8 / byte_sz * byte_sz;
 		}
 	} else {
-		sz =3D btf__resolve_size(spec->btf, m->type);
+		sz =3D btf__resolve_size(spec->btf, field_type_id);
 		if (sz < 0)
 			return -EINVAL;
 		byte_sz =3D sz;
@@ -5096,6 +5105,10 @@ static int bpf_core_calc_field_relo(const struct b=
pf_program *prog,
 	switch (relo->kind) {
 	case BPF_FIELD_BYTE_OFFSET:
 		*val =3D byte_off;
+		if (!bitfield) {
+			*field_sz =3D byte_sz;
+			*type_id =3D field_type_id;
+		}
 		break;
 	case BPF_FIELD_BYTE_SIZE:
 		*val =3D byte_sz;
@@ -5196,6 +5209,19 @@ struct bpf_core_relo_res
 	bool poison;
 	/* some relocations can't be validated against orig_val */
 	bool validate;
+	/* for field byte offset relocations or the forms:
+	 *     *(T *)(rX + <off>) =3D rY
+	 *     rX =3D *(T *)(rY + <off>),
+	 * we remember original and resolved field size to adjust direct
+	 * memory loads of pointers and integers; this is necessary for 32-bit
+	 * host kernel architectures, but also allows to automatically
+	 * relocate fields that were resized from, e.g., u32 to u64, etc.
+	 */
+	bool fail_memsz_adjust;
+	__u32 orig_sz;
+	__u32 orig_type_id;
+	__u32 new_sz;
+	__u32 new_type_id;
 };
=20
 /* Calculate original and target relocation values, given local and targ=
et
@@ -5217,10 +5243,56 @@ static int bpf_core_calc_relo(const struct bpf_pr=
ogram *prog,
 	res->new_val =3D 0;
 	res->poison =3D false;
 	res->validate =3D true;
+	res->fail_memsz_adjust =3D false;
+	res->orig_sz =3D res->new_sz =3D 0;
+	res->orig_type_id =3D res->new_type_id =3D 0;
=20
 	if (core_relo_is_field_based(relo->kind)) {
-		err =3D bpf_core_calc_field_relo(prog, relo, local_spec, &res->orig_va=
l, &res->validate);
-		err =3D err ?: bpf_core_calc_field_relo(prog, relo, targ_spec, &res->n=
ew_val, NULL);
+		err =3D bpf_core_calc_field_relo(prog, relo, local_spec,
+					       &res->orig_val, &res->orig_sz,
+					       &res->orig_type_id, &res->validate);
+		err =3D err ?: bpf_core_calc_field_relo(prog, relo, targ_spec,
+						      &res->new_val, &res->new_sz,
+						      &res->new_type_id, NULL);
+		if (err)
+			goto done;
+		/* Validate if it's safe to adjust load/store memory size.
+		 * Adjustments are performed only if original and new memory
+		 * sizes differ.
+		 */
+		res->fail_memsz_adjust =3D false;
+		if (res->orig_sz !=3D res->new_sz) {
+			const struct btf_type *orig_t, *new_t;
+
+			orig_t =3D btf__type_by_id(local_spec->btf, res->orig_type_id);
+			new_t =3D btf__type_by_id(targ_spec->btf, res->new_type_id);
+
+			/* There are two use cases in which it's safe to
+			 * adjust load/store's mem size:
+			 *   - reading a 32-bit kernel pointer, while on BPF
+			 *   size pointers are always 64-bit; in this case
+			 *   it's safe to "downsize" instruction size due to
+			 *   pointer being treated as unsigned integer with
+			 *   zero-extended upper 32-bits;
+			 *   - reading unsigned integers, again due to
+			 *   zero-extension is preserving the value correctly.
+			 *
+			 * In all other cases it's incorrect to attempt to
+			 * load/store field because read value will be
+			 * incorrect, so we poison relocated instruction.
+			 */
+			if (btf_is_ptr(orig_t) && btf_is_ptr(new_t))
+				goto done;
+			if (btf_is_int(orig_t) && btf_is_int(new_t) &&
+			    btf_int_encoding(orig_t) !=3D BTF_INT_SIGNED &&
+			    btf_int_encoding(new_t) !=3D BTF_INT_SIGNED)
+				goto done;
+
+			/* mark as invalid mem size adjustment, but this will
+			 * only be checked for LDX/STX/ST insns
+			 */
+			res->fail_memsz_adjust =3D true;
+		}
 	} else if (core_relo_is_type_based(relo->kind)) {
 		err =3D bpf_core_calc_type_relo(relo, local_spec, &res->orig_val);
 		err =3D err ?: bpf_core_calc_type_relo(relo, targ_spec, &res->new_val)=
;
@@ -5229,6 +5301,7 @@ static int bpf_core_calc_relo(const struct bpf_prog=
ram *prog,
 		err =3D err ?: bpf_core_calc_enumval_relo(relo, targ_spec, &res->new_v=
al);
 	}
=20
+done:
 	if (err =3D=3D -EUCLEAN) {
 		/* EUCLEAN is used to signal instruction poisoning request */
 		res->poison =3D true;
@@ -5268,6 +5341,28 @@ static bool is_ldimm64(struct bpf_insn *insn)
 	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
 }
=20
+static int insn_mem_sz_to_bytes(struct bpf_insn *insn)
+{
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_DW: return 8;
+	case BPF_W: return 4;
+	case BPF_H: return 2;
+	case BPF_B: return 1;
+	default: return -1;
+	}
+}
+
+static int insn_bytes_to_mem_sz(__u32 sz)
+{
+	switch (sz) {
+	case 8: return BPF_DW;
+	case 4: return BPF_W;
+	case 2: return BPF_H;
+	case 1: return BPF_B;
+	default: return -1;
+	}
+}
+
 /*
  * Patch relocatable BPF instruction.
  *
@@ -5277,10 +5372,13 @@ static bool is_ldimm64(struct bpf_insn *insn)
  * spec, and is checked before patching instruction. If actual insn->imm=
 value
  * is wrong, bail out with error.
  *
- * Currently three kinds of BPF instructions are supported:
+ * Currently supported classes of BPF instruction are:
  * 1. rX =3D <imm> (assignment with immediate operand);
  * 2. rX +=3D <imm> (arithmetic operations with immediate operand);
- * 3. rX =3D <imm64> (load with 64-bit immediate value).
+ * 3. rX =3D <imm64> (load with 64-bit immediate value);
+ * 4. rX =3D *(T *)(rY + <off>), where T is one of {u8, u16, u32, u64};
+ * 5. *(T *)(rX + <off>) =3D rY, where T is one of {u8, u16, u32, u64};
+ * 6. *(T *)(rX + <off>) =3D <imm>, where T is one of {u8, u16, u32, u64=
}.
  */
 static int bpf_core_patch_insn(struct bpf_program *prog,
 			       const struct bpf_core_relo *relo,
@@ -5289,7 +5387,7 @@ static int bpf_core_patch_insn(struct bpf_program *=
prog,
 {
 	__u32 orig_val, new_val;
 	struct bpf_insn *insn;
-	int insn_idx;
+	int insn_idx, mem_sz;
 	__u8 class;
=20
 	if (relo->insn_off % BPF_INSN_SZ)
@@ -5304,6 +5402,7 @@ static int bpf_core_patch_insn(struct bpf_program *=
prog,
 	class =3D BPF_CLASS(insn->code);
=20
 	if (res->poison) {
+poison:
 		/* poison second part of ldimm64 to avoid confusing error from
 		 * verifier about "unknown opcode 00"
 		 */
@@ -5346,10 +5445,37 @@ static int bpf_core_patch_insn(struct bpf_program=
 *prog,
 				prog->name, relo_idx, insn_idx, new_val);
 			return -ERANGE;
 		}
+		if (res->fail_memsz_adjust) {
+			pr_warn("prog '%s': relo #%d: insn #%d (LDX/ST/STX) accesses field in=
correctly. "
+				"Make sure you are accessing pointers, unsigned integers, or fields =
of matching type and size.\n",
+				prog->name, relo_idx, insn_idx);
+			goto poison;
+		}
+
 		orig_val =3D insn->off;
 		insn->off =3D new_val;
 		pr_debug("prog '%s': relo #%d: patched insn #%d (LDX/ST/STX) off %u ->=
 %u\n",
 			 prog->name, relo_idx, insn_idx, orig_val, new_val);
+
+		if (res->new_sz !=3D res->orig_sz) {
+			mem_sz =3D insn_mem_sz_to_bytes(insn);
+			if (mem_sz !=3D res->orig_sz) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDX/ST/STX) unexpected mem s=
ize: got %u, exp %u\n",
+					prog->name, relo_idx, insn_idx, mem_sz, res->orig_sz);
+				return -EINVAL;
+			}
+
+			mem_sz =3D insn_bytes_to_mem_sz(res->new_sz);
+			if (mem_sz < 0) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDX/ST/STX) invalid new mem =
size: %u\n",
+					prog->name, relo_idx, insn_idx, res->new_sz);
+				return -EINVAL;
+			}
+
+			insn->code =3D BPF_MODE(insn->code) | mem_sz | BPF_CLASS(insn->code);
+			pr_debug("prog '%s': relo #%d: patched insn #%d (LDX/ST/STX) mem_sz %=
u -> %u\n",
+				 prog->name, relo_idx, insn_idx, res->orig_sz, res->new_sz);
+		}
 		break;
 	case BPF_LD: {
 		__u64 imm;
--=20
2.24.1


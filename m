Return-Path: <bpf+bounces-14892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58DB7E8C8A
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 21:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40BE281313
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206F1D6A7;
	Sat, 11 Nov 2023 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061C1D6BE
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 20:17:02 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDAD72
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:17:01 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABJx5d8028838
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:17:01 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua5tqabsx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:17:01 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 12:16:58 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4629E3B5A8FBE; Sat, 11 Nov 2023 12:16:45 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 5/8] bpf: emit map name in register state if applicable and available
Date: Sat, 11 Nov 2023 12:16:30 -0800
Message-ID: <20231111201633.3434794-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111201633.3434794-1-andrii@kernel.org>
References: <20231111201633.3434794-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uemJ7OGNnXLnZV3sIpBnc_ZNmiv7XY9-
X-Proofpoint-ORIG-GUID: uemJ7OGNnXLnZV3sIpBnc_ZNmiv7XY9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_16,2023-11-09_01,2023-05-22_02

In complicated real-world applications, whenever debugging some
verification error through verifier log, it often would be very useful
to see map name for PTR_TO_MAP_VALUE register. Usually this needs to be
inferred from key/value sizes and maybe trying to guess C code location,
but it's not always clear.

Given verifier has the name, and it's never too long, let's just emit it
for ptr_to_map_key, ptr_to_map_value, and const_ptr_to_map registers. We
reshuffle the order a bit, so that map name, key size, and value size
appear before offset and immediate values, which seems like a more
logical order.

Current output:

  R1_w=3Dmap_ptr(map=3Darray_map,ks=3D4,vs=3D8,off=3D0,imm=3D0)

But we'll get rid of useless off=3D0 and imm=3D0 parts in the next patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c                              | 24 ++++++++++++++-----
 .../selftests/bpf/prog_tests/spin_lock.c      | 10 ++++----
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 97a1641e848e..c209ab1ec2b5 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -553,6 +553,17 @@ static void print_scalar_ranges(struct bpf_verifier_=
env *env,
 	}
 }
=20
+static bool type_is_map_ptr(enum bpf_reg_type t) {
+	switch (base_type(t)) {
+	case CONST_PTR_TO_MAP:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void print_reg_state(struct bpf_verifier_env *env, const struct b=
pf_reg_state *reg)
 {
 	enum bpf_reg_type t;
@@ -584,16 +595,17 @@ static void print_reg_state(struct bpf_verifier_env=
 *env, const struct bpf_reg_s
 		verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
+	if (type_is_map_ptr(t)) {
+		if (reg->map_ptr->name[0])
+			verbose_a("map=3D%s", reg->map_ptr->name);
+		verbose_a("ks=3D%d,vs=3D%d",
+			  reg->map_ptr->key_size,
+			  reg->map_ptr->value_size);
+	}
 	if (t !=3D SCALAR_VALUE)
 		verbose_a("off=3D%d", reg->off);
 	if (type_is_pkt_pointer(t))
 		verbose_a("r=3D%d", reg->range);
-	else if (base_type(t) =3D=3D CONST_PTR_TO_MAP ||
-		 base_type(t) =3D=3D PTR_TO_MAP_KEY ||
-		 base_type(t) =3D=3D PTR_TO_MAP_VALUE)
-		verbose_a("ks=3D%d,vs=3D%d",
-			  reg->map_ptr->key_size,
-			  reg->map_ptr->value_size);
 	if (tnum_is_const(reg->var_off)) {
 		/* Typically an immediate SCALAR_VALUE, but
 		 * could be a pointer whose offset is too big
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/t=
esting/selftests/bpf/prog_tests/spin_lock.c
index f29c08d93beb..ace65224286f 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -17,18 +17,18 @@ static struct {
 	  "R1_w=3Dptr_foo(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2\n6: (=
85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=3Dptr_ expected=3Dpercpu_ptr_" },
 	{ "lock_id_global_zero",
-	  "; R1_w=3Dmap_value(off=3D0,ks=3D4,vs=3D4,imm=3D0)\n2: (85) call bpf_=
this_cpu_ptr#154\n"
+	  "; R1_w=3Dmap_value(map=3D.data.A,ks=3D4,vs=3D4,off=3D0,imm=3D0)\n2: =
(85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
 	{ "lock_id_mapval_preserve",
 	  "[0-9]\\+: (bf) r1 =3D r0                       ;"
-	  " R0_w=3Dmap_value(id=3D1,off=3D0,ks=3D4,vs=3D8,imm=3D0)"
-	  " R1_w=3Dmap_value(id=3D1,off=3D0,ks=3D4,vs=3D8,imm=3D0)\n"
+	  " R0_w=3Dmap_value(id=3D1,map=3Darray_map,ks=3D4,vs=3D8,off=3D0,imm=3D=
0)"
+	  " R1_w=3Dmap_value(id=3D1,map=3Darray_map,ks=3D4,vs=3D8,off=3D0,imm=3D=
0)\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
 	{ "lock_id_innermapval_preserve",
 	  "[0-9]\\+: (bf) r1 =3D r0                      ;"
-	  " R0=3Dmap_value(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)"
-	  " R1_w=3Dmap_value(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)\n"
+	  " R0=3Dmap_value(id=3D2,ks=3D4,vs=3D8,off=3D0,imm=3D0)"
+	  " R1_w=3Dmap_value(id=3D2,ks=3D4,vs=3D8,off=3D0,imm=3D0)\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
 	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
--=20
2.34.1



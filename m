Return-Path: <bpf+bounces-13276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C97D76EF
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C330281D5B
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB1347AA;
	Wed, 25 Oct 2023 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XXagcqBd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA4347BD
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:33 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB06B133
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:32 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfOXh016453
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4uaXMGT9OjamVpFGOnPgWzhUOvAZdNpTHHiuS8PwIUs=;
 b=XXagcqBdMPACrC19mOXBbzdeZ+j0cgA7kAP5vCXxAM/8PxD7iezqrBi5pX8EAHoUDSmj
 j9LC2zcYS9Z3GqPJI/S/ku+wQ5ewSwLddukjOyhPqe5bIRL8Oems+4jiM5BmEhNbfBIT
 qt85UMVGJM9ktuVjEiWBGMXC4L7EsoasRK0= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ty54a367m-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:31 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:26 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id DBFE3264D46F4; Wed, 25 Oct 2023 14:40:14 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 5/6] bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
Date: Wed, 25 Oct 2023 14:40:06 -0700
Message-ID: <20231025214007.2920506-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SJzKNPf7VIgFolscKpthjagCTd6hIneh
X-Proofpoint-GUID: SJzKNPf7VIgFolscKpthjagCTd6hIneh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

This patch enables the following pattern:

  /* mapval contains a __kptr pointing to refcounted local kptr */
  mapval =3D bpf_map_lookup_elem(&map, &idx);
  if (!mapval || !mapval->some_kptr) { /* omitted */ }

  p =3D bpf_refcount_acquire(&mapval->some_kptr);

Currently this doesn't work because bpf_refcount_acquire expects an
owning or non-owning ref. The verifier defines non-owning ref as a type:

  PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF

while mapval->some_kptr is PTR_TO_BTF_ID | PTR_UNTRUSTED. It's possible
to do the refcount_acquire by first bpf_kptr_xchg'ing mapval->some_kptr
into a temp kptr, refcount_acquiring that, and xchg'ing back into
mapval, but this is unwieldy and shouldn't be necessary.

This patch modifies btf_ld_kptr_type such that user-allocated types are
marked MEM_ALLOC and if those types have a bpf_{rb,list}_node they're
marked NON_OWN_REF as well. Additionally, due to changes to
bpf_obj_drop_impl earlier in this series, rcu_protected_object now
returns true for all user-allocated types, resulting in
mapval->some_kptr being marked MEM_RCU.

After this patch's changes, mapval->some_kptr is now:

  PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU

which results in it passing the non-owning ref test, and the motivating
example passing verification.

Future work will likely get rid of special non-owning ref lifetime logic
in the verifier, at which point we'll be able to delete the NON_OWN_REF
flag entirely.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..bb098a4c8fd5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5396,10 +5396,23 @@ BTF_SET_END(rcu_protected_types)
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
 {
 	if (!btf_is_kernel(btf))
-		return false;
+		return true;
 	return btf_id_set_contains(&rcu_protected_types, btf_id);
 }
=20
+static struct btf_record *kptr_pointee_btf_record(struct btf_field *kptr=
_field)
+{
+	struct btf_struct_meta *meta;
+
+	if (btf_is_kernel(kptr_field->kptr.btf))
+		return NULL;
+
+	meta =3D btf_find_struct_meta(kptr_field->kptr.btf,
+				    kptr_field->kptr.btf_id);
+
+	return meta ? meta->record : NULL;
+}
+
 static bool rcu_safe_kptr(const struct btf_field *field)
 {
 	const struct btf_field_kptr *kptr =3D &field->kptr;
@@ -5410,12 +5423,25 @@ static bool rcu_safe_kptr(const struct btf_field =
*field)
=20
 static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_fie=
ld *kptr_field)
 {
+	struct btf_record *rec;
+	u32 ret;
+
+	ret =3D PTR_MAYBE_NULL;
 	if (rcu_safe_kptr(kptr_field) && in_rcu_cs(env)) {
-		if (kptr_field->type !=3D BPF_KPTR_PERCPU)
-			return PTR_MAYBE_NULL | MEM_RCU;
-		return PTR_MAYBE_NULL | MEM_RCU | MEM_PERCPU;
+		ret |=3D MEM_RCU;
+		if (kptr_field->type =3D=3D BPF_KPTR_PERCPU)
+			ret |=3D MEM_PERCPU;
+		if (!btf_is_kernel(kptr_field->kptr.btf))
+			ret |=3D MEM_ALLOC;
+
+		rec =3D kptr_pointee_btf_record(kptr_field);
+		if (rec && btf_record_has_field(rec, BPF_GRAPH_NODE))
+			ret |=3D NON_OWN_REF;
+	} else {
+		ret |=3D PTR_UNTRUSTED;
 	}
-	return PTR_MAYBE_NULL | PTR_UNTRUSTED;
+
+	return ret;
 }
=20
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno=
,
--=20
2.34.1



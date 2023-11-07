Return-Path: <bpf+bounces-14388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46F7E370A
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BEA1C20A26
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79E11C99;
	Tue,  7 Nov 2023 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UsJ8AGEd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A110A25
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:57:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F453113
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 00:57:01 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6NHsQB009020
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 00:57:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=C/CxlsKXah3MWLeV4ADzSIOKt6NYh4D/gZsoYRE8/aM=;
 b=UsJ8AGEdTJ+fA3bvSQrADT88W+tBohIUK7ERzMc8NZtfcObaWQCGO6V42XtPEoh2MJI0
 Pp5N15qZsy6yqhniE5Ncv8Puzq4MOR2+DiTVX1tuAFPh5VS/XLKriV7kjRo7Gd98sU2x
 CGVf/Ut9nwp7/aae24OkTfl1WqBjTOR79Fg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u79h5k60e-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 00:57:00 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:56:55 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 99FEA26E3B71B; Tue,  7 Nov 2023 00:56:45 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 5/6] bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
Date: Tue, 7 Nov 2023 00:56:38 -0800
Message-ID: <20231107085639.3016113-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107085639.3016113-1-davemarchevsky@fb.com>
References: <20231107085639.3016113-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o1BP0zj1aiM2XIRbqQdvezUZRPJ5mOH7
X-Proofpoint-ORIG-GUID: o1BP0zj1aiM2XIRbqQdvezUZRPJ5mOH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

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
index 2197385d91dc..62076b7aad03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5542,10 +5542,23 @@ BTF_SET_END(rcu_protected_types)
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
@@ -5556,12 +5569,25 @@ static bool rcu_safe_kptr(const struct btf_field =
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
+		else if (!btf_is_kernel(kptr_field->kptr.btf))
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



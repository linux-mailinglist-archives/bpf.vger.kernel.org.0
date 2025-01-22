Return-Path: <bpf+bounces-49436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DBCA18A4B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BD4167DDC
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F21531C2;
	Wed, 22 Jan 2025 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="eqHOpi0E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4B14C5AF
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514423; cv=none; b=JxNJt5pbyKNRAxYwn3Y/kA1VldrSVjViDos2YiwfrgJQwGrmQDqrFztKat4k0Go4VzlxSu24Cg+pk9IsY6VRdDiyMNtMIhZRYBld/C5xDxvObkgJr3WogwzJ8ZjB3VJB2JHDLvWMCAX/KFfv8xJi+f7TKLUwL87A6OEYiXaOD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514423; c=relaxed/simple;
	bh=yvgSJIqrJ1OfzkhkLtSbHjXKpLH1GH21iNkKkuaiqKM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eerWsYsaLYONP6CAg6WqPXviqm1726sLo+VTZAXARe3fmKPi4iXiBwYm7EpGbcjqwCR7VrldQR+BW9nM11jzl0G5MR7ojQ+yXNdCqf+FaERtE6QlASQdRm/SERiQYRWgTYDf/abFNVKBvDyhB0HmwkUeKBRHVR8EpoBSUBKy+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=eqHOpi0E; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737514419; x=1737773619;
	bh=4OtlfiB/e2wSSQK+x41KnqlMY7OgNCnIROVKaSG9jXk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=eqHOpi0EA0mBM18VSv7TS2YcECr9D/OEDdLXRX2lZU+3R5dKUFTamJKLvAsUopGgi
	 iWbCUjbbS3DlWAQs8k628vn+DJIAaOMp84mTGZgCrMBxQvhWxX41h8BCu3SriKqTmu
	 /f4JnbBJTWJn6iMn0PcUDHTVFXr2JsiQF5X8MbCkgk7d737lbk3VGYy17iyLXmNPoS
	 cYHFCdNL9QanLQa2kOGSStVRwWDG7CNHh2CJe/2zXm+DJVEuaY0MDnNmVHgGxu2Y7W
	 EVu63zxglz6mgMJ+KqxZtzSkk/4t0SCZZSYJBJzhFhN5MIWj9gz4cHtuWomh5/1OUS
	 8CPPnBh7vfDZQ==
Date: Wed, 22 Jan 2025 02:53:35 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next 4/5] bpf: allow kind_flag for BTF type and decl tags
Message-ID: <20250122025308.2717553-5-ihor.solodrai@pm.me>
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: ddbff4579e00b8fab0a2b44995c6d092feade9d9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

BTF type tags and decl tags now may have info->kflag set to 1,
changing the semantics of the tag.

Change BTF verification to permit BTF that makes use of this feature:
  * remove kflag check in btf_decl_tag_check_meta(), as both values
    are valid
  * allow kflag to be set for BTF_KIND_TYPE_TAG type in
    btf_ref_type_check_meta()

Modify a selftest checking for kflag in decl_tag accordingly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 kernel/bpf/btf.c                             | 7 +------
 tools/testing/selftests/bpf/prog_tests/btf.c | 4 +---
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8396ce1d0fba..becdec583e00 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2575,7 +2575,7 @@ static int btf_ref_type_check_meta(struct btf_verifie=
r_env *env,
 =09=09return -EINVAL;
 =09}
=20
-=09if (btf_type_kflag(t)) {
+=09if (btf_type_kflag(t) && BTF_INFO_KIND(t->info) !=3D BTF_KIND_TYPE_TAG)=
 {
 =09=09btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
 =09=09return -EINVAL;
 =09}
@@ -4944,11 +4944,6 @@ static s32 btf_decl_tag_check_meta(struct btf_verifi=
er_env *env,
 =09=09return -EINVAL;
 =09}
=20
-=09if (btf_type_kflag(t)) {
-=09=09btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
-=09=09return -EINVAL;
-=09}
-
 =09component_idx =3D btf_type_decl_tag(t)->component_idx;
 =09if (component_idx < -1) {
 =09=09btf_verifier_log_type(env, t, "Invalid component_idx");
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index e63d74ce046f..aab9ad88c845 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3866,7 +3866,7 @@ static struct btf_raw_test raw_tests[] =3D {
 =09.err_str =3D "vlen !=3D 0",
 },
 {
-=09.descr =3D "decl_tag test #8, invalid kflag",
+=09.descr =3D "decl_tag test #8, tag with kflag",
 =09.raw_types =3D {
 =09=09BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),=09/* [1] */
 =09=09BTF_VAR_ENC(NAME_TBD, 1, 0),=09=09=09/* [2] */
@@ -3881,8 +3881,6 @@ static struct btf_raw_test raw_tests[] =3D {
 =09.key_type_id =3D 1,
 =09.value_type_id =3D 1,
 =09.max_entries =3D 1,
-=09.btf_load_err =3D true,
-=09.err_str =3D "Invalid btf_info kind_flag",
 },
 {
 =09.descr =3D "decl_tag test #9, var, invalid component_idx",
--=20
2.48.1




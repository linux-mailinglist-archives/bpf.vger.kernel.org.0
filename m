Return-Path: <bpf+bounces-44904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657E9CD4B0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC241F223BB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF21096F;
	Fri, 15 Nov 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cG/R3c/S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB263B9
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631150; cv=none; b=cI/rGATYlHol2ba0JLn2S4qUzhIgL900wBUgO/Vwln+rXtI32pqwoUCKd+sW5WoyYLvOGh4TVsD1GTDCUI3YSMeI1pKbQnEGxUy+jldqY4kLIZGRfs7dVKkyGAprbT2y9wEaFRHer2Cvps3O1XlfR466K7xcIIOrK2D5ajMpkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631150; c=relaxed/simple;
	bh=xqVTrsJgaqYLpCuVFY8b5Yeks6WAioT3ytYzblQoCLs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ErCjEgTKQDJEUMdQZtvZ8Nl0gbRMW1+FCofFg8pXKF2jrIe+W8Atl/zqWdFWKrOg55MDvygf7E/fj7WsnMa3p3wIAOCs1P3R6URfezVRavoIuDEfWYyk9ZCg05h7NEKoEqegFafwiS6U5kX7tb9g0LkV1yyyVB0VnEHbwxG3uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cG/R3c/S; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1731631141; x=1731890341;
	bh=xqVTrsJgaqYLpCuVFY8b5Yeks6WAioT3ytYzblQoCLs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=cG/R3c/SzOZLaOi56Im1pHa963Dw1uxyuVnQHtGkQFHsyXd8WEy3Syq5oSNHW9ph8
	 F9S1fw2W6nkBzCRSuihHkUf9UBSpe0yyo0NMrTQJHquMZ+f0KE6WkVvs8d+M8MUdhq
	 1mXCaWlFMnaFZ4BQkMm+tUdEHgTbWehmNrD0O44IkOimLf9lMTwJdMJHB+hiCEYYLe
	 8MWD37MgPrs0UH/ULtdDOm6rNCM+cBBuKaBCZlpv15MpgtFvAVXQqp+jEVwuFy3C09
	 hzSh1bMJX3QoaBd8Se+lomWtXhHUm0WVzUuNHP9m2hGSHgYa3VHWmYWKygEDGRG5+F
	 2UKJzFnT9XsJA==
Date: Fri, 15 Nov 2024 00:38:55 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf-next] selftests/bpf: set test path for token/obj_priv_implicit_token_envvar
Message-ID: <20241115003853.864397-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 0425275de50b34d359522147cbb07ae0e9d29707
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

token/obj_priv_implicit_token_envvar test may fail in an environment
where the process executing tests can not write to the root path.

Example:
https://github.com/libbpf/libbpf/actions/runs/11844507007/job/33007897936

Change default path used by the test to /tmp/bpf-token-fs, and make it
runtime configurable via an environment variable.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/prog_tests/token.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing=
/selftests/bpf/prog_tests/token.c
index fe86e4fdb89c..39f5414b674b 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -828,8 +828,11 @@ static int userns_obj_priv_btf_success(int mnt_fd, str=
uct token_lsm *lsm_skel)
 =09return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
=20
+static const char* token_bpffs_custom_dir() {
+=09return getenv("BPF_SELFTESTS_BPF_TOKEN_DIR") ? : "/tmp/bpf-token-fs";
+}
+
 #define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
-#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
=20
 static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *ls=
m_skel)
 {
@@ -892,6 +895,7 @@ static int userns_obj_priv_implicit_token(int mnt_fd, s=
truct token_lsm *lsm_skel
=20
 static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_=
lsm *lsm_skel)
 {
+=09const char *custom_dir =3D token_bpffs_custom_dir();
 =09LIBBPF_OPTS(bpf_object_open_opts, opts);
 =09struct dummy_st_ops_success *skel;
 =09int err;
@@ -909,10 +913,10 @@ static int userns_obj_priv_implicit_token_envvar(int =
mnt_fd, struct token_lsm *l
 =09 * BPF token implicitly, unless pointed to it through
 =09 * LIBBPF_BPF_TOKEN_PATH envvar
 =09 */
-=09rmdir(TOKEN_BPFFS_CUSTOM);
-=09if (!ASSERT_OK(mkdir(TOKEN_BPFFS_CUSTOM, 0777), "mkdir_bpffs_custom"))
+=09rmdir(custom_dir);
+=09if (!ASSERT_OK(mkdir(custom_dir, 0777), "mkdir_bpffs_custom"))
 =09=09goto err_out;
-=09err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, MOVE_M=
OUNT_F_EMPTY_PATH);
+=09err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, custom_dir, MOVE_MOUNT_F_E=
MPTY_PATH);
 =09if (!ASSERT_OK(err, "move_mount_bpffs"))
 =09=09goto err_out;
=20
@@ -925,7 +929,7 @@ static int userns_obj_priv_implicit_token_envvar(int mn=
t_fd, struct token_lsm *l
 =09=09goto err_out;
 =09}
=20
-=09err =3D setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/);
+=09err =3D setenv(TOKEN_ENVVAR, custom_dir, 1 /*overwrite*/);
 =09if (!ASSERT_OK(err, "setenv_token_path"))
 =09=09goto err_out;
=20
@@ -951,11 +955,11 @@ static int userns_obj_priv_implicit_token_envvar(int =
mnt_fd, struct token_lsm *l
 =09if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
 =09=09goto err_out;
=20
-=09rmdir(TOKEN_BPFFS_CUSTOM);
+=09rmdir(custom_dir);
 =09unsetenv(TOKEN_ENVVAR);
 =09return 0;
 err_out:
-=09rmdir(TOKEN_BPFFS_CUSTOM);
+=09rmdir(custom_dir);
 =09unsetenv(TOKEN_ENVVAR);
 =09return -EINVAL;
 }
--=20
2.47.0




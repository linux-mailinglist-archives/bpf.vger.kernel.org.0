Return-Path: <bpf+bounces-49435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CB4A18A4A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1EF167889
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0F152787;
	Wed, 22 Jan 2025 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IhoaM8s1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2814B96E
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514423; cv=none; b=FLq45s9D0S7dVkwzd0ik2tYRiqk3QL4rDUhQLfR6aNq4U1MwmaNF3u60DYRygfFgDgY029ECC8tdIpw3oEIxD+tlURSXIAsZoqJSNFv3UnEGfTiSwh7Fi9y7BuZCdCjGHNjRbDthkej3YUbQLm6ypCvQy9nGf5GXPv0m/d6VChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514423; c=relaxed/simple;
	bh=xAqaw2BUJcO536nFt71AdPBHKChLaJL7ngWt1UDyt80=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKaTF+nUh8Q3inh6xXovMUKDIvEA7Ed2lw7LAsMJ/ZZC82x8V5qbeRYWmVl8c8c4j6JQh+TR1R5fL5cslIqwu70zj4icSx3tII2ct6zAGGvntqP2ecuHPOUEYK3SsezArxDFJipDFnCJ6wFe3UxjXzaZCciBWT07IoGTxixr4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IhoaM8s1; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737514413; x=1737773613;
	bh=Hp4eoSnEzq6cNqXVgiEPKNvmaDvGNtz7bBI6dqq6QG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IhoaM8s1DsWyFHLgtKfYLecOFgodxr3vf1vs5xCwc4x0xQoB3VG5x12GzOm4KSm2U
	 w91gdAmk083Zu5jQUVdtwY5L62Cazpy6aBilYqASBN3CH6/+b4YPZaepkgk3hVmaNN
	 Qwb5i2SY+zO7jjeuWtey38GZjf9RCW+ZTYQdrvNmpCZNjfiD+Kb2MylwkorHuqXlmM
	 E/r1+Or/CJmKDTrILWWSZ34P8WkQEW3bNPtlefwtwz/mY0/zPc2zxXag9OZXTqs3s2
	 Ts+RI3VJC21mvAEMJAKZMSGyK/AonxHmcsGAKegOOHuBSKX+FNOl/hRdB7vFzAvYbl
	 Z0+Rl/8Pp5ncw==
Date: Wed, 22 Jan 2025 02:53:30 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next 3/5] selftests/bpf: add a btf_dump test for type_tags
Message-ID: <20250122025308.2717553-4-ihor.solodrai@pm.me>
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 04d9b5b65036e77f7e3a593b4d00747f7f9e0444
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Factor out common routines handling custom BTF from
test_btf_dump_incremental. Then use them in the
test_btf_dump_type_tags.

test_btf_dump_type_tags verifies that a type tag is dumped correctly
with respect to its kflag.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
 1 file changed, 111 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/test=
ing/selftests/bpf/prog_tests/btf_dump.c
index b293b8501fd6..690cf8cef7d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -126,26 +126,70 @@ static int test_btf_dump_case(int n, struct btf_dump_=
test_case *t)
 =09return err;
 }
=20
-static char *dump_buf;
-static size_t dump_buf_sz;
-static FILE *dump_buf_file;
+struct btf_dump__custom_btf_test {
+=09struct btf *btf;
+=09struct btf_dump *d;
+=09char *dump_buf;
+=09size_t dump_buf_sz;
+=09FILE *dump_buf_file;
+};
=20
-static void test_btf_dump_incremental(void)
+static void btf_dump__custom_btf_test__free(struct btf_dump__custom_btf_te=
st *t)
 {
-=09struct btf *btf =3D NULL;
-=09struct btf_dump *d =3D NULL;
-=09int id, err, i;
+=09fclose(t->dump_buf_file);
+=09free(t->dump_buf);
+=09btf_dump__free(t->d);
+=09btf__free(t->btf);
+}
=20
-=09dump_buf_file =3D open_memstream(&dump_buf, &dump_buf_sz);
-=09if (!ASSERT_OK_PTR(dump_buf_file, "dump_memstream"))
-=09=09return;
-=09btf =3D btf__new_empty();
-=09if (!ASSERT_OK_PTR(btf, "new_empty"))
+static int btf_dump__custom_btf_test__init(struct btf_dump__custom_btf_tes=
t *t)
+{
+=09t->dump_buf_file =3D open_memstream(&t->dump_buf, &t->dump_buf_sz);
+=09if (!ASSERT_OK_PTR(t->dump_buf_file, "dump_memstream"))
+=09=09return -1;
+=09t->btf =3D btf__new_empty();
+=09if (!ASSERT_OK_PTR(t->btf, "new_empty"))
 =09=09goto err_out;
-=09d =3D btf_dump__new(btf, btf_dump_printf, dump_buf_file, NULL);
-=09if (!ASSERT_OK(libbpf_get_error(d), "btf_dump__new"))
+=09t->d =3D btf_dump__new(t->btf, btf_dump_printf, t->dump_buf_file, NULL)=
;
+=09if (!ASSERT_OK(libbpf_get_error(t->d), "btf_dump__new"))
 =09=09goto err_out;
=20
+=09return 0;
+
+err_out:
+=09btf_dump__custom_btf_test__free(t);
+=09return -1;
+}
+
+static void btf_dump__custom_btf_test__dump_and_compare(
+=09=09struct btf_dump__custom_btf_test *t,
+=09=09const char *expected_output,
+=09=09const char *message)
+{
+=09int i, err;
+
+=09for (i =3D 1; i < btf__type_cnt(t->btf); i++) {
+=09=09err =3D btf_dump__dump_type(t->d, i);
+=09=09ASSERT_OK(err, "dump_type_ok");
+=09}
+
+=09fflush(t->dump_buf_file);
+=09t->dump_buf[t->dump_buf_sz] =3D 0; /* some libc implementations don't d=
o this */
+
+=09ASSERT_STREQ(t->dump_buf, expected_output, message);
+}
+
+static void test_btf_dump_incremental(void)
+{
+=09struct btf_dump__custom_btf_test t;
+=09struct btf *btf;
+=09int id, err;
+
+=09if (btf_dump__custom_btf_test__init(&t))
+=09=09return;
+
+=09btf =3D t.btf;
+
 =09/* First, generate BTF corresponding to the following C code:
 =09 *
 =09 * enum x;
@@ -182,15 +226,7 @@ static void test_btf_dump_incremental(void)
 =09err =3D btf__add_field(btf, "x", 4, 0, 0);
 =09ASSERT_OK(err, "field_ok");
=20
-=09for (i =3D 1; i < btf__type_cnt(btf); i++) {
-=09=09err =3D btf_dump__dump_type(d, i);
-=09=09ASSERT_OK(err, "dump_type_ok");
-=09}
-
-=09fflush(dump_buf_file);
-=09dump_buf[dump_buf_sz] =3D 0; /* some libc implementations don't do this=
 */
-
-=09ASSERT_STREQ(dump_buf,
+=09btf_dump__custom_btf_test__dump_and_compare(&t,
 "enum x;\n"
 "\n"
 "enum x {\n"
@@ -221,7 +257,7 @@ static void test_btf_dump_incremental(void)
 =09 * enum values don't conflict;
 =09 *
 =09 */
-=09fseek(dump_buf_file, 0, SEEK_SET);
+=09fseek(t.dump_buf_file, 0, SEEK_SET);
=20
 =09id =3D btf__add_struct(btf, "s", 4);
 =09ASSERT_EQ(id, 7, "struct_id");
@@ -232,14 +268,7 @@ static void test_btf_dump_incremental(void)
 =09err =3D btf__add_field(btf, "s", 6, 64, 0);
 =09ASSERT_OK(err, "field_ok");
=20
-=09for (i =3D 1; i < btf__type_cnt(btf); i++) {
-=09=09err =3D btf_dump__dump_type(d, i);
-=09=09ASSERT_OK(err, "dump_type_ok");
-=09}
-
-=09fflush(dump_buf_file);
-=09dump_buf[dump_buf_sz] =3D 0; /* some libc implementations don't do this=
 */
-=09ASSERT_STREQ(dump_buf,
+=09btf_dump__custom_btf_test__dump_and_compare(&t,
 "struct s___2 {\n"
 "=09enum x x;\n"
 "=09enum {\n"
@@ -248,11 +277,53 @@ static void test_btf_dump_incremental(void)
 "=09struct s s;\n"
 "};\n\n" , "c_dump1");
=20
-err_out:
-=09fclose(dump_buf_file);
-=09free(dump_buf);
-=09btf_dump__free(d);
-=09btf__free(btf);
+=09btf_dump__custom_btf_test__free(&t);
+}
+
+static void test_btf_dump_type_tags(void)
+{
+=09struct btf_dump__custom_btf_test t;
+=09struct btf *btf;
+=09int id, err;
+
+=09if (btf_dump__custom_btf_test__init(&t))
+=09=09return;
+
+=09btf =3D t.btf;
+
+=09/* Generate BTF corresponding to the following C code:
+=09 *
+=09 * struct s {
+=09 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
+=09 *   void __attribute__((void_attr)) *p2;
+=09 * };
+=09 *
+=09 */
+
+=09id =3D btf__add_type_tag(btf, "void_tag", 0);
+=09ASSERT_EQ(id, 1, "type_tag_id");
+=09id =3D btf__add_ptr(btf, id);
+=09ASSERT_EQ(id, 2, "void_ptr_id1");
+
+=09id =3D btf__add_type_attr(btf, "void_attr", 0);
+=09ASSERT_EQ(id, 3, "type_attr_id");
+=09id =3D btf__add_ptr(btf, id);
+=09ASSERT_EQ(id, 4, "void_ptr_id2");
+
+=09id =3D btf__add_struct(btf, "s", 8);
+=09ASSERT_EQ(id, 5, "struct_id");
+=09err =3D btf__add_field(btf, "p1", 2, 0, 0);
+=09ASSERT_OK(err, "field_ok1");
+=09err =3D btf__add_field(btf, "p2", 4, 0, 0);
+=09ASSERT_OK(err, "field_ok2");
+
+=09btf_dump__custom_btf_test__dump_and_compare(&t,
+"struct s {\n"
+"=09void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
+"=09void __attribute__((void_attr)) *p2;\n"
+"};\n\n", "dump_and_compare");
+
+=09btf_dump__custom_btf_test__free(&t);
 }
=20
 #define STRSIZE=09=09=09=094096
@@ -874,6 +945,9 @@ void test_btf_dump() {
 =09if (test__start_subtest("btf_dump: incremental"))
 =09=09test_btf_dump_incremental();
=20
+=09if (test__start_subtest("btf_dump: type_tags"))
+=09=09test_btf_dump_type_tags();
+
 =09btf =3D libbpf_find_kernel_btf();
 =09if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
 =09=09return;
--=20
2.48.1




Return-Path: <bpf+bounces-45788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A66E9DB0B6
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C2B21FB1
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C51DDEA;
	Thu, 28 Nov 2024 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="O3wckkW/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0924B34
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757077; cv=none; b=dtIU71CsePGSrXK/F6WNJGkHwm62OYhxa42W/oGfaEK+7q2ryRlpkzrPP7p1slPW6t3GI1ujCLXguywFc2Z1fGYgw9cCQ6pc7QiFyIeUdojZNnPQxDL8BUe2eIKadxwZ7OCK4ZmA4KCBBARQkxmiHQ+i6Z31SGa2UDHSq3Q8I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757077; c=relaxed/simple;
	bh=hTezoi4Y4xzFdPY93sZrzt/0tWwClRnM9FDioJqDyQk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIBOXrXk5PLkTNIB1mkBjGWeK5Wnd4q/JxGbLt7Z6+HXl9D0jQLffUbE1y9OBNSbuTm269xUwXMHR/7iGoCvuYfCbT9Sbu1H/BOE2NIVKwKa2WXZzsJbxPUM9eyPvWiaDrNszksV/GB9Gd6GLJ5z0YpE0KwuKtvla9gj5JAZZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=O3wckkW/; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757060; x=1733016260;
	bh=xFpiKjWglhVTpZuSM5IwuY0WaHeiv9m4wTkxcr93whQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O3wckkW/66vcKuCDlj8xh63RSg+s8NoRomS2S/Z+YdqlvQS5WVXURswZx17E3FBUj
	 DWZ+ylPxTu+TEa2GUIdreqQsIkKmPLhvYd0bppeSFz/LheZPVTJn6eU/DOS0hwys0f
	 Cwjax/ftWFgDbAj/QjBq/gmTZYPP7p0rGM9gXzROi8yInF3MQl+JB8ms04Fda0p+dS
	 57vQw/PLEYZ0kCk6jFjLh9AVBGmBCaf1tdQagHzyUJzif91hmv/BtsL65VOn28w3sf
	 VwkzjHm5U3TTYpM006SGz/qLbesN6n269uLP/lwsxlSG4KQm31OE87TacBrfPbNPK4
	 C+aM4Gpudl8zQ==
Date: Thu, 28 Nov 2024 01:24:17 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 8/9] btf_encoder: introduce btf_encoding_context
Message-ID: <20241128012341.4081072-9-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: af392d2d22b21d9dc7cba46a810445e6823d3dee
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Introduce a static struct holding global data necessary for BTF
encoding: elf_functions tables and btf_encoder structs.

The context has init()/exit() interface that should be used to
indicate when BTF encoding work has started and ended.

I considered freeing everything contained in the context exclusively
on exit(), however it turns out this unnecessarily increases max
RSS. Probably because the work done in btf_encoder__encode() requires
relatively more memory, and if encoders and tables are freed earlier,
that space is reused.

Compare:
    -j4: =09Maximum resident set size (kbytes): 868484
    -j8: =09Maximum resident set size (kbytes): 1003040
    -j16: =09Maximum resident set size (kbytes): 1039416
    -j32: =09Maximum resident set size (kbytes): 1145312
vs
    -j4: =09Maximum resident set size (kbytes): 972692
    -j8: =09Maximum resident set size (kbytes): 1043184
    -j16: =09Maximum resident set size (kbytes): 1081156
    -j32: =09Maximum resident set size (kbytes): 1218184

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 117 +++++++++++++++++++++++++++++++++++++-------------
 btf_encoder.h |   3 ++
 pahole.c      |  10 ++++-
 3 files changed, 98 insertions(+), 32 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 778481d..bd5a370 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -151,19 +151,73 @@ struct btf_kfunc_set_range {
 =09uint64_t end;
 };
=20
+static struct {
+=09bool initialized;
+
+=09/* In principle, multiple ELFs can be processed in one pahole
+=09 * run, so we have to store elf_functions table per ELF.
+=09 * An elf_functions struct is added to the list in
+=09 * btf_encoder__pre_load_module().
+=09 * The list is cleared at the end of btf_encoder__add_saved_funcs().
+=09 */
+=09struct list_head elf_functions_list;
+
+=09/* The mutex only needed for add/delete, as this can happen in
+=09 * multiple encoding threads.  A btf_encoder is added to this
+=09 * list in btf_encoder__new(), and removed in btf_encoder__delete().
+=09 * All encoders except the main one (`btf_encoder` in pahole.c)
+=09 * are deleted in pahole_threads_collect().
+=09 */
+=09pthread_mutex_t btf_encoder_list_lock;
+=09struct list_head btf_encoder_list;
+
+} btf_encoding_context;
+
+int btf_encoding_context__init(void)
+{
+=09int err =3D 0;
+
+=09if (btf_encoding_context.initialized) {
+=09=09fprintf(stderr, "%s was called while context is already initialized\=
n", __func__);
+=09=09err =3D -1;
+=09=09goto out;
+=09}
+
+=09INIT_LIST_HEAD(&btf_encoding_context.elf_functions_list);
+=09INIT_LIST_HEAD(&btf_encoding_context.btf_encoder_list);
+=09pthread_mutex_init(&btf_encoding_context.btf_encoder_list_lock, NULL);
+=09btf_encoding_context.initialized =3D true;
+
+out:
+=09return err;
+}
+
+static inline void btf_encoder__delete_all(void);
+static inline void elf_functions__delete_all(void);
+
+void btf_encoding_context__exit(void)
+{
+=09if (!btf_encoding_context.initialized) {
+=09=09fprintf(stderr, "%s was called while context is not initialized\n", =
__func__);
+=09=09return;
+=09}
+
+=09if (!list_empty(&btf_encoding_context.elf_functions_list))
+=09=09elf_functions__delete_all();
+
+=09if (!list_empty(&btf_encoding_context.btf_encoder_list))
+=09=09btf_encoder__delete_all();
+
+=09pthread_mutex_destroy(&btf_encoding_context.btf_encoder_list_lock);
+=09btf_encoding_context.initialized =3D false;
+}
=20
-/* In principle, multiple ELFs can be processed in one pahole run,
- * so we have to store elf_functions table per ELF.
- * An element is added to the list on btf_encoder__pre_load_module,
- * and removed after btf_encoder__encode is done.
- */
-static LIST_HEAD(elf_functions_list);
=20
 static struct elf_functions *elf_functions__get(Elf *elf)
 {
 =09struct list_head *pos;
=20
-=09list_for_each(pos, &elf_functions_list) {
+=09list_for_each(pos, &btf_encoding_context.elf_functions_list) {
 =09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
=20
 =09=09if (funcs->elf =3D=3D elf)
@@ -184,9 +238,8 @@ static inline void elf_functions__delete_all(void)
 {
 =09struct list_head *pos, *tmp;
=20
-=09list_for_each_safe(pos, tmp, &elf_functions_list) {
+=09list_for_each_safe(pos, tmp, &btf_encoding_context.elf_functions_list) =
{
 =09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
-
 =09=09elf_functions__delete(funcs);
 =09}
 }
@@ -215,7 +268,7 @@ int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf =
*elf)
 =09if (err)
 =09=09goto out_delete;
=20
-=09list_add_tail(&funcs->node, &elf_functions_list);
+=09list_add_tail(&funcs->node, &btf_encoding_context.elf_functions_list);
=20
 =09return 0;
=20
@@ -224,29 +277,21 @@ out_delete:
 =09return err;
 }
=20
-
-static LIST_HEAD(encoders);
-static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
-
-/* mutex only needed for add/delete, as this can happen in multiple encodi=
ng
- * threads.  Traversal of the list is currently confined to thread collect=
ion.
- */
-
 #define btf_encoders__for_each_encoder(encoder)=09=09\
-=09list_for_each_entry(encoder, &encoders, node)
+=09list_for_each_entry(encoder, &btf_encoding_context.btf_encoder_list, no=
de)
=20
 static void btf_encoders__add(struct btf_encoder *encoder)
 {
-=09pthread_mutex_lock(&encoders__lock);
-=09list_add_tail(&encoder->node, &encoders);
-=09pthread_mutex_unlock(&encoders__lock);
+=09pthread_mutex_lock(&btf_encoding_context.btf_encoder_list_lock);
+=09list_add_tail(&encoder->node, &btf_encoding_context.btf_encoder_list);
+=09pthread_mutex_unlock(&btf_encoding_context.btf_encoder_list_lock);
 }
=20
 static void btf_encoders__delete(struct btf_encoder *encoder)
 {
 =09struct btf_encoder *existing =3D NULL;
=20
-=09pthread_mutex_lock(&encoders__lock);
+=09pthread_mutex_lock(&btf_encoding_context.btf_encoder_list_lock);
 =09/* encoder may not have been added to list yet; check. */
 =09btf_encoders__for_each_encoder(existing) {
 =09=09if (encoder =3D=3D existing)
@@ -254,7 +299,7 @@ static void btf_encoders__delete(struct btf_encoder *en=
coder)
 =09}
 =09if (encoder =3D=3D existing)
 =09=09list_del(&encoder->node);
-=09pthread_mutex_unlock(&encoders__lock);
+=09pthread_mutex_unlock(&btf_encoding_context.btf_encoder_list_lock);
 }
=20
 #define PERCPU_SECTION ".data..percpu"
@@ -1355,19 +1400,15 @@ int btf_encoder__add_saved_funcs(struct btf_encoder=
 *encoder)
 =09=09list_for_each_entry(s, &e->func_states, node)
 =09=09=09nr_saved_fns++;
 =09}
-=09/* Another thread already did this work */
-=09if (nr_saved_fns =3D=3D 0) {
-=09=09printf("nothing to do for encoder...\n");
+
+=09if (nr_saved_fns =3D=3D 0)
 =09=09return 0;
-=09}
=20
-=09printf("got %d saved functions...\n", nr_saved_fns);
 =09saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
 =09btf_encoders__for_each_encoder(e) {
 =09=09list_for_each_entry(s, &e->func_states, node)
 =09=09=09saved_fns[i++] =3D s;
 =09}
-=09printf("added %d saved fns\n", i);
 =09qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
=20
 =09for (i =3D 0; i < nr_saved_fns; i =3D j) {
@@ -1399,6 +1440,9 @@ int btf_encoder__add_saved_funcs(struct btf_encoder *=
encoder)
 =09free(saved_fns);
 =09btf_encoders__for_each_encoder(e)
 =09=09btf_encoder__delete_saved_funcs(e);
+
+=09elf_functions__delete_all();
+
 =09return 0;
 }
=20
@@ -2177,7 +2221,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
=20
-=09elf_functions__delete_all();
 =09return err;
 }
=20
@@ -2564,6 +2607,18 @@ void btf_encoder__delete(struct btf_encoder *encoder=
)
 =09free(encoder);
 }
=20
+static inline void btf_encoder__delete_all(void)
+{
+=09struct btf_encoder *encoder;
+=09struct list_head *pos, *tmp;
+
+=09list_for_each_safe(pos, tmp, &btf_encoding_context.btf_encoder_list) {
+=09=09encoder =3D list_entry(pos, struct btf_encoder, node);
+=09=09btf_encoder__delete(encoder);
+=09}
+}
+
+
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, str=
uct conf_load *conf_load)
 {
 =09struct llvm_annotation *annot;
diff --git a/btf_encoder.h b/btf_encoder.h
index 29f652a..73d6e13 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -23,6 +23,9 @@ enum btf_var_option {
 =09BTF_VAR_GLOBAL =3D 2,
 };
=20
+int btf_encoding_context__init(void);
+void btf_encoding_context__exit(void);
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_f=
ilename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
diff --git a/pahole.c b/pahole.c
index b5aea56..6b46399 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3741,8 +3741,12 @@ int main(int argc, char *argv[])
 =09=09conf_load.threads_collect =3D pahole_threads_collect;
 =09}
=20
-=09if (btf_encode)
+=09if (btf_encode) {
 =09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
+=09=09err =3D btf_encoding_context__init();
+=09=09if (err < 0)
+=09=09=09goto out;
+=09}
=20
 =09// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 =09if (conf.header_type && !class_name && prettify_input) {
@@ -3858,7 +3862,11 @@ try_sole_arg_as_class_names:
 =09=09=09goto out_cus_delete;
 =09=09}
 =09}
+
 out_ok:
+=09if (btf_encode)
+=09=09btf_encoding_context__exit();
+
 =09if (stats_formatter !=3D NULL)
 =09=09print_stats();
=20
--=20
2.47.0




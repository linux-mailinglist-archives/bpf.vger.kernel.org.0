Return-Path: <bpf+bounces-45787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2A9DB0B5
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C85C165C55
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E41E885;
	Thu, 28 Nov 2024 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Wscrbc1S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D8847B
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757071; cv=none; b=dVDpxnKNAMfIPl5YyR0TpkPl9/snZgILGaUQwBKdP74m2o5eY4gvR+d/k2dvMLXIL7NNifRBeiSCvSFKsHplYYNBaRJ37cc4YwGhKLZV2lZ1E/FQKsjvaLdstXSKBajyMeqCw9iOu/MWkVdOEK1dLMLuKF/Z0xMn7CL+hVmaRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757071; c=relaxed/simple;
	bh=va/AvxkGDXvvYTji3ueWr+t8eHgX3elzvUDohACrD0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i61+urae1rObL8+R36fQ7Nwdew45fxA4wq9xe8s0jKwg9Pk7ACEOAYbcIdRckSBx3GdUJtVkCCrILQTTcYzy5iGPe0jkISa9XlDqIU/647G5JfwbNyyWpKICEXHhKvTD4dIMyYk7pWa+anUeEB/zu9+1PLlgI1lWWIb38jfBwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Wscrbc1S; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757066; x=1733016266;
	bh=xHmbHuArTO6h81NVuG8tXXx2QvNz08YnKtPTFkaMdH8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Wscrbc1SsRMKdP2kGyHKeOmTqVmh9ZBcgIPyPgLjLFGf/PH2V2YODBaMLLcukDN1M
	 RG+jCvX+quoZcuvg23x+OK5ogJGpwbsRk7KuYxpSRX7M2CB6/nqCGi5q74m5Hg6Boo
	 eAKN0LjyMSiRxcmLzgPVx5j7zn7791b59yPAuk0YZVf6oVBw3NJkXZQuPDjpBYCZcv
	 Cx2MqizxOm9TMkzc4dMvV4JeJVaZFKyLoap4v534doVNV5OkCbuT7nXw02+ljGQtsW
	 6E91oTyIp5egxhMEsrkpBus3u9WXWnAZ2QXENExIIuULV5trbbMSFeD2DRNEArI1eS
	 qk584xSkU97kw==
Date: Thu, 28 Nov 2024 01:24:21 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 9/9] pahole: faster reproducible BTF encoding
Message-ID: <20241128012341.4081072-10-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 60071cc7e39b03932cad94b999c26a2ab868f492
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Change multithreaded implementation of BTF encoding:

  * Use a single btf_encoder accumulating BTF for all compilation units
  * Make BTF encoding routine exclusive: only one thread at a time may
    execute btf_encoder__encode_cu
  * Introduce CU ids: an id is an index of a CU, in order they are
    created in dwarf_loader.c
  * Introduce CU__PROCESSED cu_state to inidicate what CUs have been
    processed by the encoder
  * Enforce encoding order of compilation units (struct cu) loaded
    from DWARF by utilizing global struct cus as a queue
  * reproducible_build option is now moot: BTF encoding is always
    reproducible with this change
  * Most of the code that merged the results of multiple BTF encoders
    into one BTF after CU processing is removed

Motivation behind this change and analysis that led to it are in the
cover letter to the patch series.

In short, this implementation of BTF encoding makes it reproducible
without sacrificing the performance gains from parallel
processing. The speed in terms of wall-clock time is comparable to
non-reproducible runs on pahole/next [1]. The memory footprint is
lower with increased number of threads.

pahole/next (12ca112):

            Performance counter stats for '/home/theihor/dev/dwarves/build/=
pahole -J -j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type=
_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=
=3D/dev/null --lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kb=
uild-output/.tmp_vmlinux1' (13 runs):

    50,493,244,369      cycles                                             =
                     ( +-  0.26% )

            1.6863 +- 0.0150 seconds time elapsed  ( +-  0.89% )

jobs 1, mem 546556 Kb, time 4.53 sec
jobs 2, mem 599776 Kb, time 2.81 sec
jobs 4, mem 661756 Kb, time 2.05 sec
jobs 8, mem 764584 Kb, time 1.58 sec
jobs 16, mem 844856 Kb, time 1.59 sec
jobs 32, mem 1047880 Kb, time 1.69 sec

This patchset on top of pahole/next:

 Performance counter stats for '/home/theihor/dev/dwarves/build/pahole -J -=
j24 --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimi=
zed_func,consistent_func,decl_tag_kfuncs --btf_encode_detached=3D/dev/null =
--lang_exclude=3Drust /home/theihor/git/kernel.org/bpf-next/kbuild-output/.=
tmp_vmlinux1' (13 runs):

    31,175,635,417      cycles                                             =
                     ( +-  0.22% )

           1.58644 +- 0.00501 seconds time elapsed  ( +-  0.32% )

jobs 1, mem 544780 Kb, time 4.47 sec
jobs 2, mem 553944 Kb, time 4.68 sec
jobs 4, mem 563352 Kb, time 2.36 sec
jobs 8, mem 585508 Kb, time 1.73 sec
jobs 16, mem 635212 Kb, time 1.61 sec
jobs 32, mem 772752 Kb, time 1.59 sec

[1]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dnex=
t&id=3D12ca11281912c272f931e836b9160ee827250716

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 dwarf_loader.c |   4 +
 dwarves.c      |  47 ++++-----
 dwarves.h      |   5 +-
 pahole.c       | 255 +++++++++++++++++++------------------------------
 4 files changed, 127 insertions(+), 184 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5d55649..86f8b92 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3440,6 +3440,7 @@ struct dwarf_cus {
 =09int=09=09    build_id_len;
 =09int=09=09    error;
 =09struct dwarf_cu=09    *type_dcu;
+=09uint32_t=09nr_cus_created;
 };
=20
 struct dwarf_thread {
@@ -3472,6 +3473,9 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct d=
warf_cus *dcus, Dwarf_Die *
 =09cu->priv =3D dcu;
 =09cu->dfops =3D &dwarf__ops;
=20
+=09cu->id =3D dcus->nr_cus_created;
+=09dcus->nr_cus_created++;
+
 =09return dcu;
 }
=20
diff --git a/dwarves.c b/dwarves.c
index ae512b9..e8701ba 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -537,39 +537,18 @@ void cus__set_cu_state(struct cus *cus, struct cu *cu=
, enum cu_state state)
 =09cus__unlock(cus);
 }
=20
-// Used only when reproducible builds are desired
-struct cu *cus__get_next_processable_cu(struct cus *cus)
+struct cu *cus__get_cu_by_id(struct cus *cus, uint32_t id)
 {
-=09struct cu *cu;
-
+=09struct cu *cu, *result =3D NULL;
 =09cus__lock(cus);
-
 =09list_for_each_entry(cu, &cus->cus, node) {
-=09=09switch (cu->state) {
-=09=09case CU__LOADED:
-=09=09=09cu->state =3D CU__PROCESSING;
-=09=09=09goto found;
-=09=09case CU__PROCESSING:
-=09=09=09// This will happen when we get to parallel
-=09=09=09// reproducible BTF encoding, libbpf dedup work needed
-=09=09=09// here. The other possibility is when we're flushing
-=09=09=09// the DWARF processed CUs when the parallel DWARF
-=09=09=09// loading stoped and we still have CUs to encode to
-=09=09=09// BTF because of ordering requirements.
-=09=09=09continue;
-=09=09case CU__UNPROCESSED:
-=09=09=09// The first entry isn't loaded, signal the
-=09=09=09// caller to return and try another day, as we
-=09=09=09// need to respect the original DWARF CU ordering.
-=09=09=09goto out;
+=09=09if (cu->id =3D=3D id) {
+=09=09=09result =3D cu;
+=09=09=09break;
 =09=09}
 =09}
-out:
-=09cu =3D NULL;
-found:
 =09cus__unlock(cus);
-
-=09return cu;
+=09return result;
 }
=20
 bool cus__empty(const struct cus *cus)
@@ -610,6 +589,20 @@ void cus__add(struct cus *cus, struct cu *cu)
 =09cu__find_class_holes(cu);
 }
=20
+void cus__remove_processed_cus(struct cus *cus)
+{
+=09struct cu *cu, *tmp;
+
+=09cus__lock(cus);
+=09list_for_each_entry_safe(cu, tmp, &cus->cus, node) {
+=09=09if (cu->state =3D=3D CU__PROCESSED) {
+=09=09=09__cus__remove(cus, cu);
+=09=09=09cu__delete(cu);
+=09=09}
+=09}
+=09cus__unlock(cus);
+}
+
 static void ptr_table__init(struct ptr_table *pt)
 {
 =09pt->entries =3D NULL;
diff --git a/dwarves.h b/dwarves.h
index 1a0bd4b..8af4045 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -49,6 +49,7 @@ enum cu_state {
 =09CU__UNPROCESSED,
 =09CU__LOADED,
 =09CU__PROCESSING,
+=09CU__PROCESSED,
 };
=20
 /*
@@ -194,8 +195,9 @@ void cus__add(struct cus *cus, struct cu *cu);
=20
 void __cus__remove(struct cus *cus, struct cu *cu);
 void cus__remove(struct cus *cus, struct cu *cu);
+void cus__remove_processed_cus(struct cus *cus);
=20
-struct cu *cus__get_next_processable_cu(struct cus *cus);
+struct cu *cus__get_cu_by_id(struct cus *cus, uint32_t id);
=20
 void cus__set_cu_state(struct cus *cus, struct cu *cu, enum cu_state state=
);
=20
@@ -297,6 +299,7 @@ struct cu {
 =09struct ptr_table functions_table;
 =09struct ptr_table tags_table;
 =09struct rb_root=09 functions;
+=09uint32_t=09 id;
 =09const char=09 *name;
 =09char=09=09 *filename;
 =09void =09=09 *priv;
diff --git a/pahole.c b/pahole.c
index 6b46399..f56c66f 100644
--- a/pahole.c
+++ b/pahole.c
@@ -94,6 +94,7 @@ static struct conf_fprintf conf =3D {
=20
 static struct conf_load conf_load =3D {
 =09.conf_fprintf =3D &conf,
+=09.nr_jobs =3D 1,
 };
=20
 struct structure {
@@ -3136,12 +3137,10 @@ static bool print_enumeration_with_enumerator(struc=
t cu *cu, const char *name)
 =09return false;
 }
=20
-struct thread_data {
-=09struct btf *btf;
-=09struct btf_encoder *encoder;
-};
+// not used yet
+struct thread_data { int dummy; };
=20
-static int pahole_threads_prepare_reproducible_build(struct conf_load *con=
f, int nr_threads, void **thr_data)
+static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, =
void **thr_data)
 {
 =09for (int i =3D 0; i < nr_threads; i++)
 =09=09thr_data[i] =3D NULL;
@@ -3149,17 +3148,6 @@ static int pahole_threads_prepare_reproducible_build=
(struct conf_load *conf, int
 =09return 0;
 }
=20
-static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, =
void **thr_data)
-{
-=09int i;
-=09struct thread_data *threads =3D calloc(sizeof(struct thread_data), nr_t=
hreads);
-
-=09for (i =3D 0; i < nr_threads; i++)
-=09=09thr_data[i] =3D threads + i;
-
-=09return 0;
-}
-
 static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
 {
 =09struct thread_data *thread =3D thr_data;
@@ -3179,7 +3167,6 @@ static int pahole_threads_collect(struct conf_load *c=
onf, int nr_threads, void *
 =09=09=09=09  int error)
 {
 =09struct thread_data **threads =3D (struct thread_data **)thr_data;
-=09int i;
 =09int err =3D 0;
=20
 =09if (error)
@@ -3189,29 +3176,97 @@ static int pahole_threads_collect(struct conf_load =
*conf, int nr_threads, void *
 =09if (err < 0)
 =09=09goto out;
=20
-=09for (i =3D 0; i < nr_threads; i++) {
-=09=09/*
-=09=09 * Merge content of the btf instances of worker threads to the btf
-=09=09 * instance of the primary btf_encoder.
-                */
-=09=09if (!threads[i]->encoder || !threads[i]->btf)
-=09=09=09continue;
-=09=09err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
-=09=09if (err < 0)
-=09=09=09goto out;
+out:
+=09free(threads[0]);
+
+=09return err;
+}
+
+static inline void btf_encoder__init(struct cu *cu, struct conf_load *conf=
_load)
+{
+=09btf_encoder =3D btf_encoder__new(cu,
+=09=09=09=09       detached_btf_filename,
+=09=09=09=09       conf_load->base_btf,
+=09=09=09=09       global_verbose,
+=09=09=09=09       conf_load);
+=09if (!btf_encoder) {
+=09=09fprintf(stderr, "Error creating BTF encoder.\n");
+=09=09exit(1);
 =09}
-=09err =3D 0;
+}
=20
-out:
-=09for (i =3D 0; i < nr_threads; i++) {
-=09=09if (threads[i]->encoder && threads[i]->encoder !=3D btf_encoder) {
-=09=09=09btf_encoder__delete(threads[i]->encoder);
-=09=09=09threads[i]->encoder =3D NULL;
+static enum load_steal_kind pahole_stealer__threaded_btf_encode(struct cu =
*cu, struct conf_load *conf_load)
+{
+=09static pthread_mutex_t btf_encode_lock =3D PTHREAD_MUTEX_INITIALIZER;
+=09static uint32_t next_cu_id_to_encode;
+
+=09struct cu *cu_to_encode =3D NULL;
+=09int encoding_ret;
+
+=09if (pthread_mutex_trylock(&btf_encode_lock) !=3D 0) {
+=09=09/* Another thread is busy encoding.
+=09=09 * Check the number of CUs in queue, and if it's too high, wait.
+=09=09 */
+=09=09while (cus__nr_entries(cus) >=3D conf_load->nr_jobs - 1) {
+=09=09=09usleep(1000);
+=09=09=09cus__remove_processed_cus(cus);
 =09=09}
+=09=09goto out;
 =09}
-=09free(threads[0]);
=20
-=09return err;
+=09/* Got the lock: check whether btf_encoder has already been created */
+=09if (!btf_encoder) {
+=09=09if (cu->id =3D=3D 0)
+=09=09=09btf_encoder__init(cu, conf_load);
+=09=09goto out_unlock;
+=09}
+
+=09/* Proceed to encoding in order of cu->id
+=09 * cus->cus serves as a queue of loaded cu-s
+=09 * Keep encoding until a cu with expected id is not yet loaded
+=09 */
+=09do {
+=09=09cu_to_encode =3D cus__get_cu_by_id(cus, next_cu_id_to_encode);
+=09=09if (!cu_to_encode || cu_to_encode->state !=3D CU__LOADED)
+=09=09=09break;
+
+=09=09encoding_ret =3D btf_encoder__encode_cu(btf_encoder,
+=09=09=09=09=09=09      cu_to_encode,
+=09=09=09=09=09=09      conf_load);
+=09=09if (encoding_ret < 0) {
+=09=09=09fprintf(stderr, "Encountered error while encoding BTF.\n");
+=09=09=09exit(1);
+=09=09}
+
+=09=09cus__set_cu_state(cus, cu_to_encode, CU__PROCESSED);
+=09=09next_cu_id_to_encode++;
+=09} while (true);
+
+out_unlock:
+=09pthread_mutex_unlock(&btf_encode_lock);
+out:
+=09// always keep incoming CUs
+=09// they will be deleted by cus__remove_processed_cus()
+=09return LSK__KEEPIT;
+}
+
+static enum load_steal_kind pahole_stealer__btf_encode(struct cu *cu, stru=
ct conf_load *conf_load)
+{
+=09int ret;
+
+=09if (!btf_encoder)
+=09=09btf_encoder__init(cu, conf_load);
+
+=09ret =3D btf_encoder__encode_cu(btf_encoder, cu, conf_load);
+=09if (ret < 0) {
+=09=09fprintf(stderr, "Encountered error while encoding BTF.\n");
+=09=09exit(1);
+=09}
+
+=09// This has no meaning for a single thread, but let's be consistent
+=09cus__set_cu_state(cus, cu, CU__PROCESSED);
+
+=09return ret;
 }
=20
 static enum load_steal_kind pahole_stealer(struct cu *cu,
@@ -3238,94 +3293,10 @@ static enum load_steal_kind pahole_stealer(struct c=
u *cu,
 =09=09return LSK__DELETE; // Maybe we can find this in several CUs, so don=
't stop it
=20
 =09if (btf_encode) {
-=09=09static pthread_mutex_t btf_lock =3D PTHREAD_MUTEX_INITIALIZER;
-=09=09struct btf_encoder *encoder;
-
-=09=09pthread_mutex_lock(&btf_lock);
-=09=09/*
-=09=09 * FIXME:
-=09=09 *
-=09=09 * This should be really done at main(), but since in the current co=
debase only at this
-=09=09 * point we'll have cu->elf setup...
-=09=09 */
-=09=09if (!btf_encoder) {
-=09=09=09/*
-=09=09=09 * btf_encoder is the primary encoder.
-=09=09=09 * And, it is used by the thread
-=09=09=09 * create it.
-=09=09=09 */
-=09=09=09btf_encoder =3D btf_encoder__new(cu, detached_btf_filename, conf_=
load->base_btf,
-=09=09=09=09=09=09       global_verbose, conf_load);
-=09=09=09if (btf_encoder && thr_data) {
-=09=09=09=09struct thread_data *thread =3D thr_data;
-
-=09=09=09=09thread->encoder =3D btf_encoder;
-=09=09=09=09thread->btf =3D btf_encoder__btf(btf_encoder);
-=09=09=09}
-=09=09}
-
-=09=09// Reproducible builds don't have multiple btf_encoders, so we need =
to keep the lock until we encode BTF for this CU.
-=09=09if (thr_data)
-=09=09=09pthread_mutex_unlock(&btf_lock);
-
-=09=09if (!btf_encoder) {
-=09=09=09ret =3D LSK__STOP_LOADING;
-=09=09=09goto out_btf;
-=09=09}
-
-=09=09/*
-=09=09 * thr_data keeps per-thread data for worker threads.  Each worker t=
hread
-=09=09 * has an encoder.  The main thread will merge the data collected by=
 all
-=09=09 * these encoders to btf_encoder.  However, the first thread reachin=
g this
-=09=09 * function creates btf_encoder and reuses it as its local encoder. =
 It
-=09=09 * avoids copying the data collected by the first thread.
-=09=09 */
-=09=09if (thr_data) {
-=09=09=09struct thread_data *thread =3D thr_data;
-
-=09=09=09if (thread->encoder =3D=3D NULL) {
-=09=09=09=09thread->encoder =3D
-=09=09=09=09=09btf_encoder__new(cu, detached_btf_filename,
-=09=09=09=09=09=09=09 NULL,
-=09=09=09=09=09=09=09 global_verbose,
-=09=09=09=09=09=09=09 conf_load);
-=09=09=09=09thread->btf =3D btf_encoder__btf(thread->encoder);
-=09=09=09}
-=09=09=09encoder =3D thread->encoder;
-=09=09} else {
-=09=09=09encoder =3D btf_encoder;
-=09=09}
-
-=09=09// Since we don't have yet a way to parallelize the BTF encoding, we
-=09=09// need to ask the loader for the next CU that we can process, one
-=09=09// that is loaded and is in order, if the next one isn't yet loaded,
-=09=09// then return to let the DWARF loader thread to load the next one,
-=09=09// eventually all will get processed, even if when all DWARF loading
-=09=09// threads finish.
-=09=09if (conf_load->reproducible_build) {
-=09=09=09ret =3D LSK__KEEPIT; // we're not processing the cu passed to thi=
s
-=09=09=09=09=09  // function, so keep it.
-=09=09=09cu =3D cus__get_next_processable_cu(cus);
-=09=09=09if (cu =3D=3D NULL)
-=09=09=09=09goto out_btf;
-=09=09}
-
-=09=09ret =3D btf_encoder__encode_cu(encoder, cu, conf_load);
-=09=09if (ret < 0) {
-=09=09=09fprintf(stderr, "Encountered error while encoding BTF.\n");
-=09=09=09exit(1);
-=09=09}
-
-=09=09if (conf_load->reproducible_build) {
-=09=09=09ret =3D LSK__KEEPIT; // we're not processing the cu passed to thi=
s function, so keep it.
-=09=09=09// Kinda equivalent to LSK__DELETE since we processed this, but w=
e can't delete it
-=09=09=09// as we stash references to entries in CUs for 'struct function'=
 in btf_encoder__add_saved_funcs()
-=09=09=09// and btf_encoder__save_func(), so we can't delete them here. - =
Alan Maguire
-=09=09}
-out_btf:
-=09=09if (!thr_data) // See comment about reproducibe_build above
-=09=09=09pthread_mutex_unlock(&btf_lock);
-=09=09return ret;
+=09=09if (conf_load->nr_jobs > 1)
+=09=09=09return pahole_stealer__threaded_btf_encode(cu, conf_load);
+=09=09else
+=09=09=09return pahole_stealer__btf_encode(cu, conf_load);
 =09}
 #if 0
 =09if (ctf_encode) {
@@ -3625,24 +3596,6 @@ out_free:
 =09return ret;
 }
=20
-static int cus__flush_reproducible_build(struct cus *cus, struct btf_encod=
er *encoder, struct conf_load *conf_load)
-{
-=09int err =3D 0;
-
-=09while (true) {
-=09=09struct cu *cu =3D cus__get_next_processable_cu(cus);
-
-=09=09if (cu =3D=3D NULL)
-=09=09=09break;
-
-=09=09err =3D btf_encoder__encode_cu(encoder, cu, conf_load);
-=09=09if (err < 0)
-=09=09=09break;
-=09}
-
-=09return err;
-}
-
 int main(int argc, char *argv[])
 {
 =09int err, remaining, rc =3D EXIT_FAILURE;
@@ -3731,18 +3684,12 @@ int main(int argc, char *argv[])
 =09if (languages.exclude)
 =09=09conf_load.early_cu_filter =3D cu__filter;
=20
-=09conf_load.thread_exit =3D pahole_thread_exit;
-
-=09if (conf_load.reproducible_build) {
-=09=09conf_load.threads_prepare =3D pahole_threads_prepare_reproducible_bu=
ild;
-=09=09conf_load.threads_collect =3D NULL;
-=09} else {
+=09if (btf_encode) {
+=09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
 =09=09conf_load.threads_prepare =3D pahole_threads_prepare;
 =09=09conf_load.threads_collect =3D pahole_threads_collect;
-=09}
+=09=09conf_load.thread_exit =3D pahole_thread_exit;
=20
-=09if (btf_encode) {
-=09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
 =09=09err =3D btf_encoding_context__init();
 =09=09if (err < 0)
 =09=09=09goto out;
@@ -3847,13 +3794,9 @@ try_sole_arg_as_class_names:
 =09header =3D NULL;
=20
 =09if (btf_encode && btf_encoder) { // maybe all CUs were filtered out and=
 thus we don't have an encoder?
-=09=09if (conf_load.reproducible_build &&
-=09=09    cus__flush_reproducible_build(cus, btf_encoder, &conf_load) < 0)=
 {
-=09=09=09fprintf(stderr, "Encountered error while encoding BTF.\n");
-=09=09=09exit(1);
-=09=09}
=20
-=09=09if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
+=09=09// pahole_threads_collect() is not called in single-threaded runs
+=09=09if (conf_load.nr_jobs <=3D 1)
 =09=09=09btf_encoder__add_saved_funcs(btf_encoder);
=20
 =09=09err =3D btf_encoder__encode(btf_encoder);
--=20
2.47.0




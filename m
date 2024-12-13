Return-Path: <bpf+bounces-46933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898159F193D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C254D163F7E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58821AA1EB;
	Fri, 13 Dec 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Z4y+TdlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E31990C4
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129469; cv=none; b=iNLzWJa4k5yZ16OcNJynEqmw13ZqZjcxb/KusvbDGM59jmnKgSs2ZeKH4jez1ClIXderec5+OqZ0WKh22hUTUtbhhRRdBKK6jz7saYEkOz9z4b6NHjhcIWlRY08DMVWbklJbRhMG9yJR9DDb4BEZp5qNvpdjDzmu0B4Tzoxu4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129469; c=relaxed/simple;
	bh=emACkQg9LqjNFj2vmhwrd6Aau4SzqZ3keBKv3QKikLA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EScAugLVcPEiGUo9DfL12bWlknHz0fFczxpIdbj2VKVF5gvirs76ZFQ8K98g+XgByxSPee7Rc5+jEtCnS6SfAAlXRrqNm3AA2TTEqBt7W/By1adXhTEdIblR7G+G3lixb55lxSCFdwdXSL8G0Bux2bu2ULO4fryJJCfTfmhXIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Z4y+TdlW; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129457; x=1734388657;
	bh=On8nxGD1xWDIOCqynwXUmxU24owv8pJRaUs8s0Ql1fk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Z4y+TdlW9KROhto8gzPs2/MFtjoI6dQdJZnKCr7uIHjlBbLpIydRu+r/AcW+fdXkw
	 SlVqO60WjO9oEaStMh9t5bW39pnFH6ocADGXZiOaGqTW3DdHt1Bn4xCIS6GkDq/b0h
	 AsRdMZy6A7yw9MV4ZfbB7IeV+5tN/NF0hAOGz3B/6utN3mcZHbTnSZjA8eRwmeIDAa
	 ZcauVssDRUC2FBLnPwd/jd3vfP8N9l5Hs3pUXdXrdJlyqQvdvf/C/8CxN9HVXrf4KX
	 MrtCEP1V8M9uudvtsNZWMPq/4TW46sme+dZI9Ew0T/1n6lGmoTxkIxFl9x9jRCdlX1
	 6iznsSyjvL0CQ==
Date: Fri, 13 Dec 2024 22:37:34 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a job/worker model
Message-ID: <20241213223641.564002-11-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 690993f45348b55758560441996a916308833f54
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a re-implementation of an idea described in a RFC [1], and
tried in a patch there [2].

The gist of this patch is that multithreading is now contained in
dwarf_loader.c, and is implemented using a jobs queue and a pool of
worker threads. As a consequence, multithreading-related code is
removed from pahole.c.

A single-thread special case is removed: queueing setup works fine
with a single worker, which will switch between jobs as appropriate.

Code supporting previous version of the multithreading, such as
cu_state, thread_data and related functions, is also removed.

reproducible_build flag is now moot: the BTF encoding is always
reproducible with these changes.

The goal outlined in the RFC [1] - making parallel reproducible BTF
generation as fast as non-reproducible - is achieved by implementing
the requirement of ordered CU encoding (stealing) directly in the job
queue in dwarf_loader.c

The synchronization in the queue is implemented by a mutex (which
ensures consistency of queue state) and two condition variables:
job_added and job_taken. Motivation behind using condition variables
is a classic one: we want to avoid the threads checking the state of
the queue in a busy loop, competing for a single mutex.

[1] https://lore.kernel.org/dwarves/20241128012341.4081072-1-ihor.solodrai@=
pm.me/
[2] https://lore.kernel.org/dwarves/20241128012341.4081072-10-ihor.solodrai=
@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c               |   8 +-
 btf_encoder.h               |   6 +-
 btf_loader.c                |   2 +-
 ctf_loader.c                |   2 +-
 dwarf_loader.c              | 342 +++++++++++++++++++++++++-----------
 dwarves.c                   |  44 -----
 dwarves.h                   |  21 +--
 pahole.c                    | 236 +++----------------------
 pdwtags.c                   |   3 +-
 pfunct.c                    |   3 +-
 tests/reproducible_build.sh |   5 +-
 11 files changed, 281 insertions(+), 391 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0b71498..20befd6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -163,8 +163,6 @@ static struct {
 =09/* The mutex only needed for add/delete, as this can happen in
 =09 * multiple encoding threads.  A btf_encoder is added to this
 =09 * list in btf_encoder__new(), and removed in btf_encoder__delete().
-=09 * All encoders except the main one (`btf_encoder` in pahole.c)
-=09 * are deleted in pahole_threads_collect().
 =09 */
 =09pthread_mutex_t btf_encoder_list_lock;
 =09struct list_head btf_encoder_list;
@@ -1378,7 +1376,7 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09}
 }
=20
-int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
+static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_pr=
oto)
 {
 =09struct btf_encoder_func_state **saved_fns, *s;
 =09struct btf_encoder *e =3D NULL;
@@ -2170,12 +2168,14 @@ out:
 =09return err;
 }
=20
-int btf_encoder__encode(struct btf_encoder *encoder)
+int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *con=
f)
 {
 =09bool should_tag_kfuncs;
 =09int err;
 =09size_t shndx;
=20
+=09btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsistent_proto=
);
+
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
 =09=09=09btf_encoder__add_datasec(encoder, shndx);
diff --git a/btf_encoder.h b/btf_encoder.h
index 421cde1..1575b61 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -29,15 +29,11 @@ void btf_encoding_context__exit(void);
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_f=
ilename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
-int btf_encoder__encode(struct btf_encoder *encoder);
-
+int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *con=
f);
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, str=
uct conf_load *conf_load);
=20
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
-int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
-int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto);
-
 int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
=20
 #endif /* _BTF_ENCODER_H_ */
diff --git a/btf_loader.c b/btf_loader.c
index 4814f29..cff0011 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -730,7 +730,7 @@ static int cus__load_btf(struct cus *cus, struct conf_l=
oad *conf, const char *fi
 =09 * The app stole this cu, possibly deleting it,
 =09 * so forget about it
 =09 */
-=09if (conf && conf->steal && conf->steal(cu, conf, NULL))
+=09if (conf && conf->steal && conf->steal(cu, conf))
 =09=09return 0;
=20
 =09cus__add(cus, cu);
diff --git a/ctf_loader.c b/ctf_loader.c
index 944bf6e..501c4ab 100644
--- a/ctf_loader.c
+++ b/ctf_loader.c
@@ -728,7 +728,7 @@ int ctf__load_file(struct cus *cus, struct conf_load *c=
onf,
 =09 * The app stole this cu, possibly deleting it,
 =09 * so forget about it
 =09 */
-=09if (conf && conf->steal && conf->steal(cu, conf, NULL))
+=09if (conf && conf->steal && conf->steal(cu, conf))
 =09=09return 0;
=20
 =09cus__add(cus, cu);
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 58b165d..6d22648 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3250,24 +3250,20 @@ static void cu__sort_types_by_offset(struct cu *cu,=
 struct conf_load *conf)
 =09cu__for_all_tags(cu, type__sort_by_offset, conf);
 }
=20
-static int cu__finalize(struct cu *cu, struct cus *cus, struct conf_load *=
conf, void *thr_data)
+static void cu__finalize(struct cu *cu, struct cus *cus, struct conf_load =
*conf)
 {
 =09cu__for_all_tags(cu, class_member__cache_byte_size, conf);
=20
 =09if (cu__language_reorders_offsets(cu))
 =09=09cu__sort_types_by_offset(cu, conf);
-
-=09cus__set_cu_state(cus, cu, CU__LOADED);
-
-=09if (conf && conf->steal) {
-=09=09return conf->steal(cu, conf, thr_data);
-=09}
-=09return LSK__KEEPIT;
 }
=20
-static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_load =
*conf, void *thr_data)
+static int cus__steal_now(struct cus *cus, struct cu *cu, struct conf_load=
 *conf)
 {
-=09int lsk =3D cu__finalize(cu, cus, conf, thr_data);
+=09if (!conf || !conf->steal)
+=09=09return 0;
+
+=09int lsk =3D conf->steal(cu, conf);
 =09switch (lsk) {
 =09case LSK__DELETE:
 =09=09cus__remove(cus, cu);
@@ -3443,11 +3439,145 @@ struct dwarf_cus {
 =09uint32_t=09nr_cus_created;
 };
=20
-struct dwarf_thread {
-=09struct dwarf_cus=09*dcus;
-=09void=09=09=09*data;
+/* Multithreading is implemented using a job/worker model.
+ * cus_processing_queue represents a collection of jobs to be
+ * completed by workers.
+ * dwarf_loader__worker_thread is the worker loop, taking jobs from
+ * the queue and executing them.
+ * Implementation of this queue ensures two constraints:
+ *   * JOB_STEAL jobs for a CU are executed in the order of cu->id, as
+ *     a consequence JOB_STEAL jobs always run one at a time.
+ *   * Workers are limited by max_decoded_cus: a worker will not pick
+ *     up a new JOB_DECODE if this limit is exceeded. It'll wait.
+ */
+static struct {
+=09pthread_mutex_t mutex;
+=09pthread_cond_t job_added;
+=09pthread_cond_t job_taken;
+=09/* next_cu_id determines the next CU ready to be stealed
+=09 * This enforces the order of CU stealing.
+=09 */
+=09uint32_t next_cu_id;
+=09/* max_decoded_cus is a soft limit on the number of JOB_STEAL
+=09 * jobs currently in the queue (this number is equal to the
+=09 * number of decoded CUs held in memory). It's soft, because a
+=09 * worker thread may finish decoding it's current CU after
+=09 * this limit has already been reached. In such situation,
+=09 * JOB_STEAL with this CU is still added to the queue,
+=09 * although a worker will not pick up a new JOB_DECODE.
+=09 * So the real hard limit is max_decoded_cus + nr_workers.
+=09 * This variable indirectly limits the memory usage.
+=09 */
+=09uint16_t max_decoded_cus;
+=09uint16_t nr_decoded_cus;
+=09struct list_head jobs;
+} cus_processing_queue;
+
+enum job_type {
+=09JOB_NONE =3D 0,
+=09JOB_DECODE =3D 1,
+=09JOB_STEAL =3D 2,
 };
=20
+struct cu_processing_job {
+=09struct list_head node;
+=09enum job_type type;
+=09struct cu *cu; /* for stealing jobs */
+};
+
+static void cus_queue__init(uint16_t max_decoded_cus)
+{
+=09pthread_mutex_init(&cus_processing_queue.mutex, NULL);
+=09pthread_cond_init(&cus_processing_queue.job_added, NULL);
+=09pthread_cond_init(&cus_processing_queue.job_taken, NULL);
+=09INIT_LIST_HEAD(&cus_processing_queue.jobs);
+=09cus_processing_queue.max_decoded_cus =3D max_decoded_cus;
+=09cus_processing_queue.nr_decoded_cus =3D 0;
+=09cus_processing_queue.next_cu_id =3D 0;
+}
+
+static void cus_queue__destroy(void)
+{
+=09pthread_mutex_destroy(&cus_processing_queue.mutex);
+=09pthread_cond_destroy(&cus_processing_queue.job_added);
+=09pthread_cond_destroy(&cus_processing_queue.job_taken);
+}
+
+static inline void cus_queue__inc_next_cu_id(void)
+{
+=09pthread_mutex_lock(&cus_processing_queue.mutex);
+=09cus_processing_queue.next_cu_id++;
+=09pthread_mutex_unlock(&cus_processing_queue.mutex);
+}
+
+static void cus_queue__enqueue_job(struct cu_processing_job *job)
+{
+=09if (job =3D=3D NULL)
+=09=09return;
+
+=09pthread_mutex_lock(&cus_processing_queue.mutex);
+
+=09/* JOB_STEAL have higher priority, add them to the head so
+=09 * they can be found faster
+=09 */
+=09if (job->type =3D=3D JOB_STEAL) {
+=09=09list_add(&job->node, &cus_processing_queue.jobs);
+=09=09cus_processing_queue.nr_decoded_cus++;
+=09} else {
+=09=09list_add_tail(&job->node, &cus_processing_queue.jobs);
+=09}
+
+=09pthread_cond_signal(&cus_processing_queue.job_added);
+=09pthread_mutex_unlock(&cus_processing_queue.mutex);
+}
+
+static struct cu_processing_job *cus_queue__dequeue_job(void)
+{
+=09struct cu_processing_job *job, *dequeued_job =3D NULL;
+=09struct list_head *pos, *tmp;
+
+=09pthread_mutex_lock(&cus_processing_queue.mutex);
+=09while (list_empty(&cus_processing_queue.jobs))
+=09=09pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_q=
ueue.mutex);
+
+=09/* First, try to find JOB_STEAL for the next CU */
+=09list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
+=09=09job =3D list_entry(pos, struct cu_processing_job, node);
+=09=09if (job->type =3D=3D JOB_STEAL && job->cu->id =3D=3D cus_processing_=
queue.next_cu_id) {
+=09=09=09list_del(&job->node);
+=09=09=09cus_processing_queue.nr_decoded_cus--;
+=09=09=09dequeued_job =3D job;
+=09=09=09break;
+=09=09}
+=09}
+
+=09/* If no JOB_STEAL is found, check if we are allowed to decode
+=09 * more CUs.  If not, it means that the CU with next_cu_id is
+=09 * still being decoded while the queue is "full". Wait.
+=09 * job_taken will signal that another thread was able to pick
+=09 * up a JOB_STEAL, so we might be able to proceed with JOB_DECODE.
+=09 */
+=09if (dequeued_job =3D=3D NULL) {
+=09=09while (cus_processing_queue.nr_decoded_cus >=3D cus_processing_queue=
.max_decoded_cus)
+=09=09=09pthread_cond_wait(&cus_processing_queue.job_taken, &cus_processin=
g_queue.mutex);
+
+=09=09/* We can decode now. */
+=09=09list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
+=09=09=09job =3D list_entry(pos, struct cu_processing_job, node);
+=09=09=09if (job->type =3D=3D JOB_DECODE) {
+=09=09=09=09list_del(&job->node);
+=09=09=09=09dequeued_job =3D job;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09}
+
+=09pthread_cond_signal(&cus_processing_queue.job_taken);
+=09pthread_mutex_unlock(&cus_processing_queue.mutex);
+
+=09return dequeued_job;
+}
+
 static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf=
_Die *cu_die, uint8_t pointer_size)
 {
 =09/*
@@ -3479,28 +3609,6 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct =
dwarf_cus *dcus, Dwarf_Die *
 =09return dcu;
 }
=20
-static int dwarf_cus__process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die=
,
-=09=09=09=09 struct cu *cu, void *thr_data)
-{
-=09if (die__process_and_recode(cu_die, cu, dcus->conf) !=3D 0 ||
-=09    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) =3D=3D LSK__STOP=
_LOADING)
-=09=09return DWARF_CB_ABORT;
-
-       return DWARF_CB_OK;
-}
-
-static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_=
Die *cu_die, uint8_t pointer_size)
-{
-=09struct dwarf_cu *dcu =3D dwarf_cus__create_cu(dcus, cu_die, pointer_siz=
e);
-
-=09if (dcu =3D=3D NULL)
-=09=09return DWARF_CB_ABORT;
-
-=09cus__add(dcus->cus, dcu->cu);
-
-=09return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, NULL);
-}
-
 static int dwarf_cus__nextcu(struct dwarf_cus *dcus, struct dwarf_cu **dcu=
,
 =09=09=09     Dwarf_Die *die_mem, Dwarf_Die **cu_die,
 =09=09=09     uint8_t *pointer_size, uint8_t *offset_size)
@@ -3541,24 +3649,86 @@ out_unlock:
 =09return ret;
 }
=20
-static void *dwarf_cus__process_cu_thread(void *arg)
+static struct cu *dwarf_loader__decode_next_cu(struct dwarf_cus *dcus)
 {
-=09struct dwarf_thread *dthr =3D arg;
-=09struct dwarf_cus *dcus =3D dthr->dcus;
 =09uint8_t pointer_size, offset_size;
+=09struct dwarf_cu *dcu =3D NULL;
 =09Dwarf_Die die_mem, *cu_die;
-=09struct dwarf_cu *dcu;
+=09int err;
=20
-=09while (dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size, =
&offset_size) =3D=3D 0) {
-=09=09if (cu_die =3D=3D NULL)
+=09err =3D dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size,=
 &offset_size);
+
+=09if (err < 0)
+=09=09goto out_error;
+=09else if (err =3D=3D 1) /* no more CUs */
+=09=09return NULL;
+
+=09err =3D die__process_and_recode(cu_die, dcu->cu, dcus->conf);
+=09if (err)
+=09=09goto out_error;
+=09if (cu_die =3D=3D NULL)
+=09=09return NULL;
+
+=09cu__finalize(dcu->cu, dcus->cus, dcus->conf);
+
+=09return dcu->cu;
+
+out_error:
+=09dcus->error =3D err;
+=09fprintf(stderr, "error decoding cu %s\n", dcu && dcu->cu ? dcu->cu->nam=
e : "");
+=09return NULL;
+}
+
+static void *dwarf_loader__worker_thread(void *arg)
+{
+=09struct cu_processing_job *job;
+=09struct dwarf_cus *dcus =3D arg;
+=09bool stop =3D false;
+=09struct cu *cu;
+
+=09while (!stop) {
+=09=09job =3D cus_queue__dequeue_job();
+
+=09=09switch (job->type) {
+
+=09=09case JOB_DECODE:
+=09=09=09cu =3D dwarf_loader__decode_next_cu(dcus);
+
+=09=09=09if (cu =3D=3D NULL) {
+=09=09=09=09free(job);
+=09=09=09=09stop =3D true;
+=09=09=09=09break;
+=09=09=09}
+
+=09=09=09/* Create and enqueue a new JOB_STEAL for this decoded CU */
+=09=09=09struct cu_processing_job *steal_job =3D calloc(1, sizeof(*steal_j=
ob));
+
+=09=09=09steal_job->type =3D JOB_STEAL;
+=09=09=09steal_job->cu =3D cu;
+=09=09=09cus_queue__enqueue_job(steal_job);
+
+=09=09=09/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
+=09=09=09cus_queue__enqueue_job(job);
+=09=09=09break;
+
+=09=09case JOB_STEAL:
+=09=09=09if (cus__steal_now(dcus->cus, job->cu, dcus->conf) =3D=3D LSK__ST=
OP_LOADING)
+=09=09=09=09goto out_abort;
+=09=09=09cus_queue__inc_next_cu_id();
+=09=09=09/* Free the job struct as it's no longer
+=09=09=09 * needed after CU has been stolen.
+=09=09=09 * dwarf_loader work for this CU is done.
+=09=09=09 */
+=09=09=09free(job);
 =09=09=09break;
=20
-=09=09if (dwarf_cus__process_cu(dcus, cu_die, dcu->cu, dthr->data) =3D=3D =
DWARF_CB_ABORT)
+=09=09default:
+=09=09=09fprintf(stderr, "Unknown dwarf_loader job type %d\n", job->type);
 =09=09=09goto out_abort;
+=09=09}
 =09}
=20
-=09if (dcus->conf->thread_exit &&
-=09    dcus->conf->thread_exit(dcus->conf, dthr->data) !=3D 0)
+=09if (dcus->error)
 =09=09goto out_abort;
=20
 =09return (void *)DWARF_CB_OK;
@@ -3566,29 +3736,29 @@ out_abort:
 =09return (void *)DWARF_CB_ABORT;
 }
=20
-static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
+static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
 {
-=09pthread_t threads[dcus->conf->nr_jobs];
-=09struct dwarf_thread dthr[dcus->conf->nr_jobs];
-=09void *thread_data[dcus->conf->nr_jobs];
-=09int res;
-=09int i;
+=09int nr_workers =3D dcus->conf->nr_jobs > 0 ? dcus->conf->nr_jobs : 1;
+=09pthread_t workers[nr_workers];
+=09struct cu_processing_job *job;
=20
-=09if (dcus->conf->threads_prepare) {
-=09=09res =3D dcus->conf->threads_prepare(dcus->conf, dcus->conf->nr_jobs,=
 thread_data);
-=09=09if (res !=3D 0)
-=09=09=09return res;
-=09} else {
-=09=09memset(thread_data, 0, sizeof(void *) * dcus->conf->nr_jobs);
+=09cus_queue__init(nr_workers * 4);
+
+=09/* fill up the queue with nr_workers JOB_DECODE jobs */
+=09for (int i =3D 0; i < nr_workers; i++) {
+=09=09job =3D calloc(1, sizeof(*job));
+=09=09job->type =3D JOB_DECODE;
+=09=09/* no need for locks, workers were not started yet */
+=09=09list_add(&job->node, &cus_processing_queue.jobs);
 =09}
=20
-=09for (i =3D 0; i < dcus->conf->nr_jobs; ++i) {
-=09=09dthr[i].dcus =3D dcus;
-=09=09dthr[i].data =3D thread_data[i];
+=09if (dcus->error)
+=09=09return dcus->error;
=20
-=09=09dcus->error =3D pthread_create(&threads[i], NULL,
-=09=09=09=09=09     dwarf_cus__process_cu_thread,
-=09=09=09=09=09     &dthr[i]);
+=09for (int i =3D 0; i < nr_workers; ++i) {
+=09=09dcus->error =3D pthread_create(&workers[i], NULL,
+=09=09=09=09=09     dwarf_loader__worker_thread,
+=09=09=09=09=09     dcus);
 =09=09if (dcus->error)
 =09=09=09goto out_join;
 =09}
@@ -3596,54 +3766,19 @@ static int dwarf_cus__threaded_process_cus(struct d=
warf_cus *dcus)
 =09dcus->error =3D 0;
=20
 out_join:
-=09while (--i >=3D 0) {
+=09for (int i =3D 0; i < nr_workers; ++i) {
 =09=09void *res;
-=09=09int err =3D pthread_join(threads[i], &res);
+=09=09int err =3D pthread_join(workers[i], &res);
=20
 =09=09if (err =3D=3D 0 && res !=3D NULL)
 =09=09=09dcus->error =3D (long)res;
 =09}
=20
-=09if (dcus->conf->threads_collect) {
-=09=09res =3D dcus->conf->threads_collect(dcus->conf, dcus->conf->nr_jobs,
-=09=09=09=09=09=09  thread_data, dcus->error);
-=09=09if (dcus->error =3D=3D 0)
-=09=09=09dcus->error =3D res;
-=09}
+=09cus_queue__destroy();
=20
 =09return dcus->error;
 }
=20
-static int __dwarf_cus__process_cus(struct dwarf_cus *dcus)
-{
-=09uint8_t pointer_size, offset_size;
-=09Dwarf_Off noff;
-=09size_t cuhl;
-
-=09while (dwarf_nextcu(dcus->dw, dcus->off, &noff, &cuhl, NULL, &pointer_s=
ize, &offset_size) =3D=3D 0) {
-=09=09Dwarf_Die die_mem;
-=09=09Dwarf_Die *cu_die =3D dwarf_offdie(dcus->dw, dcus->off + cuhl, &die_=
mem);
-
-=09=09if (cu_die =3D=3D NULL)
-=09=09=09break;
-
-=09=09if (dwarf_cus__create_and_process_cu(dcus, cu_die, pointer_size) =3D=
=3D DWARF_CB_ABORT)
-=09=09=09return DWARF_CB_ABORT;
-
-=09=09dcus->off =3D noff;
-=09}
-
-=09return 0;
-}
-
-static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
-{
-=09if (dcus->conf->nr_jobs > 1)
-=09=09return dwarf_cus__threaded_process_cus(dcus);
-
-=09return __dwarf_cus__process_cus(dcus);
-}
-
 static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *co=
nf,
 =09=09=09=09     Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 =09=09=09=09     const char *filename,
@@ -3733,7 +3868,8 @@ static int cus__merge_and_process_cu(struct cus *cus,=
 struct conf_load *conf,
 =09if (cu__resolve_func_ret_types_optimized(cu) !=3D LSK__KEEPIT)
 =09=09goto out_abort;
=20
-=09if (cus__finalize(cus, cu, conf, NULL) =3D=3D LSK__STOP_LOADING)
+=09cu__finalize(cu, cus, conf);
+=09if (cus__steal_now(cus, cu, conf) =3D=3D LSK__STOP_LOADING)
 =09=09goto out_abort;
=20
 =09return 0;
@@ -3765,7 +3901,8 @@ static int cus__load_module(struct cus *cus, struct c=
onf_load *conf,
 =09}
=20
 =09if (type_cu !=3D NULL) {
-=09=09type_lsk =3D cu__finalize(type_cu, cus, conf, NULL);
+=09=09cu__finalize(type_cu, cus, conf);
+=09=09type_lsk =3D cus__steal_now(cus, type_cu, conf);
 =09=09if (type_lsk =3D=3D LSK__DELETE) {
 =09=09=09cus__remove(cus, type_cu);
 =09=09}
@@ -3787,6 +3924,7 @@ static int cus__load_module(struct cus *cus, struct c=
onf_load *conf,
 =09=09=09.type_dcu =3D type_cu ? &type_dcu : NULL,
 =09=09=09.build_id =3D build_id,
 =09=09=09.build_id_len =3D build_id_len,
+=09=09=09.nr_cus_created =3D 0,
 =09=09};
 =09=09res =3D dwarf_cus__process_cus(&dcus);
 =09}
diff --git a/dwarves.c b/dwarves.c
index ae512b9..7c3e878 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -530,48 +530,6 @@ void cus__unlock(struct cus *cus)
 =09pthread_mutex_unlock(&cus->mutex);
 }
=20
-void cus__set_cu_state(struct cus *cus, struct cu *cu, enum cu_state state=
)
-{
-=09cus__lock(cus);
-=09cu->state =3D state;
-=09cus__unlock(cus);
-}
-
-// Used only when reproducible builds are desired
-struct cu *cus__get_next_processable_cu(struct cus *cus)
-{
-=09struct cu *cu;
-
-=09cus__lock(cus);
-
-=09list_for_each_entry(cu, &cus->cus, node) {
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
-=09=09}
-=09}
-out:
-=09cu =3D NULL;
-found:
-=09cus__unlock(cus);
-
-=09return cu;
-}
-
 bool cus__empty(const struct cus *cus)
 {
 =09return list_empty(&cus->cus);
@@ -808,8 +766,6 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 =09=09cu->addr_size =3D addr_size;
 =09=09cu->extra_dbg_info =3D 0;
=20
-=09=09cu->state =3D CU__UNPROCESSED;
-
 =09=09cu->nr_inline_expansions   =3D 0;
 =09=09cu->size_inline_expansions =3D 0;
 =09=09cu->nr_structures_changed  =3D 0;
diff --git a/dwarves.h b/dwarves.h
index 7c80b18..70b4ddf 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -44,12 +44,6 @@ enum load_steal_kind {
 =09LSK__STOP_LOADING,
 };
=20
-enum cu_state {
-=09CU__UNPROCESSED,
-=09CU__LOADED,
-=09CU__PROCESSING,
-};
-
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for so=
mething
  * like a allyesconfig vmlinux kernel we can get over 65535 types.
@@ -60,7 +54,6 @@ struct btf;
 struct conf_fprintf;
=20
 /** struct conf_load - load configuration
- * @thread_exit - called at the end of a thread, 1st user: BTF encoder ded=
up
  * @extra_dbg_info - keep original debugging format extra info
  *=09=09     (e.g. DWARF's decl_{line,file}, id, etc)
  * @fixup_silly_bitfields - Fixup silly things such as "int foo:32;"
@@ -70,11 +63,9 @@ struct conf_fprintf;
  * @skip_missing - skip missing types rather than bailing out.
  */
 struct conf_load {
-=09enum load_steal_kind=09(*steal)(struct cu *cu,
-=09=09=09=09=09 struct conf_load *conf,
-=09=09=09=09=09 void *thr_data);
+=09enum load_steal_kind=09(*steal)(struct cu *cu, struct conf_load *conf);
 =09struct cu *=09=09(*early_cu_filter)(struct cu *cu);
-=09int=09=09=09(*thread_exit)(struct conf_load *conf, void *thr_data);
+=09int=09=09=09(*pre_load_module)(Dwfl_Module *mod, Elf *elf);
 =09void=09=09=09*cookie;
 =09char=09=09=09*format_path;
 =09int=09=09=09nr_jobs;
@@ -105,9 +96,6 @@ struct conf_load {
 =09const char=09=09*kabi_prefix;
 =09struct btf=09=09*base_btf;
 =09struct conf_fprintf=09*conf_fprintf;
-=09int=09=09=09(*threads_prepare)(struct conf_load *conf, int nr_threads, =
void **thr_data);
-=09int=09=09=09(*threads_collect)(struct conf_load *conf, int nr_threads, =
void **thr_data, int error);
-=09int=09=09=09(*pre_load_module)(Dwfl_Module *mod, Elf *elf);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
@@ -189,10 +177,6 @@ void cus__add(struct cus *cus, struct cu *cu);
 void __cus__remove(struct cus *cus, struct cu *cu);
 void cus__remove(struct cus *cus, struct cu *cu);
=20
-struct cu *cus__get_next_processable_cu(struct cus *cus);
-
-void cus__set_cu_state(struct cus *cus, struct cu *cu, enum cu_state state=
);
-
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 =09=09=09  const char *filename, const int err);
 struct cu *cus__find_pair(struct cus *cus, const char *name);
@@ -309,7 +293,6 @@ struct cu {
 =09uint8_t=09=09 nr_register_params;
 =09int=09=09 register_params[ARCH_MAX_REGISTER_PARAMS];
 =09int=09=09 functions_saved;
-=09enum cu_state=09 state;
 =09uint16_t=09 language;
 =09unsigned long=09 nr_inline_expansions;
 =09size_t=09=09 size_inline_expansions;
diff --git a/pahole.c b/pahole.c
index 7964a03..4148d7a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3118,6 +3118,32 @@ out:
 =09return ret;
 }
=20
+static enum load_steal_kind pahole_stealer__btf_encode(struct cu *cu, stru=
ct conf_load *conf_load)
+{
+=09int err;
+
+=09if (!btf_encoder)
+=09=09btf_encoder =3D btf_encoder__new(cu,
+=09=09=09=09       detached_btf_filename,
+=09=09=09=09       conf_load->base_btf,
+=09=09=09=09       global_verbose,
+=09=09=09=09       conf_load);
+
+=09if (!btf_encoder) {
+=09=09fprintf(stderr, "Error creating BTF encoder.\n");
+=09=09return LSK__STOP_LOADING;
+=09}
+
+=09err =3D btf_encoder__encode_cu(btf_encoder, cu, conf_load);
+=09if (err < 0) {
+=09=09fprintf(stderr, "Error while encoding BTF.\n");
+=09=09return LSK__STOP_LOADING;
+=09}
+
+=09return LSK__DELETE;
+}
+
+
 static struct type_instance *header;
=20
 static bool print_enumeration_with_enumerator(struct cu *cu, const char *n=
ame)
@@ -3136,87 +3162,7 @@ static bool print_enumeration_with_enumerator(struct=
 cu *cu, const char *name)
 =09return false;
 }
=20
-struct thread_data {
-=09struct btf *btf;
-=09struct btf_encoder *encoder;
-};
-
-static int pahole_threads_prepare_reproducible_build(struct conf_load *con=
f, int nr_threads, void **thr_data)
-{
-=09for (int i =3D 0; i < nr_threads; i++)
-=09=09thr_data[i] =3D NULL;
-
-=09return 0;
-}
-
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
-static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
-{
-=09struct thread_data *thread =3D thr_data;
-
-=09if (thread =3D=3D NULL)
-=09=09return 0;
-
-=09/*
-=09 * Here we will call btf__dedup() here once we extend
-=09 * btf__dedup().
-=09 */
-
-=09return 0;
-}
-
-static int pahole_threads_collect(struct conf_load *conf, int nr_threads, =
void **thr_data,
-=09=09=09=09  int error)
-{
-=09struct thread_data **threads =3D (struct thread_data **)thr_data;
-=09int i;
-=09int err =3D 0;
-
-=09if (error)
-=09=09goto out;
-
-=09err =3D btf_encoder__add_saved_funcs(conf_load.skip_encoding_btf_incons=
istent_proto);
-=09if (err < 0)
-=09=09goto out;
-
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
-=09}
-=09err =3D 0;
-
-out:
-=09for (i =3D 0; i < nr_threads; i++) {
-=09=09if (threads[i]->encoder && threads[i]->encoder !=3D btf_encoder) {
-=09=09=09btf_encoder__delete(threads[i]->encoder);
-=09=09=09threads[i]->encoder =3D NULL;
-=09=09}
-=09}
-=09free(threads[0]);
-
-=09return err;
-}
-
-static enum load_steal_kind pahole_stealer(struct cu *cu,
-=09=09=09=09=09   struct conf_load *conf_load,
-=09=09=09=09=09   void *thr_data)
+static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load=
 *conf_load)
 {
 =09int ret =3D LSK__DELETE;
=20
@@ -3238,94 +3184,7 @@ static enum load_steal_kind pahole_stealer(struct cu=
 *cu,
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
+=09=09return pahole_stealer__btf_encode(cu, conf_load);
 =09}
 #if 0
 =09if (ctf_encode) {
@@ -3625,24 +3484,6 @@ out_free:
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
@@ -3731,16 +3572,6 @@ int main(int argc, char *argv[])
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
-=09=09conf_load.threads_prepare =3D pahole_threads_prepare;
-=09=09conf_load.threads_collect =3D pahole_threads_collect;
-=09}
-
 =09if (btf_encode) {
 =09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
 =09=09err =3D btf_encoding_context__init();
@@ -3847,16 +3678,7 @@ try_sole_arg_as_class_names:
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
-
-=09=09if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
-=09=09=09btf_encoder__add_saved_funcs(conf_load.skip_encoding_btf_inconsis=
tent_proto);
-
-=09=09err =3D btf_encoder__encode(btf_encoder);
+=09=09err =3D btf_encoder__encode(btf_encoder, &conf_load);
 =09=09btf_encoder__delete(btf_encoder);
 =09=09if (err) {
 =09=09=09fputs("Failed to encode BTF\n", stderr);
diff --git a/pdwtags.c b/pdwtags.c
index 67982af..962883d 100644
--- a/pdwtags.c
+++ b/pdwtags.c
@@ -91,8 +91,7 @@ static int cu__emit_tags(struct cu *cu)
 }
=20
 static enum load_steal_kind pdwtags_stealer(struct cu *cu,
-=09=09=09=09=09    struct conf_load *conf_load __maybe_unused,
-=09=09=09=09=09    void *thr_data __maybe_unused)
+=09=09=09=09=09    struct conf_load *conf_load __maybe_unused)
 {
 =09cu__emit_tags(cu);
 =09return LSK__DELETE;
diff --git a/pfunct.c b/pfunct.c
index 1d74ece..55eafe8 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -510,8 +510,7 @@ int elf_symtabs__show(char *filenames[])
 }
=20
 static enum load_steal_kind pfunct_stealer(struct cu *cu,
-=09=09=09=09=09   struct conf_load *conf_load __maybe_unused,
-=09=09=09=09=09   void *thr_data __maybe_unused)
+=09=09=09=09=09   struct conf_load *conf_load __maybe_unused)
 {
=20
 =09if (function_name) {
diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index f10f834..a940d93 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -37,10 +37,7 @@ for threads in $(seq $nr_proc) ; do
 =09sleep 0.3s
 =09# PID part to remove ps output headers
 =09nr_threads_started=3D$(ps -L -C pahole | grep -v PID | wc -l)
-
-=09if [ $threads -gt 1 ] ; then
-=09=09((nr_threads_started -=3D 1))
-=09fi
+        ((nr_threads_started -=3D 1)) # main thread doesn't count, it wait=
s to join
=20
 =09if [ $threads !=3D $nr_threads_started ] ; then
 =09=09echo "ERROR: pahole asked to start $threads encoding threads, starte=
d $nr_threads_started"
--=20
2.47.1




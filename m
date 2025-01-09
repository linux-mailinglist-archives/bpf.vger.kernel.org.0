Return-Path: <bpf+bounces-48444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF30A0805E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FC3A8A04
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803E11A0BE1;
	Thu,  9 Jan 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VjCHR1VA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E518A93C
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449256; cv=none; b=gAPGYA+Yiyv6PvsLI1WA7q85+B+4t/0T341PWO0xMlVIiDtn94P7fb37ngvsFpe4ABdPyQgK+m63n3zrXygyUv8xRf8yoGpndh2m47sfMZSt/ejbiKIRRqnJPWDizkK5JoIj2ejD6NgTcpUY09wHsQic/0N+ksbR7lvc5maZmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449256; c=relaxed/simple;
	bh=JfAT1exJCA1DS3oE5pE7Q2gAP+uboWIZDNUoMXyjZP8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9XjzCQh1PRDixRtT8OO2WL/tViqDj/hpQQl+5Z7Gkh/BM84rZWKs56gWrCy7RQA0K5KRug9DvFA0CmZGy3QhBau/WDbeH98zZQgrymOFNmr+UONfILkMZNb9SWEM+p7r0BBAk7Jbv2Yi8LSpOiY6/C3O+Gnz4qfM+kh17evBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VjCHR1VA; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449245; x=1736708445;
	bh=QlREc9WP24jrSWVnHSbpzJFbMdOwMMJYi+/K8mZIvXY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VjCHR1VAdCBBn7FzD0zMKBDQ85UjIofHa5EnCefFWWA6URoBz8DpOfUgIABbL3OTP
	 pTZQuIYHcYutrUjwgtbxA2EvizcO6lR/Wqag67P7ClGz/mWkNM/S5p3o4FXA4nA4Tg
	 QE73Hr9KZSebmeEoNxi5vK5USE5AlVUJZ+67n9w8fO1ncCTBFkZvDMISLWqFY17pnw
	 tpBLqBLBiVx6vMIs8R98emVEu+6AsraZZEkS7AksJ1n8aImYWAxu4HRbTwSyzaSSkF
	 7zkYLST9jjEYAYuoUYE7nYjuKnKCMaVtbOeu/GC4iQo0A5jfpmJLFOE5ZTSS/FIoB+
	 /PavmhaVKAo4A==
Date: Thu, 09 Jan 2025 19:00:41 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 08/10] dwarf_loader: multithreading with a job/worker model
Message-ID: <20250109185950.653110-9-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 61ab0784c224f94fbe9495714a6d803afb91cea5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Multithreading is now contained in dwarf_loader.c, and is implemented
using a jobs queue and a pool of worker threads. As a consequence,
multithreading-related code is removed from pahole.c.

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
ensures consistency of queue state) and a job_added condition
variable. Motivation behind using condition variables is a classic
one: we want to avoid the threads checking the state of the queue in a
busy loop, competing for a single mutex.

In comparison to the previous version of this patch [2], job_taken
condition variable is removed. The number of decoded CUs in memory is
now limited by initial JOB_DECODE jobs. The enqueue/dequeue interface
is changed aiming to reduce locking. See relevant discussion [3].

[1] https://lore.kernel.org/dwarves/20241128012341.4081072-1-ihor.solodrai@=
pm.me/
[2] https://lore.kernel.org/dwarves/20241213223641.564002-11-ihor.solodrai@=
pm.me/
[3] https://lore.kernel.org/dwarves/58dc053c9d47a18124d8711604b08acbc640034=
0.camel@gmail.com/

Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c               |   2 +-
 btf_encoder.h               |   2 -
 btf_loader.c                |   2 +-
 ctf_loader.c                |   2 +-
 dwarf_loader.c              | 330 +++++++++++++++++++++++++-----------
 dwarves.c                   |  44 -----
 dwarves.h                   |  19 +--
 pahole.c                    | 231 +++----------------------
 pdwtags.c                   |   3 +-
 pfunct.c                    |   3 +-
 tests/reproducible_build.sh |   5 +-
 11 files changed, 264 insertions(+), 379 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8243eb4..ce0259e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1326,7 +1326,7 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09}
 }
=20
-int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
+static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_pr=
oto)
 {
 =09struct btf_encoder_func_state **saved_fns =3D NULL, *s;
 =09int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
diff --git a/btf_encoder.h b/btf_encoder.h
index b95f2f3..0081a99 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -33,6 +33,4 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
truct cu *cu, struct co
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
-int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto);
-
 #endif /* _BTF_ENCODER_H_ */
diff --git a/btf_loader.c b/btf_loader.c
index af9e1db..f4f9f65 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -745,7 +745,7 @@ static int cus__load_btf(struct cus *cus, struct conf_l=
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
index 39e4cba..84122d0 100644
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
@@ -3443,11 +3439,112 @@ struct dwarf_cus {
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
+ * the queue, executing them and re-enqueuing new jobs as necessary.
+ * Implementation of this queue ensures two constraints:
+ *   * JOB_STEAL jobs for a CU are executed in the order of cu->id, as
+ *     a consequence JOB_STEAL jobs always run one at a time.
+ *   * Initial number of JOB_DECODE jobs in the queue is effectively a
+ *     limit on how many decoded CUs can be held in memory.
+ *     See dwarf_loader__decoded_cus_limit()
+ */
+static struct {
+=09pthread_mutex_t mutex;
+=09pthread_cond_t job_added;
+=09/* next_cu_id determines the next CU ready to be stealed
+=09 * This enforces the order of CU stealing.
+=09 */
+=09uint32_t next_cu_id;
+=09struct list_head jobs;
+} cus_processing_queue;
+
+enum job_type {
+=09JOB_NONE =3D 0,
+=09JOB_DECODE =3D 1,
+=09JOB_STEAL =3D 2,
+};
+
+struct cu_processing_job {
+=09struct list_head node;
+=09enum job_type type;
+=09struct cu *cu; /* for JOB_STEAL */
 };
=20
+static void cus_queue__init(void)
+{
+=09pthread_mutex_init(&cus_processing_queue.mutex, NULL);
+=09pthread_cond_init(&cus_processing_queue.job_added, NULL);
+=09INIT_LIST_HEAD(&cus_processing_queue.jobs);
+=09cus_processing_queue.next_cu_id =3D 0;
+}
+
+static void cus_queue__destroy(void)
+{
+=09pthread_mutex_destroy(&cus_processing_queue.mutex);
+=09pthread_cond_destroy(&cus_processing_queue.job_added);
+}
+
+static inline void cus_queue__inc_next_cu_id(void)
+{
+=09pthread_mutex_lock(&cus_processing_queue.mutex);
+=09cus_processing_queue.next_cu_id++;
+=09pthread_mutex_unlock(&cus_processing_queue.mutex);
+}
+
+static struct cu_processing_job *cus_queue__try_dequeue(void)
+{
+=09struct cu_processing_job *job, *dequeued_job =3D NULL;
+=09struct list_head *pos, *tmp;
+
+=09list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
+=09=09job =3D list_entry(pos, struct cu_processing_job, node);
+=09=09if (job->type =3D=3D JOB_STEAL && job->cu->id =3D=3D cus_processing_=
queue.next_cu_id) {
+=09=09=09dequeued_job =3D job;
+=09=09=09break;
+=09=09}
+=09=09if (job->type =3D=3D JOB_DECODE) {
+=09=09=09/* all JOB_STEALs are added to the head, so no viable JOB_STEAL a=
vailable */
+=09=09=09dequeued_job =3D job;
+=09=09=09break;
+=09=09}
+=09}
+
+=09/* No jobs or only steals out of order */
+=09if (!dequeued_job)
+=09=09return NULL;
+
+=09list_del(&dequeued_job->node);
+
+=09return dequeued_job;
+}
+
+static struct cu_processing_job *cus_queue__enqdeq_job(struct cu_processin=
g_job *job)
+{
+=09pthread_mutex_lock(&cus_processing_queue.mutex);
+=09if (job) {
+=09=09/* JOB_STEAL have higher priority, add them to the head so
+=09=09 * they can be found faster
+=09=09 */
+=09=09if (job->type =3D=3D JOB_STEAL)
+=09=09=09list_add(&job->node, &cus_processing_queue.jobs);
+=09=09else
+=09=09=09list_add_tail(&job->node, &cus_processing_queue.jobs);
+=09=09pthread_cond_signal(&cus_processing_queue.job_added);
+=09}
+=09for (;;) {
+=09=09job =3D cus_queue__try_dequeue();
+=09=09if (job)
+=09=09=09break;
+=09=09/* No jobs or only steals out of order */
+=09=09pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_q=
ueue.mutex);
+=09}
+=09pthread_mutex_unlock(&cus_processing_queue.mutex);
+=09return job;
+}
+
 static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf=
_Die *cu_die, uint8_t pointer_size)
 {
 =09/*
@@ -3479,28 +3576,6 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct =
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
@@ -3541,24 +3616,74 @@ out_unlock:
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
+=09struct cu_processing_job *job =3D NULL;
+=09struct dwarf_cus *dcus =3D arg;
+=09bool stop =3D false;
+=09struct cu *cu;
+
+=09while (!stop) {
+=09=09job =3D cus_queue__enqdeq_job(job);
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
+=09=09=09job->type =3D JOB_STEAL;
+=09=09=09job->cu =3D cu;
 =09=09=09break;
=20
-=09=09if (dwarf_cus__process_cu(dcus, cu_die, dcu->cu, dthr->data) =3D=3D =
DWARF_CB_ABORT)
+=09=09case JOB_STEAL:
+=09=09=09if (cus__steal_now(dcus->cus, job->cu, dcus->conf) =3D=3D LSK__ST=
OP_LOADING)
+=09=09=09=09goto out_abort;
+=09=09=09cus_queue__inc_next_cu_id();
+=09=09=09/* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
+=09=09=09job->type =3D JOB_DECODE;
+=09=09=09job->cu =3D NULL;
+=09=09=09break;
+
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
@@ -3566,29 +3691,64 @@ out_abort:
 =09return (void *)DWARF_CB_ABORT;
 }
=20
-static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
+/*
+ * If workers pick up next cu for decoding as soon as they're ready,
+ * then the memory usage may greatly increase, if the stealer can't
+ * keep up with incoming work.
+ * If we want to avoid this there needs to be a limit on how many
+ * decoded, but not yet stolen, CUs we allow to hold in memory. When
+ * this limit is reached the workers will wait for more CUs to get
+ * stolen.
+ * The limit is enforced by the number of JOB_DECODE jobs we enqueue
+ * before the workers have started decoding.  A job serves as a
+ * "ticket": worker can proceed with decoding only if it has a ticket.
+ *
+ * As for the value of this limit, it must be at least N, where N is
+ * the number of workers.  If the limit < N, some workers will never
+ * work. Setting the limit higher, while allows for higher memory
+ * consumption, does not necessarily improves the total pahole
+ * runtime, likely due to increased concurrent memory allocation.
+ *
+ * Here are some data points that led to the chosen value:
+ *
+ * perf stat -e cpu-clock -r13 ... pahole -J -j$(nproc) ... vmlinux
+ *   limit=3DN       1.58878 +- 0.00859 seconds time elapsed  ( +-  0.54% =
)
+ *   limit=3DNx2     1.58532 +- 0.00405 seconds time elapsed  ( +-  0.26% =
)  # best
+ *   limit=3DNx4     1.59415 +- 0.00413 seconds time elapsed  ( +-  0.26% =
)
+ *   limit=3DNx8     1.62584 +- 0.00448 seconds time elapsed  ( +-  0.28% =
)
+ *   limit=3DNx1024  1.92333 +- 0.00765 seconds time elapsed  ( +-  0.40% =
)
+ */
+static inline int dwarf_loader__decoded_cus_limit(const struct conf_load *=
conf)
 {
-=09pthread_t threads[dcus->conf->nr_jobs];
-=09struct dwarf_thread dthr[dcus->conf->nr_jobs];
-=09void *thread_data[dcus->conf->nr_jobs];
-=09int res;
+=09return conf->nr_jobs > 0 ? conf->nr_jobs * 2 : 2;
+}
+
+static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
+{
+=09int nr_workers =3D dcus->conf->nr_jobs > 0 ? dcus->conf->nr_jobs : 1;
+=09pthread_t workers[nr_workers];
+=09struct cu_processing_job *job;
 =09int i;
=20
-=09if (dcus->conf->threads_prepare) {
-=09=09res =3D dcus->conf->threads_prepare(dcus->conf, dcus->conf->nr_jobs,=
 thread_data);
-=09=09if (res !=3D 0)
-=09=09=09return res;
-=09} else {
-=09=09memset(thread_data, 0, sizeof(void *) * dcus->conf->nr_jobs);
-=09}
+=09cus_queue__init();
=20
-=09for (i =3D 0; i < dcus->conf->nr_jobs; ++i) {
-=09=09dthr[i].dcus =3D dcus;
-=09=09dthr[i].data =3D thread_data[i];
+=09/* Fill up the queue with JOB_DECODE jobs.
+=09 */
+=09for (i =3D 0; i < dwarf_loader__decoded_cus_limit(dcus->conf); i++) {
+=09=09job =3D calloc(1, sizeof(*job));
+=09=09if (!job) {
+=09=09=09dcus->error =3D -ENOMEM;
+=09=09=09goto out_error;
+=09=09}
+=09=09job->type =3D JOB_DECODE;
+=09=09/* no need for locks, workers were not started yet */
+=09=09list_add(&job->node, &cus_processing_queue.jobs);
+=09}
=20
-=09=09dcus->error =3D pthread_create(&threads[i], NULL,
-=09=09=09=09=09     dwarf_cus__process_cu_thread,
-=09=09=09=09=09     &dthr[i]);
+=09for (i =3D 0; i < nr_workers; ++i) {
+=09=09dcus->error =3D pthread_create(&workers[i], NULL,
+=09=09=09=09=09     dwarf_loader__worker_thread,
+=09=09=09=09=09     dcus);
 =09=09if (dcus->error)
 =09=09=09goto out_join;
 =09}
@@ -3598,52 +3758,18 @@ static int dwarf_cus__threaded_process_cus(struct d=
warf_cus *dcus)
 out_join:
 =09while (--i >=3D 0) {
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
+out_error:
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
@@ -3733,7 +3859,8 @@ static int cus__merge_and_process_cu(struct cus *cus,=
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
@@ -3765,7 +3892,8 @@ static int cus__load_module(struct cus *cus, struct c=
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
diff --git a/dwarves.c b/dwarves.c
index 1cf2562..ef93239 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -533,48 +533,6 @@ void cus__unlock(struct cus *cus)
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
@@ -813,8 +771,6 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 =09=09cu->addr_size =3D addr_size;
 =09=09cu->extra_dbg_info =3D 0;
=20
-=09=09cu->state =3D CU__UNPROCESSED;
-
 =09=09cu->nr_inline_expansions   =3D 0;
 =09=09cu->size_inline_expansions =3D 0;
 =09=09cu->nr_structures_changed  =3D 0;
diff --git a/dwarves.h b/dwarves.h
index b28a66e..8234e1a 100644
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
@@ -70,11 +63,8 @@ struct conf_fprintf;
  * @skip_missing - skip missing types rather than bailing out.
  */
 struct conf_load {
-=09enum load_steal_kind=09(*steal)(struct cu *cu,
-=09=09=09=09=09 struct conf_load *conf,
-=09=09=09=09=09 void *thr_data);
+=09enum load_steal_kind=09(*steal)(struct cu *cu, struct conf_load *conf);
 =09struct cu *=09=09(*early_cu_filter)(struct cu *cu);
-=09int=09=09=09(*thread_exit)(struct conf_load *conf, void *thr_data);
 =09void=09=09=09*cookie;
 =09char=09=09=09*format_path;
 =09int=09=09=09nr_jobs;
@@ -105,8 +95,6 @@ struct conf_load {
 =09const char=09=09*kabi_prefix;
 =09struct btf=09=09*base_btf;
 =09struct conf_fprintf=09*conf_fprintf;
-=09int=09=09=09(*threads_prepare)(struct conf_load *conf, int nr_threads, =
void **thr_data);
-=09int=09=09=09(*threads_collect)(struct conf_load *conf, int nr_threads, =
void **thr_data, int error);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
@@ -188,10 +176,6 @@ void cus__add(struct cus *cus, struct cu *cu);
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
@@ -308,7 +292,6 @@ struct cu {
 =09uint8_t=09=09 nr_register_params;
 =09int=09=09 register_params[ARCH_MAX_REGISTER_PARAMS];
 =09int=09=09 functions_saved;
-=09enum cu_state=09 state;
 =09uint16_t=09 language;
 =09unsigned long=09 nr_inline_expansions;
 =09size_t=09=09 size_inline_expansions;
diff --git a/pahole.c b/pahole.c
index 37d76b1..af3e1cf 100644
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
-=09=09if (!threads[i]->btf)
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
 =09// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 =09if (conf.header_type && !class_name && prettify_input) {
 =09=09conf.count =3D 1;
@@ -3840,12 +3671,6 @@ try_sole_arg_as_class_names:
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
 =09=09err =3D btf_encoder__encode(btf_encoder, &conf_load);
 =09=09btf_encoder__delete(btf_encoder);
 =09=09if (err) {
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




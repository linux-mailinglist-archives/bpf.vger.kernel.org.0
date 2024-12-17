Return-Path: <bpf+bounces-47130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CB9F55C0
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51CC188799E
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D01F757B;
	Tue, 17 Dec 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bTLgsTnB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F51F470F
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459144; cv=none; b=aN6tnoowkajLc6atx362iTm6zMk0wRhh87ziUqGfDbCt93MJF0qcbzEFtcsDrTJRM56BmRw6kwTTOQwzGfnsSQqshcy/EhBWSSll6RZwocnawfkTfo8FqHgwlRWy5TBTfcN244eko9EIzLVJGdWfscVA5o4wcrRUr1fTZBF4SZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459144; c=relaxed/simple;
	bh=oeII/hthktiGwK8yPCcniuknamxglYyc1A9hUNK60xc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lj7AMHBlysHUSSb8k8J9sdAOGGOEQUK5Y1QfJ0garSMqK1gF20VQUMK8Otue0g7xTaz0ILUiFYc+//CKFQJX0NKTShb3Yp790qZ5Z2b98u8ioe9dqcCLh9qNbDNWX/e+rDVjXbmVvCchwNPTO01EVYf+3pykpYHtJnx+1kFACQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bTLgsTnB; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734459139; x=1734718339;
	bh=oeII/hthktiGwK8yPCcniuknamxglYyc1A9hUNK60xc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bTLgsTnB2ELz4LPDDQB5p8uZX2TArS7GXxxccJESFkBiXUbIE3PpYsSkQfxDSbIDU
	 7CILxggFLHDZCUjntKjlXmHiSOSUJ6iUEbggrlp5WM7wA9Iax125l3CI1hppxICcCZ
	 avYCS3zj9vJm6Pi2T7RvRRpbZNF8FTOwuha9Vw7lGILO4k1KvDgYLXxXOy6SW1Gzu5
	 PNq2jmn63bYwtdVwxoIpEhDUjRp2JtjPlutlliSYfwHFsjbvEG7vCaIxHfUhzLPa4d
	 kyrapEyWmvsLCyJQTBzJdbfb5M1M5VAgnEnZOUrCR9W3sFhH6P+S9FT9eT3l2PpLnO
	 465vXnZMzoU1Q==
Date: Tue, 17 Dec 2024 18:12:14 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a job/worker model
Message-ID: <IoyitLMvy0oWAXqSEmKaNQoJDqkWDUJCJ9BRHG6cmhodA3GW3KJoMcgbsy4KGs_TxyR0P02DjuzD549UnARiK6_Dn69Hjhgr3rV6NcjI6d0=@pm.me>
In-Reply-To: <58dc053c9d47a18124d8711604b08acbc6400340.camel@gmail.com>
References: <20241213223641.564002-1-ihor.solodrai@pm.me> <20241213223641.564002-11-ihor.solodrai@pm.me> <58dc053c9d47a18124d8711604b08acbc6400340.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 8e82511d826add8f6d6fcf8e644193b097af04e1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 16th, 2024 at 4:57 PM, Eduard Zingerman <eddyz87@gmail.=
com> wrote:

>=20
>=20
> On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:
>=20
> [...]
>=20
> There is no real need to use two conditional variables to achieve what is=
 done here.
> The "JOB_DECODE" item is already used as a "ticket" to do the decoding.
> So it is possible to "emit" a fixed amount of tickets and alternate their=
 state
> between "decode"/"steal", w/o allocating new tickets.
> This would allow to remove "job_taken" conditional variable and decode co=
unters.
> E.g. as in the patch below applied on top of this patch-set.

Your suggestion makes sense, I haven't thought about utilizing jobs as
"tickets". This simplifies synchronization.=20

I'll incorporate this in the next version.

Thank you!

>=20
> ---
>=20
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 6d22648..40ad27d 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3453,23 +3453,10 @@ struct dwarf_cus {
> static struct {
> pthread_mutex_t mutex;
> pthread_cond_t job_added;
> - pthread_cond_t job_taken;
> /* next_cu_id determines the next CU ready to be stealed
> * This enforces the order of CU stealing.
> /
> uint32_t next_cu_id;
> - / max_decoded_cus is a soft limit on the number of JOB_STEAL
> - * jobs currently in the queue (this number is equal to the
> - * number of decoded CUs held in memory). It's soft, because a
> - * worker thread may finish decoding it's current CU after
> - * this limit has already been reached. In such situation,
> - * JOB_STEAL with this CU is still added to the queue,
> - * although a worker will not pick up a new JOB_DECODE.
> - * So the real hard limit is max_decoded_cus + nr_workers.
> - * This variable indirectly limits the memory usage.
> - */
> - uint16_t max_decoded_cus;
> - uint16_t nr_decoded_cus;
> struct list_head jobs;
> } cus_processing_queue;
>=20
> @@ -3489,10 +3476,7 @@ static void cus_queue__init(uint16_t max_decoded_c=
us)
> {
> pthread_mutex_init(&cus_processing_queue.mutex, NULL);
> pthread_cond_init(&cus_processing_queue.job_added, NULL);
> - pthread_cond_init(&cus_processing_queue.job_taken, NULL);
> INIT_LIST_HEAD(&cus_processing_queue.jobs);
> - cus_processing_queue.max_decoded_cus =3D max_decoded_cus;
> - cus_processing_queue.nr_decoded_cus =3D 0;
> cus_processing_queue.next_cu_id =3D 0;
> }
>=20
> @@ -3500,7 +3484,6 @@ static void cus_queue__destroy(void)
> {
> pthread_mutex_destroy(&cus_processing_queue.mutex);
> pthread_cond_destroy(&cus_processing_queue.job_added);
> - pthread_cond_destroy(&cus_processing_queue.job_taken);
> }
>=20
> static inline void cus_queue__inc_next_cu_id(void)
> @@ -3520,12 +3503,10 @@ static void cus_queue__enqueue_job(struct cu_proc=
essing_job job)
> / JOB_STEAL have higher priority, add them to the head so
> * they can be found faster
> */
> - if (job->type =3D=3D JOB_STEAL) {
>=20
> + if (job->type =3D=3D JOB_STEAL)
>=20
> list_add(&job->node, &cus_processing_queue.jobs);
>=20
> - cus_processing_queue.nr_decoded_cus++;
> - } else {
> + else
> list_add_tail(&job->node, &cus_processing_queue.jobs);
>=20
> - }
>=20
> pthread_cond_signal(&cus_processing_queue.job_added);
> pthread_mutex_unlock(&cus_processing_queue.mutex);
> @@ -3537,45 +3518,28 @@ static struct cu_processing_job *cus_queue__deque=
ue_job(void)
> struct list_head *pos, tmp;
>=20
> pthread_mutex_lock(&cus_processing_queue.mutex);
> - while (list_empty(&cus_processing_queue.jobs))
> - pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queu=
e.mutex);
> -
> - / First, try to find JOB_STEAL for the next CU */
> +retry:
> list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
> job =3D list_entry(pos, struct cu_processing_job, node);
> if (job->type =3D=3D JOB_STEAL && job->cu->id =3D=3D cus_processing_queue=
.next_cu_id) {
>=20
> - list_del(&job->node);
>=20
> - cus_processing_queue.nr_decoded_cus--;
> dequeued_job =3D job;
> break;
> }
> - }
> -
> - /* If no JOB_STEAL is found, check if we are allowed to decode
> - * more CUs. If not, it means that the CU with next_cu_id is
> - * still being decoded while the queue is "full". Wait.
> - * job_taken will signal that another thread was able to pick
> - * up a JOB_STEAL, so we might be able to proceed with JOB_DECODE.
> - */
> - if (dequeued_job =3D=3D NULL) {
> - while (cus_processing_queue.nr_decoded_cus >=3D cus_processing_queue.ma=
x_decoded_cus)
>=20
> - pthread_cond_wait(&cus_processing_queue.job_taken, &cus_processing_queu=
e.mutex);
> -
> - /* We can decode now. */
> - list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
> - job =3D list_entry(pos, struct cu_processing_job, node);
> - if (job->type =3D=3D JOB_DECODE) {
>=20
> - list_del(&job->node);
>=20
> - dequeued_job =3D job;
> - break;
> - }
> + if (job->type =3D=3D JOB_DECODE) {
>=20
> + /* all JOB_STEALs are added to the head, so no viable JOB_STEAL availab=
le /
> + dequeued_job =3D job;
> + break;
> }
> }
> -
> - pthread_cond_signal(&cus_processing_queue.job_taken);
> + / No jobs or only steals out of order */
> + if (!dequeued_job) {
> + pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queu=
e.mutex);
> + goto retry;
> + }
> + list_del(&dequeued_job->node);
>=20
> pthread_mutex_unlock(&cus_processing_queue.mutex);
>=20
> - return dequeued_job;
> + return job;
> }
>=20
> static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwar=
f_Die *cu_die, uint8_t pointer_size)
> @@ -3700,14 +3664,8 @@ static void *dwarf_loader__worker_thread(void arg)
> break;
> }
>=20
> - / Create and enqueue a new JOB_STEAL for this decoded CU */
> - struct cu_processing_job *steal_job =3D calloc(1, sizeof(*steal_job));
> -
> - steal_job->type =3D JOB_STEAL;
>=20
> - steal_job->cu =3D cu;
>=20
> - cus_queue__enqueue_job(steal_job);
> -
> - /* re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
> + job->type =3D JOB_STEAL;
>=20
> + job->cu =3D cu;
>=20
> cus_queue__enqueue_job(job);
> break;
>=20
> @@ -3715,11 +3673,10 @@ static void *dwarf_loader__worker_thread(void *ar=
g)
> if (cus__steal_now(dcus->cus, job->cu, dcus->conf) =3D=3D LSK__STOP_LOADI=
NG)
>=20
> goto out_abort;
> cus_queue__inc_next_cu_id();
> - /* Free the job struct as it's no longer
> - * needed after CU has been stolen.
> - * dwarf_loader work for this CU is done.
> - /
> - free(job);
> + / re-enqueue JOB_DECODE so that next CU is decoded from DWARF */
> + job->type =3D JOB_DECODE;
>=20
> + job->cu =3D NULL;
>=20
> + cus_queue__enqueue_job(job);
> break;
>=20
> default:
> @@ -3742,10 +3699,10 @@ static int dwarf_cus__process_cus(struct dwarf_cu=
s *dcus)
> pthread_t workers[nr_workers];
> struct cu_processing_job job;
>=20
> - cus_queue__init(nr_workers * 4);
> + cus_queue__init(nr_workers);
>=20
> / fill up the queue with nr_workers JOB_DECODE jobs */
> - for (int i =3D 0; i < nr_workers; i++) {
> + for (int i =3D 0; i < nr_workers * 4; i++) {
> job =3D calloc(1, sizeof(*job));
> job->type =3D JOB_DECODE;
>=20
> /* no need for locks, workers were not started yet */


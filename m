Return-Path: <bpf+bounces-47348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A69F844F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F04F7A1394
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E63A1B4240;
	Thu, 19 Dec 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NS4MIZ3p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9F1B4147;
	Thu, 19 Dec 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636711; cv=none; b=TAAyiXGOSp4CYBecaU+IHC0ezImaIHzDFjfhtwNJqrPJqWuPPEhKyQg+X4y0AGHFO1HQal2M4aMZWUsqfLQ5eN54aT0/uIA64s0XXXcpi8NDt8rFGVoE28ulPN8tHnQchfVbM3e5rgBNRzta0oUNZ8cxULefMQOzECK5tNN/BoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636711; c=relaxed/simple;
	bh=zMDGKqDHNRRsp8eposPaHOyDg/J5j+nmpksjxm+fgpE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY2fm/pFaHaG4mQu21F2fxOOxMpvFx3JD18G+J6xroOn+cU2HpDJOkWO8/Lu+7hKVrjHYYZm9nFQHWjRmKM7gBcssbYZY1Bq2QvqoPZpW7tDoCb+xbO2ALRpQBIVVyiJVEUrYmKZaQaBarysb5pVwxxCyNcW0MEAcSP/ezi7WNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NS4MIZ3p; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734636700; x=1734895900;
	bh=zMDGKqDHNRRsp8eposPaHOyDg/J5j+nmpksjxm+fgpE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NS4MIZ3pB6jWBiPnA6wlXpwNqZKXZlP5XjWTB8ErZsFVp0X+aCRFM6szipQHEg9zf
	 VI1wbx+yrT3wVbXO12CAqGTJBjb6Y6X4jFn24M6a6NZIvW51aFHdzFAYgkmYpg+sSp
	 NimMWLLidNXENUaNiWCcrQ+LtrilMhAmG3HkH3MyWa22O1J1i/vl7O1qYc4syLo5/3
	 K2s3zj9wGJOPldDqUp532ypvVb+d8VIsgF4PvS+55hT7M4L3cV+mC7Zb5b5B+eCN1s
	 uNfrTpkY6vvFPo1a0QpOL0uLYiVELYT9vg1Mg0QKmrNNyiGEoqMlJkD6xs3/I4PiRI
	 N+t6kXesvkyUA==
Date: Thu, 19 Dec 2024 19:31:35 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a job/worker model
Message-ID: <Gk0nTkIuEA2FQD6WzNeIq1Hsoj5V2zwmar99_nB5a_Yc96sJLMi3W57sBAr84aUJjUepJkLgVqkOAeXVPvx7B7P0WIgl6qJib2Kw-iGRwaM=@pm.me>
In-Reply-To: <Z2Q0wU_AOOF0c_NF@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me> <20241213223641.564002-11-ihor.solodrai@pm.me> <Z2Q0wU_AOOF0c_NF@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 18bdf95cecd8a8fa8c62be658f9e50117b496816
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, December 19th, 2024 at 6:59 AM, Jiri Olsa <olsajiri@gmail.com>=
 wrote:

>=20
>=20
> On Fri, Dec 13, 2024 at 10:37:34PM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > +static void *dwarf_loader__worker_thread(void *arg)
> > +{
> > + struct cu_processing_job *job;
> > + struct dwarf_cus *dcus =3D arg;
> > + bool stop =3D false;
> > + struct cu cu;
> > +
> > + while (!stop) {
> > + job =3D cus_queue__dequeue_job();
> > +
> > + switch (job->type) {
> > +
> > + case JOB_DECODE:
> > + cu =3D dwarf_loader__decode_next_cu(dcus);
> > +
> > + if (cu =3D=3D NULL) {
> > + free(job);
> > + stop =3D true;
> > + break;
> > + }
> > +
> > + / Create and enqueue a new JOB_STEAL for this decoded CU */
> > + struct cu_processing_job *steal_job =3D calloc(1, sizeof(*steal_job))=
;
>=20
>=20
> missing steal_job !=3D NULL check

In the next version, job objects are allocated only by the main thread
and are reused when enqueued [1].

>=20
> SNIP
>=20
> > -static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
> > +static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
> > {
> > - pthread_t threads[dcus->conf->nr_jobs];
> > - struct dwarf_thread dthr[dcus->conf->nr_jobs];
> > - void *thread_data[dcus->conf->nr_jobs];
> > - int res;
> > - int i;
> > + int nr_workers =3D dcus->conf->nr_jobs > 0 ? dcus->conf->nr_jobs : 1;
> > + pthread_t workers[nr_workers];
> > + struct cu_processing_job *job;
> >=20
> > - if (dcus->conf->threads_prepare) {
> > - res =3D dcus->conf->threads_prepare(dcus->conf, dcus->conf->nr_jobs, =
thread_data);
> > - if (res !=3D 0)
> > - return res;
> > - } else {
> > - memset(thread_data, 0, sizeof(void *) * dcus->conf->nr_jobs);
> > + cus_queue__init(nr_workers * 4);
>=20
>=20
> why '* 4' ?

This is an arbitrary limit, described in comments.

If we allow the workers to pick up next cu for decoding as soon as
it's ready, then the memory usage may greatly increase, if the stealer
can't keep up with incoming work.

If we want to avoid this there needs to be a limit on how many
decoded, but not yet stolen, CUs we allow to hold in memory. When
this limit is reached the workers will wait for more CUs to get
stolen.

N x 4 is a number I picked after trying various values and looking at
the resulting memory usage.

We could make it configurable, but this value doesn't look to me as a
reasonable user-facing option. Maybe we could add "I don't care about
memory usage" flag to pahole? wdyt?

>=20
> > +
> > + /* fill up the queue with nr_workers JOB_DECODE jobs */
> > + for (int i =3D 0; i < nr_workers; i++) {
> > + job =3D calloc(1, sizeof(*job));
>=20
>=20
> missing job !=3D NULL check
>=20
> > + job->type =3D JOB_DECODE;
> > + /* no need for locks, workers were not started yet */
> > + list_add(&job->node, &cus_processing_queue.jobs);
> > }
> >=20
> > - for (i =3D 0; i < dcus->conf->nr_jobs; ++i) {
> > - dthr[i].dcus =3D dcus;
> > - dthr[i].data =3D thread_data[i];
> > + if (dcus->error)
> > + return dcus->error;
> >=20
> > - dcus->error =3D pthread_create(&threads[i], NULL,
> > - dwarf_cus__process_cu_thread,
> > - &dthr[i]);
> > + for (int i =3D 0; i < nr_workers; ++i) {
> > + dcus->error =3D pthread_create(&workers[i], NULL,
> > + dwarf_loader__worker_thread,
> > + dcus);
> > if (dcus->error)
> > goto out_join;
> > }
> > @@ -3596,54 +3766,19 @@ static int dwarf_cus__threaded_process_cus(stru=
ct dwarf_cus *dcus)
> > dcus->error =3D 0;
> >=20
> > out_join:
> > - while (--i >=3D 0) {
> > + for (int i =3D 0; i < nr_workers; ++i) {
>=20
>=20
> I think you should keep the original while loop to cleanup/wait only for
> threads that we actually created

Do you mean in case of an error from pthread_create? Ok.

>=20
> > void *res;
> > - int err =3D pthread_join(threads[i], &res);
> > + int err =3D pthread_join(workers[i], &res);
> >=20
> > if (err =3D=3D 0 && res !=3D NULL)
> > dcus->error =3D (long)res;
> > }
> >=20
> > - if (dcus->conf->threads_collect) {
> > - res =3D dcus->conf->threads_collect(dcus->conf, dcus->conf->nr_jobs,
> > - thread_data, dcus->error);
> > - if (dcus->error =3D=3D 0)
> > - dcus->error =3D res;
> > - }
> > + cus_queue__destroy();
> >=20
> > return dcus->error;
> > }
>=20
>=20
> SNIP

[1] https://github.com/acmel/dwarves/commit/5278adbe5cb796c7baafb110d8c5cda=
107ec9d68#diff-77fe7eedce76594a6c71363b22832723fc086a8e72debd0370763e419370=
4b1eR3706-R3708



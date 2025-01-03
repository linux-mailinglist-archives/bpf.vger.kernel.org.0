Return-Path: <bpf+bounces-47812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B4A001F4
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 01:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB523A34F5
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2211CA0;
	Fri,  3 Jan 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="eu69klS6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F028FD
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735863888; cv=none; b=jBcsYriHa5P53lougNsOPPCjO0iJObj6VQ1AzJ+PW8m9zfR5O8q0Ji0bjaAjHvOiOsVI/AFdaRAoiTQGGf8iZiJTrTOKmGjJJ9dMIwYMRgCOvZxWBCLC8zSTXLy/Idr/sML4F3D0xtG2diAJrzdpqvNkwZr/qnnmGJZRHgwYpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735863888; c=relaxed/simple;
	bh=YAp8XKx5+zGq/XceBkw+R7d58tZUalYU+JVlHQsIIII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peuJ/BQ8lgfXar3+Sdzj4WUiJSEalmIjZyYoGBpRjn25pWCgAY2W8aXmU9MLwU4U1x6Mc6FfA19cUI4c0p5o8sDoniyZYbb6bzPXUbmVnyzoQtjjZGptVTRZ+oGayqBT0tE+aL5dcqNjfZzaO1678ayZGqqe+CCwC25xjnR1sEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=eu69klS6; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735863876; x=1736123076;
	bh=YAp8XKx5+zGq/XceBkw+R7d58tZUalYU+JVlHQsIIII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=eu69klS6idadZmfPXT4/t+vf2w/43D5ON91UwUQpt+fPX2zBklVf+1qBMRhHhsKna
	 Q0tczaMICIkwzGS7nhY7gjVt0eb538eIQCvOAYrl0n89ZLxETFCUoJ9DADcQBDtmtD
	 BXTlagg8wwQ8XfngX3u+hmDmFRCOBeUF6ebn+MvQW8t8RSsQwH3gL3yCYkx19YQ7lD
	 u7sZTh/ruG4CHwRcF3+TqR4x4Q+vJFgEKAa0nmQ9vffG7qU+VdPMVNVpzdIUjhRka4
	 uhCloGll7ulMorvtUX8n3A3sSH+fIfdXBLIdngNSmjWQ+CkOpVSYcqL+M63BgwStcJ
	 rjfF/XeREMD3A==
Date: Fri, 03 Jan 2025 00:24:29 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 7/8] dwarf_loader: multithreading with a job/worker model
Message-ID: <qafFqkIRgYxN5kalyCJsyLhIdpgJmCQtdEE-VwWecjAM1gD2VzuZMDBWKVRU81Hb1ksuQeD9tfzHAYgUFECGd6FST1p2w-rWrwo4sNutaFc=@pm.me>
In-Reply-To: <Z3VzsA8nv4kQj1bH@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me> <20241221012245.243845-8-ihor.solodrai@pm.me> <Z3VzsA8nv4kQj1bH@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 592cef34946214836df700f89e52d32187b977d5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 1st, 2025 at 8:56 AM, Jiri Olsa <olsajiri@gmail.com> =
wrote:

>=20
>=20
> On Sat, Dec 21, 2024 at 01:23:38AM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 90f1b9a..7e03ba4 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1326,7 +1326,7 @@ static void btf_encoder__delete_saved_funcs(struc=
t btf_encoder *encoder)
> > }
> > }
> >=20
> > -int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto=
)
> > +static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsisten=
t_proto)
> > {
> > struct btf_encoder_func_state **saved_fns, *s;
> > struct btf_encoder *e =3D NULL;
> > @@ -2134,7 +2134,6 @@ int btf_encoder__encode(struct btf_encoder *encod=
er, struct conf_load *conf)
> > int err;
> > size_t shndx;
> >=20
> > - /* for single-threaded case, saved funcs are added here */
> > btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsistent_proto=
);
>=20
>=20
> should we check the return value in here? now it's the only caller

Yes, thanks.

>=20
> SNIP
>=20
> > -struct dwarf_thread {
> > - struct dwarf_cus *dcus;
> > - void data;
> > +/ Multithreading is implemented using a job/worker model.
> > + * cus_processing_queue represents a collection of jobs to be
> > + * completed by workers.
> > + * dwarf_loader__worker_thread is the worker loop, taking jobs from
> > + * the queue, executing them and re-enqueuing new jobs as necessary.
> > + * Implementation of this queue ensures two constraints:
> > + * * JOB_STEAL jobs for a CU are executed in the order of cu->id, as
> > + * a consequence JOB_STEAL jobs always run one at a time.
> > + * * Initial number of JOB_DECODE jobs in the queue is effectively a
> > + * limit on how many decoded CUs can be held in memory.
> > + * See dwarf_loader__decoded_cus_limit()
> > + /
> > +static struct {
> > + pthread_mutex_t mutex;
> > + pthread_cond_t job_added;
> > + / next_cu_id determines the next CU ready to be stealed
> > + * This enforces the order of CU stealing.
> > + */
> > + uint32_t next_cu_id;
> > + struct list_head jobs;
> > +} cus_processing_queue;
> > +
> > +enum job_type {
> > + JOB_NONE =3D 0,
>=20
>=20
> nit, no need for JOB_NONE?

I find it useful for the default value to not be a valid "type". This
helps to avoid bugs when an object is initialized, but the type has
not been set explicitly (even though it should be).

>=20
> SNIP
>=20
> > +static struct cu_processing_job *cus_queue__try_dequeue(void)
> > +{
> > + struct cu_processing_job *job, *dequeued_job =3D NULL;
> > + struct list_head *pos, tmp;
> > +
> > + list_for_each_safe(pos, tmp, &cus_processing_queue.jobs) {
> > + job =3D list_entry(pos, struct cu_processing_job, node);
> > + if (job->type =3D=3D JOB_STEAL && job->cu->id =3D=3D cus_processing_q=
ueue.next_cu_id) {
> > + dequeued_job =3D job;
> > + break;
> > + }
> > + if (job->type =3D=3D JOB_DECODE) {
> > + / all JOB_STEALs are added to the head, so no viable JOB_STEAL availa=
ble /
> > + dequeued_job =3D job;
> > + break;
> > + }
> > + }
> > + / No jobs or only steals out of order */
> > + if (!dequeued_job)
> > + return NULL;
> > +
> > + list_del(&dequeued_job->node);
> > + return job;
>=20
>=20
> IIUC job =3D=3D dequeued_job at this point, but I think we should return
> dequeued_job to be clear

Agree.

>=20
> SNIP
>=20
> > -static void *dwarf_cus__process_cu_thread(void *arg)
> > +static struct cu *dwarf_loader__decode_next_cu(struct dwarf_cus *dcus)
> > {
> > - struct dwarf_thread *dthr =3D arg;
> > - struct dwarf_cus *dcus =3D dthr->dcus;
> > uint8_t pointer_size, offset_size;
> > + struct dwarf_cu *dcu =3D NULL;
> > Dwarf_Die die_mem, *cu_die;
> > - struct dwarf_cu *dcu;
> > + int err;
> >=20
> > - while (dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size=
, &offset_size) =3D=3D 0) {
> > - if (cu_die =3D=3D NULL)
> > + err =3D dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_siz=
e, &offset_size);
> > +
> > + if (err < 0)
> > + goto out_error;
> > + else if (err =3D=3D 1) /* no more CUs */
> > + return NULL;
> > +
> > + err =3D die__process_and_recode(cu_die, dcu->cu, dcus->conf);
> > + if (err)
> > + goto out_error;
> > + if (cu_die =3D=3D NULL)
> > + return NULL;
>=20
>=20
> should this check be placed before calling die__process_and_recode ?

Yes, but actually this check is redundant. If dwarf_cus__nextcu
returns 0, then the cu_die is valid. There are null checks within
dwarf_cus__nextcu:

=09if (ret =3D=3D 0 && *cu_die !=3D NULL) {
=09=09*dcu =3D dwarf_cus__create_cu(dcus, *cu_die, *pointer_size);
=09=09if (*dcu =3D=3D NULL) {
=09=09=09dcus->error =3D ENOMEM;
=09=09=09ret =3D -1;
=09=09=09goto out_unlock;
=09=09}
=09=09// Do it here to keep all CUs in cus->cus in the same
=09=09// order as in the DWARF file being loaded (e.g. vmlinux)
=09=09__cus__add(dcus->cus, (*dcu)->cu);
=09}

>=20
>=20
> SNIP
>=20
> > -static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
> > -{
> > - if (dcus->conf->nr_jobs > 1)
> > - return dwarf_cus__threaded_process_cus(dcus);
> > -
> > - return __dwarf_cus__process_cus(dcus);
> > -}
> > -
> > static int cus__merge_and_process_cu(struct cus *cus, struct conf_load =
*conf,
> > Dwfl_Module *mod, Dwarf *dw, Elf *elf,
> > const char *filename,
> > @@ -3733,7 +3859,8 @@ static int cus__merge_and_process_cu(struct cus *=
cus, struct conf_load *conf,
> > if (cu__resolve_func_ret_types_optimized(cu) !=3D LSK__KEEPIT)
> > goto out_abort;
> >=20
> > - if (cus__finalize(cus, cu, conf, NULL) =3D=3D LSK__STOP_LOADING)
> > + cu__finalize(cu, cus, conf);
> > + if (cus__steal_now(cus, cu, conf) =3D=3D LSK__STOP_LOADING)
> > goto out_abort;
> >=20
> > return 0;
> > @@ -3765,7 +3892,8 @@ static int cus__load_module(struct cus *cus, stru=
ct conf_load *conf,
> > }
> >=20
> > if (type_cu !=3D NULL) {
> > - type_lsk =3D cu__finalize(type_cu, cus, conf, NULL);
> > + cu__finalize(type_cu, cus, conf);
> > + type_lsk =3D cus__steal_now(cus, type_cu, conf);
> > if (type_lsk =3D=3D LSK__DELETE) {
> > cus__remove(cus, type_cu);
> > }
> > @@ -3787,6 +3915,7 @@ static int cus__load_module(struct cus *cus, stru=
ct conf_load *conf,
> > .type_dcu =3D type_cu ? &type_dcu : NULL,
> > .build_id =3D build_id,
> > .build_id_len =3D build_id_len,
> > + .nr_cus_created =3D 0,
>=20
>=20
> should go to the previous patch? if needed at all..

Yeah. I think it's better to have an explicit assignment.

>=20
> thanks,
> jirka
>=20
> > };
> > res =3D dwarf_cus__process_cus(&dcus);
> > }
> > diff --git a/dwarves.c b/dwarves.c
> > index ae512b9..7c3e878 100644
> > --- a/dwarves.c
> > +++ b/dwarves.c
> > @@ -530,48 +530,6 @@ void cus__unlock(struct cus *cus)
> > pthread_mutex_unlock(&cus->mutex);
> > }
>=20
>=20
> SNIP


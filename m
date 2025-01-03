Return-Path: <bpf+bounces-47814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F2A0021A
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25F51883CFE
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479C145B0C;
	Fri,  3 Jan 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="biFNFEci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755013CFBD;
	Fri,  3 Jan 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735865031; cv=none; b=TmPkmoOeEnM4acCO+8Us7EuZSNLfa1KQ8Nsr17pbjgBvEOLRl/0XC3PVGABUF+/ye14lBSYFPAUV+lOwQX82rq87YtKEMNsGwhb/JQOxrflarDDw47C9J9jMcFWry1DEUPK0LVCVacWnrHvSMgCYVbss5PMjb0N/YwtvcIEXi1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735865031; c=relaxed/simple;
	bh=ijaM6s4ZJaMgrFSHC+dq53reI8Fp8p8Vcj+z9h+hS0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEWC+1F1xfgpymK6WVyAtZJwN6E3anDs/20aBCSaaI7M5Ag3y7uAve7SIoiTo/WYkFpZfoP2glM9ncxU9L4BwRdhK1qnyfprrLy+hEg8+BjW/VOK1+uExvCLVXzlnefrvyO8Qu40vZjkKeZVg9MQFQqQEtY3brIeqDbejXoZRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=biFNFEci; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735865027; x=1736124227;
	bh=ijaM6s4ZJaMgrFSHC+dq53reI8Fp8p8Vcj+z9h+hS0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=biFNFEcih+YU7cKOuStfUZmmkFhTlrK5OoqBL7eF3i0lPBXyXFISYHrN1xZNz4KZd
	 iQauAHV9Q29CH1HeJZB1zoU6VbBory5oJRUzZyJwl73Lviq9jSpclVFNYh2jpX6hdv
	 KIekjyAUz+WhvVDLagDC0ghSn9b7je/ulKWRj5LUyBoT5S1zSZfZAVA/9IsA7387Wi
	 zKHGuzEt+Hqht2pxyGupgNc6FE0Q3ZwrOsK87FqUzpwRa94wcSGaQuIqlCJ1x1Oe+5
	 qwW2qGoM3hkuKNDi4YcjUuu2Wx4wxxtYOnbQ1FniUPOsgCCZFr45wTIXQpN1euYI3q
	 YuB4DQZxXZu0A==
Date: Fri, 03 Jan 2025 00:43:42 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 8/8] btf_encoder: clean up global encoders list
Message-ID: <hG-genPmZbX2hjVJ0oU90oOYrm7AWp9v0_G4kJwRvC3TBbFcg1rPFMEfu4-zQT8YHDihSU4XbSYNru8XrS-0fcpwSos0AODh8ASitiI5szQ=@pm.me>
In-Reply-To: <Z3VzuN8yX63qktPl@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me> <20241221012245.243845-9-ihor.solodrai@pm.me> <Z3VzuN8yX63qktPl@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 1f549ee92e84ec0397fc3be7154d497d4ab42f29
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
> On Sat, Dec 21, 2024 at 01:23:45AM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > -static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsisten=
t_proto)
> > +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, b=
ool skip_encoding_inconsistent_proto)
> > {
> > struct btf_encoder_func_state **saved_fns, *s;
> > - struct btf_encoder *e =3D NULL;
> > - int i =3D 0, j, nr_saved_fns =3D 0;
> > + int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
> >=20
> > - /* Retrieve function states from each encoder, combine them
> > + /* Retrieve function states from the encoder, combine them
> > * and sort by name, addr.
> > */
> > - btf_encoders__for_each_encoder(e) {
> > - list_for_each_entry(s, &e->func_states, node)
> > - nr_saved_fns++;
> > + list_for_each_entry(s, &encoder->func_states, node) {
> > + nr_saved_fns++;
> > }
> >=20
> > if (nr_saved_fns =3D=3D 0)
> > - return 0;
> > + goto out;
> >=20
> > saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
> > - btf_encoders__for_each_encoder(e) {
> > - list_for_each_entry(s, &e->func_states, node)
> > - saved_fns[i++] =3D s;
> > + if (!saved_fns) {
> > + err =3D -ENOMEM;
> > + goto out;
> > + }
> > +
> > + list_for_each_entry(s, &encoder->func_states, node) {
> > + saved_fns[i++] =3D s;
> > }
> > qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
> >=20
> > @@ -1377,11 +1313,10 @@ static int btf_encoder__add_saved_funcs(bool sk=
ip_encoding_inconsistent_proto)
> >=20
> > /* Now that we are done with function states, free them. */
> > free(saved_fns);
> > - btf_encoders__for_each_encoder(e) {
> > - btf_encoder__delete_saved_funcs(e);
> > - }
> > + btf_encoder__delete_saved_funcs(encoder);
>=20
>=20
> is this call necessary? there's btf_encoder__delete call right after
> same for elf_functions_list__clear in btf_encoder__encode

At this point we know that the function information is no longer
needed, so we can free up some memory.

I remember when I wrote a "context" patch [1] (now discarded), there
was a significant difference in MAX RSS between freeing this right
away and delaying until encoding is finished. Now it might not be as
significant, but still there is no reason to keep the stuff we know is
not used later.

[1] https://lore.kernel.org/dwarves/20241213223641.564002-8-ihor.solodrai@p=
m.me/

>=20
> thanks,
> jirka
>=20
> > - return 0;
> > +out:
> > + return err;
> > }
>=20
>=20
> SNIP



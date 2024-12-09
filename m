Return-Path: <bpf+bounces-46423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D29EA127
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF918872FA
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB868199E84;
	Mon,  9 Dec 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BfchS968"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C449652
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779211; cv=none; b=gjXACscyJHf9v/DVqm+yCZht1THbpSuFTv6T84NaIGXJIWQuDkrVrVOGTproGPeqUlriDEg08amlCQhupmuifI7ATh9E9Z2k/xoifv3IENn/6zrNTn5eLB163yGtJoSPk1GdFSlHD2u7NzB5SUUNNTfPVAMyCpAxRCUsZsrFrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779211; c=relaxed/simple;
	bh=treQA906LHFSeGVM20SWX7anjyEYlGsLgOwq281n5KY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVo1n8fGd3huDyAKfKFtQgYM/d9dOc5kMC0VMcUP11dYx2kpzLbPQHI/WhKSVhmTzrmH+w9/AmU71zFkTDmvuhAQGHPLexmrbP7ijH9QBlCvWhIQ3uQyppMwdd8ZigzjTCkQvGqL+GtmZ6+n0BJAStacdGCCb4/vg/tcgQulxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BfchS968; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733779199; x=1734038399;
	bh=treQA906LHFSeGVM20SWX7anjyEYlGsLgOwq281n5KY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BfchS968y6E5gfwUo41pQ+7PjoPq/AhFFVfaa0yS7fyvDyZ6QQIg1YxpeRessqGLI
	 LNHW+vScm4qbtjyOGYbQy2TxyTzPPg0H9GuXa+N4xkGcTYaiW9i98P9928T1gKeFcj
	 IwqkcC6vHTbxq0Etpz+BbrMorI4qHsv7VcHy0TQQruWUPqs0BXlk0gf6WuKKjgz9WY
	 1b5vmbhqQOdmoPsovog1mjnvymjL1xeUZ0UR2zTuO6cA9J2Jc6fRRiEm3Hq9SlxTA/
	 D8vud900TbCVX+GLFp+EaJ+0yuO7zTWmfiTcjbxA376wpFAP4+blFLHxJkgOLnyYbL
	 4kKU2vvm5J4Mw==
Date: Mon, 09 Dec 2024 21:19:55 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, mykolal@fb.com
Subject: Re: [RFC PATCH 3/9] btf_encoder: separate elf function, saved function representations
Message-ID: <BYUWdN7DqLYAVNMnw9WWl7MshnWOV2o1hduVJT7l-ZOsTpp9R8wkBtWIgy18F9hTsgC0WbL1jas0MQ0Pj_5BzD9C53yJfwj3wn7kQJCS468=@pm.me>
In-Reply-To: <39b3f6f04838b96e858effc09e01d7b29c529f2e.camel@gmail.com>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me> <20241128012341.4081072-4-ihor.solodrai@pm.me> <39b3f6f04838b96e858effc09e01d7b29c529f2e.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: cdcabbb0b4913828944faf71e4864ab0e8ddd820
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, November 29th, 2024 at 12:37 PM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:

> On Thu, 2024-11-28 at 01:23 +0000, Ihor Solodrai wrote:
>=20
> [...]
>=20
> Acked-by: Eduard Zingerman eddyz87@gmail.com
>=20
>=20
> I like what this patch does, a few nits below.
>=20
> Note:
> this patch leads to 58 less functions being generated,
> compared to a previous patch, for my test configuration.
> For example, functions like:
> - hid_map_usage_clear
> - jhash
> - nlmsg_parse_deprecated_strict
> Are not in the BTF anymore. It would be good if patch message could
> explain why this happens.

Hey Eduard.

I decided to remove patch 2/9 [1] for the v2 of this series, as it is
largely unrelated.

Applying 1/9 and 3/9 (this patch) to next, I couldn't reproduce the
difference you described. With reproducible_build I get identical text
dump of BTFs between next [2] and the changes [3].

It looks to me the difference you noted here is caused by introduction
of section-relative addresses in the patch 2/9.

>=20
> [...]
>=20
> > +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
> > +{
> > + struct btf_encoder_func_state **saved_fns, *s;
> > + struct btf_encoder e =3D NULL;
> > + int i =3D 0, j, nr_saved_fns =3D 0;
> > +
> > + / Retrieve function states from each encoder, combine them
> > + * and sort by name, addr.
> > + /
> > + btf_encoders__for_each_encoder(e) {
> > + list_for_each_entry(s, &e->func_states, node)
> > + nr_saved_fns++;
> > + }
> > + / Another thread already did this work */
> > + if (nr_saved_fns =3D=3D 0) {
> > + printf("nothing to do for encoder...\n");
> > + return 0;
> > + }
>=20
>=20
> Nit: this function is called from pahole_threads_collect():
>=20
> static int pahole_threads_collect(...)
> for (i =3D 0; i < nr_threads; i++)
> ...
> err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
>=20
> ...
>=20
> int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_=
encoder *other)
> ...
> btf_encoder__add_saved_funcs(other);
> ...
>=20
> maybe move call to btf_encoder__add_saved_funcs() to pahole_threads_colle=
ct()
> outside of the loop? So that comment about another thread won't be necess=
ary.

Done in [3].

>=20
> [...]
>=20
> > @@ -2437,16 +2470,8 @@ out_delete:
> > return NULL;
> > }
> >=20
> > -void btf_encoder__delete_func(struct elf_function *func)
> > -{
> > - free(func->alias);
>=20
>=20
> Nit: it looks like func->alias is never freed after this change.

Yeap. Fixed in [3].

Sanitizer also caught leaked secinfo here, the one you noted in a
different thread [4]. Fixed in [3] as well.

[1]: https://lore.kernel.org/dwarves/20241128012341.4081072-3-ihor.solodrai=
@pm.me/
[2]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dnex=
t&id=3D3ddadc131586d6f3aa68775636adff5f7e7ff0f0
[3]: https://github.com/acmel/dwarves/commit/20ef1cd5131d340caaa4719e980b4d=
a77c345579
[4]: https://lore.kernel.org/dwarves/e1df45360963d265ea5e0b3634f0a3dae0c9c3=
43.camel@gmail.com/

>=20
> > - zfree(&func->state.annots);
> > - zfree(&func->state.parms);
> > -}
>=20
>=20
> [...]




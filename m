Return-Path: <bpf+bounces-47776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527B9FFFB4
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E8F1883A58
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C41B3937;
	Thu,  2 Jan 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LVYL56Gj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FA28FD;
	Thu,  2 Jan 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847690; cv=none; b=htawqFbHgBzjy6UpIKJWXywPYuAYmBUZzuhFwKTO3O+Cn52/Vcl9wUjhUKnDe3pccNmyxSGqb5LgCnV9HRpn80UqsFXlQsSM193SZxAJpSiuYQ0z6rJBN06cVL/g26/BMLhfHCFE/YHp3+vaC3HIgpge/zEaAdZh9wVt0zRLM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847690; c=relaxed/simple;
	bh=JSiC+wQojJKFqqnOYedfOOgOWmdFjMSWvFMipApGYMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUumAwYhrowYUdUcl63s3YCD+5p11wiiLXRCYM3Pj1AqRyu3athSttidCrns/HOrOUtPbVxf6ALWOzsryFga6teZN0iqZb4ywrE8HdwWWoORxLt/Ywb9ESm/gdy05ovYD31PtXxkSY3abGfOx3V03oo6ZJ609jPaE3pa7TDXt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LVYL56Gj; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735847678; x=1736106878;
	bh=JSiC+wQojJKFqqnOYedfOOgOWmdFjMSWvFMipApGYMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LVYL56Gj0+qcKc28tqWmBdw9xOwSKEQjA4jB+k20bqSyrg6vlvDEBzMkmmI0Etv88
	 5hsRbWCQZs+FBWPPH6X8i2OJo3uMVL3cetAwPDomz5maed9ZQvMSFPigXiBQqaF3ko
	 1AzCwsIBWLdvdY5tq4QzYqi3GRQlyP2RtuGHx/nOzR0cgATJxMicqyfcUD7HldaQq8
	 MyWpUZCjvdIKgAPmc1bfDj+p6HfBgbpOKtkOVfjA1zIVNjMNRIL+88Ujj8W1izigX7
	 wXI7IJa1zXxhXDioYHJUgHA2SBWSfWPHZKw8queuGuXdNyScDQF67RHWTPLyJYWvnV
	 L5lY5AhycVS9A==
Date: Thu, 02 Jan 2025 19:54:36 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 2/8] btf_encoder: separate elf function, saved function representations
Message-ID: <YiiVvWJxHUyK75b4FqlvAOnHvX9WLzCsRLG-236zf_cPZy1jmgbUq2xM4ChxRob1kaTVUdtVljtcpL2Cs3v1wXPGcP8dPeASBiYVGH3jEaQ=@pm.me>
In-Reply-To: <Z3Vzp9M55sRsNgCP@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me> <20241221012245.243845-3-ihor.solodrai@pm.me> <Z3Vzp9M55sRsNgCP@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 446936c6a5e337cbdfba06bd9a572bbe7f2ccfa6
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
> On Sat, Dec 21, 2024 at 01:23:01AM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > +static int saved_functions_combine(void *_a, void *_b)
> > +{
> > + uint8_t optimized, unexpected, inconsistent;
> > + struct btf_encoder_func_state *a =3D _a;
> > + struct btf_encoder_func_state *b =3D _b;
> > + int ret;
> > +
> > + ret =3D strncmp(a->elf->name, b->elf->name,
> > + max(a->elf->prefixlen, b->elf->prefixlen));
> > + if (ret !=3D 0)
> > + return ret;
> > + optimized =3D a->optimized_parms | b->optimized_parms;
> > + unexpected =3D a->unexpected_reg | b->unexpected_reg;
> > + inconsistent =3D a->inconsistent_proto | b->inconsistent_proto;
> > + if (!unexpected && !inconsistent && !funcs__match(a, b))
> > + inconsistent =3D 1;
> > + a->optimized_parms =3D b->optimized_parms =3D optimized;
> > + a->unexpected_reg =3D b->unexpected_reg =3D unexpected;
> > + a->inconsistent_proto =3D b->inconsistent_proto =3D inconsistent;
>=20
>=20
> do we still need to update the 'b' state object?

Hi Jiri, thanks for review.

Given how this function is used, we don't need to. But this is a kind
of a "merge", and IMO having both states equal on the way out makes
sense.

=09=09while (j < nr_saved_fns && saved_functions_combine(saved_fns[i], save=
d_fns[j]) =3D=3D 0)
=09=09=09j++;

>=20
> > +
> > + return 0;
> > +}
> > +
> > +static void btf_encoder__delete_saved_funcs(struct btf_encoder *encode=
r)
> > +{
> > + struct btf_encoder_func_state *pos, *s;
> > +
> > + list_for_each_entry_safe(pos, s, &encoder->func_states, node) {
> > + list_del(&pos->node);
> > + free(pos->parms);
> > + free(pos->annots);
> > + free(pos);
> > + }
> > +
> > + for (int i =3D 0; i < encoder->functions.cnt; i++)
> > + free(encoder->functions.entries[i].alias);
> > +}
> > +
> > +int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
> > +{
> > + struct btf_encoder_func_state **saved_fns, *s;
> > + struct btf_encoder e =3D NULL;
> > + int i =3D 0, j, nr_saved_fns =3D 0;
> > +
> > + / Retrieve function states from each encoder, combine them
> > + * and sort by name, addr.
> > + */
> > + btf_encoders__for_each_encoder(e) {
> > + list_for_each_entry(s, &e->func_states, node)
> > + nr_saved_fns++;
> > + }
>=20
>=20
> the encoder loop goes eventualy away, but still would it make to store
> func_states count instead of the loop?
>=20
> now when there's just single place that stores 'state' it seems like it
> should be straighforward

Yeah.

>=20
> SNIP
>=20
> > void btf_encoder__delete(struct btf_encoder *encoder)
> > {
> > - int i;
> > size_t shndx;
> >=20
> > if (encoder =3D=3D NULL)
> > @@ -2447,18 +2469,19 @@ void btf_encoder__delete(struct btf_encoder *en=
coder)
> > btf_encoders__delete(encoder);
> > for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
> > __gobuffer__delete(&encoder->secinfo[shndx].secinfo);
> > + free(encoder->secinfo);
>=20
>=20
> nit, this seems unrelated to this change, should be in separate fix?

IIRC this was also caught by the sanitizer. I'll sliver this into a
separate patch in the next iteration.

>=20
> thanks,
> jirka
>=20
> > zfree(&encoder->filename);
> > zfree(&encoder->source_filename);
> > btf__free(encoder->btf);
> > encoder->btf =3D NULL;
> > elf_symtab__delete(encoder->symtab);
> >=20
> > - for (i =3D 0; i < encoder->functions.cnt; i++)
> > - btf_encoder__delete_func(&encoder->functions.entries[i]);
> > encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
> > free(encoder->functions.entries);
> > encoder->functions.entries =3D NULL;
> >=20
> > + btf_encoder__delete_saved_funcs(encoder);
> > +
> > free(encoder);
> > }
>=20
>=20
> SNIP



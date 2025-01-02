Return-Path: <bpf+bounces-47778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B603B9FFFCB
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959E43A35B0
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC341B4F3A;
	Thu,  2 Jan 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LFapZnML"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774403D96A;
	Thu,  2 Jan 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735848387; cv=none; b=MCz7xuRf7ZIy3SuU7gqLh43h/xLkybChG+KYniUcT1iF1GRMbIj+x92f+wK6zRxqULHrTiQzyJrqmnYJN0iLdy6GZJuqDv8ujUUHCUKnM0j7rsfpkfkNGByls8y9VO3MLInwHRCdDNxJEZFyKlSlvnCN62C4KTmGWFnizYoBoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735848387; c=relaxed/simple;
	bh=URkk3ojDl9zhoDmfCj9S37FZkFSv8dphTHRMkGvzr/w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5bse33K3rcwOeLIMI4A1cuEyDZqITOVu8Cah3kXFX/net3QgR++iAn67BmSy1XRIlprGdYUSYgNSWF7MJRUseWjr1HptNFB5+d3xBklrxIBYNz0pHLNF3Q3c1ELpYITuyE8+eGiq6EMcDEsldwDUwCrrzCtts6CUcerS68IpCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LFapZnML; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735848382; x=1736107582;
	bh=URkk3ojDl9zhoDmfCj9S37FZkFSv8dphTHRMkGvzr/w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LFapZnMLcwXhY1e5JOmXM968WOTN/WyQ6WMtaPahr/MX/Cjk+GSBAu9ovEZz0Tzd/
	 KPSaadmzgVuiR8pVRImp+zjYiXhSlTEy5r8vuf3g+Fa7QtrFAZm3ajI54RUueyq4Uu
	 hTYkeqkGHPgUPSEABofJGAlgpqG8UpNbhVXOHaRTr8hnRljREmvNS4Y1pGR/Alev6p
	 +OuNQWLvhYpIfacknu2z4DGEzJwRkn+71XTozSUqDENCjWXuSDy6wap60IofNtk5b/
	 tnfpFWgkkKKnanSF4MCAlTsGff6K2ODCkdEdYzubddFR4FNKO9S90qnOiBHqcShXnX
	 Smdt3IlOilEqg==
Date: Thu, 02 Jan 2025 20:06:18 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 3/8] btf_encoder: introduce elf_functions struct type
Message-ID: <3MqWfdjBO9srtpr8kjweJgCkdwYKV6JC_-SN27S8Y9_J1SzssIgZs4Ptc5tEqpZ7w2vbSmTQ35J5CX35Yb4KMbw8wsTrB2IAf2SWU-k4Xi4=@pm.me>
In-Reply-To: <Z3VzwnXfKIKMi5TX@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me> <20241221012245.243845-4-ihor.solodrai@pm.me> <Z3VzwnXfKIKMi5TX@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 6c363a8fe984166e4df34110c1e2a53793134112
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
> On Sat, Dec 21, 2024 at 01:23:10AM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > -static int btf_encoder__collect_function(struct btf_encoder *encoder, =
GElf_Sym *sym)
> > +static void elf_functions__collect_function(struct elf_functions *func=
tions, GElf_Sym *sym)
> > {
> > - struct elf_function *new;
> > + struct elf_function *func;
> > const char *name;
> >=20
> > if (elf_sym__type(sym) !=3D STT_FUNC)
> > - return 0;
> > - name =3D elf_sym__name(sym, encoder->symtab);
> > - if (!name)
> > - return 0;
> > + return;
> >=20
> > - if (encoder->functions.cnt =3D=3D encoder->functions.allocated) {
> > - new =3D reallocarray_grow(encoder->functions.entries,
> > - &encoder->functions.allocated,
> > - sizeof(encoder->functions.entries));
> > - if (!new) {
> > - /
> > - * The cleanup - delete_functions is called
> > - * in btf_encoder__encode_cu error path.
> > - */
> > - return -1;
> > - }
> > - encoder->functions.entries =3D new;
> > - }
> > + name =3D elf_sym__name(sym, functions->symtab);
> > + if (!name)
> > + return;
> >=20
> > - memset(&encoder->functions.entries[encoder->functions.cnt], 0,
> > - sizeof(*new));
> > - encoder->functions.entries[encoder->functions.cnt].name =3D name;
> > + func =3D &functions->entries[functions->cnt];
> > + func->name =3D name;
> > if (strchr(name, '.')) {
> > const char *suffix =3D strchr(name, '.');
> > -
>=20
>=20
> nit, let's keep that new line after declaration

ok

>=20
> > - encoder->functions.suffix_cnt++;
> > - encoder->functions.entries[encoder->functions.cnt].prefixlen =3D suff=
ix - name;
> > + functions->suffix_cnt++;
> > + func->prefixlen =3D suffix - name;
> > } else {
> > - encoder->functions.entries[encoder->functions.cnt].prefixlen =3D strl=
en(name);
> > + func->prefixlen =3D strlen(name);
> > }
> > - encoder->functions.cnt++;
> > - return 0;
> > +
> > + functions->cnt++;
> > }
> >=20
> > static struct elf_function *btf_encoder__find_function(const struct btf=
_encoder *encoder,
> > @@ -2126,26 +2103,56 @@ int btf_encoder__encode(struct btf_encoder *enc=
oder)
> > return err;
> > }
> >=20
> > -
> > -static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
> > +static int elf_functions__collect(struct elf_functions *functions)
> > {
> > - uint32_t sym_sec_idx;
> > + uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
> > + struct elf_function *tmp;
> > + Elf32_Word sym_sec_idx;
> > uint32_t core_id;
> > GElf_Sym sym;
> > + int err;
> >=20
> > - elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_=
sec_idx) {
> > - if (btf_encoder__collect_function(encoder, &sym))
> > - return -1;
> > + /* We know that number of functions is less than number of symbols,
> > + * so we can overallocate temporarily.
> > + */
> > + functions->entries =3D calloc(nr_symbols, sizeof(*functions->entries)=
);
> > + if (!functions->entries) {
> > + err =3D -ENOMEM;
> > + goto out_free;
>=20
>=20
> you could just return -ENOMEM here

I am trying to adhere to the kernel style, although not very strictly.
It's recommended [1] to have a single exit from a function when there
is cleanup work.

I usually check my patches with a script [2] before submitting.

[1] https://www.kernel.org/doc/html/v4.10/process/coding-style.html#central=
ized-exiting-of-functions
[2] https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl

>=20
> > + }
> > +
> > + functions->cnt =3D 0;
> > + elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sy=
m_sec_idx) {
> > + elf_functions__collect_function(functions, &sym);
> > }
> >=20
> > - if (encoder->functions.cnt) {
> > - qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(enco=
der->functions.entries[0]),
> > + if (functions->cnt) {
> > + qsort(functions->entries,
> > + functions->cnt,
> > + sizeof(*functions->entries),
> > functions_cmp);
>=20
>=20
> nit, why not keep the single line?

How many chars in a line is too many? :)

>=20
> > - if (encoder->verbose)
> > - printf("Found %d functions!\n", encoder->functions.cnt);
> > + } else {
> > + err =3D 0;
> > + goto out_free;
> > + }
> > +
> > + /* Reallocate to the exact size */
> > + tmp =3D realloc(functions->entries, functions->cnt * sizeof(struct el=
f_function));
> > + if (tmp) {
> > + functions->entries =3D tmp;
> > + } else {
> > + fprintf(stderr, "could not reallocate memory for elf_functions table\=
n");
> > + err =3D -ENOMEM;
> > + goto out_free;
> > }
> >=20
> > return 0;
> > +
> > +out_free:
> > + free(functions->entries);
> > + functions->entries =3D NULL;
> > + functions->cnt =3D 0;
> > + return err;
> > }
> >=20
> > static bool ftype__has_arg_names(const struct ftype *ftype)
> > @@ -2406,6 +2413,7 @@ struct btf_encoder *btf_encoder__new(struct cu *c=
u, const char *detached_filenam
> > printf("%s: '%s' doesn't have symtab.\n", func, cu->filename);
> > goto out;
> > }
> > + encoder->functions.symtab =3D encoder->symtab;
>=20
>=20
> I was wondering if we need to keep both symtab pointers, but it's sorted
> out in the next patch ;-)
>=20
> thanks,
> jirka
>=20
> [...]



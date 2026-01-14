Return-Path: <bpf+bounces-78848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E27D1D3B6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF9B30082C9
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCD36E493;
	Wed, 14 Jan 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R7jHi1BQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB14218AAD
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380538; cv=none; b=o0qgpjgWVWnAl0UPps2fAQpnHTATSXNygkKgHR74+paBskmXWZ9B0JM0CuCcjXcokqR3mJvoJrvjnaxZ3git4p3ULUSMzuN7/k/1fjNORLH5HgC905OK5py/IloyhvsphK8zIvYo5d+icIM1qNJ64VE37mmmtsFhuomIIshjyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380538; c=relaxed/simple;
	bh=m7WlSDjsJR23TNHdC8y0tLHb4b6D1xumCWxXi1BM0Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfVoE+EkNFHP2vnd5rajjOuT9wLM8/ovXK8tL+P7ftMq6o8gAdjakrtiTDSFZ7NRkZS8Ko8eZ07+sSUHv0NdYuBRbYPagsqONS9qTTAs/U6DzxEyf5DF4/q4eLatbxL1As8NlHRmNpyFF+UzeXZTkqz/rXtP8wkaDJ7lCGlHKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R7jHi1BQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768380530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFOvYS/MwLIoa2ddKtSerXnnDZ6P+P0QxZA10mD8sGk=;
	b=R7jHi1BQHrpYXKbkhrJYyhW/15yWOtqM8To4dfUn4yXQHUs64cj6n7K4oLF+s+q/e/b2zQ
	MMwFcGvtGx6VckfAj0b1UI+Klr5FEB5HNg1sG1un4yovX71Aqyh9uF+H5gkLyh36c/3nfa
	AfW3oYFB22Sk3Brat2A11k7mAGushXI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net, kernel-team@fb.com
Subject:
 Re: [PATCH bpf-next 3/9] libbpf: improve relocation ambiguity detection
Date: Wed, 14 Jan 2026 16:48:39 +0800
Message-ID: <4682258.8F6SAcFxjW@7940hx>
In-Reply-To:
 <CAEf4Bzb04C97K=S1av_6EKG3jKHoG+mKwaxVw3cCnNsbyiDzmw@mail.gmail.com>
References:
 <20200818223921.2911963-1-andriin@fb.com> <2249675.irdbgypaU6@7940hx>
 <CAEf4Bzb04C97K=S1av_6EKG3jKHoG+mKwaxVw3cCnNsbyiDzmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 07:26 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Mon, Jan 12, 2026 at 11:36=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> >
> > On 2020/8/19 06:39 Andrii Nakryiko <andriin@fb.com> write:
> > > Split the instruction patching logic into relocation value calculatio=
n and
> > > application of relocation to instruction. Using this, evaluate reloca=
tion
> > > against each matching candidate and validate that all candidates agre=
e on
> > > relocated value. If not, report ambiguity and fail load.
> > >
> > > This logic is necessary to avoid dangerous (however unlikely) acciden=
tal match
> > > against two incompatible candidate types. Without this change, libbpf=
 will
> > > pick a random type as *the* candidate and apply potentially invalid
> > > relocation.
> > >
> > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 170 ++++++++++++++++++++++++++++++---------=
=2D-
> > >  1 file changed, 124 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 2047e4ed0076..1ba458140f50 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > [......]
> > > @@ -5005,16 +5063,31 @@ static int bpf_core_reloc_field(struct bpf_pr=
ogram *prog,
> > >               if (err =3D=3D 0)
> > >                       continue;
> > >
> > > +             err =3D bpf_core_calc_relo(prog, relo, relo_idx, &local=
_spec, &cand_spec, &cand_res);
> > > +             if (err)
> > > +                     return err;
> > > +
> > >               if (j =3D=3D 0) {
> > > +                     targ_res =3D cand_res;
> > >                       targ_spec =3D cand_spec;
> > >               } else if (cand_spec.bit_offset !=3D targ_spec.bit_offs=
et) {
> > > -                     /* if there are many candidates, they should all
> > > -                      * resolve to the same bit offset
> > > +                     /* if there are many field relo candidates, they
> > > +                      * should all resolve to the same bit offset
> > >                        */
> > > -                     pr_warn("prog '%s': relo #%d: offset ambiguity:=
 %u !=3D %u\n",
> > > +                     pr_warn("prog '%s': relo #%d: field offset ambi=
guity: %u !=3D %u\n",
> > >                               prog_name, relo_idx, cand_spec.bit_offs=
et,
> > >                               targ_spec.bit_offset);
> > >                       return -EINVAL;
> > > +             } else if (cand_res.poison !=3D targ_res.poison || cand=
_res.new_val !=3D targ_res.new_val) {
> > > +                     /* all candidates should result in the same rel=
ocation
> > > +                      * decision and value, otherwise it's dangerous=
 to
> > > +                      * proceed due to ambiguity
> > > +                      */
> > > +                     pr_warn("prog '%s': relo #%d: relocation decisi=
on ambiguity: %s %u !=3D %s %u\n",
> > > +                             prog_name, relo_idx,
> > > +                             cand_res.poison ? "failure" : "success"=
, cand_res.new_val,
> > > +                             targ_res.poison ? "failure" : "success"=
, targ_res.new_val);
> > > +                     return -EINVAL;
> > >               }
> >
> > Hi, Andrii. This approach is not friend to bpf_core_cast() if the struct
> > is not used in the vmlinux, but the kernel modules.
> >
> > Take "struct nft_chain" for example. Following code will fail:
> >     struct nft_chain *chain =3D bpf_core_cast(ptr, struct nft_chain).
> >
> > The bpf_core_cast() will record a BPF_CORE_TYPE_ID_TARGET relocation
> > for "struct nft_chain". The libbpf will find multi btf type of nft_chain
> > in the modules nf_tables, nft_reject, etc, and it will fail the verific=
ation
> > due to the "new_val", which is btf type id, not the same, even if all
> > the "struct nft_chain" are exactly the same in different kernel modules.
> >
> > I think this is a common case. So how about we check the consistence of
> > struct nft_chain in all the candidate list, and use the first one if al=
l of
> > them have exactly the same definition?
>=20
> BTF type ID for some type in some kernel is not meaningful without
> also capturing module's BTF ID or FD, so we'd be just capturing some
> relatively random and meaningless type ID.
>=20
> I'm actually not sure bpf_core_cast() can work with BTF types defined
> in module's BTF. Can you please check what we do if we have
> non-ambiguous BTF type defined only in module's BTF?

You are right. I got the following error when I use bpf_core_cast()
for the struct that in kernel module:
    Unknown type ID 142301 passed to kfunc bpf_rdonly_cast

It seems that I didn't realize the kernel side. The module's BTF ID
or FD for the struct is unknown for the kernel, and it will only
lookup it in the btf that the kfunc belongs to.

>=20
> >
> > We can check all the members in the struct iteratively, and make
> > sure they are all the same.
> >
>=20
> It's not even clear what "same" would mean here, btw. None of the
> issues you bring up are easy to solve :)

Yeah, thing is much more complex than I thought. I think I'd better
use bpf_probe_kernel_read() for such case ;)

Thanks!
Menglong Dong

>=20
> > Thanks!
> > Menglong Dong
> >
> > >
> > >               cand_ids->data[j++] =3D cand_spec.spec[0].type_id;
> > > @@ -5042,13 +5115,18 @@ static int bpf_core_reloc_field(struct bpf_pr=
ogram *prog,
> > >        * verifier. If it was an error, then verifier will complain an=
d point
> > >        * to a specific instruction number in its log.
> > >        */
> > > -     if (j =3D=3D 0)
> > > +     if (j =3D=3D 0) {
> > >               pr_debug("prog '%s': relo #%d: no matching targets foun=
d\n",
> > >                        prog_name, relo_idx);
> > >
> > > -     /* bpf_core_reloc_insn should know how to handle missing targ_s=
pec */
> > > -     err =3D bpf_core_reloc_insn(prog, relo, relo_idx, &local_spec,
> > > -                               j ? &targ_spec : NULL);
> > > +             /* calculate single target relo result explicitly */
> > > +             err =3D bpf_core_calc_relo(prog, relo, relo_idx, &local=
_spec, NULL, &targ_res);
> > > +             if (err)
> > > +                     return err;
> > > +     }
> > > +
> > > +     /* bpf_core_patch_insn() should know how to handle missing targ=
_spec */
> > > +     err =3D bpf_core_patch_insn(prog, relo, relo_idx, &targ_res);
> > >       if (err) {
> > >               pr_warn("prog '%s': relo #%d: failed to patch insn at o=
ffset %d: %d\n",
> > >                       prog_name, relo_idx, relo->insn_off, err);
> > > --
> > > 2.24.1
> > >
> > >
> >
> >
> >
> >






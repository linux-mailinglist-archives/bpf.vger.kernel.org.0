Return-Path: <bpf+bounces-76194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B3DCA9AD6
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 01:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F325F3017327
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4314C81;
	Sat,  6 Dec 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/KPt9DJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49D184
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979894; cv=none; b=UXY6wFIE2mJNQ0yKvrUiKVkEwdNxTx+oR7HJeHdY0PrcVT/noMHC3rfrweMVWOCTx6kNMpaQ8UbyZohIh8/K2+DWtEWpLBdeoPELWA1HAcdgPO7SBTykeO+sJL1bTZCZqd7nLArrIAgV71t4Y76S8kcZdvAbiiFdfTDMnUnhrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979894; c=relaxed/simple;
	bh=hAwk6SPNZjh7cM8p8luUzYYSKajhfccr6Qncykep1nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYq2AuElXWKiL9pH1YCsFOIMONAVac50+SfoRoiNOKNWhKoI+ciwmZTsi9W65hoAe3TD8O0JlI5kSoXc+Gf9cOAFccXKMJa4NFgHjhrEMtsyiAEX5no5fX/6VwvTWhEWwbb86XpiSnvDEzEP9ygYGQyf89c2OOpfYrFgl9BF97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/KPt9DJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343d73d08faso1405350a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764979892; x=1765584692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xUhJwjdDqNbq1a4oYSu07fCbOOzN5QUVn2MmlMv/q8=;
        b=m/KPt9DJjzAg0zkg1k7zZPxeuBgagxwxHC4BWNe6s43M1KbdSpnEMMLZ8JO/VSc9fm
         b2GIJv1GWvhIpzyhAWEtXS4uE+ghja0Lz/B4dBaFhRkxbhrWzD43uCEJDwDCGzNMBLep
         JL5dhGZBX6IGXbuFWBce2y/cgif3D3wWDCQQNqUYQcyP9ScaZlZ05N6RPMCp4xZBFwij
         vLSCMk7Pk1k3K8HtBJHE2UlmWlKFmdvB1hf9Gsn1a8BLOkvne+yR15H70Tdx7f+8Tlg+
         lA+iWyGo6qGFqoT26avMqH8We9yW+QAKQm8uvzpcJnWNJkrdf9HuW1bbXSoMFlh6ERfy
         36bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764979892; x=1765584692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xUhJwjdDqNbq1a4oYSu07fCbOOzN5QUVn2MmlMv/q8=;
        b=mpN+VQbwcY3a3irONLBCeBAZ+7/rERTh0SCRz1q6DplFH8dB/8GSJeHjKygwyTN8S/
         krcrff2hxzFBp59bKyXW4/nIs0bevwYGMJPnz6xEEJ94wMgrzNaoX9Ammg8tivxO4cS5
         AB4Lryk5jIq1E+qo+pn+CGfi3G14fhEEYNuWpOEWp4IPRMqw+XN//Mb2bX0/eqmInQ80
         obcJdy2UK+9sODCBv5vpYCq4odAAxoBXTnQk+yRTpz4+x22qLrFO6tt0cBk1dIbQzI49
         fLe1Zh5qcxy9rbOkO7ztHeJ765UoTjkMLg7u11zY900/yZ9uO1aY20sGCGaoiN2bdV3D
         U3og==
X-Forwarded-Encrypted: i=1; AJvYcCUMwp6N9TlFTJn62fF697X5wFXUW9g7miH02oSCs8t8mGCHGzoN1FgDkAT9j7RzbJpVbDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q3fBGXjGNqQDZuTB/SLEh+ThkS1CKOc9W+/xoGRe+GsZzDpk
	Ex3De+Sd3rTlJoRt4AM8wO6IsZBNTb1LT7R3GqI2eM95ZRmt1FGGOIjv+KJr4vjhf5BcQDprJdQ
	xdVI0qf2hzPSD7EIV/6BWRhrWfCi2Jic=
X-Gm-Gg: ASbGncvYnsEwV5fG7oel3GAK0ma8hgmWTHs8eVTI/kaYDI97uhcj/G/bQ9y4sGQ4TT9
	MjWs6b/ZBiH38RfJNvStIZ0E4ndORC7PLNIXGFgMpCwk+lF2zzWH3/DCiN4sz+VuuHzXxwpbfpU
	ooMdwpxjAwfwYaJgikOymQwRTfRM9hKEU3DHGcYY2lt8eAetwnHzypC1RDuVINoYeqKTI4ZcGnB
	cuvGmSGp9rE7gI4NvPBBi/8n4OVE9ldKwMgquhyVAkVkt9C9qx75Tj35cm1CQAwNZ7ciprSG8Tx
	2T8JwCQCcD0=
X-Google-Smtp-Source: AGHT+IGbtebGvfdhqqlQhl7Yd0aBFq/2EwVMusft9KNPwfoGjbQpNl2c/1hti9lEH4Dzc95aDzX/nuDPhGd5IBWw8Kw=
X-Received: by 2002:a17:90a:d603:b0:343:a298:90ac with SMTP id
 98e67ed59e1d1-34943730cfdmr7962032a91.0.1764979891348; Fri, 05 Dec 2025
 16:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203162625.13152-4-emil@etsalapatis.com> <45513ae5c2cfe74c5d29d23e6c2eaec62b07e709138bc9167c5fea5ea6dde762@mail.kernel.org>
In-Reply-To: <45513ae5c2cfe74c5d29d23e6c2eaec62b07e709138bc9167c5fea5ea6dde762@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 16:11:19 -0800
X-Gm-Features: AWmQ_bmbm35FZSLZu_7F93z9HEg0vE-shOZMoE3pOuBUoM0K7BTdqoZ6ABuPFrw
Message-ID: <CAEf4BzYoD85yjR7-9RTwSMU6zJ3pMJAnUC1CeNy4Hy7c2es21w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: move arena globals to the end of the arena
To: bot+bpf-ci@kernel.org
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 706e7481b..9642d697b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -2991,10 +2992,11 @@ static int init_arena_map_data(struct bpf_objec=
t *obj, struct bpf_map *map,
> >                              void *data, size_t data_sz)
> >  {
> >       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > +     const size_t data_alloc_sz =3D roundup(data_sz, page_sz);
> >       size_t mmap_sz;
> >
> >       mmap_sz =3D bpf_map_mmap_sz(map);
> > -     if (roundup(data_sz, page_sz) > mmap_sz) {
> > +     if (data_alloc_sz > mmap_sz) {
> >               pr_warn("elf: sec '%s': declared ARENA map size (%zu) is =
too small to hold global __arena variables of size %zu\n",
> >                       sec_name, mmap_sz, data_sz);
> >               return -E2BIG;
> > @@ -3006,6 +3008,9 @@ static int init_arena_map_data(struct bpf_object =
*obj, struct bpf_map *map,
> >       memcpy(obj->arena_data, data, data_sz);
> >       obj->arena_data_sz =3D data_sz;
> >
> > +     /* place globals at the end of the arena */
> > +     obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> > +
>
> Here obj->arena_data_off is a __u32, but the calculation is done in
> size_t (64-bit). For a 4GB arena (which the test verifier_arena_large.c
> uses), mmap_sz is 4GB and the result can approach 4GB - PAGE_SIZE. This
> fits in u32 correctly.
>
> > @@ -4663,7 +4668,7 @@ static int bpf_program__record_reloc(struct bpf_p=
rogram *prog,
> >               reloc_desc->type =3D RELO_DATA;
> >               reloc_desc->insn_idx =3D insn_idx;
> >               reloc_desc->map_idx =3D obj->arena_map_idx;
> > -             reloc_desc->sym_off =3D sym->st_value;
> > +             reloc_desc->sym_off =3D sym->st_value + obj->arena_data_o=
ff;
>                                                  ^^^^^^^^^^^^^^^^^^^^^^
>
> Can this overflow when storing to reloc_desc->sym_off? The sym_off field
> is 'int' (signed 32-bit), but arena_data_off can be larger than INT_MAX
> for arenas approaching 4GB in size.
>
> For example, with a 4GB arena and one page of globals:
> - mmap_sz =3D 4GB =3D 0x100000000
> - data_alloc_sz =3D 4096
> - arena_data_off =3D 0xFFFFF000 =3D 4294963200
>
> This value (4294963200) exceeds INT_MAX (2147483647), so when stored in
> the signed int sym_off field, it becomes negative.
>
> Later in bpf_object__relocate_data(), this is used as:
>     insn[1].imm =3D insn[0].imm + relo->sym_off;
>
> With sym_off being negative due to overflow, this produces an incorrect
> offset for accessing arena globals.
>
> Should sym_off be changed to an unsigned type to handle large arena
> offsets correctly?

AI has good a point, valid offset with 4GB arena will overflow int...
But then ldimm64 instructions that allow direct access to arena have
insn[1].imm as s32, so they cannot even address more than 2GB? Can you
please double check this, maybe we actually treat insn[1].imm as u32
on the verifier side for this use case?

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/199013=
83089


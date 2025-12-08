Return-Path: <bpf+bounces-76317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A4CAE531
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 23:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B261303D6B3
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C12E22A6;
	Mon,  8 Dec 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="svSZ2Znp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539732DF15B
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765233023; cv=none; b=sHzK+zFJu0OBbR0e9yAmBWmcXE5/tPplfKXjdM+Kkl/tO77qXRgT4HOWE9wgkgfNm7G1ynFi/PMMfVkT40jT3qcWhvbJJ0NJCqv1GO/dx7jIaKzoa+BvWZf5K/O5Um9ng6ZZdpjGPO7XTLUmr7EJCw//VP/Ji/3AbTF0++1D8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765233023; c=relaxed/simple;
	bh=ocjYjWmWaxCJzmhmO4vt0e6YP0rdbfNJzCbnZyXkwLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJggLRK7KwupjBeMOYulNgiFwfMPdLqUhwCGIJXPvKJgLoneEzwb8+NCbVDWRBtzWbciYI7CJH+tmWMuHhBPbvS/8qFwnHYJzYt7x/5iEswSJh5lS3w9f0EaYhXzXUyNUfFo8X5B0vyxxe4PMfzyybjKlovXaiOdcICHdGwAcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=svSZ2Znp; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so4797737d50.3
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765233020; x=1765837820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K6AcyeU5pV3EWlmWTWkhsjb9k8uT1vtZHrd2dO18is=;
        b=svSZ2ZnpiqWmHWodOrWXq0JYhVEi5IG/nfdrTTgAWV6JpmNS4elT866zDwEKrALNms
         PzRmDiOn1OA7vyXEPV01vU7bjRH2Uzjm1ZfxZQEfAuCFEU7CRYZCgWFtMSC0910F19h9
         mmK1kicPG9z4Ir3T3rFJxaY8AvupuhTfEKoTzE8tBLy0mrKDav+N7ypwmNsbjJWarsMs
         DT3eWPB8t+N1RiXg+9Q4l3VdZ71+abItQ/m6ms65G1C3b6Z04ULxKptQKIsa4yOipPGC
         1vHhZD2fN+56Pk1nf3zMSGRZQkGQVmRKU7aqfMyY+nOZmW4zM0xME9xYqUIwEjYNR+Rn
         2AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765233020; x=1765837820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+K6AcyeU5pV3EWlmWTWkhsjb9k8uT1vtZHrd2dO18is=;
        b=aD6jfafSggC56zMqgsyxCeGZCPD1S3XJp4IlTa8TwOAxmgGFF/IMnhko4lnDLb9+q0
         5lfbxJ8UNOiGPCRVIOzJ5b/X47tK2rqF8njN5X5xsIAyGTaeTFmqyCnw8cgHsJ5VLPW1
         1flzsNLN8uGNQQh8c3Ov++RYoLZo8X5wmJoPv3fzhodx20/bNlaUT5VlGvNgSByV6Cfw
         6UeYeGkSOsg/veLEO4aPVUDIXqjG9nrW9NRPEA8Sy3WpgwaEqMAt9XArzh8w634jW0mz
         /rRgFsj2kIUnfrxkqZAH9XJRUJSwuQGt1Yh/mGL7xOi8FKXvfC1gIu1T392GRDPZe+I0
         EzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWLhyizdS1eoGfD5gkCGgwxIBGD+EyWou3Vv0h7bu4kwxYVgD5SYETkeLvdotBRWgyQcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Od7WTJpXWi8/MLjgr3OznNtgWtwtfuTDO0IsZkFZRK2XTX9P
	6Tu2ZUuoTA4sdxoyVhF3gnvlbADibH5zi1vCs4xLN7DrM93Pp9hQCAsFnTGO1RQQ2BckgzfB47n
	ZHxjT3+D1s9qn0w9zlUOeiWSqNKeQmeqPoQYtV0nlxA==
X-Gm-Gg: ASbGncssnumDCBI0I06jizzfUNJPsEmIxXCDitQ7BbBOoZOdoH5p6fvLgpSg1fvLDdx
	b3AY+6voPpQe1+z6PtGmfpT++L6iCSSatEJ1oyMeG9+rynrsV3IiJEy8/a/4W6koYNm+k08ynuI
	keSwA1K7UaRm0tVm9sXOcquUsJrdMFd/EOik5iBkKwIOCYUhxa6LHpEuqNubKHAOzG9EpMgiB4A
	js3Z4ao8+ETVmC6+Mx/Ip8eGvmIul54g94G74bDMo672aHIPgTdetQ8oaSSNAqjqpkQNyUECg==
X-Google-Smtp-Source: AGHT+IHVuMNWgDuiqgomV5ZtfwFKIsM8rRD5EOUD50cGvF6O3xnwOYf/ZA6SkvnpNqllyZdP5kbLg64xXRNKS+UbvPk=
X-Received: by 2002:a05:690e:1448:b0:644:6575:b4de with SMTP id
 956f58d0204a3-6446575c3f5mr637189d50.3.1765233020143; Mon, 08 Dec 2025
 14:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203162625.13152-4-emil@etsalapatis.com> <45513ae5c2cfe74c5d29d23e6c2eaec62b07e709138bc9167c5fea5ea6dde762@mail.kernel.org>
 <CAEf4BzYoD85yjR7-9RTwSMU6zJ3pMJAnUC1CeNy4Hy7c2es21w@mail.gmail.com>
In-Reply-To: <CAEf4BzYoD85yjR7-9RTwSMU6zJ3pMJAnUC1CeNy4Hy7c2es21w@mail.gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 8 Dec 2025 17:30:04 -0500
X-Gm-Features: AQt7F2qrGmWoe4qSab9MD6XGZDC7eEILFq_dtrPgonRWPea8ewt_53uenK9jQIw
Message-ID: <CABFh=a7khDBCvGK5h5oWt18bX=i4X4yX+PVg3ijiPYx9GSkvYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: move arena globals to the end of the arena
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 3, 2025 at 8:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 706e7481b..9642d697b 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> >
> > [ ... ]
> >
> > > @@ -2991,10 +2992,11 @@ static int init_arena_map_data(struct bpf_obj=
ect *obj, struct bpf_map *map,
> > >                              void *data, size_t data_sz)
> > >  {
> > >       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > > +     const size_t data_alloc_sz =3D roundup(data_sz, page_sz);
> > >       size_t mmap_sz;
> > >
> > >       mmap_sz =3D bpf_map_mmap_sz(map);
> > > -     if (roundup(data_sz, page_sz) > mmap_sz) {
> > > +     if (data_alloc_sz > mmap_sz) {
> > >               pr_warn("elf: sec '%s': declared ARENA map size (%zu) i=
s too small to hold global __arena variables of size %zu\n",
> > >                       sec_name, mmap_sz, data_sz);
> > >               return -E2BIG;
> > > @@ -3006,6 +3008,9 @@ static int init_arena_map_data(struct bpf_objec=
t *obj, struct bpf_map *map,
> > >       memcpy(obj->arena_data, data, data_sz);
> > >       obj->arena_data_sz =3D data_sz;
> > >
> > > +     /* place globals at the end of the arena */
> > > +     obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> > > +
> >
> > Here obj->arena_data_off is a __u32, but the calculation is done in
> > size_t (64-bit). For a 4GB arena (which the test verifier_arena_large.c
> > uses), mmap_sz is 4GB and the result can approach 4GB - PAGE_SIZE. This
> > fits in u32 correctly.
> >
> > > @@ -4663,7 +4668,7 @@ static int bpf_program__record_reloc(struct bpf=
_program *prog,
> > >               reloc_desc->type =3D RELO_DATA;
> > >               reloc_desc->insn_idx =3D insn_idx;
> > >               reloc_desc->map_idx =3D obj->arena_map_idx;
> > > -             reloc_desc->sym_off =3D sym->st_value;
> > > +             reloc_desc->sym_off =3D sym->st_value + obj->arena_data=
_off;
> >                                                  ^^^^^^^^^^^^^^^^^^^^^^
> >
> > Can this overflow when storing to reloc_desc->sym_off? The sym_off fiel=
d
> > is 'int' (signed 32-bit), but arena_data_off can be larger than INT_MAX
> > for arenas approaching 4GB in size.
> >
> > For example, with a 4GB arena and one page of globals:
> > - mmap_sz =3D 4GB =3D 0x100000000
> > - data_alloc_sz =3D 4096
> > - arena_data_off =3D 0xFFFFF000 =3D 4294963200
> >
> > This value (4294963200) exceeds INT_MAX (2147483647), so when stored in
> > the signed int sym_off field, it becomes negative.
> >
> > Later in bpf_object__relocate_data(), this is used as:
> >     insn[1].imm =3D insn[0].imm + relo->sym_off;
> >
> > With sym_off being negative due to overflow, this produces an incorrect
> > offset for accessing arena globals.
> >
> > Should sym_off be changed to an unsigned type to handle large arena
> > offsets correctly?
>
> AI has good a point, valid offset with 4GB arena will overflow int...
> But then ldimm64 instructions that allow direct access to arena have
> insn[1].imm as s32, so they cannot even address more than 2GB? Can you
> please double check this, maybe we actually treat insn[1].imm as u32
> on the verifier side for this use case?
>

I can confirm we treat insn[1].imm as a u32, but the following
relocation logic in
 bpf_object__relocate_data looks suspect:

                case RELO_DATA:
                        map =3D &obj->maps[relo->map_idx];
                        insn[1].imm =3D insn[0].imm + relo->sym_off;
                        if (obj->gen_loader) {

If sym_off is interpreted as a negative, then insn[1].imm should be
completely wrong and typecasting
back to u32 should do nothing. I added tests with both nonzero
insn[0].imm and st_value, and none
of them are failing which unless I"m missing something is honestly
kind of surprising.

I don't think sym_off should actually ever be negative. The st_value
from the ELF headers
should be always positive, and elf_find_func_offset_* also returns
only positive numbers.

Should we change sym_off in reloc_desc to be a u32? If anything that
is more accurate than having it
as an int.

For the rest of the feedback: Ack, will incorporate it into the next patch.



> >
> > [ ... ]
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/1990=
1383089


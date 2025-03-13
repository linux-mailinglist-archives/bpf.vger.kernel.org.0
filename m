Return-Path: <bpf+bounces-54002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AEAA60346
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39F519C5EEE
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44EF1F4C91;
	Thu, 13 Mar 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDcb9ZMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26FB1F03E5
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900333; cv=none; b=objiUrWeuQIOOrOWcgRFVedEcxd0B48bsd1GA93vbnqduvaRy5OKdVsjz65NO1XhGLgAC7Yax5+EauVjc4UbxG8OHtngXspQwpXVwKuDMlcB1Qs+0+VAh0MFS0CJ5durS5bRtoolQ43MtAjjQZS/AzhnmoeYM4fY5h2Tfh4CLLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900333; c=relaxed/simple;
	bh=/553K3o/HldKHtISj3z/khcnaoGIdhXxLJU3FyD/9jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz8mvJG/tU2yGl/oOLfCFXiHRQawJHNJ93zBTxoTbsDmpal5srhgemo47mJmVBY/fr0N7k1xCKeSBW96XIwwHVF/2ypTLUI2GZnwIOOAnzUzZh4P7rddS+kWsd1n2SCwv2Y6LyTKrFsbiUXwfEQ8ygOSjcknRwioAKsq8tC5sFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDcb9ZMo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so26961965ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741900330; x=1742505130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zbpt94Glc3BzZwbDH+/np1ydAQ+SxRKOdOyWqbLm1U=;
        b=kDcb9ZMoFwe87qCaRycBwCqZHAmOEJIUtdNCb70Fw8YzDb6fKHJC2gH1txcPk6ooV5
         kPslA+iTElfcvy3lIUtdcuXNIdTo8oMVExZmjvcULkUx0T4EVfNHFREKm/WO7Yvkaq+N
         0nraVwSDDEqBEQmhsNcwv4fuVh7CxzlJmY3LOLeLNbcjcq/gqpKx/ubBnnW0yVRKZlbK
         x/O80qY7wT6vaqozWFY/iYBmnBlP4S3pg6ny27ONcpUj6F55TSOYeAM3aFX1SiBM9WgW
         vAdzqKQfXMb1R0JIFi1j1orzBCbQ5cQWjmT65vARWHyMPG6BEYDlchaOdmOJY5fTgj4Y
         GazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900330; x=1742505130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zbpt94Glc3BzZwbDH+/np1ydAQ+SxRKOdOyWqbLm1U=;
        b=ZOuTeGtMMX6W4sE8Rerl5Lu20yufuiUwWKB5C7H90OnhwtJ+E0nS6kQgFTiTFKRuwf
         kaJ4ihlI77Vg+naUcSBBCvCzckxgespadhKWnQej3QC8WouWZGFgEwHWF+ZySpT4UWAU
         KKjGNyrX4Or3wVgbbUICBqqJoF4pj/lBvq9iI1OncMaXItNxQpOO1A45ccwZJrr0yWN+
         dgIPeenD8Z6CODkxV5g2t+cYw0t1OLwpZAFfF2AtZoVfRalLSrl9DbbWqzYycqB/WtUr
         sI6T2KD8Bkm5kby3I7cOpgXJJ9r2QG2Sgk0CnoA2vrKSxyK3NoijFo3eUA9bM+4PB7GK
         3m5w==
X-Forwarded-Encrypted: i=1; AJvYcCVou9NgO8hzXCTvEQbEr92/6v2qcspFdzrfW4ah865DaOgmp8faXZyaKy0W7IJwcwzBz2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQawbVbWTnzOX8aJVGv3/3cugsd4j1pmN97/C3psANGRKSnXx
	LO59CPj+ZU6JkqQCe6rC6DK0gN1IMeORjFLspaYJifu1xqaX8gHhiZRui+1W5+l5HLkXXZNSJu9
	yzZNwjSWURYrdfQQrh+rjtoLKlwk=
X-Gm-Gg: ASbGnctkusTvjY3fOWSRQJLyzAx6DHSZ+wy/vMNEdADLrrVUEzgZ7dOvrC3zrsD3fkF
	zvfwsVN/2amKMqAkx2gBhSGoie9vuCbF5dtwanAha+Gm0f27dM+gzkNZ/ex/D3WfMzesk1SQyqV
	a/9SCBHucXHACmXTk+VKfPXHUbvDgSegnDKEWMflqE1w==
X-Google-Smtp-Source: AGHT+IGzBj2RYiUKuwCgtLYjSqNUKzMZy9QfbAYChvyfKDK/9OBQtXp3KIilx8EYCkswFxytBkYtXhf0JlCNKlAi798=
X-Received: by 2002:a05:6a00:816:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-737223b9782mr13927b3a.14.1741900329716; Thu, 13 Mar 2025
 14:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307140120.1261890-1-hengqi.chen@gmail.com>
 <10239917-2cbe-434e-adc5-69c3f3e66e36@linux.dev> <CAEyhmHT+DZDjXixnWgCq028K7KZ84bWHY1+Kv9bjJAQW9vryHQ@mail.gmail.com>
 <CAEf4BzbAi-g-jyFoHdXHNfOT3DLTnKN1XioPhR=XYJnM7+_VOQ@mail.gmail.com>
 <CAEyhmHRobpifJ_h3q2ucnhunV_r2MLO4QE5sAMZKQmAMYaBzjw@mail.gmail.com> <Z9LsFNtXXBD0ydeO@krava>
In-Reply-To: <Z9LsFNtXXBD0ydeO@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Mar 2025 14:11:57 -0700
X-Gm-Features: AQ5f1Joopde-viJ1Ym1HRJKYgGeg2x664p7MwMWzb6jOKlvifPQ0-DOENPeBAqk
Message-ID: <CAEf4BzZm8bcMxFqZ1t3goSkuWw7BmULRNdYAsWk2UheF9OW9Hw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix uprobe offset calculation
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, deso@posteo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:30=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Mar 13, 2025 at 12:23:10PM +0800, Hengqi Chen wrote:
>
> SNIP
>
> > > > > >   tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
> > > > > >   1 file changed, 24 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > > > > > index 823f83ad819c..9b561c8d1eec 100644
> > > > > > --- a/tools/lib/bpf/elf.c
> > > > > > +++ b/tools/lib/bpf/elf.c
> > > > > > @@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_i=
ter *iter, int sh_type, struct elf_sym
> > > > > >    * for shared libs) into file offset, which is what kernel is=
 expecting
> > > > > >    * for uprobe/uretprobe attachment.
> > > > > >    * See Documentation/trace/uprobetracer.rst for more details.=
 This is done
> > > > > > - * by looking up symbol's containing section's header and usin=
g iter's virtual
> > > > > > - * address (sh_addr) and corresponding file offset (sh_offset)=
 to transform
> > > > > > + * by looking up symbol's containing program header and using =
its virtual
> > > > > > + * address (p_vaddr) and corresponding file offset (p_offset) =
to transform
> > > > > >    * sym.st_value (virtual address) into desired final file off=
set.
> > > > > >    */
> > > > > > -static unsigned long elf_sym_offset(struct elf_sym *sym)
> > > > > > +static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *=
sym)
> > > > > >   {
> > > > > > -     return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_o=
ffset;
> > > > > > +     size_t nhdrs, i;
> > > > > > +     GElf_Phdr phdr;
> > > > > > +
> > > > > > +     if (elf_getphdrnum(elf, &nhdrs))
> > > > > > +             return -1;
> > > > > > +
> > > > > > +     for (i =3D 0; i < nhdrs; i++) {
> > > > > > +             if (!gelf_getphdr(elf, (int)i, &phdr))
> > > > > > +                     continue;
> > > > > > +             if (phdr.p_type !=3D PT_LOAD || !(phdr.p_flags & =
PF_X))
> > > > > > +                     continue;
> > > > > > +             if (sym->sym.st_value >=3D phdr.p_vaddr &&
> > > > > > +                 sym->sym.st_value < (phdr.p_vaddr + phdr.p_me=
msz))
> > > > > > +                     return sym->sym.st_value - phdr.p_vaddr +=
 phdr.p_offset;
> > >
> > > Hengqi,
> > >
> > > Can you please provide an example where existing code doesn't work? I=
 think that
> > >
> > > sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset
> > >
> > > and
> > >
> > > sym->sym.st_value - phdr.p_vaddr + phdr.p_offset
> > >
> > >
> > > Should result in the same, and we don't need to search for a matching
> > > segment if we have an ELF symbol and its section. But maybe I'm
> > > mistaken, so can you please elaborate a bit?
> >
> > The binary ([0]) provided in the issue shows some counterexamples.
> > I could't find an authoritative documentation describing this though.
> > A modified version ([1]) of this patch could pass the CI now.
>
> yes, I tried that binary and it gives me different offsets
>
> IIUC the symbol seems to be from .eh_frame_hdr (odd?) while the new logic
> base it on offset of .text section.. I'm still not following that binary
> layout completely.. will try to check on that more later today
>

Yep, something is off with the way that this ELF file is linked.
Symbols information is just wrong.

In sections he have:

  [Nr] Name              Type            Address          Off    Size
 ES Flg Lk Inf Al
  [ 0]                   NULL            0000000000000000 000000
000000 00      0   0  0
  [ 1] .gnu.version      VERSYM          0000000000299b38 299b38
03774a 02   A  5   0  2
  [ 2] .gnu.version_r    VERNEED         00000000002d1284 2d1284
000340 00   A  6  12  4
  [ 3] .gnu.hash         GNU_HASH        00000000002d15c8 2d15c8
0c9538 00   A  5   0  8
  [ 4] .dynamic          DYNAMIC         000000000b29fb10 b29db10
000380 10  WA  6   0  8
  [ 5] .dynsym           DYNSYM          00000000d7b03070 b2b4070
299778 18   A  6   1  8
  [ 6] .dynstr           STRTAB          000000000039ab00 39ab00
17c8e7e 00   A  0   0  1
  [ 7] .rela.dyn         RELA            0000000001b63980 1b63980
513630 18   A  5   0  8
  [ 8] .rela.plt         RELA            0000000002076fb0 2076fb0
000288 18  AI  5  26  8
  [ 9] .rodata           PROGBITS        0000000002078000 2078000
a30306 00 AMS  0   0 4096
  [10] .gcc_except_table PROGBITS        0000000002aa8308 2aa8308
3cd368 00   A  0   0  4
  [11] protodesc_cold    PROGBITS        0000000002e75670 2e75670
007400 00   A  0   0 16
  [12] .stapsdt.base     PROGBITS        0000000002e7ca70 2e7ca70
000001 00   A  0   0  1
  [13] .eh_frame_hdr     PROGBITS        0000000002e7ca74 2e7ca74
0f35bc 00   A  0   0  4
  [14] .eh_frame         PROGBITS        0000000002f70030 2f70030
66f6a4 00   A  0   0  8
  [15] .text             PROGBITS        00000000035e0700 35df700
7a9de55 00  AX  0   0 64
  [16] .init             PROGBITS        000000000b07e558 b07d558
00001b 00  AX  0   0  4
  [17] .fini             PROGBITS        000000000b07e574 b07d574
00000d 00  AX  0   0  4
  ...


Symbol itself says:

Symbol table '.dynsym' contains 113573 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
   ...
109776: 00000000081658d0  4132 FUNC    GLOBAL DEFAULT   13
_ZN7cluster15topics_frontend13create_topicsE17fragmented_vectorINS_37custom=
_assignable_topic_configurationELm18446744073709551615EENSt3__16chrono10tim=
e_pointIN7seastar12lowres_clockENS5_8durationIxNS4_5ratioILl1ELl1000000000E=
EEEEEE
   ...

Note how the symbol points to section #13, which is .eh_frame_hdr. But
value (virtual address) 00000000081658d0 actually belongs to section
#15 (.text):


[15] .text             PROGBITS        00000000035e0700 35df700
7a9de55 00  AX  0   0 64

So symbol information has section index off by 2. And this seems to be
the case for lots of symbols, they all point to section #13.

Libbpf's logic is correct, as long as symbol information is correct.
If that index was 15, we'd calculate that 0x1000 additional offset.

So let's figure out why ELF is invalid instead of trying to "fix"
libbpf's logic, which is correct and much faster than linearly
searching through segments. Could it be that that binary was modified
post final linking to add custom sections before .text (like that
protodesc_cold)?


> jirka
>
> >
> >   [0]: https://github.com/libbpf/libbpf-rs/issues/1110#issuecomment-269=
9221802
> >   [1]: https://github.com/kernel-patches/bpf/pull/8647
> >
> > >
> > > > > > +     }
> > > > > > +
> > > > > > +     return -1;
> > > > > >   }
> > > > > >
> > > > > >   /* Find offset of function name in the provided ELF object. "=
binary_path" is
> > > > > > @@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const c=
har *binary_path, const char *name)
> > > > > >
> > > > > >                       if (ret > 0) {
> > > > > >                               /* handle multiple matches */
> > > > > > -                             if (elf_sym_offset(sym) =3D=3D re=
t) {
> > > > > > +                             if (elf_sym_offset(elf, sym) =3D=
=3D ret) {
> > > > > >                                       /* same offset, no proble=
m */
> > > > > >                                       continue;
> > > > > >                               } else if (last_bind !=3D STB_WEA=
K && cur_bind !=3D STB_WEAK) {
> > > > >
> > > > > [...]
> > > > >
> >


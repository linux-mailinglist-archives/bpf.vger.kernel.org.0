Return-Path: <bpf+bounces-59995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA4AD0DCB
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 16:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A3A16FCFA
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571941519AC;
	Sat,  7 Jun 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jULw+AWB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3C288DB
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749305250; cv=none; b=aVg/muNChfry5Yo9fT2KUMId6Ve+LqmgZypB6kGQ8XurYIFHbwyEGlAo25HaHpe8uXobuSFMFduTbIPDuuCZdrmNpjmGT8exK+EmISwanvGwVH37EHReFsfWuSHAqH48dbcZ6eMkYm9/2MXcXoZWjea8x8u40e8coYCsDhn08Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749305250; c=relaxed/simple;
	bh=0n7QfDWRLEzryVq4Xx5MPSRGoEIV9z9VwaNdN1kVdVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC00RlHzoAjIrHVQlqRkR0ViDsxhhWPBYJpGKICLIu1tBzSStyaN9S8RRGgCN2QwDszr2T7+BB+usnvdmBoTugbRqR+YWRsWjDJ1T8pkVFXLP+6k4tGT/nHqjKtjcb290FpFbKhoIOvm/aphltAx1xTr7gYaifmRFjbrzKYeA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jULw+AWB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a35c894313so2537904f8f.2
        for <bpf@vger.kernel.org>; Sat, 07 Jun 2025 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749305247; x=1749910047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE16podkkCw7gq6O5TkJCoDADd0e70RmH/D5N/vIh2A=;
        b=jULw+AWBfV4aQgKKRDc6ytlzuZRP4mYooIUxpwbyuDV432PVe3zFXKTX7GKcpav5it
         OcHPlIR/mAmACeg/j5nECe43xDvjb1hSL2SJlmujWSFJDAGorABIoOguVMXzkQ6qw0Xi
         nbgR6m+tzt+cmks8uc8TIJXEKDcpRV0bUdvVVywOwfcAcARO2/ln7GFAVekTc5X8fybq
         FbQUq3ZQGVApoGh5Mx6xOdWW8N0YlLct6OKab+l0dntQ6oYfDZAJUXUS5ChT8SqNgjEv
         TF9Tq+Gil7y9nZeQ7VyGbMGJNk06HpFToNW9THPSmLeIoaQ9oXf1Hr87CZCw0Ntk6Tn4
         b3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749305247; x=1749910047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE16podkkCw7gq6O5TkJCoDADd0e70RmH/D5N/vIh2A=;
        b=XpA0ZBeKPELKZr+1EV333XpquF3sPebonnJj/svatYmewvtuDVDERtqW71n0wpq5ww
         MnQa7yglSqQ8eeuQOT2U070yvCpPAAKKICmXbu0hXdrT4PnTC1pKmuVswdETcRn1uKZp
         bdkC4Zl7Ph4stRLoiU2CgaqymcHIBZnzIQlOp/UaUFyyHa+AwZW6Aa2yFgUo9M3f5IX8
         8xgCQBYde5e8JLcTn+0koYu73APsGBbrJZ8AQMrUftnO9WUu8ttGBfF4XjdmvVaw3kgn
         4NEfS7z6IydW4FAPo+QYph4wTDTNw/viBfklL5hBvIDweBBXicpC3d+n21Vu6JAgcWny
         uyww==
X-Forwarded-Encrypted: i=1; AJvYcCU8D9AUnEdZDoIGfZW67XkJd31yJgEp+NB6VNR/+yozWCGXkdPviSmSwp2H8cHUpKaiep0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyHd5GcmL35zVtbqq0ihlj4YVkJa22sJQ0cje08cnwtoebatg
	q6eTNxCrT/26Ep7YTxH8GkDaPEQf0Lr5mazqlZoOM8eAitxYYg7kDfRqWrvElJkcNP7u97Z/zUQ
	F45TxBfuTNK2rP1hq5j4lCC/5OalH+A4=
X-Gm-Gg: ASbGncsmjfzwvKNz6T3/Whu6UguetaP9S9+nLHZtyJdPIBrtulNPqhamdc11iZfKl7H
	aNTZe5xJn55WEA6HKRYuY+nl9RZtJV7wHia8gsmtIfmkhs1F/GoCRbT9kYKRVEKXN7xxGxKihZZ
	+znLfPnXdcu8ML1GQETYwmIyFCMHbtGRCmjmXelxk+7RMZ03EURceifzF9z2yOH7+rP+EUgYh2
X-Google-Smtp-Source: AGHT+IHMk+jlwYGIYim1ESiL1ya4af5oVVjBLRRQ1KMUoST3dND/LPQuHPJpeIBxPGIQgmRLsLHZqJuwbf07LkCrW+4=
X-Received: by 2002:a5d:64ca:0:b0:3a5:2848:2445 with SMTP id
 ffacd0b85a97d-3a531ab50f2mr6303888f8f.16.1749305246940; Sat, 07 Jun 2025
 07:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-3-isolodrai@meta.com>
 <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
 <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev> <CAADnVQJ-sxOEdzy7OktZrTUDxk7Rw7H3zCt_u+iM987zTTDksw@mail.gmail.com>
 <8c24eae8-a932-4c1d-87ec-c5f8ef8fdf79@linux.dev> <CAADnVQKwekQ61umAokC09OB+ao5T4E_yg_cLgzVEUtCtFwo=0Q@mail.gmail.com>
 <3e0d243a-f769-464c-ab58-49e94e52611d@linux.dev> <CAADnVQL8PWXLoHWoHJ4EZipP-vVi=1ZqEAx_UpkFyQq-haLiaA@mail.gmail.com>
In-Reply-To: <CAADnVQL8PWXLoHWoHJ4EZipP-vVi=1ZqEAx_UpkFyQq-haLiaA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 7 Jun 2025 07:07:15 -0700
X-Gm-Features: AX0GCFs8VnIB8sjBFisGFWz5dg8w6PGD7cxAC0SN3X0Geo1obE9kPLGY77KZJe8
Message-ID: <CAADnVQ+d-ZW3FW1DEaFFYifYLFQQH7h2w-FPi+baF02X0Tk4Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with
 CONST_PTR_TO_MAP null checks
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 4:38=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
> >
> > On 6/5/25 5:25 PM, Alexei Starovoitov wrote:
> > > On Thu, Jun 5, 2025 at 4:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> > >>
> > >> On 6/5/25 10:00 AM, Alexei Starovoitov wrote:
> > >>> On Thu, Jun 5, 2025 at 9:42=E2=80=AFAM Ihor Solodrai <ihor.solodrai=
@linux.dev> wrote:
> > >>>>
> > >>>> On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
> > >>>>> On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@m=
eta.com> wrote:
> > >>>>>>
> > >>>>>> [...]
> > >>>>>>
> > >>>>>> +SEC("socket")
> > >>>>>> +int map_ptr_is_never_null(void *ctx)
> > >>>>>> +{
> > >>>>>> +       struct bpf_map *maps[2] =3D { 0 };
> > >>>>>> +       struct bpf_map *map =3D NULL;
> > >>>>>> +       int __attribute__((aligned(8))) key =3D 0;
> > >>>>>
> > >>>>> aligned(8) makes any difference?
> > >>>>
> > >>>> Yes. If not aligned (explicitly or by accident), verification fail=
s
> > >>>> with "math between fp pointer and register with unbounded min valu=
e is
> > >>>> not allowed" at maps[key]. See the log below.
> > >>>
> > >>> It's not clear to me why "aligned" changes code gen,
> > >>> but let's not rely on it.
> > >>> Try 'unsigned int key' instead.
> > >>> Also note that &key part pessimizes the code.
> > >>> Do for (...; i < 2; i++) {u32 key =3D i; &key }
> > >>> instead.
> > >>
> > >> I've tried changing the test like this:
> > >>
> > >> @@ -144,12 +144,12 @@ int map_ptr_is_never_null(void *ctx)
> > >>    {
> > >>           struct bpf_map *maps[2] =3D { 0 };
> > >>           struct bpf_map *map =3D NULL;
> > >> -       int __attribute__((aligned(8))) key =3D 0;
> > >>
> > >> -       for (key =3D 0; key < 2; key++) {
> > >> +       for (int i =3D 0; i < 2; i++) {
> > >> +               __u32 key =3D i;
> > >>                   map =3D bpf_map_lookup_elem(&map_in_map, &key);
> > >>                   if (map)
> > >> -                       maps[key] =3D map;
> > >> +                       maps[i] =3D map;
> > >>                   else
> > >>                           return 0;
> > >>           }
> > >>
> > >> This version passes verification independent of the first patch bein=
g
> > >> applied, which kinda defeats the purpose of the test. Verifier log
> > >> below:
> > >>
> > >>       0: R1=3Dctx() R10=3Dfp0
> > >>       ; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c=
:143
> > >>       0: (b4) w1 =3D 0                        ; R1_w=3D0
> > >>       ; __u32 key =3D i; @ verifier_map_in_map.c:149
> > >>       1: (63) *(u32 *)(r10 -4) =3D r1
> > >>       mark_precise: frame0: last_idx 1 first_idx 0 subseq_idx -1
> > >>       mark_precise: frame0: regs=3Dr1 stack=3D before 0: (b4) w1 =3D=
 0
> > >>       2: R1_w=3D0 R10=3Dfp0 fp-8=3D0000????
> > >>       2: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> > >>       3: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
> > >>       ; map =3D bpf_map_lookup_elem(&map_in_map, &key); @
> > >> verifier_map_in_map.c:150
> > >>       4: (18) r1 =3D 0xff302cd6802e0a00       ;
> > >> R1_w=3Dmap_ptr(map=3Dmap_in_map,ks=3D4,vs=3D4)
> > >>       6: (85) call bpf_map_lookup_elem#1    ;
> > >> R0_w=3Dmap_value_or_null(id=3D1,map=3Dmap_in_map,ks=3D4,vs=3D4)
> > >>       ; if (map) @ verifier_map_in_map.c:151
> > >>       7: (15) if r0 =3D=3D 0x0 goto pc+7        ; R0_w=3Dmap_ptr(ks=
=3D4,vs=3D4)
> > >>       8: (b4) w1 =3D 1                        ; R1_w=3D1
> > >>       ; __u32 key =3D i; @ verifier_map_in_map.c:149
> > >>       9: (63) *(u32 *)(r10 -4) =3D r1         ; R1_w=3D1 R10=3Dfp0 f=
p-8=3Dmmmm????
> > >>       10: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
> > >>       11: (07) r2 +=3D -4                     ; R2_w=3Dfp-4
> > >>       ; map =3D bpf_map_lookup_elem(&map_in_map, &key); @
> > >> verifier_map_in_map.c:150
> > >>       12: (18) r1 =3D 0xff302cd6802e0a00      ;
> > >> R1_w=3Dmap_ptr(map=3Dmap_in_map,ks=3D4,vs=3D4)
> > >>       14: (85) call bpf_map_lookup_elem#1   ;
> > >> R0=3Dmap_value_or_null(id=3D2,map=3Dmap_in_map,ks=3D4,vs=3D4)
> > >>       ; } @ verifier_map_in_map.c:164
> > >>       15: (b4) w0 =3D 0                       ; R0_w=3D0
> > >>       16: (95) exit
> > >
> > > because the compiler removed 'if (!maps[0])' check?
> > > Make maps volatile then.
> >
> > Making maps and/or map volatile didn't help.
> >
> > >
> > > It's not clear to me what the point of the 'for' loop is.
> > > Just one bpf_map_lookup_elem() from map_in_map should do ?
> >
> > No. Using an array and loop was my attempt to put map_ptr on the
> > stack. But apparently this was not the reason it happened in the v1 of
> > the test.
> >
> > >
> > >>
> > >> If map[i] is changed back to map[key] like this:
> > >>
> > >>          for (int i =3D 0; i < 2; i++) {
> > >>                  __u32 key =3D i;
> > >>                  map =3D bpf_map_lookup_elem(&map_in_map, &key);
> > >>                  if (map)
> > >>                          maps[key] =3D map; /* change here */
> > >>                  else
> > >>                          return 0;
> > >>          }
> > >>
> > >> Verification fails with "invalid unbounded variable-offset write to
> > >> stack R2"
> > >
> > > as it should, because both the compiler and the verifier
> > > see that 'key' is unbounded in maps[key] access.
> > >
> > >>       __u32 __attribute__((aligned(8))) key =3D i;
> > >>
> > >> but that puts us back to square one.
> > >>
> > >> It appears that alignment becomes a problem if the variable is used =
as
> > >> array index and also it's address is passed to a helper.
> > >
> > > I bet this alignment "workaround" is fragile.
> > > A different version of clang or gcc-bpf will change layout.
> >
> > I agree, it's fragile.
> >
> > After I fought compiler/verifier for a while I gave up and wrote a
> > test in asm:
> >
> >      SEC("socket")
> >      __description("map_ptr is never null")
> >      __success
> >      __naked void map_ptr_is_never_null(void)
> >      {
> >         asm volatile ("                                 \
> >         r1 =3D 0;                                         \
> >         *(u32*)(r10 - 4) =3D r1;                          \
> >         r2 =3D r10;                                       \
> >         r2 +=3D -4;                                       \
> >         r1 =3D %[map_in_map] ll;                          \
> >         call %[bpf_map_lookup_elem];                    \
> >         if r0 !=3D 0 goto l0_%=3D;                          \
> >         exit;                                           \
> >      l0_%=3D:     *(u64 *)(r10 -16) =3D r0;                         \
> >         r1 =3D *(u64 *)(r10 -16);                         \
> >         if r1 =3D=3D 0 goto l1_%=3D;                          \
> >         exit;                                           \
> >      l1_%=3D:     r10 =3D 42;                                       \
> >         exit;                                           \
> >      "  :
> >         : __imm(bpf_map_lookup_elem),
> >           __imm_addr(map_in_map)
> >         : __clobber_all);
> >      }
> >
> > What must happen to reproduce the situation is: map_ptr gets on a
> > stack, and then loaded and compared to 0.
> >
> > It looks like I accidentally forced map_ptr on the stack by using
> > `key` both for map lookup and array access, which triggers those
> > alignment problems. Without that I wasn't able to figure out simple C
> > code that would produce bpf with map_ptr on the stack (besides the
> > other test, with rbs).
> >
> > I guess I should've written an asm test right away.
>
> Yeah. For this kind of sequence asm is the right answer.
> It's not clear to me why you want to spill/fill it.
> CONST_PTR_TO_MAP is already in is_spillable_regtype()
> before this patch.
> The test needs to validate that reg_not_null() is working.
> So just:
>
>         r1 =3D %[map_in_map] ll;
>         call %[bpf_map_lookup_elem];
>         if r0 =3D=3D 0 goto l0_%=3D;
>         exit;
> l0_%=3D: r10 =3D 42;
>        exit;
>
> would do the job without spill/fill.

braino. I meant two if r0 checks back to back.
Like:
         r1 =3D %[map_in_map] ll;
         call %[bpf_map_lookup_elem];
         if r0 =3D=3D 0 goto l0_%=3D;
         if r0 !=3D 0 goto l0_%=3D;
         r10 =3D 42;
l0_%=3D:   exit;

kinda obvious looking at asm that the verifier should be
smart to understand that the 2nd if is always taken.
But the smartness is only added in patch 1.

Another test is probably worth it too:
         r1 =3D %[map_in_map] ll;
         if r1 !=3D 0 goto l0_%=3D;
         r10 =3D 42;
l0_%=3D:   exit;


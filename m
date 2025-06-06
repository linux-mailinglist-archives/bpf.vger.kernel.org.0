Return-Path: <bpf+bounces-59978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6CAD0A73
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB90161BD7
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1B23F419;
	Fri,  6 Jun 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK2O27TB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A921214209
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253958; cv=none; b=em38S03n87cMFvk2bV0Wub2Bvd34eISttKZ/Tb6f4krgoW6+1V7uuIVZ4mAPSAUO+A+BZRRVWZgqBll1egYC7ghIs0pDrp2c+R9k8EKGAsZYNLY93gdTKrjEfgmBRbR+L3jCuq/6QP+PMHKr+dreaECu46agurCDn5TYMSJovrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253958; c=relaxed/simple;
	bh=jyDHx/iAeTGuDiccA+Vw7tqGVS7CpGqW6hUYQK2VVq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWBfwd1fhrcc56ags2m1V1oOq72DOXqUrjOUpEONgzsFXy+YhEu+W86ILmrkPnpveN+rtQ5U0k78w1qlvnDkbIzDFpWnUV0cQJqTSa7oa4cfzSwhK4t9GtqwEtYpqQSxCJle9haiVoZCgzs5yhxtzWBa19EHJeYM/qNTB38+QE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK2O27TB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a510432236so2033761f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253954; x=1749858754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVEzkzoi7Ed0SZwtnjKyf28OOviRstHfcsHx4kzu29o=;
        b=YK2O27TB3PxzCrLOBb0Zer/zBA9r8GAKtX0VK47WsEcHFFFaNJdy2tQ9Kh0bjSiM8/
         UUJiI6XAwURdhUZdzb47riaoHTQFolzRdOkBLkwzH+kWe+qeYhsO01n8aQIBWXT9qfkO
         ta6KvA3YfxHBee4Ak1im6XQSw+yUDlvwtchNr5Smkn58oNkbxqInpfCCWEn939VuYatU
         um2p4gATX/VRJc3FTEAUkDHShuugvjNN2subqxX1Cts1NeWrDLXPPhHH5M5MWaehXMe9
         5OIcHGAzl02Ra/xWEQkssrUDo5Uw1uH3b857lzfc4UwIEZO0+bCPHJvji0cuIc3dwfuF
         u4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253954; x=1749858754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVEzkzoi7Ed0SZwtnjKyf28OOviRstHfcsHx4kzu29o=;
        b=Q7/f4EnpfbsTqjqIscV5eTl6mpWsdmtkA47uaG5DBpPyLsV/6XBqx+jghOh4gCpl3P
         4TAEhSt7lvE3kHbXKNx3YTAsyauFl712W5MXE8BkABQQo0l044flElnSsla0LD10YJjI
         Hl99qmxgbSUj1i9EiVA1W6Qkrzy5Uei1Y4MYSbF2w+h6xWcs4BV8cHW7SET9wMZW1VTy
         06sUnf4oVhJFq9tJqFvi9Vp9TwnLBKM3pzfRNS4mwkdAmISREdpY0LmyutkibOx2vk1z
         BL6T8PJJVGLTQfC98yVDknvOWI2K9tZhUheRKAKxJWRmua7KGSnroo7gaosL4cY7E53q
         1o3g==
X-Forwarded-Encrypted: i=1; AJvYcCW+O2bf4cbzBroOJXociqHk0ae0HFacLYO+Q4ojKQpjxqOwKOgYOSln7dQnuWcsl9lp7e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NvcXv79ZXLH18WlY5RxDOt7c7Apr7gq5la0XuPYnu5tqv/J9
	WMRvBqIXkfepb3Zt1Fv/GU2Usu3j1XxhiArqZSYZwzTDVj0LnCLe+4lRSq3YZUgro0FmugpLZ26
	Svq60Dlce/MT6bU7FIFqEUblCaTnZjwo=
X-Gm-Gg: ASbGnctd+AU1ziWGohV1gJh1fBgV68Eg93R0P0BEwqEv/nsWt4JUtZcnKdms1Ec4EWp
	fQ2mPZivT22vDRlDvPyiaXvQtfDyifznLfZRhNagJoy6eQ9QX2mwnOTGuy4Frxo5NhYvGb9fdce
	WJaBhd3m/ZW8UfzAqiBlhUNvY+N6gHyIK+kQpjHDLUU0fPqAS5IsPZUBimWUV++A==
X-Google-Smtp-Source: AGHT+IHWO62ULyBBXg98kJl+GtjdET4VVsEa0XV3GFQwzOSxH5UisB/5npAWU05Chwq3wAKjtEHxWwlvkHuF/tytLeU=
X-Received: by 2002:a05:6000:2382:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3a531cdd5a0mr4323052f8f.43.1749253953995; Fri, 06 Jun 2025
 16:52:33 -0700 (PDT)
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
 <3e0d243a-f769-464c-ab58-49e94e52611d@linux.dev>
In-Reply-To: <3e0d243a-f769-464c-ab58-49e94e52611d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 16:52:22 -0700
X-Gm-Features: AX0GCFs4B8th059_nwowcya_U1mt2A2CGh-sibKt6rlO5mvyy6hPXyKM9jkUVCM
Message-ID: <CAADnVQL8PWXLoHWoHJ4EZipP-vVi=1ZqEAx_UpkFyQq-haLiaA@mail.gmail.com>
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

On Fri, Jun 6, 2025 at 4:38=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 6/5/25 5:25 PM, Alexei Starovoitov wrote:
> > On Thu, Jun 5, 2025 at 4:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >>
> >> On 6/5/25 10:00 AM, Alexei Starovoitov wrote:
> >>> On Thu, Jun 5, 2025 at 9:42=E2=80=AFAM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>>>
> >>>> On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
> >>>>> On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@met=
a.com> wrote:
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>> +SEC("socket")
> >>>>>> +int map_ptr_is_never_null(void *ctx)
> >>>>>> +{
> >>>>>> +       struct bpf_map *maps[2] =3D { 0 };
> >>>>>> +       struct bpf_map *map =3D NULL;
> >>>>>> +       int __attribute__((aligned(8))) key =3D 0;
> >>>>>
> >>>>> aligned(8) makes any difference?
> >>>>
> >>>> Yes. If not aligned (explicitly or by accident), verification fails
> >>>> with "math between fp pointer and register with unbounded min value =
is
> >>>> not allowed" at maps[key]. See the log below.
> >>>
> >>> It's not clear to me why "aligned" changes code gen,
> >>> but let's not rely on it.
> >>> Try 'unsigned int key' instead.
> >>> Also note that &key part pessimizes the code.
> >>> Do for (...; i < 2; i++) {u32 key =3D i; &key }
> >>> instead.
> >>
> >> I've tried changing the test like this:
> >>
> >> @@ -144,12 +144,12 @@ int map_ptr_is_never_null(void *ctx)
> >>    {
> >>           struct bpf_map *maps[2] =3D { 0 };
> >>           struct bpf_map *map =3D NULL;
> >> -       int __attribute__((aligned(8))) key =3D 0;
> >>
> >> -       for (key =3D 0; key < 2; key++) {
> >> +       for (int i =3D 0; i < 2; i++) {
> >> +               __u32 key =3D i;
> >>                   map =3D bpf_map_lookup_elem(&map_in_map, &key);
> >>                   if (map)
> >> -                       maps[key] =3D map;
> >> +                       maps[i] =3D map;
> >>                   else
> >>                           return 0;
> >>           }
> >>
> >> This version passes verification independent of the first patch being
> >> applied, which kinda defeats the purpose of the test. Verifier log
> >> below:
> >>
> >>       0: R1=3Dctx() R10=3Dfp0
> >>       ; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c:1=
43
> >>       0: (b4) w1 =3D 0                        ; R1_w=3D0
> >>       ; __u32 key =3D i; @ verifier_map_in_map.c:149
> >>       1: (63) *(u32 *)(r10 -4) =3D r1
> >>       mark_precise: frame0: last_idx 1 first_idx 0 subseq_idx -1
> >>       mark_precise: frame0: regs=3Dr1 stack=3D before 0: (b4) w1 =3D 0
> >>       2: R1_w=3D0 R10=3Dfp0 fp-8=3D0000????
> >>       2: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> >>       3: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
> >>       ; map =3D bpf_map_lookup_elem(&map_in_map, &key); @
> >> verifier_map_in_map.c:150
> >>       4: (18) r1 =3D 0xff302cd6802e0a00       ;
> >> R1_w=3Dmap_ptr(map=3Dmap_in_map,ks=3D4,vs=3D4)
> >>       6: (85) call bpf_map_lookup_elem#1    ;
> >> R0_w=3Dmap_value_or_null(id=3D1,map=3Dmap_in_map,ks=3D4,vs=3D4)
> >>       ; if (map) @ verifier_map_in_map.c:151
> >>       7: (15) if r0 =3D=3D 0x0 goto pc+7        ; R0_w=3Dmap_ptr(ks=3D=
4,vs=3D4)
> >>       8: (b4) w1 =3D 1                        ; R1_w=3D1
> >>       ; __u32 key =3D i; @ verifier_map_in_map.c:149
> >>       9: (63) *(u32 *)(r10 -4) =3D r1         ; R1_w=3D1 R10=3Dfp0 fp-=
8=3Dmmmm????
> >>       10: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
> >>       11: (07) r2 +=3D -4                     ; R2_w=3Dfp-4
> >>       ; map =3D bpf_map_lookup_elem(&map_in_map, &key); @
> >> verifier_map_in_map.c:150
> >>       12: (18) r1 =3D 0xff302cd6802e0a00      ;
> >> R1_w=3Dmap_ptr(map=3Dmap_in_map,ks=3D4,vs=3D4)
> >>       14: (85) call bpf_map_lookup_elem#1   ;
> >> R0=3Dmap_value_or_null(id=3D2,map=3Dmap_in_map,ks=3D4,vs=3D4)
> >>       ; } @ verifier_map_in_map.c:164
> >>       15: (b4) w0 =3D 0                       ; R0_w=3D0
> >>       16: (95) exit
> >
> > because the compiler removed 'if (!maps[0])' check?
> > Make maps volatile then.
>
> Making maps and/or map volatile didn't help.
>
> >
> > It's not clear to me what the point of the 'for' loop is.
> > Just one bpf_map_lookup_elem() from map_in_map should do ?
>
> No. Using an array and loop was my attempt to put map_ptr on the
> stack. But apparently this was not the reason it happened in the v1 of
> the test.
>
> >
> >>
> >> If map[i] is changed back to map[key] like this:
> >>
> >>          for (int i =3D 0; i < 2; i++) {
> >>                  __u32 key =3D i;
> >>                  map =3D bpf_map_lookup_elem(&map_in_map, &key);
> >>                  if (map)
> >>                          maps[key] =3D map; /* change here */
> >>                  else
> >>                          return 0;
> >>          }
> >>
> >> Verification fails with "invalid unbounded variable-offset write to
> >> stack R2"
> >
> > as it should, because both the compiler and the verifier
> > see that 'key' is unbounded in maps[key] access.
> >
> >>       __u32 __attribute__((aligned(8))) key =3D i;
> >>
> >> but that puts us back to square one.
> >>
> >> It appears that alignment becomes a problem if the variable is used as
> >> array index and also it's address is passed to a helper.
> >
> > I bet this alignment "workaround" is fragile.
> > A different version of clang or gcc-bpf will change layout.
>
> I agree, it's fragile.
>
> After I fought compiler/verifier for a while I gave up and wrote a
> test in asm:
>
>      SEC("socket")
>      __description("map_ptr is never null")
>      __success
>      __naked void map_ptr_is_never_null(void)
>      {
>         asm volatile ("                                 \
>         r1 =3D 0;                                         \
>         *(u32*)(r10 - 4) =3D r1;                          \
>         r2 =3D r10;                                       \
>         r2 +=3D -4;                                       \
>         r1 =3D %[map_in_map] ll;                          \
>         call %[bpf_map_lookup_elem];                    \
>         if r0 !=3D 0 goto l0_%=3D;                          \
>         exit;                                           \
>      l0_%=3D:     *(u64 *)(r10 -16) =3D r0;                         \
>         r1 =3D *(u64 *)(r10 -16);                         \
>         if r1 =3D=3D 0 goto l1_%=3D;                          \
>         exit;                                           \
>      l1_%=3D:     r10 =3D 42;                                       \
>         exit;                                           \
>      "  :
>         : __imm(bpf_map_lookup_elem),
>           __imm_addr(map_in_map)
>         : __clobber_all);
>      }
>
> What must happen to reproduce the situation is: map_ptr gets on a
> stack, and then loaded and compared to 0.
>
> It looks like I accidentally forced map_ptr on the stack by using
> `key` both for map lookup and array access, which triggers those
> alignment problems. Without that I wasn't able to figure out simple C
> code that would produce bpf with map_ptr on the stack (besides the
> other test, with rbs).
>
> I guess I should've written an asm test right away.

Yeah. For this kind of sequence asm is the right answer.
It's not clear to me why you want to spill/fill it.
CONST_PTR_TO_MAP is already in is_spillable_regtype()
before this patch.
The test needs to validate that reg_not_null() is working.
So just:

        r1 =3D %[map_in_map] ll;
        call %[bpf_map_lookup_elem];
        if r0 =3D=3D 0 goto l0_%=3D;
        exit;
l0_%=3D: r10 =3D 42;
       exit;

would do the job without spill/fill.


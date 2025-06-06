Return-Path: <bpf+bounces-59819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560AACFA67
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22B3189C351
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C58F6F;
	Fri,  6 Jun 2025 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3TAJJ9C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95997257D
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749169527; cv=none; b=FUUccIETW7gu7OVn9Jt43Bq8PwqV8pug6SE8K+twRezRStVF28ondmqLvl0oKakVp9LQ94RSl5oAgrVXHBvdGtIqbCznQsLYXHggC9WLM9qeFRV1Se+RpK9PrtXokR/2WiAF6K2+VLiDKRDtsFrjnf5sWnhdWfWGWKGRxBOAtW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749169527; c=relaxed/simple;
	bh=9mAyCRAcqD1GPYXyqd0WWOg/ubdjIZU3VLoS0hmdgpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5xvgPCzHIAwYKW20XmaMKz8gWlRJxlcm1zQGqS2do36MXQHAq7n+SoWm8M0v5ThaBMC1DOL6Q1/U/JMRm5HSXWsNgOf2tjHlnWZyKg3jEkmaCDt06aMJDIT1lqM/AZQMhHLSMeBQqxiOVvF36CEi54Z61TjSsxdLOelkqw2VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3TAJJ9C; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so896506f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749169524; x=1749774324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNMUcjYQND81qEXCXFKdSC3IUPpnM84qRlvGyOo4tV4=;
        b=j3TAJJ9CnS2Qtld/Pw4U6GlaJasUs1ycWO17ADxDjHnaVy8awGzkyJOO97EBvsyypo
         UQ+3lB3QQlBnAyesWxYk8ljauvLRyTwGZv3qNIbGDs/K0TznkgYOnnjDArTHfWrevNWb
         PfCa5eq6B8973yTWT2mB4H7r9lFFBXc4qWHceBTHJva5WtP5Q+Sk+xU+4Xp1KmzIcmUl
         t/ww7Fw4Fw47pEIhm0EImQ7sWrPMRJr3NCI/bVKS1RUBJ7GHs9yxJKqU3bUM1WaajAMA
         JVtEuJvoiG2sTNl461JW8alwlH+LWXv+edG2qd32Lds4S0UHi8wZWgo4tZF/RyFwa+kK
         +x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749169524; x=1749774324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNMUcjYQND81qEXCXFKdSC3IUPpnM84qRlvGyOo4tV4=;
        b=uTLnh8JCgynT7Ok2+JJn1KUJAT6zHLy7w6Z4U9lCnsqIZ7c91vTZ1UZTCKGGq+JysY
         aaJwddEay1wuTcc4JM2i0boV717zyKFB7/HfCZ90hp53fJNssMtHKe0SnUbwzVO+i0Pp
         Vw7tUcChcgSr8VPH0Rs5JJT9fFDn3ogeDFjCTnwN8ioE4yCaYEqFCWcISFfsg39B94O2
         8GlJ7P0EcXRtkXGVHIrUX8bYpFejlQz3UcWN58/sWyf4Wmxatmfpe+zD7t5M8VxSu2Gi
         l/GDYWSB4K0tRcubJWzNascx/bXtw7qRBmZkRTxni3jGM4TXgWmgj8IMxI6g310KBnkK
         S3oA==
X-Forwarded-Encrypted: i=1; AJvYcCWcs+XEEBJqF3GcLYOefkHVTbdFzEqc66mLwt5CdHXrrP/7icnR5nKKZMJRc/gdPvgGPHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGZMVdYX8iJoz9LND9l7ZlZVO15S767va/zGM6/ZshIObLijH
	znRL5qEZ20xXwFg0mNSndXVy2QjxUpzKOB9TMhT0+Heq9R+20O9Zzwtm1x1F61aNJOEQDt6GxvF
	6fEM/XQR+8qkRLE3d6UFRsTy3FCLXrP0=
X-Gm-Gg: ASbGncubmFMVGLzuDxWqJ9xLY7plVUs8R2qia0/d2Df7/G2WwaCsk2H97UA+am+cflK
	80ZNaKVnmXMzetNcTb0NV25f4mByzOfP87RCFAoCGC00TaPpVMhJonw7/BHYeR1tcDrt2VIozqx
	/4+7LsY9oNKHFGIKCpdBqLcvst1EzXkyYgBS/XJMGJr47VMAaWscMDW/fdj7vZdR3fJ9/SgH2rl
	QK8tj5TDfk=
X-Google-Smtp-Source: AGHT+IHiGvI/rgfApaQnRRgR35iYFA9Ub0DCyUV5qtoSZ3iwVwij/n99uj62pY1c3y6XgvndPYO2LGeywbrxxzXFwzA=
X-Received: by 2002:a05:6000:25c5:b0:3a4:df80:7284 with SMTP id
 ffacd0b85a97d-3a53188a553mr1139903f8f.1.1749169523549; Thu, 05 Jun 2025
 17:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-3-isolodrai@meta.com>
 <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
 <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev> <CAADnVQJ-sxOEdzy7OktZrTUDxk7Rw7H3zCt_u+iM987zTTDksw@mail.gmail.com>
 <8c24eae8-a932-4c1d-87ec-c5f8ef8fdf79@linux.dev>
In-Reply-To: <8c24eae8-a932-4c1d-87ec-c5f8ef8fdf79@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 17:25:12 -0700
X-Gm-Features: AX0GCFuFqh8iwucXUzLyy7QA_odZhrFqbis3XVSNZ-95OYkNSniANQXncXrI6lc
Message-ID: <CAADnVQKwekQ61umAokC09OB+ao5T4E_yg_cLgzVEUtCtFwo=0Q@mail.gmail.com>
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

On Thu, Jun 5, 2025 at 4:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 6/5/25 10:00 AM, Alexei Starovoitov wrote:
> > On Thu, Jun 5, 2025 at 9:42=E2=80=AFAM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >>
> >> On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
> >>> On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.=
com> wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>> +SEC("socket")
> >>>> +int map_ptr_is_never_null(void *ctx)
> >>>> +{
> >>>> +       struct bpf_map *maps[2] =3D { 0 };
> >>>> +       struct bpf_map *map =3D NULL;
> >>>> +       int __attribute__((aligned(8))) key =3D 0;
> >>>
> >>> aligned(8) makes any difference?
> >>
> >> Yes. If not aligned (explicitly or by accident), verification fails
> >> with "math between fp pointer and register with unbounded min value is
> >> not allowed" at maps[key]. See the log below.
> >
> > It's not clear to me why "aligned" changes code gen,
> > but let's not rely on it.
> > Try 'unsigned int key' instead.
> > Also note that &key part pessimizes the code.
> > Do for (...; i < 2; i++) {u32 key =3D i; &key }
> > instead.
>
> I've tried changing the test like this:
>
> @@ -144,12 +144,12 @@ int map_ptr_is_never_null(void *ctx)
>   {
>          struct bpf_map *maps[2] =3D { 0 };
>          struct bpf_map *map =3D NULL;
> -       int __attribute__((aligned(8))) key =3D 0;
>
> -       for (key =3D 0; key < 2; key++) {
> +       for (int i =3D 0; i < 2; i++) {
> +               __u32 key =3D i;
>                  map =3D bpf_map_lookup_elem(&map_in_map, &key);
>                  if (map)
> -                       maps[key] =3D map;
> +                       maps[i] =3D map;
>                  else
>                          return 0;
>          }
>
> This version passes verification independent of the first patch being
> applied, which kinda defeats the purpose of the test. Verifier log
> below:
>
>      0: R1=3Dctx() R10=3Dfp0
>      ; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c:143
>      0: (b4) w1 =3D 0                        ; R1_w=3D0
>      ; __u32 key =3D i; @ verifier_map_in_map.c:149
>      1: (63) *(u32 *)(r10 -4) =3D r1
>      mark_precise: frame0: last_idx 1 first_idx 0 subseq_idx -1
>      mark_precise: frame0: regs=3Dr1 stack=3D before 0: (b4) w1 =3D 0
>      2: R1_w=3D0 R10=3Dfp0 fp-8=3D0000????
>      2: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>      3: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
>      ; map =3D bpf_map_lookup_elem(&map_in_map, &key); @
> verifier_map_in_map.c:150
>      4: (18) r1 =3D 0xff302cd6802e0a00       ;
> R1_w=3Dmap_ptr(map=3Dmap_in_map,ks=3D4,vs=3D4)
>      6: (85) call bpf_map_lookup_elem#1    ;
> R0_w=3Dmap_value_or_null(id=3D1,map=3Dmap_in_map,ks=3D4,vs=3D4)
>      ; if (map) @ verifier_map_in_map.c:151
>      7: (15) if r0 =3D=3D 0x0 goto pc+7        ; R0_w=3Dmap_ptr(ks=3D4,vs=
=3D4)
>      8: (b4) w1 =3D 1                        ; R1_w=3D1
>      ; __u32 key =3D i; @ verifier_map_in_map.c:149
>      9: (63) *(u32 *)(r10 -4) =3D r1         ; R1_w=3D1 R10=3Dfp0 fp-8=3D=
mmmm????
>      10: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
>      11: (07) r2 +=3D -4                     ; R2_w=3Dfp-4
>      ; map =3D bpf_map_lookup_elem(&map_in_map, &key); @
> verifier_map_in_map.c:150
>      12: (18) r1 =3D 0xff302cd6802e0a00      ;
> R1_w=3Dmap_ptr(map=3Dmap_in_map,ks=3D4,vs=3D4)
>      14: (85) call bpf_map_lookup_elem#1   ;
> R0=3Dmap_value_or_null(id=3D2,map=3Dmap_in_map,ks=3D4,vs=3D4)
>      ; } @ verifier_map_in_map.c:164
>      15: (b4) w0 =3D 0                       ; R0_w=3D0
>      16: (95) exit

because the compiler removed 'if (!maps[0])' check?
Make maps volatile then.

It's not clear to me what the point of the 'for' loop is.
Just one bpf_map_lookup_elem() from map_in_map should do ?

>
> If map[i] is changed back to map[key] like this:
>
>         for (int i =3D 0; i < 2; i++) {
>                 __u32 key =3D i;
>                 map =3D bpf_map_lookup_elem(&map_in_map, &key);
>                 if (map)
>                         maps[key] =3D map; /* change here */
>                 else
>                         return 0;
>         }
>
> Verification fails with "invalid unbounded variable-offset write to
> stack R2"

as it should, because both the compiler and the verifier
see that 'key' is unbounded in maps[key] access.

>      __u32 __attribute__((aligned(8))) key =3D i;
>
> but that puts us back to square one.
>
> It appears that alignment becomes a problem if the variable is used as
> array index and also it's address is passed to a helper.

I bet this alignment "workaround" is fragile.
A different version of clang or gcc-bpf will change layout.


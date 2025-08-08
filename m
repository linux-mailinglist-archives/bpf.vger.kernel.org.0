Return-Path: <bpf+bounces-65273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F7B1ECF3
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4187211FC
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC4287249;
	Fri,  8 Aug 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iij2zVcj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E827BF84
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670249; cv=none; b=sdbq4j4ZxF850wgO7nH7zwdoXFBWVAyrc8Ofs7L/rDyntIUsQ6o+dUvd8z3D4zZpt4UWWXrfTpjfWqbwWPpr8IuviAi07OBcAYq1mKMDDQHUsZU7yRARYBmXHPlGS0ssFGYhzcp2TaVyDzhGEOgRZe7Y/erNo99LjS3w6Y556/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670249; c=relaxed/simple;
	bh=utdAtVh4cqpubhLi1me/CbOV7zWsXSYbVZupNtlfOV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxhqbBo4RmsPtOlHWcPmqEdfqnuWDZcbBxwAZPlHTWPW5F0tk1COuT4gi3nKgkzJ7TqSJG60iKnFqmzFFIUbVMM6KK8IRGwhQgFeqH2zNKnslVsO39mx3FdFTmexFdKhgIbG0SgKxAJaZJoDFkYlsNwLWao4UQuGPyjFXhSNNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iij2zVcj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b783d851e6so2016116f8f.0
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754670246; x=1755275046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SC5+jpdrbTYx6QUdRe2wK1Al+V42f/u+Y7n2gDWYFw=;
        b=Iij2zVcjKRaxxSKuw7K1KZDMbXqS5pKmFXIy3kGRskZwFNPdFO57Js86UtqCRnnqYW
         eb2mV308K+VDJkWB1WMmEChtmgtyjGGub/qK0q7YlZnRBUZ9EeTunrCap6oKg1iSUYxT
         hrkr//GNXlCAiMK2yhjhwVgnbdVTmh2AtIblTpEua4uE83aeQ/z4+IQgn7zBVCuVl7KV
         s3KW8csv1GzbYj/6D6SuOzslZu4EV5M6xbVxkJVGpMw4T8TLJaeizm9rPEKM8AQKHUzh
         KZ+v8jiGf1Jpmj/hyeOiu4UWmfzOutY2qcRJeSICgcyReR8XmjgDpObjELfearlaZ8oa
         Hglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670246; x=1755275046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SC5+jpdrbTYx6QUdRe2wK1Al+V42f/u+Y7n2gDWYFw=;
        b=nlBtYzf/X+eiug5+2H1Ew6p1aFqe6CdZwPllQf0l5MuQPHcDwcH2kFq0fCr5On05pb
         OHn2NCRQC8behjZYZRN9xhNGhEno5/lcjT6Enxlnbrzr3TqrZcWme3FuRoLdLu4lkWRN
         SDd4t9AiIIDinNjtcIK8l3H53udvCoQHxtF7URsv0pJmujE5lagLg6qMEzvuawPPhz+J
         vchBPTO0SWdMhFNEqmSQBGkM3AjKpenXykF4FHFO6Hibff7nPvlPnEbj1gKXnrVrju9n
         qnHGynyf+HrATCkyaOzS6rN0RO4HPfj/N+GNhmGj6cY26zUsR/DHHvxUVe+fyu/DQFtX
         6qyA==
X-Gm-Message-State: AOJu0YwRgoo11sWf+lkZLvuhW+jw6Uvg9z4vwOqg1T/jyFmQx9mYi5PJ
	TJHoyg0pKSMJY8BBTxmCeu54ENoD/Sax7tDMdXl/wPOaO9hBVnoU3SjQq8zJGHFI9QMAH7XV/xI
	FH+NEM7mNEMwgHiNFrICfMCUhfefnhbU=
X-Gm-Gg: ASbGncvDxd4G16aLSnCRl2vKcnCgofVDApBYRJT9Km9gltYQWgaWqwnejJKM5nb+rEG
	r2QJ/B218X/AIcE2DArQV9vETrqAZ927a6gnZEKZ84lvzePH9+leMPHOYjH37KC/zvFoHPMYwcJ
	KVGvAeav3Bwhr1bElXgV8VXl6eV/KZ1ISBCwxvAFpqfaZol4r/Ka0RKUT5nTKtjEIQrMv2DVIj+
	ZpmEuna0mAPDofMRmSxiZPj8ALhqRN/cBu2
X-Google-Smtp-Source: AGHT+IGLHVZW3GTuPxxSOcEkDLkksfn1scjIUv/te+zYM1TY6PyAxdxjwT4YcFPrmdQPj97xXOOOnQQnlSGCG0LhQWs=
X-Received: by 2002:a05:6000:310f:b0:3b7:925b:571c with SMTP id
 ffacd0b85a97d-3b900b83ca6mr2841130f8f.57.1754670245765; Fri, 08 Aug 2025
 09:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805163017.17015-1-leon.hwang@linux.dev> <20250805163017.17015-2-leon.hwang@linux.dev>
 <CAADnVQ+Mkmy+9WnepShLsQtMWceFUpfsV-Tw=dMaXP-B15R2yQ@mail.gmail.com> <DBX6F51OAZSO.3OKUPR14AGTSI@linux.dev>
In-Reply-To: <DBX6F51OAZSO.3OKUPR14AGTSI@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Aug 2025 09:23:54 -0700
X-Gm-Features: Ac12FXzbLgXEJakkNx1wImjgfgN40pm388DHdYd8fpY1ejhUkKa1wfIa8NYfcsk
Message-ID: <CAADnVQK7N2HpHsbNgfot02zF0yak4F=gqcWw1cJqB7kRyK9yMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:11=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On Fri Aug 8, 2025 at 1:20 AM +08, Alexei Starovoitov wrote:
> > On Tue, Aug 5, 2025 at 9:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
> >> updating values for specified CPU or for all CPUs with a single value.
> >>
> >> This enhancement enables:
> >>
> >> * Efficient update of all CPUs using a single value when cpu =3D=3D (u=
32)~0.
> >> * Targeted update or lookup for a specified CPU otherwise.
> >>
> >> The flag is passed via:
> >>
> >> * map_flags in bpf_percpu_array_update() along with embedded cpu field=
.
> >> * elem_flags in generic_map_update_batch() along with embedded cpu fie=
ld.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf.h            |  3 +-
> >>  include/uapi/linux/bpf.h       |  6 +++
> >>  kernel/bpf/arraymap.c          | 54 ++++++++++++++++++------
> >>  kernel/bpf/syscall.c           | 77 +++++++++++++++++++++------------=
-
> >>  tools/include/uapi/linux/bpf.h |  6 +++
> >>  5 files changed, 103 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index cc700925b802f..c17c45f797ed9 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -2691,7 +2691,8 @@ int map_set_for_each_callback_args(struct bpf_ve=
rifier_env *env,
> >>                                    struct bpf_func_state *callee);
> >>
> >>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)=
;
> >> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value=
);
> >> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value=
,
> >> +                         u64 flags);
> >>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *valu=
e,
> >>                            u64 flags);
> >>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *val=
ue,
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 233de8677382e..67bc35e4d6a8d 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -1372,6 +1372,12 @@ enum {
> >>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exis=
t */
> >>         BPF_EXIST       =3D 2, /* update existing element */
> >>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update *=
/
> >> +       BPF_F_CPU       =3D 8, /* map_update for percpu_array */
> >
> > only percpu_array?!
> > Aren't you doing it for percpu_hash too?
> >
>
> Only percpu_array in this patchset.
>
> I have no need to do it for percpu_hash.

You're missing the point. If we're adding the flag it should
work for all per-cpu maps. Both array and hash.

Same issue as with your other patch with common_attr.
We're not adding a feature that works for 1 out 10
commands/map types/whatever and doesn't work for the rest.
Flags/features have to be generic and consistent.


Return-Path: <bpf+bounces-16932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BEC807A79
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63FB1C21040
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1470971;
	Wed,  6 Dec 2023 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNmzWNF5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1A39A
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 13:32:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b397793aaso1723855e9.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898331; x=1702503131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6AbGgQZH8wrF9jXjitIsJ4mROhPkJd5M9HqjlKnvwo=;
        b=TNmzWNF5XRMB4eBlJJm2qPzUUPtNpMXaZPpl5fR0gDUj/uxBLtfB1FigP/636Yz5qk
         ENyocuo4y4Iis8yIsBjS2GwGtqQQ6AIZKYgHdWQ1SCZyWW8BNCMkyiGdAa+eCGHT5f+i
         dHF/Y4Oid1+i8IT86nAPgPhmztNIkDa4+Dk2kzTSVkisvmj2/xXG28ns10ISJToPaU6f
         ArmlyAEkcZeun+RZw8woWbp7sim8l18cz7/tqj+aHvOxilScnOONm0DRC8bnlCo/sJwg
         8IzehXJGxrU3eewDGtyO8kuzYUE8lH2LXo+sc8TnJdYqai1onzIiXx/PXWTJA/qGnWj3
         7YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898331; x=1702503131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6AbGgQZH8wrF9jXjitIsJ4mROhPkJd5M9HqjlKnvwo=;
        b=s5B8AtyD+kIXSkwh8Zzkg7aNGPDeI5fAVC8ob45aWIHTZHYsgkl1ibWqKynF7iyMuF
         4eLyOvvw0mu0n6OdgyPT0XSiMvUDwNmc5mQf7uR421ZRewDTMP5TjaAsswPXmkxnlJsO
         Uwk7enPvgsNHrlBKMDniI6ogt5W8Otb9ZeXnA4/hUFlvNwLQDvu0jDDjX+CWP/6IdXBz
         R90GFjYmdOLyYypxEVTUMrunNKkzmC8cynOhlzLgyuTE9yjXT/cfUMeHWVAmLDo7thc+
         bSjW+zlEMwW2wkmsSA7mMbDLSL3xlTny8QZDNXjP1+QvTBwxLJul4sYBq52VNtGqOxwz
         V3DQ==
X-Gm-Message-State: AOJu0YzckWwVdoa9wiks0uiXHgQNU8j4N6hWdmvq5F6A3gAOfBcFVT6t
	X8noc5bw2ycsHkpWG4KTDmy0AimRVEGSjbxik6+ygMBk
X-Google-Smtp-Source: AGHT+IE9WzTRcJGrfZkrv5Rv0Yrwo2fzdpwATV/1Sz9OSztsQmHUT0g+GY4WdlqtLLpzUBQ2gIP9OZwtY98cC+vsLIc=
X-Received: by 2002:a05:600c:4995:b0:407:73fc:6818 with SMTP id
 h21-20020a05600c499500b0040773fc6818mr1857767wmp.2.1701898330786; Wed, 06 Dec
 2023 13:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201190654.1233153-1-song@kernel.org> <20231201190654.1233153-6-song@kernel.org>
 <CAADnVQ+_XZMVegPSN_xmA6C9Tx9UTQ0J-q=N6pv6RzbkVwBCEg@mail.gmail.com> <CAPhsuW7LYiytwCq8rpM9xC98AO8YCJ2Siy4JKoQJx7=LwjDb3Q@mail.gmail.com>
In-Reply-To: <CAPhsuW7LYiytwCq8rpM9xC98AO8YCJ2Siy4JKoQJx7=LwjDb3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Dec 2023 13:31:59 -0800
Message-ID: <CAADnVQJrXHc1Gav4x4U1vNDUJgJahw5a8FzHSjAONgg3tgUK1A@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 5/7] bpf: Add arch_bpf_trampoline_size()
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@meta.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Wed, Dec 6, 2023 at 11:34=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 01, 2023 at 11:06:52AM -0800, Song Liu wrote:
> > > +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 fla=
gs,
> > > +                          struct bpf_tramp_links *tlinks, void *func=
_addr)
> > > +{
> > > +     struct bpf_tramp_image im;
> > > +     void *image;
> > > +     int ret;
> > > +
> > > +     /* Allocate a temporary buffer for __arch_prepare_bpf_trampolin=
e().
> > > +      * This will NOT cause fragmentation in direct map, as we do no=
t
> > > +      * call set_memory_*() on this buffer.
> > > +      */
> > > +     image =3D bpf_jit_alloc_exec(PAGE_SIZE);
> > > +     if (!image)
> > > +             return -ENOMEM;
> > > +
> > > +     ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_=
SIZE, m, flags,
> > > +                                         tlinks, func_addr);
> > > +     bpf_jit_free_exec(image);
> > > +     return ret;
> > > +}
> >
> > There is no need to allocate an executable page just to compute the siz=
e, right?
> > Instead of bpf_jit_alloc_exec() it should work with alloc_page() ?
>
> We can use kvmalloc in patch 7. But we need bpf_jit_alloc_exec(). The rea=
son is
> __arch_prepare_bpf_trampoline() assumes "image" falls in certain memory r=
anges.
> If we use kvmalloc here, we may fail those checks, for example is_simm32(=
) in
> emit_patch().

Ahh. Makes sense. Please add a comment then.


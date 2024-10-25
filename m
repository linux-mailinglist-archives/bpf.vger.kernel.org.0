Return-Path: <bpf+bounces-43177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6E9B0A4A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E430B1C22AE3
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70C02038A5;
	Fri, 25 Oct 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5BTdIko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581931FDFA8
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874995; cv=none; b=g1mVNGDdP2kneiqchX0LBUfoXWzTIrYRcTdHHVT6koltbd2wt2sS9mOUkmS0EoZdo/ZPSz07/eCKCXiDCV6JzWU9xA4D5mru99xAB39wUxT/v8qkwNTeglzvwLPHIuUwx6j9OFlhmUVaMONCNStXaSTA2KRkPLNNZ94q0/YWu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874995; c=relaxed/simple;
	bh=+fTlkyS4M707tvoILCuL8AfdzyuBgOLmGZXqJiFy0qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qErdYLO/kXzzJJTWKrOy/fyO/EGd9ITA4n/1xF0UHpl6JtnfDxkGUUFY0qkI0p9N76vlZDUHh5RdkuWjtIRhUVC/1A15xZ13usGjP7LKNEkKklCLAC9CHOefPWgTqiQA0DXiOZif81cN4soPS9pd5C7sbLmUq1n8zJqNF43HDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5BTdIko; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d462c91a9so1527397f8f.2
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729874992; x=1730479792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XHKxo9g6HXhd1xdPrsAmF5Hl1QDh8U3ZxWwhuEBBEg=;
        b=S5BTdIkoSshLnVPG4tNIkOl0RcMy05dufVOMP1fW3XIxeilhZGj5+rOkyxpxgfae+T
         2L/pVJ/H/kQSY5bHDKc43MjI8ZgtjfBKi10NwMcjfQSXJqW4GzV6QVb1RyqZ2R9Oy/5H
         iWxUbe2ahMPcAHBnGHF0kPTJUFEhbL7dQRki3GQ68vOYkwq0UlePtXsvhwoZOVQEpXgu
         TrOdw+bkdNiCRunURWW1NgIxI9cN182JQqG/mAOUnSvvBnPwKXmmp8+L9PO+gZ83M9bC
         X2beC8RNBgSPechpKz00UIZucQ+jJHQfjw8tMw6RcRnKegF76Q4zxa92ah4Dz6yNCrfg
         9jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874992; x=1730479792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XHKxo9g6HXhd1xdPrsAmF5Hl1QDh8U3ZxWwhuEBBEg=;
        b=sZdLZgrwZ+55zGNutu0di+sCQHTvuZiMhfyUgF6dYwE1Vs4o0S6S/oLkjR5LcXdAht
         XpSltiV3rH3mCqYy/dQ2e2SNFE0aiwknQFetHtzjflk3Y9pUsRlc1AEfo6rMRAy3xt7d
         2MIKsTbeP543IKmuFzXhj1W10kWsIijBCrzAoyHgcs9fq1gUo1PBROK89+998aHycOIn
         A8fGjpmYmRnwCMUm5BcSUbmElbTqVjFjLUDpPPd158nwGkGXfzd0ieDtUykP+blK+oOA
         0Gdpr/PulEixCuAAcJjShMQEkFnMXRyd7huG5MhVxRq9WYA/JzQ1nwEfQqssDSAGfMm9
         9hnA==
X-Forwarded-Encrypted: i=1; AJvYcCXyUvgTMLOvVrjIL5kNFyF0ZEjlnOVHvBd1ITCyMMlLzmMy8SOUjJnGaAhEBEfxUXEHsGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzra1++e3ZX5ou2/RTXfxAHQlW7CDQdBgdLRi6WUXnB8f+7/JGf
	LWvM92kXsRIR4IIt6Ea/RIbnDK/58em5WWSIPN05o5mid32jBYWyYgZxIK86gDrFvx1aIS3l8X3
	Joxvi0P9SsfISUz/aO++BHxhSfBgmvfk4
X-Google-Smtp-Source: AGHT+IGlPQkNr0lfK9VE/B6WDNEMPVFuP9zdEmbvfWRP15eWMQwKUefdwOl38rg5IdOnO2+R24dZ6ZCVt28tTz4700Y=
X-Received: by 2002:a5d:4d50:0:b0:371:8319:4dcc with SMTP id
 ffacd0b85a97d-380610e6b79mr69780f8f.2.1729874991521; Fri, 25 Oct 2024
 09:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com> <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com> <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
 <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com>
 <f07ae723-2773-4dae-88c9-2d26903182fc@oracle.com> <CAADnVQLmSKATXzi+++hGpk0i-UiOKk8qt9N2CGBkznCRVr=qcQ@mail.gmail.com>
 <4ce7da07-20f7-4684-b60b-4704405fa703@oracle.com>
In-Reply-To: <4ce7da07-20f7-4684-b60b-4704405fa703@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Oct 2024 09:49:40 -0700
Message-ID: <CAADnVQKFjK8BnZ-rYzXKv-Zdw=HBJRoJ7jo5PN+0P6+qpJOxNg@mail.gmail.com>
Subject: Re: Questions about the state of some BTF features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/10/2024 17:19, Alexei Starovoitov wrote:
> > On Fri, Oct 25, 2024 at 9:15=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 25/10/2024 17:09, Alexei Starovoitov wrote:
> >>> On Thu, Oct 24, 2024 at 4:26=E2=80=AFPM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>>
> >>>>>
> >>>>> The good news is that already happens, provided you have the update=
d
> >>>>> pahole to handle distilled base generation. After building selftest=
s I see
> >>>>>
> >>>>> $ objdump -h bpf_testmod.ko |grep BTF
> >>>>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  000=
02c50
> >>>>>  2**0
> >>>>>  50 .BTF          000036f4  0000000000000000  0000000000000000  000=
6e048
> >>>>>  2**0
> >>>>>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  000=
7173c
> >>>>>  2**0
> >>>>>
> >>>>
> >>>> Indeed, after updating to the latest pahole master now I get
> >>>> .BTF.base, very nice.
> >>>
> >>> I pulled the latest pahole, rebuilt everything,
> >>> but still cannot get it to generate BTF.base.
> >>>
> >>> Any special trick needed?
> >>
> >> Hmm, should just work for bpf_testmod.ko as long as "pahole
> >> --supported_btf_features" reports "distilled_base" among the set of
> >> features. scripts/Makefile.btf should add that feature if KBUILD_EXTMO=
D
> >> is set, as it should be in the case of building bpf_testmod.ko. I'll
> >> double-check at my end with latest bpf-next, but it was working
> >> yesterday for me.
> >
> > There must be something else necessary:
> >
> > pahole -J -j --btf_features=3Dencode_force,var,float,enum64,decl_tag,ty=
pe_tag,optimized_func,consistent_func,decl_tag_kfuncs
> > --lang_exclude=3Drust --btf_features=3Ddistilled_base --btf_base vmlinu=
x
> > .../bpf/bpf_testmod/bpf_testmod.ko; .../resolve_btfids -b vmlinux
> > .../selftests/bpf/bpf_testmod/bpf_testmod.ko;
> >
> > objdump -h .../testing/selftests/bpf/bpf_testmod/bpf_testmod.ko|grep BT=
F
> >   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00001d9=
4  2**0
> >  50 .BTF          00002ea7  0000000000000000  0000000000000000  00062e3=
0  2**0
> >
>
> Not sure what's going on for you here to be honest. I just tried pulling
> latest bpf-next and dwarves master branch, rebuilding pahole and
> selftests. I see .BTF.base sections for each .ko in selftests/bpf.
> Can you provide the output of
>
> pahole --supported_btf_features
>
> ? If it contains distilled_base things _should_ be working. The only
> other reason I can think of that you might not get .BTF.base sections is
> if dwarves was built against a local libbpf (rather than the git
> submodule)

That was it.
I did 'git pull' in pahole instead of 'git pull --recurse-submodules'.

Thanks for the tips. Now I see .BTF.base section.


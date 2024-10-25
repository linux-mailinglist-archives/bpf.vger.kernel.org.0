Return-Path: <bpf+bounces-43178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A507A9B0A51
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1850A283545
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8181E00BF;
	Fri, 25 Oct 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB41lGSk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13816F099
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875121; cv=none; b=bUD7+kf1eKdCJfma/v6OV7s5y2uf/s7E0ouHgKeZR3IJ4A5NhpHK6GchPxQhrfz2osGrXO0ZqNpb9K5wKVHO0xUWP7dKN5hvcWx6qL1ol0aXH2+UElJ3HqDI+ZPgMJ+AfCELCTCuI3bIPSO/bMpzew4uqeaol5+HIOfEa1zz0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875121; c=relaxed/simple;
	bh=ITWe3XV/AjBuVnt+Dz2mRAqeesbym5H5tzFkxrJHCY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egJ0NLIrjw6DtunM9owhzdnuQYpaMzXU7rr5lBHZ4WVAt67otHj6J0ozchm6eFiZRNwn15L9OYsowY1Vf2S0VI/93ZY7ywB6av23AKL4raKh0wt/cGtIRvGZsWTTQqjsrwFjeLuFxyDXOT+7FbwrFaTyuNfcwS+bhT9mLuWSKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB41lGSk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso1751445f8f.3
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729875117; x=1730479917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+inEdC/yFvX1eEWyeepmpqvYboulJhaG+cfkd6BP0o8=;
        b=lB41lGSki7HgtMAXpkbBUX2oR4t/a4RkCjkQw3JyujQeTZYBa5m+wxXBqWOflgNrpy
         swRxlIjMiXe4c1rnjqcS8ZNe9YB71mY91IKaPZwLAaLO9I/psK+alCK7e/yDE6xIrVe2
         8Ay0SMXQ7T+Mz8dKWzmFxtUueMjJrSlmYnF4UpN9ecDssoXNBkufruuGvfUpcbZIxN+u
         KNSPGQVcfc/w7cFfSpLd28zBBrlB4So8VqLxBq/6GmYvqTYFhzlZUhAdIfs4Htw2uJLG
         hyrOFFuhTx2YFELg2ikW7QhTYgItjAZO69eYCTzdFh68E+IxiW+31rVEcZgBfzSympaj
         +Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875117; x=1730479917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+inEdC/yFvX1eEWyeepmpqvYboulJhaG+cfkd6BP0o8=;
        b=XioKPLhVO/BGeWn4b1HgQReuE8ukE58X7mkP45C4TNFJCuUlRIOaoreaUvcj+8CXsu
         fmkE+3YlpRRK2gq2zNO7qU39t2XZpQHJa2dMDbDfP+4yz23pGBW1gFs2qq5+LpIyGDpO
         qmaSxK95xGOnbVHZy2vJ4pIpsiTSYu84lcsw2ewCFjdyGUjqFKYpQjopwLfNjfGYIIS2
         0nD0xYgKGM3zpeJpoVAP06+1DT/CWt5tyJBkwm5rvzOjaw7NbsE2nbKB+97e70JFnWgR
         C1SQfJvQRekUwUkd+bcjgrM6j8UzLHYd+kfJEj43CVt8oWeuV9/aKvmJuGb1EXC3ycv2
         /kJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM5ZQPFlfc+skkMFkF3juIVK8blHAT49pfTw9lIhqp/98Y+1wmCM1VKZA/82aKoGqj6tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCRb0VXRkjdoFzcz6frKm8TNHNZWg9HrxhdWTXPQTqSCA9/lB
	Zkl4uC7jnhFPJb12quKSDPf99i9ky8fNasreUPwvN0598y3yuJ2PcNkr2+4fZ1z4iu4ZZ8IDTNP
	OCNkFh5M6decBQ5X3docGTAXN4bU=
X-Google-Smtp-Source: AGHT+IHd/J+mJy72z1VX7lT5uW4CT8AqWrmAfYNcuafxPFGS7FBGZMB/fllnKZOWXi5uXaLmT6ACpjQ4g0k8nl0lBS8=
X-Received: by 2002:adf:e0d2:0:b0:37d:493c:f7b8 with SMTP id
 ffacd0b85a97d-380610f245dmr71136f8f.2.1729875117026; Fri, 25 Oct 2024
 09:51:57 -0700 (PDT)
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
 <4ce7da07-20f7-4684-b60b-4704405fa703@oracle.com> <CAADnVQKFjK8BnZ-rYzXKv-Zdw=HBJRoJ7jo5PN+0P6+qpJOxNg@mail.gmail.com>
In-Reply-To: <CAADnVQKFjK8BnZ-rYzXKv-Zdw=HBJRoJ7jo5PN+0P6+qpJOxNg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Oct 2024 09:51:46 -0700
Message-ID: <CAADnVQKS-j2O7nCqmmiXF1-gJnZHb5-TY70kHZqHGxFUO7FSog@mail.gmail.com>
Subject: Re: Questions about the state of some BTF features
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 25, 2024 at 9:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > On 25/10/2024 17:19, Alexei Starovoitov wrote:
> > > On Fri, Oct 25, 2024 at 9:15=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> > >>
> > >> On 25/10/2024 17:09, Alexei Starovoitov wrote:
> > >>> On Thu, Oct 24, 2024 at 4:26=E2=80=AFPM Andrii Nakryiko
> > >>> <andrii.nakryiko@gmail.com> wrote:
> > >>>>
> > >>>>>
> > >>>>> The good news is that already happens, provided you have the upda=
ted
> > >>>>> pahole to handle distilled base generation. After building selfte=
sts I see
> > >>>>>
> > >>>>> $ objdump -h bpf_testmod.ko |grep BTF
> > >>>>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  0=
0002c50
> > >>>>>  2**0
> > >>>>>  50 .BTF          000036f4  0000000000000000  0000000000000000  0=
006e048
> > >>>>>  2**0
> > >>>>>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  0=
007173c
> > >>>>>  2**0
> > >>>>>
> > >>>>
> > >>>> Indeed, after updating to the latest pahole master now I get
> > >>>> .BTF.base, very nice.
> > >>>
> > >>> I pulled the latest pahole, rebuilt everything,
> > >>> but still cannot get it to generate BTF.base.
> > >>>
> > >>> Any special trick needed?
> > >>
> > >> Hmm, should just work for bpf_testmod.ko as long as "pahole
> > >> --supported_btf_features" reports "distilled_base" among the set of
> > >> features. scripts/Makefile.btf should add that feature if KBUILD_EXT=
MOD
> > >> is set, as it should be in the case of building bpf_testmod.ko. I'll
> > >> double-check at my end with latest bpf-next, but it was working
> > >> yesterday for me.
> > >
> > > There must be something else necessary:
> > >
> > > pahole -J -j --btf_features=3Dencode_force,var,float,enum64,decl_tag,=
type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> > > --lang_exclude=3Drust --btf_features=3Ddistilled_base --btf_base vmli=
nux
> > > .../bpf/bpf_testmod/bpf_testmod.ko; .../resolve_btfids -b vmlinux
> > > .../selftests/bpf/bpf_testmod/bpf_testmod.ko;
> > >
> > > objdump -h .../testing/selftests/bpf/bpf_testmod/bpf_testmod.ko|grep =
BTF
> > >   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00001=
d94  2**0
> > >  50 .BTF          00002ea7  0000000000000000  0000000000000000  00062=
e30  2**0
> > >
> >
> > Not sure what's going on for you here to be honest. I just tried pullin=
g
> > latest bpf-next and dwarves master branch, rebuilding pahole and
> > selftests. I see .BTF.base sections for each .ko in selftests/bpf.
> > Can you provide the output of
> >
> > pahole --supported_btf_features
> >
> > ? If it contains distilled_base things _should_ be working. The only
> > other reason I can think of that you might not get .BTF.base sections i=
s
> > if dwarves was built against a local libbpf (rather than the git
> > submodule)
>
> That was it.
> I did 'git pull' in pahole instead of 'git pull --recurse-submodules'.
>
> Thanks for the tips. Now I see .BTF.base section.

Forgot to add that even in this broken configuration:
before:
$ pahole --supported_btf_features
encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_f=
unc,decl_tag_kfuncs,reproducible_build,distilled_base,global_var
after:
$ pahole --supported_btf_features
encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_f=
unc,decl_tag_kfuncs,reproducible_build,distilled_base,global_var

No difference :(
Both claim that distilled_base is working, but it didn't.
Before had older libbpf submodule.
Maybe it should print libbpf version or something ?


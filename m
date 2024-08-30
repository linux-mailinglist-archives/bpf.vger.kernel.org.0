Return-Path: <bpf+bounces-38621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA1966CE9
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2751C215A8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFEB184524;
	Fri, 30 Aug 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlUAYdzq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AC17994F;
	Fri, 30 Aug 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060671; cv=none; b=sY7/JZEse++oVOQLqXAUZWNwFpko2gc+sCbpYldFqPmU0FHkaZJWWHvWAkSjAXzikQ/SU6vqcS736xhRYuj5c4QkeauCjaGJAuJo6/Vus/PHqYBlWAhpSAMshCnqR5ojW4OHf2xaHCiHRyG0qWnEiiSZ9JIHN6eMMzKkpOWEdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060671; c=relaxed/simple;
	bh=buC2bX10dVigUodWAc/hFTlQ3kGNNW+PY/64C2JkWXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjwRBVwy8wV+LdqrfWtVQJNvsKW99vhC1B7tAVBqiSq+LwI7TkY6/1DhAlU0eRUqizley/DgtBXN+yNmMMbMhNdF6qhGQDJUSfFqbSnvCoTDFeQp/qJgjsb7klyz49dzKv3gpDPIkGCVRw7wsJKPes7SvyCYWQZeenHay5hAdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlUAYdzq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d873bec4f5so772902a91.0;
        Fri, 30 Aug 2024 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725060669; x=1725665469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XioJO72UljpzKfSHrpe4mcBdCSEF9itASLzl0Nz1k8=;
        b=QlUAYdzqAMKFeElrZbsEbOnveVaQsf+W6dINj+ipeLEOgj78aG8xprr8cjZSeihIXI
         M0C0Xfrb8SHdJwNFNByfa/dhy3G//+0hkRpA9VBQgnD41DMftEpf8N0yvngiNlEB5sSJ
         PcafvCLyi5PepWuNQa+350TL/C9JobTK8bHwjoF3B01uhHhaMWodgsG62EAOPDU3mMLj
         xWWDN6XvbxjZh8QtJ7zIPmMECUMbOZPPOjKy9dwoSYF+WbYp/RNTwLAhmOM3mD/92W8L
         7JoRIfhbSK4FlWLACeS77iOqIW6Xj3BwGsHZy4BvuattPTBely4/T1bU4myxn3yM/pOQ
         3ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725060669; x=1725665469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XioJO72UljpzKfSHrpe4mcBdCSEF9itASLzl0Nz1k8=;
        b=Rw0eJ0rmWpdvGgPPxouXhtC7EOaYP3zKUfN7eS7njqqll/CWInUKJ9r62YTprl0Mqi
         XmJcA58bHBcN3CwZj8fzTWAfoK7TiNR9wKG3wzhz/yYijwQ2CVN0BuuUXdewa3QDrR4q
         uSoAkYo4LcEFT7tnPF5BHjQL8QEWJu46lwOtOp7rdcRuV6XOlBEIIe5KsD4C1qSOYjWO
         +lOZ3tSbowZNmfMq9gTXig8GsDNo9RFdptmj8F3Y0GmmtKE3vqvhXLg0qzbiV8XHIuqU
         QIQABBAF1Yetj8ZqiVnUnfa3oH46PzTyTIddR9bfIYnYL05OPdeF42xrgBWT5zt8eqOy
         OiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrH2ZzNlmW33K4ymHxkaY7o31CZGeqX8LJZWyhD+dHZ+P30lfPTV8QmhlmlmNVREQNN4sIzIZ6rw==@vger.kernel.org, AJvYcCW8O5ZrSdsMHPW0mA/iTBYXIcjCZzvzAxNQsh6B6rTW1tMI6oQXJQ2IRai0O3j2pTE0vMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygnh4u+grXFHypOkVKv3EHPSBPXgDTi87Y/tPJ+vSEYqk9fniw
	mc/EdIkHQyM6BO+fQRujFjzZuC66TYT5TSOoIOeJnWh+BkIg/WLHjuQ2Ay6xTXWOt7QECvh4AD9
	Tvz4Fclq8QpgXOKz6HCnKyuIiVhk=
X-Google-Smtp-Source: AGHT+IGKlGSq17ZI523gxTiktaVK99fofwosVVDcvj8tMPJVT6l3MVFlHyZAdUky//Ag5PL2JLIEyDSG4EL4AZ9IDi4=
X-Received: by 2002:a17:90a:e008:b0:2d8:89ac:c3ee with SMTP id
 98e67ed59e1d1-2d889ad1038mr2130503a91.43.1725060668913; Fri, 30 Aug 2024
 16:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com> <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1> <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
 <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>
In-Reply-To: <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 16:30:56 -0700
Message-ID: <CAEf4BzbykuVKzXa1z+6icECPTTh2bU4JFezDmA+4-S_izAUhsA@mail.gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole changes
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@meta.com>, 
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 3:34=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 30/08/2024 23:20, Andrii Nakryiko wrote:
> > On Fri, Aug 30, 2024 at 1:49=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >>
> >> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
> >>> On Fri, Aug 30, 2024 at 6:19=E2=80=AFAM Arnaldo Carvalho de Melo <acm=
e@kernel.org> wrote:
> >>>> On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
> >>>>> Arnaldo: apologies but I think we'll either need to back out the
> >>>>> distilled stuff for 1.28 or have a new libbpf resync that captures =
the
> >>>>> fixes for endian issues once they land. Let me know what works best=
 for
> >>>>> you. Thanks!
> >>>>
> >>>> It was useful, we got it tested more widely and caught this one.
> >>>>
> >>>> Andrii, what do you think? Can we get a 1.5.1 with this soon so that=
 we
> >>>> do a resying in pahole and then release 1.28?
> >>>
> >>> Did you mean 1.4.6? We haven't released v1.5 just yet.
> >>>
> >>> But yes, I'm going to cut a new set of bugfix releases to libbpf
> >>> anyways, there is one more skeleton-related fix I have to backport.
> >>>
> >>> So I'll try to review, land, and backport the fix ASAP.
> >>
> >> Well, Alan sent patches updating libbpf to 1.5.0, so I misunderstood, =
I
> >> think he meant what is to become 1.5.0, so even better, I think its ju=
st
> >> a matter of updating the submodule sha:
> >>
> >> =E2=AC=A2[acme@toolbox pahole]$ git show b6def578aa4a631f870568e13bfd6=
47312718e7f
> >> commit b6def578aa4a631f870568e13bfd647312718e7f
> >> Author: Alan Maguire <alan.maguire@oracle.com>
> >> Date:   Mon Jul 29 12:13:16 2024 +0100
> >>
> >>     pahole: Sync with libbpf-1.5
> >>
> >>     This will pull in BTF support for distilled base BTF.
> >>
> >>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>     Cc: Alexei Starovoitov <ast@kernel.org>
> >>     Cc: Andrii Nakryiko <andrii@kernel.org>
> >>     Cc: Eduard Zingerman <eddyz87@gmail.com>
> >>     Cc: Jiri Olsa <jolsa@kernel.org>
> >>     Cc: bpf@vger.kernel.org
> >>     Cc: dwarves@vger.kernel.org
> >>     Link: https://lore.kernel.org/r/20240729111317.140816-2-alan.magui=
re@oracle.com
> >>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>
> >> diff --git a/lib/bpf b/lib/bpf
> >> index 6597330c45d18538..686f600bca59e107 160000
> >> --- a/lib/bpf
> >> +++ b/lib/bpf
> >> @@ -1 +1 @@
> >> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
> >> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> >> =E2=AC=A2[acme@toolbox pahole]$
> >>
> >> Right?
> >
> > Yes, and I'm doing another Github sync today.
> >
> > Separate question, I think pahole supports the shared library version
> > of libbpf, as an option, is that right? How do you guys handle missing
> > APIs for distilled BTF in such a case?
> >
>
> Good question - at present the distill-related code is conditionally
> compiled if LIBBPF_MAJOR_VERSION >=3D1 and LIBBF_MINOR_VERSION >=3D 5; so=
 if
> an older shared library libbpf+headers is used, the btf_feature is
> simply ignored as if we didn't know about it. See [1] for the relevant
> code in btf_encoder.c. This problem doesn't arise if we're using the
> synced libbpf.

Is it possible to compile against newer libbpf headers, but run with
older shared library?

BTW, I've just synced the latest libbpf sources to Github ([0]), feel
free to pull the latest submodule reference.

  [0] https://github.com/libbpf/libbpf/pull/848

>
> There might be a better way to handle this, but I think that's enough to
> ensure we avoid compilation failures at least.
>
> [1]
> https://github.com/acmel/dwarves/blob/fd14dc67cb6aaead553074afb4a1ddad102=
09892/btf_encoder.c#L1766
>
> >>
> >> - Arnaldo


Return-Path: <bpf+bounces-21460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD9C84D727
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A481F22F87
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29226DDBE;
	Thu,  8 Feb 2024 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1oPjsE6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21448D502
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352003; cv=none; b=G/MahEpTwQ49+9gJ4ZNj5cvm7L0g0oXVdprwnzyqYCe3Np0ebN3+mTpPxukjiz12UpP9aBYm3i8Wzj4+i61svEChz49/2+eJ2b/6pPsTAgd0XrwTclJvTJ5BTU8CMaXRTxmPz0k1koyP7K9y8s+ieCAl+/0up/9Hjd+9hbL/thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352003; c=relaxed/simple;
	bh=DPJrLE6LcxR6uF7057WKxmEZsT+Ro/2KjpAlXYHGzqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuokvGF5csiYC3ldn5zbi0uhZ9b56jU0zwcDcZ5YPdzi2q0O/aEJ3upN3MwnXnNut5JfKADvmgbnLH8dYflhzom1aSpDjMXBeLdaR8SdtXbkgKUCa241LzjQKYcANr2dEFVM9Vm7opedtMWFJT+S5tCW8adiIxjkEntfOZ3GbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1oPjsE6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e06bc288d2so732041b3a.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707352001; x=1707956801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpod15BCjrW/ToAgnjy+pNLDi+yXlPZAXCLa9OXebvQ=;
        b=I1oPjsE6zINaXxEkpS8SXtz9FyOHPrhrGgBGBc0LRVrHA33GdYoMJlQAu8UGZjoNfB
         ewGIeDVrNV7XlIJ4M4zUvGSgpvKgZL56hE1LBC9N4nphFHJ96d0KK699TYxN4x6Psp6k
         CQ6aGNtowmEgwfYzIASMEwrp8hRjeNFSQNsIdi9yiEpC3BGF0JYFlUZt1w8MHl67yF9H
         7gkK9+dKeRyXdRHsDtqubIQv66mtQaLQnnICuEiOHZdU3JbO5u3DvdJmDAJ8GJNZGZHr
         JperxvmH8oQgNu8tVN1ZiNFNaQlUHEucZJCOqT5kxpT5y+xoqsmya4P1lG1k01d5qkAv
         fiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707352001; x=1707956801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpod15BCjrW/ToAgnjy+pNLDi+yXlPZAXCLa9OXebvQ=;
        b=QNBVHKC7kBTzHjKC7bWmw6T8SUiqkWV1P7QfL7fZ1sXs57ecUpxj/z6i2aoYbRBtCP
         MV3oSA75yvGEHzjthzZ/cb9BwHsBbhHWH18FRlwnQSkCoQvjKwxruTm2ZzAjayyLkk61
         Vj4ItCtymd50B4KlxRHUrRa0UzRDCt2faM0vj0RLlh2LeEk53JvBwrRiCcNu+UqPZXhF
         uq5eTgkHlEx4VnjnQz83l91jKAupp4nhP4IdGow9E3ODzffAkvF5VVCf5TrKDONvvYej
         ODEX2dfgPWvPXNJaeQVH1I1tZ3CY4zGwN9s928ysSkev9IUMXI9ROfP4rTjFcaijoAFf
         RA0Q==
X-Gm-Message-State: AOJu0Yz/fAGIMDutLf6oIxj0SR0UvBL7wyyRv/OO5S0QkUjQTOT5799g
	24MIgOpBc5IKMH8ne7s/6lEXd4NX0yEPavmhqZYzvMr9KoyVBqq2F+0kQB8aW9fZfffAMbAOCUJ
	tN37eGkv56k2Dk+OWVA5dRMEKVDk=
X-Google-Smtp-Source: AGHT+IHOWeNdHgBfgThZE6FhsCfrU3/9YGEHfKqtQ4CL9LJtfWeHkPlUuObeg8P2pKo6/zX0C3Sld8kwIA7UfBRwC4Q=
X-Received: by 2002:a05:6a00:2d14:b0:6e0:5170:4d62 with SMTP id
 fa20-20020a056a002d1400b006e051704d62mr4728247pfb.6.1707352001263; Wed, 07
 Feb 2024 16:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
 <CAEf4Bzb8zopBkfSxynV4DwzODgvPeM_M9rDJ+BtrfriW+TyAZA@mail.gmail.com> <53c5bf7a-97ef-48f6-90f2-d2a170acf1b2@oracle.com>
In-Reply-To: <53c5bf7a-97ef-48f6-90f2-d2a170acf1b2@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 16:26:29 -0800
Message-ID: <CAEf4BzZm-fSSQbp85dx3exoPK2oRhNFg5Op0ggcaD7ZPv=XCxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org, quentin@isovalent.com, 
	ast@kernel.org, daniel@iogearbox.net, Bryce Kahle <bryce.kahle@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:59=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 02/02/2024 22:16, Andrii Nakryiko wrote:
> > On Wed, Jan 31, 2024 at 10:47=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 30/01/2024 23:05, Bryce Kahle wrote:
> >>> From: Bryce Kahle <bryce.kahle@datadoghq.com>
> >>>
> >>> Enables a user to generate minimized kernel module BTF.
> >>>
> >>> If an eBPF program probes a function within a kernel module or uses
> >>> types that come from a kernel module, split BTF is required. The spli=
t
> >>> module BTF contains only the BTF types that are unique to the module.
> >>> It will reference the base/vmlinux BTF types and always starts its ty=
pe
> >>> IDs at X+1 where X is the largest type ID in the base BTF.
> >>>
> >>> Minimization allows a user to ship only the types necessary to do
> >>> relocations for the program(s) in the provided eBPF object file(s). A
> >>> minimized module BTF will still not contain vmlinux BTF types, so you
> >>> should always minimize the vmlinux file first, and then minimize the
> >>> kernel module file.
> >>>
> >>> Example:
> >>>
> >>> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> >>> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
> >>
> >> This is great! I've been working on a somewhat related problem involvi=
ng
> >> split BTF for modules, and I'm trying to figure out if there's overlap
> >> with what you've done here that can help in either direction. I'll try
> >> and describe what I'm doing. Sorry if this is a bit of a diversion,
> >> but I just want to check if there are potential ways your changes coul=
d
> >> facilitate other scenarios in the future.
> >>
> >> The problem I'm trying to tackle is to enable split BTF module
> >> generation to be more resilient to underlying kernel BTF changes;
> >> this would allow for example a module that is not built with the kerne=
l
> >> to generate BTF and have it work even if small changes in vmlinux occu=
r.
> >> Even a small change in BTF ids in base BTF is enough to invalidate the
> >> associated split BTF, so the question is how to make this a bit less
> >> brittle. This won't be needed for modules built along with the kernel,
> >> but more for cases like a package delivering a kernel module.
> >>
> >> The way this is done is similar to what you're doing - generating
> >> minimal base vmlinux BTF along with the module BTF. In my case however
> >> the minimization is not driven by CO-RE relocations; rather it is driv=
en
> >> by only adding types that are referenced by module BTF and any other
> >> associated types needed. We end up with minimal base BTF that is carri=
ed
> >> along with the module BTF (in a .BTF.base_minimal section) and this
> >> minimal BTF will be used to later reconcile module BTF with the runnin=
g
> >> kernel BTF when the module is loaded; it essentially provides the
> >> additional information needed to map to current vmlinux types.
> >>
> >> In this approach, minimal vmlinux BTF is generated via an additional
> >> option to pahole which adds an extra phase to BTF deduplication betwee=
n
> >> module and kernel. Once we have found the candidate mappings for
> >> deduplication, we can look at all base BTF references from module BTF
> >> and recursively add associated types to the base minimal BTF. Finally =
we
> >> reparent the split BTF to this minimal base BTF. Experiments show most
> >> modules wind up with base minimal BTF of around 4000 types, so the
> >> minimization seems to work well. But it's complex.
> >>
> >> So what I've been trying to work out is if this dedup complexity can b=
e
> >> eliminated with your changes, but from what I can see, the membership =
in
> >> the minimal base BTF in your case is driven by the CO-RE relocations
> >> used in the BPF program. Would there do you think be a future where we
> >> would look at doing base minimal BTF generation by other criteria (lik=
e
> >> references from the module BTF)? Thanks!
> >
> > Hm... I might be misremembering or missing something, but the problem
> > you are solving doesn't seem to be related to BTF minimization. I also
> > forgot why you need BTF deduplication, I vaguely remember we needed to
> > remember "expectations" of types that module BTF references in vmlinux
> > BTF, but I fail to remember why we needed dedup... Perhaps we need a
> > BPF office hours session to go over details again?
> >
>
> Yeah, that would be great! I've put
>
> Making split BTF more resilient
>
> ..on the agenda for 02-15.
>
> The reason BTF minimization comes into the picture is this - the
> expectations split BTF can have of base BTF can be quite complex, and in
> figuring out ways to represent them, it occurred that BTF itself - in
> the form of the minimal BTF needed to represent those split BTF
> references - made sense. Consider cases like a split BTF struct that
> contains a base BTF struct embedded in it. If we have a minimal base BTF
> which contains such needed base types, we are in a position to use it to
> later reconcile the base BTF worlds at encoding time and use time (for
> example vmlinux BTF at module build time versus current vmlinux BTF).
>
> Further, a natural time to construct that minimal base BTF presents
> itself when we do deduplication between split and base BTF.  The phase
> after we have mapped split types to canonical types is the ideal time to
> handle this; the algorithm is basically
>
> - foreach reference from split -> base BTF
>  - add it to base minimal BTF
> This is controlled by a new dedup option - gen_base_btf_minimal - which
> would be enabled via  a ---btf_features option to pahole for users who
> wanted to generate minimal base BTF. pahole places the new minimized
> base BTF in .BTF.base_minimal section, with the split BTF referring to
> it in the usual .BTF section. Later this base minimal BTF is used to
> reconcile the split BTF expectations with current base BTF.
>
> The kinds of minimizations I see are pretty reasonable for kernel
> modules; I tried a number of in-tree modules (which wouldn't use this
> feature in practice, just wanted to have something to test with), and
> around 4000 types were observed in base minimal BTF.
>
> It's possible we could adapt this minimization process to be guided
> by CO-RE relocations (rather than split->base BTF references), if that
> would help Bryce's case.

I think this minimization idea is overcomplicating anything. First, we
don't have CO-RE relocations, and from BTF alone we don't know what
fields of base BTF structs module is referencing (that may or may not
be in DWARF). So I don't think there is anything to minimize.

On the other hand, it seems reasonable to record a few basic things
about base BTF type expectations:
  - name
  - size and whether that size has to be exact. This would be
determined if base BTF type is ever embedded or is only referenced by
pointer;
  - we can record number of fields, but you said you want to enable
extensions, so it will have to be treated as minimum number of fields,
probably?

Basically, all we want to ensure is that overall memory layout is
compatible and doesn't cause any module field to be shifted.

>
> Alan


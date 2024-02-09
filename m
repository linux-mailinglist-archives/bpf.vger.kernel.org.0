Return-Path: <bpf+bounces-21647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5684FD2C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E139C1C250E7
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694BE84A42;
	Fri,  9 Feb 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgFjtoQV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B387E770
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508266; cv=none; b=S2BSHkHfBCfG2NArSEnG0+SMsF50NPeLz6QetEuy8N7BgG0rUNMXGfzR+LpKwCXjyhE1zrvp2A7vsARnipRnYbai0KEZOThDDb5WMsaS6lvNOwstORWyR83X50W0/qVJg7Ozpoco0w/XcGhpTpVJI22NPMGoFBlxJKOoPtHd5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508266; c=relaxed/simple;
	bh=GaZBachqpJQx3nbVvdvq0uTQjzzHW+X5Z/8lhUp6dC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwTZc1mEJeKJX4O8ZuxYoLX9jFYH5XrPVP0GxXX1wRBdemUPbnQjHaaTik/sLKNu0yTNLbdF9GOm/V4hhV7xrTjA3/Q+pwqW62d1cdyoJ3paZP/ZhmIdKR89DOuSKmiY0XVrdXvBYsAD/Aek1IUkiVZus5lbTQCaAbNyj5iDybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgFjtoQV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29026523507so1033163a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707508263; x=1708113063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0jQXLTyecNXUeSBfp+Cilp58BQWEjABcLkGBg8F34U=;
        b=YgFjtoQV/1ImpIojrgc8qWclsBOTHNOFZP2cnICx6O4g8EiOEkssonhX0yhpJJB85r
         sBAjn2OTq10leKPBcSWZGip66tD47JIOzIFrFKkkd0/3s8OdmUXWmhdQ5to7oFv4FSYW
         HuE1LjklQs3urv0HUbWk5BLV40+SJYeFh0GB8W2qC8iCKGv1kXXLmfkCxBIdTz19Ak4z
         kYLiK8wMl0Xw4z6TPuChKyyOeUbfd+XQORjU2Dw3UfP8KK8AijGJSMzpQttnFtW+SOyS
         7qQCPo/cmrphKxJ9UEh9eX1VkKllv0XWhp8L02KU+SCjzCTgkPa2WVFA1HhF5wYHEbYo
         q0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707508263; x=1708113063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0jQXLTyecNXUeSBfp+Cilp58BQWEjABcLkGBg8F34U=;
        b=qG2S19aPsV8aVSbcb1Xwjk7bw/IgNxCiK7DwSlE4Ml/lw4L0M9xh4tJuqGvs8zvvYl
         109Kq4jUeef7d3oc+Cn9WGW7AcAj1AdlK0oLqINEUzTI9jyUrUEu//U4JsQHRGVbrDJk
         sG4WHwtZgRnz6o5gwMEnsc8C7HAI7WY9Cci31MAKbR8vZoWZkeMDQrMIizzEyLEzWpqR
         ZB9MxiPhcA3TInf+iEM63eXZZ/JRMKh0RzS3rJymuIXE0lKlb35gp0ce9ROZSccPG9oM
         MWgNhCMQ+1EzEE8O/gI5VWbbaI9BTMjfvbNe4BZ7Mw5yExsVj5qG43dRNNxEwb2ixm4l
         2WIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+0QiFmVjI9aNggSPH7VdwVzCU6mvQMJPgWORYOxHgEwcPCnnayqcuBw7Z9JuibRE82NlM5X/xrO6x8DQoYXhvb/xL
X-Gm-Message-State: AOJu0Yx6bIyAhlUrwUPwU9OHbU5UefGZkkmFSH1AZvf8eIg3J/SnzjL/
	0NJArZe0eDjTC7pV1Cy3j+FX9fAEXHeHuwl1eeSN8NsN25W/EyolA0ZOd54F92ef/BegpBrcbzc
	vOWjbYxkqAKM0uiIOsBoDWfyZEOc=
X-Google-Smtp-Source: AGHT+IGETAIpya8zvAzd0XDE2Krb8a1++DXetvoxrLaYUQAVjk73ZVJsIZxp/aWXKFPa2EIlZ0hvR+b6YVZugU/aGF4=
X-Received: by 2002:a17:90b:30cc:b0:297:fd5:ba7b with SMTP id
 hi12-20020a17090b30cc00b002970fd5ba7bmr15643pjb.31.1707508263391; Fri, 09 Feb
 2024 11:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
 <CAEf4Bzb8zopBkfSxynV4DwzODgvPeM_M9rDJ+BtrfriW+TyAZA@mail.gmail.com>
 <53c5bf7a-97ef-48f6-90f2-d2a170acf1b2@oracle.com> <CAEf4BzZm-fSSQbp85dx3exoPK2oRhNFg5Op0ggcaD7ZPv=XCxg@mail.gmail.com>
 <db6628e6-74e2-4fb3-8e43-8588956684dc@oracle.com>
In-Reply-To: <db6628e6-74e2-4fb3-8e43-8588956684dc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Feb 2024 11:50:51 -0800
Message-ID: <CAEf4BzYgwFZsbKC1Cnpyki5QO2OXNvKNpPxUV04xDH5SkyHvaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org, quentin@isovalent.com, 
	ast@kernel.org, daniel@iogearbox.net, Bryce Kahle <bryce.kahle@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:45=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 08/02/2024 00:26, Andrii Nakryiko wrote:
> > On Tue, Feb 6, 2024 at 2:59=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> On 02/02/2024 22:16, Andrii Nakryiko wrote:
> >>> On Wed, Jan 31, 2024 at 10:47=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>
> >>>> On 30/01/2024 23:05, Bryce Kahle wrote:
> >>>>> From: Bryce Kahle <bryce.kahle@datadoghq.com>
> >>>>>
> >>>>> Enables a user to generate minimized kernel module BTF.
> >>>>>
> >>>>> If an eBPF program probes a function within a kernel module or uses
> >>>>> types that come from a kernel module, split BTF is required. The sp=
lit
> >>>>> module BTF contains only the BTF types that are unique to the modul=
e.
> >>>>> It will reference the base/vmlinux BTF types and always starts its =
type
> >>>>> IDs at X+1 where X is the largest type ID in the base BTF.
> >>>>>
> >>>>> Minimization allows a user to ship only the types necessary to do
> >>>>> relocations for the program(s) in the provided eBPF object file(s).=
 A
> >>>>> minimized module BTF will still not contain vmlinux BTF types, so y=
ou
> >>>>> should always minimize the vmlinux file first, and then minimize th=
e
> >>>>> kernel module file.
> >>>>>
> >>>>> Example:
> >>>>>
> >>>>> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> >>>>> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf=
.o
> >>>>
> >>>> This is great! I've been working on a somewhat related problem invol=
ving
> >>>> split BTF for modules, and I'm trying to figure out if there's overl=
ap
> >>>> with what you've done here that can help in either direction. I'll t=
ry
> >>>> and describe what I'm doing. Sorry if this is a bit of a diversion,
> >>>> but I just want to check if there are potential ways your changes co=
uld
> >>>> facilitate other scenarios in the future.
> >>>>
> >>>> The problem I'm trying to tackle is to enable split BTF module
> >>>> generation to be more resilient to underlying kernel BTF changes;
> >>>> this would allow for example a module that is not built with the ker=
nel
> >>>> to generate BTF and have it work even if small changes in vmlinux oc=
cur.
> >>>> Even a small change in BTF ids in base BTF is enough to invalidate t=
he
> >>>> associated split BTF, so the question is how to make this a bit less
> >>>> brittle. This won't be needed for modules built along with the kerne=
l,
> >>>> but more for cases like a package delivering a kernel module.
> >>>>
> >>>> The way this is done is similar to what you're doing - generating
> >>>> minimal base vmlinux BTF along with the module BTF. In my case howev=
er
> >>>> the minimization is not driven by CO-RE relocations; rather it is dr=
iven
> >>>> by only adding types that are referenced by module BTF and any other
> >>>> associated types needed. We end up with minimal base BTF that is car=
ried
> >>>> along with the module BTF (in a .BTF.base_minimal section) and this
> >>>> minimal BTF will be used to later reconcile module BTF with the runn=
ing
> >>>> kernel BTF when the module is loaded; it essentially provides the
> >>>> additional information needed to map to current vmlinux types.
> >>>>
> >>>> In this approach, minimal vmlinux BTF is generated via an additional
> >>>> option to pahole which adds an extra phase to BTF deduplication betw=
een
> >>>> module and kernel. Once we have found the candidate mappings for
> >>>> deduplication, we can look at all base BTF references from module BT=
F
> >>>> and recursively add associated types to the base minimal BTF. Finall=
y we
> >>>> reparent the split BTF to this minimal base BTF. Experiments show mo=
st
> >>>> modules wind up with base minimal BTF of around 4000 types, so the
> >>>> minimization seems to work well. But it's complex.
> >>>>
> >>>> So what I've been trying to work out is if this dedup complexity can=
 be
> >>>> eliminated with your changes, but from what I can see, the membershi=
p in
> >>>> the minimal base BTF in your case is driven by the CO-RE relocations
> >>>> used in the BPF program. Would there do you think be a future where =
we
> >>>> would look at doing base minimal BTF generation by other criteria (l=
ike
> >>>> references from the module BTF)? Thanks!
> >>>
> >>> Hm... I might be misremembering or missing something, but the problem
> >>> you are solving doesn't seem to be related to BTF minimization. I als=
o
> >>> forgot why you need BTF deduplication, I vaguely remember we needed t=
o
> >>> remember "expectations" of types that module BTF references in vmlinu=
x
> >>> BTF, but I fail to remember why we needed dedup... Perhaps we need a
> >>> BPF office hours session to go over details again?
> >>>
> >>
> >> Yeah, that would be great! I've put
> >>
> >> Making split BTF more resilient
> >>
> >> ..on the agenda for 02-15.
> >>
> >> The reason BTF minimization comes into the picture is this - the
> >> expectations split BTF can have of base BTF can be quite complex, and =
in
> >> figuring out ways to represent them, it occurred that BTF itself - in
> >> the form of the minimal BTF needed to represent those split BTF
> >> references - made sense. Consider cases like a split BTF struct that
> >> contains a base BTF struct embedded in it. If we have a minimal base B=
TF
> >> which contains such needed base types, we are in a position to use it =
to
> >> later reconcile the base BTF worlds at encoding time and use time (for
> >> example vmlinux BTF at module build time versus current vmlinux BTF).
> >>
> >> Further, a natural time to construct that minimal base BTF presents
> >> itself when we do deduplication between split and base BTF.  The phase
> >> after we have mapped split types to canonical types is the ideal time =
to
> >> handle this; the algorithm is basically
> >>
> >> - foreach reference from split -> base BTF
> >>  - add it to base minimal BTF
> >> This is controlled by a new dedup option - gen_base_btf_minimal - whic=
h
> >> would be enabled via  a ---btf_features option to pahole for users who
> >> wanted to generate minimal base BTF. pahole places the new minimized
> >> base BTF in .BTF.base_minimal section, with the split BTF referring to
> >> it in the usual .BTF section. Later this base minimal BTF is used to
> >> reconcile the split BTF expectations with current base BTF.
> >>
> >> The kinds of minimizations I see are pretty reasonable for kernel
> >> modules; I tried a number of in-tree modules (which wouldn't use this
> >> feature in practice, just wanted to have something to test with), and
> >> around 4000 types were observed in base minimal BTF.
> >>
> >> It's possible we could adapt this minimization process to be guided
> >> by CO-RE relocations (rather than split->base BTF references), if that
> >> would help Bryce's case.
> >
> > I think this minimization idea is overcomplicating anything. First, we
> > don't have CO-RE relocations, and from BTF alone we don't know what
> > fields of base BTF structs module is referencing (that may or may not
> > be in DWARF). So I don't think there is anything to minimize.
> >
>
> The minimization is a method to capture expectations of base BTF similar

Important part of btfgen's minimization is about keeping only used
fields (according to CO-RE relocs) and stripping away everything else.
Your "minimization" is quite different, and so referring to both as
"minimization" is just going to confuse things.

> to what you describe below. In the approach I've been pursuing, we
> capture those expectations via the minimal base BTF needed to represent
> the types the module needs.
>
> > On the other hand, it seems reasonable to record a few basic things
> > about base BTF type expectations:
> >   - name
> >   - size and whether that size has to be exact. This would be
> > determined if base BTF type is ever embedded or is only referenced by
> > pointer;
> >   - we can record number of fields, but you said you want to enable
> > extensions, so it will have to be treated as minimum number of fields,
> > probably?
> >
>
> Yeah, the motivation here is that often when changes are backported to
> stable release-based distros, the associated struct changes try to fill
> holes in existing structures so that overall structure size does not
> change in an incompatible way, and any modules that utilize such
> structures continue to work.
>
> > Basically, all we want to ensure is that overall memory layout is
> > compatible and doesn't cause any module field to be shifted.
> >
>
> There are a few other gotchas though. Consider the case of an enum; if
> the values associated with it get shifted between the time the module is
> built and the time it is used, and ENUM_VAL_X that was 1 when the module
> was built, but is now 2 in base vmlinux, we'd need to track that as an
> incompatibility too.

Enum case is a bit weird. If enum is defined in vmlinux BTF, then the
base kernel is built and using that definition of enum, right? So even
if a module's enum definition is different (different integer values),
base's enum definition should probably be used instead in BTF, no?

>
> A minimized view of base BTF - driven by the types the module needs -
> can capture these changes along with the field offset/size issues. The
> approach I use today also avoids expanding types unnecessarily; when it
> encounters a pointer to struct foo in the module representation only,
> the minimized base BTF will just use a fwd representation of that struct
> in minimal base BTF.

So this is basically the only common part with btfgen's minimization,
but overall they are quite different, which is why I'm suggesting to
not combine them.

>
> So to summarize, base BTF minimization is driven by the need to capture
> the set of expectations the module has, similar to what you describe abov=
e.
>
> Alan


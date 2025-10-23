Return-Path: <bpf+bounces-71953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0BC0264D
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D2B1887FAD
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBD2989B0;
	Thu, 23 Oct 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWX+I43R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF2296BC3
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236184; cv=none; b=PGEhENZstqo9iCxGuxyZX4seXBBLLvYJ2/F+MPmP8fpE2ukSBvq4NqgAfxiat4P/HoYU4IG0tqB7POUPKpl94+UsxW72E8Mv43FQ9JcKmxHGcJCyDf23Yl427+3Op3nqeGiOnEiLVsSzm+hpy4s9w9T+26f7nvhK66DPtzdQwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236184; c=relaxed/simple;
	bh=4H6bVxaWrF+ASJzWQsX2wTuxH7vKrKh6iMMbD1uvC/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDDJJp7ZLjb3HujjGXUVglRlKN5tSNcKWjoEkDPqG1XAK50KZidfh7DNsPSREjsn9MHssRGUhVzKdk22VDATYdtvghYNR7cUg4sAvFfrsD6f0Iym3wXDGx5BO4VaODbyGoCDr/8ATtGnH2m6ueOTzNVYtLN2kJBytwfoF/Gdn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWX+I43R; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33be037cf73so1171992a91.2
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236182; x=1761840982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zfWsQ+AFimv3rCgf6S/28JeazWnBkAyvO/PBif/5hY=;
        b=cWX+I43RYdBioBsr8qwU3uH2lmXdkdZnhprx1OM34W3ML1/7B1y37zE1yb85/rMQeJ
         h2g1FM0u2IgL9Fe9SH4KS2HWuNaMgL2KoAgm4k3T/+rzk3HLedX+NBTyH/eEVJ3zhcRS
         N7Iz+2FZV9BjIalqw3kyTezVgeQtULJKPIQ/WhjfYCEFEDG7B7W0C9lmP6gl7wRxh7i6
         mijQY22tQPmed6cb5GzLbu/sYi9dWdeXv+RKUklCOGm+koFr4seIWMElWV1AapF5X6Vp
         atdedwW/vS3RLpPEL+j/87977TkIdVCMoFq+OPwCCoFsB7+OpTWjyn+jbUup6eunyGKR
         XNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236182; x=1761840982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zfWsQ+AFimv3rCgf6S/28JeazWnBkAyvO/PBif/5hY=;
        b=ONs2XyYoCDWeWI9EPZQpbxWEZMrJtUBbyzdKasgxuk1qiD8OxzM7mMKLPcUEZ8kAzE
         Upp18RESkor38tL4KM/Btt4gNtBNqFxpx74ioSahfg8PBmYPavYZRblcwlsnzBcWu59q
         uxQDwm4l5E4YGOOv9rKsh+CTXA5MksQq/1CJNDMTPI4MF295j1RLtbbfY/vuLPwfLMgC
         Ofz1FZJR6X9/VRHbGTBUaT6dzdb8ozRR/q92Wp3tZG3Ne/fmZMw6q7+VpfL3LXco43wE
         eOa1rrsvA3sNEWSeWBRRj0t/wItLafH41tFZveID7CQl5G1I2PFEj8ZNOEBsTOnUYwQA
         ix6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzraALfJykscSi+vJCZLI+Xc3/uDgVsmAC2P2KuEq759dyziDdEdUQO/RAsnJ6TdtNrHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwAIspMb7thqUetxeJjqJ8Je6wCTFxOkTymnbit53AOX+IAwH
	WjxCMNt9E3SLxYmm3oD6T3k9nfM20EVq2cdpDKJR57g61KVzNmzw6AktNPNkjIzW1hiXmoA8NRe
	ghpIz2Mq7T5xL8JzDBBLwOe4fBqfSeis=
X-Gm-Gg: ASbGncvMHmbkvWJyPqTKdVMNuhtxxe78hHsb2yYNWriNX81rHDLpatjx0UZYPTFJyG/
	IvPujEQXLDPmER0IekblBxtIwX36aBTG4ejYnKTIlvA+QzkDjRHj5Siawocl3gNs6IbRVgGzxrk
	rk5daL1uNRs+vs8kqc0lC227+NFchDAFvGmDupyd6DHcV20w//+PCt8cnMJ3Kbf0F2Pu5RJnLjV
	CKkWs6vINZI/ZhmI9gtIjwUofioujeSlhrYSz4MdRddoz82Rmmws72cwi9iKd22hiX5Ffvo7aLn
X-Google-Smtp-Source: AGHT+IFATP81D15ihn4fPdBvLp7q2Mxeptxo6BBxgqw1cWEb+BCaiUmypqGUY0FrMdsuk+UicRhB7WwPPEe6ZuaMK68=
X-Received: by 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id
 98e67ed59e1d1-33bcf90e86cmr32733536a91.34.1761236182263; Thu, 23 Oct 2025
 09:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com> <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <4201e67c-5a56-44f9-ad62-897326d84a41@oracle.com> <CAEf4Bza27n44nNcPUtQHMS9OR1BH_NafY1xcRqhKORJMNamP_w@mail.gmail.com>
 <1b7bd33c-1b50-421c-98be-4b6c41d89e1e@oracle.com>
In-Reply-To: <1b7bd33c-1b50-421c-98be-4b6c41d89e1e@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Oct 2025 09:16:09 -0700
X-Gm-Features: AS18NWCIoktxYONwqddNYnqSVlcjpKDU1JVk7yyjPbUTAfquQuWkRR3TSgbrRQM
Message-ID: <CAEf4BzZx=X6vGqcA8SPU6D+v6k+TR=ZewebXMuXtpmML058piw@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, David Faust <david.faust@oracle.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:37=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/10/2025 19:36, Andrii Nakryiko wrote:
> > On Tue, Oct 14, 2025 at 2:58=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 14/10/2025 01:12, Alexei Starovoitov wrote:
> >>> On Mon, Oct 13, 2025 at 12:38=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>
> >>>>
> >>>> I was trying to avoid being specific about inlines since the same
> >>>> approach works for function sites with optimized-out parameters and =
they
> >>>> could be easily added to the representation (and probably should be =
in a
> >>>> future version of this series). Another "extra" source of info
> >>>> potentially is the (non per-cpu) global variables that Stephen sent
> >>>> patches for a while back and the feeling was it was too big to add t=
o
> >>>> vmlinux BTF proper.
> >>>>
> >>>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
> >>>
> >>> aux is too abstract and doesn't convey any meaning.
> >>> How about "BTF.func_info" ? It will cover inlined and optimized funcs=
.
> >>>
> >>
> >> Sure, works for me.
> >>
> >>> Thinking more about reuse of struct btf_type for these...
> >>> After sleeping on it it feels a bit awkward today, since if they're
> >>> types they suppose to be in one table with other types,
> >>> searchable and so on, but we actually don't want them there.
> >>> btf_find_*() isn't fast and people are trying to optimize it.
> >>> Also if we teach the kernel to use these loc-s they probably
> >>> should be in a separate table.
> >>>
> >>
> >> The BTF with location info is a separate split BTF, so it won't regres=
s
> >> search times of vmlinux/module BTF. Searching by name isn't really a
> >> need for the non-LOCSEC cases; None of the FUNC_PROTO, LOC_PROTO and
> >> LOC_PARAM have names, so the searching that will be done to deal with
> >> inlines will all be within the LOCSEC representations for the inlines,
> >> and from there it'll just be id-based lookup.
> >>
> >> Currently the LOCSECs are sorted internally by address, but we could
> >> change that to be by name given that name-based lookup is the much mor=
e
> >> likely search mode.
> >>
> >> One limitation we hit is that the max BTF vlen number is not sufficien=
t
> >> to represent all the inlines in one LOCSEC; we max out at specifying a
> >> vlen of 65535, and need over 400000 LOCSEC entries. So we add multiple
> >
> > We have this, currently:
> >
> >
> > /* Max # of struct/union/enum members or func args */
> > #define BTF_MAX_VLEN    0xffff
> >
> > struct btf_type {
> >         __u32 name_off;
> >         /* "info" bits arrangement
> >          * bits  0-15: vlen (e.g. # of struct's members)
> >          * bits 16-23: unused
> >          * bits 24-28: kind (e.g. int, ptr, array...etc)
> >          * bits 29-30: unused
> >          * bit     31: kind_flag, currently used by
> >          *             struct, union, enum, fwd, enum64,
> >          *             decl_tag and type_tag
> >          */
> >
> >
> > Note those unused 16-23 bits. We can use them to extend vlen up to 8
> > million, which should hopefully be good enough? This split by name
> > prefix sounds unnecessarily convoluted, tbh.
> >
>
> That would be great! Do you have a preference for how libbpf might
> handle this? Currently we have
>
>
> static inline __u16 btf_vlen(const struct btf_type *t)
> {
>         return BTF_INFO_VLEN(t->info);
> }
>
> As a result many consumers (in libbpf and elsewhere) use a __u16 for the
> vlen value.  Would it make sense to add
>
> static inline __u32 btf_extended_vlen(const struct btf_type *t)
> {
>         return BTF_INFO_VLEN(t->info);
> }
>
> perhaps?

just update btf_vlen() to return __u32 and use more bits. Those bits
should be all zeroes today, so all this should be backwards
compatible.

>
>
> >
> >
> >> LOCSECs. That was just a workaround before, but for faster name-based
> >> lookup we could perhaps make use of the multiple LOCSECs by grouping
> >> them by sorted function names. So if the first LOCSEC was called
> >> inline.a and the next LOCSEC inline.c or whatever we'd know locations
> >> named a*, b* are in that first LOCSEC and then do a binary search with=
in
> >> it. We could limit the number of LOCSECs to some reasonable upper boun=
d
> >> like 1024 and this would mean we'd binary search between ~400 LOCSECs
> >> first and then - once we'd found the right one - within it to optimize
> >> lookup time.
> >>
> >>> global non per-cpu vars fit into current BTF's datasec concept,
> >>> so they can be another kernel module with a different name.
> >>>
> >>> I guess one can argue that LOCSEC is similar to DATASEC.
> >>> Both need their own search tables separate from the main type table.
> >>>
> >>
> >> Right though we could use a hybrid approach of using the LOCSEC name +
> >> multiple LOCSECs (which we need anyway) to speed things up.
> >>>>
> >>>>> The partially inlined functions were the biggest footgun so far.
> >>>>> Missing fully inlined is painful, but it's not a footgun.
> >>>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> >>>>> user space is not enough. It's great and, probably, can be supporte=
d,
> >>>>> but the kernel should use this "BTF.inline_info" as well to
> >>>>> preserve "backward compatibility" for functions that were
> >>>>> not-inlined in an older kernel and got partially inlined in a new k=
ernel.
> >>>>>
> >>>>
> >>>> That would be great; we'd need to teach the kernel to handle multi-s=
plit
> >>>> BTF but I would hope that wouldn't be too tricky.
> >>>>
> >>>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> >>>>> make a lot of sense, but since libbpf has to attach a bunch
> >>>>> of regular kprobes it seems to me the kernel support is more approp=
riate
> >>>>> for the whole thing.
> >>>>
> >>>> I'm happy with either a userspace or kernel-based approach; the main=
 aim
> >>>> is to provide this functionality in as straightforward a form as
> >>>> possible to tracers/libbpf. I have to confess I didn't follow the wh=
ole
> >>>> kprobe multi progress, but at one stage that was more kprobe-based
> >>>> right? Would there be any value in exploring a flavour of kprobe-mul=
ti
> >>>> that didn't use fprobe and might work for this sort of use case? As =
you
> >>>> say if we had that keeping a user-space based approach might be more
> >>>> attractive as an option.
> >>>
> >>> Agree.
> >>>
> >>> Jiri,
> >>> how hard would it be to make multi-kprobe work on arbitrary IPs ?
> >>>
> >>>>
> >>>>> I mean when the kernel processes SEC("fentry/foo") into partially
> >>>>> inlined function "foo" it should use fentry for "foo" and
> >>>>> automatically add kprobe into inlined callsites and automatically
> >>>>> generated code that collects arguments from appropriate registers
> >>>>> and make "fentry/foo" behave like "foo" was not inlined at all.
> >>>>> Arguably, we can use a new attach type.
> >>>>> If we teach the kernel to do that then doing bpf_loc_arg() and a bu=
nch
> >>>>> of regular kprobes from libbpf is unnecessary.
> >>>>> The kernel can do the same transparently and prepare the args
> >>>>> depending on location.
> >>>>> If some of the callsites are missing args it can fail the whole ope=
ration.
> >>>>
> >>>> There's a few options here but I think having attach modes which are
> >>>> selectable - either best effort or all-or-none would both be needed =
I
> >>>> think.
> >>>
> >>> Exactly. For partially inlined we would need all-or-none,
> >>> but I see a case where somebody would want to say:
> >>> "pls attach to all places where foo() is called and since
> >>> it's inlined the actual entry point may not be accurate and it's ok".
> >>>
> >>> The latter would probably need a flag in tracing tools like bpftrace.
> >>> I think all-or-none is a better default.
> >>>
> >>
> >> Yep, agree.
> >>
> >>>>> Of course, doing the whole thing from libbpf feels good,
> >>>>> since we're burdening the kernel with extra complexity,
> >>>>> but lack of kprobe-multi changes the way to think about this trade =
off.
> >>>>>
> >>>>> Whether we decide that the kernel should do it or stay with bpf_loc=
_arg()
> >>>>> the first few patches and pahole support can/should be landed first=
.
> >>>>>
> >>>>
> >>>> Sounds great! Having patches 1-10 would be useful as that would allo=
w us
> >>>> in turn to update pahole's libbpf submodule commit to generate locat=
ion
> >>>> data, which would then allow us to update kbuild and start using it =
for
> >>>> attach. So we can focus on generating the inline info first, and the=
n
> >>>> think about how we want to present that info to consumers.
> >>>
> >>> Yep. Please post pahole patches for review. I doubt folks
> >>> will look into your git tree ;)
> >>>
> >>
> >
> > BTW, what happened to the self-described BTF patches? With these
> > additions we are going to break all the BTF-based tooling one more
> > time. Let's add minimal amount of changes to BTF to allow tools to
> > skip unknown BTF types and dump the rest? I don't remember all the
> > details by now, was there any major blocker last time? I feel like
> > that minimal approach of fixed size + vlen * vlen_size would still
> > work even for all these newly added types (even with the alternative
> > for LOC_PARAM I mention in the corresponding patch).
> >
> >
>
> Yep that scheme would still work. The reason I didn't prioritize it here
> is that the BTF with new LOC kinds is separate from the BTF that legacy
> tools would be looking at, but I'd be happy to revive it if it'd help.

We are coming up on another big BTF update, so I think it's time to
add this minimal self-describing info and teach bpftool and other
tools to understand this, so that going forward we can add new types
without breaking anything. So yeah, I think we should revive and land
it roughly in the same time frame.

>
> Thanks!
>
> Alan


Return-Path: <bpf+bounces-78348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C6D0BD96
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E0643015829
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304751DE89A;
	Fri,  9 Jan 2026 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFaYMB7V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3119CCF7
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983667; cv=none; b=o+4JzRktlpYrpak1KleFq8vcqOqoV1MLUFzNyTFr24QbMvQP9IcMwRhZU2C+eRIw1XrfxyTg0PbYpA0I7LruTOQCfhShkWR+2QLH3swljp0DD8/klgD0OTx7C4UGBV+zNvpT2gMKgSAC9hHmy6Vi8+zjAqbRWySpLTx812T+Iaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983667; c=relaxed/simple;
	bh=fH1ZaG1r6e9ipB8caS3Az/FSjQNAZq64CfHYQ5eEQfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRELr0zc9KLiEe5mwBi4qcE5hG02UM+Bq8KWZ/eo5+weXIpjPlPt06gWLk4Z9Qm1HLM/H+8ZkOZZV9lnJI4laqzlD9czdYylCschO+i/5vx2O5X0wW7orCk2NBhHtgAXT9U5B35PuwvMl7Bpw6rgi29fteZR+El2LbDpWIG+uqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFaYMB7V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so35818185e9.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767983665; x=1768588465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8iHWfuMGKS8j6ybHjB9zSAEdHZWhU6h34FrPMJ5qeU=;
        b=eFaYMB7Vfj9JbkS+XsaLZp1TTSK55NugMvIKoUKLmU+knC6lNrvm1r4NzpGZjPtluE
         rKQ1BRtMtDTRzLA5hNoqVWsyZL98LEhf69vNgi+yX09y2sf2NH4OuK4SPegmRLUWJHct
         nOeW2lgGc/giVZ7KJZECmBGuk1FTMdN7KCBgOMtXP7Oq5kW69jcsj2Dbtj4DmZYuIdYC
         4nJnnh7q8cbZap4Di0wGY24lqO3V9QeP09Zr/FjSDzYKw/c6EZHzXQToc8K4AtaKcDpX
         5Zu2rt5BWFhLFRmFHmMsUrdSYNuNpCpJSijq2rUS7nb2H/PSdPTG9rikHouLxFJSxEtY
         fBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983665; x=1768588465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8iHWfuMGKS8j6ybHjB9zSAEdHZWhU6h34FrPMJ5qeU=;
        b=VYZuFjQ2zjWSVeVGJsNPXmPwQND48RBaUubMnfwHNXtNgZACXyu/8yArJNQv4t6WtV
         8wy+n53bqKwQSnMo/AX62h2OHSzBF8/RMFLtCPE4DPSu91KhioZ0+qaEeTn2CGU+iBh3
         csTc7GZsqZPZqaMfwCUvXB5+hceI0gNTOgW+jLN2XH670mOKgwg1zCoQg5qMcEME0j6s
         /nRlZJHy+dXM1iAdk0Jq8itMO9sd+pxZ0Q+csnWa9lMKua/j8CutwYu7UL7Ck7yInxrc
         im6bUHaZel24KtHCuE1vbPlX8t7Rk9XdGucLQwrSeT3/0iY0th6m60qWD30AawK2Apry
         lXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlsf7iFirIQa8dxTK7FduU737c2rtn01H9DSFY1F9GZjrZ2nJ5p1YqqLWnsoRsQw7AghY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuok71hwZ0hi5Te1Z5mkwV0KfkvjZLyxZWhxmk5r4wnBzuu0ck
	gcE2RsXgtRmhXR1xqul9N05YN30lsnnU/TBiAl63vzf8z4yRBmnt6ciBWLxr1qgrZK4WlXqioUD
	J9s4p+D6CSvKz9dygU6pFi7hXTf+R+qo=
X-Gm-Gg: AY/fxX4CaRAU9/3M0qdqcJ/IUnypM2kVspmCcwML6b99ICjHn+DzOpYj34gyRy1Sm1H
	Ww2xWDEM90nkK9BiCebwPhJe3G3Te4tHWH1PDFpROcifsgpZQuF1k2yDe3lLR7I3VzU+8DCpIMd
	ogsQWBDK2/nbOjMG8IwBbrTw6idCo/8Nm2kujUYCgJs9lw6qwCsx/E0H4VZjvpkUSP9AbmxxUSX
	De6NF+sKnZ9t0swbyt5J6rFpBl5TH2U0RCIShIPymQLmW+wG9NVIRYjRTqZQd7GH2or07a3TTxr
	TbOLhbNrI+irI8gVCo7+ukHRIGVM
X-Google-Smtp-Source: AGHT+IFLr8GzWHhXzIEoH7vQcTU0TCGdTOBs91ac1EtIOVmBJLXMY3xqzbWFBNxBgdbQib3fB5CcIOjZPbNfl2T768s=
X-Received: by 2002:a05:600c:8b0c:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-47d84b18a9fmr115215235e9.5.1767983664398; Fri, 09 Jan 2026
 10:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com> <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com> <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
 <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
 <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com> <CAEf4BzZYS5QN0B-B7HfPrmiag26-XYqiGNEv+n0gAMhg5uYjrA@mail.gmail.com>
 <CAADnVQLFCPDoRQt4nWxsHVt3AG=HnyE=PepaniWv1yeigozaoA@mail.gmail.com> <da5823ad-bc47-4fb3-a308-645e9857947b@oracle.com>
In-Reply-To: <da5823ad-bc47-4fb3-a308-645e9857947b@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 10:34:13 -0800
X-Gm-Features: AZwV_QjL68y-bOWjV6UCf9dTSo5LVXTgeDKDrkbWf4pSZDBaalZi7b5Yp0jLv8E
Message-ID: <CAADnVQLpGFkNnbex6CmbDjpPgXEH4TPvA9XrtY76SX_RaoRq9g@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:21=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 09/01/2026 01:40, Alexei Starovoitov wrote:
> > On Thu, Jan 8, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Thu, Jan 8, 2026 at 10:55=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>>
> >>> On 06/01/2026 01:19, Andrii Nakryiko wrote:
> >>>> On Mon, Jan 5, 2026 at 4:51=E2=80=AFPM Alexei Starovoitov
> >>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>
> >>>>> On Mon, Jan 5, 2026 at 4:11=E2=80=AFPM Andrii Nakryiko
> >>>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>>
> >>>>>> On Tue, Dec 23, 2025 at 3:09=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> >>>>>>>
> >>>>>>> On 22/12/2025 19:03, Alexei Starovoitov wrote:
> >>>>>>>> On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.magu=
ire@oracle.com> wrote:
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hold on. I'm missing how libbpf will sanitize things for older=
 kernels?
> >>>>>>>>>
> >>>>>>>>> The sanitization we can get from layout info is for handling a =
kernel built with
> >>>>>>>>> newer kernel/module BTF. The userspace tooling (libbpf and othe=
rs) does not fully
> >>>>>>>>> understand it due to the presence of new kinds. In such a case =
layout data gives us
> >>>>>>>>> info to parse it by providing info on kind layout, and libbpf c=
an sanitize it
> >>>>>>>>> to be usable for some cases (where the type graph is not fatall=
y compromised
> >>>>>>>>> by the lack of a kind). This will always be somewhat limited, b=
ut it
> >>>>>>>>> does provide more usability than we have today.
> >>>>>>>>
> >>>>>>>> I'm even more confused now. libbpf will sanitize BTF for the sak=
e of
> >>>>>>>> user space? That's not something it ever did. libbpf sanitizes B=
TF
> >>>>>>>> only to
> >>>>>>>
> >>>>>>> Right; it's an extension of the sanitization concept from what it=
 does today.
> >>>>>>> Today we sanitize newer _program_ BTF to ensure it is acceptable =
to a kernel which
> >>>>>>> lacks specific aspects of that BTF; the goal here is to support s=
ome simple sanitization
> >>>>>>> of the newer _kernel_ BTF by libbpf to help tools (that know abou=
t kind layout but may lack
> >>>>>>> latest kind info kernel has) to make that kernel BTF usable.
> >>>>>>
> >>>>>> Wait, is that really a goal? I get why Alexei is confused now :)
> >>>>>>
> >>>>>> I think we should stick to libbpf sanitizing only BPF program's BT=
Fs
> >>>>>> for the sake of loading it into the kernel. If some user space too=
l is
> >>>>>> trying to work with kernel BTF that has BTF features that tool doe=
sn't
> >>>>>> support, then we only have two reasonable options: a) tool just fa=
ils
> >>>>>> to process that BTF altogether or b) the tool is smart enough to
> >>>>>> utilize BTF layout information to know which BTF types it can safe=
ly
> >>>>>> skip (that's where those flags I argue for would be useful). In bo=
th
> >>>>>> cases libbpf's btf__parse() will succeed because libbpf can utiliz=
e
> >>>>>> layout info to construct a lookup table for btf__type_by_id(). And
> >>>>>> libbpf doesn't need to do anything beyond that, IMO.
> >>>>>>
> >>>>>> We'll teach bpftool to dump as much of BTF as possible (I mean
> >>>>>> `bpftool btf dump file`), so it's possible to get an idea of what =
part
> >>>>>> of BTF is not supported and show those that we know about. We coul=
d
> >>>>>> teach btf_dump to ignore those types that are "safe modifier-like
> >>>>>> reference kind" (as marked with that flag I proposed earlier), so =
that
> >>>>>> `format c` works as well (though I wouldn't recommend using such
> >>>>>> output as a proper vmlinux.h, users should update bpftool ASAP for
> >>>>>> such use cases).
> >>>>>>
> >>>>>> As far as the kernel is concerned, BTF layout is not used and shou=
ld
> >>>>>> not be used or trusted (it can be "spoofed" by the user). It can
> >>>>>> validate it for sanity, but that's pretty much it. Other than that=
, if
> >>>>>> the kernel doesn't *completely* understand every single piece of B=
TF,
> >>>>>> it should reject it (and that's also why libbpf should sanitize BP=
F
> >>>>>> object's BTF, of course).
> >>>>>
> >>>>> +1 to all of the above, except ok-to-skip flag, since I feel
> >>>>> it will cause more bike sheding and arguing whether a particular
> >>>>> new addition to BTF is skippable or not. Like upcoming location inf=
o.
> >>>>
> >>>> I was thinking about something like TYPE_TAG, where it's in the chai=
n
> >>>> of types and is unavoidable when processing STRUCT and its field.
> >>>> Having a flag specifying that it's ref-like (so btf_type::type field
> >>>> points to a valid type ID) would allow it to still make sense of the
> >>>> entire struct and its fields, though you might be missing some
> >>>> (presumably) optional and highly-specialized extra annotation.
> >>>>
> >>>> But it's fine not to add it, just some type graphs will be completel=
y
> >>>> unprocessable using old tools. Perhaps not such a big deal.
> >>>>
> >>>> I suspect all the newly added BTF kinds will be of "ok-to-skip" kind=
,
> >>>> whether they are more like DECL_TAG (roots pointing to other types) =
or
> >>>> TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
> >>>> fields, PROTO args, etc).
> >>>>
> >>>>> Is it skippable? kinda. Or, say, we decide to add vector types to B=
TF.
> >>>>> Skippable? One might argue that they are while they are mandatory
> >>>>> for some other use case.
> >>>>> Looking at it differently, if the kernel is old and cannot understa=
nd that
> >>>>> BTF feature the libbpf has to sanitize it no matter skippable or no=
t.
> >>>>> While from btf__parse() pov it also doesn't matter.
> >>>>> btf_new()->btf_parse_hdr() will remember kind layout,
> >>>>> and btf_parse_type_sec() can construct the index for the whole thin=
g
> >>>>> with layout info,
> >>>>> while btf_validate_type() has to warn about unknown kind regardless
> >>>>> of skippable flag. The tool (bpftool or else) needs to yell when
> >>>>> final vmlinux.h is incomplete. Skipping printing modifier-like decl=
_tag
> >>>>> is pretty bad for vmlinux.h. It's really not skippable (in my opini=
on)
> >>>>> though one might argue that they are.
> >>>>
> >>>> Yeah, I agree about vmlinux.h. One way to enforce this would be to
> >>>> have btf_dump emit something uncompilable as
> >>>> "HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
> >>>> modified.
> >>>>
> >>>> But yeah, we don't want bikeshedding. It's fine.
> >>>>
> >>>
> >>> Ok so is it best to leave out flags entirely then? If so where we
> >>> are now is to have each kind layout entry have a string name offset,
> >>> a singular element size and a vlen-specified object size. To be
> >>> conservative it might make sense to allow 16 bits for each size field=
,
> >>> leaving us with 64 bits per kind, 160 bytes in total for the 20 kinds=
.
> >>> We could cut down further by leaving out kind name strings if needed.
> >>
> >> Are we sure we will *never* need flags? I'd probably stick to
> >> single-byte sizes and have 2 bytes reserved for flags or whatever we
> >> might need in the future?
> >
> > Just to clarify what I was saying.
> > I think it's a good thing to have flags space and reserve it.
> > I just struggle to see the value of 'ok-to-skip' flag.
> >
> > So 2 bytes of reserved space for flags makes sense to me.
>
> Ok sounds good; I think there is still value in having the single flag
> that tells us that the type/size field in struct btf_type refers
> to a type though, right?

What's the value?

I sort-of kinda see small value of a set of flags like:
- this kind is a type (int, ptr, array, struct, func_proto)
- this kind is a modifier of a type (volatile, const, restrict, type_tag)

but then we cannot quite classify var, datasec, decl_tag, func..

So it feels like it's getting into the bikeshed category again.


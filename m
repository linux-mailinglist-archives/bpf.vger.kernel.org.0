Return-Path: <bpf+bounces-78271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E0D06BB8
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 02:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29ACC301D5A6
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 01:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421442264D5;
	Fri,  9 Jan 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZngjnHSs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F58224AE8
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921876; cv=none; b=oYGc4Tm11gJTwLcet4KJKbQ5zkTUB4MSBCfORL2Btl2tWH4cujQs1ayCanKN6cB3QO5GjKOvRDLz24kFV2cvF43xvODUHeRdNHMPIG4FUw9uMTn/g2t46uFR1pNSWzvV/u1ZiKuxUKyn6ukeqmH/886cw4Q04ibeOXsOr8ijiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921876; c=relaxed/simple;
	bh=77aNEz2koeHn6FN8OLjoLps1TCo+qiHNStN2etC4zl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbVUxEFWkvnFALLaDAE+/zd0ncvPlUj8g6HqhDAISB9yJw1HTGXfWUtqLqZGsfeNG3SZ0JONVFtN2DflyV5EkiDvmT73jxWSlvCGDbI4Py4OoEaObGny2WRouBW7cGIIU5TjDbLpLOWRzQfYug2PNMkYSp4oBT+ZOz0EYS8bzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZngjnHSs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so427384a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767921875; x=1768526675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjLpW02h4Nv4/Mh3XxyMLg4hIQs0ekGD5xCgmpZQHfQ=;
        b=ZngjnHSstR6SC78nHdPtGxchKuCdxfc68GxRItpSHMphSx3gOw4nMW64uKxX5r8M7L
         JhDoanVHZ1BmBvdZQKzM29upH3ycA5TpmT5bFaML6ZypUWYZV2VVjbRVKVfaQuQHfupa
         M487/+OPqexBwsbQk5TmJjbWPHS2fnZTcPt34cElc9q5f2kDzPMOtMmkWMOFNC/u5QxH
         B8glBgxi5QcuWbpfuUWpyPHoJ2Ve+BP3NM8pwNF31MgEalyFVWqPciMlNEFPTaWVuCW6
         aq9/ch7emqgPyw7jBjIPiul8C9Bxg/e5jQ/YD2+SmD24JhubLrVzRrWRQdNSIbx4kiMf
         BMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767921875; x=1768526675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjLpW02h4Nv4/Mh3XxyMLg4hIQs0ekGD5xCgmpZQHfQ=;
        b=AKKRWgoD5IWer8UiIMKy87NlQ8IYCQEA20IpSduf54DayzJMwrwnTHkWIiT6ng9hSn
         /YrdWiunGCinzp3NJrfoETLKZtIf+0b+ktAfCEML6BL2nYxVgYc5ExmEa/NePjuLpZUL
         Jvx4w4fvDu6BK5rwrGVYc18Djm6zo3NhElCVsvz49acu0LkerHBXp5KDZMCjdHRHe/+J
         LJMZELwtxN64wtA1KU4fxn+RQgon4ygGv80IijvwRzd+LGR3neGNDWn+YLg/pcI5dDfi
         eyBD56zszwrKtqtj6+32OXk1LS0s7tP9NRB7PvlwXINDWNWnkmHZboH6zF9pvEtWog6b
         yqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4u28LiqpqYBkW6ZFz6D7WLcVR3aGrQzSyQpx3PkpdB6DTtQYxP+uUP3sQe4WcHW7/Q+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9ZNREjLhCm7mmCiLwyME0ORS0EJuvbFx/ADtzS8JuwfKpv9s
	PmEapJszjM25xSEs8UlssRGCwP3mMWRz/LtMQJGqJ5+iHL9/1/IcaNY5xgHiKJjTzQCYhAExqpV
	c7WobPPKf+Y4i9GYwp6aWwJcO5omZjxE=
X-Gm-Gg: AY/fxX6717FSsunC+jgphNbWeI1pLb6yObZfYTM9KPzJ/1rLHF2YhKy/ImYwToZlNKQ
	+TIYWGrq/nLdhS0WyVWl0ue/1+VN9zUPhPN68WXbcYuTRkFDWjY2NMxB2DoZE6NNS/VoLhoo2Lw
	EHfHkfDJxazw6JzZB3id6Uf8J/Ecx9YrKlzAuOzZQa7UELMAAVdxiUMxnXX/I1cmSwUh9Q2CsVb
	SckxGwpgAcbZRRkhDwKnoH2EppJZHgIB+b4iwpUx3eU4HPmQGACMOxZ7EbTT5+SQjD0XiKOVja7
	nWYvTWDOcdM7SyumJPTroQ==
X-Google-Smtp-Source: AGHT+IGXnFs9QIbRC00ZIZspzXmvYv8YtRuOmvQrAZZ64ATRZgKlg40ofTjBB0Fn89C+bJyt2ADJUrKv4eAp0dh89Pk=
X-Received: by 2002:a05:6a20:12c3:b0:366:19e9:8a3c with SMTP id
 adf61e73a8af0-3898f896919mr8058008637.2.1767921874617; Thu, 08 Jan 2026
 17:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com> <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com> <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
 <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com> <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com>
In-Reply-To: <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jan 2026 17:24:22 -0800
X-Gm-Features: AQt7F2oBIXoNC3aTbXBZ0IzdzjcwGGjCQ70cm0RMSoCSqi_Xs7yn8GyTSwK8s5o
Message-ID: <CAEf4BzZYS5QN0B-B7HfPrmiag26-XYqiGNEv+n0gAMhg5uYjrA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
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

On Thu, Jan 8, 2026 at 10:55=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 06/01/2026 01:19, Andrii Nakryiko wrote:
> > On Mon, Jan 5, 2026 at 4:51=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Jan 5, 2026 at 4:11=E2=80=AFPM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> On Tue, Dec 23, 2025 at 3:09=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> >>>>
> >>>> On 22/12/2025 19:03, Alexei Starovoitov wrote:
> >>>>> On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> >>>>>>
> >>>>>>>
> >>>>>>> Hold on. I'm missing how libbpf will sanitize things for older ke=
rnels?
> >>>>>>
> >>>>>> The sanitization we can get from layout info is for handling a ker=
nel built with
> >>>>>> newer kernel/module BTF. The userspace tooling (libbpf and others)=
 does not fully
> >>>>>> understand it due to the presence of new kinds. In such a case lay=
out data gives us
> >>>>>> info to parse it by providing info on kind layout, and libbpf can =
sanitize it
> >>>>>> to be usable for some cases (where the type graph is not fatally c=
ompromised
> >>>>>> by the lack of a kind). This will always be somewhat limited, but =
it
> >>>>>> does provide more usability than we have today.
> >>>>>
> >>>>> I'm even more confused now. libbpf will sanitize BTF for the sake o=
f
> >>>>> user space? That's not something it ever did. libbpf sanitizes BTF
> >>>>> only to
> >>>>
> >>>> Right; it's an extension of the sanitization concept from what it do=
es today.
> >>>> Today we sanitize newer _program_ BTF to ensure it is acceptable to =
a kernel which
> >>>> lacks specific aspects of that BTF; the goal here is to support some=
 simple sanitization
> >>>> of the newer _kernel_ BTF by libbpf to help tools (that know about k=
ind layout but may lack
> >>>> latest kind info kernel has) to make that kernel BTF usable.
> >>>
> >>> Wait, is that really a goal? I get why Alexei is confused now :)
> >>>
> >>> I think we should stick to libbpf sanitizing only BPF program's BTFs
> >>> for the sake of loading it into the kernel. If some user space tool i=
s
> >>> trying to work with kernel BTF that has BTF features that tool doesn'=
t
> >>> support, then we only have two reasonable options: a) tool just fails
> >>> to process that BTF altogether or b) the tool is smart enough to
> >>> utilize BTF layout information to know which BTF types it can safely
> >>> skip (that's where those flags I argue for would be useful). In both
> >>> cases libbpf's btf__parse() will succeed because libbpf can utilize
> >>> layout info to construct a lookup table for btf__type_by_id(). And
> >>> libbpf doesn't need to do anything beyond that, IMO.
> >>>
> >>> We'll teach bpftool to dump as much of BTF as possible (I mean
> >>> `bpftool btf dump file`), so it's possible to get an idea of what par=
t
> >>> of BTF is not supported and show those that we know about. We could
> >>> teach btf_dump to ignore those types that are "safe modifier-like
> >>> reference kind" (as marked with that flag I proposed earlier), so tha=
t
> >>> `format c` works as well (though I wouldn't recommend using such
> >>> output as a proper vmlinux.h, users should update bpftool ASAP for
> >>> such use cases).
> >>>
> >>> As far as the kernel is concerned, BTF layout is not used and should
> >>> not be used or trusted (it can be "spoofed" by the user). It can
> >>> validate it for sanity, but that's pretty much it. Other than that, i=
f
> >>> the kernel doesn't *completely* understand every single piece of BTF,
> >>> it should reject it (and that's also why libbpf should sanitize BPF
> >>> object's BTF, of course).
> >>
> >> +1 to all of the above, except ok-to-skip flag, since I feel
> >> it will cause more bike sheding and arguing whether a particular
> >> new addition to BTF is skippable or not. Like upcoming location info.
> >
> > I was thinking about something like TYPE_TAG, where it's in the chain
> > of types and is unavoidable when processing STRUCT and its field.
> > Having a flag specifying that it's ref-like (so btf_type::type field
> > points to a valid type ID) would allow it to still make sense of the
> > entire struct and its fields, though you might be missing some
> > (presumably) optional and highly-specialized extra annotation.
> >
> > But it's fine not to add it, just some type graphs will be completely
> > unprocessable using old tools. Perhaps not such a big deal.
> >
> > I suspect all the newly added BTF kinds will be of "ok-to-skip" kind,
> > whether they are more like DECL_TAG (roots pointing to other types) or
> > TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
> > fields, PROTO args, etc).
> >
> >> Is it skippable? kinda. Or, say, we decide to add vector types to BTF.
> >> Skippable? One might argue that they are while they are mandatory
> >> for some other use case.
> >> Looking at it differently, if the kernel is old and cannot understand =
that
> >> BTF feature the libbpf has to sanitize it no matter skippable or not.
> >> While from btf__parse() pov it also doesn't matter.
> >> btf_new()->btf_parse_hdr() will remember kind layout,
> >> and btf_parse_type_sec() can construct the index for the whole thing
> >> with layout info,
> >> while btf_validate_type() has to warn about unknown kind regardless
> >> of skippable flag. The tool (bpftool or else) needs to yell when
> >> final vmlinux.h is incomplete. Skipping printing modifier-like decl_ta=
g
> >> is pretty bad for vmlinux.h. It's really not skippable (in my opinion)
> >> though one might argue that they are.
> >
> > Yeah, I agree about vmlinux.h. One way to enforce this would be to
> > have btf_dump emit something uncompilable as
> > "HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
> > modified.
> >
> > But yeah, we don't want bikeshedding. It's fine.
> >
>
> Ok so is it best to leave out flags entirely then? If so where we
> are now is to have each kind layout entry have a string name offset,
> a singular element size and a vlen-specified object size. To be
> conservative it might make sense to allow 16 bits for each size field,
> leaving us with 64 bits per kind, 160 bytes in total for the 20 kinds.
> We could cut down further by leaving out kind name strings if needed.

Are we sure we will *never* need flags? I'd probably stick to
single-byte sizes and have 2 bytes reserved for flags or whatever we
might need in the future?


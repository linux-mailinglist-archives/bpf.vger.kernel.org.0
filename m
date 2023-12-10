Return-Path: <bpf+bounces-17326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695280B883
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 04:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118981F21048
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285415AC;
	Sun, 10 Dec 2023 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmlbCcXS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AAEFD
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 19:10:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so20705115e9.3
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 19:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702177845; x=1702782645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIksy3SQTBUBARta9D9fpak30NF+hUQgyMPS+9iDm/8=;
        b=YmlbCcXSAbZTSTw7uGmxQ6NzsAq5ht6Z5VDK4NVDG7BDf1pZ1WHyz8++mGov5PKCFE
         jtM6mLVi4Kk0JotPq+HFy0pfsmWdfFPfYl86kfIyIlHSGAab2YBzPRjqocVnrdfJ8ma6
         scDwr3yxPH0YP+ciZruyzNyvj8R7uqPbxBoCsgPJuRhHYX31bTUpg5haQP3QVJCxDbAV
         ftz0yqIjNiu8qI/BED+CfDsQGmfzq21lQlEdwecI8ARtyZihPWWnEWgNFSEu/suJEySC
         HYP9+h6E7ccto3iTH+3MWeLKD2cmY1E3oRobWPjxBFzxMstoZ1kKHWIn3lEwvBH1JFqj
         CAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702177845; x=1702782645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIksy3SQTBUBARta9D9fpak30NF+hUQgyMPS+9iDm/8=;
        b=LtTlxCzhy29HIEFXtqfpScjAjVIelAXJDmMH0zt+DQVLeWsxK0zU4y9SLdrgHiEVS8
         GAgQwAZUn8FaEfqOQo4iFooC/UMaQzu8wIz3jeGBPdyjd4NBkLPWTkGTUF5DvSbN9hT/
         TU3jBX5vxSzAs+Y0VW9SO5z7W+o98i6gmNDV0mu5NfWnsFzPkN4TWRDhxqK1I7zLlg7a
         57lBKWxMhK+2w150Oy+7jPIL3Z5Da8AM01btAXYQiT45/iXy0yvCjP1/PpZXjp7anZgG
         axx/8HNi/8Q497IymmXgb/XEnhtntS9FHFPxR83D8lipo1dfiyzCxTzd5KTOpucwfBdu
         9qzQ==
X-Gm-Message-State: AOJu0YwHccRQ07K2ikVZ+QUCdKaCPa4rBv/QQYyqLSBOs5rR5Qeer1wl
	On3KBMbpxWhaFfDLObJlUOniBjfTN3BqVVbtA6s=
X-Google-Smtp-Source: AGHT+IHG7+fwvr9GYUZJ4DPY02szyiNOUhDwcZzNYUye5guoD8UtqXxCrgnYb32ceF/YYe/ZxuY/PC+5zbP7xynHSA8=
X-Received: by 2002:a05:600c:3784:b0:40b:5e21:e27b with SMTP id
 o4-20020a05600c378400b0040b5e21e27bmr1234528wmr.104.1702177845234; Sat, 09
 Dec 2023 19:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge> <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
In-Reply-To: <20231207215152.GA168514@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 19:10:33 -0800
Message-ID: <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>, 
	Christoph Hellwig <hch@infradead.org>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 1:51=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Sat, Dec 02, 2023 at 11:51:50AM -0800, dthaler1968=3D40googlemail.com@=
dmarc.ietf.org wrote:
> > >From David Vernet's WG summary:
> > > After this update, the discussion moved to a topic for the BPF ISA
> > document that has yet to be resolved:
> > > ISA RFC compliance. Dave pointed out that we still need to specify wh=
ich
> > instructions in the ISA are
> > > MUST, SHOULD, etc, to ensure interoperability.  Several different opt=
ions
> > were presented, including
> > >  having individual-instruction granularity, following the clang CPU
> > versioning convention, and grouping
> > > instructions by logical functionality.
> > >
> > > We did not obtain consensus at the conference on which was the best w=
ay
> > forward. Some of the points raised include the following:
> > >
> > > - Following the clang CPU versioning labels is somewhat arbitrary. It
> > >   may not be appropriate to standardize around grouping that is a res=
ult
> > >   of largely organic historical artifacts.
> > > - If we decide to do logical grouping, there is a danger of
> > >   bikeshedding. Looking at anecdotes from industry, some vendors such=
 as
> > >   Netronome elected to not support particular instructions for
> > >   performance reasons.
> >
> > My sense of the feedback in general was to group instructions by logica=
l
> > functionality, and only create separate
> > conformance groups where there is some legitimate technical reason that=
 a
> > runtime might not want to support
> > a given set of instructions.  Based on discussion during the meeting, h=
ere's
> > a strawman set of conformance
> > groups to kick off discussion.  I've tried to use short (like 6 charact=
ers
> > or fewer) names for ease of display in
> > document tables, and potentially in command line options to tools that =
might
> > want to use them.
> >
> > A given runtime platform would be compliant to some set of the followin=
g
> > conformance groups:
> >
> > 1. "basic": all instructions not covered by another group below.
> > 2. "atomic": all Atomic operations.  I think Christoph argued for this =
one
> > in the meeting.
> > 3. "divide": all division and modulo operations.  Alexei said in the me=
eting
> > that he'd heard demand for this one.
> > 4. "legacy": all legacy packet access instructions (deprecated).
> > 5. "map": 64-bit immediate instructions that deal with map fds or map
> > indices.
> > 6. "code": 64-bit immediate instruction that has a "code pointer" type.
> > 7. "func": program-local functions.
>
> I thought for a while about whether this should be part of the basic
> conformance group, and talked through it with Jakub Kicinski. I do think
> it makes sense to keep it separate like this. For e.g. devices with
> Harvard architectures, it could get quite non-trivial for the verifier
> to determine whether accesses to arguments stored in special register
> are safe. Definitely not impossible, and overall very useful to support
> this, but in order to ease vendor adoption it's probably best to keep
> this separate.
>
> > Things that I *think* don't need a separate conformance group (can just=
 be
> > in "basic") include:
> > a. Call helper function by address or BTF ID.  A runtime that doesn't
> > support these simply won't expose any
> >     such helper functions to BPF programs.
> > b. Platform variable instructions (dst =3D var_addr(imm)).  A runtime t=
hat
> > doesn't support this simply won't
> >     expose any platform variables to BPF programs.
> >
> > Comments? (Let the bikeshedding begin...)
>
> This list seems logical to me,

I think we should do just two categories: legacy and the rest,
since any scheme will be flawed and infinite bikeshedding will ensue.
For example, let's take a look at #2 atomic...
Should it include or exclude atomic_add insn ? It was added
at the very beginning of BPF ISA and was used from day one.
Without it it's impossible to count stats. The typical network or
tracing use case needs to count events and one cannot do it without
atomic increment. Eventually per-cpu maps were added as an alternative.
I suspect any platform that supports #1 basic insn without
atomic_add will not be practically useful.
Should atomic_add be a part of "basic" then? But it's atomic.
Then what about atomic_fetch_add insn? It's pretty close semantically.
Part of atomic or part of basic?

Another example, #3 divide. bpf cpu=3Dv1 ISA only has unsigned div/mod.
Eventually we added a signed version. Integer division is one of the
slowest operations in a HW. Different cpus have different flavors
of them 64/32 64/64 32/32, etc. All with different quirks.
cpu=3Dv1 had modulo insn because in tracing one often needs to do it
to select a slot in a table, but in networking there is rarely a need.
So bpf offload into netronome HW doesn't support it (iirc).
Should div/mod signed/unsigned be a part of basic? or separate?
Only 32 or 64 bit?

Hence my point: legacy and the rest (as of cpu=3Dv4) are the only two categ=
ories
we should have in _this_ version of the standard.
Rest assured we will add new insn in the coming months.
I suggest we figure out conformance groups for future insns at that time.
That would be the time to argue and actually extract value out of discussio=
n.
Retroactive bike shedding is a bike shedding and nothing else.


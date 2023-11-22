Return-Path: <bpf+bounces-15676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6307F4E94
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16B51C20ACF
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 17:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3D57888;
	Wed, 22 Nov 2023 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWOynzkc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4567DD
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:42:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a002562bd8bso14930566b.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700674941; x=1701279741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjInO44ndk7ZeA93TCSlf8a3LggziidMtZBY0NFF6+I=;
        b=dWOynzkckXoJYzAQOP47K45kdmMW26cVke1OjQEblqa8M2Gi/LAyX6FDGYhK/nkz/e
         66FdtNo7g9mi2Qk849O6ycXhVMzPbuWLJ5SNxM45Qgrt0viHx2jJqMiBPhxd4yXTtwxt
         jMRhwPbX9Rj7fKGHp4R9OxMH3b+fK19VfoPiYiUB0kyCDW9UfIb+T6grCxqwbDIWl1lY
         M7iUTLFOYFIA7EacZd3NlfKkI7zUhzwrC52zbTvS0fYrcrvXTriJNadr1m558zabwZcP
         jMOutJZAYh4dB68X5kTcWg+v6Qy2UknxndC5BynCZjBtnC0swVOPn7vCK2OSiPorqDGe
         xi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674941; x=1701279741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjInO44ndk7ZeA93TCSlf8a3LggziidMtZBY0NFF6+I=;
        b=M6ZOz8LIFTxVlLFy/VP3Sw0fka88SdEfkX3eVaQZyoiF3IjBr6PDfMATNTpnhLhZom
         qm2vsQfmh9rS83AXpR4e+DVOt4PZiwTgsuzPeKGSehQSyVcnv/JI5gT5P49UJg9AhQ8Y
         6GZvIbYVQMFS7b6tCk4/KRrQdz93RZBOK0/DANSyjlaI0yfnREDJpC3zUJ2WYgwN6mEQ
         08EHlgFrnPnro3Dedr3LyxCtVbAkI5VRyqCF9Bs7vf/8WeXwpn/RKbFRt5o85apCC2VL
         NDPJbJ2LBFhDpMkSWPUrba8JFf6ohiQVNPcUiis+zi/ATtyTyZ9OprMKg44dAA5xUahO
         miYA==
X-Gm-Message-State: AOJu0Yz0eB1+7lJpTPae2SXqKbkRk/34FzE+NdSdKetwdjJ65y5FrYcP
	9XD6g8TM13HkEzdDaO/lLQ1iLrNZNonJ0JmNXuA=
X-Google-Smtp-Source: AGHT+IGAk8HviQ/Sf9Q/dmhs0MEMs3qVKOOCpmWrQHv9txy8pzrzd8ecEdnCPDsTinB5ZXKZp87idxPdbNfdwmEo7FA=
X-Received: by 2002:a17:906:101b:b0:9e5:26b2:b38d with SMTP id
 27-20020a170906101b00b009e526b2b38dmr158857ejm.10.1700674940784; Wed, 22 Nov
 2023 09:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112124834.388735-1-alan.maguire@oracle.com>
 <f546e2bf-982b-62cd-b2d4-88760d4d97d7@oracle.com> <CAEf4BzZa1Z1c+oe2=he_UDgZbowDUvCaDLKKhHyvR5PQqZBNNw@mail.gmail.com>
 <6f56ebb5-ea60-54ae-f2b6-ccd77290cd35@oracle.com>
In-Reply-To: <6f56ebb5-ea60-54ae-f2b6-ccd77290cd35@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Nov 2023 09:42:09 -0800
Message-ID: <CAEf4BzbrTqZsJX=tf8avPJToceUeQszh_q+K-nO_Ho45c0bxqA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/17] Add kind layout, CRCs to BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, masahiroy@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 9:00=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 21/11/2023 19:44, Andrii Nakryiko wrote:
> > On Tue, Nov 14, 2023 at 12:20=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> hi folks
> >>
> >> I wanted to capture feedback received on the approach described here f=
or
> >> BTF module generation at my talk at LPC [1].
> >>
> >> Stepping back, the aim is to provide a way to generate BTF for a modul=
e
> >> such that it is somewhat resilient to minor changes in underlying BTF,
> >> so it does not have to be rebuilt every time vmlinux is built.  The
> >> module references to vmlinux BTF ids are currently very brittle, and
> >> even for the same kernel we get different vmlinux BTF ids if the BTF i=
s
> >> rebuilt.  So the aim is to support a more robust method of module BTF
> >> generation.  Note that the approach described here is not needed for
> >> modules that are built at the same time as the kernel, so it's unlikel=
y
> >> any in-tree modules will need this, but it will be useful for cases su=
ch
> >> as where modules are delivered via a package and want to make use
> >> of BTF such that it will not be invalidated.
> >>
> >> Turning to the talk, the general consensus - I think - was that the
> >> standalone BTF approach described in this series was problematic.
> >> Consider kfuncs, if we have, for example, our own definition of a
> >> structure in  standalone module BTF, the BTF id of the local structure
> >> will not match that of the core kernel, which has the potential to
> >> confuse the verifier.
> >>
> >> A similar problem exists for tracing; we would trace an sk_buff in
> >> the module via the module's view of struct sk_buff, but we have no
> >> guarantees that the module's view is still consistent with the vmlinux
> >> representation (which actually allocated it).
> >>
> >> Hopefully I've characterized this correctly; let me know if I missed
> >> something here.
> >
> > Correct.
> >
> >>
> >> So we need some means to both remap BTF ids in the module BTF that ref=
er
> >> to the vmlinux BTF so they point at the right types, _and_ to check th=
e
> >> consistency of the representation of a vmlinux type between module BTF
> >> build time and when it is loaded into the kernel.
> >>
> >> With this in mind, I think a good way forward might be something like
> >> the following:
> >>
> >> For cases where we want more change-independent module BTF - which
> >> is resilient to things like reshuffling of vmlinux BTF ids, and small
> >> changes that don't invalidate structure use completely - we add
> >> a "relocatable" option to the --btf_features list of features for paho=
le
> >> encoding of module BTF.
> >>
> >> This option would not be needed for modules built at the same time as
> >> the kernel, since the BTF ids and the types they refer to are consiste=
nt.
> >>
> >> When used however, it would tell BTF dedup in pahole to add reocation
> >> information as well as generating usual split BTF at the time of modul=
e
> >> BTF generation. This relocation information would consist of
> >> descriptions of the BTF types that the module refers to in base BTF an=
d
> >> their dependents. By providing such descriptions, we can then reconcil=
e
> >> the views of types between module and kernel, or if such reconciliatio=
n
> >> is impossible, we can refuse to use the BTF. The amount of information
> >> needed for a module will need to be determined, but I'm hopeful in mos=
t
> >> cases it would be a small subset of the type information
> >> required for vmlinux as a whole.
> >>
> >> The process of reconciling module and vmlinux BTF at module load time
> >> would then be
> >>
> >> 1. Remap all the split BTF ids representing module-specific types
> >>    and functions to start at last_vmlinux_id + 1. Since the current
> >>    vmlinux may have a different number of types than the vmlinux
> >>    at time of encoding, this remapping is necessary.
> >
> > Correct.
> >
> >>
> >> 2. For each vmlinux type in our list of relocations, check its
> >>    compatibility with the associated vmlinux type.  This is
> >>    somewhat akin to the CO-RE compatibility checks.  Exact rules
> >
> > Not really. CO-RE compatiblity is explicitly very permissive, while
> > here we want to make sure that types are actually memory
> > layout-compatible.
> >
> >>    would need to be ironed out, but a somewhat loose approach
> >>    would be ideal such that a few minor changes in a struct
> >>    somewhere do not totally invalidate module BTF. Unlike CO-RE
> >>    though, field offset changes are _not_ good since they imply the
> >>    module has an incorrect view of the structure and might
> >>    start using fields incorrectly.
> >
> > I think vmlinux type should have at least all the members that module
> > expects, at the same offset, with the same size. Maybe we should allow
> > vmlinux type to get some types at the end, not sure. How hard a
> > requirement it is to accommodate non-exact type matches between
> > vmlinux and kernel module's types?
> >
>
> The main need is to support resilience in the face of small structure
> changes such that the compiled module will still work. When backporting
> fixes to a stable-based kernel - where a version of say 5.15 stable is
> supported for a while and so accumulates stable fixes - often the
> approach used is to use holes in structures for new fields, or if the
> structure is not embedded in any module-specific structures, add fields
> at the end. All existing field offsets should match. In taking that
> approach, the aim is to make sure data accesses in the module are still
> valid - memory layout compatibility is the goal.

So we'll need to develop some checksum/hash that would accommodate
these allowed changes.

>
> >>
> >>    Note that this is a bit easier than BTF deduplication, because
> >>    the deduplication process that happened at module encoding time
> >>    has already done the dependency checking for us; we just need
> >>    to do a type-by-type, 1-to-1 comparison between our relocation
> >>    types and current vmlinux types.
> >>
> >> 3. If all types are consistent, BTF is loaded and we remap the
> >>    module's vmlinux BTF id references to the corresponding
> >>    vmlinux BTF ids of the current vmlinux.
> >
> > Note that we might need to do something special for anonymous types
> > (modifiers, anon enums and structs/unions). Otherwise it's not clear
> > how to even map them between vmlinux BTF and module BTF.
> >
>
> Good point, we'd probably need to represent some sort of parent-child
> relationship to handle cases like this.

Probably best to keep such anonymous types in module's BTF. It might
add a bit of duplication, but will simplify the rest a lot.

>
> >>
> >> I _think_ this gets us what we want; more resilient module BTF,
> >> but with safety checks to ensure compatible representations.
> >> There were some suggestions of using a hashing method, but I think
> >> such a method presupposes we want exact type matches, which I suspect
> >> would be unlikely to be useful in practice as with most stable-based
> >> distros, small changes in types can be made due to fixes etc.
> >
> > What are "small changes" and how are they automatically determined and
> > validated?
> >
>
> See above, field additions in data structure holes or appended to
> structs for the most part. Once I have something rough working
> I'll see how it performs in practice and report back. Thanks!
>

SGTM.


> Alan
>
>
> >>
> >> There were also a suggestion of doing a full dedup, but I think the
> >> consensus in the room (which I agree with) is that would be hard
> >> to do in-kernel.  So the above approach is a compropmise I think;
> >> it gets actual dedup at BTF creation time to create the list of
> >> references and dependents, and we later check them one-by-one on modul=
e
> >> load for compatibility.
> >>
> >> Anyway I just wanted to try and capture the feedback received, and
> >> lay out a possible direction. Any further thoughts or suggestions
> >> would be much appreciated. Thanks!
> >>
> >> Alan
> >>
> >> [1] https://lpc.events/event/17/contributions/1576/


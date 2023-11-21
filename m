Return-Path: <bpf+bounces-15588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C57F36E2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EE2B218A6
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3342047;
	Tue, 21 Nov 2023 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2lBF47g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9318E
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:44:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a002562bd8bso24522066b.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700595893; x=1701200693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl248It0EqY6Zxf4HE+A6xO9ymK7R/4L7KhAWGxR/aw=;
        b=i2lBF47gPJ+Avr8pHvUGEYhsY+AAV/0TV6xSIFeEN/nr+33gYy5LI0Wz+5fMJilN1D
         AgN5wXzqp3kJvGDfLuMuZ/FBnXubqpFliMayuAeOfGDj5NlZw2ttKbcW2MSq2X0IVXg6
         ihGpj/j/d325eNgUVVez/1j2lhQ/0HoIznntEYHLvsIr5rnNSGyaupMXaLoHxIR/nIQa
         p8VM+tdRpn8gOmQ45Ziw9bzPGhaZyzvc8Z9LMFxXtHhLUc4Z0ClQwJ9Y3RokCsRnwKS9
         ecGbmra/a1YW1KMMn5Uhh6PXkE/PGQdZC7aWcr3lkCcflUgmET2J837SjYbnmfTd2tme
         W7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700595893; x=1701200693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl248It0EqY6Zxf4HE+A6xO9ymK7R/4L7KhAWGxR/aw=;
        b=ttdvvR99BP2B28tzZwuSZzBX3AU7R6BIzBZL/HKceFzXHRwUKzPBOwqPyTDXT5stah
         DyyMpoYa6lN35eu5JTcOw0Mq4/KS9nQPaLotNS3BV/3+joMxxol+ZoyFfCoOSCxk9GAg
         2Ue6jrLTaqc3NlyS2k7+Z0eLyoVJbgY0ufLGgDkC3eQ8YiKm4OGYMEz1vm0+7DAqdcxC
         P1dZNnMT/Pq+u8/2hseZmBNCrWO8/5lqh4tZqkB5HbGjYjAd8IkFoQvIP3i3Y+1kkXo2
         bgkoGz4zebJZ2YndjjrErBud+Cpje+Qkw5vxczllGblUEAVruP44t1SGNckVkAYVpUsv
         CkKA==
X-Gm-Message-State: AOJu0YzuvLr5Tjr49RDX9RJzJJgYieiuIUgs+3bfok513EDjEWd9Uo77
	QpUp+Geim5ulgnIu8X40m9+ps1+Wm8U74O7VWFM=
X-Google-Smtp-Source: AGHT+IF/ev1QR7DnE6cCqUwMcQXKbzFdZt+HtC9/RuN+4/v7WPSxcrcrb4isfgvHXw97ADT2JV7hbykTqhgV0csL8wE=
X-Received: by 2002:a17:907:1004:b0:9ff:3d80:1863 with SMTP id
 ox4-20020a170907100400b009ff3d801863mr3248984ejb.20.1700595892531; Tue, 21
 Nov 2023 11:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112124834.388735-1-alan.maguire@oracle.com> <f546e2bf-982b-62cd-b2d4-88760d4d97d7@oracle.com>
In-Reply-To: <f546e2bf-982b-62cd-b2d4-88760d4d97d7@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 11:44:41 -0800
Message-ID: <CAEf4BzZa1Z1c+oe2=he_UDgZbowDUvCaDLKKhHyvR5PQqZBNNw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/17] Add kind layout, CRCs to BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, masahiroy@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 12:20=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 12/11/2023 12:48, Alan Maguire wrote:
> > Update struct btf_header to add a new "kind_layout" section containing
> > a description of how to parse the BTF kinds known about at BTF
> > encoding time.  This provides the opportunity for tools that might
> > not know all of these kinds - as is the case when older tools run
> > on more newly-generated BTF - to still parse the BTF provided,
> > even if it cannot all be used.
> >
> > Also add CRCs for the BTF and base BTF (if needed) from which it was
> > created.  CRCs provide a few useful features:
> >
> > - the base CRC allows us to explicitly identify when the split and
> >   base BTF are not matched
> > - absence of a base BTF CRC can indicate that BTF is standalone;
> >   i.e. not defined relative to base BTF
> >
> > The former case can be used to explicitly reject mismatched
> > module/kernel BTF rather than assuming it is matched until an
> > unexpected type is encountered.
> >
> > The latter case is useful for modules that are not built as
> > frequently as the kernel; in such cases, the module can be built
> > standalone by specifying an empty BTF base:
> >
> >  make BTF_BASE=3D M=3Dpath/2/module
> >
> > If CRCs are not present (as will be the case for pahole versions
> > prior to the proposed v1.26 which will support CRC generation),
> > standalone BTF can still be identified by a slower fallback
> > method of examining BTF type ids to ensure that BTF is
> > self-referential only.
> >
> > To ensure existing tooling can handle standalone BTF for kernel
> > modules,  we remap the type ids to start after the vmlinux
> > BTF ids, to make it appear to be split BTF.  This allows tools
> > (and the kernel) that assume split BTF for modules to operate normally.
> >
>
> hi folks
>
> I wanted to capture feedback received on the approach described here for
> BTF module generation at my talk at LPC [1].
>
> Stepping back, the aim is to provide a way to generate BTF for a module
> such that it is somewhat resilient to minor changes in underlying BTF,
> so it does not have to be rebuilt every time vmlinux is built.  The
> module references to vmlinux BTF ids are currently very brittle, and
> even for the same kernel we get different vmlinux BTF ids if the BTF is
> rebuilt.  So the aim is to support a more robust method of module BTF
> generation.  Note that the approach described here is not needed for
> modules that are built at the same time as the kernel, so it's unlikely
> any in-tree modules will need this, but it will be useful for cases such
> as where modules are delivered via a package and want to make use
> of BTF such that it will not be invalidated.
>
> Turning to the talk, the general consensus - I think - was that the
> standalone BTF approach described in this series was problematic.
> Consider kfuncs, if we have, for example, our own definition of a
> structure in  standalone module BTF, the BTF id of the local structure
> will not match that of the core kernel, which has the potential to
> confuse the verifier.
>
> A similar problem exists for tracing; we would trace an sk_buff in
> the module via the module's view of struct sk_buff, but we have no
> guarantees that the module's view is still consistent with the vmlinux
> representation (which actually allocated it).
>
> Hopefully I've characterized this correctly; let me know if I missed
> something here.

Correct.

>
> So we need some means to both remap BTF ids in the module BTF that refer
> to the vmlinux BTF so they point at the right types, _and_ to check the
> consistency of the representation of a vmlinux type between module BTF
> build time and when it is loaded into the kernel.
>
> With this in mind, I think a good way forward might be something like
> the following:
>
> For cases where we want more change-independent module BTF - which
> is resilient to things like reshuffling of vmlinux BTF ids, and small
> changes that don't invalidate structure use completely - we add
> a "relocatable" option to the --btf_features list of features for pahole
> encoding of module BTF.
>
> This option would not be needed for modules built at the same time as
> the kernel, since the BTF ids and the types they refer to are consistent.
>
> When used however, it would tell BTF dedup in pahole to add reocation
> information as well as generating usual split BTF at the time of module
> BTF generation. This relocation information would consist of
> descriptions of the BTF types that the module refers to in base BTF and
> their dependents. By providing such descriptions, we can then reconcile
> the views of types between module and kernel, or if such reconciliation
> is impossible, we can refuse to use the BTF. The amount of information
> needed for a module will need to be determined, but I'm hopeful in most
> cases it would be a small subset of the type information
> required for vmlinux as a whole.
>
> The process of reconciling module and vmlinux BTF at module load time
> would then be
>
> 1. Remap all the split BTF ids representing module-specific types
>    and functions to start at last_vmlinux_id + 1. Since the current
>    vmlinux may have a different number of types than the vmlinux
>    at time of encoding, this remapping is necessary.

Correct.

>
> 2. For each vmlinux type in our list of relocations, check its
>    compatibility with the associated vmlinux type.  This is
>    somewhat akin to the CO-RE compatibility checks.  Exact rules

Not really. CO-RE compatiblity is explicitly very permissive, while
here we want to make sure that types are actually memory
layout-compatible.

>    would need to be ironed out, but a somewhat loose approach
>    would be ideal such that a few minor changes in a struct
>    somewhere do not totally invalidate module BTF. Unlike CO-RE
>    though, field offset changes are _not_ good since they imply the
>    module has an incorrect view of the structure and might
>    start using fields incorrectly.

I think vmlinux type should have at least all the members that module
expects, at the same offset, with the same size. Maybe we should allow
vmlinux type to get some types at the end, not sure. How hard a
requirement it is to accommodate non-exact type matches between
vmlinux and kernel module's types?

>
>    Note that this is a bit easier than BTF deduplication, because
>    the deduplication process that happened at module encoding time
>    has already done the dependency checking for us; we just need
>    to do a type-by-type, 1-to-1 comparison between our relocation
>    types and current vmlinux types.
>
> 3. If all types are consistent, BTF is loaded and we remap the
>    module's vmlinux BTF id references to the corresponding
>    vmlinux BTF ids of the current vmlinux.

Note that we might need to do something special for anonymous types
(modifiers, anon enums and structs/unions). Otherwise it's not clear
how to even map them between vmlinux BTF and module BTF.

>
> I _think_ this gets us what we want; more resilient module BTF,
> but with safety checks to ensure compatible representations.
> There were some suggestions of using a hashing method, but I think
> such a method presupposes we want exact type matches, which I suspect
> would be unlikely to be useful in practice as with most stable-based
> distros, small changes in types can be made due to fixes etc.

What are "small changes" and how are they automatically determined and
validated?

>
> There were also a suggestion of doing a full dedup, but I think the
> consensus in the room (which I agree with) is that would be hard
> to do in-kernel.  So the above approach is a compropmise I think;
> it gets actual dedup at BTF creation time to create the list of
> references and dependents, and we later check them one-by-one on module
> load for compatibility.
>
> Anyway I just wanted to try and capture the feedback received, and
> lay out a possible direction. Any further thoughts or suggestions
> would be much appreciated. Thanks!
>
> Alan
>
> [1] https://lpc.events/event/17/contributions/1576/


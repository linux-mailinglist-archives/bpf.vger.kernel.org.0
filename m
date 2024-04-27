Return-Path: <bpf+bounces-28004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C28B433B
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A531C22E1B
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DD6AD6;
	Sat, 27 Apr 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx86gnua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B195228
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177485; cv=none; b=KwWXnfs16fW64nWd+g2Ceusj9CUIT2s3HzljxnL8HClRf3M7A5hpCBKaVS8+L6ViN6d27vLpM5cF49RTYeefNt7h1XxQU7K9szWujMCd35VH2DIeAOrH707rNXkkH5TAir2y941bl2AWAmY7nvXupGmqYxLUXd2q9ANKsT5R5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177485; c=relaxed/simple;
	bh=dsLtUGmlW0kuIIvg3Nkj5vYSOPKCX0joxQa1aDoeX8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxQAT+gYcbbrUwyh55Htfes7SCNFBMKVndJA3C+4W7oxPvFeoVlqQMcHTGOqzBYvow7w8YzyGmtB19a1FheMcw6O/zTDFjItXfL3eYcHju1kqDN7bFl+/F5a/aDlMYZqmMLc7YMaeSF8Idp6lU07H/nAk04NDA3v6FxWgSiKzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx86gnua; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c9300c65so24630235ad.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714177483; x=1714782283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MceoLJ/sYG2EVhAxGDBrhY19oM2m4WDVoGssjmCVbxo=;
        b=mx86gnuaOcBk43buEXH1qLZtlTQ3i3Q0zhg8LIqp2lO2Gn2XEYjBi4FQ0mDvEzka3q
         viok6UiZpYd7HsHQuPnW10ig5OfUL3DRhiYSiTUeDx0tA7nkv/gVy49kQche/dIyGbDo
         jo1gKZvXORW+BrX0F4pu3TQMWwTReDn/SHR1BqF6TqZ07H+/7ByV44gMlPbw8AuA4Hn8
         NV5elTda55fdOi3WGBVx9xawWm9Hm0OC0rQ5xxdLoFrW7kWTP2cSCArhp5JTVc9mVsAd
         rSzrNsWrjfpmvw2lhUoZQ0ijd49DckOG8y2KBuwTkn3tCAyWBtdGA+fNF3GTjxHHa9nE
         qDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714177483; x=1714782283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MceoLJ/sYG2EVhAxGDBrhY19oM2m4WDVoGssjmCVbxo=;
        b=pluN04UV3KzMX2NyDVKSSEck/foHkdqbB1xkw6GymaNUCyrYixVgoW8pjrmWQDBUoZ
         W7zOX2tYq1uvtMacKWpYyYroO26javORg+sH49F6pvuGrAAtskB4kOpmK7hp5M+mdKlb
         EzkglAFnmHcO9WPWkH4TD2YgIsCtTD5okNVfHOhvC/fWcTUBrnDcpXXsEHxXzqZ91IPY
         Cy5UjabUESwC1vTDstt6Gr9bFxNaxtUp91QGKxb/ILsSw9aPp9Ug/XcUzyX0bAkLB9jZ
         c2A3X+Syr0LsAtRi19je0XzikWL7/y1b5fD45rks4kJvdbqXSiIHBXu3oFbcJ2NUjBid
         8OQw==
X-Forwarded-Encrypted: i=1; AJvYcCWi54ziurzRNbKz2+SWsA3urcgx3NgL9j23Q0n/Jj15GEKdrEl5R1aCnWDaCJsu5ei8nUsXKjI4KScYE9PjSR/f1ycN
X-Gm-Message-State: AOJu0YzValbudSz2R9e/d/8epQ8a74KEyiQlXH2M3lmaYI5BFrjj3nVg
	WIHxz9BPIVeFBJ5wzdIxrWDcq+tgcZ5EurqL9rCNRLxlMCAskE+cd7y6FfKMKCxkl8IZhp/CRLO
	xcGE5aMUf/ugdmXNYff97Nlpbtb9vEfmd
X-Google-Smtp-Source: AGHT+IEg+pXtkdpe8J70Qh5+siuTzrhVCKpkoCsiak6pjQnIKeRRE2WDQtoUct9wn/p82E9lpTbPfx0OntZlA2fYciA=
X-Received: by 2002:a17:902:fc4d:b0:1eb:3e13:ca0b with SMTP id
 me13-20020a170902fc4d00b001eb3e13ca0bmr1914469plb.37.1714177483092; Fri, 26
 Apr 2024 17:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <CAEf4BzavgDXC2fM43+20wvHdXbaHRNQLWmWhtzyUh_57UYTc6Q@mail.gmail.com>
In-Reply-To: <CAEf4BzavgDXC2fM43+20wvHdXbaHRNQLWmWhtzyUh_57UYTc6Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 17:24:30 -0700
Message-ID: <CAEf4BzY-P3rdV1LeJFBO_zVMn7pr+b166BOaGZEO4ZQrLdPqKA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/13] bpf: support resilient split BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 3:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > Split BPF Type Format (BTF) provides huge advantages in that kernel
> > modules only have to provide type information for types that they do no=
t
> > share with the core kernel; for core kernel types, split BTF refers to
> > core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
> > uses that structure (or a pointer to it) simply needs to refer to the
> > core kernel type id, saving the need to define the structure and its ma=
ny
> > dependents.  This cuts down on duplication and makes BTF as compact
> > as possible.
> >
> > However, there is a downside.  This scheme requires the references from
> > split BTF to base BTF to be valid not just at encoding time, but at use
> > time (when the module is loaded).  Even a small change in kernel types
> > can perturb the type ids in core kernel BTF, and due to pahole's
> > parallel processing of compilation units, even an unchanged kernel can
> > have different type ids if BTF is re-generated.  So we have a robustnes=
s
> > problem for split BTF for cases where a module is not always compiled a=
t
> > the same time as the kernel.  This problem is particularly acute for
> > distros which generally want module builders to be able to compile a
> > module for the lifetime of a Linux stable-based release, and have it
> > continue to be valid over the lifetime of that release, even as changes
> > in data structures (and hence BTF types) accrue.  Today it's not
> > possible to generate BTF for modules that works beyond the initial
> > kernel it is compiled against - kernel bugfixes etc invalidate the spli=
t
> > BTF references to vmlinux BTF, and BTF is no longer usable for the
> > module.
> >
> > The goal of this series is to provide options to provide additional
> > context for cases like this.  That context comes in the form of
> > distilled base BTF; it stands in for the base BTF, and contains
> > information about the types referenced from split BTF, but not their
> > full descriptions.  The modified split BTF will refer to type ids in
> > this .BTF.base section, and when the kernel loads such modules it
> > will use that base BTF to map references from split BTF to the
> > current vmlinux BTF - a process of relocating split BTF with the
> > currently-running kernel's vmlinux base BTF.
> >
> > A module builder - using this series along with the pahole changes -
> > can then build a module with distilled base BTF via an out-of-tree
> > module build, i.e.
> >
> > make -C . M=3Dpath/2/module
> >
> > The module will have a .BTF section (the split BTF) and a
> > .BTF.base section.  The latter is small in size - distilled base
> > BTF does not need full struct/union/enum information for named
> > types for example.  For 2667 modules built with distilled base BTF,
> > the average size observed was 1556 bytes (stddev 1563).
> >
> > Note that for the in-tree modules, this approach is not needed as
> > split and base BTF in the case of in-tree modules are always built
> > and re-built together.
> >
> > The series first focuses on generating split BTF with distilled base
> > BTF, and provides btf__parse_opts() which allows specification
> > of the section name from which to read BTF data, since we now have
> > both .BTF and .BTF.base sections that can contain such data.
> >
> > Then we add support to resolve_btfids for generating the .BTF.ids
> > section with reference to the .BTF.base section - this ensures the
> > .BTF.ids match those used in the split/base BTF.
> >
> > Finally the series provides the mechanism for relocating split BTF with
> > a new base; the distilled base BTF is used to map the references to bas=
e
> > BTF in the split BTF to the new base.  For the kernel, this relocation
> > process happens at module load time, and we relocate split BTF
> > references to point at types in the current vmlinux BTF.  As part of
> > this, .BTF.ids references need to be mapped also.
> >
> > So concretely, what happens is
> >
> > - we generate split BTF in the .BTF section of a module that refers to
> >   types in the .BTF.base section as base types; these are not full
> >   type descriptions but provide information about the base type.  So
> >   a STRUCT sk_buff would be represented as a FWD struct sk_buff in
> >   distilled base BTF for example.
> > - when the module is loaded, the split BTF is relocated with vmlinux
> >   BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_buf=
f
> >   in vmlinux BTF and map all split BTF references to the distilled base
> >   FWD sk_buff, replacing them with references to the vmlinux BTF
> >   STRUCT sk_buff.
> >
> > Support is also added to bpftool to be able to display split BTF
> > relative to its .BTF.base section, and also to display the relocated
> > form via the "-R path_to_base_btf".
> >
> > A previous approach to this problem [1] utilized standalone BTF for suc=
h
> > cases - where the BTF is not defined relative to base BTF so there is n=
o
> > relocation required.  The problem with that approach is that from
> > the verifier perspective, some types are special, and having a custom
> > representation of a core kernel type that did not necessarily match the
> > current representation is not tenable.  So the approach taken here was
> > to preserve the split BTF model while minimizing the representation of
> > the context needed to relocate split and current vmlinux BTF.
> >
> > To generate distilled .BTF.base sections the associated dwarves
> > patch (to be applied on the "next" branch there) is needed.
> > Without it, things will still work but bpf_testmod will not be built
> > with a .BTF.base section.
> >
> > Changes since RFC [2]:
> >
> > - updated terminology; we replace clunky "base reference" BTF with
> >   distilling base BTF into a .BTF.base section. Similarly BTF
> >   reconcilation becomes BTF relocation (Andrii, most patches)
> > - add distilled base BTF by default for out-of-tree modules
> >   (Alexei, patch 8)
> > - distill algorithm updated to record size of embedded struct/union
> >   by recording it as a 0-vlen STRUCT/UNION with size preserved
> >   (Andrii, patch 2)
> > - verify size match on relocation for such STRUCT/UNIONs (Andrii,
> >   patch 9)
> > - with embedded STRUCT/UNION recording size, we can have bpftool
> >   dump a header representation using .BTF.base + .BTF sections
> >   rather than special-casing and refusing to use "format c" for
> >   that case (patch 5)
> > - match enum with enum64 and vice versa (Andrii, patch 9)
> > - ensure that resolve_btfids works with BTF without .BTF.base
> >   section (patch 7)
> > - update tests to cover embedded types, arrays and function
> >   prototypes (patches 3, 12)
> >
> > One change not made yet is adding anonymous struct/unions that the spli=
t
> > BTF references in base BTF to the module instead of adding them to the
> > .BTF.base section.  That would involve having to maintain two pipes for
> > writing BTF, one for the .BTF.base and one for the split BTF.  It would
> > be possible, but there are I think some edge cases that might make it
> > tricky.  For example consider a split BTF reference to a base BTF
> > ARRAY which in turn referenced an anonymous STRUCT as type.  In such a
> > case, it wouldn't make sense to have the array in the .BTF.base section
> > while having the STRUCT in the module.  The general concern is that onc=
e
>
> Hm.. not really? ARRAY is a reference type (and anonymous at that), so
> it would have to stay in module's BTF, no? I'll go read the patch
> series again, but let me know if I'm missing something.
>
> > we move a type to the module we would need to also ensure any base type=
s
> > that refer to it move there too.  For now it is I think simpler to
> > retain the existing split/base type classifications.
>
> We would have to finalize this part before landing, as it has big
> implications on the relocation process.

Ran out of time, sorry, will continue on Monday. But please consider,
meanwhile, what I mentioned about only having named
structs/unions/enums in distilled base BTF.

>
>
> >
> > [1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@o=
racle.com/
> > [2] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@ora=
cle.com/
> >
> >
> >
> > Alan Maguire (13):
> >   libbpf: add support to btf__add_fwd() for ENUM64
> >   libbpf: add btf__distill_base() creating split BTF with distilled bas=
e
> >     BTF
> >   selftests/bpf: test distilled base, split BTF generation
> >   libbpf: add btf__parse_opts() API for flexible BTF parsing
> >   bpftool: support displaying raw split BTF using base BTF section as
> >     base
> >   kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
> >   resolve_btfids: use .BTF.base ELF section as base BTF if -B option is
> >     used
> >   kbuild, bpf: add module-specific pahole/resolve_btfids flags for
> >     distilled base BTF
> >   libbpf: split BTF relocation
> >   module, bpf: store BTF base pointer in struct module
> >   libbpf,bpf: share BTF relocate-related code with kernel
> >   selftests/bpf: extend distilled BTF tests to cover BTF relocation
> >   bpftool: support displaying relocated-with-base split BTF
> >
> >  include/linux/btf.h                           |  32 +
> >  include/linux/module.h                        |   2 +
> >  kernel/bpf/Makefile                           |   8 +
> >  kernel/bpf/btf.c                              | 227 +++++--
> >  kernel/module/main.c                          |   5 +-
> >  scripts/Makefile.btf                          |  12 +-
> >  scripts/Makefile.modfinal                     |   4 +-
> >  .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
> >  tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
> >  tools/bpf/bpftool/btf.c                       |  20 +-
> >  tools/bpf/bpftool/main.c                      |  14 +-
> >  tools/bpf/bpftool/main.h                      |   2 +
> >  tools/bpf/resolve_btfids/main.c               |  22 +-
> >  tools/lib/bpf/Build                           |   2 +-
> >  tools/lib/bpf/btf.c                           | 561 +++++++++++-----
> >  tools/lib/bpf/btf.h                           |  61 ++
> >  tools/lib/bpf/btf_common.c                    | 146 ++++
> >  tools/lib/bpf/btf_relocate.c                  | 630 ++++++++++++++++++
> >  tools/lib/bpf/libbpf.map                      |   3 +
> >  tools/lib/bpf/libbpf_internal.h               |   2 +
> >  .../selftests/bpf/prog_tests/btf_distill.c    | 298 +++++++++
> >  21 files changed, 1864 insertions(+), 209 deletions(-)
> >  create mode 100644 tools/lib/bpf/btf_common.c
> >  create mode 100644 tools/lib/bpf/btf_relocate.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.=
c
> >
> > --
> > 2.31.1
> >


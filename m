Return-Path: <bpf+bounces-28127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393D8B5F9B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4CF282846
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F461127B70;
	Mon, 29 Apr 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT5cYA2d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECE86636
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410326; cv=none; b=XLLrt8foiif7RVlNEM4IU4Ej8Z/4x7o8QtuStOFF5JrmcejNE1w+YrNmt/9VG8vztzDlAYGiAkQ/e3gdE32oiCyLHm0Tt0IW+sOzIp0AOZAkxSkVHYL6paCj/hgDsTyz4+D1EBAgpYrbmrPAk7qJzMrKFprRv1epq4amv1jFxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410326; c=relaxed/simple;
	bh=2gFroDrmX7wWv1L1nDNGFiFnlkL/1d8HCy0wFn1DoL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTrqYFhRyhu5D9HupXstuVUpZIOSMZpP7gEZ/8L2XSgPGrg9dzMGmW3tueVx36zRbh+r29f+Snip7ZhFzC+HbQ54rzSFUPo3WN2qzxC0BU6SdRiWRKayw4lUPl2EMXJAjgESi+0q4VtGSazCHVOeegEilowKk8ezBIuu263Vp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT5cYA2d; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so3898528a91.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410324; x=1715015124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmLZ9wRiyUOXsSDtJjomtlbO5tzqWUIuyYjx5e17Nts=;
        b=RT5cYA2d550mnB1CXwcG/m70dgR08dr5H3m3jJjv0bvjjzCHMlpoQNRY9BTFSwTBeX
         kUuTaszzoJWyyYfeadN32HqPv0sFvUJZ6nOV71ybzgEN1pQbAkK7mqt4CvQ8Dcfh584Q
         DMIdCQKuwSc93HQL4BgOm0RnxFenjCSjudJkvpHh70bT5woMnUqxUeKD4US6g91Pl8yI
         xDiNqxt1he1b3ao00mBV8E+wwlGA2o+I7RKlUKNoY8ZDzRz1xaj48aqBAsQoZ8TIetwy
         qBhYkiIbepBHQi/m5E1WuAYnxAQLFl6bSGTTiQBdgk3w1FMTP4S/Kglf1lux7ecYYdMG
         y2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410324; x=1715015124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmLZ9wRiyUOXsSDtJjomtlbO5tzqWUIuyYjx5e17Nts=;
        b=VeRv2nMKyydDiTn1FfvQxYjc99YsG8riqzqnSSMN20MfjMZj7bKSrDJpaIUVBKjsCQ
         61TU6683fAkf9GtcsGMTEEajD+jyE7Nwpse05N63aBR2JgIP84d2KfR1xJMgMxRJNCVM
         gzbV+t26lbUdvoyJ9epyQM14AddDTCcSgth0e/19NS0qABsZwzKydCzrcD1fI4p4wlKv
         JR3m3/r0jwwzJS/HJxZhyGNYesQ7K8qIYR/yIuJVC+wYcB4tkOVhAtsFDTuJTSci1iEG
         khgnbO/wKyo7AfGCiqT5qRpbcJaSyAJNHA6uWp0aJu4WGDn2K9C1afzlzvgbGM76fYit
         F+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWHfOEmWzTsWbtfwLAhPxpQf4aDgjjwVp8GEwBLgQszDxr9upCP49Upfu9qaU2t/Moc3sxIYEfbIPbMJZaxvKnllpOf
X-Gm-Message-State: AOJu0Yzf+8RWbKIus7oYm8cWA62H72MSFmhY5ux3GdZKhxnG+TJK8tG9
	wRkWyEHlCW/rk23r7m8PsHFqz1kWeN965nD8dIqQPTKhua36sLKs7GOepAa35sH90nV/JSLXnhe
	oD9BsZwn+hDoiCqRAjrPK+e/OAWE=
X-Google-Smtp-Source: AGHT+IFrk+23+1BatlwjBTebDOcKgjSfg9U7+YiHQQ2kv3U6zv/BOnSrDIG8IfnhM1aeB4T8kIRHOLNAvQTCp5VO08c=
X-Received: by 2002:a17:90b:4d8c:b0:2b2:6975:bf49 with SMTP id
 oj12-20020a17090b4d8c00b002b26975bf49mr164877pjb.6.1714410324037; Mon, 29 Apr
 2024 10:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <CAEf4BzavgDXC2fM43+20wvHdXbaHRNQLWmWhtzyUh_57UYTc6Q@mail.gmail.com>
 <CAEf4BzY-P3rdV1LeJFBO_zVMn7pr+b166BOaGZEO4ZQrLdPqKA@mail.gmail.com> <e08937ac-c329-4a72-9a6e-8fbc36a740b5@oracle.com>
In-Reply-To: <e08937ac-c329-4a72-9a6e-8fbc36a740b5@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 10:05:11 -0700
Message-ID: <CAEf4BzZ=uMh4gW8O20-hZV1njJTAN4afQBKzFHro5A6ym-3FBg@mail.gmail.com>
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

On Mon, Apr 29, 2024 at 8:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 27/04/2024 01:24, Andrii Nakryiko wrote:
> > On Fri, Apr 26, 2024 at 3:56=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>>
> >>> Split BPF Type Format (BTF) provides huge advantages in that kernel
> >>> modules only have to provide type information for types that they do =
not
> >>> share with the core kernel; for core kernel types, split BTF refers t=
o
> >>> core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
> >>> uses that structure (or a pointer to it) simply needs to refer to the
> >>> core kernel type id, saving the need to define the structure and its =
many
> >>> dependents.  This cuts down on duplication and makes BTF as compact
> >>> as possible.
> >>>
> >>> However, there is a downside.  This scheme requires the references fr=
om
> >>> split BTF to base BTF to be valid not just at encoding time, but at u=
se
> >>> time (when the module is loaded).  Even a small change in kernel type=
s
> >>> can perturb the type ids in core kernel BTF, and due to pahole's
> >>> parallel processing of compilation units, even an unchanged kernel ca=
n
> >>> have different type ids if BTF is re-generated.  So we have a robustn=
ess
> >>> problem for split BTF for cases where a module is not always compiled=
 at
> >>> the same time as the kernel.  This problem is particularly acute for
> >>> distros which generally want module builders to be able to compile a
> >>> module for the lifetime of a Linux stable-based release, and have it
> >>> continue to be valid over the lifetime of that release, even as chang=
es
> >>> in data structures (and hence BTF types) accrue.  Today it's not
> >>> possible to generate BTF for modules that works beyond the initial
> >>> kernel it is compiled against - kernel bugfixes etc invalidate the sp=
lit
> >>> BTF references to vmlinux BTF, and BTF is no longer usable for the
> >>> module.
> >>>
> >>> The goal of this series is to provide options to provide additional
> >>> context for cases like this.  That context comes in the form of
> >>> distilled base BTF; it stands in for the base BTF, and contains
> >>> information about the types referenced from split BTF, but not their
> >>> full descriptions.  The modified split BTF will refer to type ids in
> >>> this .BTF.base section, and when the kernel loads such modules it
> >>> will use that base BTF to map references from split BTF to the
> >>> current vmlinux BTF - a process of relocating split BTF with the
> >>> currently-running kernel's vmlinux base BTF.
> >>>
> >>> A module builder - using this series along with the pahole changes -
> >>> can then build a module with distilled base BTF via an out-of-tree
> >>> module build, i.e.
> >>>
> >>> make -C . M=3Dpath/2/module
> >>>
> >>> The module will have a .BTF section (the split BTF) and a
> >>> .BTF.base section.  The latter is small in size - distilled base
> >>> BTF does not need full struct/union/enum information for named
> >>> types for example.  For 2667 modules built with distilled base BTF,
> >>> the average size observed was 1556 bytes (stddev 1563).
> >>>
> >>> Note that for the in-tree modules, this approach is not needed as
> >>> split and base BTF in the case of in-tree modules are always built
> >>> and re-built together.
> >>>
> >>> The series first focuses on generating split BTF with distilled base
> >>> BTF, and provides btf__parse_opts() which allows specification
> >>> of the section name from which to read BTF data, since we now have
> >>> both .BTF and .BTF.base sections that can contain such data.
> >>>
> >>> Then we add support to resolve_btfids for generating the .BTF.ids
> >>> section with reference to the .BTF.base section - this ensures the
> >>> .BTF.ids match those used in the split/base BTF.
> >>>
> >>> Finally the series provides the mechanism for relocating split BTF wi=
th
> >>> a new base; the distilled base BTF is used to map the references to b=
ase
> >>> BTF in the split BTF to the new base.  For the kernel, this relocatio=
n
> >>> process happens at module load time, and we relocate split BTF
> >>> references to point at types in the current vmlinux BTF.  As part of
> >>> this, .BTF.ids references need to be mapped also.
> >>>
> >>> So concretely, what happens is
> >>>
> >>> - we generate split BTF in the .BTF section of a module that refers t=
o
> >>>   types in the .BTF.base section as base types; these are not full
> >>>   type descriptions but provide information about the base type.  So
> >>>   a STRUCT sk_buff would be represented as a FWD struct sk_buff in
> >>>   distilled base BTF for example.
> >>> - when the module is loaded, the split BTF is relocated with vmlinux
> >>>   BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_b=
uff
> >>>   in vmlinux BTF and map all split BTF references to the distilled ba=
se
> >>>   FWD sk_buff, replacing them with references to the vmlinux BTF
> >>>   STRUCT sk_buff.
> >>>
> >>> Support is also added to bpftool to be able to display split BTF
> >>> relative to its .BTF.base section, and also to display the relocated
> >>> form via the "-R path_to_base_btf".
> >>>
> >>> A previous approach to this problem [1] utilized standalone BTF for s=
uch
> >>> cases - where the BTF is not defined relative to base BTF so there is=
 no
> >>> relocation required.  The problem with that approach is that from
> >>> the verifier perspective, some types are special, and having a custom
> >>> representation of a core kernel type that did not necessarily match t=
he
> >>> current representation is not tenable.  So the approach taken here wa=
s
> >>> to preserve the split BTF model while minimizing the representation o=
f
> >>> the context needed to relocate split and current vmlinux BTF.
> >>>
> >>> To generate distilled .BTF.base sections the associated dwarves
> >>> patch (to be applied on the "next" branch there) is needed.
> >>> Without it, things will still work but bpf_testmod will not be built
> >>> with a .BTF.base section.
> >>>
> >>> Changes since RFC [2]:
> >>>
> >>> - updated terminology; we replace clunky "base reference" BTF with
> >>>   distilling base BTF into a .BTF.base section. Similarly BTF
> >>>   reconcilation becomes BTF relocation (Andrii, most patches)
> >>> - add distilled base BTF by default for out-of-tree modules
> >>>   (Alexei, patch 8)
> >>> - distill algorithm updated to record size of embedded struct/union
> >>>   by recording it as a 0-vlen STRUCT/UNION with size preserved
> >>>   (Andrii, patch 2)
> >>> - verify size match on relocation for such STRUCT/UNIONs (Andrii,
> >>>   patch 9)
> >>> - with embedded STRUCT/UNION recording size, we can have bpftool
> >>>   dump a header representation using .BTF.base + .BTF sections
> >>>   rather than special-casing and refusing to use "format c" for
> >>>   that case (patch 5)
> >>> - match enum with enum64 and vice versa (Andrii, patch 9)
> >>> - ensure that resolve_btfids works with BTF without .BTF.base
> >>>   section (patch 7)
> >>> - update tests to cover embedded types, arrays and function
> >>>   prototypes (patches 3, 12)
> >>>
> >>> One change not made yet is adding anonymous struct/unions that the sp=
lit
> >>> BTF references in base BTF to the module instead of adding them to th=
e
> >>> .BTF.base section.  That would involve having to maintain two pipes f=
or
> >>> writing BTF, one for the .BTF.base and one for the split BTF.  It wou=
ld
> >>> be possible, but there are I think some edge cases that might make it
> >>> tricky.  For example consider a split BTF reference to a base BTF
> >>> ARRAY which in turn referenced an anonymous STRUCT as type.  In such =
a
> >>> case, it wouldn't make sense to have the array in the .BTF.base secti=
on
> >>> while having the STRUCT in the module.  The general concern is that o=
nce
> >>
> >> Hm.. not really? ARRAY is a reference type (and anonymous at that), so
> >> it would have to stay in module's BTF, no? I'll go read the patch
> >> series again, but let me know if I'm missing something.
> >>
>
> The way things currently work, we preserve all relationships prior to
> distilling base BTF. That is, if a type was in split BTF prior to
> calling btf__distill_base(), it will stay in split BTF afterwards. Ditto
> for base types. This is true for reference types as well as named types.
> So in the case of the above array for example, prior to distilling types
> it is in base BTF. If it in turn then referred to a base anonymous
> struct, both would be in the base and thus the distilled base BTF. In
> the above case, I was suggesting the array itself was referred to from
> split BTF, but not in split BTF, sorry if that wasn't clearer.
>
> So the problem comes if we moved the anon struct to the module; then we
> also need to move types that depend on it there. This means we'd need to
> make the move recursive. That seems doable; the only question is around

Yep, it should be very doable. We just mark everything used from
"to-be-moved-to-new-split-BTF" types recursively, unless it's
"qualified named type", where we stop. You have a pass to mark
embedded types, here it might be another pass to mark
"used-by-split-BTF-types-but-not-distillable" types.

> the logistics and the effects of doing so. At one extreme we might end
> up with something that resembles standalone BTF (many/most types in the

My hypothesis is that it is very unlikely that there will be a lot of
types that have to be copied into split BTF.

> split BTF). That seems unlikely in most cases. I examined one module's
> BTF base for example, and the only anon structs arose from typedef
> references possible_net_t, sockptr_t, rwlock_t and atomic_t. These in
> turn were only referenced once elsewhere in distilled base BTF; a
> sockptr was in a FUNC_PROTO, but aside from that the typedefs were not
> otherwise referenced in distilled base BTF, they were referenced in
> split BTF as embeeded struct field types.
>
> So moving all of this to the split BTF seems possible; what I think we
> probably need to think on a bit is how to handle relocation.  Is there a
> need to relocate these module types too, or can we live with having
> duplicate atomic_t/sockptr_t typedefs in the module? Currently
> relocation is simplified by the fact that we only need to relocate the
> types prior to the module's start id. All we need to do is rewrite type
> references in split BTF to base ids. If we were relocating split types
> too we'd need to remove them from split BTF.

I think anything that is not in distilled base should not be
relocated, so current simplicity is remapping distilled BTF IDs will
remain. It's ok to have clones/copies of some simple typedefs,
probably.

We have a few somewhat competing goals here and we need to make a
tradeoff between them:

  a) minimizing split BTF size (or rather not making it too large)
  b) making sure PTR_TO_BTF_ID types work (so module kfuncs can accept
task_struct and others)
  c) keeping relocation simple, fast, and reliable/unambiguous

By copying anonymous types we potentially hurt a) (but presumably not
a lot to worry about), and we significantly improve c) by making
relocation simple/fast/reliably (to the extent possible with "by name"
lookups). And we (presumably) don't change b), it still works for all
existing and future cases.

If we ever need to pass anonymous typedef'ed types to kfunc, we'll
need to think how to represent them in distilled base BTF. But it most
probably won't be TYPEDEF -> STRUCT chain, but rather empty STRUCT
with the name of original TYPEDEF + some bit to specify that we are
looking for a TYPEDEF in real base BTF; I think we have a pass forward
here, and that's the main thing, but I don't think it's a problem
worth solving now (or ever).

WDYT?

>
> >>> we move a type to the module we would need to also ensure any base ty=
pes
> >>> that refer to it move there too.  For now it is I think simpler to
> >>> retain the existing split/base type classifications.
> >>
> >> We would have to finalize this part before landing, as it has big
> >> implications on the relocation process.
> >
> > Ran out of time, sorry, will continue on Monday. But please consider,
> > meanwhile, what I mentioned about only having named
> > structs/unions/enums in distilled base BTF.
> >
>
> Sure, I'll dig into it further. FWIW I agree with the goal of moving
> anonymous structs/unions if it's doable. I can't see any blocking issues
> thus far.

Yep, please give it a go, and I'll try to finish the review today, thanks.

>
> >>
> >>
> >>>
> >>> [1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire=
@oracle.com/
> >>> [2] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@o=
racle.com/
> >>>
> >>>
> >>>
> >>> Alan Maguire (13):
> >>>   libbpf: add support to btf__add_fwd() for ENUM64
> >>>   libbpf: add btf__distill_base() creating split BTF with distilled b=
ase
> >>>     BTF
> >>>   selftests/bpf: test distilled base, split BTF generation
> >>>   libbpf: add btf__parse_opts() API for flexible BTF parsing
> >>>   bpftool: support displaying raw split BTF using base BTF section as
> >>>     base
> >>>   kbuild,bpf: switch to using --btf_features for pahole v1.26 and lat=
er
> >>>   resolve_btfids: use .BTF.base ELF section as base BTF if -B option =
is
> >>>     used
> >>>   kbuild, bpf: add module-specific pahole/resolve_btfids flags for
> >>>     distilled base BTF
> >>>   libbpf: split BTF relocation
> >>>   module, bpf: store BTF base pointer in struct module
> >>>   libbpf,bpf: share BTF relocate-related code with kernel
> >>>   selftests/bpf: extend distilled BTF tests to cover BTF relocation
> >>>   bpftool: support displaying relocated-with-base split BTF
> >>>
> >>>  include/linux/btf.h                           |  32 +
> >>>  include/linux/module.h                        |   2 +
> >>>  kernel/bpf/Makefile                           |   8 +
> >>>  kernel/bpf/btf.c                              | 227 +++++--
> >>>  kernel/module/main.c                          |   5 +-
> >>>  scripts/Makefile.btf                          |  12 +-
> >>>  scripts/Makefile.modfinal                     |   4 +-
> >>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
> >>>  tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
> >>>  tools/bpf/bpftool/btf.c                       |  20 +-
> >>>  tools/bpf/bpftool/main.c                      |  14 +-
> >>>  tools/bpf/bpftool/main.h                      |   2 +
> >>>  tools/bpf/resolve_btfids/main.c               |  22 +-
> >>>  tools/lib/bpf/Build                           |   2 +-
> >>>  tools/lib/bpf/btf.c                           | 561 +++++++++++-----
> >>>  tools/lib/bpf/btf.h                           |  61 ++
> >>>  tools/lib/bpf/btf_common.c                    | 146 ++++
> >>>  tools/lib/bpf/btf_relocate.c                  | 630 ++++++++++++++++=
++
> >>>  tools/lib/bpf/libbpf.map                      |   3 +
> >>>  tools/lib/bpf/libbpf_internal.h               |   2 +
> >>>  .../selftests/bpf/prog_tests/btf_distill.c    | 298 +++++++++
> >>>  21 files changed, 1864 insertions(+), 209 deletions(-)
> >>>  create mode 100644 tools/lib/bpf/btf_common.c
> >>>  create mode 100644 tools/lib/bpf/btf_relocate.c
> >>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distil=
l.c
> >>>
> >>> --
> >>> 2.31.1
> >>>
> >


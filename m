Return-Path: <bpf+bounces-28138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B48B60DD
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEA71C21193
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6F127E2A;
	Mon, 29 Apr 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRlmc4la"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6186655
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413763; cv=none; b=JvFwGL7SzWXlKHrnJ3SwksIB+0v0dn1EdoCKiJGlScU18/TuVG/fzX18+b+37cc8vNzhXmSAGMVvJiV14z/jwUBuPPOTUBgzeVNIi3Xnr4pCs2Oc2KQ7kDBKFTxIhc0B+5phcLIOISpfSjtf53rxaISouhTwOCDfo0y3mCIEMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413763; c=relaxed/simple;
	bh=OAkT+SwWnq8VVwO2gPgZm1Is3873Er6ooHHIcuwpm14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLMCAk2zJvPGyS+TTpOSimQXcYG/h00Z3sj0YqdF7wp+wjVG6+b35ijmeqC3HQvhNzst91vq+gYzGhVHGtJ+D47Jad7RS3kvPJQc/CbG9Z4xkQw51M9okv8SDH5Loau02McGIrUBbzPhjjBttdv17o4blX6tzJUYY6E4IeezTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRlmc4la; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3751381a12.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714413761; x=1715018561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HlFNHJ5Q1zhV+p/aiU79rc+HHZskwCiIgsh7MpQCL0=;
        b=eRlmc4laz6btLYi/lBuHAS3RovlTkj1RaEdIMFU31o6eY0uu3QFh6dkocdTWFS80Q7
         KfKbMHn9dCoumVeIA8FPTZRq5p8ZaitOK0mz2CzTvyLcTanKOWG1rlxgfEm3pbhXEJIp
         o5tqKVFlrAmIC/dzS7CUFCSgT82Ep+9dHUpoq+sqY/w3fdJcKWZKwgDB99B4mb/mv7Ah
         AQk+AD8EybcYQ2W4rOXH3Whuyv+cOs090ZMVfXZngS/nHSiI58hs4MgnIkJ653VxPu5z
         SI2pURxzj7TXbQKN6M5hNXMUJsimMzoxpFSY272YwCZ7YAJ/bxrt8ZaVubjNRJEy8sDq
         Y4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714413761; x=1715018561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HlFNHJ5Q1zhV+p/aiU79rc+HHZskwCiIgsh7MpQCL0=;
        b=M4Cme9D1tGwaq+OK7i5jwYbSiiP8NHOsi+1/v3U801gsZ0EcoMh7flYpr3+sWEPMdh
         Z6PWRpgDHH9BVNOeLEHWPW7Hj8Z0f83oRce6ale+EEo9cJW48KHe2BDPtyN5q2k3M1tz
         Ae+iyE8nHOG01E3dsCoYSxkk2D2Zzk1osWQ8aLeEcPyQ/A6r2PD4pjDCLi4yUYwsPqcb
         rONToIbmmS0MVyzi/44u+z55RxX4EEhoNO3yHV7F7D6kqOJ9QsUB+XgpCtR2r2V2Oj3L
         IgLCXwBacyk/3FtD8c2ye134nA6lRkLBQbPHKA5NsOmWLmjzcYhVvMC3HgKOxD2ne6EF
         NE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUZajdinu1X4m2Gcav5H5EVq/Pi1lkmRmL/iYINyFSPu9LIJMuzkw7CbYgeCv0Tn44jjhRHZpN0JlFQ7ih/cJHjHJAV
X-Gm-Message-State: AOJu0YwhEjhlIPsFxd2oU5YInQzORHgkdeoLjG91GUD5jcGntpnhYttf
	71WuYu30xCj/DwoXKoW5sr08WEP0GxUXuKjx7OdXmO1fie9Jg60tzH2wrdQ8VFSg/JytrBtNaKM
	A9Aj2+wIWmoYgX+bu4LTu82rmQo4=
X-Google-Smtp-Source: AGHT+IF+9Pkn5P+Cw86GC1bTjbVGPQQMqFBuHuj72030wpySOV5k/o8wAka3ZRVNZ8OOq/rUKgtfNNYqH6kxzJt9690=
X-Received: by 2002:a17:90a:af97:b0:2ab:d82e:1afb with SMTP id
 w23-20020a17090aaf9700b002abd82e1afbmr10580219pjq.16.1714413760567; Mon, 29
 Apr 2024 11:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <CAEf4BzavgDXC2fM43+20wvHdXbaHRNQLWmWhtzyUh_57UYTc6Q@mail.gmail.com>
 <CAEf4BzY-P3rdV1LeJFBO_zVMn7pr+b166BOaGZEO4ZQrLdPqKA@mail.gmail.com>
 <e08937ac-c329-4a72-9a6e-8fbc36a740b5@oracle.com> <CAEf4BzZ=uMh4gW8O20-hZV1njJTAN4afQBKzFHro5A6ym-3FBg@mail.gmail.com>
 <f05afb12-5ec8-47d7-bcd6-a0d6b913b38c@oracle.com>
In-Reply-To: <f05afb12-5ec8-47d7-bcd6-a0d6b913b38c@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 11:02:28 -0700
Message-ID: <CAEf4BzY__EKpsdxqw+CiUQ=oe8CLtsVwP3nQgqTZ7eCBzxTr4w@mail.gmail.com>
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

On Mon, Apr 29, 2024 at 10:31=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 29/04/2024 18:05, Andrii Nakryiko wrote:
> > On Mon, Apr 29, 2024 at 8:25=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 27/04/2024 01:24, Andrii Nakryiko wrote:
> >>> On Fri, Apr 26, 2024 at 3:56=E2=80=AFPM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>>
> >>>> On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>>
> >>>>> Split BPF Type Format (BTF) provides huge advantages in that kernel
> >>>>> modules only have to provide type information for types that they d=
o not
> >>>>> share with the core kernel; for core kernel types, split BTF refers=
 to
> >>>>> core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
> >>>>> uses that structure (or a pointer to it) simply needs to refer to t=
he
> >>>>> core kernel type id, saving the need to define the structure and it=
s many
> >>>>> dependents.  This cuts down on duplication and makes BTF as compact
> >>>>> as possible.
> >>>>>
> >>>>> However, there is a downside.  This scheme requires the references =
from
> >>>>> split BTF to base BTF to be valid not just at encoding time, but at=
 use
> >>>>> time (when the module is loaded).  Even a small change in kernel ty=
pes
> >>>>> can perturb the type ids in core kernel BTF, and due to pahole's
> >>>>> parallel processing of compilation units, even an unchanged kernel =
can
> >>>>> have different type ids if BTF is re-generated.  So we have a robus=
tness
> >>>>> problem for split BTF for cases where a module is not always compil=
ed at
> >>>>> the same time as the kernel.  This problem is particularly acute fo=
r
> >>>>> distros which generally want module builders to be able to compile =
a
> >>>>> module for the lifetime of a Linux stable-based release, and have i=
t
> >>>>> continue to be valid over the lifetime of that release, even as cha=
nges
> >>>>> in data structures (and hence BTF types) accrue.  Today it's not
> >>>>> possible to generate BTF for modules that works beyond the initial
> >>>>> kernel it is compiled against - kernel bugfixes etc invalidate the =
split
> >>>>> BTF references to vmlinux BTF, and BTF is no longer usable for the
> >>>>> module.
> >>>>>
> >>>>> The goal of this series is to provide options to provide additional
> >>>>> context for cases like this.  That context comes in the form of
> >>>>> distilled base BTF; it stands in for the base BTF, and contains
> >>>>> information about the types referenced from split BTF, but not thei=
r
> >>>>> full descriptions.  The modified split BTF will refer to type ids i=
n
> >>>>> this .BTF.base section, and when the kernel loads such modules it
> >>>>> will use that base BTF to map references from split BTF to the
> >>>>> current vmlinux BTF - a process of relocating split BTF with the
> >>>>> currently-running kernel's vmlinux base BTF.
> >>>>>
> >>>>> A module builder - using this series along with the pahole changes =
-
> >>>>> can then build a module with distilled base BTF via an out-of-tree
> >>>>> module build, i.e.
> >>>>>
> >>>>> make -C . M=3Dpath/2/module
> >>>>>
> >>>>> The module will have a .BTF section (the split BTF) and a
> >>>>> .BTF.base section.  The latter is small in size - distilled base
> >>>>> BTF does not need full struct/union/enum information for named
> >>>>> types for example.  For 2667 modules built with distilled base BTF,
> >>>>> the average size observed was 1556 bytes (stddev 1563).
> >>>>>
> >>>>> Note that for the in-tree modules, this approach is not needed as
> >>>>> split and base BTF in the case of in-tree modules are always built
> >>>>> and re-built together.
> >>>>>
> >>>>> The series first focuses on generating split BTF with distilled bas=
e
> >>>>> BTF, and provides btf__parse_opts() which allows specification
> >>>>> of the section name from which to read BTF data, since we now have
> >>>>> both .BTF and .BTF.base sections that can contain such data.
> >>>>>
> >>>>> Then we add support to resolve_btfids for generating the .BTF.ids
> >>>>> section with reference to the .BTF.base section - this ensures the
> >>>>> .BTF.ids match those used in the split/base BTF.
> >>>>>
> >>>>> Finally the series provides the mechanism for relocating split BTF =
with
> >>>>> a new base; the distilled base BTF is used to map the references to=
 base
> >>>>> BTF in the split BTF to the new base.  For the kernel, this relocat=
ion
> >>>>> process happens at module load time, and we relocate split BTF
> >>>>> references to point at types in the current vmlinux BTF.  As part o=
f
> >>>>> this, .BTF.ids references need to be mapped also.
> >>>>>
> >>>>> So concretely, what happens is
> >>>>>
> >>>>> - we generate split BTF in the .BTF section of a module that refers=
 to
> >>>>>   types in the .BTF.base section as base types; these are not full
> >>>>>   type descriptions but provide information about the base type.  S=
o
> >>>>>   a STRUCT sk_buff would be represented as a FWD struct sk_buff in
> >>>>>   distilled base BTF for example.
> >>>>> - when the module is loaded, the split BTF is relocated with vmlinu=
x
> >>>>>   BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk=
_buff
> >>>>>   in vmlinux BTF and map all split BTF references to the distilled =
base
> >>>>>   FWD sk_buff, replacing them with references to the vmlinux BTF
> >>>>>   STRUCT sk_buff.
> >>>>>
> >>>>> Support is also added to bpftool to be able to display split BTF
> >>>>> relative to its .BTF.base section, and also to display the relocate=
d
> >>>>> form via the "-R path_to_base_btf".
> >>>>>
> >>>>> A previous approach to this problem [1] utilized standalone BTF for=
 such
> >>>>> cases - where the BTF is not defined relative to base BTF so there =
is no
> >>>>> relocation required.  The problem with that approach is that from
> >>>>> the verifier perspective, some types are special, and having a cust=
om
> >>>>> representation of a core kernel type that did not necessarily match=
 the
> >>>>> current representation is not tenable.  So the approach taken here =
was
> >>>>> to preserve the split BTF model while minimizing the representation=
 of
> >>>>> the context needed to relocate split and current vmlinux BTF.
> >>>>>
> >>>>> To generate distilled .BTF.base sections the associated dwarves
> >>>>> patch (to be applied on the "next" branch there) is needed.
> >>>>> Without it, things will still work but bpf_testmod will not be buil=
t
> >>>>> with a .BTF.base section.
> >>>>>
> >>>>> Changes since RFC [2]:
> >>>>>
> >>>>> - updated terminology; we replace clunky "base reference" BTF with
> >>>>>   distilling base BTF into a .BTF.base section. Similarly BTF
> >>>>>   reconcilation becomes BTF relocation (Andrii, most patches)
> >>>>> - add distilled base BTF by default for out-of-tree modules
> >>>>>   (Alexei, patch 8)
> >>>>> - distill algorithm updated to record size of embedded struct/union
> >>>>>   by recording it as a 0-vlen STRUCT/UNION with size preserved
> >>>>>   (Andrii, patch 2)
> >>>>> - verify size match on relocation for such STRUCT/UNIONs (Andrii,
> >>>>>   patch 9)
> >>>>> - with embedded STRUCT/UNION recording size, we can have bpftool
> >>>>>   dump a header representation using .BTF.base + .BTF sections
> >>>>>   rather than special-casing and refusing to use "format c" for
> >>>>>   that case (patch 5)
> >>>>> - match enum with enum64 and vice versa (Andrii, patch 9)
> >>>>> - ensure that resolve_btfids works with BTF without .BTF.base
> >>>>>   section (patch 7)
> >>>>> - update tests to cover embedded types, arrays and function
> >>>>>   prototypes (patches 3, 12)
> >>>>>
> >>>>> One change not made yet is adding anonymous struct/unions that the =
split
> >>>>> BTF references in base BTF to the module instead of adding them to =
the
> >>>>> .BTF.base section.  That would involve having to maintain two pipes=
 for
> >>>>> writing BTF, one for the .BTF.base and one for the split BTF.  It w=
ould
> >>>>> be possible, but there are I think some edge cases that might make =
it
> >>>>> tricky.  For example consider a split BTF reference to a base BTF
> >>>>> ARRAY which in turn referenced an anonymous STRUCT as type.  In suc=
h a
> >>>>> case, it wouldn't make sense to have the array in the .BTF.base sec=
tion
> >>>>> while having the STRUCT in the module.  The general concern is that=
 once
> >>>>
> >>>> Hm.. not really? ARRAY is a reference type (and anonymous at that), =
so
> >>>> it would have to stay in module's BTF, no? I'll go read the patch
> >>>> series again, but let me know if I'm missing something.
> >>>>
> >>
> >> The way things currently work, we preserve all relationships prior to
> >> distilling base BTF. That is, if a type was in split BTF prior to
> >> calling btf__distill_base(), it will stay in split BTF afterwards. Dit=
to
> >> for base types. This is true for reference types as well as named type=
s.
> >> So in the case of the above array for example, prior to distilling typ=
es
> >> it is in base BTF. If it in turn then referred to a base anonymous
> >> struct, both would be in the base and thus the distilled base BTF. In
> >> the above case, I was suggesting the array itself was referred to from
> >> split BTF, but not in split BTF, sorry if that wasn't clearer.
> >>
> >> So the problem comes if we moved the anon struct to the module; then w=
e
> >> also need to move types that depend on it there. This means we'd need =
to
> >> make the move recursive. That seems doable; the only question is aroun=
d
> >
> > Yep, it should be very doable. We just mark everything used from
> > "to-be-moved-to-new-split-BTF" types recursively, unless it's
> > "qualified named type", where we stop. You have a pass to mark
> > embedded types, here it might be another pass to mark
> > "used-by-split-BTF-types-but-not-distillable" types.
> >
> >> the logistics and the effects of doing so. At one extreme we might end
> >> up with something that resembles standalone BTF (many/most types in th=
e
> >
> > My hypothesis is that it is very unlikely that there will be a lot of
> > types that have to be copied into split BTF.
> >
> >> split BTF). That seems unlikely in most cases. I examined one module's
> >> BTF base for example, and the only anon structs arose from typedef
> >> references possible_net_t, sockptr_t, rwlock_t and atomic_t. These in
> >> turn were only referenced once elsewhere in distilled base BTF; a
> >> sockptr was in a FUNC_PROTO, but aside from that the typedefs were not
> >> otherwise referenced in distilled base BTF, they were referenced in
> >> split BTF as embeeded struct field types.
> >>
> >> So moving all of this to the split BTF seems possible; what I think we
> >> probably need to think on a bit is how to handle relocation.  Is there=
 a
> >> need to relocate these module types too, or can we live with having
> >> duplicate atomic_t/sockptr_t typedefs in the module? Currently
> >> relocation is simplified by the fact that we only need to relocate the
> >> types prior to the module's start id. All we need to do is rewrite typ=
e
> >> references in split BTF to base ids. If we were relocating split types
> >> too we'd need to remove them from split BTF.
> >
> > I think anything that is not in distilled base should not be
> > relocated, so current simplicity is remapping distilled BTF IDs will
> > remain. It's ok to have clones/copies of some simple typedefs,
> > probably.
> >
> > We have a few somewhat competing goals here and we need to make a
> > tradeoff between them:
> >
> >   a) minimizing split BTF size (or rather not making it too large)
> >   b) making sure PTR_TO_BTF_ID types work (so module kfuncs can accept
> > task_struct and others)
> >   c) keeping relocation simple, fast, and reliable/unambiguous
> >
> > By copying anonymous types we potentially hurt a) (but presumably not
> > a lot to worry about), and we significantly improve c) by making
> > relocation simple/fast/reliably (to the extent possible with "by name"
> > lookups). And we (presumably) don't change b), it still works for all
> > existing and future cases.
> >
>
> Yeah, case b) is the only lingering concern I have, but in practice it
> seems unlikely to arise. One point of clarification - we've discussed so
> far mostly anonymous STRUCTs and UNIONs; do you think there are other
> anonymous types we should consider, ARRAYs for example?

Everything is technically possible, but I'd be surprised if anything
but STRUCT/UNION is referred to by PTR_TO_BTF_ID for kfunc. But let's
get there first.

> > If we ever need to pass anonymous typedef'ed types to kfunc, we'll
> > need to think how to represent them in distilled base BTF. But it most
> > probably won't be TYPEDEF -> STRUCT chain, but rather empty STRUCT
> > with the name of original TYPEDEF + some bit to specify that we are
> > looking for a TYPEDEF in real base BTF; I think we have a pass forward
> > here, and that's the main thing, but I don't think it's a problem
> > worth solving now (or ever).
> >
> > WDYT?
>
> Agreed. I think (hope) it's unlikely to arise.
>
> >
> >>
> >>>>> we move a type to the module we would need to also ensure any base =
types
> >>>>> that refer to it move there too.  For now it is I think simpler to
> >>>>> retain the existing split/base type classifications.
> >>>>
> >>>> We would have to finalize this part before landing, as it has big
> >>>> implications on the relocation process.
> >>>
> >>> Ran out of time, sorry, will continue on Monday. But please consider,
> >>> meanwhile, what I mentioned about only having named
> >>> structs/unions/enums in distilled base BTF.
> >>>
> >>
> >> Sure, I'll dig into it further. FWIW I agree with the goal of moving
> >> anonymous structs/unions if it's doable. I can't see any blocking issu=
es
> >> thus far.
> >
> > Yep, please give it a go, and I'll try to finish the review today, than=
ks.
> >
> >>
> >>>>
> >>>>
> >>>>>
> >>>>> [1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.magui=
re@oracle.com/
> >>>>> [2] https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire=
@oracle.com/
> >>>>>
> >>>>>
> >>>>>
> >>>>> Alan Maguire (13):
> >>>>>   libbpf: add support to btf__add_fwd() for ENUM64
> >>>>>   libbpf: add btf__distill_base() creating split BTF with distilled=
 base
> >>>>>     BTF
> >>>>>   selftests/bpf: test distilled base, split BTF generation
> >>>>>   libbpf: add btf__parse_opts() API for flexible BTF parsing
> >>>>>   bpftool: support displaying raw split BTF using base BTF section =
as
> >>>>>     base
> >>>>>   kbuild,bpf: switch to using --btf_features for pahole v1.26 and l=
ater
> >>>>>   resolve_btfids: use .BTF.base ELF section as base BTF if -B optio=
n is
> >>>>>     used
> >>>>>   kbuild, bpf: add module-specific pahole/resolve_btfids flags for
> >>>>>     distilled base BTF
> >>>>>   libbpf: split BTF relocation
> >>>>>   module, bpf: store BTF base pointer in struct module
> >>>>>   libbpf,bpf: share BTF relocate-related code with kernel
> >>>>>   selftests/bpf: extend distilled BTF tests to cover BTF relocation
> >>>>>   bpftool: support displaying relocated-with-base split BTF
> >>>>>
> >>>>>  include/linux/btf.h                           |  32 +
> >>>>>  include/linux/module.h                        |   2 +
> >>>>>  kernel/bpf/Makefile                           |   8 +
> >>>>>  kernel/bpf/btf.c                              | 227 +++++--
> >>>>>  kernel/module/main.c                          |   5 +-
> >>>>>  scripts/Makefile.btf                          |  12 +-
> >>>>>  scripts/Makefile.modfinal                     |   4 +-
> >>>>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
> >>>>>  tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
> >>>>>  tools/bpf/bpftool/btf.c                       |  20 +-
> >>>>>  tools/bpf/bpftool/main.c                      |  14 +-
> >>>>>  tools/bpf/bpftool/main.h                      |   2 +
> >>>>>  tools/bpf/resolve_btfids/main.c               |  22 +-
> >>>>>  tools/lib/bpf/Build                           |   2 +-
> >>>>>  tools/lib/bpf/btf.c                           | 561 +++++++++++---=
--
> >>>>>  tools/lib/bpf/btf.h                           |  61 ++
> >>>>>  tools/lib/bpf/btf_common.c                    | 146 ++++
> >>>>>  tools/lib/bpf/btf_relocate.c                  | 630 ++++++++++++++=
++++
> >>>>>  tools/lib/bpf/libbpf.map                      |   3 +
> >>>>>  tools/lib/bpf/libbpf_internal.h               |   2 +
> >>>>>  .../selftests/bpf/prog_tests/btf_distill.c    | 298 +++++++++
> >>>>>  21 files changed, 1864 insertions(+), 209 deletions(-)
> >>>>>  create mode 100644 tools/lib/bpf/btf_common.c
> >>>>>  create mode 100644 tools/lib/bpf/btf_relocate.c
> >>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_dist=
ill.c
> >>>>>
> >>>>> --
> >>>>> 2.31.1
> >>>>>
> >>>


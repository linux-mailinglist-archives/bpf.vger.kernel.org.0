Return-Path: <bpf+bounces-12110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ABC7C7ACD
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 02:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076FFB20988
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C43376;
	Fri, 13 Oct 2023 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQV/ei/P"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E3360
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 00:23:13 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3CC0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:23:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso2919958a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697156589; x=1697761389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2500ayuvodFvnhUUHUTReuiIK+/I4S52tDRKOP130k=;
        b=JQV/ei/POEbr5Ky35tgELE6ZKw5CF1fl9uH76PBHAYpKIJZ3GXE3iT2XSw6yuvZ9fU
         ynyKBCiAVIheN4uRmofSpgZB7iO3L/1v3Da3cCE+oxK/42uCecSr8QlEnLZ9pDo5zO+W
         nrsyMb5uDrw9ZvTOcvmX3DoyiAD+I/KOuInHmXjZruH8apCwDp2dsOygBs6OSerbdA9l
         na/6hhO3G5Zer/qHSJym3ulgG7WiO4fFIG0B5RX6Hl+YJs+uR/+qUYaqonlzdm3fEcml
         QlJh4a+c4yUGAhoWeVaeBpqEQBV77Pohj1aCzYlegVogBWEcKaNLSZmjRsOYTUlRX/XF
         1hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697156589; x=1697761389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2500ayuvodFvnhUUHUTReuiIK+/I4S52tDRKOP130k=;
        b=dkqIZpdMvNdlZW463TmCHPR5yXNvMIzc9pyXbgMnYCkXSb90RQvqRH/olMVFzXjhQY
         bmR6oRpOIlICYCRU5xvom2iS2y7wkCkedlxFTZ3XVZdOnMMgiEUnM8+bxYrIyJzwuaPQ
         9rWuEy7DijZXeX1Spcgj+v34ecWJOFbGPUqHiag4/+oos/ZIdTvMMmSXL5Joe9SlZBZ2
         luD6e3mBVv2cnomdRd2NcYbzlkk8c9rUYNN+unkpIYw/RVF00YHdd2GPXh9pTpgzTEVk
         rQ3cR8oALi57iu/1ToFF1oNatvEXSCwcweYM70Z7X8WjY/HRzaLfX8NPhVegBdQ3VLTk
         K5DA==
X-Gm-Message-State: AOJu0Ywxusd20LHmqe73gvZv5a4acn1qKVBTQKNdCZjACGhPByj3PtOz
	aJdKB4kctwTVCXw51Cqp2cL+gY8TlkMosAzxiVI=
X-Google-Smtp-Source: AGHT+IGQkg8vaYz/h/Pnpv6MGtvivG3lr5AnAce+V+II4iWoBFsGObGlBSgN/lrLUSsFe13KRf75f76v85B1t7cj9XY=
X-Received: by 2002:a05:6402:26d4:b0:53e:343a:76c4 with SMTP id
 x20-20020a05640226d400b0053e343a76c4mr981100edd.30.1697156589239; Thu, 12 Oct
 2023 17:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913142646.190047-1-alan.maguire@oracle.com>
 <CAEf4BzayTrNnOLj4t2s1aegATjqMdvz1iiGq4A6gMmbxJ+zmYg@mail.gmail.com>
 <7e941212-7a2e-5878-6396-cdc6ec39d8be@oracle.com> <CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9YTWchqoYLbg@mail.gmail.com>
 <1f8485ea-1d0b-dfcb-6b18-c51235bb8ffb@oracle.com>
In-Reply-To: <1f8485ea-1d0b-dfcb-6b18-c51235bb8ffb@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 17:22:58 -0700
Message-ID: <CAEf4BzaO9HsADcc74A45+GNTqajm40bQ+ofP_LBmCzAjEtRa=g@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/3] dwarves: detect BTF kinds supported by kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 2:27=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 19/09/2023 19:58, Andrii Nakryiko wrote:
> > On Tue, Sep 19, 2023 at 9:30=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 14/09/2023 18:58, Andrii Nakryiko wrote:
> >>> On Wed, Sep 13, 2023 at 7:26=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> >>>>
> >>>> When a newer pahole is run on an older kernel, it often knows about =
BTF
> >>>> kinds that the kernel does not support, and adds them to the BTF
> >>>> representation.  This is a problem because the BTF generated is then
> >>>> embedded in the kernel image.  When it is later read - possibly by
> >>>> a different older toolchain or by the kernel directly - it is not us=
able.
> >>>>
> >>>> The scripts/pahole-flags.sh script enumerates the various pahole opt=
ions
> >>>> available associated with various versions of pahole, but in the cas=
e
> >>>> of an older kernel is the set of BTF kinds the _kernel_ can handle t=
hat
> >>>> is of more importance.
> >>>>
> >>>> Because recent features such as BTF_KIND_ENUM64 are added by default
> >>>> (and only skipped if --skip_encoding_btf_* is set), BTF will be
> >>>> created with these newer kinds that the older kernel cannot read.
> >>>> This can be (and has been) fixed by stable-backporting --skip option=
s,
> >>>> but this is cumbersome and would have to be done every time a new BT=
F kind
> >>>> is introduced.
> >>>>
> >>>
> >>> Yes, this is indeed the problem, but I don't think any sort of auto
> >>> detection by pahole itself of what is the BTF_KIND_MAX is the best
> >>> solution. Sometimes new features are added to existing kinds (like
> >>> kflag usage, etc), and that will still break even with "auto
> >>> detection".
> >>>
> >>> I think the solution is to design pahole behavior in such a way that
> >>> it allows full control for old kernels to specify which BTF features
> >>> are expected to be generated, while also allowing to default to all
> >>> the latest and greatest BTF features by default for any other
> >>> application.
> >>>
> >>> So, how about something like the following. By default, pahole
> >>> generates all the BTF features it knows about. But we add a new flag
> >>> that says to stay conservative and only generate a specified subset o=
f
> >>> BTF features. E.g.:
> >>>
> >>> 1) `pahole -J <eLF.o>`  will generate everything
> >>>
> >>> 2) `pahole -J <elf.o> --btf_feature=3Dbasic` will generate only the v=
ery
> >>> basic stuff (we can decide what constitutes basic, we can go all the
> >>> way to before we added variables, or can pick any random state after
> >>> that)
> >>>
> >>> 3) `pahole -J <elf.o> --btf_feature=3Dbasic --btf_feature=3Denum64
> >>> --btf_feature=3Dfancy_funcs` will generate only requested bits.
> >>>
> >>> We can have --btf_feature=3Dall as a convenience as well, but kernel
> >>> scripts won't use it.
> >>>
> >>> From the very beginning, pahole should not fail with a feature name
> >>> that it doesn't recognize, though (maybe emit a warning, don't know).
> >>> So that kernel-side scripts can be simpler: when kernel starts to
> >>> recognize some new BTF functionality, we just unconditionally add
> >>> another `--btf_feature=3D<something>`. And that works starting from t=
he
> >>> first pahole version that supports this `--btf_feature` flag.
> >>>
> >>
> >> The idea of a BTF feature flag set - not restricted to BTF kinds -
> >
> > so what about not trying to auto-detect anything and let kernel
> > strictly opt into BTF functionality it expects from pahole and
> > recognizes?
> >
> >> is a good one. I think it should be in the UAPI also though
> >> as "enum btf_features". A set of bitmask values - probably closely
> >> mirroring the FEAT_BTF* . Something like this perhaps:
> >>
> >> enum btf_features {
> >>         BTF_FEATURE_BASIC       =3D       0x1,    /* _FUNC, _FUNC_PROT=
O */
> >>         BTF_FEATURE_DATASEC     =3D       0x2,    /* _VAR, _DATASEC */
> >>
> >> ..etc. A bitmask value would also be amenable to inclusion in
> >> an updated struct btf_header.
> >
> > I don't know if I agree to add this to UAPI. It seems like an
> > overkill, and it also raises a question of "what is a feature"? Any
> > tiny addition, extension, etc could be considered a feature and we'll
> > end up using all the bits very soon. With self-describing btf_type
> > sizes, tools should be able to skip BTF types they don't recognize.
> > And if there is some fancy kflag usage within an old BTF KIND, for
> > example, then it will be up to the application to either complain,
> > skip, or ignore. E.g., bpftool should try to emit all possible
> > information during bpftool btf dump, even if it doesn't recognize a
> > particular flag or enum.
> >
>
> Based on the above, I've put together an RFC implementing a
>
> --btf_features=3Dfeature1[,feature2]
>
> ...parameter for pahole [1]. I _think_ it's roughly what you've
> described above, and I think it has the characteristics we need
> to simplify scripts/pahole-flags.sh (features are opt-in, no
> complaints on unrecognized features) such that we'll only
> need one more version-check clause, something like this:
>
> if [ "${pahole_ver}" -ge "126" ]; then
>         extra_pahole_opt=3D"-j --lang_exclude=3Drust
> --btf_features=3Dencode_force,var,float,decl_tag,type_tag,enum64,optimize=
d,consistent"
> fi
>
> New features would simply be added to the list above without a
> version check requirement and ignored for pahole versions that
> don't support them.

Yes, that's the hope. I left a few comments, I think this looks great
overall, thanks!

>
> I'll follow up with the kind layout/crc stuff once we converge on
> how we want to handle new BTF features. Thanks!

Makes sense, and I think we have converged :)

>
> Alan
>
> [1]
> https://lore.kernel.org/bpf/20231011091732.93254-1-alan.maguire@oracle.co=
m/
>
> >>
> >> So at BTF encoding time - if we support the newer header - we could
> >> add the feature set supported by the BTF encoding along with CRCs.
> >> That would be useful for tools - for example if bpftool encounters
> >> features it doesn't support in BTF it is trying to parse, it can
> >> complain upfront. Ditto for libbpf.
> >>
> >> With respect to the kind layout support, it probably isn't worth it.
> >> It would be a tax on every BTF encoding, and it only helps with
> >> parsing - as opposed to using - newer BTF features. As long as
> >> we can guarantee that a kernel doesn't wind up with BTF features
> >> it doesn't support in vmlinux/module BTF, I think that's enough.
> >>
> >> Alan
> >>
> >>>
> >>> All this cleverness in trying to guess what kernel supports and what
> >>> not (without actually running the kernel and feature-testing) will
> >>> just come biting us later on. This never works reliably.
> >>>
> >>>
> >>>> So this series attempts to detect the BTF kinds supported by the
> >>>> kernel/modules so that this can inform BTF encoding for older
> >>>> kernels.  We look for BTF_KIND_MAX - either as an enumerated value
> >>>> in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinux
> >>>> BTF (patch 3).  Knowing this prior to encoding BTF allows us to spec=
ify
> >>>> skip_encoding options to avoid having BTF with kinds the kernel itse=
lf
> >>>> will not understand.
> >>>>
> >>>> The aim is to minimize pain for older stable kernels when new BTF
> >>>> kinds are introduced.  Kind encoding [1] can solve the parsing probl=
em
> >>>> with BTF, but this approach is intended to ensure generated BTF is
> >>>> usable when newer pahole runs on older kernels.
> >>>>
> >>>> This approach requires BTF kinds to be defined via an enumerated typ=
e,
> >>>> which happened for 5.16 and later.  Older kernels than this used #de=
fines
> >>>> so the approach will only work for 5.16 stable kernels and later cur=
rently.
> >>>>
> >>>> With this change in hand, adding new BTF kinds becomes a bit simpler=
,
> >>>> at least for the user of pahole.  All that needs to be done is to ad=
d
> >>>> internal "skip_new_kind" booleans to struct conf_load and set them
> >>>> in dwarves__set_btf_kind_max() if the detected maximum kind is less
> >>>> than the kind in question - in other words, if the kernel does not k=
now
> >>>> about that kind.  In that case, we will not use it in encoding.
> >>>>
> >>>> The approach was tested on Linux 5.16 as released, i.e. prior to the
> >>>> backports adding --skip_encoding logic, and the BTF generated did no=
t
> >>>> contain kinds > BTF_KIND_MAX for the kernel (corresponding to
> >>>> BTF_KIND_DECL_TAG in that case).
> >>>>
> >>>> Changes since RFC [2]:
> >>>>  - added --skip_autodetect_btf_kind_max to disable kind autodetectio=
n
> >>>>    (Jiri, patch 2)
> >>>>
> >>>> [1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire=
@oracle.com/
> >>>> [2] https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguire=
@oracle.com/
> >>>>
> >>>> Alan Maguire (3):
> >>>>   dwarves: auto-detect maximum kind supported by vmlinux
> >>>>   pahole: add --skip_autodetect_btf_kind_max to disable kind autodet=
ect
> >>>>   btf_encoder: learn BTF_KIND_MAX value from base BTF when generatin=
g
> >>>>     split BTF
> >>>>
> >>>>  btf_encoder.c      | 37 +++++++++++++++++++++++++++++++++
> >>>>  btf_encoder.h      |  2 ++
> >>>>  dwarf_loader.c     | 52 +++++++++++++++++++++++++++++++++++++++++++=
+++
> >>>>  dwarves.h          |  3 +++
> >>>>  man-pages/pahole.1 |  4 ++++
> >>>>  pahole.c           | 10 +++++++++
> >>>>  6 files changed, 108 insertions(+)
> >>>>
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>


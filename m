Return-Path: <bpf+bounces-75957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46457C9E6CB
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 10:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51A194E1763
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD02D7DE1;
	Wed,  3 Dec 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcb4hee3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A232D661D
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753279; cv=none; b=att8tTYqGU8hk+GYTRkckFZGurOJwLK/h14E2zGkjuNGzkhl7cVwYD9d0FOLwkdTLlDfs5/JTa2TFnYQsUUpQ+Vz/qA3iXDxnL1xJXiHIKpguRzoaKcETVChC/Muu/+qdWwm+DsxL1ymOfdb6TVf20s3pVBPhi5PcwLLeRAdnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753279; c=relaxed/simple;
	bh=ut8HRGOgivsoB0kx50pHLVq+z8gVE0mBBi4b9ppr2Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJBoOUswkXOblDXO6+8gqWKl1cKP3sMOs8Vc4sI1mU0BEMy/ph7WXUiKVFqsNcQQb+9/hw2K3mACK1Dcw2WnofmBYAoYozon4USx4zy/gMYm95oAQg+maF7JjNnLlvVW0pAaFQhlDgzR91iFjaG/hdDq3RRdv6d9GA17NgKCur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcb4hee3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so4379715a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 01:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753275; x=1765358075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jykVF6C50DofBVWNGtAsaNOhzMdnpnwN579zp18tvo=;
        b=Jcb4hee3i6RMrNEDL6FgKEL6kgpTWTzI3E8xdGmh0v+9Kl0kFeS8U+YFkS5z6vjvqd
         9JJuhPBYi6bcqE3OAH+LCw8JZn8AYFkFj6t6a32Ohvw+QRxiCd4cmTO7ITNDncY7pZ1N
         ybL3J22pdhas7ltWIC6eN97d0a1t9pejZpd2EQlaMQMdp+53yk3Do5U80p92+jOoXJEd
         QMVV9cCOqAJnbYZdhzyWGqCtJNf7gxp7SE9HQ0zsksGneqDsuyzasENf+kmttR/Bbji7
         WLWrvNa7GBZFs7USsx3yWy2CmPe4x1DxZagWFD9cBAqZ7cFnP9lQ+2m9L0QHD7LQeJOO
         CSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753275; x=1765358075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jykVF6C50DofBVWNGtAsaNOhzMdnpnwN579zp18tvo=;
        b=vjlQH8hOQUO9NxytVi8BWulQWFsZfghP4DYqkHBfowQhwJ+CEyjYBr2qvJafXFzGxQ
         bFT7vMk4s6b+v6a1TaYlJQqRm7vD5WPXSjjXOKmg5re3H0S7EaMn3C/74ZmQQzTu0yvN
         dj3mZYZCNR+6bz2zYk2zsVhWZJY4ZypqXdHVBhwaKTIhGLOKqTKoi+LNLrMSAvH3Yjkx
         P1936yGddQu6goZrKOBwf+kNLUxBo+GDMrPXUg+0r97ttPSDrbNR7E4APh3pITrgiprc
         lxSIUh9NiVlJNzTWCKhbTYvMtMGf6aYME9kaHWuBhaHi0vyZbOuQzWIb9bnyLwyuf2Wj
         JU7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFtHSZfsWFJCxjN5URQlfmEl+4YAx4Nzaq7l/Ub2eiWAAlYoTzy7vcY7LJaze0L5iFtGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QbBWveSWFk0bfZWWqrxnm4IYFEFLtZ4Ti/VY6IsZ18lrMmH8
	0IukAU2WBMomM/sfQOD263lQTieCkbO8koB5kg7HFB9I/HPw/hu69tvbSYIXDo8qm+wleS07M/H
	ILgPWSaamIkXZqteKFMV74aqpnUggL3w=
X-Gm-Gg: ASbGncsmdxdFnDHNl4di9HAz152u4qXJE8vkKaQdvNBfYNIwau6nADud5BpAb59FS7z
	OSxgMH7czgqg8YFMKMAg4tygkRPpOL8WAiY29OVXtscUqkMveae2Q2CB4XOXkgA1irwEgZe+Vbc
	8yJGEPWcI6bpW417bveToPJOu16fOUH/cbHt9sgXaAaALCmfb4ZzMOGRN1N4Dg6KMi1MN/c8LSQ
	hzQWbMvtjbZH4xbetm4LYfLjlJFe7NNE4fsqvRR4d9GH1HwW4gxsTC8o1x9zt8N+rOWzwrH
X-Google-Smtp-Source: AGHT+IEbr04sJVE4nvZUHZmXCNQkR/JZubmHYKe97g98UhmUP9Gb2cZrjPJlhUbKu9YMF0LyXfxhYRMYX4mSKvhJRSI=
X-Received: by 2002:a17:906:f58f:b0:b73:6998:7bce with SMTP id
 a640c23a62f3a-b79dc51b194mr158113566b.33.1764753274848; Wed, 03 Dec 2025
 01:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev> <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
 <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev> <642f6b68-0691-44a1-844f-a8cddec41fd0@linux.dev>
 <CAErzpmsoeFJBhqXZF1ttUCDx5HSFVawdiVfsG2vWSOq4DBBruQ@mail.gmail.com> <1175fe21-5c0b-4680-8fa7-55d22e4bcaca@linux.dev>
In-Reply-To: <1175fe21-5c0b-4680-8fa7-55d22e4bcaca@linux.dev>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 3 Dec 2025 17:14:21 +0800
X-Gm-Features: AWmQ_bmZ6kzjhxdhvzeaKJNPMi5MeEsvJ8QRRB3ITcKG_ofOlcKUeWSpxKEpwtc
Message-ID: <CAErzpms1hg=6JZJMRLK6gNsSZDeBbz-4RmUfU6aSf8J281QSwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:01=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 12/1/25 6:01 PM, Donglin Peng wrote:
> > On Tue, Dec 2, 2025 at 3:46=E2=80=AFAM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >>
> >> On 11/27/25 9:52 PM, Ihor Solodrai wrote:
> >>> On 11/27/25 7:20 PM, Donglin Peng wrote:
> >>>> On Fri, Nov 28, 2025 at 2:53=E2=80=AFAM Ihor Solodrai <ihor.solodrai=
@linux.dev> wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/s=
elftests/bpf/Makefile
> >>>>> index bac22265e7ff..ec7e2a7721c7 100644
> >>>>> --- a/tools/testing/selftests/bpf/Makefile
> >>>>> +++ b/tools/testing/selftests/bpf/Makefile
> >>>>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
> >>>>>  include ../../../scripts/Makefile.include
> >>>>>
> >>>>>  CXX ?=3D $(CROSS_COMPILE)g++
> >>>>> +OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> >>>>>
> >>>>>  CURDIR :=3D $(abspath .)
> >>>>>  TOOLSDIR :=3D $(abspath ../../..)
> >>>>> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OB=
JS)                  \
> >>>>>         $$(call msg,BINARY,,$$@)
> >>>>>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(=
LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> >>>>>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.=
o $$@
> >>>>> +       $(Q)if [ -f $$@.btf_ids ]; then \
> >>>>> +               $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids =
$$@; \
> >>>>
> >>>> I encountered a resolve_btfids self-test failure when enabling the
> >>>> BTF sorting feature, with the following error output:
> >>>>
> >>>> All error logs:
> >>>> resolve_symbols:PASS:resolve 0 nsec
> >>>> test_resolve_btfids:PASS:id_check 0 nsec
> >>>> test_resolve_btfids:PASS:id_check 0 nsec
> >>>> test_resolve_btfids:FAIL:id_check wrong ID for T (7 !=3D 5)
> >>>> #369     resolve_btfids:FAIL
> >>>>
> >>>> The root cause is that prog_tests/resolve_btfids.c retrieves type ID=
s
> >>>> from btf_data.bpf.o and compares them against the IDs in test_progs.
> >>>> However, while the IDs in test_progs are sorted, those in btf_data.b=
pf.o
> >>>> remain in their original unsorted state, causing the validation to f=
ail.
> >>>>
> >>>> This presents two potential solutions:
> >>>> 1. Update the relevant .BTF.* section datas in btf_data.bpf.o, inclu=
ding
> >>>>     the .BTF and .BTF.ext sections
> >>>> 2. Modify prog_tests/resolve_btfids.c to retrieve IDs from test_prog=
s.btf
> >>>>     instead. However, I discovered that test_progs.btf is deleted in=
 the
> >>>>     subsequent code section.
> >>>>
> >>>> What do you think of it?
> >>>
> >>> Within resolve_btfids it's clear that we have to update (sort in this
> >>> case) BTF first, and then resolve the ids based on the changed BTF.
> >>>
> >>> As for the test, we should probably change it to become closer to an
> >>> actual resolve_btfids use-case. Maybe even replace or remove it.
> >>>
> >>> resolve_btfids operates on BTF generated by pahole for
> >>> kernel/module. And the .BTF_ids section makes sense only in kernel
> >>> space AFAIU (might be wrong, let me know if I am).
> >>>
> >>> And in this test we are using BTF produced by LLVM for a BPF program,
> >>> and then create a .BTF_ids section in a user-space app (test_progs /
> >>> resolve_btfids.test.o), although using proper kernel macros.
> >>>
> >>> By the way, the test was written more than 5y ago [1], so it might be
> >>> outdated too.
> >>>
> >>> I think the behavior that we care about is already indirectly tested
> >>> by bpf_testmod module tests, with custom BPF kfuncs and BTF_ID_*
> >>> declarations etc. If resolve_btfids is broken, those tests will fail.
> >>>
> >>> But it's also reasonable to have some tests targeting resolve_btfids
> >>> app itself, of course. This one doesn't fit though IMO.
> >>>
> >>> I'll try to think of something.
> >>
> >> Hi Donglin,
> >>
> >> I discussed this off-list with Andrii, and we agreed that the selftest
> >> itself is reasonable with respect to testing resolve_btfids output.
> >>
> >> In this series, I only have to change the test_progs build recipe.
> >>
> >> The problem that you've encountered I think can be fixed in the test,
> >> which is basically what you suggested as option 2:
> >>
> >>   static int resolve_symbols(void)
> >>   {
> >>         struct btf *btf;
> >>         int type_id;
> >>         __u32 nr;
> >>
> >>         btf =3D btf__parse_elf("btf_data.bpf.o", NULL); /* <--- this *=
/
> >>
> >>         [...]
> >>
> >> Instead of reading in the source BTF, we have to load .btf produced by
> >> resolve_btfids. A complication is that it's going to be a different
> >> file for every TRUNNER_BINARY, which has to be accounted for, although
> >> the BTF itself would be identical between relevant runners.
> >>
> >> If go this route, I think we should add .btf cleanup to the Makefile
> >> and update local .gitignore
> >
> > Thanks, could the following modification be accepted?
> >
> > diff --git a/tools/testing/selftests/bpf/.gitignore
> > b/tools/testing/selftests/bpf/.gitignore
> > index be1ee7ba7ce0..38ac369cd701 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -45,3 +45,4 @@ xdp_synproxy
> >  xdp_hw_metadata
> >  xdp_features
> >  verification_cert.h
> > +*.btf
> > diff --git a/tools/testing/selftests/bpf/Makefile
> > b/tools/testing/selftests/bpf/Makefile
> > index 2a027ff9ceaf..a1188129229f 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -720,7 +720,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
> >                  \
> >         $(Q)if [ -f $$@.btf_ids ]; then \
> >                 $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$@;=
 \
> >         fi
> > -       $(Q)rm -f $$@.btf_ids $$@.btf
> > +       $(Q)rm -f $$@.btf_ids
> >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bp=
ftool \
> >                    $(OUTPUT)/$(if $2,$2/)bpftool
> >
> > @@ -908,7 +908,7 @@ EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
> >                  \
> >         prog_tests/tests.h map_tests/tests.h verifier/tests.h          =
 \
> >         feature bpftool $(TEST_KMOD_TARGETS)                           =
 \
> >         $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h  =
 \
> > -                              no_alu32 cpuv4 bpf_gcc                  =
 \
> > +                              *.btf no_alu32 cpuv4 bpf_gcc            =
 \
> >                                liburandom_read.so)                     =
 \
> >         $(OUTPUT)/FEATURE-DUMP.selftests
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > index 51544372f52e..00883ff16569 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > @@ -101,7 +101,7 @@ static int resolve_symbols(void)
> >         int type_id;
> >         __u32 nr;
> >
> > -       btf =3D btf__parse_elf("btf_data.bpf.o", NULL);
> > +       btf =3D btf__parse_raw("test_progs.btf");
>
> We can't hardcode a filename here, because $(OUTPUT)/$(TRUNNER_BINARY)
> is a generic rule for a number of different binaries (test_progs,
> test_maps, test_progs-no_alu32 and others).
>
> I think there are a few options how to deal with this:
> - generate .btf and .btf_ids not for the final TRUNNER_BINARY, but for
>   a specific test object (resolve_btfids.test.o in this case); then we
>   could load "resolve_btfids.test.o.btf"
> - implement an --output-btf option in resolve_btfids
> - somehow (env var?) determine what binary is running in the test
> - (a hack) in the makefile, copy $@.btf to "test.btf" or similar
>
> IMO the first option is the best, as this makefile code exists because
> of that specific test.
>
> The --output-btf is okay in principle, but I don't like the idea of
> adding a cli option that would be used only for one selftest.

Thanks, I understand. Here are the changes based on the first option:

diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 2a027ff9ceaf..751960aeb8e5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -704,6 +704,16 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
        $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 endif

+ifneq ($(TRUNNER_BINARY),test_maps)
+$(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf
$(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf_ids:
$(TRUNNER_OUTPUT)/btf_data.bpf.o          \
+
                      $(TRUNNER_OUTPUT)/resolve_btfids.test.o    \
+
                      $(RESOLVE_BTFIDS)
+       $(call msg,BTF+IDS,resolve_btfids,$@)
+       $(Q)$(RESOLVE_BTFIDS) --btf $(dir $@)btf_data.bpf.o $(dir
$@)resolve_btfids.test.o
+
+$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf_i=
ds
+endif
+
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)

@@ -716,11 +726,9 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
                 \
                             | $(TRUNNER_BINARY)-extras
        $$(call msg,BINARY,,$$@)
        $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS)
$$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
-       $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
-       $(Q)if [ -f $$@.btf_ids ]; then \
-               $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$@; \
+       $(Q)if [ "$(TRUNNER_BINARY)" !=3D "test_maps" ]; then \
+               $(OBJCOPY) --update-section
.BTF_ids=3D$(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf_ids $$@; \
        fi
-       $(Q)rm -f $$@.btf_ids $$@.btf
        $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftoo=
l \
                   $(OUTPUT)/$(if $2,$2/)bpftool

@@ -908,7 +916,7 @@ EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
                 \
        prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
        feature bpftool $(TEST_KMOD_TARGETS)                            \
        $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h   \
-                              no_alu32 cpuv4 bpf_gcc                   \
+                              *.btf *.btf_ids no_alu32 cpuv4 bpf_gcc   \
                               liburandom_read.so)                      \
        $(OUTPUT)/FEATURE-DUMP.selftests

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 51544372f52e..eef6efc82606 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -101,9 +101,9 @@ static int resolve_symbols(void)
        int type_id;
        __u32 nr;

-       btf =3D btf__parse_elf("btf_data.bpf.o", NULL);
+       btf =3D btf__parse_raw("resolve_btfids.test.o.btf");
        if (CHECK(libbpf_get_error(btf), "resolve",
-                 "Failed to load BTF from btf_data.bpf.o\n"))
+                 "Failed to load BTF from resolve_btfids.test.o.btf\n"))
                return -1;

        nr =3D btf__type_cnt(btf);

>
> >         if (CHECK(libbpf_get_error(btf), "resolve",
> >                   "Failed to load BTF from btf_data.bpf.o\n"))
> >                 return -1;
> >
> > Thanks,
> > Donglin
> >
> >>
> >> This change is not strictly necessary in this series, but it is for
> >> the BTF sorting series. Let me know if you would like to take this on,
> >> so we don't do the same work twice.
> >
> > Thanks, I will take it on.
>
> Thank you. I think that'll be a patch in the BTF sorting series.
> You can work on top of this (v2) series for now. The feedback so far has
> been mostly nits, and I don't expect overall approach to change in v3.
>
> >
> >>
> >>>
> >>> [1] https://lore.kernel.org/bpf/20200703095111.3268961-10-jolsa@kerne=
l.org/
> >>>
> >>>
> >>>>
> >>>> Thanks,
> >>>> Donglin
> >>>>
> >>>>> +       fi
> >>>>> +       $(Q)rm -f $$@.btf_ids $$@.btf
> >>>>>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRA=
P)bpftool \
> >>>>>                    $(OUTPUT)/$(if $2,$2/)bpftool
> >>>>>
> >>>>> --
> >>>>> 2.52.0
> >>>>>
> >>>
> >>
>


Return-Path: <bpf+bounces-75964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C3C9EC0E
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 11:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC933A7827
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33ED2EFD95;
	Wed,  3 Dec 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FziRWimn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F992EF654
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758559; cv=none; b=j79uc9sDjLWJdYOUaPsP09gc3yfvrCkpiCU0fnB4qyry2hvBPfLnw01GuuFx906/RWt3jbhO1srLKzgRceIU2Wvr7Nld3uSHeBBQLl3akn39bENQwgh/7b3D/geCSLaMo6gsOXmU0+/7kyhwTIjothn79nib7yqMxfXSBWHZ/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758559; c=relaxed/simple;
	bh=tEQVcPqsv8DAVxcYPPcWyTn9akh39anPXKzKrd7i5io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB1LFT7Bj16Scm7wXIAiOdRL4cbOfK8NxsZnT59AvJrsYVdBGnnSPho83RtbLcpfmYAEm3MPKkpyIdYX2xWIrVLweFlFJ5RZn6BhYXyc4Tfw9k226b8Zi0s4cHVOEPSW5D7EDtcSYmkeFO3pmvxUr8hPf1ULWUVBG+BC2LwKb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FziRWimn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735487129fso948752966b.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764758555; x=1765363355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x446siwotpujmP9BD8csJrElgaCH9mcm8ox97o4pMsE=;
        b=FziRWimnSOZXMLqSYFPrFqAQhuNEQrdYAo0pYD6STpoCktBqn7EFv1AwBsc1rsXXqK
         LSulohgWHUHjdpCXmQnvHUuJ07kHrreCaCf3ljrK9Ncb14rB3yPyHhog03GFbIFVVsq1
         uhBCM2WPHT8Dz04BTkKoKBKO1/mH35j6iwyxYdCmWVeUSFjNYZU6kyhfDg0ChJXxbciD
         8iXdwTlVN61FX0ABdlhAjFU8A/1Al0QChW281622o2+EO1Km10ouKh7DriBxAIf/+fo/
         EY0nvP8V01hpPlOQ+/1gvL4lj4RzvKJUCPraYQyv/pd0BpHCwOh6ixIChUJu6ZF4fqC2
         e+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764758555; x=1765363355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x446siwotpujmP9BD8csJrElgaCH9mcm8ox97o4pMsE=;
        b=NQXkTfjE5B9hLyWxhahhmB/sOVLxY2pdfix7LIyc0gQo9yAtQx4ZgkgeHlN8K8sJZn
         DLjuVBAKIrzO0M6nkKX32o+CtTgy+EHWJcpa3xHJnI8p3ALiJgyeJ9ZIpDOiXUu0++Mh
         FvX4Vwtu96V5PTyb6E9kKtJ2dMEEzh8ZSOgRo1pbXVVp235QHtTD2UwkcaY3P0DFF1tl
         iBQzqrqHeN+UFiRuJzhiUa4bKWjNCJu0UjzvCnt4CcKyyaItzNltLB2ZH9oTWasOXku0
         anxNdMTjcyoL85qk+wCiXj57eMrWP8PhMOU82Fs1Zvqk7ui8QeSaGdfKWQW8IFIFFAwM
         wjbg==
X-Forwarded-Encrypted: i=1; AJvYcCUmmvG7YpmGKm8sGFyY0+n0+PTcUJjhC+5+Pf1nOz7g8HWQayDTRinKne2/4D+ysf/uriE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVuNH3sETp3bgfFYhjyWIcoyPYN6PajFg5JzTGQBu9xtWsx05
	4SoewPOPDds0Z2FSq37XYOuhtKSZ4Fz8EAu2xrPLb2wHexhzkx8deB/or7Uv/MXSu2e4ljgr3q5
	Ze31Z7bLwYV6M/VxTkdvYnPi0Kbkx8xs=
X-Gm-Gg: ASbGnctSUjrNlfUlI8shagehSjnXq8CBsWtwpYoHJtm28A9nGBrECoKV/RTkQ9WbCt4
	ry2OaGYxZXIkKkcsw9x7ECxWvcP2Adi2wDFuEAVwPkCgKQdlytZRW/TrwZYr6bjM21nCf8ncZny
	bG3M0/CnGlNlB6pwroBaPqlnBMc4qBwwc+w/y74IrNfyhM5b7ywxFXJwasBM1AdqWQRSJNQQRuy
	EdzzBl7I6GYcb5xz8SygKp73y6nd1etz2Ea0gXCR/zdn3ex/cU9gID2vtT3iCP7AbmgjE9H
X-Google-Smtp-Source: AGHT+IHY/Q93Vb8a/mu4yVgPiQqVsL9c07dOacbfrRsix1y6rD1JRR9OpZPDMkVzYiWbim0ckYAl2J/+cVNWgMwQSmY=
X-Received: by 2002:a17:907:1c0b:b0:b71:1164:6a7e with SMTP id
 a640c23a62f3a-b79db622b72mr177431666b.0.1764758554899; Wed, 03 Dec 2025
 02:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev> <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
 <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev> <642f6b68-0691-44a1-844f-a8cddec41fd0@linux.dev>
 <CAErzpmsoeFJBhqXZF1ttUCDx5HSFVawdiVfsG2vWSOq4DBBruQ@mail.gmail.com>
 <1175fe21-5c0b-4680-8fa7-55d22e4bcaca@linux.dev> <CAErzpms1hg=6JZJMRLK6gNsSZDeBbz-4RmUfU6aSf8J281QSwQ@mail.gmail.com>
In-Reply-To: <CAErzpms1hg=6JZJMRLK6gNsSZDeBbz-4RmUfU6aSf8J281QSwQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 3 Dec 2025 18:42:22 +0800
X-Gm-Features: AWmQ_bmhEOss5ZpSm8ZEk9zYyIjRbLCVVUj76yCk7ixG7XwWPKROGcRPJiZDmb4
Message-ID: <CAErzpmvB8s4KKViFAPOn8OhxsLj49_cM+95iJdcr5TSGnL5q4A@mail.gmail.com>
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

On Wed, Dec 3, 2025 at 5:14=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Wed, Dec 3, 2025 at 3:01=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
> >
> > On 12/1/25 6:01 PM, Donglin Peng wrote:
> > > On Tue, Dec 2, 2025 at 3:46=E2=80=AFAM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> > >>
> > >> On 11/27/25 9:52 PM, Ihor Solodrai wrote:
> > >>> On 11/27/25 7:20 PM, Donglin Peng wrote:
> > >>>> On Fri, Nov 28, 2025 at 2:53=E2=80=AFAM Ihor Solodrai <ihor.solodr=
ai@linux.dev> wrote:
> > >>>>>
> > >>>>> [...]
> > >>>>>
> > >>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing=
/selftests/bpf/Makefile
> > >>>>> index bac22265e7ff..ec7e2a7721c7 100644
> > >>>>> --- a/tools/testing/selftests/bpf/Makefile
> > >>>>> +++ b/tools/testing/selftests/bpf/Makefile
> > >>>>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
> > >>>>>  include ../../../scripts/Makefile.include
> > >>>>>
> > >>>>>  CXX ?=3D $(CROSS_COMPILE)g++
> > >>>>> +OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> > >>>>>
> > >>>>>  CURDIR :=3D $(abspath .)
> > >>>>>  TOOLSDIR :=3D $(abspath ../../..)
> > >>>>> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_=
OBJS)                  \
> > >>>>>         $$(call msg,BINARY,,$$@)
> > >>>>>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $=
$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> > >>>>>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bp=
f.o $$@
> > >>>>> +       $(Q)if [ -f $$@.btf_ids ]; then \
> > >>>>> +               $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_id=
s $$@; \
> > >>>>
> > >>>> I encountered a resolve_btfids self-test failure when enabling the
> > >>>> BTF sorting feature, with the following error output:
> > >>>>
> > >>>> All error logs:
> > >>>> resolve_symbols:PASS:resolve 0 nsec
> > >>>> test_resolve_btfids:PASS:id_check 0 nsec
> > >>>> test_resolve_btfids:PASS:id_check 0 nsec
> > >>>> test_resolve_btfids:FAIL:id_check wrong ID for T (7 !=3D 5)
> > >>>> #369     resolve_btfids:FAIL
> > >>>>
> > >>>> The root cause is that prog_tests/resolve_btfids.c retrieves type =
IDs
> > >>>> from btf_data.bpf.o and compares them against the IDs in test_prog=
s.
> > >>>> However, while the IDs in test_progs are sorted, those in btf_data=
.bpf.o
> > >>>> remain in their original unsorted state, causing the validation to=
 fail.
> > >>>>
> > >>>> This presents two potential solutions:
> > >>>> 1. Update the relevant .BTF.* section datas in btf_data.bpf.o, inc=
luding
> > >>>>     the .BTF and .BTF.ext sections
> > >>>> 2. Modify prog_tests/resolve_btfids.c to retrieve IDs from test_pr=
ogs.btf
> > >>>>     instead. However, I discovered that test_progs.btf is deleted =
in the
> > >>>>     subsequent code section.
> > >>>>
> > >>>> What do you think of it?
> > >>>
> > >>> Within resolve_btfids it's clear that we have to update (sort in th=
is
> > >>> case) BTF first, and then resolve the ids based on the changed BTF.
> > >>>
> > >>> As for the test, we should probably change it to become closer to a=
n
> > >>> actual resolve_btfids use-case. Maybe even replace or remove it.
> > >>>
> > >>> resolve_btfids operates on BTF generated by pahole for
> > >>> kernel/module. And the .BTF_ids section makes sense only in kernel
> > >>> space AFAIU (might be wrong, let me know if I am).
> > >>>
> > >>> And in this test we are using BTF produced by LLVM for a BPF progra=
m,
> > >>> and then create a .BTF_ids section in a user-space app (test_progs =
/
> > >>> resolve_btfids.test.o), although using proper kernel macros.
> > >>>
> > >>> By the way, the test was written more than 5y ago [1], so it might =
be
> > >>> outdated too.
> > >>>
> > >>> I think the behavior that we care about is already indirectly teste=
d
> > >>> by bpf_testmod module tests, with custom BPF kfuncs and BTF_ID_*
> > >>> declarations etc. If resolve_btfids is broken, those tests will fai=
l.
> > >>>
> > >>> But it's also reasonable to have some tests targeting resolve_btfid=
s
> > >>> app itself, of course. This one doesn't fit though IMO.
> > >>>
> > >>> I'll try to think of something.
> > >>
> > >> Hi Donglin,
> > >>
> > >> I discussed this off-list with Andrii, and we agreed that the selfte=
st
> > >> itself is reasonable with respect to testing resolve_btfids output.
> > >>
> > >> In this series, I only have to change the test_progs build recipe.
> > >>
> > >> The problem that you've encountered I think can be fixed in the test=
,
> > >> which is basically what you suggested as option 2:
> > >>
> > >>   static int resolve_symbols(void)
> > >>   {
> > >>         struct btf *btf;
> > >>         int type_id;
> > >>         __u32 nr;
> > >>
> > >>         btf =3D btf__parse_elf("btf_data.bpf.o", NULL); /* <--- this=
 */
> > >>
> > >>         [...]
> > >>
> > >> Instead of reading in the source BTF, we have to load .btf produced =
by
> > >> resolve_btfids. A complication is that it's going to be a different
> > >> file for every TRUNNER_BINARY, which has to be accounted for, althou=
gh
> > >> the BTF itself would be identical between relevant runners.
> > >>
> > >> If go this route, I think we should add .btf cleanup to the Makefile
> > >> and update local .gitignore
> > >
> > > Thanks, could the following modification be accepted?
> > >
> > > diff --git a/tools/testing/selftests/bpf/.gitignore
> > > b/tools/testing/selftests/bpf/.gitignore
> > > index be1ee7ba7ce0..38ac369cd701 100644
> > > --- a/tools/testing/selftests/bpf/.gitignore
> > > +++ b/tools/testing/selftests/bpf/.gitignore
> > > @@ -45,3 +45,4 @@ xdp_synproxy
> > >  xdp_hw_metadata
> > >  xdp_features
> > >  verification_cert.h
> > > +*.btf
> > > diff --git a/tools/testing/selftests/bpf/Makefile
> > > b/tools/testing/selftests/bpf/Makefile
> > > index 2a027ff9ceaf..a1188129229f 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -720,7 +720,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
> > >                  \
> > >         $(Q)if [ -f $$@.btf_ids ]; then \
> > >                 $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$=
@; \
> > >         fi
> > > -       $(Q)rm -f $$@.btf_ids $$@.btf
> > > +       $(Q)rm -f $$@.btf_ids
> > >         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)=
bpftool \
> > >                    $(OUTPUT)/$(if $2,$2/)bpftool
> > >
> > > @@ -908,7 +908,7 @@ EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DI=
R)
> > >                  \
> > >         prog_tests/tests.h map_tests/tests.h verifier/tests.h        =
   \
> > >         feature bpftool $(TEST_KMOD_TARGETS)                         =
   \
> > >         $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h=
   \
> > > -                              no_alu32 cpuv4 bpf_gcc                =
   \
> > > +                              *.btf no_alu32 cpuv4 bpf_gcc          =
   \
> > >                                liburandom_read.so)                   =
   \
> > >         $(OUTPUT)/FEATURE-DUMP.selftests
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > > b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > > index 51544372f52e..00883ff16569 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> > > @@ -101,7 +101,7 @@ static int resolve_symbols(void)
> > >         int type_id;
> > >         __u32 nr;
> > >
> > > -       btf =3D btf__parse_elf("btf_data.bpf.o", NULL);
> > > +       btf =3D btf__parse_raw("test_progs.btf");
> >
> > We can't hardcode a filename here, because $(OUTPUT)/$(TRUNNER_BINARY)
> > is a generic rule for a number of different binaries (test_progs,
> > test_maps, test_progs-no_alu32 and others).
> >
> > I think there are a few options how to deal with this:
> > - generate .btf and .btf_ids not for the final TRUNNER_BINARY, but for
> >   a specific test object (resolve_btfids.test.o in this case); then we
> >   could load "resolve_btfids.test.o.btf"
> > - implement an --output-btf option in resolve_btfids
> > - somehow (env var?) determine what binary is running in the test
> > - (a hack) in the makefile, copy $@.btf to "test.btf" or similar
> >
> > IMO the first option is the best, as this makefile code exists because
> > of that specific test.
> >
> > The --output-btf is okay in principle, but I don't like the idea of
> > adding a cli option that would be used only for one selftest.
>
> Thanks, I understand. Here are the changes based on the first option:
>
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 2a027ff9ceaf..751960aeb8e5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -704,6 +704,16 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
>         $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
>  endif
>
> +ifneq ($(TRUNNER_BINARY),test_maps)
> +$(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf
> $(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf_ids:
> $(TRUNNER_OUTPUT)/btf_data.bpf.o          \
> +
>                       $(TRUNNER_OUTPUT)/resolve_btfids.test.o    \
> +
>                       $(RESOLVE_BTFIDS)
> +       $(call msg,BTF+IDS,resolve_btfids,$@)
> +       $(Q)$(RESOLVE_BTFIDS) --btf $(dir $@)btf_data.bpf.o $(dir
> $@)resolve_btfids.test.o

Sorry, the above command has some issues. Use the following command instead=
:
$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)btf_data.bpf.o
$(TRUNNER_OUTPUT)resolve_btfids.test.o

> +
> +$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf=
_ids
> +endif
> +
>  # some X.test.o files have runtime dependencies on Y.bpf.o files
>  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
>
> @@ -716,11 +726,9 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
>                  \
>                              | $(TRUNNER_BINARY)-extras
>         $$(call msg,BINARY,,$$@)
>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS)
> $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> -       $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
> -       $(Q)if [ -f $$@.btf_ids ]; then \
> -               $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$@; \
> +       $(Q)if [ "$(TRUNNER_BINARY)" !=3D "test_maps" ]; then \
> +               $(OBJCOPY) --update-section
> .BTF_ids=3D$(TRUNNER_OUTPUT)/resolve_btfids.test.o.btf_ids $$@; \
>         fi
> -       $(Q)rm -f $$@.btf_ids $$@.btf
>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpft=
ool \
>                    $(OUTPUT)/$(if $2,$2/)bpftool
>
> @@ -908,7 +916,7 @@ EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
>                  \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature bpftool $(TEST_KMOD_TARGETS)                            \
>         $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h   \
> -                              no_alu32 cpuv4 bpf_gcc                   \
> +                              *.btf *.btf_ids no_alu32 cpuv4 bpf_gcc   \
>                                liburandom_read.so)                      \
>         $(OUTPUT)/FEATURE-DUMP.selftests
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 51544372f52e..eef6efc82606 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -101,9 +101,9 @@ static int resolve_symbols(void)
>         int type_id;
>         __u32 nr;
>
> -       btf =3D btf__parse_elf("btf_data.bpf.o", NULL);
> +       btf =3D btf__parse_raw("resolve_btfids.test.o.btf");
>         if (CHECK(libbpf_get_error(btf), "resolve",
> -                 "Failed to load BTF from btf_data.bpf.o\n"))
> +                 "Failed to load BTF from resolve_btfids.test.o.btf\n"))
>                 return -1;
>
>         nr =3D btf__type_cnt(btf);
>
> >
> > >         if (CHECK(libbpf_get_error(btf), "resolve",
> > >                   "Failed to load BTF from btf_data.bpf.o\n"))
> > >                 return -1;
> > >
> > > Thanks,
> > > Donglin
> > >
> > >>
> > >> This change is not strictly necessary in this series, but it is for
> > >> the BTF sorting series. Let me know if you would like to take this o=
n,
> > >> so we don't do the same work twice.
> > >
> > > Thanks, I will take it on.
> >
> > Thank you. I think that'll be a patch in the BTF sorting series.
> > You can work on top of this (v2) series for now. The feedback so far ha=
s
> > been mostly nits, and I don't expect overall approach to change in v3.
> >
> > >
> > >>
> > >>>
> > >>> [1] https://lore.kernel.org/bpf/20200703095111.3268961-10-jolsa@ker=
nel.org/
> > >>>
> > >>>
> > >>>>
> > >>>> Thanks,
> > >>>> Donglin
> > >>>>
> > >>>>> +       fi
> > >>>>> +       $(Q)rm -f $$@.btf_ids $$@.btf
> > >>>>>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTST=
RAP)bpftool \
> > >>>>>                    $(OUTPUT)/$(if $2,$2/)bpftool
> > >>>>>
> > >>>>> --
> > >>>>> 2.52.0
> > >>>>>
> > >>>
> > >>
> >


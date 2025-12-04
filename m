Return-Path: <bpf+bounces-76011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3CCA20F9
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 01:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E44023012761
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F4A59;
	Thu,  4 Dec 2025 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkwXsLBE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160886359
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809207; cv=none; b=g8vjHiae62f7fDJDZgXZolhb+kGTwcHZ5enemeXTcXAQe+83bkVzN+KxGPC2ao7Bb0Sm15iUn3dXvdRXfTHXHvB+e/Vtxb7Maw0z5BGjp7OBOx3v3H4Yj0PVugtzlPD9dD/fSNWrQ5eBL2EuEZB1WlUUJmJ6qyHT+pMKvY3FX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809207; c=relaxed/simple;
	bh=xjn9Jss06eKIX11EIjPQFikvCqmZ2zB7KogITNMgHck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlygYiD8/zNdITVIedOyGiAjv+d/WheOyR19xYszAAWISknCGg1h9z/eiHqNi/kp9oe644Vr7KGQldJhr+cFPs7Ra+JDYypj3wuoLSofJw8L/xf3pTWAQVOEgA9fG17IL+M1P9BsV2HyFVBIiRSsVmKXMz7PaknxxqaAfoNfWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkwXsLBE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437af8444cso265774a91.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 16:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764809205; x=1765414005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP7rQrVhaPyLCOk5nVwtFYeECP4u2hSafGmHfz6zVjU=;
        b=jkwXsLBEjT4+9V+ScRVasjndnrdy2E4XZB0XQp1/kB3rbg/c0xMJ0SY0+JXSF7Jvfj
         wQTg+A6+Hz/G9O8fzhcLGAJKpS1YhXW8MbCZyMkQ5JvhXMF5V7rIy2/pRTeWB9mBI193
         nUptfjkTPWcQxtq04wnnbchjh5G9QptWXEKIiyRfwANvTphseDq6rABYVXwCmX7TXljH
         UbuDTvpnd0pBWZTumOorlejtvVTsuw0iYplIZiHW5viMoKYolETiF5Ekds0e2tCMszhC
         xXcp30w8OTuqhxZ4k2/igwy7WTWbRdu0GwhqpV3C3ieATboEQJCPBW1DKgqoNCZBWioR
         fXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764809205; x=1765414005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JP7rQrVhaPyLCOk5nVwtFYeECP4u2hSafGmHfz6zVjU=;
        b=oJLrcZ2S4ziaBIElU5+8gHRecoyFVQeZAlLqAqdZIU6qmgBsNjXNgsl36yEwjRNMNi
         5j0HOXky/FpbABQYhRdsaI+FXcR5pDqWhV0eYUjbmn4EulTQEYS/jZo2JZcwsMf198Vo
         xu/9oifHewPEz3hlLXM3pJoWI7hoV1vtmBh9qmF80G/WQdaKD98UhrfnOT09LsE3wRrc
         cDR5il7eteyWmhn/tZWbvCSxb9HdVm0ve2ZEzN0UaXk+MYLd4yBXEOU0cpDNN3aqRrQZ
         WTtL0GCKa2+CK0VKHMjZdXE1mv5r0ygRGmLySZ6h4bbsQQ03LcO/f5hdvv4pZdX//V3l
         lqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkCgMeX9F3jkZbcpv/MHPpZ7DH4AE+r8HcNXapAJSCWKsghprpJGPF21mZA/NT6UROIGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJz4WEbM9bofbV78piB/ysF77CAC74XLrREJzJTnI3U01ifW7D
	3rWoiSGMBFTOko/LZ7pMm+Ps2HTNGSw/22dlSVrPQ7kvhwWktE7p0iQwJE4T5lqG+jqtsgzEzIQ
	xpTOqTnxsM35HUrkQuFhSt/9UHJXKbGQ=
X-Gm-Gg: ASbGncsb//GWTfkzlDCbe61Ig2lFWIof9FBgABUr/JUPWipIZYfMM0s0obj6apHluQJ
	z+ibxlZmAAE71P/X1XtLFPnEpt768ghXVjk85AHdhhYdzdz+pPHGs8ZS/2l6FRmzb9rRhwbHr8q
	EksQoCMt0t/0OjTv9VSRjSI/crms0w5LqFTpzoRGTx35Z13S3HXWAawQGDlNHrx/FfZDs1WAb4U
	zsKVPp9snO7B0EPclhe+FexCGBpm9FF/xxs2JiokAXkVkR3bYOv6VDmHlOYuI0CbKAHwNtxmtHu
	jDGSEpvAO9c=
X-Google-Smtp-Source: AGHT+IFG3Eu1YhgihzPSaW50MptnfWM0NY53FdjHfaKUYmFm2dz8gzODWGImPG4rPJCJpeRrVVo3x1KBs4bngeyfj3s=
X-Received: by 2002:a17:90b:5750:b0:341:d265:1e82 with SMTP id
 98e67ed59e1d1-349126f142dmr5276678a91.29.1764809204896; Wed, 03 Dec 2025
 16:46:44 -0800 (PST)
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
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Dec 2025 16:46:32 -0800
X-Gm-Features: AWmQ_bkW9kpsY7QhdJXjaBdxD_Y3XpzCwRtrty1y2GqQhbL5F1Vp85jf1M3dyHI
Message-ID: <CAEf4BzaKn1NV=x1MEwXGp8=w_0afZGkVwmdRdNMbdwNUkL-Z7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Tue, Dec 2, 2025 at 11:01=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
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

see cd_flavor_subdir(), each flavor of test_progs has its dedicated
subdir (and flavor-less one just runs in selftests' directory). So I
think you should be able to hard-code the name. Even for
btf_data.bpf.o:

$ find . -name 'btf_data.bpf.o'
./no_alu32/btf_data.bpf.o
./cpuv4/btf_data.bpf.o
./btf_data.bpf.o


> - (a hack) in the makefile, copy $@.btf to "test.btf" or similar
>
> IMO the first option is the best, as this makefile code exists because
> of that specific test.
>
> The --output-btf is okay in principle, but I don't like the idea of
> adding a cli option that would be used only for one selftest.
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
>


Return-Path: <bpf+bounces-76018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F9CA2419
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 04:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FEC3056C4C
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 03:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD3246782;
	Thu,  4 Dec 2025 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK4++OTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715482E0B64
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764818954; cv=none; b=T8u81yWXXbrldx+SqLXeEBF7aR0gE90k8uD2HigBBk7a+X5xhyz0Smf9bZk5LNaRJL3QYS8vgxRMVyKDq1YKbNw12b8ReOIGBNpi5wmVrZBC242ERFFRW05+eRKMZZv+/nJC366TibfSeXcSDF1iD3QnWxHjlJeLHykOqYKuZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764818954; c=relaxed/simple;
	bh=bhlJ/orrMUqRtMSoNwXfqzUb4hyMYzoScgUoWuk8168=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9yKO8eMf3Eir//XEm78GEZ7NDf7ommsjefIvPdCuXs0TJaKG/ekBmm5UCp/NB9t8o18J9oTdCX66J65F8fZfYFdrMXnj5emoOyF/SbW4M2PohIMXOicNSkwoYpg8xGTclkR8UU2hod9zAM8JLgMpkU8QpjnmhmQoofoanpGViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK4++OTk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b736ffc531fso67551366b.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 19:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764818950; x=1765423750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrdIwNoj+82zFo75YV21A0a1to2ODbhIblwLS1s07sA=;
        b=ZK4++OTkx6T/+5THs7cfoyIRJDJd+2hISk3MBTYwXqFvZMK1/vgOnb1pESyaUeI5vP
         CroR46OE9WgS35vLNuHk6wk6iZGuXPDqzDYG304uFn2+OScsCMYaFZ58BH0y+iqqZF0k
         ZmpLoABMuE8UIYSQlOkBkwHyZcSliOxnCTecdVVMdr5jqTDIz7ehIgnnZMf66US6BJGq
         pDxsez0Js3dUoOsym4Q+cGQHipBg4elWu4wmLinr53iLz7F1F7/7T59ejjwcM2Vg0GAB
         7hWeva3KNmK5ZMfn8pvjtMIcYclrNp42UFsz9vcwwW25+lGCq8hsxa5ZBRlW2iq/9UZd
         l3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764818950; x=1765423750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrdIwNoj+82zFo75YV21A0a1to2ODbhIblwLS1s07sA=;
        b=wHX56FDd+dGRMoTKpvO8t3OfnmnFxYX+qIfM1r83Dgc3fAF4SrivSsxQGmQ6H3WDBy
         ERmfR7/AixxVKkkt8B5tVTbpUvMwbIWv/2iMNqqZr8TY6FWqQgirR4uUP7/7xBJSkTO0
         lf8pu1HKST24Qms0B3pmijPvJ4ToRcPs/nop9YTHucgnNK4Nf4eMNSh0Zgbc+N4fJhe9
         INieF47d8H7u3Kl7dfgMo3UWPZJawggzkNvXrDL+xj6R+VzbklYfGE8BycrZPN/P2Awe
         E2wfC6eucmoScJ49wzblsTqTVx+BA+ApHouJIofmxwZubhWu6eShJlieRcJGRK/QaVpD
         uJVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQluvoQWEUCC9qVW5oiEOhsZC3RwHFhRxS6UlZ0736Ay0UJ5pRKp7Khhgs2a+ZtMteDZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3w860FrxnYBLgvDO6YWG0N0L3hu6F1+WSz22ugFLgt12SEbu
	aG7SNBBgvG2rZgmo2Ov4SPe3MSJVysYaY8f33Tmcg6MNuacHUZdNpmsMuKyUYVufDcnrRfkdqpQ
	e89AN7F29fuJ1WlOG0hkSF92L/ISvdN0=
X-Gm-Gg: ASbGncsupsXcoekDp6zSgWZE2vKOiA+XKvI1UAVqgUnQeY/HXtfRD8J+5MAzSIhitO6
	qaU6IIoxANIRWwPYKODklepj0YdPlnZKLGp310RUSDog1xXg/pOtS0EY6LhQYIm1tuqSRl9Naz7
	fh3r1cSO1Y/6oF6LxDmvn6QRWVinmY3TlSzeIiN5u1TjPXWPGuOm9h7dO8AbcdBT4uqMOaPlhXJ
	gGOY6Wv1zlDXMjzgmoCoQz9J8aUk9vTu5C09Gc+Cg8Lc90yXA9splbkmxQk+tgitjjwC+nv
X-Google-Smtp-Source: AGHT+IGvm3xzZD8ZFm72o8ANUC1/FdwmSNkJrTb50ikzXyjqKOyOTJxni+DektAddUPPDxozqrhQqd8VBoQtqyehCis=
X-Received: by 2002:a17:907:7e82:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b79dbea1b3fmr502274566b.24.1764818949547; Wed, 03 Dec 2025
 19:29:09 -0800 (PST)
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
 <1175fe21-5c0b-4680-8fa7-55d22e4bcaca@linux.dev> <CAEf4BzaKn1NV=x1MEwXGp8=w_0afZGkVwmdRdNMbdwNUkL-Z7g@mail.gmail.com>
In-Reply-To: <CAEf4BzaKn1NV=x1MEwXGp8=w_0afZGkVwmdRdNMbdwNUkL-Z7g@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 4 Dec 2025 11:28:57 +0800
X-Gm-Features: AWmQ_bmQLU4gdw9_BZB4zFtWxW5boiQMPjJenIls0p-0DQx26JaIww14uPAriks
Message-ID: <CAErzpmt_o4BmPZ-2OeixDz8QGtrKvMe8rHeEiF3J+=JLJvkVZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
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

On Thu, Dec 4, 2025 at 8:46=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 2, 2025 at 11:01=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linu=
x.dev> wrote:
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
>
> see cd_flavor_subdir(), each flavor of test_progs has its dedicated
> subdir (and flavor-less one just runs in selftests' directory). So I
> think you should be able to hard-code the name. Even for
> btf_data.bpf.o:
>
> $ find . -name 'btf_data.bpf.o'
> ./no_alu32/btf_data.bpf.o
> ./cpuv4/btf_data.bpf.o
> ./btf_data.bpf.o

I think the first option is feasible. Based on my modifications, the
resolve_btfids.test.o.btffile will exist in each flavor's subdirectory.
Therefore, we can hard-code the filename resolve_btfids.test.o.btf
directly in prog_tests/resolve_btfids.c:

$ find -name resolve_btfids.test.o.btf
./resolve_btfids.test.o.btf
./cpuv4/resolve_btfids.test.o.btf
./no_alu32/resolve_btfids.test.o.btf

>
>
> > - (a hack) in the makefile, copy $@.btf to "test.btf" or similar
> >
> > IMO the first option is the best, as this makefile code exists because
> > of that specific test.
> >
> > The --output-btf is okay in principle, but I don't like the idea of
> > adding a cli option that would be used only for one selftest.
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
> >


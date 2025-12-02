Return-Path: <bpf+bounces-75855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C7C99D14
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 03:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416773A574C
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 02:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18681A0BD6;
	Tue,  2 Dec 2025 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giJ2zL2h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188921CC5B
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640906; cv=none; b=bXcpPNfTZQ5xNqohfO4uZC8OzDAWMA5PkCovw8pP8tRKwNsutGVm6Ks+Olkdl6isPe6Svo0IJaGjd/Aku5SudEyjB3h7dXj8dpQCYZfIT/YXIVBAFqeRFNkQE1RKBItLg+/wkmcn/EG66uXDZNel8urzJNT4SllGBHFiLIFyiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640906; c=relaxed/simple;
	bh=1xm2uxq3/XWsun1w9jLUXw2+0r+sZnuQEDplDJXFQuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLuev6CMXa9uczdKRf+lapeAoefsFA2+vbFbXeqBzbwPUktut3dMMWLLRF7E6aipOHXy27FjyBUXaSvetIiCbgEjjuQeSXseD/p5Bmha5XkJR0f3JD7QoNCTnN49YPKauqzKTvDWJo9dy7MUJI6vrHuZsWBFs7ChmLyXEFqRFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giJ2zL2h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so638836266b.3
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 18:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764640902; x=1765245702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm5mr5yL9Du8VwaKrx/bLGxyw/v9Tzp/9qk0FyO6AHc=;
        b=giJ2zL2hyFm4MbS08gYshTsWaqig5fkZxiIt5+LRfEsA13EPwhePysGXXTERSOfb6m
         zJBo9ci9PE5k51heJhvhqsykW9oOOPnWnr6XIRWpMHXKQy9bkh7A7lslD9gm7kC7qcGQ
         C5BfgHRXwDEQc3e3GelYThfgSzToQbiSjACoJ8FtyU7WWyrSz3H3Kt1iTQYpFbGExXt8
         SY9sFjPd6/a0Yiwlu71icFuu0+90j0qkuoo9yW3+I9sYjdz430EpuiKjHxEmQnZTArei
         zWEAqq2xQMm8xCBS1tWaKmWEhI5geRpL7fJ+VmcJ5cKc11LuQ9l76dp1vgncm4smZZbn
         hbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764640902; x=1765245702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tm5mr5yL9Du8VwaKrx/bLGxyw/v9Tzp/9qk0FyO6AHc=;
        b=qbMAwv5NGMJu3yDvdhCYC7JZHSX4P+CrOUYL7YCBf1G3HrhWP8GVz0EaawAwPDmR8H
         G/iO0OC3iOTwqyJhGFNbLRoopOvBWCOM/UNr2l7s68rOvy3n+sZfUkvOOSeQRO6cGuTo
         BBOIy784vicQtlXKcUgsN5fiUWW00+I0EPlRKk0yXPqj+rFr7YnN5w36FGs4bjamWLwN
         omkO2O8iFxVz8rV/KZpdVeDBreT/oz3P374CK8JmteFqOffLCThKtlVcQYK7/ULOX7UN
         e1IuxIhaywPNbAE6tmhkRuYB5A6WlK/MzphT9DOhA3MUVpT39GQD0qYvbod8hvNq5P/A
         xkvg==
X-Forwarded-Encrypted: i=1; AJvYcCU/qN800QYjsWpIDK9S08SCmJdCdyHr3xHdb32zZra4Cw7/exra0pKtJUT+7Do8SsyIXk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIr0dTRdRzxeS0NERKqcInPPZOoLke5FUKKmH7/0ntyuobsw8
	UDHsvls45WjIeZLvhIWc81XadlwUM6mSUVAX4k6iDJrHjCBV1WxfEPPY5pSf7R41uCUcMHGUIel
	QrtR88P81cWjXSbvOxUdVb422puGVR1c=
X-Gm-Gg: ASbGnctGgY72hNv1iVl4U1gU/ZNV5BsyokSz7uffGOEZZBCd87FhUFqi+Z+sh2mR5I1
	lHsePyEZ4L/lCA0x4Vsgf/6lbY2ZUh7wXn3sagWvI0JY8wMosZmHyssadkTG+bSpUuUfSmVlj+s
	6ZJ3B31qv8yymTU5ReL6MzZBogcGprfmHAB0/4gUVrbD6jJeHfSRCxvC+QbxRlBYUovzdSkKajh
	tqA+N/zbEw5fdkJFDD4pr2X6/L8Ztv2ibtnbJlBKzT2OJYGvMUuks6L6cgSCQHqXFCClatf
X-Google-Smtp-Source: AGHT+IHHko5taDzoikUBxxib+Dl66QmkMrihFVovUWzM3DLPTsIrY4nj1HQrVpOngr31v5ZBjowao82qKsNyWp/1rW8=
X-Received: by 2002:a17:907:948e:b0:b76:6aca:f1f3 with SMTP id
 a640c23a62f3a-b7671589e26mr4690153166b.19.1764640902328; Mon, 01 Dec 2025
 18:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev> <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
 <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev> <642f6b68-0691-44a1-844f-a8cddec41fd0@linux.dev>
In-Reply-To: <642f6b68-0691-44a1-844f-a8cddec41fd0@linux.dev>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 2 Dec 2025 10:01:30 +0800
X-Gm-Features: AWmQ_bnjqK72ks9Avti-IcUvnRHy9afmTaSBhUzRFloy790PNcPXAn75zl9WskI
Message-ID: <CAErzpmsoeFJBhqXZF1ttUCDx5HSFVawdiVfsG2vWSOq4DBBruQ@mail.gmail.com>
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

On Tue, Dec 2, 2025 at 3:46=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 11/27/25 9:52 PM, Ihor Solodrai wrote:
> > On 11/27/25 7:20 PM, Donglin Peng wrote:
> >> On Fri, Nov 28, 2025 at 2:53=E2=80=AFAM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>>
> >>> [...]
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/sel=
ftests/bpf/Makefile
> >>> index bac22265e7ff..ec7e2a7721c7 100644
> >>> --- a/tools/testing/selftests/bpf/Makefile
> >>> +++ b/tools/testing/selftests/bpf/Makefile
> >>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
> >>>  include ../../../scripts/Makefile.include
> >>>
> >>>  CXX ?=3D $(CROSS_COMPILE)g++
> >>> +OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> >>>
> >>>  CURDIR :=3D $(abspath .)
> >>>  TOOLSDIR :=3D $(abspath ../../..)
> >>> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS=
)                  \
> >>>         $$(call msg,BINARY,,$$@)
> >>>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LL=
VM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> >>>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o =
$$@
> >>> +       $(Q)if [ -f $$@.btf_ids ]; then \
> >>> +               $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$=
@; \
> >>
> >> I encountered a resolve_btfids self-test failure when enabling the
> >> BTF sorting feature, with the following error output:
> >>
> >> All error logs:
> >> resolve_symbols:PASS:resolve 0 nsec
> >> test_resolve_btfids:PASS:id_check 0 nsec
> >> test_resolve_btfids:PASS:id_check 0 nsec
> >> test_resolve_btfids:FAIL:id_check wrong ID for T (7 !=3D 5)
> >> #369     resolve_btfids:FAIL
> >>
> >> The root cause is that prog_tests/resolve_btfids.c retrieves type IDs
> >> from btf_data.bpf.o and compares them against the IDs in test_progs.
> >> However, while the IDs in test_progs are sorted, those in btf_data.bpf=
.o
> >> remain in their original unsorted state, causing the validation to fai=
l.
> >>
> >> This presents two potential solutions:
> >> 1. Update the relevant .BTF.* section datas in btf_data.bpf.o, includi=
ng
> >>     the .BTF and .BTF.ext sections
> >> 2. Modify prog_tests/resolve_btfids.c to retrieve IDs from test_progs.=
btf
> >>     instead. However, I discovered that test_progs.btf is deleted in t=
he
> >>     subsequent code section.
> >>
> >> What do you think of it?
> >
> > Within resolve_btfids it's clear that we have to update (sort in this
> > case) BTF first, and then resolve the ids based on the changed BTF.
> >
> > As for the test, we should probably change it to become closer to an
> > actual resolve_btfids use-case. Maybe even replace or remove it.
> >
> > resolve_btfids operates on BTF generated by pahole for
> > kernel/module. And the .BTF_ids section makes sense only in kernel
> > space AFAIU (might be wrong, let me know if I am).
> >
> > And in this test we are using BTF produced by LLVM for a BPF program,
> > and then create a .BTF_ids section in a user-space app (test_progs /
> > resolve_btfids.test.o), although using proper kernel macros.
> >
> > By the way, the test was written more than 5y ago [1], so it might be
> > outdated too.
> >
> > I think the behavior that we care about is already indirectly tested
> > by bpf_testmod module tests, with custom BPF kfuncs and BTF_ID_*
> > declarations etc. If resolve_btfids is broken, those tests will fail.
> >
> > But it's also reasonable to have some tests targeting resolve_btfids
> > app itself, of course. This one doesn't fit though IMO.
> >
> > I'll try to think of something.
>
> Hi Donglin,
>
> I discussed this off-list with Andrii, and we agreed that the selftest
> itself is reasonable with respect to testing resolve_btfids output.
>
> In this series, I only have to change the test_progs build recipe.
>
> The problem that you've encountered I think can be fixed in the test,
> which is basically what you suggested as option 2:
>
>   static int resolve_symbols(void)
>   {
>         struct btf *btf;
>         int type_id;
>         __u32 nr;
>
>         btf =3D btf__parse_elf("btf_data.bpf.o", NULL); /* <--- this */
>
>         [...]
>
> Instead of reading in the source BTF, we have to load .btf produced by
> resolve_btfids. A complication is that it's going to be a different
> file for every TRUNNER_BINARY, which has to be accounted for, although
> the BTF itself would be identical between relevant runners.
>
> If go this route, I think we should add .btf cleanup to the Makefile
> and update local .gitignore

Thanks, could the following modification be accepted?

diff --git a/tools/testing/selftests/bpf/.gitignore
b/tools/testing/selftests/bpf/.gitignore
index be1ee7ba7ce0..38ac369cd701 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -45,3 +45,4 @@ xdp_synproxy
 xdp_hw_metadata
 xdp_features
 verification_cert.h
+*.btf
diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 2a027ff9ceaf..a1188129229f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -720,7 +720,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
                 \
        $(Q)if [ -f $$@.btf_ids ]; then \
                $(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$@; \
        fi
-       $(Q)rm -f $$@.btf_ids $$@.btf
+       $(Q)rm -f $$@.btf_ids
        $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftoo=
l \
                   $(OUTPUT)/$(if $2,$2/)bpftool

@@ -908,7 +908,7 @@ EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
                 \
        prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
        feature bpftool $(TEST_KMOD_TARGETS)                            \
        $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h   \
-                              no_alu32 cpuv4 bpf_gcc                   \
+                              *.btf no_alu32 cpuv4 bpf_gcc             \
                               liburandom_read.so)                      \
        $(OUTPUT)/FEATURE-DUMP.selftests

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 51544372f52e..00883ff16569 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -101,7 +101,7 @@ static int resolve_symbols(void)
        int type_id;
        __u32 nr;

-       btf =3D btf__parse_elf("btf_data.bpf.o", NULL);
+       btf =3D btf__parse_raw("test_progs.btf");
        if (CHECK(libbpf_get_error(btf), "resolve",
                  "Failed to load BTF from btf_data.bpf.o\n"))
                return -1;

Thanks,
Donglin

>
> This change is not strictly necessary in this series, but it is for
> the BTF sorting series. Let me know if you would like to take this on,
> so we don't do the same work twice.

Thanks, I will take it on.

>
> >
> > [1] https://lore.kernel.org/bpf/20200703095111.3268961-10-jolsa@kernel.=
org/
> >
> >
> >>
> >> Thanks,
> >> Donglin
> >>
> >>> +       fi
> >>> +       $(Q)rm -f $$@.btf_ids $$@.btf
> >>>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)=
bpftool \
> >>>                    $(OUTPUT)/$(if $2,$2/)bpftool
> >>>
> >>> --
> >>> 2.52.0
> >>>
> >
>


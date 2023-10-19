Return-Path: <bpf+bounces-12753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFED7D0445
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 23:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9873DB214AE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8B405E6;
	Thu, 19 Oct 2023 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArzAO0WT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A53FB15
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 21:57:19 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74B115
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:57:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso397e87.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697752634; x=1698357434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XajYlYAO8Kk7inISBTtrUw4bdn+rl2BtGkmrWxdlT40=;
        b=ArzAO0WTS7lHFUI+IYunE+dQkaAWbfx4sCzlH248DNc8OZeXw4EEG1Goa5bgrUo8uY
         qivCEttsgruQTYchqg31D+XjBbN2WlQJD96vxBHM75oH8HQwIS02yIEf90IpOIQu/NHU
         5cMBzv6C3YjRQz/SJ8GtviFLigx5H3xe8mJsHR/G8c7wje+i0iYLVGcNW9+IvMekODDA
         O1peJE29o3XGMKDqz9wfETt05RHF1MFnE6iyfJgdkrDeprWgm6NE3dVMU4qVHjuxFgbm
         ne7XnFGFMcuWCXmvL5LGiGbjUv9SPfSDtg/WD9IfYMq9LTkAnWUVg0SXPXndOuryXNLO
         oarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752634; x=1698357434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XajYlYAO8Kk7inISBTtrUw4bdn+rl2BtGkmrWxdlT40=;
        b=YxC+9yLA4+0McKE7U3ZOjN2wYQQLaLAad5oD+FC1MYtVJBJ86WhoXCXmNnGtJgnBbD
         bhsHJ0Cep8weBn0Kq3cjjs3UIDKc6N07rkuooaJs5G05kQIa6QAQoMAQY9C/KI9Z/oEV
         WGtLxJq0Z4xZf7Bgn1mWb+86oCoTUsyoupwyUrcWxUP3ZBOqlRlOd67broaMnsmsc/UE
         Qv3X0xwSUZM45gZXP9a2k2MRUq66jeL9g4s7gfRuvLbszTlwKs9f58YjIJPfUEEU46pV
         2zx2BJy3wWJNFL5Okx1udRmT7UJ+Gjz39xAdVSRdi1OE72at2t6rFubuD7RR/1Wa6BRB
         absA==
X-Gm-Message-State: AOJu0Yw+pXXvrP3EQJc8LpBifLKj4CBfmQBnmmrLDPAo8DFDa9NChRff
	YppBRt2TpoPnIK39gGwpWJZ6L3rQnVnyzJB676GFfQ==
X-Google-Smtp-Source: AGHT+IE2v4Wr4RNxELB1a8mWDC9skPvwIt1rxIqCVgLu5Uiyjg78Fr/2hugh2CoSyopYsjyCQHrqzyBSgJpifeeul5A=
X-Received: by 2002:a05:6512:754:b0:502:a55e:fec0 with SMTP id
 c20-20020a056512075400b00502a55efec0mr19637lfs.6.1697752634350; Thu, 19 Oct
 2023 14:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com> <20230810184853.2860737-2-irogers@google.com>
 <ZNZJCWi9MT/HZdQ/@kernel.org> <ZNZWsAXg2px1sm2h@kernel.org>
 <ZTGHRAlQtF7Fq8vn@surya> <ZTGa0Ukt7QyxWcVy@kernel.org>
In-Reply-To: <ZTGa0Ukt7QyxWcVy@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Oct 2023 14:57:00 -0700
Message-ID: <CAP-5=fU9DHYDAcGuX=7SHy2J09bqcYpP+_8NXKbnVDtSjrw01g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf parse-events: Remove BPF event support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Manu Bretelle <chantr4@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Fangrui Song <maskray@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>, 
	Wang ShaoBo <bobo.shaobowang@huawei.com>, YueHaibing <yuehaibing@huawei.com>, 
	He Kuang <hekuang@huawei.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 2:08=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Oct 19, 2023 at 12:45:08PM -0700, Manu Bretelle escreveu:
> > cc @quentin
> >
> > On Fri, Aug 11, 2023 at 12:41:36PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Em Fri, Aug 11, 2023 at 11:43:22AM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Right now it is not applying due to some clash with other changes a=
nd
> > > > when I tried to apply it manually there were some formatting issues=
:
> > > >
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ head ~/wb/1.patch
> > > > From SRS0=3DEALy=3DD3=3Dflex--irogers.bounces.google.com=3D3IDHVZAc=
KBAUnwtljwxlttlqj.htrfhrjpjwsjq.twl@kernel.org Thu Aug 10 17:53:46 2023
> > > > Delivered-To: arnaldo.melo@gmail.com
> > > > Received: from imap.gmail.com [64.233.186.109]
> > > >   by quaco with IMAP (fetchmail-6.4.37)
> > > >   for <acme@localhost> (single-drop); Thu, 10 Aug 2023 17:53:46 -03=
00 (-03)
> > > > Received: by 2002:a0c:ab03:0:b0:63d:780e:9480 with SMTP id h3csp908=
198qvb;
> > > >  Thu, 10 Aug 2023 11:49:52 -0700 (PDT)
> > > > X-Google-Smtp-Source: AGHT+IH9N/knUCyQ0tQ2Q0XBH0gqf8A8DB8/37YHWAJDK=
Bmz7AGSV9CvCKYDuE3EwxriZFBwtZMs
> > > > X-Received: by 2002:a4a:6b4f:0:b0:56c:b2ab:9820 with SMTP id
> > > >  h15-20020a4a6b4f000000b0056cb2ab9820mr2695332oof.8.1691693392493; =
Thu, 10 Aug
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
> > > > patching file tools/perf/Documentation/perf-config.txt
> > > > patch: **** malformed patch at line 234: ith
> > > >
> > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > > >
> > > > I'm trying to apply it manually.
> > >
> > > I have this extracted from this patch as the first patch in the serie=
s:
> > >
> > > >From adc61b5774a9de62f34d593f164ca02daa6fb44c Mon Sep 17 00:00:00 20=
01
> > > From: Ian Rogers <irogers@google.com>
> > > Date: Fri, 11 Aug 2023 12:19:48 -0300
> > > Subject: [PATCH 1/1] perf bpf: Remove support for embedding clang for
> > >  compiling BPF events (-e foo.c)
> > >
> > > This never was in the default build for perf, is difficult to maintai=
n
> > > as it uses clang/llvm internals so ditch it, keeping, for now, the
> > > external compilation of .c BPF into .o bytecode and its subsequent
> > > loading, that is also going to be removed, do it separately to help
> > > bisection and to properly document what is being removed and why.
> > >
> > > Committer notes:
> > >
> > > Extracted from a larger patch and removed some leftovers, namely
> > > deleting these now unused feature tests:
> > >
> > >     tools/build/feature/test-clang.cpp
> > >     tools/build/feature/test-cxx.cpp
> > >     tools/build/feature/test-llvm-version.cpp
> > >     tools/build/feature/test-llvm.cpp
> > >
> >
> > This seem to have broken `llvm` feature detection for `bpftool`.
> >
> > The feature detections are still available in `tools/build/Makefile.fea=
ture` [0]
> > but the .cpp files are gone.
> >
> > `bpftool` still rely on the `llvm` feature:
> >
> >     $ git --no-pager grep 'feature-llvm'
> >     tools/bpf/bpftool/Makefile:ifeq ($(feature-llvm),1)
> >
> > The result of testing llvm feature is:
> >
> >     $ cat tools/build/feature/test-llvm.make.output
> >     cc1plus: fatal error: test-llvm.cpp: No such file or directory
> >     compilation terminated.
> >
> > With current head:
> >
> >     make -j $((4*$(nproc))) -C tools/bpf/bpftool && ./tools/bpf/bpftool=
/bpftool --version
> >     ...
> >     Auto-detecting system features:
> >     ...                         clang-bpf-co-re: [ on  ]
> >     ...                                    llvm: [ OFF ]
> >     ...                                  libcap: [ on  ]
> >     ...                                  libbfd: [ on  ]
> >     ...
> >     ...
> >     ...
> >     bpftool v7.3.0
> >     using libbpf v1.3
> >     features: libbfd, skeletons
> >
> > After applying
> >
> >     git show 56b11a2126bf2f422831ecf6112b87a4485b221b  tools/build/feat=
ure | \
> >         patch -p1 -R
>
>
> Ouch, so probably we need just to reintroduce that one
> tools/build/feature/test-llvm.cpp file.
>
> Building perf these days ends up using bpftool, and the end result as
> noticed with me testing perf, perf trace with bpf, etc didn't change, so
> I didn't notice :-\
>
> And:
>
> ifeq ($(feature-llvm),1)
>   # If LLVM is available, use it for JIT disassembly
>   CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
>   LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
>   CFLAGS  +=3D $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_C=
OMPONENTS))
>   LIBS    +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS=
))
>   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>     LIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMP=
ONENTS))
>     LIBS +=3D -lstdc++
>   endif
>   LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
> else
>   # Fall back on libbfd
>   ifeq ($(feature-libbfd),1)
>     LIBS +=3D -lbfd -ldl -lopcodes
>   else ifeq ($(feature-libbfd-liberty),1)
>     LIBS +=3D -lbfd -ldl -lopcodes -liberty
>   else ifeq ($(feature-libbfd-liberty-z),1)
>     LIBS +=3D -lbfd -ldl -lopcodes -liberty -lz
>   endif
>
>   # If one of the above feature combinations is set, we support libbfd
>   ifneq ($(filter -lbfd,$(LIBS)),)
>     CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
>
>     # Libbfd interface changed over time, figure out what we need
>     ifeq ($(feature-disassembler-four-args), 1)
>       CFLAGS +=3D -DDISASM_FOUR_ARGS_SIGNATURE
>     endif
>     ifeq ($(feature-disassembler-init-styled), 1)
>       CFLAGS +=3D -DDISASM_INIT_STYLED
>     endif
>   endif
> endif
>
> And there is a fallback to using binutils, so most people ended up not
> noticing.
>
> I wonder how to improve the current situation to detect these kinds of
> problems in the future, i.e. how to notice that some file needed by some
> Makefile, etc got removed or that some feature test fails because some
> change in the test .c files makes them fail and thus activates fallbacks
> like the one above :-\
>
>
> So if I just get this back:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llv=
m.cpp
> // SPDX-License-Identifier: GPL-2.0
> #include "llvm/Support/ManagedStatic.h"
> #include "llvm/Support/raw_ostream.h"
> #define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR <=
< 8) + LLVM_VERSION_PATCH)
>
> #if NUM_VERSION < 0x030900
> # error "LLVM version too low"
> #endif
> int main()
> {
>         llvm::errs() << "Hello World!\n";
>         llvm::llvm_shutdown();
>         return 0;
> }
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> And install the llvm-devel package then it back working:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool
> make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftoo=
l'
>
> Auto-detecting system features:
> ...                         clang-bpf-co-re: [ on  ]
> ...                                    llvm: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libbfd: [ on  ]
> <SNIP>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llv=
m.make.output
> =E2=AC=A2[acme@toolbox perf-tools-next]$ ls -la tools/build/feature/test-=
llvm.
> test-llvm.bin          test-llvm.cpp          test-llvm.d            test=
-llvm.make.output
> =E2=AC=A2[acme@toolbox perf-tools-next]$ ls -la tools/build/feature/test-=
llvm.bin
> -rwxr-xr-x. 1 acme acme 17712 Oct 19 18:04 tools/build/feature/test-llvm.=
bin
> =E2=AC=A2[acme@toolbox perf-tools-next]$ ldd tools/build/feature/test-llv=
m.bin
>         linux-vdso.so.1 (0x00007ffcaf5d9000)
>         libLLVM-16.so =3D> /lib64/libLLVM-16.so (0x00007fc4faefa000)
>         libstdc++.so.6 =3D> /lib64/libstdc++.so.6 (0x00007fc4faca6000)
>         libm.so.6 =3D> /lib64/libm.so.6 (0x00007fc4fabc5000)
>         libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007fc4faba1000)
>         libc.so.6 =3D> /lib64/libc.so.6 (0x00007fc4fa9c3000)
>         libffi.so.8 =3D> /lib64/libffi.so.8 (0x00007fc4fa9b7000)
>         libedit.so.0 =3D> /lib64/libedit.so.0 (0x00007fc4fa978000)
>         libz.so.1 =3D> /lib64/libz.so.1 (0x00007fc4fa95e000)
>         libtinfo.so.6 =3D> /lib64/libtinfo.so.6 (0x00007fc4fa92b000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007fc502404000)
> =E2=AC=A2[acme@toolbox perf-tools-next]$ sudo dnf install llvm-devel
>
> I'll get this merged in my perf-tools-fixes-for-v6.6 that I'll submit
> tomorrow to Linus, thanks for reporting!
>
> I'll add your:
>
> Reported-by: Manu Bretelle <chantr4@gmail.com>
>
> And:
>
> Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang fo=
r compiling BPF events (-e foo.c)")
>
> Ok?

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo


Return-Path: <bpf+bounces-11389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C27B8659
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4CF692818D3
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE331CAB3;
	Wed,  4 Oct 2023 17:21:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F11B27D
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 17:21:28 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C89E
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 10:21:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so4089795a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440085; x=1697044885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O7d23g7y7F1jEVdZuw5V47KMhAH4ctukL8CH1bIYIc=;
        b=YzOD3RXY8kDJmsKd9s2bbnpRuidH2yTfl4b1bn33WjMvIFc0opR56L9gmjxAIc0p0W
         CLlRBdyNfpSOwBi5SNWxknG1Q6/kDHAIRVudJ9m+40jphIi2mQ8fngl3vlVV/TTS+V90
         H/SjIYZLp/+nAvPezR+MZgJLfOeqrKoab9bw/jl/hr/U1/1v03VIXRa+IB1BVyBhjZlA
         vOQojENgS9lym2WPEqKIGJkOywaRKVMmfyRvaYtg4H6bABrXEGBIRnii85YFbz85ULps
         P449E+I5RXnUNCvjip5OG+Cb/xSHq52CsZliG1JEudhx+/z42YCJUOCjtEr5LBFXf8YL
         /BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440085; x=1697044885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O7d23g7y7F1jEVdZuw5V47KMhAH4ctukL8CH1bIYIc=;
        b=hOgdNLSLi23BvsDF9kOXeiAUV0f9tMbCLtyU8jYaQZn3xMv5xh1BhASyunjCpgTXgv
         CWqA+iwM0HrNDbWrYlRcQpm0e36jZGktz+NE9n2qJSAaFAXq7e6WZZIF3aMtlqW0/83T
         x7uddf/1lphfXnXGTR090c8T7CdiLBjWN3RyhdjBTCi05IJMN6PnZ5b2tiAuu8Fzjj0J
         iHeFv5bLSrFpDYv9vdIYllfSdn0Phf4/lvYvRgVg3t3DFhhvQQ1wKVZSE0jXkNFUVG2x
         W00NZrp9iLGQPJVSDcFyC/lWTT+5L7jDrIJreWqXjnL2HrdeMVE0Jjkv5FHHEpF9PJaE
         To2A==
X-Gm-Message-State: AOJu0Yzz+5r8iyO9e10DkIo7gdbWqAqqM3r8jWAik+EXt0ZR4LCPHZJF
	N/LieolDD9K7GpQAfNIuyJ1BXd99fPn8u7NsekY=
X-Google-Smtp-Source: AGHT+IFdxB0IpCJuwwn/b9rqrJr2pa2e53YMkYg4uxpJG920AM2JanSZ7cFWhYoUpaTeHofpV+0jqn+lcxLTgVgFgdA=
X-Received: by 2002:a50:ec93:0:b0:533:97c:8413 with SMTP id
 e19-20020a50ec93000000b00533097c8413mr2631449edr.25.1696440084296; Wed, 04
 Oct 2023 10:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004001750.2939898-1-andrii@kernel.org> <20231004001750.2939898-2-andrii@kernel.org>
 <ZR0h12W2AHvquBWv@krava>
In-Reply-To: <ZR0h12W2AHvquBWv@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Oct 2023 10:21:12 -0700
Message-ID: <CAEf4Bzag+5_r05t7p2N-XiWykT51U5x4ov7YSa0NGVJrGpo6UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: support building selftests in
 optimized -O2 mode
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 1:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Oct 03, 2023 at 05:17:49PM -0700, Andrii Nakryiko wrote:
> > Add support for building selftests with -O2 level of optimization, whic=
h
> > allows more compiler warnings detection (like lots of potentially
> > uninitialized usage), but also is useful to have a faster-running test
> > for some CPU-intensive tests.
> >
> > One can build optimized versions of libbpf and selftests by running:
> >
> >   $ make RELEASE=3D1
> >
> > There is a measurable speed up of about 10 seconds for me locally,
> > though it's mostly capped by non-parallelized serial tests. User CPU
> > time goes down by total 40 seconds, from 1m10s to 0m28s.
> >
> > Unoptimized build (-O0)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Summary: 430/3544 PASSED, 25 SKIPPED, 4 FAILED
> >
> > real    1m59.937s
> > user    1m10.877s
> > sys     3m14.880s
> >
> > Optimized build (-O2)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Summary: 425/3543 PASSED, 25 SKIPPED, 9 FAILED
> >
> > real    1m50.540s
> > user    0m28.406s
> > sys     3m13.198s
>
> hi,
> I get following error when running selftest compiled with RELEASE=3D1
>
> # ./test_progs -t attach_probe/manual-legacy
> test_attach_probe:PASS:skel_open 0 nsec
> test_attach_probe:PASS:skel_load 0 nsec
> test_attach_probe:PASS:check_bss 0 nsec
> test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
> test_attach_probe_manual:PASS:uprobe_offset 0 nsec
> test_attach_probe_manual:PASS:attach_kprobe 0 nsec
> test_attach_probe_manual:PASS:attach_kretprobe 0 nsec
> test_attach_probe_manual:PASS:attach_uprobe 0 nsec
> test_attach_probe_manual:PASS:attach_uretprobe 0 nsec
> libbpf: failed to add legacy uprobe event for /proc/self/exe:0x19020: -17
> libbpf: prog 'handle_uprobe_byname': failed to create uprobe '/proc/self/=
exe:0x19020' perf event: File exists
> test_attach_probe_manual:FAIL:attach_uprobe_byname unexpected error: -17
> #8/2     attach_probe/manual-legacy:FAIL
> #8       attach_probe:FAIL
>
>
> it looks like -O2 can merge some of the trigger functions:
>
>         [root@qemu bpf]# nm test_progs | grep trigger_func
>         0000000000558f30 t autoattach_trigger_func.constprop.0
>         000000000041d240 t trigger_func
>         0000000000419020 t trigger_func
>         0000000000420e70 t trigger_func
>         0000000000507aa0 t trigger_func
>         0000000000419020 t trigger_func2
>         0000000000419020 t trigger_func3
>         0000000000419030 t trigger_func4
>         [root@qemu bpf]# nm test_progs | grep 0000000000419020
>         0000000000419020 t trigger_func
>         0000000000419020 t trigger_func2
>         0000000000419020 t trigger_func3
>
> I got more tests fails, but I suspect it's all for similar
> reason like above
>

yes, I didn't say that -O2 version passes all tests :) at least there
are complicated USDT cases under -O2 which libbpf can't support (if I
remember correctly, it was offset relative to global symbol case). But
it's the first step. And once we have ability to build with RELEASE=3D1,
we can add it as a separate test in CI and catch more of these
uninitialized usage errors. Initially we can denylist tests that are
broken due to -O2 and work to fix them.

> jirka
>
>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index a25e262dbc69..55d1b1848e6c 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -27,7 +27,9 @@ endif
> >  BPF_GCC              ?=3D $(shell command -v bpf-gcc;)
> >  SAN_CFLAGS   ?=3D
> >  SAN_LDFLAGS  ?=3D $(SAN_CFLAGS)
> > -CFLAGS +=3D -g -O0 -rdynamic                                          =
 \
> > +RELEASE              ?=3D
> > +OPT_FLAGS    ?=3D $(if $(RELEASE),-O2,-O0)
> > +CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                                 =
 \
> >         -Wall -Werror                                                 \
> >         $(GENFLAGS) $(SAN_CFLAGS)                                     \
> >         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> > @@ -241,7 +243,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL=
) $(RUNQSLOWER_OUTPUT)
> >                   BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/          =
        \
> >                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf                  =
        \
> >                   BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)      =
          \
> > -                 EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'                =
        \
> > +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'       =
        \
> >                   EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&                  =
        \
> >                   cp $(RUNQSLOWER_OUTPUT)runqslower $@
> >
> > @@ -279,7 +281,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch]=
 $(BPFTOOLDIR)/Makefile)    \
> >                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
> >       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                  =
      \
> >                   ARCH=3D CROSS_COMPILE=3D CC=3D"$(HOSTCC)" LD=3D"$(HOS=
TLD)"         \
> > -                 EXTRA_CFLAGS=3D'-g -O0'                              =
        \
> > +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'                     =
        \
> >                   OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/                  =
        \
> >                   LIBBPF_OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/            =
        \
> >                   LIBBPF_DESTDIR=3D$(HOST_SCRATCH_DIR)/                =
        \
> > @@ -290,7 +292,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $=
(BPFTOOLDIR)/Makefile) \
> >                   $(BPFOBJ) | $(BUILD_DIR)/bpftool
> >       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                  =
       \
> >                   ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE)      =
           \
> > -                 EXTRA_CFLAGS=3D'-g -O0'                              =
         \
> > +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'                     =
         \
> >                   OUTPUT=3D$(BUILD_DIR)/bpftool/                       =
         \
> >                   LIBBPF_OUTPUT=3D$(BUILD_DIR)/libbpf/                 =
         \
> >                   LIBBPF_DESTDIR=3D$(SCRATCH_DIR)/                     =
         \
> > @@ -313,7 +315,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Ma=
kefile)                       \
> >          $(APIDIR)/linux/bpf.h                                         =
      \
> >          | $(BUILD_DIR)/libbpf
> >       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=3D$(BUILD_DIR)/=
libbpf/ \
> > -                 EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'                =
        \
> > +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'       =
        \
> >                   EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)'                     =
        \
> >                   DESTDIR=3D$(SCRATCH_DIR) prefix=3D all install_header=
s
> >
> > @@ -322,7 +324,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDI=
R)/Makefile)                  \
> >               $(APIDIR)/linux/bpf.h                                    =
      \
> >               | $(HOST_BUILD_DIR)/libbpf
> >       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                       =
      \
> > -                 EXTRA_CFLAGS=3D'-g -O0' ARCH=3D CROSS_COMPILE=3D     =
            \
> > +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)' ARCH=3D CROSS_COMPIL=
E=3D        \
> >                   OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/                   =
        \
> >                   CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"                    =
          \
> >                   DESTDIR=3D$(HOST_SCRATCH_DIR)/ prefix=3D all install_=
headers
> > --
> > 2.34.1
> >
> >


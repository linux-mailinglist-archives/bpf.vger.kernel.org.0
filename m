Return-Path: <bpf+bounces-11422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689157B9B48
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 09:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6D7D1B208B2
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C65525D;
	Thu,  5 Oct 2023 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSYcnZg7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62E1C3D
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:19:35 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F73769D
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 00:19:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so1060818a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 00:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696490370; x=1697095170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iisRHyXqvyBxx2DIxf0cTIFFudU+zBIMnVVkU6ybh7c=;
        b=gSYcnZg7Ro5VTQjN/b4Db6kIXWHAwbzR7Up8LE21JvNf99IBqpGCYdGKtJy2EanbBU
         H+1uH58N3MZoPf79kwioGht+o2ExLMIiPdBpdSeztMNHfs4YiNodAmh3sObelZtna3Uk
         1yvDbpMGjIz5wnWme6K25zFY3iRZzuThuPIzxU+eLRN6gATeVpboB9Ju/U36SCXQ4O3a
         2KcDRVt2upaUM4X5b2eO8cnhemademIlIcZJjLdG0ieXJO2MxRVSznJI89QdVVP8tCyI
         Knwbpjy5UKWzbE4ij4Dabv7zE2jKCsPW4d/ZiAfzbxWMirU92q3apJO0oEt51Z2nIae1
         /YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490370; x=1697095170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iisRHyXqvyBxx2DIxf0cTIFFudU+zBIMnVVkU6ybh7c=;
        b=VoMUj2cpj2eBpkImMQV7qRUtiO0nGDSwoDNMlaXXXGJiWnkhagY0UePmuBWlJae4/d
         H8prkhp29VkcD3yiEgrBzNEp2TWJ1+SbtV5kpOAXe58sn3mVg5U6gCrqxibq2F5f78bA
         /nu5HluVYmRI9qnbgDzahSPO2UqWuROYox5x3ao+VBlNe846kyjUTtJt/sH1c0XIM66P
         kvh5OpO5W/E8LZsmdKijs3ksCkXL/D2K8BPuCvYLpQzWYJWxSHPN/uL5fdkRLQbPtELs
         mLRnALUIcINaC/81uiWGI3+vgpBe/I7/s08zwofj8mu16N7OE0C56DjGxRlxgZc7SGUM
         7SXw==
X-Gm-Message-State: AOJu0YznP//qhOdcVzp8Oxu6PwxvLKAP95RhYtU3bJdM/2+hnZDpGM6y
	E4F4C/dwdk2pUbJ8oQBbqEA=
X-Google-Smtp-Source: AGHT+IHKhYbO5MrWxZYNfeZhuBz1LKYc/yCY2dKQrKbKpADI/qFbOx2DLs0BQd3qZ/UbLw5WxiMk2w==
X-Received: by 2002:a17:907:b11:b0:9ae:699d:8a29 with SMTP id h17-20020a1709070b1100b009ae699d8a29mr3749438ejl.6.1696490370193;
        Thu, 05 Oct 2023 00:19:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b00997e00e78e6sm683004eji.112.2023.10.05.00.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:19:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Oct 2023 09:19:26 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: support building selftests
 in optimized -O2 mode
Message-ID: <ZR5jfh939hHLtnED@krava>
References: <20231004001750.2939898-1-andrii@kernel.org>
 <20231004001750.2939898-2-andrii@kernel.org>
 <ZR0h12W2AHvquBWv@krava>
 <CAEf4Bzag+5_r05t7p2N-XiWykT51U5x4ov7YSa0NGVJrGpo6UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzag+5_r05t7p2N-XiWykT51U5x4ov7YSa0NGVJrGpo6UQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 10:21:12AM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 4, 2023 at 1:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Oct 03, 2023 at 05:17:49PM -0700, Andrii Nakryiko wrote:
> > > Add support for building selftests with -O2 level of optimization, which
> > > allows more compiler warnings detection (like lots of potentially
> > > uninitialized usage), but also is useful to have a faster-running test
> > > for some CPU-intensive tests.
> > >
> > > One can build optimized versions of libbpf and selftests by running:
> > >
> > >   $ make RELEASE=1
> > >
> > > There is a measurable speed up of about 10 seconds for me locally,
> > > though it's mostly capped by non-parallelized serial tests. User CPU
> > > time goes down by total 40 seconds, from 1m10s to 0m28s.
> > >
> > > Unoptimized build (-O0)
> > > =======================
> > > Summary: 430/3544 PASSED, 25 SKIPPED, 4 FAILED
> > >
> > > real    1m59.937s
> > > user    1m10.877s
> > > sys     3m14.880s
> > >
> > > Optimized build (-O2)
> > > =====================
> > > Summary: 425/3543 PASSED, 25 SKIPPED, 9 FAILED
> > >
> > > real    1m50.540s
> > > user    0m28.406s
> > > sys     3m13.198s
> >
> > hi,
> > I get following error when running selftest compiled with RELEASE=1
> >
> > # ./test_progs -t attach_probe/manual-legacy
> > test_attach_probe:PASS:skel_open 0 nsec
> > test_attach_probe:PASS:skel_load 0 nsec
> > test_attach_probe:PASS:check_bss 0 nsec
> > test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> > test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
> > test_attach_probe_manual:PASS:uprobe_offset 0 nsec
> > test_attach_probe_manual:PASS:attach_kprobe 0 nsec
> > test_attach_probe_manual:PASS:attach_kretprobe 0 nsec
> > test_attach_probe_manual:PASS:attach_uprobe 0 nsec
> > test_attach_probe_manual:PASS:attach_uretprobe 0 nsec
> > libbpf: failed to add legacy uprobe event for /proc/self/exe:0x19020: -17
> > libbpf: prog 'handle_uprobe_byname': failed to create uprobe '/proc/self/exe:0x19020' perf event: File exists
> > test_attach_probe_manual:FAIL:attach_uprobe_byname unexpected error: -17
> > #8/2     attach_probe/manual-legacy:FAIL
> > #8       attach_probe:FAIL
> >
> >
> > it looks like -O2 can merge some of the trigger functions:
> >
> >         [root@qemu bpf]# nm test_progs | grep trigger_func
> >         0000000000558f30 t autoattach_trigger_func.constprop.0
> >         000000000041d240 t trigger_func
> >         0000000000419020 t trigger_func
> >         0000000000420e70 t trigger_func
> >         0000000000507aa0 t trigger_func
> >         0000000000419020 t trigger_func2
> >         0000000000419020 t trigger_func3
> >         0000000000419030 t trigger_func4
> >         [root@qemu bpf]# nm test_progs | grep 0000000000419020
> >         0000000000419020 t trigger_func
> >         0000000000419020 t trigger_func2
> >         0000000000419020 t trigger_func3
> >
> > I got more tests fails, but I suspect it's all for similar
> > reason like above
> >
> 
> yes, I didn't say that -O2 version passes all tests :) at least there
> are complicated USDT cases under -O2 which libbpf can't support (if I
> remember correctly, it was offset relative to global symbol case). But
> it's the first step. And once we have ability to build with RELEASE=1,
> we can add it as a separate test in CI and catch more of these
> uninitialized usage errors. Initially we can denylist tests that are
> broken due to -O2 and work to fix them.

I see ;-) sounds good

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> > jirka
> >
> >
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index a25e262dbc69..55d1b1848e6c 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -27,7 +27,9 @@ endif
> > >  BPF_GCC              ?= $(shell command -v bpf-gcc;)
> > >  SAN_CFLAGS   ?=
> > >  SAN_LDFLAGS  ?= $(SAN_CFLAGS)
> > > -CFLAGS += -g -O0 -rdynamic                                           \
> > > +RELEASE              ?=
> > > +OPT_FLAGS    ?= $(if $(RELEASE),-O2,-O0)
> > > +CFLAGS += -g $(OPT_FLAGS) -rdynamic                                  \
> > >         -Wall -Werror                                                 \
> > >         $(GENFLAGS) $(SAN_CFLAGS)                                     \
> > >         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> > > @@ -241,7 +243,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
> > >                   BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/                  \
> > >                   BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf                          \
> > >                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)                \
> > > -                 EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'                        \
> > > +                 EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'               \
> > >                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&                          \
> > >                   cp $(RUNQSLOWER_OUTPUT)runqslower $@
> > >
> > > @@ -279,7 +281,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> > >                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
> > >       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                        \
> > >                   ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)"         \
> > > -                 EXTRA_CFLAGS='-g -O0'                                      \
> > > +                 EXTRA_CFLAGS='-g $(OPT_FLAGS)'                             \
> > >                   OUTPUT=$(HOST_BUILD_DIR)/bpftool/                          \
> > >                   LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/                    \
> > >                   LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/                        \
> > > @@ -290,7 +292,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile) \
> > >                   $(BPFOBJ) | $(BUILD_DIR)/bpftool
> > >       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                         \
> > >                   ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)                 \
> > > -                 EXTRA_CFLAGS='-g -O0'                                       \
> > > +                 EXTRA_CFLAGS='-g $(OPT_FLAGS)'                              \
> > >                   OUTPUT=$(BUILD_DIR)/bpftool/                                \
> > >                   LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/                          \
> > >                   LIBBPF_DESTDIR=$(SCRATCH_DIR)/                              \
> > > @@ -313,7 +315,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                       \
> > >          $(APIDIR)/linux/bpf.h                                               \
> > >          | $(BUILD_DIR)/libbpf
> > >       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
> > > -                 EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'                        \
> > > +                 EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'               \
> > >                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)'                             \
> > >                   DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
> > >
> > > @@ -322,7 +324,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                  \
> > >               $(APIDIR)/linux/bpf.h                                          \
> > >               | $(HOST_BUILD_DIR)/libbpf
> > >       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
> > > -                 EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=                 \
> > > +                 EXTRA_CFLAGS='-g $(OPT_FLAGS)' ARCH= CROSS_COMPILE=        \
> > >                   OUTPUT=$(HOST_BUILD_DIR)/libbpf/                           \
> > >                   CC="$(HOSTCC)" LD="$(HOSTLD)"                              \
> > >                   DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
> > > --
> > > 2.34.1
> > >
> > >


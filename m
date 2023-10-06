Return-Path: <bpf+bounces-11549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF747BBE10
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AD41C20A26
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993FE3418B;
	Fri,  6 Oct 2023 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8nR9qv3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA5286AB
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 17:55:27 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67681B6
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 10:55:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso4382527a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696614924; x=1697219724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huShWRIzhFtDGCQ/26hF8vgywbf7lsjxexLEL3k5A1s=;
        b=W8nR9qv3Yv8CBbHSSSQMvP3SMG9vsjgTiro4x+uVWsRVoclKyy34+2GtIPM5qm25rS
         m5i/RTMVTxzBECwLha5k/Lzvo33O4u73jOuidExKr9OYkd9zUIOuGRBaWcRfoNy2sVH8
         TQQZ4/XWOoNYdHZFW0dBzYPsPs0P2FBSmwWt5/RtQPQ6QtkDnRryrr0ijWaNbgVw6x2m
         BEDHh5N3C/y1apaAHC43pao2vUtijvc03i+uLcNoGr2IQCZ9UDmmcL8/FLXZMRlrPKgF
         G9NUgtJO4/Khk4sECb0Llb+OT1JQKYpscNoWnaWIiWIPryuu1ua8Ij4GydyWhdUd9M4/
         K7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696614924; x=1697219724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huShWRIzhFtDGCQ/26hF8vgywbf7lsjxexLEL3k5A1s=;
        b=fpbJK7JicmANhST7zaGlObZJHdmQHZ7RItm4uey5wj2Gn+NW45A+56qzY99VBI1JII
         GGamGX+7iCyV7Jh0Qpn21CDZDypdRwsh9cpR+LKGdyONVjxCEGnQJdKJLsVSE70uSY4L
         nOnSDtBbM/iKTF26HpOe3bie4l5NtRCGm3gJmC1PIBl8WmUajH5apKS43Zh56feZnK9K
         Nitt5bRa6VRzPUNk5o4djymkpAyTXQRLreE2KD38EGmm6q2rdaAZg+KMNhUX+ubmpoxW
         WW6mtvsryl+rUrg/wfLywJqaQEVqF6jJInk1eJREmZaCWhaYdmC0ivJbP+1H0ILuHNDk
         u/NA==
X-Gm-Message-State: AOJu0YyLwzpO4CoYNJaHsSdA1QJdzn1cDW6GzT6xFyXT5CghU3o7W4rc
	bY79Y0FtVHsMt9oGJa7IlcztNhk2CRvvjnfqE8w=
X-Google-Smtp-Source: AGHT+IEC6iid7cHPJa29Ub9Kb34wujmuuTzh9mvh13Q1Q8Q+eOCXjGmtjbg1vSZBN8RKihTZWXZgr7AXXeVOJ18Oon4=
X-Received: by 2002:aa7:c301:0:b0:523:2e0e:5462 with SMTP id
 l1-20020aa7c301000000b005232e0e5462mr6815732edq.42.1696614923430; Fri, 06 Oct
 2023 10:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004001750.2939898-1-andrii@kernel.org> <20231004001750.2939898-2-andrii@kernel.org>
 <ZR0h12W2AHvquBWv@krava> <CAEf4Bzag+5_r05t7p2N-XiWykT51U5x4ov7YSa0NGVJrGpo6UQ@mail.gmail.com>
 <ZR5jfh939hHLtnED@krava> <e4993aa4-2162-b227-d14e-6d521931c6e0@oracle.com>
In-Reply-To: <e4993aa4-2162-b227-d14e-6d521931c6e0@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Oct 2023 10:55:11 -0700
Message-ID: <CAEf4BzbJwHJDF1ZmNrWXRfg1OTr3pt4sfCfp8xBwu9P5TUY6Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: support building selftests in
 optimized -O2 mode
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 2:04=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 05/10/2023 08:19, Jiri Olsa wrote:
> > On Wed, Oct 04, 2023 at 10:21:12AM -0700, Andrii Nakryiko wrote:
> >> On Wed, Oct 4, 2023 at 1:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> >>>
> >>> On Tue, Oct 03, 2023 at 05:17:49PM -0700, Andrii Nakryiko wrote:
> >>>> Add support for building selftests with -O2 level of optimization, w=
hich
> >>>> allows more compiler warnings detection (like lots of potentially
> >>>> uninitialized usage), but also is useful to have a faster-running te=
st
> >>>> for some CPU-intensive tests.
> >>>>
> >>>> One can build optimized versions of libbpf and selftests by running:
> >>>>
> >>>>   $ make RELEASE=3D1
> >>>>
> >>>> There is a measurable speed up of about 10 seconds for me locally,
> >>>> though it's mostly capped by non-parallelized serial tests. User CPU
> >>>> time goes down by total 40 seconds, from 1m10s to 0m28s.
> >>>>
> >>>> Unoptimized build (-O0)
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>>> Summary: 430/3544 PASSED, 25 SKIPPED, 4 FAILED
> >>>>
> >>>> real    1m59.937s
> >>>> user    1m10.877s
> >>>> sys     3m14.880s
> >>>>
> >>>> Optimized build (-O2)
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> Summary: 425/3543 PASSED, 25 SKIPPED, 9 FAILED
> >>>>
> >>>> real    1m50.540s
> >>>> user    0m28.406s
> >>>> sys     3m13.198s
> >>>
> >>> hi,
> >>> I get following error when running selftest compiled with RELEASE=3D1
> >>>
> >>> # ./test_progs -t attach_probe/manual-legacy
> >>> test_attach_probe:PASS:skel_open 0 nsec
> >>> test_attach_probe:PASS:skel_load 0 nsec
> >>> test_attach_probe:PASS:check_bss 0 nsec
> >>> test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> >>> test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
> >>> test_attach_probe_manual:PASS:uprobe_offset 0 nsec
> >>> test_attach_probe_manual:PASS:attach_kprobe 0 nsec
> >>> test_attach_probe_manual:PASS:attach_kretprobe 0 nsec
> >>> test_attach_probe_manual:PASS:attach_uprobe 0 nsec
> >>> test_attach_probe_manual:PASS:attach_uretprobe 0 nsec
> >>> libbpf: failed to add legacy uprobe event for /proc/self/exe:0x19020:=
 -17
> >>> libbpf: prog 'handle_uprobe_byname': failed to create uprobe '/proc/s=
elf/exe:0x19020' perf event: File exists
> >>> test_attach_probe_manual:FAIL:attach_uprobe_byname unexpected error: =
-17
> >>> #8/2     attach_probe/manual-legacy:FAIL
> >>> #8       attach_probe:FAIL
> >>>
> >>>
> >>> it looks like -O2 can merge some of the trigger functions:
> >>>
> >>>         [root@qemu bpf]# nm test_progs | grep trigger_func
> >>>         0000000000558f30 t autoattach_trigger_func.constprop.0
> >>>         000000000041d240 t trigger_func
> >>>         0000000000419020 t trigger_func
> >>>         0000000000420e70 t trigger_func
> >>>         0000000000507aa0 t trigger_func
> >>>         0000000000419020 t trigger_func2
> >>>         0000000000419020 t trigger_func3
> >>>         0000000000419030 t trigger_func4
> >>>         [root@qemu bpf]# nm test_progs | grep 0000000000419020
> >>>         0000000000419020 t trigger_func
> >>>         0000000000419020 t trigger_func2
> >>>         0000000000419020 t trigger_func3
> >>>
> >>> I got more tests fails, but I suspect it's all for similar
> >>> reason like above
> >>>
> >>
>
> This one is an interesting failure that definitely seems worth fixing;
> as above trigger_func2 and trigger_func3 were merged it looks like, and
> the legacy perf_event_kprobe_open_legacy()-based attach failed due to
> add_uprobe_event_legacy() failing. The latter seems to be down to the
> way that gen_uprobe_legacy_event_name() constructs legacy event names
> via pid, binary_path and offset. In this case it will construct the
> same name for trigger_func2 and trigger_func3, hence the -EEXIST.
>
> It _seems_ like a fix here would be to add an optional func_name to
> gen_uprobe_legacy_event_name(). At least it appears that the non-legacy
> attach handles this case, which is great. Regardless, we can follow
> up with some of this stuff later.

Yeah, let's fix this up as a follow up. I'm not sure about using
function name as part of uprobe name, mostly because these symbol
names can be super long, and I don't know what's kernel size limits.
So we probably want to keep them bounded in size. Having said that,
seems like we use binary path and we also don't sanitize that. So I
think we should try to fix all that as a follow up: sanitize and maybe
truncate binary_path, and generally make sure that each uprobe name is
unique (probably with atomic counter). This atomic static counter will
take care of all such issues, right? Maybe we should drop the binary
path from the uprobe name altogether with that?

Either way, thanks for taking a deeper look into failures!

>
> >> yes, I didn't say that -O2 version passes all tests :) at least there
> >> are complicated USDT cases under -O2 which libbpf can't support (if I
> >> remember correctly, it was offset relative to global symbol case). But
> >> it's the first step. And once we have ability to build with RELEASE=3D=
1,
> >> we can add it as a separate test in CI and catch more of these
> >> uninitialized usage errors. Initially we can denylist tests that are
> >> broken due to -O2 and work to fix them.
> >
>
> Sounds good to me; it's a great change as we're more likely to hit
> more problems that users run into.

yep

>
> For the series:
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > I see ;-) sounds good
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > jirka
> >
> >>
> >>> jirka
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>>> ---
> >>>>  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
> >>>>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/se=
lftests/bpf/Makefile
> >>>> index a25e262dbc69..55d1b1848e6c 100644
> >>>> --- a/tools/testing/selftests/bpf/Makefile
> >>>> +++ b/tools/testing/selftests/bpf/Makefile
> >>>> @@ -27,7 +27,9 @@ endif
> >>>>  BPF_GCC              ?=3D $(shell command -v bpf-gcc;)
> >>>>  SAN_CFLAGS   ?=3D
> >>>>  SAN_LDFLAGS  ?=3D $(SAN_CFLAGS)
> >>>> -CFLAGS +=3D -g -O0 -rdynamic                                       =
    \
> >>>> +RELEASE              ?=3D
> >>>> +OPT_FLAGS    ?=3D $(if $(RELEASE),-O2,-O0)
> >>>> +CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                              =
    \
> >>>>         -Wall -Werror                                               =
  \
> >>>>         $(GENFLAGS) $(SAN_CFLAGS)                                   =
  \
> >>>>         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)        =
  \
> >>>> @@ -241,7 +243,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFT=
OOL) $(RUNQSLOWER_OUTPUT)
> >>>>                   BPFTOOL_OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/       =
           \
> >>>>                   BPFOBJ_OUTPUT=3D$(BUILD_DIR)/libbpf               =
           \
> >>>>                   BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)   =
             \
> >>>> -                 EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'             =
           \
> >>>> +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'    =
           \
> >>>>                   EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)' &&               =
           \
> >>>>                   cp $(RUNQSLOWER_OUTPUT)runqslower $@
> >>>>
> >>>> @@ -279,7 +281,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[=
ch] $(BPFTOOLDIR)/Makefile)    \
> >>>>                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
> >>>>       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)               =
         \
> >>>>                   ARCH=3D CROSS_COMPILE=3D CC=3D"$(HOSTCC)" LD=3D"$(=
HOSTLD)"         \
> >>>> -                 EXTRA_CFLAGS=3D'-g -O0'                           =
           \
> >>>> +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'                  =
           \
> >>>>                   OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/               =
           \
> >>>>                   LIBBPF_OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/         =
           \
> >>>>                   LIBBPF_DESTDIR=3D$(HOST_SCRATCH_DIR)/             =
           \
> >>>> @@ -290,7 +292,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch=
] $(BPFTOOLDIR)/Makefile) \
> >>>>                   $(BPFOBJ) | $(BUILD_DIR)/bpftool
> >>>>       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)               =
          \
> >>>>                   ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE)   =
              \
> >>>> -                 EXTRA_CFLAGS=3D'-g -O0'                           =
            \
> >>>> +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)'                  =
            \
> >>>>                   OUTPUT=3D$(BUILD_DIR)/bpftool/                    =
            \
> >>>>                   LIBBPF_OUTPUT=3D$(BUILD_DIR)/libbpf/              =
            \
> >>>>                   LIBBPF_DESTDIR=3D$(SCRATCH_DIR)/                  =
            \
> >>>> @@ -313,7 +315,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)=
/Makefile)                       \
> >>>>          $(APIDIR)/linux/bpf.h                                      =
         \
> >>>>          | $(BUILD_DIR)/libbpf
> >>>>       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=3D$(BUILD_DI=
R)/libbpf/ \
> >>>> -                 EXTRA_CFLAGS=3D'-g -O0 $(SAN_CFLAGS)'             =
           \
> >>>> +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'    =
           \
> >>>>                   EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)'                  =
           \
> >>>>                   DESTDIR=3D$(SCRATCH_DIR) prefix=3D all install_hea=
ders
> >>>>
> >>>> @@ -322,7 +324,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BP=
FDIR)/Makefile)                  \
> >>>>               $(APIDIR)/linux/bpf.h                                 =
         \
> >>>>               | $(HOST_BUILD_DIR)/libbpf
> >>>>       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                    =
         \
> >>>> -                 EXTRA_CFLAGS=3D'-g -O0' ARCH=3D CROSS_COMPILE=3D  =
               \
> >>>> +                 EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)' ARCH=3D CROSS_COM=
PILE=3D        \
> >>>>                   OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/                =
           \
> >>>>                   CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"                 =
             \
> >>>>                   DESTDIR=3D$(HOST_SCRATCH_DIR)/ prefix=3D all insta=
ll_headers
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>>
> >


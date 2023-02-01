Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FABA68701E
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 21:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBAUwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 15:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBAUw3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 15:52:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C225E10;
        Wed,  1 Feb 2023 12:51:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mc11so103385ejb.10;
        Wed, 01 Feb 2023 12:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WEnT4l/7Vbds6HefVySnPsb+qjWoxpoG0FxO7t7bEx8=;
        b=DyjGhOuky6W+MfYyZaJi0dNRwHTMl15zu9ox7MK5HRBMBR79juayr42JXBEfDWNzMx
         oWbM8eshpTYd228MtWzLW0s6kTMZeZF+azmKKBfycYuivhetmfDtrJWbPiGC20opzThc
         /pzEyHMMN7xp+cKMgxuKanJw/ijsi29hbN90VHbXRwR0Anu0yqq365/E95wiuMSp3MpQ
         W2lXTFjOQFvPCpTR3qEl+uFgrKeKi5NkaBQukbiVrvHEHByvpretkVf1aD3RU8vbwtvd
         TlxYO3Tm/saSEziIkKjk+6h60TsnxgqYm3hg1IG3o5pSmAdrGk+GGTdnhV+YSpsxYUHD
         fQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEnT4l/7Vbds6HefVySnPsb+qjWoxpoG0FxO7t7bEx8=;
        b=i0Ri6JWqie++DGe7sM4xyaLFa6/3VsdJ/nIkZ4+98PpEJFCzFCodvYiefYsE884JR2
         ukY8oehTP36Glgv7g5Zhqb4pMRsvjfyqPVR2aV1F5gqNhkjidA2/ngu7n9hIXOIvH+7o
         gfHxCXIK/Iqn8DiEihM2WJMuPyrq2ssT5dm0hkkrCHySGRXiNdtFNVBEoZpc+m35Qw9T
         gr7nnNfVk+/iXMMwDr62S9GtaSGFHSWzpqhebXylepgb/uqJESCHGP4ZnZInobxgHfB1
         MQYri0tK0yS05XMZjsyth3+lMI3johz0H4mrcX3isKSrjf3VGPwxNn2zFPASP7mDs6W/
         dDwg==
X-Gm-Message-State: AO0yUKU4mkOd4y7cSmBlLHs1x8Hr2ntTjU6nqnyoYGdoWU9wTk4OKssk
        vjqKj1CryK5cCQ9BS3JsLMQ=
X-Google-Smtp-Source: AK7set9snvYN/79UB77jFPicwMopjHHbSECyElISmuL2h/2imsbcMwtelDIpgN5xSl9idd/224LBmg==
X-Received: by 2002:a17:907:8dcd:b0:87b:6bbb:11ac with SMTP id tg13-20020a1709078dcd00b0087b6bbb11acmr4162297ejc.60.1675284640623;
        Wed, 01 Feb 2023 12:50:40 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b0088224df181asm7665987ejd.224.2023.02.01.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:50:40 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 1 Feb 2023 21:50:38 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <Y9rQnu6KPj1t8Rog@krava>
References: <20230201015015.359535-1-irogers@google.com>
 <Y9o4H61YmbOSCDOG@krava>
 <Y9pCY5IcYEqfNgBX@krava>
 <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 10:57:40AM -0800, Ian Rogers wrote:
> On Wed, Feb 1, 2023 at 2:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 01, 2023 at 11:00:02AM +0100, Jiri Olsa wrote:
> > > On Tue, Jan 31, 2023 at 05:50:15PM -0800, Ian Rogers wrote:
> > > > Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
> > > > HOSTCFLAGS for submake builds. This fixes problems with cross
> > > > compilation.
> > > >
> > > > Tidy to not unnecessarily modify/export CFLAGS, make the override for
> > > > prepare and build clearer.
> > > >
> > > > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > hum, that seems to build just the fixdep and skip the resolve_btfids binary
> > >
> > > make[1]: Entering directory '/home/jolsa/kernel/linux-qemu/build'
> > >   GEN     Makefile
> > >   CALL    ../scripts/checksyscalls.sh
> > >   DESCEND bpf/resolve_btfids
> > >   HOSTCC  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep.o
> > >   HOSTLD  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep-in.o
> > >   LINK    /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep
> > >   UPD     include/generated/utsversion.h
> > >   CC      init/version-timestamp.o
> > >   LD      .tmp_vmlinux.btf
> > >   BTF     .btf.vmlinux.bin.o
> > > die__process_unit: DW_TAG_label (0xa) @ <0x4f0d4> not handled!
> > >
> > >   ...
> > >
> > > die__process_unit: DW_TAG_label (0xa) @ <0xaf91cc3> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0xb032fa7> not handled!
> > >   LD      .tmp_vmlinux.kallsyms1
> > >   NM      .tmp_vmlinux.kallsyms1.syms
> > >   KSYMS   .tmp_vmlinux.kallsyms1.S
> > >   AS      .tmp_vmlinux.kallsyms1.S
> > >   LD      .tmp_vmlinux.kallsyms2
> > >   NM      .tmp_vmlinux.kallsyms2.syms
> > >   KSYMS   .tmp_vmlinux.kallsyms2.S
> > >   AS      .tmp_vmlinux.kallsyms2.S
> > >   LD      .tmp_vmlinux.kallsyms3
> > >   NM      .tmp_vmlinux.kallsyms3.syms
> > >   KSYMS   .tmp_vmlinux.kallsyms3.S
> > >   AS      .tmp_vmlinux.kallsyms3.S
> > >   LD      vmlinux
> > >   BTFIDS  vmlinux
> > > ../scripts/link-vmlinux.sh: line 277: ./tools/bpf/resolve_btfids/resolve_btfids: No such file or directory
> > > make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 127
> > > make[2]: *** Deleting file 'vmlinux'
> > > make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1264: vmlinux] Error 2
> > > make[1]: Leaving directory '/home/jolsa/kernel/linux-qemu/build'
> > > make: *** [Makefile:242: __sub-make] Error 2
> > >
> > > we actually have the hostprogs support in tools/build and we use it for
> > > fixdep, I think we should use it also here, I'll check
> >
> > it doesn't look that bad.. the change below fixes the build for me,
> > perhaps we should do that for all the host tools
> >
> > jirka
> 
> I don't mind this. The fixdep vs all thing is just cause by the
> ordering in the Makefile, you can fix by specifying the target or add
> this patch:
> ```
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -58,11 +58,11 @@ HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \
> 
> LIBS = $(LIBELF_LIBS) -lz
> 
> +all: $(BINARY)
> +
> export srctree OUTPUT Q
> include $(srctree)/tools/build/Makefile.include
> 
> -all: $(BINARY)
> -
> prepare: $(BPFOBJ) $(SUBCMDOBJ)
> 
> $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> ```
> 
> Should we do this and the hostprogs migration as a follow up? There
> isn't that much use of hostprogs in tools, but I like that your change
> will show HOSTCC rather than CC during compilation. If we use
> hostprogs can we just avoid the overrides altogether?

right, I think so.. we can now remove it for the BINARY target and
then for the rest of 'prepare' once they are converted to hostprogs..
not sure how 'hostprogs' will work for library, will need to check

I'll try to send the format patch with the fix below tomorrow

Nathan, any chance you could test it?

thanks,
jirka

> 
> Thanks,
> Ian
> 
> >
> > ---
> > diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> > index ae82da03f9bf..077de3829c72 100644
> > --- a/tools/bpf/resolve_btfids/Build
> > +++ b/tools/bpf/resolve_btfids/Build
> > @@ -1,3 +1,5 @@
> > +hostprogs := resolve_btfids
> > +
> >  resolve_btfids-y += main.o
> >  resolve_btfids-y += rbtree.o
> >  resolve_btfids-y += zalloc.o
> > @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
> >
> >  $(OUTPUT)%.o: ../../lib/%.c FORCE
> >         $(call rule_mkdir)
> > -       $(call if_changed_dep,cc_o_c)
> > +       $(call if_changed_dep,host_cc_o_c)
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > index daed388aa5d7..de513fd08535 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
> >                   EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> >
> >  RM      ?= rm
> > +HOSTCC  ?= gcc
> > +HOSTLD  ?= ld
> > +HOSTAR  ?= ar
> >  CROSS_COMPILE =
> >
> >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> >
> > -CFLAGS += -g \
> > +HOSTCFLAGS += -g \
> >            -I$(srctree)/tools/include \
> >            -I$(srctree)/tools/include/uapi \
> >            -I$(LIBBPF_INCLUDE) \
> > @@ -73,7 +76,7 @@ CFLAGS += -g \
> >
> >  LIBS = $(LIBELF_LIBS) -lz
> >
> > -export srctree OUTPUT CFLAGS Q
> > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> >  include $(srctree)/tools/build/Makefile.include
> >
> >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)

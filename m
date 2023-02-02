Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34775687C57
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 12:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBBLdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 06:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjBBLct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 06:32:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C48AC19;
        Thu,  2 Feb 2023 03:32:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d14so1395028wrr.9;
        Thu, 02 Feb 2023 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUsF6Q+s4fboI4afVIjhwNpT1taWE989m3DLZIX71Z0=;
        b=Bk6GGl6E4nNpoDDwJOi52GtbpFORoTqsWjgYixfUSAJrdE7iziw65rdNE8tnvvvVFH
         e8dfZokXLs43k9VzST+A5bG8r8P3OnbOSJTq85ov6M67qbUCeSqBIKhMAe1T686gwS0D
         AX+qt7FVXekdtMm3eofM62Tw8GvPc4Ckx/Y9fQHOyxPWZRq+7a86bTw8YnShGRXoISyL
         y3jZ8Gm690B+6OyF3QUrcj8ykE9fSYdurYYgY0KASnz11DX51szkNG3VKb5fqPjIeqxg
         GEvdN00iV+3PYfHoOvIPS1998O+cpSEUqAS85+2yN3mQT8VnfjuBuCrIU77F97qGeGRH
         Gxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUsF6Q+s4fboI4afVIjhwNpT1taWE989m3DLZIX71Z0=;
        b=BBeHk3UE2jaC7rgu28Np/c0L34z321wGwkQzbNvIVMTkkVb6SacHBGNVydguhuPUrp
         gdc5jc3ZAfRV0jeBGYHLDCq1Vu+JUc1FijnBffWtPtLS7zq3UYbJa1IpQi0MxTU/kD7P
         ClRu95gq6szqiwgpOnLm2KxOcIt6JAKYq2TNb3hRxQaccJlCnyDgkPvic64oqca2on6x
         wB4GCSzXeLw12IVr0i7k++4dqJZ4g75WlsyvsekVgLi2EDCHccQ6efj+CCvLGfARGwa3
         UKiWFgnsf5i1r44ueSxqjEC3UPM/NvR1NT/sDdkyJTPa5doommxJ+ABTLY/3qvmRXxgP
         CJ7w==
X-Gm-Message-State: AO0yUKXWStIt7bgmm99slSq/R/UEv7UmQ0hZoq669ysCehT4qMo97uMs
        aAfp+Myh96O6l/CXhpSy5sY=
X-Google-Smtp-Source: AK7set9Gyw3LYvIMkWMgSGVcfZCuXWfjDeOi0kV4eOoEgid6etjDTPPQdj7d9eCr7hCxJii0daVJdw==
X-Received: by 2002:a05:6000:16c4:b0:2bf:be35:2303 with SMTP id h4-20020a05600016c400b002bfbe352303mr6174926wrf.34.1675337555096;
        Thu, 02 Feb 2023 03:32:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm16843929wrm.43.2023.02.02.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 03:32:34 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 2 Feb 2023 12:32:33 +0100
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
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
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <Y9ufUdzOSp9y9qQA@krava>
References: <20230201015015.359535-1-irogers@google.com>
 <Y9o4H61YmbOSCDOG@krava>
 <Y9pCY5IcYEqfNgBX@krava>
 <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
 <Y9rQnu6KPj1t8Rog@krava>
 <Y9rXzIm3UY7lzYFt@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9rXzIm3UY7lzYFt@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 02:21:16PM -0700, Nathan Chancellor wrote:

SNIP

> > > Should we do this and the hostprogs migration as a follow up? There
> > > isn't that much use of hostprogs in tools, but I like that your change
> > > will show HOSTCC rather than CC during compilation. If we use
> > > hostprogs can we just avoid the overrides altogether?
> > 
> > right, I think so.. we can now remove it for the BINARY target and
> > then for the rest of 'prepare' once they are converted to hostprogs..
> > not sure how 'hostprogs' will work for library, will need to check
> > 
> > I'll try to send the format patch with the fix below tomorrow
> > 
> > Nathan, any chance you could test it?
> 
> 
> Sure thing, would you happen to have a single patch file of what I
> should test? I am a little confused from reading the thread (unless what
> you want tested has not been sent yet).

I meant the change below, but I posted the formal patch now:
  https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/T/#u

thanks,
jirka

> 
> Cheers,
> Nathan
> 
> > > > ---
> > > > diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> > > > index ae82da03f9bf..077de3829c72 100644
> > > > --- a/tools/bpf/resolve_btfids/Build
> > > > +++ b/tools/bpf/resolve_btfids/Build
> > > > @@ -1,3 +1,5 @@
> > > > +hostprogs := resolve_btfids
> > > > +
> > > >  resolve_btfids-y += main.o
> > > >  resolve_btfids-y += rbtree.o
> > > >  resolve_btfids-y += zalloc.o
> > > > @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
> > > >
> > > >  $(OUTPUT)%.o: ../../lib/%.c FORCE
> > > >         $(call rule_mkdir)
> > > > -       $(call if_changed_dep,cc_o_c)
> > > > +       $(call if_changed_dep,host_cc_o_c)
> > > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > > index daed388aa5d7..de513fd08535 100644
> > > > --- a/tools/bpf/resolve_btfids/Makefile
> > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
> > > >                   EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > >
> > > >  RM      ?= rm
> > > > +HOSTCC  ?= gcc
> > > > +HOSTLD  ?= ld
> > > > +HOSTAR  ?= ar
> > > >  CROSS_COMPILE =
> > > >
> > > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > > > @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> > > >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> > > >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> > > >
> > > > -CFLAGS += -g \
> > > > +HOSTCFLAGS += -g \
> > > >            -I$(srctree)/tools/include \
> > > >            -I$(srctree)/tools/include/uapi \
> > > >            -I$(LIBBPF_INCLUDE) \
> > > > @@ -73,7 +76,7 @@ CFLAGS += -g \
> > > >
> > > >  LIBS = $(LIBELF_LIBS) -lz
> > > >
> > > > -export srctree OUTPUT CFLAGS Q
> > > > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> > > >  include $(srctree)/tools/build/Makefile.include
> > > >
> > > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)

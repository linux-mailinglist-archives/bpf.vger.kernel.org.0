Return-Path: <bpf+bounces-9979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFA79FE1F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DEAB20ACC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA818C11;
	Thu, 14 Sep 2023 08:17:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029D18AE7
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 08:17:36 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4851BB
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 01:17:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso731713a12.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694679454; x=1695284254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+4xA51e50qcAOLVbeVHWO2Emck9tyiK2RitlpZpuLo=;
        b=q1oY3AesN/of+FyiAnxZUDXnqTiA3iBhNXE9cC12rQqvvbI0VhXxiSfqrUOz7gZfZf
         ybZdvxXWgj2P13T3z2+zJdvUowkuYZqPH30BDf+Ww08ZP7tLVHxjslVCq7CAb+9FUJVY
         /HCoQy8xwquOa1oM2P0CsIhI4pAAEuFZhTGEQCzT3BcfMoopTBA9EHb/WsLtp5RUCW3I
         JtlZ+q5dU7Dzg7CP9Mnyjvf7LJ2FJE/kVTmbR8HqwdkeuRazv7KjA3Adz6M1Orn4ezL/
         rFboh8YsS7v8qIZ3MQZTPR3NtA2yU1OjFza1BiVT19JbwENeOW+EQZ1lDYwEvrkqqoKM
         7pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679454; x=1695284254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+4xA51e50qcAOLVbeVHWO2Emck9tyiK2RitlpZpuLo=;
        b=cyEW+P6vuiMq3owg/n9T48nUGB/20axGncp5jhAjnhFgCZHBfo0Eq+1ei4Q30p9jDn
         FiRsO3xcKmpHAlYuBqmrEXHI8hUVbDGMcvbMeZZza+AByRfQBTGgQck5NbD0ys0dVUMM
         KLCZk45TLW+FHwu3lgMuKA1r592xxufIVQWf40mP3hyT7FbT3l9oCh3l5jIqQgwWXKGL
         o1YDrAsEJ3O7lpx7SvcuIlzjsz2ESuErKqL53xC7QdQgfCpNvyeKJIad1p6NiiOaY5pq
         Ppsp0RedWajRRp/RhUoQKyrFNriVgFHzwZOm3ck8sgZqsYY+XY+RzcF1elco9C1y1Q3F
         FxqA==
X-Gm-Message-State: AOJu0Ywdt+4Bo4RL9htSZsHRpiKL4P4TZSdpa4wNjO3wc1/luwmDFpHl
	3r+Pf5OpOmbxu0VWxzQyUzg=
X-Google-Smtp-Source: AGHT+IEk66RycSq2aMAN7gAM5SD7uAov8vv/Ix10Nl9fbCXph87QAOEZ2YlWHc2WoH4gz4d1l+S8/Q==
X-Received: by 2002:aa7:c71a:0:b0:522:1bdd:d41a with SMTP id i26-20020aa7c71a000000b005221bddd41amr4416512edq.4.1694679454408;
        Thu, 14 Sep 2023 01:17:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b005255f5735adsm596795edq.24.2023.09.14.01.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:17:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Sep 2023 10:17:31 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZQLBm8sC+V53CIzD@krava>
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava>
 <ZPsJ4AAqNMchvms/@krava>
 <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPuA5+HmbcdBLbIq@krava>

On Fri, Sep 08, 2023 at 10:15:35PM +0200, Jiri Olsa wrote:
> On Fri, Sep 08, 2023 at 10:14:56AM -0700, Nick Desaulniers wrote:
> > Thanks for the patch!
> > 
> > + Marcus
> > 
> > Marcus can you please test the below patch and provide your tested-by
> > and reported-by tags?
> > 
> > On Fri, Sep 8, 2023 at 4:47 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Sep 07, 2023 at 10:33:00PM +0200, Jiri Olsa wrote:
> > > > On Thu, Sep 07, 2023 at 12:01:18PM -0700, Nick Desaulniers wrote:
> > > > > So we've got a curious report recently:
> > > > > https://github.com/ClangBuiltLinux/linux/issues/1913
> > > > >
> > > > > ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > > > > '__BTF_ID__struct__cgroup__624' is already defined
> > > > > __BTF_ID__struct__cgroup__624:
> > > > > ^
> > > > >
> > > > > It's been hard to pin down a SHA and .config to reproduce this, but
> > > > > looking at the definition of BTF_ID's usage of __ID's usage of
> > > > > __COUNTER__, and the two statements:
> > > > >
> > > > > kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
> > > > > kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)
> > > > >
> > > > > Is it possible that __COUNTER__ could evaluate to the same value
> > > > > across 2 different translation units, leading to a name collision like
> > > > > the above?
> > > >
> > > > hum, that probably the case, I see same counter values at different
> > > > __BTF_ID_ symbols:
> > > >
> > > > ffffffff833fe540 r __BTF_ID__struct__bpf_bloom_filter__380
> > > > ffffffff833fe548 r __BTF_ID__struct__bpf_queue_stack__380
> > > > ffffffff833fe578 r __BTF_ID__struct__cgroup__380
> > > >
> > > > perhaps we were just lucky not to hit that :-\
> > > >
> > > > >
> > > > > looking at another usage of BTF_ID other than struct
> > > > > cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_release)
> > > > > is only defined in one translation unit
> > > > >
> > > > > Should one of those two `BTF_ID(struct, cgroup)` be removed? Is there
> > > > > some other way we can avoid these collisions in the future?
> > > >
> > > > need to find some way to make the symbol unique, will check
> > >
> > > the change below uses object's path as the __BTF_ID_.. symbol suffix to make
> > > it unique
> > >
> > > I'm still looking, but can't think of a better way so far, perhaps somebody
> > > will have better idea
> > 
> > Another good approach; I had simply added __LINE__ into the paste.
> > https://github.com/ClangBuiltLinux/linux/issues/1913#issuecomment-1710794319
> > Which just makes the probability of this occurring again smaller, but
> > still non-zero.
> 
> yes, there's still possibility of the match
> 
> > 
> > + Masahiro for thoughts on the invocation of echo and base32.  Looks
> > like base32 is part of coreutils. Kind of strange that coreutils isn't
> > listed in Documentation/process/changes.rst.  Would adding the usage
> > of base32 add a new dependency on coreutils?
> > 
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > index a3462a9b8e18..564953f9cbc7 100644
> > > --- a/include/linux/btf_ids.h
> > > +++ b/include/linux/btf_ids.h
> > > @@ -49,7 +49,7 @@ word                                                  \
> > >         ____BTF_ID(symbol, word)
> > >
> > >  #define __ID(prefix) \
> > > -       __PASTE(prefix, __COUNTER__)
> > > +       __PASTE(__PASTE(prefix, __COUNTER__), BTF_ID_BASE)
> > 
> > Do we still need __COUNTER__ if we're now using BTF_ID_BASE?
> 
> yes we still need that because we could have same __BTF_ID__...
> symbol used multiple times within same object, and that's where
> __COUNTER__ makes the difference
> 
> > 
> > >
> > >  /*
> > >   * The BTF_ID defines unique symbol for each ID pointing
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 68d0134bdbf9..2ef8b2798be0 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -200,6 +200,10 @@ _c_flags += $(if $(patsubst n%,, \
> > >         -D__KCSAN_INSTRUMENT_BARRIERS__)
> > >  endif
> > >
> > > +ifeq ($(CONFIG_DEBUG_INFO_BTF),y)
> > > +_c_flags += -DBTF_ID_BASE=$(subst =,,$(shell echo -n $(modfile) | base32 -w0))
> > 
> > `man 1 base32` shows it can just read a file. Could the above be:
> > 
> > _c_flags += -DBTF_ID_BASE=$(subst =,,$(shell base32 -w0 $(modfile)))
> > 
> > ? (untested)
> > 
> > Also, the output of
> > 
> > $ base32 -w0 Documentation/process/changes.rst
> > 
> > is 24456 characters.  This is going to blow up symbol tables. I
> > suppose ELF probably has some length limit on symbol names, too.  I
> > was nervous about my approaching appending __LINE__.
> > 
> > Perhaps pipe the output to `head -c <n bytes>`?
> 
> so the change is about adding unique id that's basically path of
> the object stored in base32 so it could be used as symbol, so we
> don't really need to read the actual file
> 
> the problem is when BTF_ID definition like:
> 
> BTF_ID(struct, cgroup)
> 
> translates in 2 separate objects into same symbol name because of
> the matching __COUNTER__ macro values (like 380 below)
> 
>   __BTF_ID__struct__cgroup__380
> 
> this change just adds unique id of the path name at the end of the
> symbol with:
> 
>   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> 
> so the symbol looks like:
> 
>   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> 
> and is unique over the sources
> 
> but I still hope we could come up with some better solution ;-)

so far the only better solution I could come up with is to use
cksum (also from coreutils) instead of base32, which makes the
BTF_ID_BASE value compact

I'll run test to find out how much it hurts the build time

jirka


---
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a3462a9b8e18..564953f9cbc7 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -49,7 +49,7 @@ word							\
 	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), BTF_ID_BASE)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..01b14e6a7df3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -200,6 +200,10 @@ _c_flags += $(if $(patsubst n%,, \
 	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
 
+ifeq ($(CONFIG_DEBUG_INFO_BTF),y)
+_c_flags += -DBTF_ID_BASE=$(firstword $(shell echo -n $(modfile) | cksum))
+endif
+
 # $(srctree)/$(src) for including checkin headers from generated source files
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)


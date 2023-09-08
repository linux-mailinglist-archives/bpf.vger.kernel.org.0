Return-Path: <bpf+bounces-9552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB20D7990E7
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8655A281B48
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E530FA2;
	Fri,  8 Sep 2023 20:15:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EE30F8D
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 20:15:43 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F5E0
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:15:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1c66876aso307513366b.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694204138; x=1694808938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=si1xGkM7Ros3c7RMLtdfTxwuvqPomUDStzBN1AuUiUQ=;
        b=ixFcCWkp3mrBC6zzqXi0PzSDAmBKU979iF6DVSIYkHfQT2MryoSWJu83hD8yo9IqdU
         0cUb+UcmI7d09Pcn3c4UbGth4aEryLJv93LDGCcGrYOmbaUyrKiTVajRCuLt9NOMItH/
         9RxNUsZ3ucpB1mKli0DtdgJTrME5lPglbPBUUPwcQqkPN8Lz4SX3H7RTN0ZeH/6Zg+4u
         qTTaYglzq3fu7RnK55aYInfO5DjNNVi5iJrmQ7P6XNIK/Fvgt07KnNBNuR2oUXn4dFgT
         aRlKau97W/jgLbURLn05rnakaIK0QH6KDReoT3sHnhLbrjhtDiZlEMbewZ0GzjSIg5R3
         zgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694204138; x=1694808938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si1xGkM7Ros3c7RMLtdfTxwuvqPomUDStzBN1AuUiUQ=;
        b=PTHj2PPw9lDizJrNyIL1ACbEMagH/cGkBGa/CXlXQ6ENa1CwnOgEYAXvP8qkJbhKup
         nnEaDy2KpoOpB+KIS8v7SqLyDo3j8LjTsS/KLzFsKgFsuk9RV7UAm7PL5srDkE1g4t8m
         3rI0H7DAzJF+HbTIcGXmBRTr19qz9RUQSlCmCr/Le0TrtJbc0MdT/Hcq1SOxO0mLMwv6
         Q+B28k9789Jd7wLMznimyr1PGhF7jwUduJ5J45+nxBi06CWbfWE2mPHyuFweuacIonkx
         dxS8gy5cUm2sYjYHJ3qCm1QsM02DFAuO26JrDcehPhhOKvpZA6DMdjkLfiVrlrO7TB17
         TCRw==
X-Gm-Message-State: AOJu0Yy2h79AIl+WtHPw+qIGtk3bztI7tj6OeVOLYvF/AAgpOwCQ0+mS
	18C8ushO11i0ehzwr2KJaxsNV1QvTXs=
X-Google-Smtp-Source: AGHT+IH25N0r6VV2un5+wqQKFwEggFRKFnpRBeYcun0YJGT1y54WhSAiL9ngsk8F1RRwuXgbuFKq1A==
X-Received: by 2002:a17:907:770b:b0:9a5:8269:2c94 with SMTP id kw11-20020a170907770b00b009a582692c94mr3077635ejc.57.1694204138379;
        Fri, 08 Sep 2023 13:15:38 -0700 (PDT)
Received: from krava ([83.240.61.79])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00992b2c55c67sm1449713ejm.156.2023.09.08.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:15:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 8 Sep 2023 22:15:35 +0200
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Marcus Seyfarth <m.seyfarth@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZPuA5+HmbcdBLbIq@krava>
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava>
 <ZPsJ4AAqNMchvms/@krava>
 <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 10:14:56AM -0700, Nick Desaulniers wrote:
> Thanks for the patch!
> 
> + Marcus
> 
> Marcus can you please test the below patch and provide your tested-by
> and reported-by tags?
> 
> On Fri, Sep 8, 2023 at 4:47 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Sep 07, 2023 at 10:33:00PM +0200, Jiri Olsa wrote:
> > > On Thu, Sep 07, 2023 at 12:01:18PM -0700, Nick Desaulniers wrote:
> > > > So we've got a curious report recently:
> > > > https://github.com/ClangBuiltLinux/linux/issues/1913
> > > >
> > > > ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > > > '__BTF_ID__struct__cgroup__624' is already defined
> > > > __BTF_ID__struct__cgroup__624:
> > > > ^
> > > >
> > > > It's been hard to pin down a SHA and .config to reproduce this, but
> > > > looking at the definition of BTF_ID's usage of __ID's usage of
> > > > __COUNTER__, and the two statements:
> > > >
> > > > kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
> > > > kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)
> > > >
> > > > Is it possible that __COUNTER__ could evaluate to the same value
> > > > across 2 different translation units, leading to a name collision like
> > > > the above?
> > >
> > > hum, that probably the case, I see same counter values at different
> > > __BTF_ID_ symbols:
> > >
> > > ffffffff833fe540 r __BTF_ID__struct__bpf_bloom_filter__380
> > > ffffffff833fe548 r __BTF_ID__struct__bpf_queue_stack__380
> > > ffffffff833fe578 r __BTF_ID__struct__cgroup__380
> > >
> > > perhaps we were just lucky not to hit that :-\
> > >
> > > >
> > > > looking at another usage of BTF_ID other than struct
> > > > cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_release)
> > > > is only defined in one translation unit
> > > >
> > > > Should one of those two `BTF_ID(struct, cgroup)` be removed? Is there
> > > > some other way we can avoid these collisions in the future?
> > >
> > > need to find some way to make the symbol unique, will check
> >
> > the change below uses object's path as the __BTF_ID_.. symbol suffix to make
> > it unique
> >
> > I'm still looking, but can't think of a better way so far, perhaps somebody
> > will have better idea
> 
> Another good approach; I had simply added __LINE__ into the paste.
> https://github.com/ClangBuiltLinux/linux/issues/1913#issuecomment-1710794319
> Which just makes the probability of this occurring again smaller, but
> still non-zero.

yes, there's still possibility of the match

> 
> + Masahiro for thoughts on the invocation of echo and base32.  Looks
> like base32 is part of coreutils. Kind of strange that coreutils isn't
> listed in Documentation/process/changes.rst.  Would adding the usage
> of base32 add a new dependency on coreutils?
> 
> >
> > jirka
> >
> >
> > ---
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index a3462a9b8e18..564953f9cbc7 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -49,7 +49,7 @@ word                                                  \
> >         ____BTF_ID(symbol, word)
> >
> >  #define __ID(prefix) \
> > -       __PASTE(prefix, __COUNTER__)
> > +       __PASTE(__PASTE(prefix, __COUNTER__), BTF_ID_BASE)
> 
> Do we still need __COUNTER__ if we're now using BTF_ID_BASE?

yes we still need that because we could have same __BTF_ID__...
symbol used multiple times within same object, and that's where
__COUNTER__ makes the difference

> 
> >
> >  /*
> >   * The BTF_ID defines unique symbol for each ID pointing
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 68d0134bdbf9..2ef8b2798be0 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -200,6 +200,10 @@ _c_flags += $(if $(patsubst n%,, \
> >         -D__KCSAN_INSTRUMENT_BARRIERS__)
> >  endif
> >
> > +ifeq ($(CONFIG_DEBUG_INFO_BTF),y)
> > +_c_flags += -DBTF_ID_BASE=$(subst =,,$(shell echo -n $(modfile) | base32 -w0))
> 
> `man 1 base32` shows it can just read a file. Could the above be:
> 
> _c_flags += -DBTF_ID_BASE=$(subst =,,$(shell base32 -w0 $(modfile)))
> 
> ? (untested)
> 
> Also, the output of
> 
> $ base32 -w0 Documentation/process/changes.rst
> 
> is 24456 characters.  This is going to blow up symbol tables. I
> suppose ELF probably has some length limit on symbol names, too.  I
> was nervous about my approaching appending __LINE__.
> 
> Perhaps pipe the output to `head -c <n bytes>`?

so the change is about adding unique id that's basically path of
the object stored in base32 so it could be used as symbol, so we
don't really need to read the actual file

the problem is when BTF_ID definition like:

BTF_ID(struct, cgroup)

translates in 2 separate objects into same symbol name because of
the matching __COUNTER__ macro values (like 380 below)

  __BTF_ID__struct__cgroup__380

this change just adds unique id of the path name at the end of the
symbol with:

  echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4DGF5UGK3DQMVZHG

so the symbol looks like:

  __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG

and is unique over the sources

but I still hope we could come up with some better solution ;-)

jirka


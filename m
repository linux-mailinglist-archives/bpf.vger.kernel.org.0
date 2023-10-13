Return-Path: <bpf+bounces-12123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8097C7DC6
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 08:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C055B20A56
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF146AC;
	Fri, 13 Oct 2023 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+SNLB1i"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25134110C;
	Fri, 13 Oct 2023 06:37:14 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B2EBC;
	Thu, 12 Oct 2023 23:37:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso299776266b.2;
        Thu, 12 Oct 2023 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697179031; x=1697783831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yw2XAIYoGosVaRhpV1LmzXn+oclXPzYHPKDh6+mkVJM=;
        b=V+SNLB1iiEbK2IN27jgvg5yYTJL7w5p+T8Q1S5SDP1IoSh72n6x1kxmsOQaO+9Swc1
         RBsYH9hj2XMO0SqlmK2oFnFohOSAUPRUUbZ0xz+ZCglnaePylVYIXWqUBQDuog3OHlPd
         i66GxRIp0yav/qvVinB3AAR/YUv6bzDKuIRcRuhzMO0/IF4K84APZaIocuxI55Znm8zH
         sQSYceVA+hqpi3J8IiNMxro0cbsGA4NJ6be4LTieoW+qXOcZ3inz7aBxurmH7H7vfs9U
         JGGHfWOkz4OqNJdWCkqXETN804U95whdzcKA7qq0O7K16uer6jURI3nMb0v1YYfR39rT
         wKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179031; x=1697783831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw2XAIYoGosVaRhpV1LmzXn+oclXPzYHPKDh6+mkVJM=;
        b=h9ngPds+9J0S6YGD0/QP+CU6NyZnk5IxJeLpy5eLjN7cN352YnNHthwDPmNlriHyVJ
         +cYTgFHZ4PDXyhpyZNzvMrYw+km/F4E0abTcsmUS552HpDo0kxxulTfEEfFyizko+0Bg
         vsC7azmGadHAupPq+f4PYN0SRBLVbU7mXlRAPH7iJbhYQboQxV0fHjMofWSHHnVDLisT
         WLxJAkDIfIQPHdxhVU7uX0csIRXP3sVHMBir8Usa66bWeNUq+uJTdlDoFjlIFw88yno7
         dOK18/2GsYgAniJPOVkIWwaO6uMl9z26HNgsDqesduz25C71e+gixd0EPa3+jC/7LuVo
         mwCQ==
X-Gm-Message-State: AOJu0YzWMnKRYd/0RlEyLuvWlzFsqlU+z3+jnPI6fPYITPzwso2M31ui
	nl55vk9YIXar/Z2dLA3feSA=
X-Google-Smtp-Source: AGHT+IGnIQOy++7g/GxLi2lAayoaVwkkPdJ7exYracwDbOtTZ/0MBIw4RkVOgFpePPvQNylLy+wwGA==
X-Received: by 2002:a17:906:209a:b0:9ae:69b8:322b with SMTP id 26-20020a170906209a00b009ae69b8322bmr22516291ejq.60.1697179030550;
        Thu, 12 Oct 2023 23:37:10 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id gy6-20020a0564025bc600b0053e2a64b5f8sm1041676edb.14.2023.10.12.23.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:37:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Oct 2023 08:37:07 +0200
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Dmitry Goncharov <dgoncharov@users.sf.net>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCHv2 1/2] tools/build: Fix -s detection code in
 tools/build/Makefile.build
Message-ID: <ZSjlk99UOV2tTMWO@krava>
References: <20231008212251.236023-1-jolsa@kernel.org>
 <20231008212251.236023-2-jolsa@kernel.org>
 <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:57:33PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Sun, Oct 8, 2023 at 2:23 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > As Dmitry described in [1] changelog the current way of detecting
> > -s option is broken for new make.
> 
> I'm not sure what -s option does for perf (at least).
> It doesn't seem much different whether I give it or not.
> Am I missing something?

what's your make version? the wrong output is visible when running
with make version > 4.4 .. basicaly the -s is wrongly detected and
you either get no output at all from some builds or overly verbose
output

it's mentioned in the [1] commit changelog, I can put it to the
changelog in new version

jirka

> 
> Thanks,
> Namhyung
> 
> >
> > Changing the tools/build -s option detection the same way as it was
> > fixed for root Makefile in [1].
> >
> > [1] 4bf73588165b ("kbuild: Port silent mode detection to future gnu make.")
> >
> > Cc: Dmitry Goncharov <dgoncharov@users.sf.net>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/build/Makefile.build | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > index fac42486a8cf..5fb3fb3d97e0 100644
> > --- a/tools/build/Makefile.build
> > +++ b/tools/build/Makefile.build
> > @@ -20,7 +20,15 @@ else
> >    Q=@
> >  endif
> >
> > -ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
> > +# If the user is running make -s (silent mode), suppress echoing of commands
> > +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > +short-opts := $(firstword -$(MAKEFLAGS))
> > +else
> > +short-opts := $(filter-out --%,$(MAKEFLAGS))
> > +endif
> > +
> > +ifneq ($(findstring s,$(short-opts)),)
> >    quiet=silent_
> >  endif
> >
> > --
> > 2.41.0
> >


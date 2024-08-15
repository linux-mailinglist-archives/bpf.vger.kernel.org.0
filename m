Return-Path: <bpf+bounces-37320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1F953D2C
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3E1C254AC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85D154C11;
	Thu, 15 Aug 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6DMscur"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F421547EE
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759844; cv=none; b=qdYykocPPCLEax5J6s9Q84XM+WI6eLWzuDbK3LYwyNHaur82sfHJyAS90FSLGJHN4afPJ/raIv93XwLq6p0iyp+ySDkYkc719sZwhQGBAq/rdJl67x0FG7hRO8TMEbncDFHXC1jK+SSz9M/DA7tZEIRDrsyQJDbOw0xOCmsq3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759844; c=relaxed/simple;
	bh=nFqZB4bfxstaTL7JatWcD8WUGqPY+B2IlOBDa/MTJbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTbdmB3NLAXamH6jUTEe8kkSgQOgREqrjU2hc/3FwP7sgNMsHZJRIpkDMJtDdGC13Nr+ZD4UBWj1rSLcrzQl77hA5/x/6kRVCHcKhobFiXZwAAgs+GwliHVX6JcbbYabpN6ws6fY+CrVyZVz6P37hAukiOpl+BkI/BGhp07yHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6DMscur; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso1087115a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759842; x=1724364642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4s2Y1hU+E+jfGbV3qH2Ba1FlR8M9KLU9vxOWSKjCSs=;
        b=a6DMscurwTpgQmAje9Fo2WxuQpxlqzEnq0PmyU1qIW41NPyK6sm0Ln+pmNAEoOm43L
         7zSaw/qo2QocpRGB39nYa1YJ2+p9Teh0hPg5Brd4hyWG72JgRKB18s710k4ubqwPu+cS
         BVwf0nR3ZQn098yJOfa7Sxz8uqdr4RWw0bPgAP8E16tcsbCM77E2xaBje8e8g6oxzvpl
         TLpRKhi+pkXzzLXqAWxrjqLyBOEOl55IuxsHgzF0WDvjyg1vLmXQbPJIBMkhWNWorNua
         JlvOzA8y8ClOv2wdkEomFlnIEH6DUjsFN1PCzZuY0DQo3Rg55xiawxxhPrEdYh9gGoA7
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759842; x=1724364642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4s2Y1hU+E+jfGbV3qH2Ba1FlR8M9KLU9vxOWSKjCSs=;
        b=LASH8+4lN3Y9KhY5WX84itbrNnWYBbOElJJ8xE0x70GyFDehZbF4jMBA/yOgHZFpfl
         H1Pp5+AcY6VTlvoDyspnkf8Dow1MZFKUNc92+WEx2VktxYQinGu5Ipf62+QzIdqYhKUA
         mUgk5adg0bzRd1u3msYiz5TTlgHZ9xILTfy45ox51z8ZGUg2ZRyDtP9qgstC8tvTAn9T
         Dq7XNv0Ia4QWTYDWz9wg2vRlbU0oLCwh7Ci+n1wcE5do19MkAoFa95BCXDIk1ACz+pxn
         S0GJC5ROVhTeR8i7HGWRE5UacFeeTzvifu7TVWWA6u279fQ50DIs6hOzjB2MgJgGNWXn
         NJ0Q==
X-Gm-Message-State: AOJu0YwktQQ5OTbtZ0uZJ88E1jjoIqiJ57+1/YzQ75YFLI9yeXB6aSsq
	KKApwQLPf4gvirfP/V5Uyvrqa3R9XkAeoHyT/u8GQPvLqUL6pKWUZ0jlpeM/OP8cJHaQMSYRzi8
	P/OdkoN4r5rIWOW9mnDfe23awRk4=
X-Google-Smtp-Source: AGHT+IGFG7gwOC9TZW5WkH5WwrY3O1+9uLXeSY7Nwqoi9A2NiaGfgufnuMD7L15rOerR+isRrWoUzj9UAEYxduIuyR8=
X-Received: by 2002:a17:90a:ce11:b0:2d1:b36c:6bc1 with SMTP id
 98e67ed59e1d1-2d3dfdaaed9mr1119391a91.2.1723759842312; Thu, 15 Aug 2024
 15:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815205449.242556-1-eddyz87@gmail.com> <20240815205449.242556-3-eddyz87@gmail.com>
 <CAEf4BzZ2Z3P+m+ptHbMMwLhR=KvJZsd-w9z56=hGTCvbTzGhtQ@mail.gmail.com> <5f79465fb172c3a6d8d706ee9adc7ae80437524d.camel@gmail.com>
In-Reply-To: <5f79465fb172c3a6d8d706ee9adc7ae80437524d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:10:30 -0700
Message-ID: <CAEf4BzZdf4JRrvm71hTKUii4REpBQRHb=KWsm8ku+8gLdxjbjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: utility function to get
 program disassembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-15 at 14:17 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -164,6 +176,31 @@ endef
> > >
> > >  include ../lib.mk
> > >
> > > +NON_CHECK_FEAT_TARGETS :=3D clean docs-clean
> > > +CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECM=
DGOALS), "none"))
> > > +ifneq ($(CHECK_FEAT),)
> > > +FEATURE_USER :=3D .selftests
> > > +FEATURE_TESTS :=3D llvm
> > > +FEATURE_DISPLAY :=3D $(FEATURE_TESTS)
> > > +
> > > +# Makefile.feature expects OUTPUT to end with a slash
> > > +$(let OUTPUT,$(OUTPUT)/,\
> > > +       $(eval include ../../../build/Makefile.feature))
> > > +endif
> > > +
> > > +ifeq ($(feature-llvm),1)
> > > +  LLVM_CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
> > > +  LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
> > > +  # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as =
conflict
> > > +  LLVM_CFLAGS  +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG=
) --cflags))
> > > +  LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_=
COMPONENTS))
> > > +  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> > > +    LLVM_LDLIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CON=
FIG_LIB_COMPONENTS))
> > > +    LLVM_LDLIBS +=3D -lstdc++
> > > +  endif
> > > +  LLVM_LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
> > > +endif
> > > +
> >
> > Seems like we raced between me commenting on v1 and you posting v2 :(
>
> Yes, I should have waited a bit more, sorry.
>

no worries

> > But I just noticed that formatting seems off here. Can you please
> > check space vs tabs issues?
>
> For the block above the lines are indented using two spaces and four spac=
es.
> This is not a rule body, so should not be a problem afaik.
> What's not working on your side?
>

oh, it's just for consistency with the rest of Makefile. We use tabs
for indentation, so let's stay consistent.

> > >  SCRATCH_DIR :=3D $(OUTPUT)/tools
> > >  BUILD_DIR :=3D $(SCRATCH_DIR)/build
> > >  INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
>
> [...]
>


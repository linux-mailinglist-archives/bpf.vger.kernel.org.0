Return-Path: <bpf+bounces-37314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF1A953CF7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B0B1F2478B
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E34154456;
	Thu, 15 Aug 2024 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqZcG58G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D726154433
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758897; cv=none; b=n9GZN+T4bRQPP3a8zZEuY5Yyu5BPWJdXUqyoEagYc1+uB3/YoeA0A95UsD9SXZu9YTANrAJZNrFjnQZY9xGmJ5jdBEa71kdB86NYroUXnKGmxMcn7+iNyLFAoGOHXteJYNNhrPTo3cJcq6tsAi4j1KTBy3Xp5nDDg0o61GU2gT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758897; c=relaxed/simple;
	bh=HvAx4kiZk5DD6b7Oie3GDQPdHU0FVByJ8kRcjflPIFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5WRoueyi+EOPKXv1aJoo6H3/WoJleFkVpJ1VrxQlNpzUTZD3LKQ39CSnnpPk/G3/yiPYZxY+i4j92KnRDtYOoopXzpatPe7HHAgyYTuCwQYAZE1cGNDpX6bSwcX6NN0KTBCJWFuImAQY16jAYb9zja65pw92h4i+nkd7ZHHe/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqZcG58G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc569440e1so13369685ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758895; x=1724363695; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tcqlhNlIO0L4lVDrnAPE1QOql2E9If/1JYTiBeREn7g=;
        b=iqZcG58G1t8XgyNUiX7pe2m+l44bQYeE3AD1H1qOfCGkidQ1vxg7y1ArLGA+4yayPP
         QYjFfJca1Rxr9rQMfDjfDovdg1NhWDhRbUciMz4yMlz0x2WKq7wnk53QXwayISLHcUPi
         Zvz5SrjOi2O3vdlWW5zyzGOrVTGnSPikyIRUNtvARS4EkkN8J9cQbuiD0enIGALZwTEO
         UygG6eyopFIjoaou1ad11Ptyo0KuEMLkUsuGcK2/leBOTjYpVXvmysqk9Z4vHP8G7fT5
         PPkG7YjcnM5Fcsz1n2ZiPC4Y5fPMnirOa+kfPD2gK12Ux5TXDpY9LAxsGXrx09KM7HyX
         VB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758895; x=1724363695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcqlhNlIO0L4lVDrnAPE1QOql2E9If/1JYTiBeREn7g=;
        b=jZ3blpxES8H2w0WJkwAXIWprsps5AbEqQS9kMFTndQbyP7b6VEZeFlyBQJ2wMyuyG9
         FTwXgR3FmDDr5KhzNW/8qlYdmUHlYSig4bKyxdqfwnR0oofhHzNwZRyNBIWZX5ZtseU/
         o8FrwpepBmoeFGM95dhqbPMBkPDfq/0c5B6N8HyDlc24+M7Sa1TFGlAfE08auZK8eSh+
         4oE8/2pkYMeedcvNYXotmQhP03PQAmlRQCHO6aBiPAMqIZNoTtdJv2HQ5siHMRAhGb1h
         A0HADfUV8dpOz+crtz6WeW+N1IFvMqgtQ83EGHKwrGHrWoXVpD+A8Y/SCUhhIZsCRTLZ
         5WCQ==
X-Gm-Message-State: AOJu0YxXeKb1384lJJtAhCmPPgApxO8BuBA/NyCx25To2z3fMIe+j6XH
	Vt3oFuGn6P2O1QKxhBdHEBtsBbz9hu9ClbLE5ehSvCz03nAeBN+L
X-Google-Smtp-Source: AGHT+IGGKBzAacxdUdI08lZIEclw+E186E2P1Pos/VvnponD8vmzVlyobHbaGTa/a9AM/U0W7ZQSBw==
X-Received: by 2002:a17:902:c94b:b0:1ff:4618:36bc with SMTP id d9443c01a7336-20203ee1bf9mr11733065ad.39.1723758894660;
        Thu, 15 Aug 2024 14:54:54 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037599asm14523425ad.149.2024.08.15.14.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:54:54 -0700 (PDT)
Message-ID: <5f79465fb172c3a6d8d706ee9adc7ae80437524d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 14:54:49 -0700
In-Reply-To: <CAEf4BzZ2Z3P+m+ptHbMMwLhR=KvJZsd-w9z56=hGTCvbTzGhtQ@mail.gmail.com>
References: <20240815205449.242556-1-eddyz87@gmail.com>
	 <20240815205449.242556-3-eddyz87@gmail.com>
	 <CAEf4BzZ2Z3P+m+ptHbMMwLhR=KvJZsd-w9z56=hGTCvbTzGhtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:17 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -164,6 +176,31 @@ endef
> >=20
> >  include ../lib.mk
> >=20
> > +NON_CHECK_FEAT_TARGETS :=3D clean docs-clean
> > +CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDG=
OALS), "none"))
> > +ifneq ($(CHECK_FEAT),)
> > +FEATURE_USER :=3D .selftests
> > +FEATURE_TESTS :=3D llvm
> > +FEATURE_DISPLAY :=3D $(FEATURE_TESTS)
> > +
> > +# Makefile.feature expects OUTPUT to end with a slash
> > +$(let OUTPUT,$(OUTPUT)/,\
> > +       $(eval include ../../../build/Makefile.feature))
> > +endif
> > +
> > +ifeq ($(feature-llvm),1)
> > +  LLVM_CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
> > +  LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
> > +  # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as co=
nflict
> > +  LLVM_CFLAGS  +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) =
--cflags))
> > +  LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_CO=
MPONENTS))
> > +  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> > +    LLVM_LDLIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFI=
G_LIB_COMPONENTS))
> > +    LLVM_LDLIBS +=3D -lstdc++
> > +  endif
> > +  LLVM_LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
> > +endif
> > +
>=20
> Seems like we raced between me commenting on v1 and you posting v2 :(

Yes, I should have waited a bit more, sorry.

> But I just noticed that formatting seems off here. Can you please
> check space vs tabs issues?

For the block above the lines are indented using two spaces and four spaces=
.
This is not a rule body, so should not be a problem afaik.
What's not working on your side?

> >  SCRATCH_DIR :=3D $(OUTPUT)/tools
> >  BUILD_DIR :=3D $(SCRATCH_DIR)/build
> >  INCLUDE_DIR :=3D $(SCRATCH_DIR)/include

[...]



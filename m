Return-Path: <bpf+bounces-9995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C77A00E3
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1031C20936
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485FD2AB5A;
	Thu, 14 Sep 2023 09:52:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9B20B3E
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 09:52:35 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065DFBB
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 02:52:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501be2d45e0so1277978e87.3
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694685153; x=1695289953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GN8ytPq7BJ4KPt7TJ0dTMIMvhtcsDk2MyD/gO1nB0y4=;
        b=gwDXPiSmGQceIw11yjAsF2cmoUMETgkqqdeTStnhJ8F07R6UV2lcul+hBTN/Y/mixN
         lPTycQpHFobuiMgIQgeE8hnAeQzEpw9D46ffz4YI23HfMr16X+bsV/ijfeMEIJe9nd3y
         AuR2buLJZTRS3o3kW7DJZK8CZcvNWyKiW/JsgFxege6tqgwOCL/WSEMoIsI3i7EDmZmP
         IG5tbXcSRgcI0tHxmUS5mrUSgVGzb5nlsecQY/NrRSsxj8VUW6JhXtshTdp8MgFxwhOD
         EZGir4AUvG4fp0bARFmza80ga+/xEcZyOpBqZpvYSv759zfQBuhCZvVl/HWgEaUyF2gR
         3UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685153; x=1695289953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN8ytPq7BJ4KPt7TJ0dTMIMvhtcsDk2MyD/gO1nB0y4=;
        b=HGHBkaXbj4nfuVwZ6+itbz0C7ugAgGkYGScp1qZnWH0/CFRlh7F5yAfc8eE/avtTUu
         VC4l6hsMp3q2tRQHkUNr5R+sQX2TTtp4FNZ/fokeRpZTUocF/sHewz8B53YWfrYAo/92
         TaiaHniVWjx+RjNtzXEzr42/lump9eBrbwNMsu9ZQwCn3XSpfmlWyFsIDPU8O4NfuJWs
         I2AcD64AaaO4A5xfNVseMvtf1l687cxgfA6m5jlIQV9wyIoK54TYvKkbWga6ATZgXG2w
         Ye93YSwpvPmOTUkYTGHzAlvMYFayB2hrom+1CY34ocQoZQJUw5z6OhXlx6LTKIrrOpiB
         7kJA==
X-Gm-Message-State: AOJu0Yw9LNs2a0GybUBYQIsoRXtjJPp6HBwxKKkyj/mskZ/hE/Yxg82Y
	BDH+fJjTfGfIC/FzN3PUSSg=
X-Google-Smtp-Source: AGHT+IGeOefCnnsoPvyMmIk0zg+5/TvlLnDgZJwi/81IC5W9Bi2z9/z9bJQiU3/JuL3fhkRMZtSynw==
X-Received: by 2002:a05:6512:3b0d:b0:501:c406:c296 with SMTP id f13-20020a0565123b0d00b00501c406c296mr5239850lfv.31.1694685152802;
        Thu, 14 Sep 2023 02:52:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i3-20020aa7c703000000b0051dfa2e30b2sm704330edq.9.2023.09.14.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:52:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Sep 2023 11:52:30 +0200
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZQLX3oSCk95Qf4Ma@krava>
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava>
 <ZPsJ4AAqNMchvms/@krava>
 <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava>
 <ZQLBm8sC+V53CIzD@krava>
 <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>

On Thu, Sep 14, 2023 at 05:30:51PM +0900, Masahiro Yamada wrote:

SNIP

> > > so the change is about adding unique id that's basically path of
> > > the object stored in base32 so it could be used as symbol, so we
> > > don't really need to read the actual file
> > >
> > > the problem is when BTF_ID definition like:
> > >
> > > BTF_ID(struct, cgroup)
> > >
> > > translates in 2 separate objects into same symbol name because of
> > > the matching __COUNTER__ macro values (like 380 below)
> > >
> > >   __BTF_ID__struct__cgroup__380
> > >
> > > this change just adds unique id of the path name at the end of the
> > > symbol with:
> > >
> > >   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > >
> > > so the symbol looks like:
> > >
> > >   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > >
> > > and is unique over the sources
> > >
> > > but I still hope we could come up with some better solution ;-)
> >
> > so far the only better solution I could come up with is to use
> > cksum (also from coreutils) instead of base32, which makes the
> > BTF_ID_BASE value compact
> >
> > I'll run test to find out how much it hurts the build time
> >
> > jirka
> 
> 
> 
> Seems a bad idea to me.
> 
> It would fork a new shell and chsum for all files,
> while only a few of them need it.

right, I have a change to limit this on kernel and net directories,
but it's still bad

> 
> Better to consult BTF forks.

perhaps there's better way within kbuild to get unique id/value
for each object file?

thanks,
jirka


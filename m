Return-Path: <bpf+bounces-18548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EA81BC91
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41ECAB21D7B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743D58234;
	Thu, 21 Dec 2023 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID5uMII1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE295822D
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33686649b72so959775f8f.3
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178343; x=1703783143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUMp5fzumXMNmnf9T/7Q1DmkhRz1J1Uw0YIx+NCj/Yc=;
        b=ID5uMII13Eo4JQgR0GOy/KSGeHBekKfd1RmMeIlXF//kfZ/lXYzNfxrGGRriqoeO+W
         lx9SnEjlEjzjhoUyPNRO+9jrY2GJXZUfb7ZKdRqABu8jcmU66lmxgXsar5EloKMC902Q
         wgkmIx4xnGhSGwIay72TN2eE/y0O4lPRafsaLY8R5PTVoAanu3rfHXr3EDut8pzTohkN
         W3VT13M6qslHANU5tL6/OW6ZXiQLj0A4cccLUIJxD7zFgnMc441ci5EA0oooHx/LauJA
         UfTSV9eQ4ogl0n9RKAJ4YgsyI3Px2qN2OX1SeiPrcW0TTP43H93T18xXr1+P2e26HAFT
         znFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178343; x=1703783143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUMp5fzumXMNmnf9T/7Q1DmkhRz1J1Uw0YIx+NCj/Yc=;
        b=sF7mclkD9Q5admV+kkKV1njLCQmdwjAaDzEL0DP4cE/TWOKzqRRHiO0E+faNWkKQil
         qZIjUuIffGau5trlC10ezgFX5vLp4BJvM0rCgVftVW0ytaNCRdaqn1SVR0B7qQ2zNHxF
         /wKG9SwoW5AyRhpyLENLmJfrFXEVtBMO1tOevikA+tMUXC2chkDBpRMl31CyKmIcNC9j
         1t5yL8zoCoZMFHL7dG/lQObvBVXTgNvF+6lVpKSb2rvfQwBU37urTpWmDyEw+l5LMkYl
         jqg2IyyJG0Dre7V3vLlI7FKyNFHhDF2sEA7zV1flDZcTcbKZVoEVANmFEdlZxeZ5HeJt
         64MA==
X-Gm-Message-State: AOJu0YybTWnzPo70TpL2+hPayiS9Fqw2KqlLqmgbG3oO3mSKf0cH2SWR
	M4Gb1IV0n3pZ/MMhbegjE3oO0MOH9gTSbssV/1c=
X-Google-Smtp-Source: AGHT+IFgkgF4MYQ34/3OkEuFi7vNoBtjV8syWKbEPMX35t6yg2yGBP9kntK8i/yppDXrQj/dfjSAJe5Q8AzWu0bs1sI=
X-Received: by 2002:adf:fdc7:0:b0:333:37f6:ad33 with SMTP id
 i7-20020adffdc7000000b0033337f6ad33mr43993wrs.102.1703178342933; Thu, 21 Dec
 2023 09:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme> <ZYP40EN9U9GKOu7x@krava>
In-Reply-To: <ZYP40EN9U9GKOu7x@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Dec 2023 09:05:31 -0800
Message-ID: <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lis=
ts,
> which are bounded by __BTF_ID__set8__<name> symbols, which also provide s=
ize

+1

> >
> > Maybe we need a codemod from:
> >
> >         BTF_ID(func, ...
> >
> > to:
> >
> >         BTF_ID(kfunc, ...
>
> I think it's better to keep just 'func' and not to do anything special fo=
r
> kfuncs in resolve_btfids logic to keep it simple
>
> also it's going to be already in pahole so if we want to make a fix in fu=
ture
> you need to change pahole, resolve_btfids and possibly also kernel

I still don't understand why you guys want to add it to vmlinux BTF.
The kernel has no use in this additional data.
It already knows about all kfuncs.
This extra memory is a waste of space from kernel pov.
Unless I am missing something.

imo this logic belongs in bpftool only.
It can dump vmlinux BTF and emit __ksym protos into vmlinux.h


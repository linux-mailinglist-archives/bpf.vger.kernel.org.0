Return-Path: <bpf+bounces-67600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB68B462EF
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA0C1D21C17
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8D315D35;
	Fri,  5 Sep 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVgobWrK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B06315D22;
	Fri,  5 Sep 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098657; cv=none; b=l7AiOGf88IhtJLRwmz0L/CKCK/vO6NG204KL+pkA/aJFIAavluMHOIgxdMIMa5YKBOMFPjXiVmYm4l0b32vk0FzzcKJOy4gJr7psMgQDYleuR3pHE9o/Q8IWVQF2uUwjzSzNH+Kr4vxpVBhdibzQ762c654zWbyXccOIWAL87xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098657; c=relaxed/simple;
	bh=Sh2W9S33o9oHSqjqqDPu97sA2vKA/BObXcqy8rxc/KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDhUmatjo3QJyo3O6KVvODd/ZKcWuaFcPRei2sm+w9FOWOKHBmQ6fe00u70QTnX1HZ/7ofyowVThVNS+mMc+b+uvIXMns9aKu8IRZEqpbnJ3Ra2mXv5P8jRKGsiS5oCj3uQJrMgJyxrATxa3Ff27fy3i6lPD6jSDjo6kIX3l7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVgobWrK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4fa6cd2377so1565700a12.2;
        Fri, 05 Sep 2025 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757098655; x=1757703455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phcp6Y13YTj5On7joWI7rno+f1V1BMv8Ow6mbXVUb6w=;
        b=LVgobWrKxR2dFFukMqnUw/T7vUc21JrB9aXRt4mmTWJhJPNcey2wqoQTpg0N0LnJ14
         /B1+KNZ8flMD+mHxuETFw7BQv2ysD2oWHcdLaAGLzMD3XWPji9nStpWaKjcsoT8aFrUr
         jvAwG1SzUCI6m1PibtbUlX8rOMpEA8YvbiG5leIKBrlerQ+3sWlhTJq1moobI7edVVnQ
         KU81SWRrDneCX6LkXntH47Bd8iwuuf1EzHf93UoH4oGwx10pBaRSwOK+ZyKhJg9BMDZe
         WbVsvwVYKSDldl+QOq0fnA8vJUCXBWodWRPFe9ogoUXZr6TNw4vINDx8x/yrxFAKHO+N
         DMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757098655; x=1757703455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Phcp6Y13YTj5On7joWI7rno+f1V1BMv8Ow6mbXVUb6w=;
        b=leL8AvcVC8g04WvquOcEUGEQtPa2w3mwAJ69PUpWIlWQVtJh/BmM//DOKOgTrDs9G0
         bFi165cGFY1VXUv7s6EXjCopx34F4qFTyxU0rP8cH7fKN2WZ2eiH+DOq6+g2BFohbWcG
         86EgBsKXsX6DptfMaEL1ZgPXasBLAWxtgz503el0+g7dqSVInSTRHDzo1RY5pQP2+6AM
         uQv/1JbMQ4a3AJcPOzvKQokkgpp5IiqRnaLQM1zmgc9d+PPHvOv+YYmfTxPUzdaGYr7R
         Z0KGwxausys4rklr/sAn1S4dlfY3g3uRoRX+lDH319G+lzNlAarVuoIIm5VXtGh+2NZG
         VDgg==
X-Forwarded-Encrypted: i=1; AJvYcCVooIszWA09xLmIufdoVny1HYPy5wmes4keOl8iDhVML8eg3Aa4MDdLosFIiuAOK12lxcuMmHtP@vger.kernel.org, AJvYcCVzJXbu5xdapaV9B7aOOg+/gMMOH3opzcYQxJ92rO2Vjav8FgHbNEGjlPhXP/CipjW9Fq/TvEz+xrVfgWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcaw1AzmF4pOrmjffowBgVby89+hpDgHJN6r3XtFCxJl3owyH
	QRFLSAGY1uA06U60jG6LIfXmeit4xJRfu9/bDsmljFWzwBi9zzsc/Sm/dtkIBybWEW22wmwGx2N
	fu92XaEVK/SCtXd5l0pLZixHJtGaG7js=
X-Gm-Gg: ASbGncsHMe8ttajDPedl3X63xR6RQWob9hb6pnaQkIyFIdMOyAoBFhxXQejzhHLoTHB
	DtL1e4wyF6kujEIUvj96zfGtNotDkD6FBK+kzac5IUqzj3tcBqgagBq5c3BBx5LpNhNzGKYuk4B
	0pxYXXcn3r0feTVg1RqHeqMBAVYDDbWQOLW54y+k3PiESJ9N064kYuDo8HQwGDO5ypmA717SI28
	cV3COAZkyYKMHI=
X-Google-Smtp-Source: AGHT+IEWUVD5cYlMBi/1ejQQ5/n7xicywFu4Y7kfT/oTopx6krdGSLXXSCmtKhpytMvanDAdT1YNmnjzFXeyQbM4J2g=
X-Received: by 2002:a17:902:e80d:b0:249:308:353 with SMTP id
 d9443c01a7336-24944ad2e89mr321812025ad.41.1757098654855; Fri, 05 Sep 2025
 11:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905051814.291254-1-hoyeon.lee@suse.com> <3pevfugpcd2j44b2wkrjhspn2a2ta627nhnqxc6ty7dxy3nt3v@qhytbn7lmqum>
In-Reply-To: <3pevfugpcd2j44b2wkrjhspn2a2ta627nhnqxc6ty7dxy3nt3v@qhytbn7lmqum>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 11:57:22 -0700
X-Gm-Features: Ac12FXxq2WqmGReWjLpExvK8MuV1pV6f8MehGAHjrpq7LQVwRkY2LEyn3ySnMWg
Message-ID: <CAEf4BzbsLP-_GkWaW5t4vM61m=qXEBOeOEJKShmB8_T5Ab8puw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 0/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Hoyeon Lee <hoyeon.lee@suse.com>, netdev@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:42=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> Adding some context that I think was miss per off-list discussion with
> Hoyeon.
>
> On Fri, Sep 05, 2025 at 02:18:11PM +0900, Hoyeon Lee wrote:
> > This RFC adds a compile-time check to bpf_tail_call_static() to warn
> > when a constant slot(index) is >=3D map->max_entries. This uses a small
> > BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.
>
> This is an attempt to see if it is possible to warn user of out-of-bound
> tail calls, with the assumption being that with bpf_tail_call_static()
> users would not be intentionally calling with an index that is superior
> to the number of entries.
>
> However, there concerns with the current implementation, so this is
> being sent as RFC to gather feedback, and to see if it can be better
> done. Currently the concerns are:
> - use macro to override bpf_tail_call_static()
> - only works for Clang and not GCC
> - uncertain whether this fit into libbpf conventions

- map definition's max_entries can be set from user space at runtime
making this check actively wrong


This diagnose_if attribute seems very useful, but I'm not sure we
should do this for anything map-related because statically provided
map attributes are all overridable from user space when loading BPF
object.

>
> > Clang front-end keeps the map type with a '(*max_entries)[N]' field,
> > so the expression
> >
> >     sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)
> >
> > is resolved to N entirely at compile time. This allows diagnose_if()
> > to emit a warning when a constant slot index is out of range.
> >
> > Example:
> >
> >     struct { /* BPF_MAP_TYPE_PROG_ARRAY =3D 3 */
> >         __uint(type, 3);             // int (*type)[3];
> >         __uint(max_entries, 100);    // int (*max_entries)[100];
> >         __type(key, __u32);          // typeof(__u32) *key;
> >         __type(value, __u32);        // typeof(__u32) *value;
> >     } progs SEC(".maps");
> >
> >     bpf_tail_call_static(ctx, &progs, 111);
> >
> > produces:
> >
> >     bound.bpf.c:26:9: warning: bpf_tail_call: slot >=3D max_entries [-W=
user-defined-warnings]
> >        26 |         bpf_tail_call_static(ctx, &progs, 111);
> >           |         ^
> >     /usr/local/include/bpf/bpf_helpers.h:190:54: note: expanded from ma=
cro 'bpf_tail_call_static'
> >       190 |          __bpf_tail_call_warn(__slot >=3D BPF_MAP_ENTRIES(m=
ap));                  \
> >           |                                                            =
 ^
> >     /usr/local/include/bpf/bpf_helpers.h:183:20: note: from 'diagnose_i=
f' attribute on '__bpf_tail_call_warn':
> >       183 |     __attribute__((diagnose_if(oob, "bpf_tail_call: slot >=
=3D max_entries", "warning")));
> >           |                    ^           ~~~
> >
> > Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
> > compile-time warning can help developers detect mistakes earlier. The
> > check is currently limited to Clang (due to diagnose_if) and constant
> > indices, but should catch common errors.
> ...


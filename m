Return-Path: <bpf+bounces-56550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E43A99BF4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BDF1B814A5
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8322F74A;
	Wed, 23 Apr 2025 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAOPDj2y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF620297E
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450419; cv=none; b=AgGkRuyGCgvzDW3o27EeR3GZO9aHY8tR0XJMUpNluohBLBTn2NvJUlnAZjOZLVM/5MZRbHd37uIxKWUbhFhw0Vw3WT7nxE33qdJE8kv+5kptbkx3Ts/qxgRbiz06VvuYFf0VI+Oeqe+Q/HubFj6Zz6qzyiawSTEjfS9qp6W+BcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450419; c=relaxed/simple;
	bh=gBSZcmoKs05GEPOCE/9I2ddkaztZARxqe0cCnsxPbuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atx2totUWwwix8zGLQzjNs8GrV4O8aPBFGFSIMiuTxrQ4cFs7lBsPfGKe69Mht5EfUUb/8QJVUumbOAMmja3M/2TkSvV3F6p+Djfzt0CONtwRgr49Syc/rtf547oIqrzsGtKNOyGSxoqUvqbCe6zOLhm99uUzWaTSMEFRGoyUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAOPDj2y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so213086a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745450416; x=1746055216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba3njgXOWb/2IcSn+2bQmLRctjovyKj04CuKA6avBUg=;
        b=kAOPDj2yjXGmsDZoWoxsZ4m2BsT0pgIFoRrQUSppbPuh/TR5eXBUncRwucIJb4oNkN
         RrVXyRa6XMgWBdQe9QBsUbP8XGSlRZ4QRfZXB3VuvJWCb/a6Z1JhtrHcTAOokRE3dQgm
         DjE/iX424zs6rDV05fW8ztclpPjNeBBAQ3tHBvPZ38K6/pFJTe7CIKmSbIa67OTGx/EE
         WZRwph8Z281INqBQzQx4ihGiDLwqRYercKKFlAXZkkPSntlBQfWs+GLEJcornhYB7jFs
         GifrGCgkE3onWD8ZVuTZTWZhYU88SKDtoEsrNTBv+3n9OCxqn+Betifq6ARyk0zVm5BI
         fl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450416; x=1746055216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba3njgXOWb/2IcSn+2bQmLRctjovyKj04CuKA6avBUg=;
        b=q1ozWVtrHjvVJ7AB6krrPyxNdLC9JGQ6OPze43CyaUXDJGWeCbQaTpL8hxzn7CLbHn
         YeEmhCSNN0sC1znjJ91lT95UifFICpmqi/Kjg0LIiLBs6rhFOB1JGd/jpSVI5IAJagZT
         f8EAt//TsbPTrwwomqqCAsiVja8gANfeFYhVnFlqaObzeRDQuvYvIxqgy+HyAouUlIXT
         sENu551PDQG/ED6G3PZAJwV+fDVyMBkigeVikLcOtCFaP5AD2fFY+R3hHNZeNowqDmPh
         zNrcnOsE4+14njCB1tj3/rP+XYahAfqvxyhlIzH9d+xXh+aMLKlJ0aL+Y1MZ5DUgEBy+
         Anpg==
X-Gm-Message-State: AOJu0YzE7sLc46uyFYRMUqDnz7ahfOMhdx+t9ZZaXVc0R8Fhm/1UWJ+H
	OSHlWq9XFSeA0rSxRXV5+ABGpZ+phEz5Wpp7nYHLj4xfZ+eis2tV07Lcsq2+T1DVllqCckk8B91
	Wf5TGUdIfLer258PA7Kk8VM2UFY8=
X-Gm-Gg: ASbGncvaHCq/8HnUdOD+MTlB67f6nt7vK1b33czX4BOfows/dV313dbwPjt06+c9X4/
	L5634xq+PFcGAFD8gU6QFt5rfOHkAMeBRuzg/DSlkBjeWBsQJSLsnKZm4VfmWm/7uk1F876B1AQ
	dD/Cr/jkrLKQ7ob0TZIoA9V4idJlq4UHPGmaJzdw==
X-Google-Smtp-Source: AGHT+IGwuUaMVe+at59d4GXmyxcbWTLq/YN5XoEVjb3z/ucLXDh4zpv8BuVnxw+N3iAF8K81/fzNGfEF/hN+yGfb2Ow=
X-Received: by 2002:a17:90b:5847:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-309ed34bb12mr851771a91.24.1745450415892; Wed, 23 Apr 2025
 16:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411011523.1838771-1-yonghong.song@linux.dev>
In-Reply-To: <20250411011523.1838771-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 16:20:01 -0700
X-Gm-Features: ATxdqUHwLcXOuIwu1gV1_J4v237Z-hEg0spJp4YcylEx788CBHXY6VYrXhREpJo
Message-ID: <CAEf4Bzaa=AYujxnFf3B8ELQWev4ZREz4qXb_=DDoGPEe30iPhw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/4] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:15=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Current cgroup prog ordering is appending at attachment time. This is not
> ideal. In some cases, users want specific ordering at a particular cgroup
> level. For example, in Meta, we have a case where three different
> applications all have cgroup/setsockopt progs and they require specific
> ordering. Current approach is to use a bpfchainer where one bpf prog
> contains multiple global functions and each global function can be
> freplaced by a prog for a specific application. The ordering of global
> functions decides the ordering of those application specific bpf progs.
> Using bpftrainer is a centralized approach and is not desirable as

typo: bpfchainer

> one of applications acts as a deamon. The decentralized attachment

typo: daemon


> approach is more favorable for those applications.
>
> To address this, the existing mprog API ([2]) seems an ideal solution wit=
h
> supporting BPF_F_BEFORE and BPF_F_AFTER flags on top of existing cgroup
> bpf implementation. More specifically, the support is added for prog/link
> attachment with BPF_F_BEFORE and BPF_F_AFTER. The kernel mprog
> interface ([2]) is not used and the implementation is directly done in
> cgroup bpf code base. The mprog 'revision' is also implemented in
> attach/detach/replace, so users can query revision number to check the
> change of cgroup prog list.
>
> The patch set contains 4 patches. Patch 1 adds revision support for
> cgroup bpf progs. Patch 2 implements mprog API implementation for
> prog/link attach and revision update. Patch 3 adds a new libbpf
> API to do cgroup link attach with flags like BPF_F_BEFORE/BPF_F_AFTER.
> Patch 4 adds two tests to validate the implementation.
>
>   [1] https://lore.kernel.org/r/20250224230116.283071-1-yonghong.song@lin=
ux.dev
>   [2] https://lore.kernel.org/r/20230719140858.13224-2-daniel@iogearbox.n=
et
>
> Yonghong Song (4):
>   cgroup: Add bpf prog revisions to struct cgroup_bpf
>   bpf: Implement mprog API on top of existing cgroup progs
>   libbpf: Support link-based cgroup attach with options
>   selftests/bpf: Add two selftests for mprog API based cgroup progs
>
>  include/linux/bpf-cgroup-defs.h               |   1 +
>  include/uapi/linux/bpf.h                      |   7 +
>  kernel/bpf/cgroup.c                           | 151 +++-
>  kernel/bpf/syscall.c                          |  58 +-
>  kernel/cgroup/cgroup.c                        |   5 +-
>  tools/include/uapi/linux/bpf.h                |   7 +
>  tools/lib/bpf/bpf.c                           |  44 +
>  tools/lib/bpf/bpf.h                           |   5 +
>  tools/lib/bpf/libbpf.c                        |  28 +
>  tools/lib/bpf/libbpf.h                        |  15 +
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../bpf/prog_tests/cgroup_mprog_opts.c        | 752 ++++++++++++++++++
>  .../bpf/prog_tests/cgroup_mprog_ordering.c    |  77 ++
>  .../selftests/bpf/progs/cgroup_mprog.c        |  30 +
>  14 files changed, 1138 insertions(+), 43 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
pts.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_o=
rdering.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_mprog.c
>
> --
> 2.47.1
>


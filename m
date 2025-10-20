Return-Path: <bpf+bounces-71448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34700BF3A2D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3A14350751
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33412286D40;
	Mon, 20 Oct 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpzIp19v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8A2AE70
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994341; cv=none; b=tBnyvqRtBtqQxq7D8pZVuNOf/MQ/Y6+5Xyi+p5ETvXQo9XGrDWd3TkZDADtJo2C2Ia1d5giDdttgujExltQOdovqI+Rlb7z91M7dPqWJBuXKiup4sPqCS/vZRHoVvwN5683Z96EyPQBcdZWTnDBDKeiHDWvDqY8O86+UQ2v0SAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994341; c=relaxed/simple;
	bh=z6Ar+MLWXgc1v2fGJl7t2AAUa3mWnvgo/Z5MuOIgUHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsKokIXFyNYVcrQHzzVib0buAE1GtWCfCvQCZUEHNE823PFOLhMMF5XiMDZnxKotiD1Yk7PFcvkhK+voWBBV/S2cvdaolHkqSxzNUEpIP19f5NHZmXcwILEMaWUgZ2ZsCWT0ChWA03DJjFJ9/4EcnLjYoKJ9/bzx9Nr12I58PV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpzIp19v; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33255011eafso4512254a91.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760994338; x=1761599138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUp80wXbk5PgbAm/scZegvJdtZywNfM5rdkFlqw+pdg=;
        b=bpzIp19v3UAFCcmC01xgYnQzYOMubUqVzt2EtidVT5rQPRjud2DTgHW3YVOV16XoL/
         fGSMMCZPzTXblToJPfomhuMT6bBrSU5w498XxEORGBOGdSDfR3rApojhGKV71ifiCpRc
         ulfVn1gzDJ8T14QeICtV+Soe/kLPI6kJQ/v8VWuk87oxziEjKL/FNtrh0e24wNjHQZiM
         F4WINx1H/5Wfj+EM6PIggHtObPuuedKFqFLsg+DNRvFG+OxOzht0R5YRzgJZdNPnUpXr
         K+0Rc9Czvubk3SEbVaygkmkaK6bko+Z2nR8ez9fIuhT8ZOrwIe1EqyLoKuGQXD7f1go8
         PYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994338; x=1761599138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUp80wXbk5PgbAm/scZegvJdtZywNfM5rdkFlqw+pdg=;
        b=SsWtUMoKpLur+vtLFfaVJKgGtvTcfQh4MJkdWRFALZTiGWpbG81RZ3M2e+R0GsKmPd
         jiaH0XjmHxuAUoLu5IuSe4ZlXv7dQhJ1OCFl8k6S6ktSKpvDycxtTcpfVHU4Ncd3jubU
         wVLrvynrBSjQ9639IjaMGI/ebJo3kW/zu/ulNN0O9bPXbl89MIyr0w4emapKb4YqucHy
         kJJwn9axiagEf4uYzMoXMIdHEfZR/edj8GQ3D77Mueo5hcxzv8n+SPPQiCCCb4R1TJBv
         9kWh4PEhUl8nNbNwIaQNqXVchJhdWqzxETmXBL4RY7ROW0DfTgGL4FcG7TCtZztRSRk2
         fWSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNXX9BZBt25PS3jedpw9Ht+H3muAvCJuOP/mnOG4KYbDTaCbjRQAd+1nCvNyze08gje+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2owQK4BWpZpyDnizD0/gEC5bzFXxaaLXOJwdDmnKVddYP1f9
	JCeOnFGXBsKYU1nhuoCE/Wv0tlbo1v3irlBKinQhpwGNw8hNlpcNY2EYhvlbImfdY0JYiBamK9a
	0D/HyfU2mPblu/KnzLznTQosW4XeRc38=
X-Gm-Gg: ASbGncvQBxsQ6JSgj//aR64Y8GE5EFQ5PrEMEvaPX7r8Ku8l0+tgdZuum2GsCHJwsrE
	L5+PXnX3/2puVKcr//PVyzkrgunpfWeGZ22YMzcgcxxTPy0uM68Hmw5b96bkSdzCfezsaEksbal
	odc3r3CZAR1q9i7JCeN9rr6am9SxYzqk8PYzUFjk+JzzG2vogXpd6ARKUOHt9n08Brl62sPoQeO
	l9xQ03r860KyumGC3tQBks7KhQaJJhvSCzzWhTtM0reTMFmlVUtjeFIDcggjf0MYgEK7vwKkhN7
X-Google-Smtp-Source: AGHT+IFt1JpI/Mpcv0+vUB6DHzglzifzY6dMdwEKAMlqcillHqNCrdYhPzqqPZiVWOFkpECimJLKuZderSbj6uXMHrE=
X-Received: by 2002:a17:90b:1801:b0:330:4604:3ae8 with SMTP id
 98e67ed59e1d1-33bcf8ea23emr17208045a91.21.1760994338380; Mon, 20 Oct 2025
 14:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-13-alan.maguire@oracle.com> <CAEf4BzaharR9cnR9Yd5Shoq8A6afJo0HW+N7cw3k9JhGZmqY4w@mail.gmail.com>
 <bca00601-b45d-4977-8d54-20a97192029a@oracle.com>
In-Reply-To: <bca00601-b45d-4977-8d54-20a97192029a@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 14:05:24 -0700
X-Gm-Features: AS18NWD4bY_A7skhtGcl96sRI2P8wgMYXrN0Ae_VTYCER53IgVepj9uAuT_MfDM
Message-ID: <CAEf4BzZ8Lp3R5amFGuqAYEfK4hwTVWV6eU+nqjR-YwOZCdaZjA@mail.gmail.com>
Subject: Re: [RFC bpf-next 12/15] kbuild, module, bpf: Support CONFIG_DEBUG_INFO_BTF_EXTRA=m
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 6:54=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/10/2025 19:37, Andrii Nakryiko wrote:
> > On Wed, Oct 8, 2025 at 10:36=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Allow module-based delivery of potentially large vmlinux .BTF.extra se=
ction;
> >> section; also support visibility of BTF data in kernel, modules in
> >> /sys/kernel/btf_extra.
> >>
> >
> > nit: whatever naming we pick, I'd keep all the BTF exposed under the
> > same /sys/kernel/btf/ directory. And then use suffixes to denote extra
> > subsets of BTF. E.g., vmlinux is base vmlinux BTF, vmlinux.funcs (or
> > whatever we will agree on) will be split BTF on top of vmlinux BTF
> > with all this function information. Same for kernel modules: <module>
> > for "base module BTF" (which is itself split on top of vmlinux, of
> > course), and <module>.funcs for this extra func info stuff,
> > (multi-)split on top of <module> BTF itself.
> >
>
> I went back and forth on this; my only hesitation in adding to
> /sys/kernel/btf was that I was concerned existing tools might make
> assumptions about its contents; i.e.
>
> - vmlinux is kernel BTF
> - everything else is module BTF relative to base BTF
>
> If we're not too worried about that we can put it in the same directory
> with the "." connoting split BTF relative to the prefix
>
> /sys/kernel/btf/[vmlinux|module].func_info
>
> Don't think a "." is valid in a module name, so there should never be
> name clashes.

Yep, I don't think there is any compatibility problem to worry about.
Let's go with .suffix as a generic way to specify extensions/subsets
of BTF.

>
> For completeness another possibility is
>
> /sys/kernel/btf/func.info/[vmlinux|module_name]
>
> However I'm happy to adjust to whateer seems most intuitive. Thanks!
>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  include/linux/bpf.h       |   1 +
> >>  include/linux/btf.h       |   2 +
> >>  include/linux/module.h    |   4 ++
> >>  kernel/bpf/Makefile       |   1 +
> >>  kernel/bpf/btf.c          | 114 +++++++++++++++++++++++++++----------=
-
> >>  kernel/bpf/btf_extra.c    |  25 +++++++++
> >>  kernel/bpf/sysfs_btf.c    |  21 ++++++-
> >>  kernel/module/main.c      |   4 ++
> >>  lib/Kconfig.debug         |   2 +-
> >>  scripts/Makefile.btf      |   3 +-
> >>  scripts/Makefile.modfinal |   5 ++
> >>  scripts/link-vmlinux.sh   |   6 ++
> >>  12 files changed, 154 insertions(+), 34 deletions(-)
> >>  create mode 100644 kernel/bpf/btf_extra.c
> >>
> >
> > [...]
>


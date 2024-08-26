Return-Path: <bpf+bounces-38085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9A95F645
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66B8282B61
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100A194ACD;
	Mon, 26 Aug 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evCIvVgt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5119412A;
	Mon, 26 Aug 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689094; cv=none; b=jAQ4BqbkjiZa0guVZRSJ2rcOV360q8YTB0YUb0YWfJInNGjUpH5f6VNp6n/qslAQQ1wvarxWQlyKQvX8LTpPIfqJNGQT5i2rvvUwzlr1aDdv09wS/MS52pzzcIBBEJtzEGVkTxaChmKXbEkoOrD8iiHUC297Z7gjeLviYRAq9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689094; c=relaxed/simple;
	bh=rHfc3tUO0PlXoEJaAEGPazJsuKQe7Tx6BQoOTkHo4QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZt0Q8t9GkHfZLCBsQvmBxy4qwOOJ2s099/L0zuZBed5H5v7SjbNovsjIwMWmGzTefKY7qLLz244WJgWriM/OOLP10+FKkLrF8DeU2+CTLZ2kRzCIqcMcRL/1Fp0wRCIB4dcv82RmEtwgZSMcpj8bD+Dg4MezgDdb+MCXLCILBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evCIvVgt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso3470563a91.2;
        Mon, 26 Aug 2024 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724689092; x=1725293892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxRlPyW1oHXAOOQ1Sj4I0wIP7vxw0OFPP0mCZsrFZrU=;
        b=evCIvVgt1k3/t/wB0Gj+BjlcdMqDb5M8vJb6RZoZN0njai4PPikNOpMh6io0pPmtyX
         4Clr3buIeUNoMZ+by+vUcKW3AZxuTHPN8HAUoqj4WPKiej4OF9rMwCVEYl611ISl7yAM
         0k1LIfsrvbZ0BZArCG86bdEMMd42Q6RW53L20lLHF+/21iVOak9+i52eqok06OEMuv5D
         ro3LPDpwKUwouiRo0+3RC09RhtZYc3ziyhG8agB/gkP/d+6Q6OpD4BcWSyvI82oY2IJy
         gvJHWJ2aNef8I/SmfMLo4QE9tmMBfzAmb1yNL3yBaYUIsV3Rq5xAkQrqpW8s+3ITr6Ah
         tHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689092; x=1725293892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxRlPyW1oHXAOOQ1Sj4I0wIP7vxw0OFPP0mCZsrFZrU=;
        b=vtH8HN52q0nBBRJqwBaQKsKueuq/2wEYPC6N7kcX6u2JGA6w86f76agFX1bnyPPDt8
         at164vSxeQxTwifBzfFC3lpuWN5NAnAS7ylbF1NoJ+lCJxKRI4A2U7fZ8mwfsFm/MObM
         kWkIOFwHCMK+i902JImXPKQRBfaq/ji9u98nW420xcXTQhxLYaKyDaLdX6/zLrkJbfl9
         mqxzfnxBP0dTnjpgTPUwp63r2u+6wAcyyTnWEcjOpCXibmvjfNoqj/CzUs8WoZrkTNY0
         rJY3JegXcpVeDFMnvdNcknyLRQHO3kKkAsmVgdbmx/EsxNkYvgUnMlJeZHt9BrriKI92
         9IKg==
X-Forwarded-Encrypted: i=1; AJvYcCVtMPqCgl1OWnUbN7OxNFlpvCx6rcy0fwr1/iXD9qDEKEi8jJw8S38koPu/EhwGjActsmc=@vger.kernel.org, AJvYcCVz3O3ZkKl6xhI1lIy9g4G/2iDVuBrq1m9pZ4U+O5XdYMNWvsbECJ1NKEZI148jKhZo8N6qgIzX/oqFNnB7@vger.kernel.org, AJvYcCW89FTY2khSHwctRvNb/v6cJKpJczsF7D/FMStpYUS7HLT1aacxR5sn7cTD2tEShCabM32sa8p3mwFCfKeOb+kjctg7@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGjyn5K02jAeTaJxTbI/AD8AqenFcVQ4Cj0qQ9ht5rWXTxSLF
	N1PYyG/UvcLRind3ksBnSxdTwPEPs2Qw6Q3VuR/odoeXINKnapPfhlanvlNh+UvLGyQMf7w5QlL
	ZOZC9Xd79PFhMOOe8amRYIr4J6rE=
X-Google-Smtp-Source: AGHT+IGRORuD5KXx1BI1X9UTnYM6Ctxz/wPpGOqICBOnAnMjMwqqox1Omxa/T6kOEq975iQJ2a7W/qEE2j/UGSD5nw4=
X-Received: by 2002:a17:90b:1b0a:b0:2c9:80cd:86b4 with SMTP id
 98e67ed59e1d1-2d646bf64c2mr9713580a91.11.1724689091970; Mon, 26 Aug 2024
 09:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809192357.4061484-1-andrii@kernel.org> <20240813223014.1a5093ede1a5046aaedea34a@kernel.org>
 <20240813154055.GA7423@redhat.com> <20240825191512.98a6ea20b4783345f4d5ba1b@kernel.org>
In-Reply-To: <20240825191512.98a6ea20b4783345f4d5ba1b@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 09:17:59 -0700
Message-ID: <CAEf4BzZgu4-aosJqjVZQCX27v1Y67GUT0UOvDUOn2EB2fJDvSQ@mail.gmail.com>
Subject: Re: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU one
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 3:15=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 13 Aug 2024 17:41:04 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 08/13, Masami Hiramatsu wrote:
> > >
> > > > @@ -62,7 +63,7 @@ struct trace_uprobe {
> > > >   struct uprobe                   *uprobe;
> > >
> > > BTW, what is this change? I couldn't cleanly apply this to the v6.11-=
rc3.
> > > Which tree would you working on? (I missed something?)
> >
> > tip/perf/core
> >
> > See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/diff/ke=
rnel/trace/trace_uprobe.c?h=3Dperf/core&id=3D3c83a9ad0295eb63bdeb81d821b8c3=
b9417fbcac
>
> OK, let me consider to rebase on tip/perf/core.
>

Hey Masami,

I've posted v3 rebased onto linux-trace/probes/for-next, so you
shouldn't need to rebase anything just for this. See [0] for the
latest revision.

  [0] https://lore.kernel.org/linux-trace-kernel/20240813203409.3985398-1-a=
ndrii@kernel.org/

> Thank you,
>
> >
> > Oleg.
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


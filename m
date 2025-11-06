Return-Path: <bpf+bounces-73878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD3C3CB39
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22942352559
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A834B677;
	Thu,  6 Nov 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGZa7pLE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38212DAFD7
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448765; cv=none; b=hTABhhfm1jgjoHr9cRUCCkcmppY6AlVYhcE9AHoFGc+mbTgPXKpUfiOA41ph9omGgxzwNwt7SO1FIqvsL47y7hvtB9hIxwGtMo/cJr0MfyFs3QirLIHrPK/yR2Q/Wta9+cE+9FKAigC6I4azhK2UcOrCNc2vb6XSQTCZpf0wLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448765; c=relaxed/simple;
	bh=ockhHoTt9eTm2xzApz/GPva9wcnSND6rwRpraHnkLdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LounT6apT7so/N0ye5V+He05gN0fJu6UAdUP2iwUnr1dbL4dhkatN+0GUO2hr6oJG+Wq92uMdfG3IA5cXq7UZvvGk7D4Z1BSZ81WBuybXgbJmd+5Giiabr1tGhRpJ0bZQqL1BFYJQ6OAezuFJfg/7Xrxeg5usT62UhcNiqHNA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGZa7pLE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso2201822a12.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448762; x=1763053562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjl191vGav29usv44vPRctI8BG6+/lKA11uH35Z+UYw=;
        b=eGZa7pLEJyJzpdjIVwkXbfkh63uBJcFc/hd04cQ1cCEpLedN2Aoqj2K8CUkTxaidYT
         whq1WGQz7aI48wlin0hV/+DAC9dbMnyTua83bEFm6rOfSuVwbcFNFR0kca1qaITXBMWD
         iK7929b0CAaHFoGgWiHnfNgnmnXRxXtQ5nfxZ0wv/UaszKaIDdmx2MttDDFD8KkJZwSZ
         Y0WSzFoTxsM6clkoJY5VhyMCUZYYpW8Ig9g9tBSfzCTjYgtRC+fCzcLdGiPNmvsfDLPt
         WH4WUQ4a0tYHyGDW/AOVG8Hy0cniTwew7ivMhOx9tyfOR3nH2Yav3hQVg0cloK6IxSL5
         EmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448762; x=1763053562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjl191vGav29usv44vPRctI8BG6+/lKA11uH35Z+UYw=;
        b=WMvYq6dMrLh3s0AlmeZR/VrlVY1ix4SgGkcCE8ueNTjpnBQfcArDlV+G1SwkuAMunH
         j/dQRiFrhxGGxnjEVTAiZyGSKwMSpcDLMSTaDT/OEua61GHUrtLwp88l7sXA0EB7GBUR
         luRuSbpvElAjZagsDqN+KD8nLsHYW6cZcDaE5YkceJSoePo1d7/qrDpKQsgDbwJCRmHC
         BMUxa7FH/VAqjH7sCrH5d82FcsZYc55o1mkdx7NyPbGXPXLfKxGpDZl6NYk2+it87AH5
         Ef7iErdRujUfOtzhoxqpyuD+UoECu/6FQkYFvTKIH4zwSE0KqeNl6giLM8ZzUR6OKgCm
         kB+w==
X-Forwarded-Encrypted: i=1; AJvYcCUk+8X7HtE625AJgKuCqOkaed4O5M4EbeOSUhFajSxdXncuoH0fd22/M/bLSGkXS/w/9N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/OoNpNvDYo/1knKLxOgSr+UZJFFjLrgXX+JELI4djn2YWfUD
	/aLnOb3I3g+znWWmgd9mis2fKf088IF0Vobo4TAdmffXUEwdM52DoyzztJILNgVe/7F4U0Stx0f
	/bX+63TJvh8TEwEkmpUT7j8Xbw9V681A=
X-Gm-Gg: ASbGnctVuqdExquJTPmNopMHykKCe+eCrncdyMrPwhZE3u2CjZBHbN7DrudclurJlnM
	86EhbBu+5xecPQ1NBZF/oIzbyHzdk4oTt5vC3opYX+YxYwHtFYEMYTe8UzqThIYhRSMqHpLjgWs
	iAhwOaOhMooUY1jlHxnMUfhDxGjLDyHJWFerrLEg2XX2cxbJ8ylCOeep1lwkGp1FU7wvVu9Qwby
	kqggBk5IeudiJz/H6XTSVOk03Antn04omdBZJPQSo9Kk5DB80jCSyEWsdc=
X-Google-Smtp-Source: AGHT+IHiSTxJuhsLQMkAS2/GVoELBe0ijnJzl1doCsdrM7L3zMqDmO1yne4NBsb409neJQdiTnxCjcsH59/r4rP7z8o=
X-Received: by 2002:a05:6402:2688:b0:640:9c99:bfac with SMTP id
 4fb4d7f45d1cf-6413ef1fb89mr110516a12.13.1762448762054; Thu, 06 Nov 2025
 09:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106162935.7146-1-puranjay@kernel.org> <CAADnVQKRAVPmmUrS6VAiPm13P3XgwkOqmd7kDurbTR8jcFqD4g@mail.gmail.com>
In-Reply-To: <CAADnVQKRAVPmmUrS6VAiPm13P3XgwkOqmd7kDurbTR8jcFqD4g@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 6 Nov 2025 18:05:50 +0100
X-Gm-Features: AWmQ_bneMRN7CfMgzg5bRM6_pTdXGlvShchE37_H41EVSQ4aqMWG1I8IAPhnr4w
Message-ID: <CANk7y0idxnbMvdtoD3KDDV2O5W8tuKpg19QPcGLm2Ry-aG0pEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use kmalloc_nolock() in range tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 6, 2025 at 8:29=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > The range tree uses bpf_mem_alloc() that is safe to be called from all
> > contexts and uses a pre-allocated pool of memory to serve these
> > allocations.
> >
> > Replace bpf_mem_alloc() with kmalloc_nolock() as it can be called safel=
y
> > from all contexts and is more scalable than bpf_mem_alloc().
> >
> > Remove the migrate_disable/enable pairs as they were only needed for
> > bpf_mem_alloc() as it does per-cpu operations, kmalloc_nolock() doesn't
> > need this.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/range_tree.c | 22 +++++++---------------
> >  1 file changed, 7 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> > index 37b80a23ae1a..2f28886f3ff7 100644
> > --- a/kernel/bpf/range_tree.c
> > +++ b/kernel/bpf/range_tree.c
> > @@ -2,7 +2,6 @@
> >  /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> >  #include <linux/interval_tree_generic.h>
> >  #include <linux/slab.h>
> > -#include <linux/bpf_mem_alloc.h>
> >  #include <linux/bpf.h>
> >  #include "range_tree.h"
> >
> > @@ -21,7 +20,7 @@
> >   * in commit 6772fcc8890a ("xfs: convert xbitmap to interval tree").
> >   *
> >   * The implementation relies on external lock to protect rbtree-s.
> > - * The alloc/free of range_node-s is done via bpf_mem_alloc.
> > + * The alloc/free of range_node-s is done via kmalloc_nolock().
> >   *
> >   * bpf arena is using range_tree to represent unallocated slots.
> >   * At init time:
> > @@ -150,9 +149,8 @@ int range_tree_clear(struct range_tree *rt, u32 sta=
rt, u32 len)
> >                         range_it_insert(rn, rt);
> >
> >                         /* Add a range */
> > -                       migrate_disable();
> > -                       new_rn =3D bpf_mem_alloc(&bpf_global_ma, sizeof=
(struct range_node));
> > -                       migrate_enable();
> > +                       new_rn =3D kmalloc_nolock(sizeof(struct range_n=
ode), __GFP_ACCOUNT,
> > +                                               NUMA_NO_NODE);
>
> bpf_global_ma would consistently charge root memcg, since it is
> saved at init time, while above kmalloc_nolock() will charge
> random current task.
> Let's drop __GFP_ACCOUNT.
> The rest looks good.


Sure,
as this change is small I will just send v2 right away.


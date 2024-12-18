Return-Path: <bpf+bounces-47202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D09F5F3C
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 08:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5EF188C22D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D63D1581E1;
	Wed, 18 Dec 2024 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNCTa5yl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE214B077
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734506731; cv=none; b=op+DoiZyzP4f55ac4okqD0T290qEbAkXe9NyaSJSudWzgANH67BInhLtHcW2uoADd6BDui3lLNI1OGzYoMuLac589OesnyfA+tI50vUN+0v3f65iP+NdjBGAQaMUdHwF6R0Q4vxpvlJSf81UuiUXi0slOpbiuk2TGnfBZQU73CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734506731; c=relaxed/simple;
	bh=NexonXHCdgEyg5usR8nRCaBcc/CF5+jjNDqZOrb9Z9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilok6w+PK2Xabn2SGwXKUoUYzVPlS8LmjBdh09dxkGKfbJj2/vPwZBbZZCs1D4TvunKvhOjwzx4MQALES9xM63VEMQimpwCXe7TnihvPWBD/8KmBpqUXNQUqhmrbsJHv6eVt9hklysso8Nbsg4PXzmQnxTPj5L7efeu/x1TRr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNCTa5yl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4363ae65100so37501855e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 23:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734506728; x=1735111528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NexonXHCdgEyg5usR8nRCaBcc/CF5+jjNDqZOrb9Z9Q=;
        b=HNCTa5yl9nmAgbF3et9X6v8vYVxmgSZsKvRdNGM4v3Aymw5QxU/B5+OABku7VEOvvB
         8n3CYzee3NtlGnwJqF4UVoiCvjP6DVDmVqwhCbGZ/69llKl42V/pI22Fwbk0aiLlti3/
         jlpHK2SlRvK4e5K5S/Wo4VEaO6/PIyh05RNftNNDI/TFndyLKUdPvMlYgBd2TlxQK/4I
         yKwUBSTo2KvN3d6SRLxxyJBxMrWMycQdOG68U6CeJ+UyrdUBxQQkxcMSVLWEAQYwEZB+
         RvBjRjWpmIsST0jFF3YwdjQMoABu2VIOBAWpTBgg/4cV9CgdhsFT/a9MLC8452FhdoaQ
         3hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734506728; x=1735111528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NexonXHCdgEyg5usR8nRCaBcc/CF5+jjNDqZOrb9Z9Q=;
        b=BWl6SO7h2jsir46YcmXdStcKh2IAvlKybvrwc7WzCohBfovRZyFARr8okr4G5x1y0K
         7e/2vUuWvsvR7jq3fFI5VYDZMyO6Vpk2sLOIVL5VHN1TAK3Neufesl13xXxGfQorLG86
         BGF5jXkEMHI1pmC02vmrIFLNssqVOikIBfM8fnwfH7iK7+hNSiu3Ybf64+pnOBuYSm0S
         ObF3NPKvpB2qJ7LI8Wj+LKjcsaSFyQ8QkEGYAyxTbxQTfZtWtGwbkVKlmryfCsK7dM+L
         swHecSMt1xaEA/8kw6fib7PKw8TiAzT8xadIJF5Qd0uBX1B0XQU/i007S7/+pFagHeUb
         rYjA==
X-Gm-Message-State: AOJu0YwsXx8jnbny33+z8B/m5lk5tDQHcC2h8jL9BmfK9rd2dY31+c2l
	yjgnuN05t6jNooiHw7p0BarnxKhwUKU/kL8QCagZTeJSGXD8a4lNLY/R/lfJgh6MHLDQP+R6DBR
	3kt+OANZzynAykSwUt0pYjHkhgng=
X-Gm-Gg: ASbGncsJ+DAn9nwco7MS9GtzDwikdAP8Rl88wPSB22tJvQsyTMA4k8Vu4/UVm00e/ko
	Rqajf4KGAZ4gmiBC6CmjhR7z/slFT/T2v7AQzWQ==
X-Google-Smtp-Source: AGHT+IEdLUMqloqI1IlrJVK67PP8kElwYcGmKTgTFQ2kAOuCpjkyw1z7K+gTq6haCfRr78So5SF1E2NJxkSqg9cKeRk=
X-Received: by 2002:a05:600c:4fd1:b0:434:a706:c0fb with SMTP id
 5b1f17b1804b1-4365535c40dmr15719335e9.10.1734506728142; Tue, 17 Dec 2024
 23:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
 <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com>
 <CAJD7tkaP40Tde1KHr2t8O9dHyiRSx8Q02=EmPtROyRpS+_qPDg@mail.gmail.com>
 <CAADnVQJwcd=PsdxcipiN8VeJh2UhSv3uzHkX5E5RuLK2vfdSHA@mail.gmail.com> <CAJD7tkYkhojXE0wwOxEMV1uWb-9hxyqbjD5Uj9ji3+GdZmZnKg@mail.gmail.com>
In-Reply-To: <CAJD7tkYkhojXE0wwOxEMV1uWb-9hxyqbjD5Uj9ji3+GdZmZnKg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 23:25:17 -0800
Message-ID: <CAADnVQKwOg0D291ndr_m=RZqTBxW8tbPV39BHPHYMmPif3kbRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Tue, Dec 17, 2024 at 10:37=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 9:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > What I mean is, functions like __free_unref_page() and
> > > free_unref_page_commit() now accept fpi_flags, but any flags other
> > > than FPI_TRYLOCK are essentially ignored, also not very clear.
> >
> > They're not ignored. They are just not useful in this context.
>
> I think they are. For example, if you pass FPI_SKIP_REPORT_NOTIFY to
> __free_unref_page(), page_reporting_notify_free() will still be called
> when the page is eventually freed to the buddy allocator. Same goes
> for FPI_NO_TAIL.

free_pcppages_bulk()->page_reporting_notify_free() will _not_ be called
when FPI_TRYLOCK is specified.
They are internal flags. The callers cannot make try_alloc_pages()
pass these extra flags.
The flags are more or less exclusive.

> > The code rules over comment. If you have a concrete suggestion on
> > how to improve the comment please say so.
>
> What I had in mind is adding a WARN in the pcp freeing functions if
> any FPI flag but FPI_TRYLOCK is passed, and/or explicitly calling out
> that other flags should not be passed as they have no effect in this
> context (whether at the function definition, above the WARN, or at the
> flag definitions).

pcp freeing functions?
In particular?
tbh this sounds like defensive programming...
BUILD_BUG_ON is a good thing when api is misused,
but WARN will be wasting run-time cycles on something that should
have been caught during code review.
free_unref_page_commit() is a shallow function when FPI_TRYLOCK is used.
There is no need to propagate fpi_flags further into free_pcppages_bulk
just to issue a WARN.


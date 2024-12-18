Return-Path: <bpf+bounces-47200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642409F5ED8
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 07:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFAF7A1245
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622B154435;
	Wed, 18 Dec 2024 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n06XYTR1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374914B075
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504596; cv=none; b=lKvRzdXqXHEpPGtyC8H3JWRSx7svyomKL5Xp2bReOfSuEuOTX9iWKh4OnJcNt9tyDt59TyoxaQrZfrK+kc4zgGR2zu0E+zYTmxgQ33M0wEnDVNMhhGat2morLGV5xtKnVWKXjoquw80wajPF0QEzwrhvcG+jpzz8pnq0Hy+swrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504596; c=relaxed/simple;
	bh=r4podPIcegl1WmRB4nSJzIUsGQgCQp45AYv2N9xZSEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbfQ6bjFP/aAQoewvQSNDqwM8o7S1o4H3iBcCt4aDCbSRZT8e9VTkr5lLOXuWJwGExlaxXPlsMzNauwX8IOu5BzIGIMgx+lemVlzFNAXSylvgEL19O/JBmtN+7BK1IZ0oX7qOgB/UnXQJF20AGBT5VRd1VsHAh8bfWkojLz6gL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n06XYTR1; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8ece4937fso43011636d6.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 22:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734504594; x=1735109394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4podPIcegl1WmRB4nSJzIUsGQgCQp45AYv2N9xZSEc=;
        b=n06XYTR1REwOPygfs447HV6NBGZeyjU8B/0du9D8fQv76O6Nxrx0o7mfb2DEAi+UWi
         chnuwER370XoOfRXgbgIz8DotYcamnIrwVn577qq+Y42hixwbjaLmSTOHWuHHV2qN+DZ
         1/enZI5xr5tpbEEuI7N9zASNJYthobafmjoF497ZKn9tAaZ/BqjY6V6VIzj+r10bM/pV
         rk2cezjBvFPG2YPAy7RJfe4GTLOiH17MIwy2cquj59/E9t7MErq9UfQyqr87yYH7i9JB
         2j3STc0F+wuQ0m9LqdMKHKz2VO/l3TeVJDlDl5EuQDui+oLW3oJRqR5+9611iaPqt3w7
         SqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734504594; x=1735109394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4podPIcegl1WmRB4nSJzIUsGQgCQp45AYv2N9xZSEc=;
        b=LrU96EjpIA2vVdKNYwUFvkSSenIbHJ1EYUmMVujOFz/A9JuogWcEaLpshth1FRGnSQ
         QZG/Jl04a/estJAMrLX9hJR31udP3F75+igI69aI4cP6X/KnmQyNfOimVfw1/IHvxdti
         ymNhSkKA6bMqDZ3VNwg4aHx6kzjkcGWniw6DT28j2gowLansD/fElFCpFrY2Cz7ReD5B
         Ir7eSDwtFqANIF+M4Qsuzu776OyknlGCnpTuLsXlYio6c+d3Vp5NqyVQXUqKccOcK3rG
         XTqaqotIu1soT2zaHx/ashj483dgPQAh/snzkQfFwtU3u2ndQZUzgQQtfCfcFHAkyJRS
         wYnA==
X-Gm-Message-State: AOJu0YyZAT6dOBGickxCrocJ8rgBJCaQ56VbzYMvxSgKkskrP03FYRBm
	henQciVw/eXuG/kRKHrkRWtqp/1DsYzYfLnxRkXKJQAvu8SsI+8C8P4Fs2YaNLdn2rQj/W5QB+o
	Qin6osBdbMCu8+TUQexdvRafS3sfVQwP9Y+X9
X-Gm-Gg: ASbGncsu+CifD2tyJ6nkKAQBFFxzSLFjp96W73j2ZKPT/p5olFcL1CLitutzNPboNt/
	arT3LVW78h/GqdPSVwCR8ZmIXhUiG59+TTzU=
X-Google-Smtp-Source: AGHT+IEiY0doIzVRi/o0mbu86WO9XgujwLT4vmrvu/dfR9MfTyl54vyqGi6QNhFn+v5PAB2el18vB7VPk6T+E3mFDho=
X-Received: by 2002:a05:6214:19e3:b0:6d8:9002:bde2 with SMTP id
 6a1803df08f44-6dd091da53bmr37249096d6.28.1734504593716; Tue, 17 Dec 2024
 22:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
 <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com>
 <CAJD7tkaP40Tde1KHr2t8O9dHyiRSx8Q02=EmPtROyRpS+_qPDg@mail.gmail.com> <CAADnVQJwcd=PsdxcipiN8VeJh2UhSv3uzHkX5E5RuLK2vfdSHA@mail.gmail.com>
In-Reply-To: <CAADnVQJwcd=PsdxcipiN8VeJh2UhSv3uzHkX5E5RuLK2vfdSHA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 17 Dec 2024 22:49:17 -0800
X-Gm-Features: AbW1kvY4pzMcuxkqREUzSdwwDtMsLHvd6NOK-dwbEaYsc6jTPt0v4wsbGUz9Fdc
Message-ID: <CAJD7tkYkhojXE0wwOxEMV1uWb-9hxyqbjD5Uj9ji3+GdZmZnKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Dec 17, 2024 at 10:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 17, 2024 at 9:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > What I mean is, functions like __free_unref_page() and
> > free_unref_page_commit() now accept fpi_flags, but any flags other
> > than FPI_TRYLOCK are essentially ignored, also not very clear.
>
> They're not ignored. They are just not useful in this context.

I think they are. For example, if you pass FPI_SKIP_REPORT_NOTIFY to
__free_unref_page(), page_reporting_notify_free() will still be called
when the page is eventually freed to the buddy allocator. Same goes
for FPI_NO_TAIL.

> The code rules over comment. If you have a concrete suggestion on
> how to improve the comment please say so.

What I had in mind is adding a WARN in the pcp freeing functions if
any FPI flag but FPI_TRYLOCK is passed, and/or explicitly calling out
that other flags should not be passed as they have no effect in this
context (whether at the function definition, above the WARN, or at the
flag definitions).


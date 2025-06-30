Return-Path: <bpf+bounces-61827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645DAEDF27
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A773BFB56
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D828B7E1;
	Mon, 30 Jun 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KHPEZGc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3E28A72B
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290101; cv=none; b=S0nBTlYDBSzhjaCvJwD2mYNGsxJ6ooRHd9i86q6Q/0EGq+eVSDrcYUei6aDVyPbWpg72ru+DQ7HzCWz5nDqK98iE2MB9XP1LK/fb5y3AFTWRjbxsnmMhR6QyFNgBNoT7dWpDhM90fmhMlDzJ1+tm0UQT9nbaIP8ZidDurkYzETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290101; c=relaxed/simple;
	bh=JOPlee8+H1wqCZ/ex4u70pd3NWavrS1JM0blGK0HgUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdiEhkNsyxabERfeYE9l2xbL5hgn1cl3ThANsJldaBgjJ0d+37wGjpk68Rg5NPxAhN/nXUFVIC8qNp8bt8FZGu3WZVkssZsRA1pO6JPtByr2WDkn1iqx3fwaMTxfRdPbPmK9yLyjBbmvAdEyhSDACUXzgn3YZTJVoN3aDvT1e7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KHPEZGc+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso4184870a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751290098; x=1751894898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOPlee8+H1wqCZ/ex4u70pd3NWavrS1JM0blGK0HgUI=;
        b=KHPEZGc+l3XTOiNeIK/SH4Vj3ktmjbktN86pSTlJpeSSubVlwrKT3rM2f94lb6sXVq
         Tb1JJzsbs0v9dK+zkz9ukRyQQnIkKjZxVX430ZovDeihIu47oGVkSJG0qci/lSc/jofj
         bnSqgi+yatHCXYVBHDKDKdJafTzKCXexyytrGoPANTNPh2iNzbqki71MrQJg7ioalQVt
         LAO6l3nEYmP0fx4nzSbXdg1kb2P5Q/XW/HXcLxFOiEU/6T+e38B5tF1mdYQZj0ZNOPoq
         Abj8fpg/yLm1lPTqsrhO9IwE+D8SY+7QJYPZR5R5g1x3XfjjCxLO0etvFvH80YKteyyx
         w3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290098; x=1751894898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOPlee8+H1wqCZ/ex4u70pd3NWavrS1JM0blGK0HgUI=;
        b=plwXmsFQpgsqcqmsFTVxmI8ZUHNi2C1l+kFDcHR6uWmZxR/3d2ptzYTLxDQUZL5Z2J
         ydlE20vGa+xt54m4XYG8x+O7eZht/M7R+Lvh8fagEkKu00dJhurROcbio8JyALNigbrQ
         PNowtRa66WnVchvkl3166OEB7F5paT7cf8J6BlDY11klIJuUn9mNjgef2iYTZLZaqWpz
         5uGPz5aUnzB0BjztqBptgpL7/YVu3gnvIwA72EwiXRw2742AlwzytpnbqhmJRkBzEVxE
         st5H0e3l5gtWelp3ywmrQR/m8UixAD8koFFETzJBFLqT6KL9ONi+XniO3iTZtTGbwb0t
         z+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoubOttQ6VRDPykoBKf1aNLYekofW8gW+lEDoPdWI6YJD7ZOLhMw5igjBuhDJrDV84QkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVMSUuL6uz44/rFpTGJqxiJ1qTVOlXeQfJKB5XX4LrbcHIY+j
	YCq1+qZt1VERfnLCVLkWzlnp/8qWIvKiHy++fGCvxtfg29v6GnzHlpTleFN1BJDflPyQVTjxBvp
	ppIRbaQcD9nR2GXvuW9iGkRl/DgqAgjH6bMJUdAqZTQ==
X-Gm-Gg: ASbGncuHpBeVm/pTXYyj+CP51GgmGecpYRJTlsJFdYyA+pfUtAB2ldOe+j5A10QQ1Vm
	HIdSpFUEWmZ4cO6hojqbKqN1Q3Hz8zrhiCUuAhG4POy8Z6XIgMc50tz8pEsmVPF/jeQzmEaSNAp
	ao8rjbhDyG3BhhZR2k9AVC9GDO39PiwIg6eqNkiDIJfyGo0wW+U7G/AcTCnKagfXVlRHykdQ==
X-Google-Smtp-Source: AGHT+IHCK0fPjZVZy4IAIBdmQg4VEfs7xo5JaePIp6jIQWk4rF8khpEsxLOS+G1AlpruG5EP5fXrkymRLvSpySiCwDQ=
X-Received: by 2002:a05:6402:5108:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-60c88b55d4dmr9970788a12.12.1751290097533; Mon, 30 Jun 2025
 06:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
 <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
 <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
 <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
 <CAADnVQLC44+D-FAW=k=iw+RQA057_ohTdwTYePm5PVMY-BEyqw@mail.gmail.com>
 <CAENh_SSduKpUtkW_=L5Gg0PYcgDCpkgX4g+7grm4kxucWmq0Ag@mail.gmail.com> <CAADnVQ+_UZ2xUaV-=mb63f+Hy2aVcfC+y9ds1X70tbZhV8W9gw@mail.gmail.com>
In-Reply-To: <CAADnVQ+_UZ2xUaV-=mb63f+Hy2aVcfC+y9ds1X70tbZhV8W9gw@mail.gmail.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Mon, 30 Jun 2025 14:28:06 +0100
X-Gm-Features: Ac12FXx0fYS0dAUVkSwEgtfKWEJIu58_CB5GnzygkiN6a3f1tL111CFtlrAmvas
Message-ID: <CAGis_TUNfUOD3+GdbJn1U33W8wW5pWmASxiMa5e5+5-BqJ-PKw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 20:36, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Good. Now you see my point, right?
> The cond_resched() doesn't fix the issue.
> 1hr to free a trie of 100M elements is horrible.
> Try 100M kmalloc/kfree to see that slab is not the issue.
> trie_free() algorithm is to blame. It doesn't need to start
> from the root for every element. Fix the root cause.

It doesn't take an hour to free 100M entries, the table showed it
takes about a minute (67 or 62 seconds).

I never claimed that kmalloc/kfree was at fault. I said that the loop
in trie_free() has no preemption, and that's a problem with tries with
millions of entries.

Of course, rewriting the algorithm used in the lpm trie code would
make this less of an issue. But this would require a major rework.
It's not as simple as improving trie_free() alone. FWIW I tried using
a recursive algorithm in trie_free() and the results are slightly
better, but it still takes multiple seconds to free 10M entries (4.3s)
and under a minute for 100M (56.7s). To fix this properly it's
necessary to use more than two children per node to reduce the height
of the trie. And in the meantime, anyone who uses maps with millions
of entries is gonna have the kthread spin in a loop without
preemption.

Thanks,
Matt


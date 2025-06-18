Return-Path: <bpf+bounces-60943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B761ADEF5C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2797A0221
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B742EBBA4;
	Wed, 18 Jun 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="M8F939s6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CC2877E8
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256859; cv=none; b=DV6RuibEd6+B6MDF/JX2pM+mQSEMfHhButaALkGz9v35/AtqwchnVsss/5KPnefqy1jAMRtYW+2vl3dHp6hIxa4H4AuwCUlJylNS6dP4xbHn/WHQLzsQn4sOj0VcYxncOwPxJktEYxf4amX7+odgWTVUYHNPrtpVy0x6r0s7ipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256859; c=relaxed/simple;
	bh=0R04X2IxAUZ+Y0jSm7qz0sa4qxhk6NzAtpPdgD8xbVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zww51WSzr/hdBKxRcpYPlqPAWZsRmWTuH8hHRYKQ8l1Y1PqW660ojWXicdg3oR3sDIJBQsHehhtPPdHBWEIqeGSIGbmaWTBNhVXl7ZGmJmEM0FcFFCvRiaAOnJ37SpLYO6uI2QlFh+1WfrK0TqDxnZleIr37oEUs8Nv55Nb5SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=M8F939s6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32addf54a01so73028021fa.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1750256854; x=1750861654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R04X2IxAUZ+Y0jSm7qz0sa4qxhk6NzAtpPdgD8xbVQ=;
        b=M8F939s6AEUCMyHjj+jeloh3DP6d22N7SImeAmZ0qEzWxA1fhP/5tFCK1U5OsJ0kPG
         si6gpln635DkGCqpQX7pZ44u0T1Fuqq1LH9OQA18hHD+xgEyNPGZM/p0xXeyn7nowqMK
         Gfck6hyqQmu2QsIcQVr3qCWVChMW4ZLCEu2RNJypBcfXWSW5G+2TjRkJlUR3TSoVjoBu
         k4nYslmXfLO03hEHcTl6tfRs8ltl88u1Q9ZGbymcAGajCajMDq039AHx6O9syvYyKim2
         xWYmI9BA80QODd+z/b+ldOr6YXmrgj5vS2aJNMkxYK9kEn/793ejXhnoj9pKgq+ZdKi1
         Hq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256854; x=1750861654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0R04X2IxAUZ+Y0jSm7qz0sa4qxhk6NzAtpPdgD8xbVQ=;
        b=tpF4q0nw3xRGwLPYtNwDN1TkFooLAOYnXIyLkPA4aXGQ5FEn5xy8+vmUwpl/YlFZB5
         rcaxAJ/xuzvo03nA9T3nnYX/BxtHogZ6UlZ9ydyIv0R630/OwQ4I1lsEg1K3zCt9WF8w
         ylfUN+g9FGOeLqlXUNzEde0URbebFbY2hL+Upw6HS7fzaVkwYt//OM/NcuL6M3Z0KYop
         /2Fs3Eh5lY+OKPEn1qrRq0c6UPlhEeECtyHGr3dH43NGgpWvwQB8v0mHzvX/ZYqFR+sX
         nFxw0pDBD66y7WRcupmDrN+erKAJXWEjXpDzVxTuHtAMA/ScQQ8c4xt7j0loNHpy5/YL
         3lZg==
X-Forwarded-Encrypted: i=1; AJvYcCU8bkds9xU/dijp8tffImmakhZRLx+ocm+AVnpNLrLasMMDnUL8re4jF1EoETix2MzKzRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdjJ2dsEcZiyyTNXKrUn8zDPrSPf8qvfbWzpM2EbMB5CV92k+
	E9L0cfSHHyVrWeZji8xRm3EJZt2GNmDrk2v//ocbUpuMXnbSYV8BlRN0+f21/rA1IpfPUbAEM5g
	QNTLu0bgNsCoAVDMPZt5lt4rCFyoB9X5X/3oMzG8+Fw==
X-Gm-Gg: ASbGnctlwbGJqmF5Jn10Y9tKFv9RRYzR7VvUg3qT7sRltPzpcClhCarMiKrZpkN2nuP
	iCxKHMOXbN/vyW8vV8lOZhD2SJpLUG3HLAgShebSAakWbxHINoptZ9zT0S2obRfDeQ/1od2X45e
	sJFqOSi6ZlyVxRB68ZDzbVEAwhLHOgE8nm4+xwgG/UN0UHlOWZ9SOO9uhaP6nUlw==
X-Google-Smtp-Source: AGHT+IGGgI3FTwdOcK8RLKdtKdhn3U4LuZlr6R5KwqYquv0mpgnRFvgV/Xu6G6n/cNU5rLBns6CPyI5rMhviN4oJemU=
X-Received: by 2002:a05:651c:1987:b0:32a:ec98:e15c with SMTP id
 38308e7fff4ca-32b4a5ca0f9mr60085391fa.19.1750256854524; Wed, 18 Jun 2025
 07:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
 <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com> <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
In-Reply-To: <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 18 Jun 2025 15:27:23 +0100
X-Gm-Features: AX0GCFsaM9DGTqH4WJ6Z032fn61el3PhuhfhzVPYIHaWfMnL8mcSuRqckaKRyAc
Message-ID: <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Matt Fleming <mfleming@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 3:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 5:29=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> >
> > On Tue, Jun 17, 2025 at 4:55=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jun 17, 2025 at 2:43=E2=80=AFAM Matt Fleming <matt@readmodwri=
te.com> wrote:
> > > >
> > >
> > > > soft lockup - CPU#41 stuck for 76s
> > >
> > > How many elements are in the trie that it takes 76 seconds??
> >
> > We run our maps with potentially millions of entries, so it's the size
> > of the map plus the fact that kfree() does more work with KASAN that
> > triggers this for us.
> >
> > > I feel the issue is different.
> > > It seems the trie_free() algorithm doesn't scale.
> > > Pls share a full reproducer.
> >
> > Yes, the scalability of the algorithm is also an issue. Jesper (CC'd)
> > had some thoughts on this.
> >
> > But regardless, it seems like a bad idea to have an unbounded loop
> > inside the kernel that processes user-controlled data.
>
> 1M kfree should still be very fast even with kasan, lockdep, etc.
> 76 seconds is an algorithm problem. Address the root cause.

What if later we have 1G? 100G? Apart from the root cause we still
have "scalability concerns" unless we can somehow reimplement this as
O(1)

Ignat


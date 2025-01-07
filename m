Return-Path: <bpf+bounces-48142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3CFA047F0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93027A2861
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207E1F472C;
	Tue,  7 Jan 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlyPRGFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DB18B463;
	Tue,  7 Jan 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270091; cv=none; b=Q9YcRlNtMWjm91wo1uRsEznAnctRh3MMr9xgfy5QPyU0qNySh3NXTxHa3st36yC6rxF8SB51aLd11TJYLznsQO462oyyEMN999PHX1UtGcdzxerdBJqtfcvkFfpL0eq7E/zefeFkAz9z1BrGPcsd61cjUbIBwitC0JBx2McWuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270091; c=relaxed/simple;
	bh=NIrTkMg3pQ5PnjMk8momlmtM1TIKOWr4y6trALHHduI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF4WJJoajbcUs1RdMDNB9OD1bMyy16vfesW9RVGdQWm9jOjlFArrWa7uEQ2aEbDA04lvIcI1o8kRioM3fWOcmc/hY48W5QhfFAokPE66jpJ37wWLseXy0ep50MhKhiohyfWEclq9tga72TfQMWUTtk+cHdARqt5x+RXiYdRhkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlyPRGFT; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-2689e7a941fso5013234fac.3;
        Tue, 07 Jan 2025 09:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736270088; x=1736874888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRIUK7p9KjTjGCUHvNjvcxgwfYIeyorHbrofSUNaikw=;
        b=IlyPRGFTSUI7PQyWbASQFQh1UkS2WdvEehd9+96lqVM3C4wlGerbqKPBv144AHFwiv
         q9Fqkr8RCORychM9GMXZ6mc37oiaBQb5FFoQDUycYPXLpsa8GDZ9OeUer3HeW6q/Dj2B
         /+fHS1BTSAzzUQKrFcgsb+RSk+wMbbbx/UTlOWRjSgIBasE9sHOmMVZI7ZYNY7mjQfoN
         MLW/4ruD7RoGfEotNFr8Gvl5RqGL5r0Meyfy8obSINxFk4VPEu8ul31Fm6wsp/Lsq5o0
         N6DN4OO80xMdLLLOThqsmHCZSPkp6t9eLDXjuMqkP27iqKNozgyBoNtRmI4cZM1lyY2w
         gMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270088; x=1736874888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRIUK7p9KjTjGCUHvNjvcxgwfYIeyorHbrofSUNaikw=;
        b=QJgHOuet+mf5nxIZ1oa0Tbb4Tndq2eJLfr3o7kaydyEHKgJVfH37H6yzZNvcsEtQp6
         B/T8gIjU1RZov8euqFl8g29/3/2FeBUubYmFDN+8WXg1xf4Ive/tZFk9xAPux36rMtzQ
         4kNCSBz997QsSPusGWhvZ4KUHLA5FshdS8CouB6G45HihicqlkLiPtXpNH/elDYZFCBg
         4ZNdc+GtmjGwe1GzOxuyIlB3DTG4zehBgGEJtV2EgdrhxGfnuJnTh+6LvvcbqEjd77bp
         m0LxqZSIGKlfD5M6lT2xD6LNSGHuLuKPfQFbrj84jnP66HStJ0u49qVhzXOyvrHyhjAs
         ZYdA==
X-Forwarded-Encrypted: i=1; AJvYcCWGXM1Sb3+BB965Hzbb3JaES7H6DvbPoCGLU7gF2bcpg8DxC0Hmjjr3U593D93r8l7S+aywRnNqM0aCS+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJRC3s4ULpF7MZpzJg8nEJ2LS6Ibl5mscDGq9OFpbfYokrmOH
	kdWhnIczfYmxLLnyAufDNxLZb1RSYP8WsN833DV5JCEllUOdqeHLMfrNxbQRlZZYDOOmyb7bVfA
	HtsrPId2MxReCsKk8uH3dpSJeVRU=
X-Gm-Gg: ASbGncvspMyPiRWxibUcd2SCiBZveEwNrgszsAfg2Gf4QiPHf7Ao24JVIKD9Lfits09
	po7YWUWMPSfGVjv5wIR8DtQ50YwYfvKI9720Qspwx5slx+nqLClG6JjIACdv09t8m3szqDqE=
X-Google-Smtp-Source: AGHT+IHNWzNRNnCvzHwnIzMWkh4VACFP4Nlv68LSbFI0aKpbIWixNbk7GjPTdMQWKq8J5aUX0wc1Bc+AoTUDejrl6sk=
X-Received: by 2002:a05:6870:a40b:b0:288:563b:e48d with SMTP id
 586e51a60fabf-2a7fb0a8f1bmr29264414fac.10.1736270087873; Tue, 07 Jan 2025
 09:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-8-memxor@gmail.com>
 <20250107145051.GA23315@noisy.programming.kicks-ass.net>
In-Reply-To: <20250107145051.GA23315@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Jan 2025 22:44:07 +0530
X-Gm-Features: AbW1kvYrnbs6wh4l1AWoW-CH3FVNXoMZEl3oCSAYs1Uf59MS36FYLjlhMVkYb3E
Message-ID: <CAP01T77D0sM4nO-B0do-Ya2AFhE3rKhZoM1=fV_+RovqELeMyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/22] rqspinlock: Add support for timeouts
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barret Rhoden <brho@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 20:20, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 07, 2025 at 05:59:49AM -0800, Kumar Kartikeya Dwivedi wrote:
> > +struct rqspinlock_timeout {
> > +     u64 timeout_end;
> > +     u64 duration;
> > +     u16 spin;
> > +};
>
> > +#define RES_CHECK_TIMEOUT(ts, ret)                    \
> > +     ({                                            \
> > +             if (!((ts).spin++ & 0xffff))          \
>
> Per the above spin is a u16, this mask is pointless.

Ack, I will drop the redundant mask.


>
> > +                     (ret) = check_timeout(&(ts)); \
> > +             (ret);                                \
> > +     })


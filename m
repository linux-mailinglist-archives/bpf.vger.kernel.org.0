Return-Path: <bpf+bounces-42947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184B9AD48B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA261F22747
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70D1D2207;
	Wed, 23 Oct 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atThM6F9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16114658F;
	Wed, 23 Oct 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710735; cv=none; b=U/xr9qNJM5QXzL1LSRDd6ggKwpXZsllx6IbPdsfRLLms/Als91QOfLQ3oUKwQjJHpwxzvzqsrZnbTAc5+s57DhZMNvxAA+ZVkV/6ygr6QhkvGg4+Tz2uuxBonsx92e2qWXiwhN+rycuKwEiH39ovlhTdHF+svUb6PBK+5E5+UVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710735; c=relaxed/simple;
	bh=mZMCb9yADboBtfszxVAciCHEEoeJ/Di+xLmjzlPY/Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVxBgyAQrv9N53KOBEazc2Axu8614rh0EbyOWld2Y5NulXhiXySAei+jjCgA4CokKoZCGA+mPTbrcORGz0oymyyxHSSgrIyiF7kneBDdino9sZvzZ0zMS1d8QF09UPnsETbpvX5UJZtTLooBCp7ehSqOnW5TMcHXlOt+Dm0UsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atThM6F9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eae96e6624so73139a12.2;
        Wed, 23 Oct 2024 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729710733; x=1730315533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZMCb9yADboBtfszxVAciCHEEoeJ/Di+xLmjzlPY/Ig=;
        b=atThM6F9Ezzcf85W59c7aF7FXCTDMkqQiKL8rME8RrDm/mW0oh8Zex/7sM90AKy3dX
         WievXRgsgrncXrapyhHN6IQkTdvDPLxnUl60ObllOw4rkocKzzIvCMWR+v1d5p5Qex6p
         M3q+Gh9MzbT3YzyK6Y2XJD6q26VcAdVjAPLQEqFBKLDFz26ylG2cS6XalCrWfjeR5nDf
         qQXXNbsb7Jamstam1oWSd1IUsG88XSK+5QZvZznNaCAV5X2m/D50pf9oI4Vyg3Hsnxno
         YlnsBG3QpTc0tUlXAUGX0vvusaS9Ie73e3GoXz6HuDhiOJoFjmehm74dU28eArzQxk7O
         2BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710733; x=1730315533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZMCb9yADboBtfszxVAciCHEEoeJ/Di+xLmjzlPY/Ig=;
        b=lGr4FmezeKIJRXUFrbQ61rf8MwhspDJwBoNW01YdohPAAvQVXxpn/WZI/0fMWilvbn
         TDc5qzeVuWxwhmgQQbnLGV3ohkzaYx61D6zvwNHauVBxhpvsRSVB8ivmWsiZZksFYl/q
         L98V7WtHmCeA2WvSOXQDlbEOJ+xPe+0SQXWIMmTy+/3AWM9UUI8n6kv9BshFv55IN+fQ
         PgBosgnRAPNfppdgegd3vpnRqX9KMs4D1iNwSc5EH/3hLOGRjGP0Vd3uAszJXWxN6i2j
         OeXwGNidHUoRpQakZRaPDNdP5D7g7Dn+eQWuNJSs0RWK+43efXUoHFBsBBKr9p6k+WEu
         WOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn8z0AwsEgzMvLfx20gSlSuJgIOqDqYn3wgfATLhjDgXz3pWRNbBROszPsKhojS3zUMr9sml4i8l2i9y1s@vger.kernel.org, AJvYcCXaGQDLN/ofqi+Ih+Lxk9Q6Iv/ucJE05Ie5wsODmSFRa4dRbh7E5S7m355qWpRd4v1ygS50la040ofgVgWiKLhW9/89@vger.kernel.org, AJvYcCXz8XET8sQOtxiAe179coSrOoMdCuPQyN/HDIBd6UVGN6ggbczoCbU6xz+OXF+Sx9z5EIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFmuBGVwKwXmB1FzFRQa7/u7JDqM6d9L/kkCJ3yQ+nygQtWgw
	YnNQKa/8S3aJXuv3c1S4Ee3ERrKo1pRVnANMGGoo6OG+SqlUbQ6MAZ+tiwQc5Su50ZyV8OfKX2A
	rRahKHs9SNxhe0l3v2RhY7L/3s+k=
X-Google-Smtp-Source: AGHT+IEgBQBY50NgmUSwv7WeWN6RgmhxUSqpC8efKbbtYOPUDXTyDNRkjloglseKzk4fJn/E39uuA/XUO26JB9Ea3Yo=
X-Received: by 2002:a05:6a21:9206:b0:1d9:1784:49f with SMTP id
 adf61e73a8af0-1d978bd6445mr3959442637.46.1729710733319; Wed, 23 Oct 2024
 12:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
 <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com> <20241023190240.GA11151@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023190240.GA11151@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 12:12:00 -0700
Message-ID: <CAEf4BzZxM2khxd0YNLT6STCvpNz+uqAgS0e8NmtbxcpPLJMvpQ@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
To: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:02=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Oct 16, 2024 at 07:01:59PM -0700, Suren Baghdasaryan wrote:
> > On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > > > To increase mm->mm_lock_seq robustness, switch it from int to long,=
 so
> > > > that it's a 64-bit counter on 64-bit systems and we can stop worryi=
ng
> > > > about it wrapping around in just ~4 billion iterations. Same goes f=
or
> > > > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> >
> > vm_lock_seq does not need to be long but for consistency I guess that
> > makes sense. While at it, can you please change these seq counters to
> > be unsigned?
>
> Yeah, that. Kees is waging war on signed types that 'overflow'. These
> sequence counter thingies are designed to wrap and should very much be
> unsigned.

Ah, ok, I already forgot I need to update this. Will do.


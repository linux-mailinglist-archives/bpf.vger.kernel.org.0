Return-Path: <bpf+bounces-22944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1386BAF1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51531C21567
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF472901;
	Wed, 28 Feb 2024 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYRSKsXT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8E1361CD;
	Wed, 28 Feb 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160539; cv=none; b=qRGMS1bdaBbZH1oqma/acDgbJbhTxCo65y+Po0qrYnLZKd2Ayd3mwFdXyNCAQpNtyd5m4zJf02QJWKEQjgrorYOs6EMdPrXiEjsGKHkECNgZlGJ2MtJKl5XOvWlqMg8noUqQc3O47nnZMhWIaoRWR1dW8ZUtBp/UBvC0iUDi+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160539; c=relaxed/simple;
	bh=aEkhJ7ls8uFYlDlRc+iLJ5Ocz8xUoDm7sxScH2TbCDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDGx7UdO7fviYAPkF49NnNBoMFPvANew7imv3QxtWDcRmzqZGGBSNgsl/9KRPtrEe5gkuRgRRjJqDGvBGVZfrg1GD/dbxtV5D4nkvKz+/Ucw4XdvKSU5KbF+d5ZX5/yE5BfdnJ9ny6xOVPD8aQvbpRqdbuiDyBxcl88seehK+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYRSKsXT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso849342f8f.0;
        Wed, 28 Feb 2024 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709160536; x=1709765336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/le6i8BwVt+VGq3pUSqTQqqbO9l7kbzBUEhYF9A/E8=;
        b=eYRSKsXT+J48Whv/wGJUN1ZFp5DakHSKKohmX4Wk85dfYrKWIhD4A8de95z95z2VAH
         GDadP53NaFExQZVZSOImq0bSVjZ1iKDosCHKnQeM0qLEwp0F0kG321r6xrMr37yqfv8w
         mGRO29wfQ85CJuBiuOLSV8KqTKmE/nBG7xcooVyB3t0jSa0xz+i5FzMj+TRWJSZV0p1F
         1JziCgCIsgK5q/YWbs3yYugGU7drL9B6S9DBicMDX6w0PB1jQuSfAvqoKTwy6SzOlKMB
         CRRjYVD+8eMGwqSevsj/r1kLtNNSJRbPiiBzigEIYIfW+aK83b73JMescb4D1PqpD2P/
         avZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160536; x=1709765336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/le6i8BwVt+VGq3pUSqTQqqbO9l7kbzBUEhYF9A/E8=;
        b=BUB0Y4nQAwTQWG3p9ySI3VhYUajpMj79SqYa7ps5q1dMjF207Yv9vnco/ZcS+UQf7w
         ZyUp3vzw++2hrExaBpqb0Vk4RVMrr2i+BmXu5p9KwSANBdQWPA12D3NrWT1t6Ls6nIKh
         o2DTvA5JPdxzJdaI0k5Mnn6pJ6lCxau+GSEdgkBYe8PXSn71VnkVy/Wkz1eK6CA12XBk
         xw/O0KFYDq6VXIFPcy+/ff47fjRwJyjO+1ZhONSBqaoJMiMm7glsIoWJFmV9JC4bVr7J
         GZ/H41kHl9woRzaAh0PzaP0aacoETUCPMA4JWVXio7Menai6YFBh+LUe82xe3+lFv4KD
         d8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXjs+pMWOOuFgWkqoIPGhVI+A7ec1Y/ynWnc3w90znc5QXGo0etm5a+hQtGO/i+PZ2FCoqrlGawbXX/BUQIQqm8b/cwr52wn+l5fJ/Bhcft/AsH8vqjNAGVwfDEcbyNX7la6J3d6E3Ho92bfNhfLiwHJ6xFHRNHgB+tcq3+1oDGPEhCx/lryY62s0lEk1Z8
X-Gm-Message-State: AOJu0YwO8GlPun29b/TuX19YI7cq0PTsGAwGOlcoag1WKpOymWwZNrrY
	TtlOdjWf1WYDGt5MaFjU2KKtx1NsyO5H9rNVUflP8l7mtkDcxfFMIxhlicwbgRvz6YeHV+3DOmU
	f9xSf/BLEznMoYB7IVdrzlCnJA8c=
X-Google-Smtp-Source: AGHT+IF0YDHyLBY6/gXQehe5XSXN9guIRT+7y3g1ZZYDHR/P+wrXwRJOjZL9EI5NoKop6bxXRpwCfMH4z78sBr0E4C4=
X-Received: by 2002:adf:ce0b:0:b0:33d:545b:a33e with SMTP id
 p11-20020adfce0b000000b0033d545ba33emr83390wrn.13.1709160535981; Wed, 28 Feb
 2024 14:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
 <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org> <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
 <20240228173307.529d11ee@gandalf.local.home>
In-Reply-To: <20240228173307.529d11ee@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Feb 2024 14:48:44 -0800
Message-ID: <CAADnVQ+szRDGaDJPoBFR9KyeMjwpuxOCNys=yxDaCLYZkSkyYw@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 28 Feb 2024 14:19:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>
> > > >
> > > > Well, to your initial point, cond_resched() does eventually invoke
> > > > preempt_schedule_common(), so you are quite correct that as far as
> > > > Tasks RCU is concerned, cond_resched() is not a quiescent state.
> > >
> > >  Thanks for confirming. :-)
> >
> > However, given that the current Tasks RCU use cases wait for trampoline=
s
> > to be evacuated, Tasks RCU could make the choice that cond_resched()
> > be a quiescent state, for example, by adjusting rcu_all_qs() and
> > .rcu_urgent_qs accordingly.
> >
> > But this seems less pressing given the chance that cond_resched() might
> > go away in favor of lazy preemption.
>
> Although cond_resched() is technically a "preemption point" and not truly=
 a
> voluntary schedule, I would be happy to state that it's not allowed to be
> called from trampolines, or their callbacks. Now the question is, does BP=
F
> programs ever call cond_resched()? I don't think they do.
>
> [ Added Alexei ]

I'm a bit lost in this thread :)
Just answering the above question.
bpf progs never call cond_resched() directly.
But there are sleepable (aka faultable) bpf progs that
can call some helper or kfunc that may call cond_resched()
in some path.
sleepable bpf progs are protected by rcu_tasks_trace.
That's a very different one vs rcu_tasks.


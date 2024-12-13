Return-Path: <bpf+bounces-46914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D79F184B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE789188502B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9A19306F;
	Fri, 13 Dec 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1o4TFXg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E71DA4E
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127341; cv=none; b=BK/T/ZhesUqPRh+2pqK+baA1rQ0p5LXM9tTjot8hWFLqtKUeBwVLgmVK+/ywtJ3ltevaAfHmdXXu0wlinQ+kLgxbkdMx2CSSkbUTpcqJ9Z4sZ+P+MDn8OOLGOXMj4q3ACU/yDg+VKj++WqnjABRT7HlpaXXPlVRcobzX6zy/XcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127341; c=relaxed/simple;
	bh=olY3vhhPpgFWDMToqbI+2tOyNTXaMOx2Ne5oWopXL30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGY7bUl6/gAfQZAYYCBMeB3kE8/C1zURTABpPnlM2XmtOk2HCRAO0Eo1/eKqDPqwGURAdsD6ZIzV1deZxU9EqKThndi4NNjPDvJGN9zsYfRgk0P58nYNL3A5i400QNSIi/l9m9r0b1tA5B9sbDWy8VOlUFZ2QA6lzxR5BN1hCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1o4TFXg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so1224778f8f.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127338; x=1734732138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZPWyb/XBe2yMGIlqJvswQxBEjkMyLRKAx8FUxbp8UE=;
        b=l1o4TFXgk2m5kWVd7zjk4tgnJfL3w/ABsDm9jJ0BZPLcX9IpyunIsnVuE/mzXAoNpJ
         aDDnWydkbSJEhPHsC9OZzMkqeW+DxUJpX27Xr8rl0Ji0dImFQqUd4+U0whyXzJj2CqYp
         rkBdC++F9pZD17r1PE+1GQgNn2GBVMjPWfCyJXnxtQPthivrHjyDn5062nFBk7TssJEz
         VZQ/TH80ljjpMI4cGc9et9rX5fw6p9yWaTHObJqwxgU3YeAxp5RKhC1x518F+U08pql1
         gQtRFuFouZlB6vP9rwhxiX1e1iCXUjg+uzm1mPuR10Tb3zFajFPxsvrrtkknA1rGX1uf
         X0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127338; x=1734732138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZPWyb/XBe2yMGIlqJvswQxBEjkMyLRKAx8FUxbp8UE=;
        b=tlmZsVKUEgTCLmoI673K7lUqeHhTDrmREmsA/NwWCcR1EoBUeMYVA8B3nlfppj0KWM
         P/x8Jx5oylzcXYBPYpS4LJmSpwNcGDoNXsrtB+z21nMRiv4D5cI0yBcbeXWqB4NWzJXT
         KQXbpHGDpM2ULoYuxlX5m8bASImsGUxKTv7NsB0+Vx4XfT2GkQ7SJW8mq3q+LcWETTZU
         TZ6aDGVBai2+/e2tdPmYD+qbxMKgQp78hVXO2JiQwpvVV6VghinppJEf93FDdQPvSwSf
         R++36gbTBGjLQJW2BFV7H8ERL2y7xu1LzGx02jpxS11dv/bR/bDOi+ke9yaVVWo3hWxZ
         2cGg==
X-Forwarded-Encrypted: i=1; AJvYcCVoIhJoSL64YRb26oi1pga6/ThYkGawkUzombcFW6kcYul/f4Ts8MoZA6D6HxkqQgGfIE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSf6oP/iKt9VVzd5f2KtSmVAduTQTnlt3RCBS8+iLGu1ry8Gs
	4ZQllM1ma5B6PW6WPiiKzSCVlSik3ppa7+xr+JNq52UbVqkOWBOKnxZ2Qp1y1QZLAYJRNvY/cSA
	qreh5Ad4XM9TS0Oho6Q9edMLa62Y=
X-Gm-Gg: ASbGnctrKxOgoSJzpYb+rC1QxE54xbmvZpVj0nn1sRpiQsw93md+V5GGjE3OGK8g09b
	9SO73LYpuQbFBe185A6M5inKymfnuKcL06ZxM/lEpx2zv43JOYYRdSzUK2bz/QR35ZgF6xg==
X-Google-Smtp-Source: AGHT+IFc228SMWCKYeO8U3tr5A9ta0NaRWjjXCjtD25Q9yW/nNmkKfc6XkNTrLI/IiWCfiuU3ymPX5f7HT3xzOCZpHM=
X-Received: by 2002:a05:6000:794:b0:385:d7a7:ad60 with SMTP id
 ffacd0b85a97d-38880ac4e7cmr3402530f8f.3.1734127337590; Fri, 13 Dec 2024
 14:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka> <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de> <Z1r_eKGkJYMz-uwH@tiehlicka>
 <20241212153506.dT1MvukO@linutronix.de> <20241212104809.1c6cb0a1@batman.local.home>
 <20241212160009.O3lGzN95@linutronix.de> <20241213124411.105d0f33@gandalf.local.home>
 <CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
 <20241213150950.2879b7db@gandalf.local.home> <20241213160035.677810fb@gandalf.local.home>
In-Reply-To: <20241213160035.677810fb@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Dec 2024 14:02:06 -0800
Message-ID: <CAADnVQ+QS19X_FFJdqvKyP5oWhT4CbgnRuwdJy5+7qcvs3kYAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 1:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> Again, allowing spin_locks being taken in hard irq context in RT, even wi=
th
> trylock is going to open a nasty can of worms that will make this less
> deterministic and determinism is the entire point of RT. If we allow one
> user to have spin_lock_trylock() in hard irq context, we have to allow
> anyone to do it.

The boosting mess is a concern indeed, but looks like it's
happening already.

See netpoll_send_udp() -> netpoll_send_skb() that does
local_irq_save() and then __netpoll_send_skb() ->
HARD_TX_TRYLOCK() -> __netif_tx_trylock() -> spin_trylock()

netconsole is the key mechanism for some hyperscalers.
It's not a niche feature.

Sounds like it's sort-of broken or rather not-working correctly
by RT standards, but replacing _xmit_lock with raw_spin_lock
is probably not an option.
So either netpoll needs to be redesigned somehow, since it has to
printk->netcons->udp->skb->tx_lock->xmit on the wire,
otherwise dmesg messages will be lost.
or make PI aware of this.

local_irq_save() is not an issue per-se,
it's printk->necons that can be called from any context
including hard irq.

For the purpose of this patch set I think I have to
if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_hardirq() || in_nmi()))
  goto out;

Looks like it's safe to call spin_trylock() on RT after
local_irq_save() and/or when irqs_disabled().
It's a hardirq/nmi context that is a problem.


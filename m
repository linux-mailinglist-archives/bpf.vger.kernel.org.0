Return-Path: <bpf+bounces-38602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBED966AD0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC3BB232CE
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243781BFDF5;
	Fri, 30 Aug 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj0t09dH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94C1BF7FD;
	Fri, 30 Aug 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050629; cv=none; b=bEuI17oWDh6eQyV+X+UPUL//pUnUDxi7mA1DqUiLBOqdoIgE++agu2runURTOW/aUmibqkfsCv+AyTJtVVH2GKaSXPnwuyhBuoQxxiHUgBmVjsLg2v5uXhAZ5vDs8nj3pQfYhuRWKdigSDOtMx2yr1zlDTgGNcCiF3xFiwtS1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050629; c=relaxed/simple;
	bh=/J3chlRHgWeDFjFRxlbl2Q7F2+KANwyc4B88VCV1lWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsuLqjI+a5BX0zGvnmE2AEyhhAr3Go3kLWOzySoi/9ZTZer/ACgJlyROoQsV0/luouoSivfxbpf9XaVi/6hZr9Vp1IGFBsROdhGihFmV+KqKtmDDA6BLajI7fW6hxzCmdPyuCQB4uV/zI+c6H4E/W049tD+4U8HzcCSnd6RZ7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj0t09dH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714226888dfso1873021b3a.1;
        Fri, 30 Aug 2024 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725050627; x=1725655427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J3chlRHgWeDFjFRxlbl2Q7F2+KANwyc4B88VCV1lWA=;
        b=lj0t09dHmOY1drWCDwH7GmBPHnFLVxET5uVk73XttInjdZxH4Z8Zr5XO0s5MqeHsHp
         t0NkSo/e9nrcnCZPvsPyy+UJODgTz7njRXlkyBfE3g8eXvKU9H1xgoITF7OEV4pg/suF
         sLTj4gBliOnNaNWf+VgqzqBVf7BABTtk1hX3C9P8r2MuRQtQTkwBIMWDdsNMfiE2Efj7
         OPHmxTg2vfXdxI3MqDkEoY7tU3WImxuIYA+o1H9xsJgk5tcEOG7wFQqH+S+0RyUS0oB7
         90KDlreSy5HwlS0YeSdDel3Z9ei/1E25VzmVa7XFs7MuAns/F/xemZltIOD2tUVpRhXt
         W2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725050627; x=1725655427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J3chlRHgWeDFjFRxlbl2Q7F2+KANwyc4B88VCV1lWA=;
        b=pPuH/JbA7FWBmcRjWbSPRRdWAmIAX2K4k3Kd8XNt6bkEkZ6+6XPoG0pWosz1P8P5TB
         ZcD9QpOqD/6YHvveIE1d7Y/tg0iTdTtGLi5VsiwdbMGNON1tNvVsID/uKnH/F1EbAV4D
         gGKQ5dPrCGoO6nPAWrmK9vV84bzsKoUYEl06sEDMhQr9qCn5eR0uA7eZSrQiLbgyQat2
         JnRrSzaxps1arihqS1kRCrJBGRoi2gcd+aay+jzSvVtQpzG+9vgLUH4+ezhFaP6Ki1s9
         UX/NpGxp93CyWDEvq8TY5KYtFvYvXpJ+GpVggxm1Qq4VlKr+1eBq8I+5/ZKRpImB3gMZ
         AJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3SoJeI9DpQOoQdPts1Q70Qn//SkRAIz2604Xh3FzmUxBRphU2n8NXB6yEOu4ZFxq1+Ok=@vger.kernel.org, AJvYcCWLUQPTexHaJKWyhULsmmlQ8yDShcChT3M0FwO4xM/S0Q9GP4FoFEU9hR1XZZGHOWmNmaTiEpqaXTs7pOX/5axKu9D7@vger.kernel.org, AJvYcCWWJSE0TVM5W3ly5MYk8hPOjIrXj8OFIPv4oNlUT2CesBfp4ccTZ02LnzKKOh0TC8xcBUNgUTpz9dGgLCn/@vger.kernel.org
X-Gm-Message-State: AOJu0YwjrHMgb7AeOyLg9tnCdO3fn9uubq/9d1sOgDgciAqIKWJp00Rp
	UzUmCQ+AkHfidtZ9LY/cEw3JsNQz6oXhW9eUh+/RSVHq36XBKokxi4Sy3x0xNc23EUK0XmOt4fS
	NO63xfn+UAzg8zyfi+GqpKtRH2SI=
X-Google-Smtp-Source: AGHT+IE4nYRaD6VNgiFBs2JY8ume+v97ADAducXuYilVQJHUShm0gRe+pkzkUhVf//0F8ALTesi7AxhylpkqGj1uvIU=
X-Received: by 2002:a17:90a:ce90:b0:2d8:6f73:55a with SMTP id
 98e67ed59e1d1-2d86f7305edmr3303400a91.25.1725050627471; Fri, 30 Aug 2024
 13:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183741.3331213-1-andrii@kernel.org> <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava> <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava> <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com> <20240830202050.GA7440@redhat.com>
In-Reply-To: <20240830202050.GA7440@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 13:43:35 -0700
Message-ID: <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:21=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/30, Andrii Nakryiko wrote:
> >
>
> Andrii, let me reply to your email "out of order". First of all:
>
> > Can we please let me land these patches first? It's been a while. I
> > don't think anything is really broken with the logic.
>
> OK, agreed.
>
> I'll probably write another email (too late for me today), but I agree
> that "avoid register_rwsem in handler_chain" is obviously a good goal,
> lets discuss the possible cleanups or even fixlets later, when this
> series is already applied.
>

Sounds good. It seems like I'll need another revision due to missing
include, so if there is any reasonably straightforward clean up we
should do, I can just incorporate that into my series.

>
>
> > On Fri, Aug 30, 2024 at 7:33=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > No, I think you found a problem. UPROBE_HANDLER_REMOVE can be lost if
> > > uc->filter =3D=3D NULL of if it returns true. See another reply I sen=
t a
> > > minute ago.
> > >
> >
> > For better or worse, but I think there is (or has to be) and implicit
> > contract that if uprobe (or uretprobe for that matter as well, but
> > that's a separate issue) handler can return UPROBE_HANDLER_REMOVE,
> > then it *has to* also provide filter.
>
> IOW, uc->handler and uc->filter must be consistent. But the current API
> doesn't require this contract, so this patch adds a difference which I
> didn't notice when I reviewed this change.
>
> (In fact I noticed the difference, but I thought that it should be fine).
>
> > If it doesn't provide filter
> > callback, it doesn't care about PID filtering and thus can't and
> > shouldn't cause unregistration.
>
> At first glance I disagree, but see above.

I still think it's fine, tbh. Which uprobe user violates this contract
in the kernel? Maybe we should just fix that while at it? Because
otherwise we are allowing some frankly too-dynamic and unnecessarily
complicated behavior where we can dynamically unsubscribe without
actually having corresponding filter logic.

As I mentioned earlier, I actually considered calling filter
explicitly to enforce this contract, but then got concerned about
indirect callback overhead and dropped that idea.

>
> > > I think the fix is simple, plus we need to cleanup this logic anyway,
> > > I'll try to send some code on Monday.
>
> Damn I am stupid. Nothing new ;) The "simple" fix I had in mind can't wor=
k.
> But we can do other things which we can discuss later.
>

I actually don't see how anything reasonably simple and
straightforward (short of just taking register_rwsem) can work if we
want this weird out-of-sync filter and dynamic UPROBE_HANDLER_REMOVE
behavior to remain. But again, does anyone actually rely on that and
should it be even allowed?

> Oleg.
>


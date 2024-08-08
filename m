Return-Path: <bpf+bounces-36699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4494C3E9
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3294282E17
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775FF145359;
	Thu,  8 Aug 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ502dM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9312FF71;
	Thu,  8 Aug 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139534; cv=none; b=mLxLNwfnVVfubUFMe4fY86z84IXokqho+lyzfqjQV6Of9CmBUdzn6wn45iiZYmRHR/2uz4Cj4ztWiWYwT2bjEjA8jHp81F5oZjo/L7Zsh+fj6T5ccicPnm0vZa3rp0a+34fcFmCaBtX7GHV/R8E84QwF6W0qr8P3tV9UO4y2AMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139534; c=relaxed/simple;
	bh=Jnlk1N7X0XteoCyN7m9BQmLde37/dNYFyBoHYFLOsnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toLAAx3Cpxre7zOSd7Qqy9pXt3mjgKYHajANYJd8qnXeZ5EY/UDc229bfMaRQsR0YPpMHY1W11zApkMoGcem0L682LDq2rNCWzdLiGnQDMxfp1TVx3kItLB7rY3K8OhkIaiYnf3aM0xidvi/74U4h9pE6Z6oTpTdmQ9NnH2Dtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ502dM8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a83a968ddso131863666b.0;
        Thu, 08 Aug 2024 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723139531; x=1723744331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xijt6vLAJnukIsVHM/l1f1l8X3JScQRQxl4IE9/q69E=;
        b=FZ502dM8GidWPQYd4UwMB4hF6paOMtdGye7IZMgpfqfslRCO0BYMX/8VMKazDON/gb
         HYSMMHZfSGEf1jNk6SWZgothVwTl0zx2RB2wO+W+g+vXiECsZV8UajGyuDeKCi08cf3W
         JdVprEBoKR43UqAsl3gR2Bj/baWtPGOE/9k4SNvU97EyqqqIFB6Q9yUHQKscUE/jYD9U
         /m//EhVO3WvymEQaESjE6Yg7LYdbrN4R8pjZuIk4tA2lSo9m8c04XpzMP9+6eoXwDkVa
         ssl7BgAfFu1aOcJjqdcQ5pKHUBraL9cdArnWcOocvA3oaCIgfUML+sBVppe1JXS+CHrS
         sRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723139531; x=1723744331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xijt6vLAJnukIsVHM/l1f1l8X3JScQRQxl4IE9/q69E=;
        b=BUf4dYNlMoA4ccw2gEArBdq4JCzoivNzGcZSbjq1iiyGj2/S252W2lLj7OGxgqPLKg
         LhTH6u5QpZU/AIyACzDqCzH+AnMROJ23Ep0hznyIGa5/03+oJx0Vc/6WPjrCDl/6+vvP
         qPXQTiZbbCmkHRz5XcUe2p9no/rBgHg/oHdJt/gBI93Ne2HldR7IWfqNF5F77Pzji1Ho
         LSn4ur8jDj5cFbatlMaIua0Y63jiv9cpxTLA7K0HMoT+U7FaJRSOd933sqSh5WgwDirq
         CEeak2OAoU8vorOXs9fqmqQHfZKdqlCGqofk5nGNeZXn7QUsId9sjES6dLYJmG7ElODF
         g7sg==
X-Forwarded-Encrypted: i=1; AJvYcCVHv+OYUjZUeKtKfNbekaCdbW47pl8r9KwpIjDUm1/Qmzf8k2Dxv10SSUQKv8gW+yiVNCAjlyGbScpN5lWM9lOBwALTAW5EEy+1b2dLqQPLDVjCWI87iFN+ui6aUYmZFq0gxA3ty6TJWrAd+C3DV9yo99O0VjgUyagdqx8LtfiYG27f/6K3
X-Gm-Message-State: AOJu0YzOJB7Aa6H9La67Cbqd3hC3xqlKzbcqMJc3MaJmlCeDGkyQqRSs
	+b+9xkpcKNah/Iyo+CKeQHLia0CLMbCmxdqmoo8JysO+0AYCRA8H+OSqg0W7fPi3MFr1BdDkIhZ
	WOxCCwALN6mfnlCDXVVEfc+5QoJs=
X-Google-Smtp-Source: AGHT+IHQg7aeU24bFk+bHfC10KDD4guSeAI138ZvIMj94coNSlL4FHs+EpzkVqZBNKIxN61wSZof/4Aw8VaT0NMXPkc=
X-Received: by 2002:a17:907:60d6:b0:a7a:8e0f:aaed with SMTP id
 a640c23a62f3a-a8090e9f919mr192445866b.50.1723139530241; Thu, 08 Aug 2024
 10:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808002118.918105-1-andrii@kernel.org> <20240808002118.918105-3-andrii@kernel.org>
 <20240808102022.GB8020@redhat.com> <CAEf4BzbAGZ7k=tZercsasGhe8JiOhXnR4e9JbcCKwMCkCXA-UQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbAGZ7k=tZercsasGhe8JiOhXnR4e9JbcCKwMCkCXA-UQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 10:51:55 -0700
Message-ID: <CAEf4BzZNgnmTLa6rEL6_cdziLKURzotdU12i0Wif2R7S5JNk7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] uprobes: protected uprobe lifetime with SRCU
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:58=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 8, 2024 at 3:20=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> >
> > On 08/07, Andrii Nakryiko wrote:
> > >
> > >  struct uprobe {
> > > -     struct rb_node          rb_node;        /* node in the rb tree =
*/
> > > +     union {
> > > +             struct rb_node          rb_node;        /* node in the =
rb tree */
> > > +             struct rcu_head         rcu;            /* mutually exc=
lusive with rb_node */
> >
> > Andrii, I am sorry.
> >
> > I suggested this in reply to 3/8 before I read
> > [PATCH 7/8] uprobes: perform lockless SRCU-protected uprobes_tree looku=
p
> >
> > I have no idea if rb_erase() is rcu-safe or not, but this union certain=
ly
> > doesn't look right if we use rb_find_rcu/etc.
> >
>
> Ah, because put_uprobe() might be fast enough to remove uprobe from
> the tree, process delayed_uprobe_remove() and then enqueue
> uprobe_free_rcu() callback (which would use rcu field here,
> overwriting rb_node), while we are still doing a lockless lookup,
> finding this overwritten rb_node . Good catch, if that's the case (and
> I'm testing all this right now), then it's an easy fix.
>
> It would also explain why I initially didn't get any crashes for
> lockless RB-tree lookup with uprobe-stress (I was really surprised
> that I "missed" the crash initially).
>
> Thanks!

I can confirm that the crash went away. Previously it was crashing
after a few minutes, but now it's running for almost an hour with no
problem. Phew, I was worried there for a bit, but it seems like we are
back to the "everything is fine" state.

Okay, I'll incorporate this fix and synchronize_srcu() locally, will
give it a few more days, maybe Peter will want to take another look.
Will send a new revision early next week.

>
>
> > Yes, this version doesn't include the SRCU-protected uprobes_tree chang=
es,
> > but still...
> >
> > Oleg.
> >


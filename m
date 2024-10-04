Return-Path: <bpf+bounces-41013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DCE991074
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D94B1C22E08
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E21B4F12;
	Fri,  4 Oct 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8diY9L5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7124231C8E;
	Fri,  4 Oct 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073141; cv=none; b=h+I0ru0Fp7iDOQvF2JOFy0/fd+D+3X6xpNfsy7DCTscGbvlAkU0oU8eREOW3VMzXob8Dxng7Qrk/TUOXbqsHyrc0sThtMYfchIP7yZgi7gzLmfQVe62YMics4K4wO4u/v5s3/5buVbtiYsKYnpbzacJi3b4qL9ytpg6fUWIT/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073141; c=relaxed/simple;
	bh=kO8h2yh/96qdBvgnAEctiSIaSRu5H1VvkCa+5VUd7og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfITi+mEWI8BzR5coKJ6sevBbxEtuGTsJvAJxCQoqPZ77V4v8wrHLTxjZ4ksyg754t6x1REUoAdz9tmBptw6t1arAj7GfF/5OqxmUuPFaibWFZydYrci1N8ooAywpN8H1OC56I/FPTlyiYtStOG1Ct5LN4GAhStTkhshfjdRxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8diY9L5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b90ab6c19so27521245ad.0;
        Fri, 04 Oct 2024 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728073139; x=1728677939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FLheXzq/15q2f96LLXhH5P16czCOjKPDgTOb73CTE8=;
        b=G8diY9L55L5b6FrbSACK1iIu9gZTCHol9Z88vB5eKnn/ivwxa4er6d//MyU/Veg+4X
         TExezbJFz8UuQ177LcIiVM76gXNp5E/QIOfszlRr7DVOt3qUbqBUmVXqo/YCb4LojN86
         lLLCxqzejAOvq/4MS67bYloV5UbrRa1KSTkDcS9WVebZ4+InAIii/4H6y05MkQ19LEKX
         95aW4grZ/cPivPD3tln58tFeDegsL4GzK5qxIgU++naSfOXnwcvns7dOAfUbKthzbIWG
         jXn/YiPAMTBC4UKZ7ELZtL6VGK4NWfO6phip7bFTq4JKzDUBXnYS4fQ/5v+pDeOg9M3A
         TmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728073139; x=1728677939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FLheXzq/15q2f96LLXhH5P16czCOjKPDgTOb73CTE8=;
        b=SXv+9qLxdti201G21nqTCybXWDkXeSasedgHJZEXRAuyIOIZwEUrMYJepqL9EQMg/A
         Sp13R3z1MzLYrNTWaHt6X0JWiC3mesosSFzNJbS9Vp3D5hTPkd5WlmXoYyCZhuW/bohK
         cArlWoLx27bCu5aE8aWHcl4z7XVXiCXpnASZFBeddYaTqP6TEUM6vUI+EYy6ZeKaaFa4
         wk9QeSzAeWgsBQRFo+i8chpgwEbpI/CqbqFEkwQ20maTin+f+6sXbn/4tbY83LF+QOnZ
         Fz7i/uG43ceIVrlAU26maK7WhqMw4yahDCKI5ZRIxaovYdYR3rtWuWrzE6SKzffw4sxH
         xX1A==
X-Forwarded-Encrypted: i=1; AJvYcCVsDQ16n085wUoLT3pqQpmuiYciEdOxh96gBwrzBACeveM2xJ5eRaAYC9tPf+oEUD1BoFsWedLa3alELXYX@vger.kernel.org, AJvYcCW4UlaeGKTNRP4LxQOL0LmcVqh46iSGseYnew/64Aw0BtMTAFY1zu/fKp8v0DcFrIWpX3c=@vger.kernel.org, AJvYcCWNIZl4zFpl9eY0lYCO4iDChgmoomX+kW2Mcr5KahDZQ32j1/fVra4dOHpu+dN2iHnq5Xe39XMajDkVNDChPwzmOSCP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxvs1e8wCMgw3mUxguMPfO5qb36daPeE0s32UEKqOxOSPkQpbM
	fNIBLZv0DJmVF7HzWIWSTHDuAhqZstiAdiXk9OlQTY84DGw1qQdpmxV3/387sO+QHxTbaG508EE
	VVqE5iz9DKfEzO3HByW/n7j2MZtI=
X-Google-Smtp-Source: AGHT+IFosWxYbZhnzaNUh9VcJNKxeVjZan6qDfHnjL8KTgP25O9RmU3CjTba4VmgHvpvWOfuS33JHNtRt6/gz3P+yVo=
X-Received: by 2002:a17:902:ea11:b0:202:28b1:9f34 with SMTP id
 d9443c01a7336-20bff04acbemr40906135ad.56.1728073139155; Fri, 04 Oct 2024
 13:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-2-andrii@kernel.org>
 <20240915144910.GA27726@redhat.com> <CAEf4BzZ7=NFAUB_GzAt1SCO=LnCFSbqX_NThtjrs8EfkjBUr7A@mail.gmail.com>
In-Reply-To: <CAEf4BzZ7=NFAUB_GzAt1SCO=LnCFSbqX_NThtjrs8EfkjBUr7A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Oct 2024 13:18:46 -0700
Message-ID: <CAEf4BzYO0i0f_pui6PwAfEHCVwaP0yR9BDY8-+EfvgbPjFXxbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable
 softirq context
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 1:19=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Sep 15, 2024 at 4:49=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 09/09, Andrii Nakryiko wrote:
> > >
> > > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), whi=
ch
> > > makes it unsuitable to be called from more restricted context like so=
ftirq.
> > >
> > > Let's make put_uprobe() agnostic to the context in which it is called=
,
> > > and use work queue to defer the mutex-protected clean up steps.
> >
> > ...
> >
> > > +static void uprobe_free_deferred(struct work_struct *work)
> > > +{
> > > +     struct uprobe *uprobe =3D container_of(work, struct uprobe, wor=
k);
> > > +
> > > +     /*
> > > +      * If application munmap(exec_vma) before uprobe_unregister()
> > > +      * gets called, we don't get a chance to remove uprobe from
> > > +      * delayed_uprobe_list from remove_breakpoint(). Do it here.
> > > +      */
> > > +     mutex_lock(&delayed_uprobe_lock);
> > > +     delayed_uprobe_remove(uprobe, NULL);
> > > +     mutex_unlock(&delayed_uprobe_lock);
> > > +
> > > +     kfree(uprobe);
> > > +}
> > > +
> > >  static void uprobe_free_rcu(struct rcu_head *rcu)
> > >  {
> > >       struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu)=
;
> > >
> > > -     kfree(uprobe);
> > > +     INIT_WORK(&uprobe->work, uprobe_free_deferred);
> > > +     schedule_work(&uprobe->work);
> > >  }
> >
> > This is still wrong afaics...
> >
> > If put_uprobe() can be called from softirq (after the next patch), then
> > put_uprobe() and all other users of uprobes_treelock should use
> > write_lock_bh/read_lock_bh to avoid the deadlock.
>
> Ok, I see the problem, that's unfortunate.
>
> I see three ways to handle that:
>
> 1) keep put_uprobe() as is, and instead do schedule_work() from the
> timer thread to postpone put_uprobe(). (but I'm not a big fan of this)
> 2) move uprobes_treelock part of put_uprobe() into rcu callback, I
> think it has no bearing on correctness, uprobe_is_active() is there
> already to handle races between putting uprobe and removing it from
> uprobes_tree (I prefer this one over #1 )
> 3) you might like this the most ;) I think I can simplify
> hprobes_expire() from patch #2 to not need put_uprobe() at all, if I
> protect uprobe lifetime with non-sleepable
> rcu_read_lock()/rcu_read_unlock() and perform try_get_uprobe() as the
> very last step after cmpxchg() succeeded.
>
> I'm leaning towards #3, but #2 seems fine to me as well.

Ok, so just a short update. I don't think #3 works, I do need
try_get_uprobe() before I know for sure that cmpxchg() succeeds. Which
means I'd need a compensating put_uprobe() if cmpxchg() fails. So for
put_uprobe(), I just made it do all the locking in deferred work
callback (which is #2 above), which I think resolved the issue you
pointed out with potential deadlock and removes any limitations on
put_uprobe().

Also, I rewrote the hprobe_consume() and hprobe_expire() in terms of
an explicit state machine with 4 possible states (LEASED, STABLE,
GONE, CONSUMED), which I think makes the logic a bit more
straightforward to follow. Hopefully that will make the change more
palatable for you. I'm probably going to post patches next week,
though.

>
> >
> > To be honest... I simply can't force myself to even try to read 2/3 ;) =
I'll
> > try to do this later, but I am sure I will never like it, sorry.
>
> This might sound rude, but the goal here is not to make you like it :)
> The goal is to improve performance with minimal complexity. And I'm
> very open to any alternative proposals as to how to make uretprobes
> RCU-protected to avoid refcounting in the hot path.
>
> I think #3 proposal above will make it a bit more palatable (but there
> is still locklessness, cmpxchg, etc, I see no way around that,
> unfortunately).
>
> >
> > Oleg.
> >


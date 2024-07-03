Return-Path: <bpf+bounces-33728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5959252AE
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 06:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF81C223B7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 04:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40594778E;
	Wed,  3 Jul 2024 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf5mKwcp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2012E5D;
	Wed,  3 Jul 2024 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719982076; cv=none; b=m06Hv12lEbCcZ/5mid6sw+TMsUO2x8fXsBFtYNVSoxGoEVUJcsnRSa7jecm2S1/TY2F5ea9g//4hmmjoTcgICUNmeMLK10loNR4rdOR2ENJUMyKAb105JuAp5nYT1nwzXckqXLo98X5FWQ3odGB7/kFHtZWTGCaA9OiMqncKYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719982076; c=relaxed/simple;
	bh=GZartgvGAOCjv7riqzAZqkBUGuz57CI86qNm2Xe26ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGy1uTXBzRf0mKhDrPph7KcgCyJJsAmJgCAQOC5zYWo8tIb5Tb7jdbKIMkV7z9avS2dXwzqcWgdkC5rXaNb/Lj5s2sOsaiaRppdZLQYmUsIddV3Egg8aycQffDN39xvh8vYPeyGKNUrEoPwQyvEMnGr3YhM1/F80sB2RwdE8iVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf5mKwcp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7276c331f78so171212a12.0;
        Tue, 02 Jul 2024 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719982074; x=1720586874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q3ILO2d3cDsjUHcE6TpnKdX4hvjH7+I6HODIdwgwGY=;
        b=mf5mKwcpAQx9qvbp/6rUPagXUFGnwveNNBvxYLzaUbG8mwckGFnwviV+rGcXgg1al7
         1gnnQEfX1b6fPWl1WDnVtELSObWISJ/3K2ZjUxKOvO8tCZS2gL3NW1vD+qli8x0QKZyw
         L7VjgAusfhYaISLVj3GLNva19FEOzjsKZChmSHTcIUaBIO25Wk4lejRIWSjA9N/SRhiy
         3m+8gesvKw1HXEhb0PxiRRHWOORL7hK3L4VOkKK/JojoxPol+5pSPqBHa3XSwNdLCfVg
         bdylYUhGzJUMUqLO1M9s1HtjKmQ8UkpZK2p1PduFEvbHCXAatHhogdvL2AAY/stco/xw
         YHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719982074; x=1720586874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q3ILO2d3cDsjUHcE6TpnKdX4hvjH7+I6HODIdwgwGY=;
        b=CwIbf1DPU7KvRxnpZh0R+6f6Kyg7sn5CchblpfxzFbXZwivTIB5DYkxTSitk5oMnht
         TkJIOd0fF/15WIAEqmWPTIclVneNXFEu/Q9Q1TvexxMOp7N3/NR6/1M8PfOD6dUgiC7l
         NgvMoYWxGZqtgxpLECTOSBOP4ErRsbXTflQV96/8UMsv1DP/DfZ5Lsjxrt/Jhn8235xy
         N498FVS83Qzme9JuMcC4iPtkZL5bSmjLWAOEdeehQHNbul7oRHtwy4YIdeajCtLQ6c9x
         w7EzJl0U5GyoQzerX6hbF3ZXb1cXDb9z1fN0mrJibK/Rr08v+zgVOi7Petrk2bjY5fPv
         6f+g==
X-Forwarded-Encrypted: i=1; AJvYcCXY0SGYPZclNQ34OWCaWvRh8Q5TRmyQH+fPk5dl4di+m4b/41JB193YKdNOU3zeFNBaJX05Ay2CD0EPhdEr+IBrJlnCFqv0dRr5Wk9umyfHTwifPjdmeh1FjbGPcsA+c1H5tWIm5R0zwOV0TKgJ/YUgNYDntvUz3sLRoILkDmf3h8pfVyRc
X-Gm-Message-State: AOJu0Yygyw5Lbq3F8uTh4vUtpzICAsSIuAGE+SLVnxXeY9fVEW4b0s1j
	K0uUpHQZwZPZj8pxKTC/3Hmb+4bgNGwUTSlgmT4f8eKC/bDC8UaLRewZjvZ83+caiCBgX/W/e08
	UOfNgUuMi85G15H+/zdT8QaBdWIqEu+hr
X-Google-Smtp-Source: AGHT+IEUyBu4fwU4xlpaTEBQbaDh/u1/iYwR89ks3oeprsVBeqUP4DaC3ZnlbbEVkBlri4Z3zALhD249xX3Jj9RAABs=
X-Received: by 2002:a05:6a20:7f99:b0:1be:c2d9:be69 with SMTP id
 adf61e73a8af0-1c0bff5f3c6mr883840637.23.1719982074005; Tue, 02 Jul 2024
 21:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net> <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 21:47:41 -0700
Message-ID: <CAEf4BzZuEicv3DkYA8HYG10QnBURK4SFddhTbA06=eOKQr82PA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	oleg@redhat.com, mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 12:19=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 02, 2024 at 10:54:51AM -0700, Andrii Nakryiko wrote:
>
> > > @@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct uprobe *=
uprobe)
> > >         return uprobe;
> > >  }
> > >

[...]

> > > @@ -668,12 +677,25 @@ static struct uprobe *__find_uprobe(struct inod=
e *inode, loff_t offset)
> > >  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset=
)
> > >  {
> > >         struct uprobe *uprobe;
> > > +       unsigned seq;
> > >
> > > -       read_lock(&uprobes_treelock);
> > > -       uprobe =3D __find_uprobe(inode, offset);
> > > -       read_unlock(&uprobes_treelock);
> > > +       guard(rcu)();
> > >
> > > -       return uprobe;
> > > +       do {
> > > +               seq =3D read_seqcount_begin(&uprobes_seqcount);
> > > +               uprobes =3D __find_uprobe(inode, offset);
> > > +               if (uprobes) {
> > > +                       /*
> > > +                        * Lockless RB-tree lookups are prone to fals=
e-negatives.
> > > +                        * If they find something, it's good. If they=
 do not find,
> > > +                        * it needs to be validated.
> > > +                        */
> > > +                       return uprobes;
> > > +               }
> > > +       } while (read_seqcount_retry(&uprobes_seqcount, seq));
> > > +
> > > +       /* Really didn't find anything. */
> > > +       return NULL;
> > >  }
> >
> > Honest question here, as I don't understand the tradeoffs well enough.
> > Is there a lot of benefit to switching to seqcount lock vs using
> > percpu RW semaphore (previously recommended by Ingo). The latter is a
> > nice drop-in replacement and seems to be very fast and scale well.
>
> As you noted, that percpu-rwsem write side is quite insane. And you're
> creating this batch complexity to mitigate that.


Note that batch API is needed regardless of percpu RW semaphore or
not. As I mentioned, once uprobes_treelock is mitigated one way or the
other, the next one is uprobe->register_rwsem. For scalability, we
need to get rid of it and preferably not add any locking at all. So
tentatively I'd like to have lockless RCU-protected iteration over
uprobe->consumers list and call consumer->handler(). This means that
on uprobes_unregister we'd need synchronize_rcu (for whatever RCU
flavor we end up using), to ensure that we don't free uprobe_consumer
memory from under handle_swbp() while it is actually triggering
consumers.

So, without batched unregistration we'll be back to the same problem
I'm solving here: doing synchronize_rcu() for each attached uprobe one
by one is prohibitively slow. We went through this exercise with
ftrace/kprobes already and fixed it with batched APIs. Doing that for
uprobes seems unavoidable as well.

>
> The patches you propose are quite complex, this alternative not so much.

I agree that this custom refcounting is not trivial, but at least it's
pretty well contained within two low-level helpers which are all used
within this single .c file.

On the other hand, it actually gives us a) speed and better
scalability (I showed comparisons with refcount_inc_not_zero approach
earlier, I believe) and b) it actually simplifies logic during
registration (which is even more important aspect with batched API),
where we don't need to handle uprobe suddenly going away after we
already looked it up.

I believe overall it's an improvement worth doing.

>
> > Right now we are bottlenecked on uprobe->register_rwsem (not
> > uprobes_treelock anymore), which is currently limiting the scalability
> > of uprobes and I'm going to work on that next once I'm done with this
> > series.
>
> Right, but it looks fairly simple to replace that rwsem with a mutex and
> srcu.

srcu vs RCU Tasks Trace aside (which Paul addressed), see above about
the need for batched API and synchronize_rcu().


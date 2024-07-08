Return-Path: <bpf+bounces-34116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321392A85E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818521C21202
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737821487EB;
	Mon,  8 Jul 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr51B3tA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B779146A85;
	Mon,  8 Jul 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460856; cv=none; b=MieUtoSLuOBvRYlRRjzzvwAAqu2gGWG2O8qYC6RcT6Er3TF5y1bsrISqFkAwmfUc2qzf5Q+wZpzdeIHf6rgYONOfH3Ka+60TRSa9e4u5XbFKrpOFDS+SIxgepeuAU/V2lmdf+d7Zl6JZzeuv6ESwWFSNNBxigUWHnc+0vQTxLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460856; c=relaxed/simple;
	bh=CrouN1t+aG+0SjeAmR0gu0NPrzKsxMgNzRQ6RyYLCC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF6M6HET8eO9ZxnGH3zlsY47FxurSccKTDoW6Fr11giMvGyaN51h09UPc9ERXcUwv3YmJSsTiTycuLy6V0ZcmJhV3+4dXs7Yxda8xP0C4kiO+BimrN/E7VbSQCVYv6rkXs2xJ5TwamUEO5gBJ5G1oW5T565FiyPhjoz2y9ilP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr51B3tA; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c66f5659edso888484eaf.0;
        Mon, 08 Jul 2024 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720460854; x=1721065654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWL6wDI8FUbHT+SRawotvReaygnX0n0Dse1dRvcZLR4=;
        b=Sr51B3tA4tXcSLg6WkLxrThj6GCOQtZQ/l8hFg2yOl4y1QcWMu6SSCG7nyZ9TKiUbg
         +cMWoA8WjQIBdaW3CLsVZ44fc91IEYcLEyJcXqtpsL8LMXqowBPfQbeKn/RKd94yDuyb
         9cb6R29cbT7fnyvyxBEtWL04dSS5bvUcy0kdVQUKPCrclgO/x2tKTcl/xnkRuDVczZuU
         7FPTFRE89td+yaSln6nLfCMgRfo/kD1MBYfKVKRKppQpMkL2FWHObXi5Lyl3c6e/Irve
         +Rcfvzia9cCSbXMWIOznN25hq1d/p2CJjm8oLkCg0+Cv1HUicOPHyw3BSbVj489Iif9d
         oR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720460854; x=1721065654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWL6wDI8FUbHT+SRawotvReaygnX0n0Dse1dRvcZLR4=;
        b=aZxnMxHZShrzxtQvfiomYr9fsORmJSeEgZgbrMpJQW+uLcecqwxJOT0PTxJmJipAKE
         noFhqFlK7L8aFBpURDQoYtVSHApaksFaoX3Jhd+7Z37uMwfW+eKzRwz27KY/MgMtNQfe
         JVm/pNfhAYOOAi7hVr092QfX5kBOIkNItpzdvZpDWTWLYdkQVFcxkmO14cxdhWkpywVA
         WYMUAps/WbJkcQo2IzwpCk5RIPj2e3E2CTuSAh8+/wqufFnPCYVehieq+2ek7vRZVqMs
         ESUCDI8FH8g5eKZ1MwY7h9FRxfSKVu84eJTjspFd4yBF0834OFU5E/D5CF0Rv5he1rvC
         keaA==
X-Forwarded-Encrypted: i=1; AJvYcCXTCvgEvmwEMPZKmj3MhjfBZ8mk/FMp1KyXQaiNytpODraGusxTkt3Jue9Rr4JhCZ2bpi7DvdhI4UaBMhZUYYL4EGyBkzTG7XQT0asOgBo68eg4Db44ptlChYTvbpAbK8MPjjHUdx5F
X-Gm-Message-State: AOJu0Yyic97Ec/K6KczDHKTpJp7LvMA7eAQtwt4KuIoj6X2LHPxfEhBh
	Xh80ADhsnkW2X4RSm9swZdL5ly6iRu9ivQkzz02AGvQ7Ql2kwLgFi6nwUfq3qUwxOyN7mQjT57Q
	Tq7CvNSR3zE/jjC44kU2MGl1eQBM=
X-Google-Smtp-Source: AGHT+IEhG2Ogqa+UXU+43yjQ12nptbzMPEahpNHQRd1O6K+kSJ55SNp85+rP9fY/RIUBtYXCpAgKc4B74P66QW/j4+U=
X-Received: by 2002:a05:6870:20c:b0:254:a0ca:6dd1 with SMTP id
 586e51a60fabf-25eae74ea67mr85302fac.12.1720460853671; Mon, 08 Jul 2024
 10:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com> <20240707144653.GB11914@redhat.com>
In-Reply-To: <20240707144653.GB11914@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:47:20 -0700
Message-ID: <CAEf4BzYZCVNFQcVBPue4uom+StiCQA6ObR7Z-sKzcEZyTiSyRA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 7:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> And I forgot to mention...
>
> In any case __uprobe_unregister() can't ignore the error code from
> register_for_each_vma(). If it fails to restore the original insn,
> we should not remove this uprobe from uprobes_tree.
>
> Otherwise the next handle_swbp() will send SIGTRAP to the (no longer)
> probed application.

Yep, that would be unfortunate (just like SIGILL sent when uretprobe
detects "improper" stack pointer progression, for example), but from
what I gather it's not really expected to fail on unregistration given
we successfully registered uprobe. I guess it's a decision between
leaking memory with an uprobe stuck in the tree or killing process due
to some very rare (or buggy) condition?


>
> On 07/05, Oleg Nesterov wrote:
> >
> > Tried to read this patch, but I fail to understand it. It looks
> > obvioulsy wrong to me, see below.
> >
> > I tend to agree with the comments from Peter, but lets ignore them
> > for the moment.
> >
> > On 07/01, Andrii Nakryiko wrote:
> > >
> > >  static void put_uprobe(struct uprobe *uprobe)
> > >  {
> > > -   if (refcount_dec_and_test(&uprobe->ref)) {
> > > +   s64 v;
> > > +
> > > +   /*
> > > +    * here uprobe instance is guaranteed to be alive, so we use Task=
s
> > > +    * Trace RCU to guarantee that uprobe won't be freed from under u=
s, if
> > > +    * we end up being a losing "destructor" inside uprobe_treelock'e=
d
> > > +    * section double-checking uprobe->ref value below.
> > > +    * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> > > +    */
> > > +   rcu_read_lock_trace();
> > > +
> > > +   v =3D atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
> > > +
> > > +   if (unlikely((u32)v =3D=3D 0)) {
> >
> > I must have missed something, but how can this ever happen?
> >
> > Suppose uprobe_register(inode) is called the 1st time. To simplify, sup=
pose
> > that this binary is not used, so _register() doesn't install breakpoint=
s/etc.
> >
> > IIUC, with this change (u32)uprobe->ref =3D=3D 1 when uprobe_register()=
 succeeds.
> >
> > Now suppose that uprobe_unregister() is called right after that. It doe=
s
> >
> >       uprobe =3D find_uprobe(inode, offset);
> >
> > this increments the counter, (u32)uprobe->ref =3D=3D 2
> >
> >       __uprobe_unregister(...);
> >
> > this wont't change the counter,
> >
> >       put_uprobe(uprobe);
> >
> > this drops the reference added by find_uprobe(), (u32)uprobe->ref =3D=
=3D 1.
> >
> > Where should the "final" put_uprobe() come from?
> >
> > IIUC, this patch lacks another put_uprobe() after consumer_del(), no?
> >
> > Oleg.
>


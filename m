Return-Path: <bpf+bounces-40019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDA097ACC3
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57827284C5F
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09409158D6A;
	Tue, 17 Sep 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt1xc0R4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A214BFBF;
	Tue, 17 Sep 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561207; cv=none; b=YXCVgEDCCIBmu2HrHY3DYsTDbnhqq7asxRCOvzHzS23lwFSlsiWugOFCVcBbFUWVXc8qCEgke8CnHfMG4NLpPj5je/R4eKvHt3qEioHVWRpyRRvmf2pfoVpva9+R0Po0EkRS3oRIh5UB8Vzosm+ei0pFfBbEV4xcqgQ7qrUwWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561207; c=relaxed/simple;
	bh=JAdXm+rX1/pVgjsENL8UoNmXkCkvirS/Np8hpzkXMH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3fJ6/gnPPmvIV1pOKgLmJtXF8fKu9P39AfY/FoC+t5F6l9CH1MDb1zntJoUxEAVpUeDp/ifw6nw89qO+VZbD0XZLy9k8nbaU/0UxEqlzbgb0A0t29iLEH35XeiqMVuOIYJ4iqjZ8X5/TIxGz5SE7ZD5HhaeGpc1UaFQpTOqAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt1xc0R4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2db928dbd53so4449777a91.2;
        Tue, 17 Sep 2024 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726561205; x=1727166005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ra+SQc9uHcvjAN7hkGM2XXAlzDGo+8+oSMMPF/cZoQ=;
        b=mt1xc0R4SRN6sFYxAGA30UnH8k8/zZmjzR4FOzP/RTxDNXa+Fw7SOTYDpeuIFOYgcn
         AGvPWiBPx3/A9JafM42qJWmPv+kfHw5+cPR6Jobzr9BhMBaEccddpmxFaLTVauQ12ewo
         nXGQYuJiV/Al0/U5eEiI74NK8f8wL0aOcgFymoUHvnqn9XDX64TuWim6nJJT4/LttsZY
         S3yVIlrEBvRXmcwdMyhffeoFIGjUpwfdnK8e/5LmE7YWgVSBeCcUrLwJ6QH0k895PC/e
         rBHnBO9ApuTYGm6c5vFQaaPXUZyMyuvIPCkjmPOp/ppka1OSCMAu+fmaCXl57VYZhoz2
         Dfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726561205; x=1727166005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ra+SQc9uHcvjAN7hkGM2XXAlzDGo+8+oSMMPF/cZoQ=;
        b=MExQxjBhyS7H4RKQY8NtFeCPcSXbx+zHvELfB2pxYeaSCj1AoxapeT69gT4fX9oCkx
         zaBGlnbbnBBfE7wnxnD6iZ7DNGaC78fuBCz9DgnvmWFZmV4xTzmQZx/jHRCKAWi+zWk6
         c/VFuPyMRkiL3tS3My6mBlWvh3iTWTHwlvHU9U+bvDPmvi4GGvy5xuEbe3OHirh9BeHo
         42wW7/0182q9QH8GmYJ6jusOVNMK4HpejLczvXkx4yYLR5ew8Q4EPYLbwYeKhW2lVdZB
         TbhVd91r76S33c+QaUPfOuWddj6AbfPABKKe8/KADngs/DLAYzDcqVr+LveQPM7pNCqX
         q/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUsojT1Lznzc5GLagHsabxKle+gyJLy112GIYOm1llJXMx3rwtvlyC2jy+vEGA3gjfhYjY=@vger.kernel.org, AJvYcCWXtBu8QFO+MOV7cux4silZg4bWHzHqNw0mEvDsWjOtpXgHIDVFOuBDVt8Rdg7NrEMgwoooDHA1wJC6BccD@vger.kernel.org, AJvYcCXB2DmeLAW/rPYb03i9w69UfY37/PMCFJtNVcCPAUjqlzJY5hc4N5MgS9wNwZzSaUBEYJiW7jrwDOp9FNq/V4VX3GOX@vger.kernel.org
X-Gm-Message-State: AOJu0YzEx9a8RIEjLntNanTA5Ond2Z93rbFGBBokn4+ptmAlCcW79MDT
	WRsSH7S7FTZzyrx+4XLcHfkY0pWQzWu6K6ECg+bQsXr//T9t3Xi1l0nqxGW+wwkNJtezPS8F/7W
	XRx1uZeshPHvcbeo9aoFzWektPlo=
X-Google-Smtp-Source: AGHT+IHeb8QhWe7L1st5kpnG3VCqDJOMgiZBhAWmiX2Gp4IGXLpTrVf6bQETaQe3XXeORZWigYwMasVhBWzydxIieoE=
X-Received: by 2002:a17:90a:9a8b:b0:2d8:8d60:a198 with SMTP id
 98e67ed59e1d1-2dba0082612mr21362376a91.37.1726561205432; Tue, 17 Sep 2024
 01:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-2-andrii@kernel.org>
 <20240915144910.GA27726@redhat.com>
In-Reply-To: <20240915144910.GA27726@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Sep 2024 10:19:52 +0200
Message-ID: <CAEf4BzZ7=NFAUB_GzAt1SCO=LnCFSbqX_NThtjrs8EfkjBUr7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable
 softirq context
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 4:49=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 09/09, Andrii Nakryiko wrote:
> >
> > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> > makes it unsuitable to be called from more restricted context like soft=
irq.
> >
> > Let's make put_uprobe() agnostic to the context in which it is called,
> > and use work queue to defer the mutex-protected clean up steps.
>
> ...
>
> > +static void uprobe_free_deferred(struct work_struct *work)
> > +{
> > +     struct uprobe *uprobe =3D container_of(work, struct uprobe, work)=
;
> > +
> > +     /*
> > +      * If application munmap(exec_vma) before uprobe_unregister()
> > +      * gets called, we don't get a chance to remove uprobe from
> > +      * delayed_uprobe_list from remove_breakpoint(). Do it here.
> > +      */
> > +     mutex_lock(&delayed_uprobe_lock);
> > +     delayed_uprobe_remove(uprobe, NULL);
> > +     mutex_unlock(&delayed_uprobe_lock);
> > +
> > +     kfree(uprobe);
> > +}
> > +
> >  static void uprobe_free_rcu(struct rcu_head *rcu)
> >  {
> >       struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
> >
> > -     kfree(uprobe);
> > +     INIT_WORK(&uprobe->work, uprobe_free_deferred);
> > +     schedule_work(&uprobe->work);
> >  }
>
> This is still wrong afaics...
>
> If put_uprobe() can be called from softirq (after the next patch), then
> put_uprobe() and all other users of uprobes_treelock should use
> write_lock_bh/read_lock_bh to avoid the deadlock.

Ok, I see the problem, that's unfortunate.

I see three ways to handle that:

1) keep put_uprobe() as is, and instead do schedule_work() from the
timer thread to postpone put_uprobe(). (but I'm not a big fan of this)
2) move uprobes_treelock part of put_uprobe() into rcu callback, I
think it has no bearing on correctness, uprobe_is_active() is there
already to handle races between putting uprobe and removing it from
uprobes_tree (I prefer this one over #1 )
3) you might like this the most ;) I think I can simplify
hprobes_expire() from patch #2 to not need put_uprobe() at all, if I
protect uprobe lifetime with non-sleepable
rcu_read_lock()/rcu_read_unlock() and perform try_get_uprobe() as the
very last step after cmpxchg() succeeded.

I'm leaning towards #3, but #2 seems fine to me as well.

>
> To be honest... I simply can't force myself to even try to read 2/3 ;) I'=
ll
> try to do this later, but I am sure I will never like it, sorry.

This might sound rude, but the goal here is not to make you like it :)
The goal is to improve performance with minimal complexity. And I'm
very open to any alternative proposals as to how to make uretprobes
RCU-protected to avoid refcounting in the hot path.

I think #3 proposal above will make it a bit more palatable (but there
is still locklessness, cmpxchg, etc, I see no way around that,
unfortunately).

>
> Oleg.
>


Return-Path: <bpf+bounces-36292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554A945FD3
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CF01C21B6A
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D821C17F;
	Fri,  2 Aug 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkeQKIhM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8991F61C;
	Fri,  2 Aug 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611041; cv=none; b=nYEl6bUisa0cHbuWKVYtGVNxsa6cA95qoN+DQCzOcPsdYeBlV5d9gOFe1uULyCrdghkVH1WQxHgiMSnclEhJzNSo3dRzFKluYSIxhZuTO715BDrGDtVGyD/a0JlpAjNWS7ntrbqyMnWZCeZWO8+Bi+lWLUqfGDnf5sq7RCvXJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611041; c=relaxed/simple;
	bh=IoR5lyUFL+tO8MqmxYx6ubpa69xnrVfzyT01anECDFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7CtX9voK0ddHjLV/c3jernO1/KoJEmbwMnUU2S9MzwNh02LCQSJ1E6mE2OVFy1hpqkCA6GEgGxEblps4nMJ38GoxKKBewcw3J+ywhsnDfQJft5QHlW8g7l0ir4cDC/7SxW41MGcGXeK05PxXb+bjbfsRKO/I41JR9g/ibvtz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkeQKIhM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso6059574b3a.1;
        Fri, 02 Aug 2024 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722611039; x=1723215839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0H/bERQlrZ1DjkqSeGhsDTzSRq9MwspaSuR7UMwxII=;
        b=ZkeQKIhMXcw1sxf3QMxOOXBdcjpClRfznjpOWHJBxE+giddCfva5YIKIvXRG+nAjwV
         xZteasIsNI3XfdoyxYaojw8/iV7kikuvKRxciPcQlqRTWUWrMkhmdbccA02wwNOBdY+a
         hlnzc+qG+VaoueOeM0CpRGI3OX8lIim4KdqI3g9z805T9ngUGkk5c00K8wu7HzqfMplE
         xGPH62NU/Vz5M1lESmTlkxYgGuJ3f+vWc2erQjis3VNbFgOOb2HFrUlLqACXfGRy1eR9
         TqUDcVqui0Q6GS8qmTZdSOWc6EOsjXHsf/MdNUKmMtP7gU6jU7H5/P9WWZ+Fp20g1plu
         PZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611039; x=1723215839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0H/bERQlrZ1DjkqSeGhsDTzSRq9MwspaSuR7UMwxII=;
        b=W3CCgTpr1bjrj5uoCn5sA6xDPuHEGF8JIsDBeqQORJbgulmoO65ZIs81hgKtN5KTMG
         6K87ssHw500qyeVF7WGmrqaySrN+Vc7taafK7IP/TCL1bGQk1EVjwEILF3tt9UW9idor
         WGcu6xcBcac0iOgKU7eJISASdyboJuEOORNNiG9uxJgBUsMghlnXwczVsCfyCfNgrPQU
         dOZLhTVZ2oNfW8n/eRddo/o+ILZCpi28YHmyXND3UGBEQGDGLw1oE2KzJhcbTboivGFI
         V8e15XYncM3bZFiyD5QutnM8XVjC6rf371MqIHmOit+ynN6iA2YTPvZXhIkXEQzPAEqE
         XcpA==
X-Forwarded-Encrypted: i=1; AJvYcCUarGQPnmtY3pYND3ukS1wXwR3xIduAdExOEOww7pwRbC3cuG0l6ndQTPnFPEnWVe8fYpvIsICSb3qOfCjo1/wubZXV8TNfOPbtF3bYNmHK1c87o0C/QMUjJGjxWXqyuEdrx/vaDk6wmbHKkrvrd9T7OZXF6yrfXEJ/H0Zgc2dsIQsy2aMz
X-Gm-Message-State: AOJu0YyjQJDW9SD+FtsudoX7yoE03gACyUceTkPNo76EcTsFR8Dw8FCb
	clXuN5WI47txfoZv+BykZnPNa+QoCkDVOUeBD7vod6ZLnczbsPYEJqg5HTFznQB7eabZMtDAsg1
	vlqF6o+l6on6eQDZpRJJK1oO0kmsY4g==
X-Google-Smtp-Source: AGHT+IHXB5zGkiAc79Xe8QqP0XrYFv6YL+bg4dmL76s04TDoAjNUrPQu0yuevM16oGpeCCPoORjUuhylCAkeF2KDQFY=
X-Received: by 2002:a17:90a:a417:b0:2c9:6f8d:7270 with SMTP id
 98e67ed59e1d1-2cff9544dc7mr4151713a91.42.1722611039266; Fri, 02 Aug 2024
 08:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-3-andrii@kernel.org>
 <Zqy-94c1cAUKoWA4@krava>
In-Reply-To: <Zqy-94c1cAUKoWA4@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Aug 2024 08:03:47 -0700
Message-ID: <CAEf4BzZbYT9kP7CAY_ddkFFXiVDS3N=HO0AbCcxfKXZue2cQPA@mail.gmail.com>
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime management
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:11=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 02:42:50PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > -/*
> > - * There could be threads that have already hit the breakpoint. They
> > - * will recheck the current insn and restart if find_uprobe() fails.
> > - * See find_active_uprobe().
> > - */
> > -static void delete_uprobe(struct uprobe *uprobe)
> > -{
> > -     if (WARN_ON(!uprobe_is_active(uprobe)))
> > -             return;
> > -
> > -     write_lock(&uprobes_treelock);
> > -     rb_erase(&uprobe->rb_node, &uprobes_tree);
> > -     write_unlock(&uprobes_treelock);
> > -     RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > -}
> > -
> >  struct map_info {
> >       struct map_info *next;
> >       struct mm_struct *mm;
> > @@ -1094,17 +1120,12 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       int err;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     if (WARN_ON(!consumer_del(uprobe, uc)))
> > +     if (WARN_ON(!consumer_del(uprobe, uc))) {
> >               err =3D -ENOENT;
> > -     else
> > +     } else {
> >               err =3D register_for_each_vma(uprobe, NULL);
> > -
> > -     /* TODO : cant unregister? schedule a worker thread */
> > -     if (!err) {
> > -             if (!uprobe->consumers)
> > -                     delete_uprobe(uprobe);
>
> ok, so removing this call is why the consumer test is failing, right?
>
> IIUC the previous behaviour was to remove uprobe from the tree
> even when there's active uprobe ref for installed uretprobe
>
> so following scenario will now behaves differently:
>
>   install uretprobe/consumer-1 on foo
>   foo {
>     remove uretprobe/consumer-1                (A)
>     install uretprobe/consumer-2 on foo        (B)
>   }
>
> before the removal of consumer-1 (A) would remove the uprobe object
> from the tree, so the installation of consumer-2 (b) would create
> new uprobe object which would not be triggered at foo return because
> it got installed too late (after foo uprobe was triggered)
>
> the behaviour with this patch is that removal of consumer-1 (A) will
> not remove the uprobe object (that happens only when we run out of
> refs), and the following install of consumer-2 will use the existing
> uprobe object so the consumer-2 will be triggered on foo return
>
> uff ;-)

yep, something like that

>
> but I think it's better, because we get more hits

note, with the next patch set that makes uretprobes SRCU protected
(but with timeout) the behavior becomes a bit time-sensitive :) so I
think we'll have to change your selftest to first attach all the new
uretprobes, then detach all the uretprobes that had to be detached,
and then do a bit more relaxed logic of the sort "if there were some
uretprobes before and after, then we *might* get uretprobe triggered
(but we might not as well, unless the same uretprobe stayed attached
at all times)".

Anyways, something to take care of in the bpf-next tree separately.

All this is very much an implementation detail, so I think we can
change these aspects freely.

>
> jirka
>
> > -             else
> > -                     err =3D -EBUSY;
> > +             /* TODO : cant unregister? schedule a worker thread */
> > +             WARN(err, "leaking uprobe due to failed unregistration");
> >       }
> >       up_write(&uprobe->register_rwsem);
> >
> > @@ -1159,27 +1180,16 @@ struct uprobe *uprobe_register(struct inode *in=
ode,
> >       if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> >               return ERR_PTR(-EINVAL);
> >
> > - retry:
> >       uprobe =3D alloc_uprobe(inode, offset, ref_ctr_offset);
> >       if (IS_ERR(uprobe))
> >               return uprobe;
> >
> > -     /*
> > -      * We can race with uprobe_unregister()->delete_uprobe().
> > -      * Check uprobe_is_active() and retry if it is false.
> > -      */
> >       down_write(&uprobe->register_rwsem);
> > -     ret =3D -EAGAIN;
> > -     if (likely(uprobe_is_active(uprobe))) {
> > -             consumer_add(uprobe, uc);
> > -             ret =3D register_for_each_vma(uprobe, uc);
> > -     }
> > +     consumer_add(uprobe, uc);
> > +     ret =3D register_for_each_vma(uprobe, uc);
> >       up_write(&uprobe->register_rwsem);
> > -     put_uprobe(uprobe);
> >
> >       if (ret) {
> > -             if (unlikely(ret =3D=3D -EAGAIN))
> > -                     goto retry;
> >               uprobe_unregister(uprobe, uc);
> >               return ERR_PTR(ret);
>
> SNIP


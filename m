Return-Path: <bpf+bounces-38494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA81965373
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCDD1C227C7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C218E760;
	Thu, 29 Aug 2024 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+9NbsP8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32018A937;
	Thu, 29 Aug 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974293; cv=none; b=qgDzOCqQoOg7ho4WnizgvSTjfiYmsPrLVs8SnYCGarAkYzzFg0nJ+iBvcSn4eM7ElMHkr0C4rzhqQouWHAZa/wQLO9AYae2e6vOM1LyU+vrRTrTWDj28yS759vnJb4VGVe1XeisNIoDWINV4oXVf6FkYPMv/1Sgp97skol5nnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974293; c=relaxed/simple;
	bh=YHOnGNOKioXdeTGyBe9loz1Wia5knzMilaslA9uBFBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr7bqfGvlTKaN4Qlc7oppYTyd7kOn3+lEyIuYBuBypoyRkL3lhSEHpgv8kUkERxrsHM+TJe1NEmlMUvJCI17sRIkpzA6DhPsbNC/3k6U1b+WyEeiuJ+fTUd7Y9XiBsaaJExWE5mFpyTMJA8I+DZzGdia90HZnReCI0JkWwKLWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+9NbsP8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso1632272a91.0;
        Thu, 29 Aug 2024 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724974291; x=1725579091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sGLpSuNSb9TW4wOVrUrMRuVsSgylePv3SAAiV7rgxA=;
        b=l+9NbsP8vSYiPlOIMwRTkl6irdqHXZY0kdWh76yHDeYrlWbHl8DrXPMLQSJzB2GJ25
         NOA+/9zm8b3+W1XSf7yIGJu5riWvKGUVOU7Q2PiZXjSZGpDO+YC6o44vv0qInDH5BWQc
         JL13fF5UIKibDz+wagASJsFsgpJLEb7059v3DEoWrI35poja/SVMtSBYKp+21qWod9FK
         9uJpn2wHHRKaeeFwFIpsk+eWgam3cRWoV7PsFMguW7dSjuZJLwN1IcbXlexOMZYWGeIo
         NZD1twou68rTxF5atOOtAWZ7hiP9xbY1PzBWnrYL23Tln4eZEwBBuBaUSUxBKILChncC
         bXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974291; x=1725579091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sGLpSuNSb9TW4wOVrUrMRuVsSgylePv3SAAiV7rgxA=;
        b=PAX1+MkoPCynTCn8putQMNUjiCuZm7Zhvx1ZTBs5ZkNmUB8NcAsBUM8h0AHVi53eET
         cxUUYgxi4Ng+SmUz4ogX2VDGBqVX0BxDpNWhKiGAGs61glllF3GEIoLbyaiHkEI4zJBE
         cXagtGAkmHwCUIJ78AtduEwiU/3KYcNd4hyFTH8BI17ZA8G1MlIX053+4gluWZiwXsKa
         FoVadhs1BS1wMoNFv1s4Yu0+fS2RhYNUt2nK53whEwCBzb+UX2EfZ/PZjnu1fz9QpxUJ
         UdIV/NehZJ0G5mJSni9XhHFsS6pSrNDeNN7HcYbZ9pP4kL9JUAw8Traf7hpvGyGo+RGm
         4XXA==
X-Forwarded-Encrypted: i=1; AJvYcCWgvnj7PKIaGp/ncMbL5fBN1E6dVsTspvN5UC5+jFWp1fHC8Sht3WMlG60QF8awRbG6rTUMpcKaGlFjUYw4@vger.kernel.org, AJvYcCWhWjMQLflrcAatkw+m7n/jESNuAi6XFf6mZK6Uzq7EdAdKl9WcySxDpYEpQ0MbhCS1ARVSn/nTiv5VP7IrqzEyEML0@vger.kernel.org, AJvYcCXVQBM7bv2pEDSGxYph0Mv3fFg7+z101w4x+eKPRvY7hyqP98tNPBe6XximSKz4tDNy0g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrRh5vgc53Nkz9lG6LwZsi2ImyHeFTzrKL40cDjEgm4O/NCWq
	86x38VeBBHhnNa0xWOrHMRpuzm+G6gVLx+UlmruWhckuAPY7iE0TMEHXytsMzk1JjfeuHUAJe4j
	hV76A8EZYQVuLp3iR3n4puwbD5mYIKQ==
X-Google-Smtp-Source: AGHT+IG2BzeU3+Y2dsTguQEEYV/W0QoXOwVAztdGZI+xFocA80n2JYgBL9eumUXtEmUdGK+owUNOgdddLh6JmuVWmBo=
X-Received: by 2002:a17:90b:2750:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2d86b00ece4mr657169a91.14.1724974291105; Thu, 29 Aug 2024
 16:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183741.3331213-1-andrii@kernel.org> <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
In-Reply-To: <ZtD_x9zxLjyhS37Z@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Aug 2024 16:31:18 -0700
Message-ID: <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:10=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Aug 29, 2024 at 11:37:37AM -0700, Andrii Nakryiko wrote:
> > uprobe->register_rwsem is one of a few big bottlenecks to scalability o=
f
> > uprobes, so we need to get rid of it to improve uprobe performance and
> > multi-CPU scalability.
> >
> > First, we turn uprobe's consumer list to a typical doubly-linked list
> > and utilize existing RCU-aware helpers for traversing such lists, as
> > well as adding and removing elements from it.
> >
> > For entry uprobes we already have SRCU protection active since before
> > uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> > won't go away from under us, but we add SRCU protection around consumer
> > list traversal.
> >
> > Lastly, to keep handler_chain()'s UPROBE_HANDLER_REMOVE handling simple=
,
> > we remember whether any removal was requested during handler calls, but
> > then we double-check the decision under a proper register_rwsem using
> > consumers' filter callbacks. Handler removal is very rare, so this extr=
a
> > lock won't hurt performance, overall, but we also avoid the need for an=
y
> > extra protection (e.g., seqcount locks).
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/uprobes.h |   2 +-
> >  kernel/events/uprobes.c | 104 +++++++++++++++++++++++-----------------
> >  2 files changed, 62 insertions(+), 44 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 9cf0dce62e4c..29c935b0d504 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -35,7 +35,7 @@ struct uprobe_consumer {
> >                               struct pt_regs *regs);
> >       bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm=
);
> >
> > -     struct uprobe_consumer *next;
> > +     struct list_head cons_node;
> >  };
> >
> >  #ifdef CONFIG_UPROBES
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 8bdcdc6901b2..97e58d160647 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -59,7 +59,7 @@ struct uprobe {
> >       struct rw_semaphore     register_rwsem;
> >       struct rw_semaphore     consumer_rwsem;
> >       struct list_head        pending_list;
> > -     struct uprobe_consumer  *consumers;
> > +     struct list_head        consumers;
> >       struct inode            *inode;         /* Also hold a ref to ino=
de */
> >       struct rcu_head         rcu;
> >       loff_t                  offset;
> > @@ -783,6 +783,7 @@ static struct uprobe *alloc_uprobe(struct inode *in=
ode, loff_t offset,
> >       uprobe->inode =3D inode;
> >       uprobe->offset =3D offset;
> >       uprobe->ref_ctr_offset =3D ref_ctr_offset;
> > +     INIT_LIST_HEAD(&uprobe->consumers);
> >       init_rwsem(&uprobe->register_rwsem);
> >       init_rwsem(&uprobe->consumer_rwsem);
> >       RB_CLEAR_NODE(&uprobe->rb_node);
> > @@ -808,32 +809,19 @@ static struct uprobe *alloc_uprobe(struct inode *=
inode, loff_t offset,
> >  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer=
 *uc)
> >  {
> >       down_write(&uprobe->consumer_rwsem);
> > -     uc->next =3D uprobe->consumers;
> > -     uprobe->consumers =3D uc;
> > +     list_add_rcu(&uc->cons_node, &uprobe->consumers);
> >       up_write(&uprobe->consumer_rwsem);
> >  }
> >
> >  /*
> >   * For uprobe @uprobe, delete the consumer @uc.
> > - * Return true if the @uc is deleted successfully
> > - * or return false.
> > + * Should never be called with consumer that's not part of @uprobe->co=
nsumers.
> >   */
> > -static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer=
 *uc)
> > +static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer=
 *uc)
> >  {
> > -     struct uprobe_consumer **con;
> > -     bool ret =3D false;
> > -
> >       down_write(&uprobe->consumer_rwsem);
> > -     for (con =3D &uprobe->consumers; *con; con =3D &(*con)->next) {
> > -             if (*con =3D=3D uc) {
> > -                     *con =3D uc->next;
> > -                     ret =3D true;
> > -                     break;
> > -             }
> > -     }
> > +     list_del_rcu(&uc->cons_node);
> >       up_write(&uprobe->consumer_rwsem);
> > -
> > -     return ret;
> >  }
> >
> >  static int __copy_insn(struct address_space *mapping, struct file *fil=
p,
> > @@ -929,7 +917,8 @@ static bool filter_chain(struct uprobe *uprobe, str=
uct mm_struct *mm)
> >       bool ret =3D false;
> >
> >       down_read(&uprobe->consumer_rwsem);
> > -     for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> > +     list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > +                              srcu_read_lock_held(&uprobes_srcu)) {
> >               ret =3D consumer_filter(uc, mm);
> >               if (ret)
> >                       break;
> > @@ -1125,18 +1114,29 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       int err;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > -             err =3D -ENOENT;
> > -     } else {
> > -             err =3D register_for_each_vma(uprobe, NULL);
> > -             /* TODO : cant unregister? schedule a worker thread */
> > -             if (unlikely(err))
> > -                     uprobe_warn(current, "unregister, leaking uprobe"=
);
> > -     }
> > +     consumer_del(uprobe, uc);
> > +     err =3D register_for_each_vma(uprobe, NULL);
> >       up_write(&uprobe->register_rwsem);
> >
> > -     if (!err)
> > -             put_uprobe(uprobe);
> > +     /* TODO : cant unregister? schedule a worker thread */
> > +     if (unlikely(err)) {
> > +             uprobe_warn(current, "unregister, leaking uprobe");
> > +             goto out_sync;
> > +     }
> > +
> > +     put_uprobe(uprobe);
> > +
> > +out_sync:
> > +     /*
> > +      * Now that handler_chain() and handle_uretprobe_chain() iterate =
over
> > +      * uprobe->consumers list under RCU protection without holding
> > +      * uprobe->register_rwsem, we need to wait for RCU grace period t=
o
> > +      * make sure that we can't call into just unregistered
> > +      * uprobe_consumer's callbacks anymore. If we don't do that, fast=
 and
> > +      * unlucky enough caller can free consumer's memory and cause
> > +      * handler_chain() or handle_uretprobe_chain() to do an use-after=
-free.
> > +      */
> > +     synchronize_srcu(&uprobes_srcu);
> >  }
> >  EXPORT_SYMBOL_GPL(uprobe_unregister);
> >
> > @@ -1214,13 +1214,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
> >  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bo=
ol add)
> >  {
> >       struct uprobe_consumer *con;
> > -     int ret =3D -ENOENT;
> > +     int ret =3D -ENOENT, srcu_idx;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     for (con =3D uprobe->consumers; con && con !=3D uc ; con =3D con-=
>next)
> > -             ;
> > -     if (con)
> > -             ret =3D register_for_each_vma(uprobe, add ? uc : NULL);
> > +
> > +     srcu_idx =3D srcu_read_lock(&uprobes_srcu);
> > +     list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> > +                              srcu_read_lock_held(&uprobes_srcu)) {
> > +             if (con =3D=3D uc) {
> > +                     ret =3D register_for_each_vma(uprobe, add ? uc : =
NULL);
> > +                     break;
> > +             }
> > +     }
> > +     srcu_read_unlock(&uprobes_srcu, srcu_idx);
> > +
> >       up_write(&uprobe->register_rwsem);
> >
> >       return ret;
> > @@ -2085,10 +2092,12 @@ static void handler_chain(struct uprobe *uprobe=
, struct pt_regs *regs)
> >       struct uprobe_consumer *uc;
> >       int remove =3D UPROBE_HANDLER_REMOVE;
> >       bool need_prep =3D false; /* prepare return uprobe, when needed *=
/
> > +     bool has_consumers =3D false;
> >
> > -     down_read(&uprobe->register_rwsem);
> >       current->utask->auprobe =3D &uprobe->arch;
> > -     for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> > +
> > +     list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > +                              srcu_read_lock_held(&uprobes_srcu)) {
> >               int rc =3D 0;
> >
> >               if (uc->handler) {
> > @@ -2101,17 +2110,24 @@ static void handler_chain(struct uprobe *uprobe=
, struct pt_regs *regs)
> >                       need_prep =3D true;
> >
> >               remove &=3D rc;
> > +             has_consumers =3D true;
> >       }
> >       current->utask->auprobe =3D NULL;
> >
> >       if (need_prep && !remove)
> >               prepare_uretprobe(uprobe, regs); /* put bp at return */
> >
> > -     if (remove && uprobe->consumers) {
> > -             WARN_ON(!uprobe_is_active(uprobe));
> > -             unapply_uprobe(uprobe, current->mm);
> > +     if (remove && has_consumers) {
> > +             down_read(&uprobe->register_rwsem);
> > +
> > +             /* re-check that removal is still required, this time und=
er lock */
> > +             if (!filter_chain(uprobe, current->mm)) {
>
> sorry for late question, but I do not follow this change..
>
> at this point we got 1 as handler's return value from all the uprobe's co=
nsumers,
> why do we need to call filter_chain in here.. IIUC this will likely skip =
over
> the removal?
>

Because we don't hold register_rwsem we are now racing with
registration. So while we can get all consumers at the time we were
iterating over the consumer list to request deletion, a parallel CPU
can add another consumer that needs this uprobe+PID combination. So if
we don't double-check, we are risking having a consumer that will not
be triggered for the desired process.

Does it make sense? Given removal is rare, it's ok to take lock if we
*suspect* removal, and then check authoritatively again under lock.

> with single uprobe_multi consumer:
>
>   handler_chain
>     uprobe_multi_link_handler
>       uprobe_prog_run
>         bpf_prog returns 1
>
>     remove =3D 1
>
>     if (remove && has_consumers) {
>
>       filter_chain - uprobe_multi_link_filter returns true.. so the uprob=
e stays?
>
> maybe I just need to write test for it ;-)
>
> thanks,
> jirka
>
>
> > +                     WARN_ON(!uprobe_is_active(uprobe));
> > +                     unapply_uprobe(uprobe, current->mm);
> > +             }
> > +
> > +             up_read(&uprobe->register_rwsem);
> >       }
> > -     up_read(&uprobe->register_rwsem);
> >  }
> >
> >  static void
> > @@ -2119,13 +2135,15 @@ handle_uretprobe_chain(struct return_instance *=
ri, struct pt_regs *regs)
> >  {
> >       struct uprobe *uprobe =3D ri->uprobe;
> >       struct uprobe_consumer *uc;
> > +     int srcu_idx;
> >
> > -     down_read(&uprobe->register_rwsem);
> > -     for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> > +     srcu_idx =3D srcu_read_lock(&uprobes_srcu);
> > +     list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > +                              srcu_read_lock_held(&uprobes_srcu)) {
> >               if (uc->ret_handler)
> >                       uc->ret_handler(uc, ri->func, regs);
> >       }
> > -     up_read(&uprobe->register_rwsem);
> > +     srcu_read_unlock(&uprobes_srcu, srcu_idx);
> >  }
> >
> >  static struct return_instance *find_next_ret_chain(struct return_insta=
nce *ri)
> > --
> > 2.43.5
> >


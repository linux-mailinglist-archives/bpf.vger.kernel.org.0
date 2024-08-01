Return-Path: <bpf+bounces-36234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34A1945110
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690A528827A
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDFB1B9B3A;
	Thu,  1 Aug 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgSkCLT+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9ED14287;
	Thu,  1 Aug 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530976; cv=none; b=K4rezpdrPam59ZZfVX6b35TWGPNxcc1WVd0g7xu44FFAIWhk1FDHYm08z3vfyjqh0ahhPA+aXYah8i8B2zZ9pxoSc88uamX4hkT0IEQJA5pVhcaAKTk5yfp5ig13jBZfQfAlQwcxzMm0xxVoD4ttYTJL7SfKe0BMPGC1yLjbIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530976; c=relaxed/simple;
	bh=MXl6Q8uGTvW7YUAYMB37EavYcd8sIOpvy+wN7aFgqts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc4cnLOTso8vBfeEzoXK8H+nFW6iIe+LC3BlZLSGk1W4a34/Ty/28wOoVDaLDYNeHkSewKgQYphNeUTqgUZIZcFI7lgmdKl/9jdiWXjIe+S1pIURtyhL3jE6AKMxYxS8HSa+pPQPBQAtp/a9hTGog35xUfRoRXVbq8zpNo3F394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgSkCLT+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso1567547a91.3;
        Thu, 01 Aug 2024 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722530974; x=1723135774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyLVob+V5HXkoAuPRko8jKPm/FOaseUPXqO8fLyyVn4=;
        b=QgSkCLT+6TVUzOiVcX3XSZYr+GzU3kOpmKV6uKEmrErZx9tEly9o4W06dCt4uGmoSi
         d+u4ORHKRqHutRhzcEWQh+oC3Q8bEoqfb2jrlRaPUm/xv1HrO9kiuI3uS9lwlbV9aB4F
         TE0+Hua1KcLEfFztmfRwGOKleFU/HgqtQk/JRXLDhn9r6FuOhU5LvEAlXdnnvRCkqH29
         XQA+HkNQFua1UwebDpbFjM6Sm2oZYb4W4ZDwI1nN74NAU0lIN4gwULNSTnZRKP8xGRKw
         EnyhWzU8suu/LPkiFyD2tDNekgPERG51BTEF3SWSsD0XX2eZCq0XYSYe+yKvNxiwBTAu
         CetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530974; x=1723135774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyLVob+V5HXkoAuPRko8jKPm/FOaseUPXqO8fLyyVn4=;
        b=XN6gWanIEh2m3dcKbrShbgWXDN9hSlEdvKadLoJ4Gb45kh3rfjp0faqFjlI0FREexZ
         Eqvnl/fGAgB2VOHRjE3aNxFNudTQR7aOYP5Ds4Cmi41W/LSmbZvousiJOq2fnd/FVUG0
         wo9Pq1PNQRuAFdgsxFY4W1me+/xb60vb7lKx+W8UZ3TIos6/gxOTdRtJImo0ZZbwhxKJ
         w+bjEn3pbO/gwQ2t9tGcnFhAp8LC8IKf9giNgwqDxOHdheCHENC1+OpELFQLx2CdG9JC
         jEL7gFwXAJLNUliTN42P+yTxyaaZHGVGwWoargKIrT6YnVDKKRXo///h6h6d/CnjUj3e
         mCNg==
X-Forwarded-Encrypted: i=1; AJvYcCXnpVVN47yiBg24AQfsaMVm78SGJ3eBMmOm7uUsF9FiNm+YpAGkTpjC8LChrHN0vexr/ObOY0EDqJFgd7iNvl6/LU6mlB2OUpRQuLzH9TtgPO0VcdoT8Qjx49ElEHzuph3o+ykklPg9whnYi41oghvgmJ9IlCWBsUuLGpSjtQqFBqLSo64W
X-Gm-Message-State: AOJu0Yyhbf6q5IFi4SksVDmDgNWlj0iLQt0k+RZJjhFzld0zLvZs7QJd
	pNivw+rnLI+10jPwqFgy0L/Qd8kTVkzwscjC3YHM3XROXFyroQG9TdOO7iZZqYLCPnE8bxCAOY/
	L6xkKyvgi1F+fR7HbY8Ox5gLSFVY=
X-Google-Smtp-Source: AGHT+IFfVwn1Sy2+6vQbX5tbvxi1Cw65g0Cz4rQUITJpvIDZ/ICycNVDCi93zR3Plvy4AiaWhTH7+Un54VrPnDr+Ktg=
X-Received: by 2002:a17:90b:4fd1:b0:2c9:7aa6:e15d with SMTP id
 98e67ed59e1d1-2cff945c29bmr962203a91.20.1722530974504; Thu, 01 Aug 2024
 09:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-3-andrii@kernel.org>
 <Zqts-5hac4_H-lrC@krava>
In-Reply-To: <Zqts-5hac4_H-lrC@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 09:49:22 -0700
Message-ID: <CAEf4BzaHpGGhZzxTTS_2-MBBjXy_mU9yjg5pTc_bq6JtcFLO1w@mail.gmail.com>
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime management
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 02:42:50PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -     if (refcount_dec_and_test(&uprobe->ref)) {
> > -             /*
> > -              * If application munmap(exec_vma) before uprobe_unregist=
er()
> > -              * gets called, we don't get a chance to remove uprobe fr=
om
> > -              * delayed_uprobe_list from remove_breakpoint(). Do it he=
re.
> > -              */
> > -             mutex_lock(&delayed_uprobe_lock);
> > -             delayed_uprobe_remove(uprobe, NULL);
> > -             mutex_unlock(&delayed_uprobe_lock);
> > -             kfree(uprobe);
> > -     }
> > +     if (!refcount_dec_and_test(&uprobe->ref))
> > +             return;
> > +
> > +     write_lock(&uprobes_treelock);
> > +
> > +     if (uprobe_is_active(uprobe))
> > +             rb_erase(&uprobe->rb_node, &uprobes_tree);
> > +
> > +     write_unlock(&uprobes_treelock);
> > +
> > +     /*
> > +      * If application munmap(exec_vma) before uprobe_unregister()
> > +      * gets called, we don't get a chance to remove uprobe from
> > +      * delayed_uprobe_list from remove_breakpoint(). Do it here.
> > +      */
> > +     mutex_lock(&delayed_uprobe_lock);
> > +     delayed_uprobe_remove(uprobe, NULL);
> > +     mutex_unlock(&delayed_uprobe_lock);
>
> we should do kfree(uprobe) in here, right?

heh, yep, seems like I lost it while rebasing or something, good catch! fix=
ed.


>
> I think this is fixed later on when uprobe_free_rcu is introduced
>
> SNIP
>
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
>
> nice, I like getting rid of this.. so far lgtm ;-)
>
> jirka
>
>
> >               uprobe_unregister(uprobe, uc);
> >               return ERR_PTR(ret);
> >       }
> > @@ -1286,15 +1296,19 @@ static void build_probe_list(struct inode *inod=
e,
> >                       u =3D rb_entry(t, struct uprobe, rb_node);
> >                       if (u->inode !=3D inode || u->offset < min)
> >                               break;
> > +                     u =3D try_get_uprobe(u);
> > +                     if (!u) /* uprobe already went away, safe to igno=
re */
> > +                             continue;
> >                       list_add(&u->pending_list, head);
> > -                     get_uprobe(u);
> >               }
> >               for (t =3D n; (t =3D rb_next(t)); ) {
> >                       u =3D rb_entry(t, struct uprobe, rb_node);
> >                       if (u->inode !=3D inode || u->offset > max)
> >                               break;
> > +                     u =3D try_get_uprobe(u);
> > +                     if (!u) /* uprobe already went away, safe to igno=
re */
> > +                             continue;
> >                       list_add(&u->pending_list, head);
> > -                     get_uprobe(u);
> >               }
> >       }
> >       read_unlock(&uprobes_treelock);
> > @@ -1752,6 +1766,12 @@ static int dup_utask(struct task_struct *t, stru=
ct uprobe_task *o_utask)
> >                       return -ENOMEM;
> >
> >               *n =3D *o;
> > +             /*
> > +              * uprobe's refcnt has to be positive at this point, kept=
 by
> > +              * utask->return_instances items; return_instances can't =
be
> > +              * removed right now, as task is blocked due to duping; s=
o
> > +              * get_uprobe() is safe to use here.
> > +              */
> >               get_uprobe(n->uprobe);
> >               n->next =3D NULL;
> >
> > @@ -1894,7 +1914,10 @@ static void prepare_uretprobe(struct uprobe *upr=
obe, struct pt_regs *regs)
> >               }
> >               orig_ret_vaddr =3D utask->return_instances->orig_ret_vadd=
r;
> >       }
> > -
> > +      /*
> > +       * uprobe's refcnt is positive, held by caller, so it's safe to
> > +       * unconditionally bump it one more time here
> > +       */
> >       ri->uprobe =3D get_uprobe(uprobe);
> >       ri->func =3D instruction_pointer(regs);
> >       ri->stack =3D user_stack_pointer(regs);
> > --
> > 2.43.0
> >


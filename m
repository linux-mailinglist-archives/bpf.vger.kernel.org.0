Return-Path: <bpf+bounces-28135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4128B60BB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3211C21E0D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914301292FF;
	Mon, 29 Apr 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ+bg66J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D51292FB
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413084; cv=none; b=R8RkwiFnV8ZhBazMIDEYQSJrVf+emXL1+pRfoA0xfJwiCgT/OwLoZJmTXUJwb2RtBEgRwlhio5XuS4dZpgB/dP4PK4Wfq24gqvloC8TeXguDsWrk1ir8GniQRXzbQQzjjLz3HUY48q8UGrQWYS/YOhDgupDutCDUiN8go0SNSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413084; c=relaxed/simple;
	bh=f78Ygc/nopLHE9nngxePzTeDBGvyUYr/E9ueB6dUvHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czl26pe1cF+pXsLM9O17MVRLYGe+5MVU4EO8iEpXIMVJCvz7RrjJnSpGtnTuOx7D7hK9brtwr1YTKf3z+j09SYkO9ENx2aRjjRNDxgKjYMWyAh0eGwBF3MhG8M0pd+8dHBf6+0/BiEhvUpzu3QsB7sQFW7J8olooGMlZwsCj5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ+bg66J; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4dac3cbc8fdso1292133e0c.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714413081; x=1715017881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FTvodmLFwsC+Aoed45QZMuC5qnzI4vmF8J1QUrj1dBQ=;
        b=NQ+bg66J09xDMspAPMQX511cXOkw6Xui5w5ZPPiycbF3MUFdapU5PjCsWZNBpAExcN
         G7UJdVCTHAvIbZD3KP+t/A2qxt2cJW2IQSsIqX2qko4LrODgJYpTkOA0LioOPjPohhvy
         Gw6Tp8AkikHMF1LbRHwHoqEpSRrgOaHhek5ysxwB+sng918ST2wIVj9LZ/MXw424wmui
         0BRtXuKEn9uIbonGVhBTnHDxJFckL87N+/QEGZc9CjZCGCE0mLHY3lgP+cYqoC/irhhu
         Nb0wNLOPMfJfwkbHN9bz6npqKbgwqqN6BvlNvQuCOvP3U/pyC/BJuuyRwsjkS7WBXSWX
         T39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714413081; x=1715017881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTvodmLFwsC+Aoed45QZMuC5qnzI4vmF8J1QUrj1dBQ=;
        b=cLOMuZS/bPrfvjJ/Nx3IzEo+edXYHW+yA0pSLd2ec073tI0DJV+4lmZz826RP2L6ud
         WXjyLF0ZdTQnOS5oFH7q0YJE8/j7a5bc1k0yfhj9lhwAeFpdm2E9pXfLqwaj0JErODcO
         q7laPnMld0MHI3BNc82V1rYL9zlpZlGg+er9H1Dj8Drg5Z+bm3yTB+9DyiDRYR4aCQj4
         6mrpUjUCPYgM541G4vJ0hx9BY/GeZG4lIU9eLxvcuoEaegAzCLzJld7yUG5JtwlKvr4/
         UrfYpRCu/YPAqrSfHeUk28RtRFMREt3xAnHtoC/XMZMjGyla+dR/RBijDuYxblX84PZt
         WbIw==
X-Gm-Message-State: AOJu0YydvhoglZmZT1+GK9iB7+6ghh33ul4DEH84AoG62RLCG/w7J9fp
	as27bK+0+i8Lbo9Y+gOaaq1AWOKrfQQoT0jEhMPmfUL2E4elqNbAucGk+8v1PbmZ20MWK7naDFT
	HN+tYXDX/SvgVXU96c3p319n4+B4=
X-Google-Smtp-Source: AGHT+IGOPWEX5DSV1efPTrLycTHHJh1sxRO6B2ffAGK+CVcRoDMsDbOp4mVS8AXmQLGCoLF8xmYe1xwNUfl192BBN2I=
X-Received: by 2002:a05:6102:3185:b0:47c:29e8:96ae with SMTP id
 c5-20020a056102318500b0047c29e896aemr9118397vsh.15.1714413081523; Mon, 29 Apr
 2024 10:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429165658.1305969-1-sidchintamaneni@gmail.com> <CAP01T74N=Lk5Yc0LT1xF9_mZfeizmfGv1Bg5R9EVfwcMiddQOA@mail.gmail.com>
In-Reply-To: <CAP01T74N=Lk5Yc0LT1xF9_mZfeizmfGv1Bg5R9EVfwcMiddQOA@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 29 Apr 2024 13:51:10 -0400
Message-ID: <CAE5sdEhqH5gXb2DVsSYZ_36DPk-gaRsYBi_nxer5e4QqJ19wHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] Patch to Fix deadlocks in queue and stack maps
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, Siddharth Chintamaneni <sidchintamaneni@vt.edu>, 
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 13:47, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Mon, 29 Apr 2024 at 18:57, Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> >
> > This patch address a possible deadlock issue in queue and
> > stack map types.
> >
> > Deadlock could happen when a nested BPF program
> > acquires the same lock as the parent BPF program
> > to perform a write operation on the same map as
> > the first one. This bug is also reported by
> > syzbot.
> >
> > Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
> > Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
> > Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > ---
> >  kernel/bpf/queue_stack_maps.c | 42 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> > index d869f51ea93a..4b7df1a53cf2 100644
> > --- a/kernel/bpf/queue_stack_maps.c
> > +++ b/kernel/bpf/queue_stack_maps.c
> > @@ -18,6 +18,7 @@ struct bpf_queue_stack {
> >         raw_spinlock_t lock;
> >         u32 head, tail;
> >         u32 size; /* max_entries + 1 */
> > +       int __percpu *map_locked;
> >
> >         char elements[] __aligned(8);
> >  };
> > @@ -78,6 +79,16 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
> >
> >         qs->size = size;
> >
> > +       qs->map_locked = bpf_map_alloc_percpu(&qs->map,
> > +                                               sizeof(int),
> > +                                               sizeof(int),
> > +                                               GFP_USER);
>
> GFP_USER | __GFP_NOWARN, like we do everywhere else.
>
> > +       if (!qs->map_locked) {
> > +               bpf_map_area_free(qs);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +
> >         raw_spin_lock_init(&qs->lock);
> >
> >         return &qs->map;
> > @@ -98,6 +109,16 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
> >         int err = 0;
> >         void *ptr;
> >
> > +       preempt_disable();
> > +       local_irq_save(flags);
> > +       if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> > +               __this_cpu_dec(*(qs->map_locked));
> > +               local_irq_restore(flags);
> > +               preempt_enable();
> > +               return -EBUSY;
> > +       }
> > +       preempt_enable();
> > +
>
> You increment, but don't decrement the map_locked counter after unlock.
> Likewise in all other cases. Then this operation cannot be called
> anymore after the first time on a given cpu for a given map.
> Probably why CI is also failing.
> https://github.com/kernel-patches/bpf/actions/runs/8882578097/job/24387802831?pr=6915
> returns -16 (EBUSY).
> E.g. check hashtab.c, it does __this_cpu_dec after unlock in htab_unlock_bucket.
>

My bad I sent a wrong patch, I will send a revised version.

> >  [...]
> >
> >


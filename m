Return-Path: <bpf+bounces-29908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DD8C8034
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EA22835DF
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6098EB672;
	Fri, 17 May 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdQ/TwMS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704969476
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715916772; cv=none; b=onXNn9hp9mxPYka+mG/fxTpoWRMrao5/CO2/ZWs25NTbYjKHwypK6RPB+RpBjdJyc9Dnh0yPicoK4wzEdl7iAjdIcg3rFDV7VFCQwbsu3NIPgurJRxd/0Qrkpyk6FSqGWX9YEI9T8gq4vjrpXJ4+YxTDw7+8b+088ysqjROHWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715916772; c=relaxed/simple;
	bh=+yGUE+QnjIXFCI3019tYkThEm1TmT4VZrChWiy7bT3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9urT3xaMiMgmIQBcp1euwLkMEQAN7fSbt3hTABPzrjAMZ7Or+bokX6XwqnHLb+lOHuC3TuivcLxoUD7l74mBLjf1d71OuS0Yt03atdWwwK/Hlf/Qui6cx0H3FRPJIFI92w4KjyNhdHkxiBo5GvEK58a8jBwS+05eCUXBmwmt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdQ/TwMS; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df344eecd7so68760e0c.3
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715916770; x=1716521570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MExuj761t1n5E9dK4TfE0PHGq9uSaRuoYsTRltitpRQ=;
        b=NdQ/TwMSv5U8CxXKbqT3igfpW/YAXxwq/0UmiYyzg5oK9sTPyBxIimZkb0Ib3MSC86
         8z/NOrhv5MtCDyPF9TToUFehNSw1mXxFEToB9G1S5PT419N1pCh0l02GgyzBFS0P45Pa
         nexrCzcbuRG3APM7GZuvkT8nW5SFuK82b1DHVu3a0C63inyJZ5EMWSQHFOBBHpK2+IkE
         2ooyEQ0VtMD28h3NO+LSBBhRHomysYOtsx9JiGZQBQUJqgl/dxQdABnUrddm07qXWu9L
         v4pfkWJIiEl7k6376oXg/933jV6NNU/ukMqmgHnuIXYIqxR/2dHgMD+VhoPRd4OWC1hb
         /hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715916770; x=1716521570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MExuj761t1n5E9dK4TfE0PHGq9uSaRuoYsTRltitpRQ=;
        b=MsD1lEeed9ToA0wR8x69Vak9I6xnQmgYXSU25Ma/lAYNzttRvzKRBaFQNlLSKO1gbY
         wesxOPtlKhNhVlPtXtN0WY1GXcjrI+QBk2PrBN2qjjGXm2uGK31YSz6c+D9z3zwhKpBR
         aLLtV7qyo4poLUIU3ndHJR3Fl5g3xTTEFCRG4wMGNfsZv75SsBhDdP71ulKzlEFpaq9k
         liG4pmuE64X0pWf6okOS33NgqikVSxIdstgIJBqE6LfxotMQrXIbPCxqCJ4OgR4si2s2
         CIduUKBSN08j63Fk4e9phpnwjHgOVSzb1moj3wBsoA0NjHyK0bOr4zzbkw2NIcJccpRj
         gY/w==
X-Gm-Message-State: AOJu0YwbHi+tNeCch0zxhUdPcChZzGHrwY2mxj98OycgC2PSsKzRgIRS
	UT+wznrcyOcyoDipOQKbemg4Zv6jiyy0CuJNtzgHeeVSJMjSgDc+RT0HkIS3Qk91UVdhq+yfvvK
	Inv3GI/a8uVZX+hRAb4rO5aMRxIk=
X-Google-Smtp-Source: AGHT+IEksBvaFkNW6eXynhGazuWrxLiuNtauc+yD3nYgaB93dBNapjhiAw2uL5eWsf9aqlWSzEPIddv5ewTG7bk0How=
X-Received: by 2002:a05:6122:3283:b0:4d4:32e1:e7b4 with SMTP id
 71dfb90a1353d-4df882a175emr18537532e0c.4.1715916769727; Thu, 16 May 2024
 20:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <20240514124052.1240266-2-sidchintamaneni@gmail.com> <43fee6a1-c078-fc1f-2039-4ef9934d2016@huaweicloud.com>
In-Reply-To: <43fee6a1-c078-fc1f-2039-4ef9934d2016@huaweicloud.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Thu, 16 May 2024 23:32:37 -0400
Message-ID: <CAE5sdEjDjcSLKcvvxBaK0pn_MgZBSDVPfonKj6PJW7+33K2tXQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and
 stack maps
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, miloc@vt.edu, memxor@gmail.com, 
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 21:53, Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 5/14/2024 8:40 PM, Siddharth Chintamaneni wrote:
> > This patch is a revised version which addresses a possible deadlock issue in
> > queue and stack map types.
> >
> > Deadlock could happen when a nested BPF program acquires the same lock
> > as the parent BPF program to perform a write operation on the same map
> > as the first one. This bug is also reported by syzbot.
> >
> > Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
> > Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
> > Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
> >  kernel/bpf/queue_stack_maps.c | 76 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> > index d869f51ea93a..b5ed76c9ddd7 100644
> > --- a/kernel/bpf/queue_stack_maps.c
> > +++ b/kernel/bpf/queue_stack_maps.c
> > @@ -13,11 +13,13 @@
> >  #define QUEUE_STACK_CREATE_FLAG_MASK \
> >       (BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
> >
> > +
> >  struct bpf_queue_stack {
> >       struct bpf_map map;
> >       raw_spinlock_t lock;
> >       u32 head, tail;
> >       u32 size; /* max_entries + 1 */
> > +     int __percpu *map_locked;
> >
> >       char elements[] __aligned(8);
> >  };
> > @@ -78,6 +80,15 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
> >
> >       qs->size = size;
> >
> > +     qs->map_locked = bpf_map_alloc_percpu(&qs->map,
> > +                                             sizeof(int),
> > +                                             sizeof(int),
> > +                                             GFP_USER | __GFP_NOWARN);
> > +     if (!qs->map_locked) {
> > +             bpf_map_area_free(qs);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> >       raw_spin_lock_init(&qs->lock);
> >
> >       return &qs->map;
> > @@ -88,19 +99,57 @@ static void queue_stack_map_free(struct bpf_map *map)
> >  {
> >       struct bpf_queue_stack *qs = bpf_queue_stack(map);
> >
> > +     free_percpu(qs->map_locked);
> >       bpf_map_area_free(qs);
> >  }
> >
> > +static inline int map_lock_inc(struct bpf_queue_stack *qs)
> > +{
> > +     unsigned long flags;
> > +
> > +     preempt_disable();
> > +     local_irq_save(flags);
> > +     if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> > +             __this_cpu_dec(*(qs->map_locked));
> > +             local_irq_restore(flags);
> > +             preempt_enable();
> > +             return -EBUSY;
> > +     }
> > +
> > +     local_irq_restore(flags);
> > +     preempt_enable();
> > +
> > +     return 0;
> > +}
> > +
> > +static inline void map_unlock_dec(struct bpf_queue_stack *qs)
> > +{
> > +     unsigned long flags;
> > +
> > +     preempt_disable();
> > +     local_irq_save(flags);
> > +     __this_cpu_dec(*(qs->map_locked));
> > +     local_irq_restore(flags);
> > +     preempt_enable();
> > +}
> > +
> >  static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
> >  {
> >       struct bpf_queue_stack *qs = bpf_queue_stack(map);
> >       unsigned long flags;
> >       int err = 0;
> >       void *ptr;
> > +     int ret;
> > +
> > +     ret = map_lock_inc(qs);
> > +     if (ret)
> > +             return ret;
> >
> >       if (in_nmi()) {
> > -             if (!raw_spin_trylock_irqsave(&qs->lock, flags))
> > +             if (!raw_spin_trylock_irqsave(&qs->lock, flags)) {
> > +                     map_unlock_dec(qs);
> >                       return -EBUSY;
> > +             }
>
> With percpu map-locked in place, I think the in_nmi() checking could
> also be remove. When the BPF program X which has already acquired the
> lock is interrupted by a NMI, if the BPF program Y for the NMI also
> tries to acquire the same lock, it will find map_locked is 1 and return
> early.

Agreed. Same thing could be done for ringbuf as well. I will fix this
in the revision for both the patches.

>
>


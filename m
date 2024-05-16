Return-Path: <bpf+bounces-29857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972908C7988
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D7BB2104F
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46514D45E;
	Thu, 16 May 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRZOhVb9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773A14D42C
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873512; cv=none; b=IQltsNg9+A+b2JY4zlh9+qf1RZJCtH6AtTBSUC+iemBpkJEVBQwovsmopCtdSUnmPoPIVoj3CHmmVOyDIwbXJnBv1k6LinMAHNWdUMXcYodptJ+blBwY2b+YowS/Gw9tSHt5SW7V3g2zfZLS2LUYbR72SItG6ajjSuaj4jBRgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873512; c=relaxed/simple;
	bh=+2aBQHj3G4TIkSXBJVmCviLDSguKaESoIyj8nvRYWaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBj/LnqK09g3LTVh0KYH057L6TopFLdQ+Nkl1ZyNXYmj/ZbqDrhq4V7gYYMZihOwMBMtfl88VX+iPEqqoDvzHzqb0busGQjiEFGQAhSmEn2xZpnDgTEsyWO2hHvaX3MV0wrOaFFBomgxldn73Kjz5rB+Qh4nYMGTRH+kiiesyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRZOhVb9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b6c2e9ed9so39224846d6.1
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715873509; x=1716478309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmxlg9rz8ZXjfBY9Ndu+bhdPtJrqdc89+qKTN8DVabo=;
        b=jRZOhVb9Ad5a7wSvfcykfQgRU26IMUvDytuWa7Zdhf8tkdTr1rqwTVMIC7F5u1aUlE
         /4QX5Rk1RAvWhXyXczSxvZxMbylMFVWvWmYQEEFZZTF3XIrvBSJru5WoWJYjKjmiG+aG
         8BOaeW7PmaU5jo2JIBfHzcTU/LxhPM7fOfFIBDzQXUqMPlqv0U/lLKGAclT5KxaSi35W
         Wgql+/s3rajNzlBBm69NXVyxMWMMtx4/EvnidWZUl16ID0QEOToDURfmqEHEpQ3vKO13
         MBVK2otrA4MVDKXZk0O9nQ9m69Ddhm7KM/lUeFDMOEGjhGb6BPR9uIvgMwzx3fXGS3+b
         O3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715873509; x=1716478309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmxlg9rz8ZXjfBY9Ndu+bhdPtJrqdc89+qKTN8DVabo=;
        b=iwJ7u41lW7MjVBm/kdESyWH6jamvT20bW4TQ9xV0fFP4lSvTp6dLlOFBOoomSBdtZn
         l9uv8/N2kLZeXi9PjGz/lvDyVWT7ME6CKygdW1rIqkMP0a3t0BCNrclTNda11/61J5pF
         JfZRTe8VGALRvyg0Gxtm9i4oz2AVKERsrITl88Bn8oFvtsWyoKxuU1rY/lG8XbB3PaQM
         r/hesdYefKjafWrDLlGYgUqohaTSUGe6JMVtuwcVw0+SasPcbVBmC7YSJJ6KgPWJweOP
         w1quKYYx2TdlXsJcCDjLzR+RHfg/XyS7xvcuF+QeQNJMALPcnZqhN9OV05u1xrjIL80E
         sCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBEmGy6pEnUf3H2I8J/KHkgnYSbY/eMUd1CAxzPO6otwE5RsQHh9XmQboNP9NzC5zP22T0/WikbVkkob52O+NXrf8J
X-Gm-Message-State: AOJu0YykrxtPWwIeD31VrBsAF36lsR4ttadOyseTZ5HGw+a6dvF48tfM
	U/cqIEdqJNHUjeCgz0UyTMW0Yrtxe7UnMRF+SU6eh1hl9QtYSLz9PG82iY76dut+T1W73u6mySg
	+InjbuzxSx0LKBkhp6jHrjDPnIJk=
X-Google-Smtp-Source: AGHT+IGmXXF135fzwxM8SGs2Em0xhScGxxSyKS+nDo9p9vsdgjqyCEqZViRHepdpa7o2FKGDTf+FvwVxFnXKN3KefBs=
X-Received: by 2002:a05:6214:448a:b0:6a0:d52f:67c8 with SMTP id
 6a1803df08f44-6a1681b8448mr174643096d6.37.1715873509408; Thu, 16 May 2024
 08:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <20240514124052.1240266-2-sidchintamaneni@gmail.com> <55b6e3cc-3809-448e-9603-951dc0693c0c@google.com>
 <CAP01T77yXv+trVCryMDK-9VghnRrNQpoSpp_Z-OLmQz9omHRGQ@mail.gmail.com>
In-Reply-To: <CAP01T77yXv+trVCryMDK-9VghnRrNQpoSpp_Z-OLmQz9omHRGQ@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Thu, 16 May 2024 11:31:38 -0400
Message-ID: <CAE5sdEiR2nNMjyZBwEBuFovwW+YWStP1P_nZRJUOre5K1Z0AaQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and
 stack maps
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Barret Rhoden <brho@google.com>, bpf@vger.kernel.org, alexei.starovoitov@gmail.com, 
	daniel@iogearbox.net, olsajiri@gmail.com, andrii@kernel.org, 
	yonghong.song@linux.dev, rjsu26@vt.edu, sairoop@vt.edu, miloc@vt.edu, 
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 10:34, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 16 May 2024 at 16:05, Barret Rhoden <brho@google.com> wrote:
> >
> > On 5/14/24 08:40, Siddharth Chintamaneni wrote:
> > [...]
> > > +static inline int map_lock_inc(struct bpf_queue_stack *qs)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     preempt_disable();
> > > +     local_irq_save(flags);
> > > +     if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> > > +             __this_cpu_dec(*(qs->map_locked));
> > > +             local_irq_restore(flags);
> > > +             preempt_enable();
> > > +             return -EBUSY;
> > > +     }
> > > +
> > > +     local_irq_restore(flags);
> > > +     preempt_enable();
> >
> > it looks like you're taking the approach from kernel/bpf/hashtab.c to
> > use a per-cpu lock before grabbing the real lock.  but in the success
> > case here (where you incremented the percpu counter), you're enabling
> > irqs and preemption.
> >
> > what happens if you get preempted right after this?  you've left the
> > per-cpu bit set, but then you run on another cpu.
>
> Great catch, that's a bug. It's not a problem when BPF programs call
> this, as migration is disabled for them (but it's questionable whether
> we should keep preemption enabled between map_inc/dec increasing the
> chances of conflicts on the same CPU), but it's certainly a problem
> from the syscall path.
>

I was also thinking from the BPF programs perspective as migration is
disabled on them. I will fix this.

> >
> > possible alternative: instead of splitting the overall lock into "grab
> > percpu lock, then grab real lock", have a single function for both,
> > similar to htab_lock_bucket().  and keep irqs and preemption off from
> > the moment you start attempting the overall lock until you completely
> > unlock.
>
> +1.
>
> >
> > barret
> >


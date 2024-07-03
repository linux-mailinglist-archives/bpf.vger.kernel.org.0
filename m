Return-Path: <bpf+bounces-33785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556109266DD
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D6F1C21F01
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049751849C3;
	Wed,  3 Jul 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBqEiI6P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765017995;
	Wed,  3 Jul 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026804; cv=none; b=Qk5717cBhNZun2+I9oi/Sgk9K++RezBjhQcHbpEsRKWxf+R7dxGtxRnBHlkgU5CVZv/TFJO2205xPNnwU08MH2zxIMqDNe86P9GjdvoR7I7i/NrnZQ65laZR1yIC4MMdhinzuewG7sI9Ovne36mJUOJ5mJar13AURFtD0reyEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026804; c=relaxed/simple;
	bh=ISzui4R/Km/FDb0ityz7LPKRM2w30x7VIMspLIJHuog=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKdAoIRxAFPChrfzvgKaNcgdvl2ulkCtbaSV1qP5WjYYWWL+cVKE8fYJWS1bV12cysogCnEksiHGXHX8zCvBy3KyQGCeW8eqiw0ak94jjqZ5A6tm2qAK3UZYhKf4Yp5cC+0DW8/wKB18HnaGv8YRmqqn7TSXLpfMtWdnaBZngFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBqEiI6P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so253723e87.0;
        Wed, 03 Jul 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026801; x=1720631601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uAhswp00lWlrzkNkALLwiEbV8YVx+xJUkbbnbn4k34=;
        b=TBqEiI6PymU7r9KF+qBD0NQ53Ct67ntgudSu9e9pd2ZLBgGNk/Z9SqvUWvtAKyz5hG
         POYLULmI6YTjY5gfYt9HS0JCqGawztc64bWYo9R5ey/fDGuSe/WDUrP4naNhGkPyQ1tr
         JG6Nz2YU1+4jUgkq3tj5zV+rc5wBe9GUkH85JdxsqaO71gu0ugg0GNyn4PFJamuqvHd3
         MxPeP6zXsOeBQ2nd2M8a6MuK5cZBI8KDM+LzTg2DnLeVwwYqS37GHXdu21GPmxjwTSCg
         +ETFsJeHzVoGsHHs0PPCMPJ33R3G+9ZFoqI3Fme7VbL1dmFIFPFkJq4VvlV3+FrqWOoU
         Az/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026801; x=1720631601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uAhswp00lWlrzkNkALLwiEbV8YVx+xJUkbbnbn4k34=;
        b=eeV/adlGnBESXKR3fjVnzinupTVsHJ2diO/AGJxmA7J+juhW8RHmKi79daP/EZgxJu
         TOKE0CxmgAZQ3Oey/WyEQ+EUPT731JC28om/iVepXunxOzWk3zaYmEaKAM5zGbBsTVhr
         V+6X3KAOd7MX2Fv6mfrVAMjxw5Qo6xxxQMjTqWDuo6GRjA9GbGrLPw+UEssdjJ6oJPfb
         mX/A+wFXtn1a+GUpqWpaQ7XqaCvqyggJudrDTQk3YYdwy4MlZDZ7NF38iN8IGOXhissR
         a98fTwLdYX9RU0Bl0OR+0O/jKhON54aVA9BnH2EN6XW8Ez+xu5OD9GWM+vndmV8CSR5m
         TH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGLCb17/I980F0x769EeZUDJmTfE+sdZPps2a64+Z2gtC4P3NJEtSJceJE7mAIL2+JwsQqydoD7EGYv4WYMDMvlGYRIZHj4VTKUoTxkQmm4CQ8Ct8ZjT3NI1pOobYlPN1u6y7tnLpf2d5/duL0wgBPbGIcM25BcA9tyMp7tlo9caVdVKAC
X-Gm-Message-State: AOJu0YxRzWeBUhkIAYWe5Y847xKhMgERknKLI/ydmicyeNToHYw3qjCf
	/LiRpgiz8nI5V0ue2Zr2rjNcaL4ZknfpTIkUshCeT7LrzFMe22Yx
X-Google-Smtp-Source: AGHT+IGIInkOERvCZYZe7mspAqGChKzLNzlmL6F5LdttmkH5c+Br3xT/bWqASJ+XKQibiMhnxe+/aA==
X-Received: by 2002:a05:6512:3d08:b0:52c:dcd4:8953 with SMTP id 2adb3069b0e04-52e8268884amr9759025e87.36.1720026800609;
        Wed, 03 Jul 2024 10:13:20 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm253568985e9.9.2024.07.03.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:13:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 19:13:16 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <ZoWGrGYdyaimB_zF@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>

On Tue, Jul 02, 2024 at 01:51:28PM -0700, Andrii Nakryiko wrote:

SNIP

> >  #ifdef CONFIG_UPROBES
> > @@ -80,6 +83,12 @@ struct uprobe_task {
> >         unsigned int                    depth;
> >  };
> >
> > +struct session_consumer {
> > +       __u64           cookie;
> > +       unsigned int    id;
> > +       int             rc;
> 
> you'll be using u64 for ID, right? so this struct will be 24 bytes.

yes

> Maybe we can just use topmost bit of ID to store whether uretprobe
> should run or not? It's trivial to mask out during ID comparisons

actually.. I think we could store just consumers that need to be
executed in return probe so there will be no need for 'rc' value

> 
> > +};
> > +
> >  struct return_instance {
> >         struct uprobe           *uprobe;
> >         unsigned long           func;
> > @@ -88,6 +97,9 @@ struct return_instance {
> >         bool                    chained;        /* true, if instance is nested */
> >
> >         struct return_instance  *next;          /* keep as stack */
> > +
> > +       int                     sessions_cnt;
> 
> there is 7 byte gap before next field, let's put sessions_cnt there

ok

> 
> > +       struct session_consumer sessions[];
> >  };
> >
> >  enum rp_check {
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 2c83ba776fc7..4da410460f2a 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -63,6 +63,8 @@ struct uprobe {
> >         loff_t                  ref_ctr_offset;
> >         unsigned long           flags;
> >
> > +       unsigned int            sessions_cnt;
> > +
> >         /*
> >          * The generic code assumes that it has two members of unknown type
> >          * owned by the arch-specific code:
> > @@ -750,11 +752,30 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> >         return uprobe;
> >  }
> >
> > +static void
> > +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > +{
> > +       static unsigned int session_id;
> 
> (besides what Peter mentioned about wrap around of 32-bit counter)
> let's use atomic here to not rely on any particular locking
> (unnecessarily), this might make my life easier in the future, thanks.
> This is registration time, low frequency, extra atomic won't hurt.
> 
> It might be already broken, actually, for two independently registering uprobes.

ok, will try

> 
> > +
> > +       if (uc->session) {
> > +               uprobe->sessions_cnt++;
> > +               uc->session_id = ++session_id ?: ++session_id;
> > +       }
> > +}
> > +
> > +static void
> > +uprobe_consumer_unaccount(struct uprobe *uprobe, struct uprobe_consumer *uc)
> 
> this fits in 100 characters, keep it single line, please. Same for
> account function

ok

> 
> > +{
> > +       if (uc->session)
> > +               uprobe->sessions_cnt--;
> > +}
> > +
> >  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >  {
> >         down_write(&uprobe->consumer_rwsem);
> >         uc->next = uprobe->consumers;
> >         uprobe->consumers = uc;
> > +       uprobe_consumer_account(uprobe, uc);
> >         up_write(&uprobe->consumer_rwsem);
> >  }
> >
> > @@ -773,6 +794,7 @@ static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >                 if (*con == uc) {
> >                         *con = uc->next;
> >                         ret = true;
> > +                       uprobe_consumer_unaccount(uprobe, uc);
> >                         break;
> >                 }
> >         }
> > @@ -1744,6 +1766,23 @@ static struct uprobe_task *get_utask(void)
> >         return current->utask;
> >  }
> >
> > +static size_t ri_size(int sessions_cnt)
> > +{
> > +       struct return_instance *ri __maybe_unused;
> > +
> > +       return sizeof(*ri) + sessions_cnt * sizeof(ri->sessions[0]);
> 
> just use struct_size()?
> 
> > +}
> > +
> > +static struct return_instance *alloc_return_instance(int sessions_cnt)
> > +{
> > +       struct return_instance *ri;
> > +
> > +       ri = kzalloc(ri_size(sessions_cnt), GFP_KERNEL);
> > +       if (ri)
> > +               ri->sessions_cnt = sessions_cnt;
> > +       return ri;
> > +}
> > +
> >  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >  {
> >         struct uprobe_task *n_utask;
> > @@ -1756,11 +1795,11 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >
> >         p = &n_utask->return_instances;
> >         for (o = o_utask->return_instances; o; o = o->next) {
> > -               n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
> > +               n = alloc_return_instance(o->sessions_cnt);
> >                 if (!n)
> >                         return -ENOMEM;
> >
> > -               *n = *o;
> > +               memcpy(n, o, ri_size(o->sessions_cnt));
> >                 get_uprobe(n->uprobe);
> >                 n->next = NULL;
> >
> > @@ -1853,9 +1892,9 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
> >         utask->return_instances = ri;
> >  }
> >
> > -static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> > +static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
> > +                             struct return_instance *ri)
> >  {
> > -       struct return_instance *ri;
> >         struct uprobe_task *utask;
> >         unsigned long orig_ret_vaddr, trampoline_vaddr;
> >         bool chained;
> > @@ -1874,9 +1913,11 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> >                 return;
> >         }
> >
> > -       ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
> > -       if (!ri)
> > -               return;
> > +       if (!ri) {
> > +               ri = alloc_return_instance(0);
> > +               if (!ri)
> > +                       return;
> > +       }
> >
> >         trampoline_vaddr = get_trampoline_vaddr();
> >         orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
> > @@ -2065,35 +2106,85 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
> >         return uprobe;
> >  }
> >
> > +static struct session_consumer *
> > +session_consumer_next(struct return_instance *ri, struct session_consumer *sc,
> > +                     int session_id)
> > +{
> > +       struct session_consumer *next;
> > +
> > +       next = sc ? sc + 1 : &ri->sessions[0];
> > +       next->id = session_id;
> 
> it's kind of unexpected that "session_consumer_next" would actually
> set an ID... Maybe drop int session_id as input argument and fill it
> out outside of this function, this function being just a simple
> iterator?

yea, I was going back and forth on what to have in that function
or not, to keep the change minimal, but makes sense, will move

> 
> > +       return next;
> > +}
> > +
> > +static struct session_consumer *
> > +session_consumer_find(struct return_instance *ri, int *iter, int session_id)
> > +{
> > +       struct session_consumer *sc;
> > +       int idx = *iter;
> > +
> > +       for (sc = &ri->sessions[idx]; idx < ri->sessions_cnt; idx++, sc++) {
> > +               if (sc->id == session_id) {
> > +                       *iter = idx + 1;
> > +                       return sc;
> > +               }
> > +       }
> > +       return NULL;
> > +}
> > +
> >  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  {
> >         struct uprobe_consumer *uc;
> >         int remove = UPROBE_HANDLER_REMOVE;
> > +       struct session_consumer *sc = NULL;
> > +       struct return_instance *ri = NULL;
> >         bool need_prep = false; /* prepare return uprobe, when needed */
> >
> >         down_read(&uprobe->register_rwsem);
> > +       if (uprobe->sessions_cnt) {
> > +               ri = alloc_return_instance(uprobe->sessions_cnt);
> > +               if (!ri)
> > +                       goto out;
> > +       }
> > +
> >         for (uc = uprobe->consumers; uc; uc = uc->next) {
> > +               __u64 *cookie = NULL;
> >                 int rc = 0;
> >
> > +               if (uc->session) {
> > +                       sc = session_consumer_next(ri, sc, uc->session_id);
> > +                       cookie = &sc->cookie;
> > +               }
> > +
> >                 if (uc->handler) {
> > -                       rc = uc->handler(uc, regs);
> > +                       rc = uc->handler(uc, regs, cookie);
> >                         WARN(rc & ~UPROBE_HANDLER_MASK,
> >                                 "bad rc=0x%x from %ps()\n", rc, uc->handler);
> >                 }
> >
> > -               if (uc->ret_handler)
> > +               if (uc->session) {
> > +                       sc->rc = rc;
> > +                       need_prep |= !rc;
> 
> nit:
> 
> if (rc == 0)
>     need_prep = true;
> 
> and then it's *extremely obvious* what happens and under which conditions

ok

> 
> > +               } else if (uc->ret_handler) {
> >                         need_prep = true;
> > +               }
> >
> >                 remove &= rc;
> >         }
> >
> > +       /* no removal if there's at least one session consumer */
> > +       remove &= !uprobe->sessions_cnt;
> 
> this is counter (not error, not pointer), let's stick to ` == 0`, please
> 
> is this
> 
> if (uprobe->sessions_cnt != 0)
>    remove = 0;

yes ;-) will change

jirka

> 
> ? I can't tell (honestly), without spending ridiculous amounts of
> mental resources (for the underlying simplicity of the condition).

SNIP


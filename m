Return-Path: <bpf+bounces-34699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C6C930196
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B34CB23AC6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57E4AEDA;
	Fri, 12 Jul 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6xbqbEw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDB49634;
	Fri, 12 Jul 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819707; cv=none; b=q9vwDk4P1s45pIpv5HDfV6Y2Hi7dB3/iwyj010ngv01nuQlb8Q+5bZJp/NEqq/JpuA9Jdvbm+4GdZjIO/Nolly+wrMy8QN98+Uf9ILoDiDd/ih6LUw0pEwEn/OVttgwwiDsGOnsbbpO/SWLh/hEyA6qG/I/pxgu9a0k4TVtZs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819707; c=relaxed/simple;
	bh=lHwGeAKM0jsTKFbu/AtfPPmHTB9uFDXbNFkTbch5BXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyzDjqHve10CRGyXT3qKbmuPheVDeB7Muui7XKnMWeO+WOgBKcLHZYAq3KGwJy0DeoZ6YzuganeNBNwek1MutXm3rP+tJJ6jQLjycZrj9u5dRC9WqUrzkScz/fuVYX4Yj3Vcj2e6zJBfXx7bhFY5gFXxV26tGHLcGG6zvt+w7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6xbqbEw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso1857077a12.1;
        Fri, 12 Jul 2024 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720819705; x=1721424505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9pjFtLIZhu06DdBsjlmTJj0Bz96mDe+BpetLpyO+Sc=;
        b=B6xbqbEwmy8CFmwHJ58zBsdi0HpbREcRAVSbGTUUyrdWjSqPlAflJR+CL454CqVKCW
         MlCm/bfqhcCBPSUSB5GdjCtl1SUqLZ/YeCOkD2IITV5cSOy6/E42wgPc/F5IWd1l4kiW
         vBYvZLJ4uQOHEhJITa1H6PMuFWup7BmKd8gzLbGrJ7fA+eAv5VMe1EqK1OpcU5bncrr/
         gfovDUMudtAoTKFcanTLKzbRUYwlKYI5x0R1MwykZNhDz17Hl+tn52NpPMsrHdsG9Wep
         XdO8GIPy8LxbmqXZDXQrceU54APwNVWkbo5awv/7m6l8pUtE4kRBhWDmwAV6oLQUUgKr
         0Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720819705; x=1721424505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9pjFtLIZhu06DdBsjlmTJj0Bz96mDe+BpetLpyO+Sc=;
        b=pNUP4KMidxCsE+rI8fLsjaKzqG7V3hz/0wkziAW2DmsfOqgDTBs/MJnlGcZcMowlFj
         F7yZ68KbJGJPA4oBS3aDFsuDBRe6dkM5tLXqqvEsrOjEZh39xb/R3btOqEqy7PPxWSZf
         awDUkpoiUq1+dvGfxExWZek1dhYVbIp45FLpvXIpzEcHVrR23dqAQ5PcS98zr4A+gs/U
         sCP7rRMnfmplkHodPk4mSL45dzgRby2QH5Tbbb20zMApMhUFJP0OEJpTTObmbexSewvg
         n9Tiz5KyWKD8wpdUUXgjEllXEWFJdM1Hr2TK8008GYCutk7L0V77t/psTr0Wop/LZPsg
         1yuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYt8skmxkJU3Kd16AN77AsFU770WLwhe+65Ms/yD5NhfYR6WXFO9rsniwCornRUOo2H8WBrwLGJ9ZpgSCexrZGVVALO+6m2BQTGZNRcXhcbOXG9EbRsqXuWzqSdZZstl+bW1M3T3cQQJ0lqxkB0em2dE7RMIAnt4m6X96SNzFLpcpvNjPm
X-Gm-Message-State: AOJu0YxH/ZFVUE8ktu+33b78UpAsbanz3S8rRHAL+TGJfEZZjMPflrhn
	FGiD8/l6Z2BMrJ8U6Pd3KPSNDHSYhrJLYlRI6SWXruCi7UCb/7ftgA7O0Sd6Evfj6M/BDZVNxCt
	vOpmfaUUG+eMr3AYjahoaX6MQusE=
X-Google-Smtp-Source: AGHT+IEsMX1uEfY5runz63h4lW6mEY9Jy+R+/Lak8T+hnNS2AjxA9XMigPz1WxRGXcPtwHpGPkHrOcjS/KJJxMaSeZM=
X-Received: by 2002:a17:90b:3786:b0:2c9:79d3:a15d with SMTP id
 98e67ed59e1d1-2ca35c7bfb0mr10800565a91.29.1720819705183; Fri, 12 Jul 2024
 14:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110401.311168524@infradead.org>
In-Reply-To: <20240711110401.311168524@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 14:28:13 -0700
Message-ID: <CAEf4BzZW56pgTqy4POud8P3t5gtdg53BX83VbieixtS1T-mg2w@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe
 to SRCU
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf

On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Both single-step and uretprobes take a refcount on struct uprobe in
> handle_swbp() in order to ensure struct uprobe stays extant until a
> next trap.
>
> Since uprobe_unregister() only cares about the uprobe_consumer
> life-time, and these intra-trap sections can be arbitrarily large,
> create a second SRCU domain to cover these.
>
> Notably, a uretprobe with a registered return_instance that never
> triggers -- because userspace -- will currently pin the
> return_instance and related uprobe until the task dies. With this
> convertion to SRCU this behaviour will inhibit freeing of all uprobes.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/uprobes.h |    2 +
>  kernel/events/uprobes.c |   60 +++++++++++++++++++++++------------------=
-------
>  2 files changed, 31 insertions(+), 31 deletions(-)
>
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -78,6 +78,7 @@ struct uprobe_task {
>
>         struct return_instance          *return_instances;
>         unsigned int                    depth;
> +       unsigned int                    active_srcu_idx;
>  };
>
>  struct return_instance {
> @@ -86,6 +87,7 @@ struct return_instance {
>         unsigned long           stack;          /* stack pointer */
>         unsigned long           orig_ret_vaddr; /* original return addres=
s */
>         bool                    chained;        /* true, if instance is n=
ested */
> +       int                     srcu_idx;
>
>         struct return_instance  *next;          /* keep as stack */
>  };
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -54,6 +54,15 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem)
>   * Covers uprobe->consumers lifetime as well as struct uprobe.
>   */
>  DEFINE_STATIC_SRCU(uprobes_srcu);
> +/*
> + * Covers return_instance->uprobe and utask->active_uprobe. Separate fro=
m
> + * uprobe_srcu because uprobe_unregister() doesn't need to wait for this
> + * and these lifetimes can be fairly long.
> + *
> + * Notably, these sections span userspace and as such use
> + * __srcu_read_{,un}lock() to elide lockdep.
> + */
> +DEFINE_STATIC_SRCU(uretprobes_srcu);
>
>  /* Have a copy of original instruction */
>  #define UPROBE_COPY_INSN       0
> @@ -596,25 +605,24 @@ set_orig_insn(struct arch_uprobe *auprob
>                         *(uprobe_opcode_t *)&auprobe->insn);
>  }
>
> -static struct uprobe *try_get_uprobe(struct uprobe *uprobe)
> -{
> -       if (refcount_inc_not_zero(&uprobe->ref))
> -               return uprobe;
> -       return NULL;
> -}
> -
>  static struct uprobe *get_uprobe(struct uprobe *uprobe)
>  {
>         refcount_inc(&uprobe->ref);
>         return uprobe;
>  }
>
> -static void uprobe_free_rcu(struct rcu_head *rcu)
> +static void uprobe_free_stage2(struct rcu_head *rcu)
>  {
>         struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
>         kfree(uprobe);
>  }
>
> +static void uprobe_free_stage1(struct rcu_head *rcu)
> +{
> +       struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
> +       call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_stage2);
> +}
> +
>  static void put_uprobe(struct uprobe *uprobe)
>  {
>         if (refcount_dec_and_test(&uprobe->ref)) {
> @@ -626,7 +634,7 @@ static void put_uprobe(struct uprobe *up
>                 mutex_lock(&delayed_uprobe_lock);
>                 delayed_uprobe_remove(uprobe, NULL);
>                 mutex_unlock(&delayed_uprobe_lock);
> -               call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
> +               call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_stage1=
);
>         }
>  }
>
> @@ -1753,7 +1761,7 @@ unsigned long uprobe_get_trap_addr(struc
>  static struct return_instance *free_ret_instance(struct return_instance =
*ri)
>  {
>         struct return_instance *next =3D ri->next;
> -       put_uprobe(ri->uprobe);
> +       __srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
>         kfree(ri);
>         return next;
>  }
> @@ -1771,7 +1779,7 @@ void uprobe_free_utask(struct task_struc
>                 return;
>
>         if (utask->active_uprobe)
> -               put_uprobe(utask->active_uprobe);
> +               __srcu_read_unlock(&uretprobes_srcu, utask->active_srcu_i=
dx);
>
>         ri =3D utask->return_instances;
>         while (ri)
> @@ -1814,7 +1822,7 @@ static int dup_utask(struct task_struct
>                         return -ENOMEM;
>
>                 *n =3D *o;
> -               get_uprobe(n->uprobe);
> +               __srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);

do we need to add this __srcu_clone_read_lock hack just to avoid
taking a refcount in dup_utask (i.e., on process fork)? This is not
that frequent and performance-sensitive case, so it seems like it
should be fine to take refcount and avoid doing srcu_read_unlock() in
a new process. Just like the case with long-running uretprobes where
you convert SRCU lock into refcount.

>                 n->next =3D NULL;
>
>                 *p =3D n;
> @@ -1931,14 +1939,10 @@ static void prepare_uretprobe(struct upr
>         if (!ri)
>                 return;
>
> -       ri->uprobe =3D try_get_uprobe(uprobe);
> -       if (!ri->uprobe)
> -               goto err_mem;
> -
>         trampoline_vaddr =3D get_trampoline_vaddr();
>         orig_ret_vaddr =3D arch_uretprobe_hijack_return_addr(trampoline_v=
addr, regs);
>         if (orig_ret_vaddr =3D=3D -1)
> -               goto err_uprobe;
> +               goto err_mem;
>
>         /* drop the entries invalidated by longjmp() */
>         chained =3D (orig_ret_vaddr =3D=3D trampoline_vaddr);
> @@ -1956,11 +1960,13 @@ static void prepare_uretprobe(struct upr
>                          * attack from user-space.
>                          */
>                         uprobe_warn(current, "handle tail call");
> -                       goto err_uprobe;
> +                       goto err_mem;
>                 }
>                 orig_ret_vaddr =3D utask->return_instances->orig_ret_vadd=
r;
>         }
>
> +       ri->srcu_idx =3D __srcu_read_lock(&uretprobes_srcu);
> +       ri->uprobe =3D uprobe;
>         ri->func =3D instruction_pointer(regs);
>         ri->stack =3D user_stack_pointer(regs);
>         ri->orig_ret_vaddr =3D orig_ret_vaddr;
> @@ -1972,8 +1978,6 @@ static void prepare_uretprobe(struct upr
>
>         return;
>
> -err_uprobe:
> -       uprobe_put(ri->uprobe);
>  err_mem:
>         kfree(ri);
>  }
> @@ -1990,15 +1994,9 @@ pre_ssout(struct uprobe *uprobe, struct
>         if (!utask)
>                 return -ENOMEM;
>
> -       utask->active_uprobe =3D try_get_uprobe(uprobe);
> -       if (!utask->active_uprobe)
> -               return -ESRCH;
> -
>         xol_vaddr =3D xol_get_insn_slot(uprobe);
> -       if (!xol_vaddr) {
> -               err =3D -ENOMEM;
> -               goto err_uprobe;
> -       }
> +       if (!xol_vaddr)
> +               return -ENOMEM;
>
>         utask->xol_vaddr =3D xol_vaddr;
>         utask->vaddr =3D bp_vaddr;
> @@ -2007,13 +2005,13 @@ pre_ssout(struct uprobe *uprobe, struct
>         if (unlikely(err))
>                 goto err_xol;
>
> +       utask->active_srcu_idx =3D __srcu_read_lock(&uretprobes_srcu);
> +       utask->active_uprobe =3D uprobe;
>         utask->state =3D UTASK_SSTEP;
>         return 0;
>
>  err_xol:
>         xol_free_insn_slot(current);
> -err_uprobe:
> -       put_uprobe(utask->active_uprobe);
>         return err;
>  }
>
> @@ -2366,7 +2364,7 @@ static void handle_singlestep(struct upr
>         else
>                 WARN_ON_ONCE(1);
>
> -       put_uprobe(uprobe);
> +       __srcu_read_unlock(&uretprobes_srcu, utask->active_srcu_idx);
>         utask->active_uprobe =3D NULL;
>         utask->state =3D UTASK_RUNNING;
>         xol_free_insn_slot(current);
>
>


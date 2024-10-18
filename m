Return-Path: <bpf+bounces-42457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E19A45C8
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4D91F24BE5
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86C208D9E;
	Fri, 18 Oct 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+5AuMFE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E049208983;
	Fri, 18 Oct 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275737; cv=none; b=MStIJ9iVnTBImbAWjt4kWdJLn17d6X/0mIy0AwjYd21elRMF+xi4q+mp02SPsuDG2oGdw5aUz1emalYUE88xOWtSCISM11idg61u+U6boCkEfItGKqGbl3I7kySx26h7+TyVZ+lgGiLpYL4POIsaCTJa90BPdf5+7ItjDs3M0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275737; c=relaxed/simple;
	bh=xEsQ6C7sDwT1xSNrzTyJArqfAtWkDfrhY9mcFXWxDOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOgfwOuCv5ksF4zuh2z4hju30ZhABJQ0jPHtdRTk4TLXJ6YFbCDbk7S84PQU56N8JUxo9atHnf9gh8+gvNN+SEc869cb783hYYKcIW30KZInN0buR+5oIEAEPFfPxEsApsi73JRTC0moMflvpnm06qRMrbfkI+r2MiUctVPyHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+5AuMFE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2224719a12.0;
        Fri, 18 Oct 2024 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729275734; x=1729880534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szlpOYbQpLKnuUX8XB/uf3D+PzZu7s18p1D68tVqpeI=;
        b=W+5AuMFE+XIeoeukkIsduuVratUi7PsiEploXXSvqoVTC9QChukd0ne1KMo4t9Wg+E
         Vq29I2Bh/Gh+XPyZQMWo2QZ0T7CT0qcNg1py1b2UczE39TgZvAW9+5DzYbt88TgEPJ1K
         8tC3HHpdB3zbebQ4qUvFxsQfGkRrb01+0GHMXV5jfiJMCrdEAs3+0ACmJ2RJzjbVH2CL
         Gzl/7X4Cd7WUltGqa2ZMvmtuO5s8u9EyAcXAQ8VPO0WUsNr7rqEq4NNEETnI6dSlpt4+
         AlpDNb4HopSvAxxAHAs1JnfBFAEtyXeELSt0CpJCUueL+jRRgwckQ/Mse43C7zlbeYyX
         Rbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275734; x=1729880534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szlpOYbQpLKnuUX8XB/uf3D+PzZu7s18p1D68tVqpeI=;
        b=EDE+oZn7G9wRF3OEe9cHummlrMB8ZI+a1YlsC8LFKbNi56lzE8Q4dGUtlOAv5Mt7x3
         f/1CLg/WCFYcpXZrVe3r2mUMp1VlwuDyI93eLHE3J5Dt97ZvjuT6Kg0XexMqxKdQhWJ7
         8O7YjZXZSnQrGl/8Vty75u0tn5rahUEHWmbVt2f3+sGEunGXazyLRLULNEGT9uDZhUPz
         ydRxqAgG3fA7X57BuE5MN8wGah+3hyukzVG4vfndoEx81ZALS9vjwmtcUdibDSKHP13m
         o10axk2CqifufQAvAw+ts6tb68Y/VDZjdDywhyQczibM5zBsPWapGbX/5KPg1JUzd18J
         a4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLiKo63geon7kubSGbqCcUCfrEVREJaE06nxJLqenP9tiZFV9VW8HWN9PHHoeQ8K7/caM=@vger.kernel.org, AJvYcCWUQ0GALApiqZ9U+whFB0ESy0GCZvd7XcGewKdBHPrgzWKOJXeAjVqxL2DkZnN5QAN/1tOA7L+Ilnf74jvB@vger.kernel.org, AJvYcCWd5UI+7FM/qh9mp1uW+oqkYa1J3GOoSuow2XTA5iznJdwK7tZD5Z1305qMJPFkUCNksp9V/ZBPiXoQMUrzkOH1QKZd@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1rY/o14u7UnXvT5flYkGHizBGvFXdjJw0W0KezwUvdp7hklb
	xgeRrJOb1k56+V0dTFBHqImTn6u9+AI1T1yydUJMU+dQ1RlKOBvc61GEf/fpkhHoUMzNr0RN5nF
	yr8v3iq/vZ1qq/BiWV/HqmBAa7T/rs42j
X-Google-Smtp-Source: AGHT+IFq+r8vQIWblVMtI2Uzay+Y6h/gUXSeCY1ZG4DppGwL3dp5HBc3n2goO/ortNvz18nkx8sM4k+tCyvLE+El3jY=
X-Received: by 2002:a05:6a21:31c8:b0:1d4:becc:6eeb with SMTP id
 adf61e73a8af0-1d92c5990femr4311881637.31.1729275733967; Fri, 18 Oct 2024
 11:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008002556.2332835-1-andrii@kernel.org> <20241008002556.2332835-2-andrii@kernel.org>
 <20241018082605.GD17263@noisy.programming.kicks-ass.net>
In-Reply-To: <20241018082605.GD17263@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 18 Oct 2024 11:22:00 -0700
Message-ID: <CAEf4Bzb3xjTH7Qh8c_j95jEr4fNxBgG11a0sCe4hoF9chwUtYg@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 1/2] uprobes: allow put_uprobe() from
 non-sleepable softirq context
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 07, 2024 at 05:25:55PM -0700, Andrii Nakryiko wrote:
> > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> > makes it unsuitable to be called from more restricted context like soft=
irq.
>
> This is delayed_uprobe_lock, right?

Not just delated_uprobe_lock, there is also uprobes_treelock (I forgot
to update the commit message to mention that). Oleg had concerns (see
[0]) with that being taken from the timer thread, so I just moved all
of the locking into deferred work callback.

  [0] https://lore.kernel.org/linux-trace-kernel/20240915144910.GA27726@red=
hat.com/

>
> So can't we do something like so instead?

I'll need to look at this more thoroughly (and hopefully Oleg will get
a chance as well), dropping lock from delayed_ref_ctr_inc() is a bit
scary, but might be ok.

But generally speaking, what's your concern with doing deferred work
in put_uprobe()? It's not a hot path by any means, worst case we'll
have maybe thousands of uprobes attached/detached.

>
> ---
>  kernel/events/uprobes.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2a0059464383..d17a9046de35 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -83,9 +83,11 @@ struct delayed_uprobe {
>         struct list_head list;
>         struct uprobe *uprobe;
>         struct mm_struct *mm;
> +       struct rcu_head rcu;
>  };
>
> -static DEFINE_MUTEX(delayed_uprobe_lock);
> +/* XXX global state; use per mm list instead ? */
> +static DEFINE_SPINLOCK(delayed_uprobe_lock);
>  static LIST_HEAD(delayed_uprobe_list);
>
>  /*
> @@ -289,9 +291,11 @@ delayed_uprobe_check(struct uprobe *uprobe, struct m=
m_struct *mm)
>  {
>         struct delayed_uprobe *du;
>
> -       list_for_each_entry(du, &delayed_uprobe_list, list)
> +       guard(rcu)();
> +       list_for_each_entry_rcu(du, &delayed_uprobe_list, list) {
>                 if (du->uprobe =3D=3D uprobe && du->mm =3D=3D mm)
>                         return du;
> +       }
>         return NULL;
>  }
>
> @@ -308,7 +312,8 @@ static int delayed_uprobe_add(struct uprobe *uprobe, =
struct mm_struct *mm)
>
>         du->uprobe =3D uprobe;
>         du->mm =3D mm;
> -       list_add(&du->list, &delayed_uprobe_list);
> +       scoped_guard(spinlock, &delayed_uprobe_lock)
> +               list_add_rcu(&du->list, &delayed_uprobe_list);
>         return 0;
>  }
>
> @@ -316,19 +321,21 @@ static void delayed_uprobe_delete(struct delayed_up=
robe *du)
>  {
>         if (WARN_ON(!du))
>                 return;
> -       list_del(&du->list);
> -       kfree(du);
> +       scoped_guard(spinlock, &delayed_uprobe_lock)
> +               list_del(&du->list);
> +       kfree_rcu(du, rcu);
>  }
>
>  static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struc=
t *mm)
>  {
> -       struct list_head *pos, *q;
>         struct delayed_uprobe *du;
> +       struct list_head *pos;
>
>         if (!uprobe && !mm)
>                 return;
>
> -       list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +       guard(rcu)();
> +       list_for_each_rcu(pos, &delayed_uprobe_list) {
>                 du =3D list_entry(pos, struct delayed_uprobe, list);
>
>                 if (uprobe && du->uprobe !=3D uprobe)
> @@ -434,12 +441,10 @@ static int update_ref_ctr(struct uprobe *uprobe, st=
ruct mm_struct *mm,
>                         return ret;
>         }
>
> -       mutex_lock(&delayed_uprobe_lock);
>         if (d > 0)
>                 ret =3D delayed_uprobe_add(uprobe, mm);
>         else
>                 delayed_uprobe_remove(uprobe, mm);
> -       mutex_unlock(&delayed_uprobe_lock);
>
>         return ret;
>  }
> @@ -645,9 +650,7 @@ static void put_uprobe(struct uprobe *uprobe)
>          * gets called, we don't get a chance to remove uprobe from
>          * delayed_uprobe_list from remove_breakpoint(). Do it here.
>          */
> -       mutex_lock(&delayed_uprobe_lock);
>         delayed_uprobe_remove(uprobe, NULL);
> -       mutex_unlock(&delayed_uprobe_lock);
>
>         call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
>  }
> @@ -1350,13 +1353,18 @@ static void build_probe_list(struct inode *inode,
>  /* @vma contains reference counter, not the probed instruction. */
>  static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
>  {
> -       struct list_head *pos, *q;
>         struct delayed_uprobe *du;
> +       struct list_head *pos;
>         unsigned long vaddr;
>         int ret =3D 0, err =3D 0;
>
> -       mutex_lock(&delayed_uprobe_lock);
> -       list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +       /*
> +        * delayed_uprobe_list is added to when the ref_ctr is not mapped
> +        * and is consulted (this function) when adding maps. And since
> +        * mmap_lock serializes these, it is not possible miss an entry.
> +        */
> +       guard(rcu)();
> +       list_for_each_rcu(pos, &delayed_uprobe_list) {
>                 du =3D list_entry(pos, struct delayed_uprobe, list);
>
>                 if (du->mm !=3D vma->vm_mm ||
> @@ -1370,9 +1378,9 @@ static int delayed_ref_ctr_inc(struct vm_area_struc=
t *vma)
>                         if (!err)
>                                 err =3D ret;
>                 }
> +
>                 delayed_uprobe_delete(du);
>         }
> -       mutex_unlock(&delayed_uprobe_lock);
>         return err;
>  }
>
> @@ -1596,9 +1604,7 @@ void uprobe_clear_state(struct mm_struct *mm)
>  {
>         struct xol_area *area =3D mm->uprobes_state.xol_area;
>
> -       mutex_lock(&delayed_uprobe_lock);
>         delayed_uprobe_remove(NULL, mm);
> -       mutex_unlock(&delayed_uprobe_lock);
>
>         if (!area)
>                 return;


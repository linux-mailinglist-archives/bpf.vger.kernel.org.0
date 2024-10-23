Return-Path: <bpf+bounces-42904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534499ACE60
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F647282D90
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D781AC448;
	Wed, 23 Oct 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFcnvSKz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57419DFB5;
	Wed, 23 Oct 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696464; cv=none; b=CGRyc76EAVRW0PED5q6UKNss6Bx4q2OFJVQpmqYD/vVoiSxVPCRBk09fsPWj2X+bTQZUg+IOWBdUp1ZCN7sjjsMb7T/aDChoIB3+S86G2VYII+TbwUnS6Xtjb0znxILLV7Ti6omRi0h+UCOk3SQ6mzlbpUfE6/JDkwf3TnqFMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696464; c=relaxed/simple;
	bh=bspjLlEbCik1ob2m01nvM6sPs33CEmOqvTfcPaEDQD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A27iBjaOsgHrub6/EqEqZV5lhR15a+fS9OneUHYWXt0obqz2jxXqkdfb32h/s1U+jNUFLqqIu4ZtxVhm2NBR+TZeH1KtKOuh2wCMzfg+jrZFZnwtQmDGS83x9VEwjT6B7/OsSAWAIYkEM9SyRKpwC3j3qrRDiUjdQasPHmKCJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFcnvSKz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so65035245e9.1;
        Wed, 23 Oct 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729696461; x=1730301261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d42TPA0cMzHWK542S6EtIXLU+A1yIxGyFcYUpqKn4fs=;
        b=KFcnvSKzTLzKEOrSnHzOqfZFhqBkgyLEQDkf5iNS0sg6rvraNLwZnJb4eg/0oS2wEf
         x9BdlIbBHiDgImB6VgCX8rQnGAR7uhU5kOX9k7y8dTtpfo7IN+6j7P8GKXGR4JHSRu1H
         FDFPP/4MCwPD6aLoZqzIhdlWiiLzuHtmiflGQg6NH44O/7oATCHRZXGqK4aF9JCJRqlZ
         jnc0fS5NL0TrVmwwylMBBmi35BgQxoO10bWC62CLdehcOz1tBtG8jPMaeYmPOqy8W7Yy
         c/dMU2GuD2TSrvaH/4evFfFK9xW8UPqzndT/7AfJ7KNAVECVSlEzM9hVwJbLT36xjqfl
         L92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729696461; x=1730301261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d42TPA0cMzHWK542S6EtIXLU+A1yIxGyFcYUpqKn4fs=;
        b=CwSz/t9gLTJfw0PPJE6M13tGPbZdcyFX/wgGq0WJ/wv3dIOqpuOS6adUCDwi24HZWA
         52BG8VUhBGVroT1nokI17xyC7Ar3/UnNWm0P5D+9uDDGjyr4X/0SRHXhbYV6YaVhjOwM
         7EGfQO11wWNWcsR7LySnOHqfgf/00wqqoB5r3nHywviFkW3oNkqNpC0/0pTSAMFGcb2h
         W2C/Zku2VOuOoT5joAMKEULZ+zAY/sZd/bRYZXqHdf8dbK6/i1cDQ+RBqww40NswvVjR
         9a4VM6uRrApCjZpYHcXiyE7PPIStyQ8iubamIWD6AUae+HCxXgahIuTTqXxbxHCKp2lE
         RFrA==
X-Forwarded-Encrypted: i=1; AJvYcCW3KjenYKhBxgHhxqVNgsGY9BPWfT7zVxoJ9e45YgYe7VvyJrKVB/IjcYhCAIUn48ewVivmS4PgSk9lBvXs@vger.kernel.org, AJvYcCWJk2cpLpq4TfkSWPPQ/ipZadLuvt8W/6hbOFASpBmyBh5+Qfa+EExAUUMmTrcUyDaUtdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7I2EmfP+oofDJve5v5AbfiQsrSF55y7LRtzE/oHu95e5tl+N
	+yHR/Od/M2M6Zy6OyJatULprkRJP4+FJ81G88By5ETVwphWroINYFCwxwOfw+sFPwDno/XpgcUn
	dOQ99uXYRBaq73NhUhJ4bAuF2WCg=
X-Google-Smtp-Source: AGHT+IHBvvvHR6S1sInHVoaytVCpOxPUnhuvrDCsXBUlq0qKZn76mauGZ4TbD3f4S5+DKyHRJGwx9Eru/q2A+f7wrUg=
X-Received: by 2002:a05:600c:46d0:b0:431:57e5:b251 with SMTP id
 5b1f17b1804b1-4318424ea03mr26365565e9.28.1729696460711; Wed, 23 Oct 2024
 08:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com>
In-Reply-To: <20241023145640.1499722-1-jrife@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Oct 2024 08:14:09 -0700
Message-ID: <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Jordan Rife <jrife@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 7:56=E2=80=AFAM Jordan Rife <jrife@google.com> wrot=
e:
>
> Mathieu's patch alone does not seem to be enough to prevent the
> use-after-free issue reported by syzbot.
>
> Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@googl=
e.com/T/#u
>
> I reran the repro script with his patch applied to my tree and was
> still able to get the same KASAN crash to occur.
>
> In this case, when bpf_link_free is invoked it kicks off three instances
> of call_rcu*.
>
> bpf_link_free()
>   ops->release()
>      bpf_raw_tp_link_release()
>        bpf_probe_unregister()
>          tracepoint_probe_unregister()
>            tracepoint_remove_func()
>              release_probes()
>                call_rcu()               [1]
>   bpf_prog_put()
>     __bpf_prog_put()
>       bpf_prog_put_deferred()
>         __bpf_prog_put_noref()
>            call_rcu()                   [2]
>   call_rcu()                            [3]
>
> With Mathieu's patch, [1] is chained with call_rcu_tasks_trace()
> making the grace period suffiently long to safely free the probe itself.
> The callback for [2] and [3] may be invoked before the
> call_rcu_tasks_trace() grace period has elapsed leading to the link or
> program itself being freed while still in use. I was able to prevent
> any crashes with the patch below which also chains
> call_rcu_tasks_trace() and call_rcu() at [2] and [3].
>
> ---
>  kernel/bpf/syscall.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 59de664e580d..5290eccb465e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2200,6 +2200,14 @@ static void __bpf_prog_put_rcu(struct rcu_head *rc=
u)
>         bpf_prog_free(aux->prog);
>  }
>
> +static void __bpf_prog_put_tasks_trace_rcu(struct rcu_head *rcu)
> +{
> +       if (rcu_trace_implies_rcu_gp())
> +               __bpf_prog_put_rcu(rcu);
> +       else
> +               call_rcu(rcu, __bpf_prog_put_rcu);
> +}
> +
>  static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>  {
>         bpf_prog_kallsyms_del_all(prog);
> @@ -2212,10 +2220,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *=
prog, bool deferred)
>                 btf_put(prog->aux->attach_btf);
>
>         if (deferred) {
> -               if (prog->sleepable)
> -                       call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_=
put_rcu);
> -               else
> -                       call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> +               call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_task=
s_trace_rcu);
>         } else {
>                 __bpf_prog_put_rcu(&prog->aux->rcu);
>         }
> @@ -2996,24 +3001,15 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(st=
ruct rcu_head *rcu)
>  static void bpf_link_free(struct bpf_link *link)
>  {
>         const struct bpf_link_ops *ops =3D link->ops;
> -       bool sleepable =3D false;
>
>         bpf_link_free_id(link->id);
>         if (link->prog) {
> -               sleepable =3D link->prog->sleepable;
>                 /* detach BPF program, clean up used resources */
>                 ops->release(link);
>                 bpf_prog_put(link->prog);
>         }
>         if (ops->dealloc_deferred) {
> -               /* schedule BPF link deallocation; if underlying BPF prog=
ram
> -                * is sleepable, we need to first wait for RCU tasks trac=
e
> -                * sync, then go through "classic" RCU grace period
> -                */
> -               if (sleepable)
> -                       call_rcu_tasks_trace(&link->rcu, bpf_link_defer_d=
ealloc_mult_rcu_gp);
> -               else
> -                       call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_g=
p);
> +               call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_m=
ult_rcu_gp);

This patch is completely wrong.
Looks like Mathieu patch broke bpf program contract somewhere.
The tracepoint type bpf programs must be called with rcu_read_lock held.
Looks like it's not happening anymore.


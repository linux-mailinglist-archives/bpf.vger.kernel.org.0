Return-Path: <bpf+bounces-46331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4F9E7BB9
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E821887A99
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1546212FAA;
	Fri,  6 Dec 2024 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIDdRHXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AA1CBEAA
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523955; cv=none; b=FhwldhjIg1ZCeiYas5GKZPjRQMFaxFiMNdyvClU6h3kCdUhU2RCTAJXdLy40ArNVLLiGKLTDI+iblXfsznp6AEDYmeeySSr4s+LVZ+WlQmrOUw8SLsNg1a2CKz5+Se6wPqwoc+gRZzyRVRuQuTjm8ohu8PqjF7/CoGpK+Ai0xFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523955; c=relaxed/simple;
	bh=1Fwo0G+mz8Rgqzi4ztNvShWWW3SkD0B+uK0GadEUKac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zszcc+BMcBY43TytUV7DrSZOgXKoE9XnZdvfgKjm0qqAh6ZCmqnoBg8CTOj7etzNR10FP8mTChHARomHlAoOQFd6eGvBB5igbPQlmKG2KTedV84ny4wBh5ivjr1+2HsFtKvm7YlOekEIdoFi2EmutbbezvWNZ8YGx4oTHg2Hu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIDdRHXQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso407a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 14:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733523951; x=1734128751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ibw0mzwOYA+EzgKVla/feMEiJCLA2VfI89MQ/7dNM=;
        b=UIDdRHXQ6FNhuBPWEDKdTDi8nOH3C5aRrPnPY/qdO74BQ3piTvUdMtWaKi4pH3jAe1
         IHr7iDW+z0Tb7bEoDv8Rwcril4BkiJCySEyBv0a+qQysEu6H1oWJnMsDBhixxVGpF04r
         PZtswU3KbX5ereO7sBPBUYF0Zjed+H/dnfXqsIMOEjKcrMuJgFo2n6rsDentz0dRAifa
         l8i+1FURH0qywsjLAm0vVdbOFAdqC1wFPHf9mxEz+Cu24YiDTXrV0EgxgiR/tNCGtHbr
         A935BtJ73cNCP/0CwBNN6U3p8B2X0d40CIdmIPP6d0mtrjo7Jd996Uaopl/sd2IunOGL
         w72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523951; x=1734128751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1ibw0mzwOYA+EzgKVla/feMEiJCLA2VfI89MQ/7dNM=;
        b=q7cetzYtYcD2HGPvNd5+3ooige+HPHXDwwDtW4O/vNf3pkMIfWiIyafcAOGRZbemgD
         wdX5KTm+kOdtjI9kjCE++Jpv8SkSOD5NGSd1zYlqEw+tqLFGKuRVwbkWWGWctxkeZob3
         vn3B1Ha3ibPtODLdEbWreQgw5FNTEczRch+BQjA5nrIpBb0tbf+QDaOL1v/Nc24Jjypx
         gpZsC/ZMmjeVRfJHeVFGK1yrZxS+7ETZ7JivRtO7NygzaWLRqHuIEeP5vQszxHYyrCH3
         ikYnSjC7SACCKuRGxB8Ipokb2lY1vc0bp4CmKYbjzy/kNc7rphHg3vA0hjlgdEErjmT8
         CqQw==
X-Forwarded-Encrypted: i=1; AJvYcCU4V9vVxe2wcIAVeMwEiuAxfkXpm9v60YjTQIK/rJKqsf4YVkYwAMctVN6stjKfeE8k75c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6oWZBzcNDPb8u0JRlfRWWDKPLvJrfeTAe7T0MOB3sRICkVk2M
	NbjkwI49e1zZEOEaDOrkj22jFpIVsNmy6brBd0oYkHHfaw1zv8NATDhXQLYwVgUoyI0cAnn0JtF
	ZayMXY+CmTLzkM/qKbFtg10yeNsfMc4K9mOX+
X-Gm-Gg: ASbGncsazVP1VU0yKP+yfHZWtshF9zdXoJ1JHFrV0HvxP/GK0qAol/HD3k1PFHvdF2q
	I1B4WisEigWN8AwVH6CC7yoYbSCndR/dt6nf0fB6NCvcaSLGCJEMUOjz9+00=
X-Google-Smtp-Source: AGHT+IGHQO7IlDTtHrmr+Kut7qmPrr+UDCTNqigZmKQw/bnbO/ORPn5+jQhaPBeJv/Cif8WX01NTzcK0mkM4k6xUdU0=
X-Received: by 2002:a50:ef0f:0:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d3daa9f7d3mr29058a12.0.1733523950627; Fri, 06 Dec 2024
 14:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com> <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Dec 2024 23:25:14 +0100
Message-ID: <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, the pointer stored in call->prog_array is loaded in
> > __uprobe_perf_func(), with no RCU annotation and no RCU protection, so =
the
> > loaded pointer can immediately be dangling. Later,
> > bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical secti=
on,
> > but this is too late. It then uses rcu_dereference_check(), but this us=
e of
> > rcu_dereference_check() does not actually dereference anything.
> >
> > It looks like the intention was to pass a pointer to the member
> > call->prog_array into bpf_prog_run_array_uprobe() and actually derefere=
nce
> > the pointer in there. Fix the issue by actually doing that.
> >
> > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) directly
> > before the might_fault() in bpf_prog_run_array_uprobe() and add an
> > include of linux/delay.h.
> >
> > Build this userspace program:
> >
> > ```
> > $ cat dummy.c
> > #include <stdio.h>
> > int main(void) {
> >   printf("hello world\n");
> > }
> > $ gcc -o dummy dummy.c
> > ```
> >
> > Then build this BPF program and load it (change the path to point to
> > the "dummy" binary you built):
> >
> > ```
> > $ cat bpf-uprobe-kern.c
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> > char _license[] SEC("license") =3D "GPL";
> >
> > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > int BPF_UPROBE(main_uprobe) {
> >   bpf_printk("main uprobe triggered\n");
> >   return 0;
> > }
> > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-kern.c
> > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoattach
> > ```
> >
> > Then run ./dummy in one terminal, and after launching it, run
> > `sudo umount uprobe-test` in another terminal. Once the 10-second
> > mdelay() is over, a use-after-free should occur, which may or may
> > not crash your kernel at the `prog->sleepable` check in
> > bpf_prog_run_array_uprobe() depending on your luck.
> > ---
> > Changes in v2:
> > - remove diff chunk in patch notes that confuses git
> > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-=
1-6869c8a17258@google.com
> > ---
> >  include/linux/bpf.h         | 4 ++--
> >  kernel/trace/trace_uprobe.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
>
> Looking at how similar in spirit bpf_prog_run_array() is meant to be
> used, it seems like it is the caller's responsibility to
> RCU-dereference array and keep RCU critical section before calling
> into bpf_prog_run_array(). So I wonder if it's best to do this instead
> (Gmail will butcher the diff, but it's about the idea):

Yeah, that's the other option I was considering. That would be more
consistent with the existing bpf_prog_run_array(), but has the
downside of unnecessarily pushing responsibility up to the caller...
I'm fine with either.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eaee2a819f4c..4b8a9edd3727 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_array *a=
rray,
>   * rcu-protected dynamically sized maps.
>   */
>  static __always_inline u32
> -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
> +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>                           const void *ctx, bpf_prog_run_fn run_prog)
>  {
>         const struct bpf_prog_array_item *item;
>         const struct bpf_prog *prog;
> -       const struct bpf_prog_array *array;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
>         u32 ret =3D 1;
>
>         might_fault();
> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held")=
;
> +
> +       if (unlikely(!array))
> +               goto out;
>
> -       rcu_read_lock_trace();
>         migrate_disable();
>
>         run_ctx.is_uprobe =3D true;
>
> -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_he=
ld());
> -       if (unlikely(!array))
> -               goto out;
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         item =3D &array->items[0];
>         while ((prog =3D READ_ONCE(item->prog))) {
> @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> bpf_prog_array __rcu *array_rcu,
>         bpf_reset_run_ctx(old_run_ctx);
>  out:
>         migrate_enable();
> -       rcu_read_unlock_trace();
>         return ret;
>  }
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index fed382b7881b..87a2b8fefa90 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace_uprobe =
*tu,
>         if (bpf_prog_array_valid(call)) {
>                 u32 ret;
>
> +               rcu_read_lock_trace();
>                 ret =3D bpf_prog_run_array_uprobe(call->prog_array,
> regs, bpf_prog_run);

But then this should be something like this (possibly split across
multiple lines with a helper variable or such):

ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->prog_array,
rcu_read_lock_trace_held()), regs, bpf_prog_run);

> +               rcu_read_unlock_trace();
>                 if (!ret)
>                         return;
>         }
>
>


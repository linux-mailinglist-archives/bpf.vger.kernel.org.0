Return-Path: <bpf+bounces-34702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8272F9301B2
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F971F23A6B
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C694F5FB;
	Fri, 12 Jul 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cild3n5D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424854AECE;
	Fri, 12 Jul 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720820646; cv=none; b=IknUSCVKbcIY9FItv/IjPKmqS5D1OEsXpT9SmSQbAFkAmTGqq6BGHzyTr7gcETk4bYbBdH+5rmq4CE5eGvCSiBT9ftZMyuyxTqvnwplS4Q1pzPKgvYySPu0tNPEqemHH5ysZCqMKLZCRJe23Bm1hjdkq4RIcO+wtj86NfHTP76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720820646; c=relaxed/simple;
	bh=kSsKQPuK7oyozBFA3sg9mWvKyLr4Thvo3hOzmz2YU0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb8C//m2ELi9MNBZ+ekPvFylV7ubLPIl0G9rHUNTsH6GJSJzhLEGHuH1/FlZLVPd4pAqYiVRfsy9BvHTKBSAXxGVEHVy1uA2iuvGtGknNI/hedhF6+UtJyvLH97IdH8jFnJ07zE7+pqZTgC8+G6pbbHnUxxLR3SYdDaW3yD3Ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cild3n5D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c96187b3d1so1870677a91.3;
        Fri, 12 Jul 2024 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720820644; x=1721425444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmq1pCxKvJ1kyS2dIS+YPGG2LxnLKYrRDFXRW+UjEyg=;
        b=cild3n5DoBOzEoIOIb7hxQqFVkIuNW+U+WobfYfkvkMUb9D2FL3w3F1PTbyHNAKuZq
         80cfoOG36fvqb0T4qDA85kU2AaxLILvuCLIJ4LKG837ztqpw+2MFFVbE2286YgrCfV8h
         5j4pxfQfxvRk0kD3bLYpN+X+uJAUmBfsyg0GPp6+Y4y39+t79pBnXYYjWYUJ9t47Gcpp
         628ebJac8tjLY53d1YPzxN9i43vxkdfYAES8i4QoA4M+FWhekceyeaZ7h9+2P5su5JjH
         OASyweo8LoGmSiMP8Ra1st3uZf4+7/t+PQe0F72j05/oMUnCtOPPBT9eCsDPeuS7Jd3I
         wx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720820644; x=1721425444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmq1pCxKvJ1kyS2dIS+YPGG2LxnLKYrRDFXRW+UjEyg=;
        b=scuekm9CgJ4AW2u2B5mx0RBzMpOefw7aMYCYTCKZ4XRFeE54xOuoggcfKOYzJKRA0E
         yVNBTXw4VSWaPTKSgpRzce68DsRMXNwIRjNAiKcYCr7TjDrB0aT1793g3VYoJu386CJ8
         hAUHDhPmvtrp/cbUy6vEqKpNGs7XhLRr+YeetzId50BKodm4jkZIJCzYV7wJ+TkMI7i7
         FM13nqnytsRZ/hEyQJAZssS1xfOBBDzAPkWEg0456WR3oiwHSKaBuqWQ2SIq6L2562do
         83z/dKq/ky5roMTJYzivhhzbSBP4uyNd7l5tJUgjfDP+X0wVMdvqy9HwOu7HAtJB+azU
         NOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw0TcGggbItcPRYLbsBofOj83P3xzci9M1eCNwPCPVAWFA3tQV47ayWti1K+xuiwhSIB2YuBQRpjw/bDfApCfQU1uXlDzyCsAf4YaWURe7s3NoJHjX97feKjDfZRaaDFndrjuc2I8gfKrPDPJYK2rHhK0BYYgDXGUr/3t1vDYoF7blUmrq
X-Gm-Message-State: AOJu0YxMw/hu9eXmuS+IuxYeSP0Kf71j94NmeK28ZxXCGrLkQ6p1cxLj
	KzFEeN8e0b92Gt8MqRnk2ZOgGlsAtSOB69pbFRh8ARjqrHnuaMjyT2kHhDGGSR0n4pHNSy5is28
	fKAswS6JxBhdX53od5NGeGow702k=
X-Google-Smtp-Source: AGHT+IE2Iln2pnBfx5RRwfNDrywBJ/2uI8jB96yufCjL8MRWhhZD+kUBl5CAtoU4zbfZJbHCVlNMcSNElL76l4+IqKU=
X-Received: by 2002:a17:90a:65c1:b0:2ca:5e9f:51ab with SMTP id
 98e67ed59e1d1-2ca5e9f53b4mr7704368a91.45.1720820644504; Fri, 12 Jul 2024
 14:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110401.412779774@infradead.org>
In-Reply-To: <20240711110401.412779774@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 14:43:52 -0700
Message-ID: <CAEf4BzZCzqOsk55E0b8i9y5zFuf8t=zwrjORnVaLGK0ZVgJTFg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
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
> In order to put a bound on the uretprobe_srcu critical section, add a
> timer to uprobe_task. Upon every RI added or removed the timer is
> pushed forward to now + 1s. If the timer were ever to fire, it would
> convert the SRCU 'reference' to a refcount reference if possible.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/uprobes.h |    8 +++++
>  kernel/events/uprobes.c |   67 +++++++++++++++++++++++++++++++++++++++++=
+++----
>  2 files changed, 69 insertions(+), 6 deletions(-)
>
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -15,6 +15,7 @@
>  #include <linux/rbtree.h>
>  #include <linux/types.h>
>  #include <linux/wait.h>
> +#include <linux/timer.h>
>
>  struct vm_area_struct;
>  struct mm_struct;
> @@ -79,6 +80,10 @@ struct uprobe_task {
>         struct return_instance          *return_instances;
>         unsigned int                    depth;
>         unsigned int                    active_srcu_idx;
> +
> +       struct timer_list               ri_timer;
> +       struct callback_head            ri_task_work;
> +       struct task_struct              *task;
>  };
>
>  struct return_instance {
> @@ -86,7 +91,8 @@ struct return_instance {
>         unsigned long           func;
>         unsigned long           stack;          /* stack pointer */
>         unsigned long           orig_ret_vaddr; /* original return addres=
s */
> -       bool                    chained;        /* true, if instance is n=
ested */
> +       u8                      chained;        /* true, if instance is n=
ested */
> +       u8                      has_ref;

Why bool -> u8 switch? You don't touch chained, so why change its
type? And for has_ref you interchangeably use 0 and true for the same
field. Let's stick to bool as there is nothing wrong with it?

>         int                     srcu_idx;
>
>         struct return_instance  *next;          /* keep as stack */

[...]

> @@ -1822,13 +1864,20 @@ static int dup_utask(struct task_struct
>                         return -ENOMEM;
>
>                 *n =3D *o;
> -               __srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
> +               if (n->uprobe) {
> +                       if (n->has_ref)
> +                               get_uprobe(n->uprobe);
> +                       else
> +                               __srcu_clone_read_lock(&uretprobes_srcu, =
n->srcu_idx);
> +               }
>                 n->next =3D NULL;
>
>                 *p =3D n;
>                 p =3D &n->next;
>                 n_utask->depth++;
>         }
> +       if (n_utask->return_instances)
> +               mod_timer(&n_utask->ri_timer, jiffies + HZ);

let's add #define for HZ, so it's adjusted in just one place (instead
of 3 as it is right now)

Also, we can have up to 64 levels of uretprobe nesting, so,
technically, the user can cause a delay of 64 seconds in total. Maybe
let's use something smaller than a full second? After all, if the
user-space function has high latency, then this refcount congestion is
much less of a problem. I'd set it to something like 50-100 ms for
starters.

>
>         return 0;
>  }
> @@ -1967,6 +2016,7 @@ static void prepare_uretprobe(struct upr
>
>         ri->srcu_idx =3D __srcu_read_lock(&uretprobes_srcu);
>         ri->uprobe =3D uprobe;
> +       ri->has_ref =3D 0;
>         ri->func =3D instruction_pointer(regs);
>         ri->stack =3D user_stack_pointer(regs);
>         ri->orig_ret_vaddr =3D orig_ret_vaddr;
> @@ -1976,6 +2026,8 @@ static void prepare_uretprobe(struct upr
>         ri->next =3D utask->return_instances;
>         utask->return_instances =3D ri;
>
> +       mod_timer(&utask->ri_timer, jiffies + HZ);
> +
>         return;
>
>  err_mem:
> @@ -2204,6 +2256,9 @@ handle_uretprobe_chain(struct return_ins
>         struct uprobe *uprobe =3D ri->uprobe;
>         struct uprobe_consumer *uc;
>
> +       if (!uprobe)
> +               return;
> +
>         guard(srcu)(&uprobes_srcu);
>
>         for_each_consumer_rcu(uc, uprobe->consumers) {
> @@ -2250,8 +2305,10 @@ static void handle_trampoline(struct pt_
>
>                 instruction_pointer_set(regs, ri->orig_ret_vaddr);
>                 do {
> -                       if (valid)
> +                       if (valid) {
>                                 handle_uretprobe_chain(ri, regs);
> +                               mod_timer(&utask->ri_timer, jiffies + HZ)=
;
> +                       }
>                         ri =3D free_ret_instance(ri);
>                         utask->depth--;
>                 } while (ri !=3D next);
>
>


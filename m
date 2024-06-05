Return-Path: <bpf+bounces-31456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FD8FD409
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 19:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA061F244C5
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8CB13A3E2;
	Wed,  5 Jun 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhFdxVgM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0CD26D;
	Wed,  5 Jun 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608371; cv=none; b=aEiZ2pSxELMPNoNlPsKBnVu0UdVFcd5DRVFKugDxkxqi0l9toD5L5QmEtjmegKdo0cqVMrF7rrHlB9zxTxhjT78BjrRnj8GaZRsNNjla5hXhqDOdqmUPlPK7H1QKelof+ylTqHswNAQ6RAa8ITwbHp/xqencLe516K4b6gxcrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608371; c=relaxed/simple;
	bh=5dWCw+Brz9atJh4vj3HhSF8MF6MQRp/xskwrsvr+usE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgCn7sAAgDpAUP6Y2J53TaCyWsd1651mfJzqLXIDiGkgwfLuFJRUp6cdJQO9Smbi/WzclAMzmiXWAZ48MKRHmqF8I3jPLvXUoYrqnsWykXsIlzxv5M9SkHThck34qZBfc11izVFyxN2EpoQl0eKzkUzKLGXBg7QGvFLiXwbtN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhFdxVgM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so49553a91.1;
        Wed, 05 Jun 2024 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608368; x=1718213168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49EyYBiI1YH8SQkHy4ti9tHaXkG/IZKT6ZmSZHt+3c8=;
        b=fhFdxVgML70Xr2NzWDgM7MKUk1yn0z0MgaSlsd2EosOwPV2Kkr8ID4OjM/6rRktYzs
         jg8Z5z7/oKHiHRVKsNhbxxuTam1+l+m5aOsVyR3aRCVhTZV8L5mbX+3EK3xgC0zd8y/z
         uZd5QlkdyBRT2SU+f8j+OCtgRTGk67ykZ8eJ/rgBHYENe5xDSqsA+hx9f19ha92GC1tO
         pNe6lsE7EDuuUkMfJGPi7qeAiceBjmSWyNQQJ+g6DXvV5PXyUvY2Sy1inKIk2pVzhKy/
         dcj6SFq5+UlWFIcsGRNeUfB3wDKDcJUEePoPClbxRPc8PtPTWZe4eDeOvyCJGSGYXVOX
         b1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608368; x=1718213168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49EyYBiI1YH8SQkHy4ti9tHaXkG/IZKT6ZmSZHt+3c8=;
        b=nqiKhkPsyUNrO/nExNQuJoJl0oSP4wLBAv9z0l5iDcOojLyPZltyxmJ48xqIE2roGg
         2AZCxcDqqo2D8SjWrA4ou+NOC7ZBUiOE65J6AHWoY6APA6ncTR5g08cYu1eKHl65xJ+6
         kWlkNAj1pPCaQ8huSp5/sKWmf6xSE5ipqOMiqoG3S+zqx6yGLU7bGDTxysfcblBA9NTH
         Lq7mSb5f1k2A1LbWvw02k+zyov2R5oLpTCJyKxUaNIKcqBhfyHSEVjfLA0YuufK7gPM8
         BfnmKj1RTksmaJXDPzR55MXc3k6UernSgLasLqAIs0eHeT76gylKyrsp8GzWYeAUDXLl
         Y1bg==
X-Forwarded-Encrypted: i=1; AJvYcCUgk2JBpDzbUCxckoYHGYTSjviP3y2wJQh06IFV+KLrqVXZMBX3ok4DTHzbXVjjZpjClVrPyqWXn25y4GPwojVWA2/RSiUTkKb1tdDLBDAKtWvrKiGgNlywAZ5aYY4fwxhbRZJUsrtgFRhedmPzQV1R4AZykGCuLh8Cg0R9HldMn8zoXcct
X-Gm-Message-State: AOJu0YxWKoVNoPIzslKczG2nvmKBgSIvvOC2eKX7ZEh6k6MkrKOnKqsY
	a7y3tKRTjhC6SUB+UXvaijkssYgwDBc+iXqo4G7dY9dJWNRJQLORa9yE+BgFCJI0j9SsJMg5Z0F
	Hz84OFLy73HuXnw1XnVRDjLBdwjs=
X-Google-Smtp-Source: AGHT+IGf5c99ahdI6HfpId71WS8AZSXe58l8eprbYv33HMmbwASnsDpl3KDevVvSPzBNgAOzU0KEGtVHVTqz4ut8ths=
X-Received: by 2002:a17:90a:a615:b0:2bd:839f:7f36 with SMTP id
 98e67ed59e1d1-2c27db002f8mr2987313a91.10.1717608368339; Wed, 05 Jun 2024
 10:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604200221.377848-1-jolsa@kernel.org> <20240604200221.377848-2-jolsa@kernel.org>
In-Reply-To: <20240604200221.377848-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jun 2024 10:25:56 -0700
Message-ID: <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to uprobe_consumer
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:02=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new set of callbacks that are triggered on entry and return
> uprobe execution for the attached function.
>
> The session means that those callbacks are 'connected' in a way
> that allows to:
>   - control execution of return callback from entry callback
>   - share data between entry and return callbacks
>
> The session concept fits to our common use case where we do filtering
> on entry uprobe and based on the result we decide to run the return
> uprobe (or not).
>
> It's also convenient to share the data between session callbacks.
>
> The control of return uprobe execution is done via return value of the
> entry session callback, where 0 means to install and execute return
> uprobe, 1 means to not install.
>
> Current implementation has a restriction that allows to register only
> single consumer with session callbacks for a uprobe and also restricting
> standard callbacks consumers.
>
> Which means that there can be only single user of a uprobe (inode +
> offset) when session consumer is registered to it.
>
> This is because all registered consumers are executed when uprobe or
> return uprobe is hit and wihout additional layer (like fgraph's shadow
> stack) that would keep the state of the return callback, we have no
> way to find out which consumer should be executed.
>
> I'm not sure how big limitation this is for people, our current use
> case seems to be ok with that. Fixing this would be more complex/bigger
> change to uprobes, thoughts?

I think it's a pretty big limitation, because in production you don't
always know ahead of time all possible users of uprobe, so any such
limitations will cause problems, issue reports, investigation, etc.

As one possible solution, what if we do

struct return_instance {
    ...
    u64 session_cookies[];
};

and allocate sizeof(struct return_instance) + 8 *
<num-of-session-consumers> and then at runtime pass
&session_cookies[i] as data pointer to session-aware callbacks?

>
> Hence sending this as RFC to gather more opinions and feedback.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h | 18 +++++++++++
>  kernel/events/uprobes.c | 69 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 78 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..a2f2d5ac3cee 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -34,6 +34,12 @@ enum uprobe_filter_ctx {
>  };
>
>  struct uprobe_consumer {
> +       /*
> +        * The handler callback return value controls removal of the upro=
be.
> +        *  0 on success, uprobe stays
> +        *  1 on failure, remove the uprobe
> +        *    console warning for anything else
> +        */
>         int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
);
>         int (*ret_handler)(struct uprobe_consumer *self,
>                                 unsigned long func,
> @@ -42,6 +48,17 @@ struct uprobe_consumer {
>                                 enum uprobe_filter_ctx ctx,
>                                 struct mm_struct *mm);
>
> +       /* The handler_session callback return value controls execution o=
f
> +        * the return uprobe and ret_handler_session callback.
> +        *  0 on success
> +        *  1 on failure, DO NOT install/execute the return uprobe
> +        *    console warning for anything else
> +        */
> +       int (*handler_session)(struct uprobe_consumer *self, struct pt_re=
gs *regs,
> +                              unsigned long *data);
> +       int (*ret_handler_session)(struct uprobe_consumer *self, unsigned=
 long func,
> +                                  struct pt_regs *regs, unsigned long *d=
ata);
> +

We should try to avoid an alternative set of callbacks, IMO. Let's
extend existing ones with `unsigned long *data`, but specify that
unless consumer sets some flag on registration that it needs a session
cookie, we'll pass NULL here? Or just allocate cookie data for each
registered consumer for simplicity, don't know; given we don't expect
many consumers on exactly the same uprobe, it might be ok to keep it
simple.


>         struct uprobe_consumer *next;
>  };
>
> @@ -85,6 +102,7 @@ struct return_instance {
>         unsigned long           func;
>         unsigned long           stack;          /* stack pointer */
>         unsigned long           orig_ret_vaddr; /* original return addres=
s */
> +       unsigned long           data;
>         bool                    chained;        /* true, if instance is n=
ested */
>
>         struct return_instance  *next;          /* keep as stack */
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2c83ba776fc7..17b0771272a6 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -750,12 +750,32 @@ static struct uprobe *alloc_uprobe(struct inode *in=
ode, loff_t offset,
>         return uprobe;
>  }
>
> -static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *=
uc)
> +/*
> + * Make sure all the uprobe consumers have only one type of entry
> + * callback registered (either handler or handler_session) due to
> + * different return value actions.
> + */
> +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_co=
nsumer *uc)
> +{
> +       if (!curr)
> +               return 0;
> +       if (curr->handler_session || uc->handler_session)
> +               return -EBUSY;
> +       return 0;
> +}
> +
> +static int consumer_add(struct uprobe *uprobe, struct uprobe_consumer *u=
c)
>  {
> +       int err;
> +
>         down_write(&uprobe->consumer_rwsem);
> -       uc->next =3D uprobe->consumers;
> -       uprobe->consumers =3D uc;
> +       err =3D consumer_check(uprobe->consumers, uc);
> +       if (!err) {
> +               uc->next =3D uprobe->consumers;
> +               uprobe->consumers =3D uc;
> +       }
>         up_write(&uprobe->consumer_rwsem);
> +       return err;
>  }
>
>  /*
> @@ -1114,6 +1134,21 @@ void uprobe_unregister(struct inode *inode, loff_t=
 offset, struct uprobe_consume
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>
> +static int check_handler(struct uprobe_consumer *uc)
> +{
> +       /* Uprobe must have at least one set consumer. */
> +       if (!uc->handler && !uc->ret_handler &&
> +           !uc->handler_session && !uc->ret_handler_session)
> +               return -1;
> +       /* Session consumer is exclusive. */
> +       if (uc->handler && uc->handler_session)
> +               return -1;
> +       /* Session consumer must have both entry and return handler. */
> +       if (!!uc->handler_session !=3D !!uc->ret_handler_session)
> +               return -1;
> +       return 0;
> +}
> +
>  /*
>   * __uprobe_register - register a probe
>   * @inode: the file in which the probe has to be placed.
> @@ -1138,8 +1173,7 @@ static int __uprobe_register(struct inode *inode, l=
off_t offset,
>         struct uprobe *uprobe;
>         int ret;
>
> -       /* Uprobe must have at least one set consumer */
> -       if (!uc->handler && !uc->ret_handler)
> +       if (check_handler(uc))
>                 return -EINVAL;
>
>         /* copy_insn() uses read_mapping_page() or shmem_read_mapping_pag=
e() */
> @@ -1173,11 +1207,14 @@ static int __uprobe_register(struct inode *inode,=
 loff_t offset,
>         down_write(&uprobe->register_rwsem);
>         ret =3D -EAGAIN;
>         if (likely(uprobe_is_active(uprobe))) {
> -               consumer_add(uprobe, uc);
> +               ret =3D consumer_add(uprobe, uc);
> +               if (ret)
> +                       goto fail;
>                 ret =3D register_for_each_vma(uprobe, uc);
>                 if (ret)
>                         __uprobe_unregister(uprobe, uc);
>         }
> + fail:
>         up_write(&uprobe->register_rwsem);
>         put_uprobe(uprobe);
>
> @@ -1853,7 +1890,7 @@ static void cleanup_return_instances(struct uprobe_=
task *utask, bool chained,
>         utask->return_instances =3D ri;
>  }
>
> -static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *reg=
s)
> +static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *reg=
s, unsigned long data)
>  {
>         struct return_instance *ri;
>         struct uprobe_task *utask;
> @@ -1909,6 +1946,7 @@ static void prepare_uretprobe(struct uprobe *uprobe=
, struct pt_regs *regs)
>         ri->stack =3D user_stack_pointer(regs);
>         ri->orig_ret_vaddr =3D orig_ret_vaddr;
>         ri->chained =3D chained;
> +       ri->data =3D data;
>
>         utask->depth++;
>         ri->next =3D utask->return_instances;
> @@ -2070,6 +2108,7 @@ static void handler_chain(struct uprobe *uprobe, st=
ruct pt_regs *regs)
>         struct uprobe_consumer *uc;
>         int remove =3D UPROBE_HANDLER_REMOVE;
>         bool need_prep =3D false; /* prepare return uprobe, when needed *=
/
> +       unsigned long data =3D 0;
>
>         down_read(&uprobe->register_rwsem);
>         for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> @@ -2081,14 +2120,24 @@ static void handler_chain(struct uprobe *uprobe, =
struct pt_regs *regs)
>                                 "bad rc=3D0x%x from %ps()\n", rc, uc->han=
dler);
>                 }
>
> -               if (uc->ret_handler)
> +               if (uc->handler_session) {
> +                       rc =3D uc->handler_session(uc, regs, &data);
> +                       WARN(rc & ~UPROBE_HANDLER_MASK,
> +                               "bad rc=3D0x%x from %ps()\n", rc, uc->han=
dler_session);
> +               }
> +
> +               if (uc->ret_handler || uc->ret_handler_session)
>                         need_prep =3D true;
>
>                 remove &=3D rc;
>         }
>
>         if (need_prep && !remove)
> -               prepare_uretprobe(uprobe, regs); /* put bp at return */
> +               prepare_uretprobe(uprobe, regs, data); /* put bp at retur=
n */
> +
> +       /* remove uprobe only for non-session consumers */
> +       if (uprobe->consumers && remove)
> +               remove &=3D !!uprobe->consumers->handler;
>
>         if (remove && uprobe->consumers) {
>                 WARN_ON(!uprobe_is_active(uprobe));
> @@ -2107,6 +2156,8 @@ handle_uretprobe_chain(struct return_instance *ri, =
struct pt_regs *regs)
>         for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
>                 if (uc->ret_handler)
>                         uc->ret_handler(uc, ri->func, regs);
> +               if (uc->ret_handler_session)
> +                       uc->ret_handler_session(uc, ri->func, regs, &ri->=
data);
>         }
>         up_read(&uprobe->register_rwsem);
>  }
> --
> 2.45.1
>


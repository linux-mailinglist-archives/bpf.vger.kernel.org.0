Return-Path: <bpf+bounces-33666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C9924999
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703361C22A16
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D33201254;
	Tue,  2 Jul 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU0w4EuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98086200134;
	Tue,  2 Jul 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953503; cv=none; b=AOuLV0sX6BK2F68NOHEWwAz2ZMbRFBbUC4jK0cU6SKJpesy8jSNqP14Ib+btl6LlEKIUI7YGc/JhvD3eZ8IJanRVRhJEvTxiT+pdS3kIRlloZ/yaPDyohrHJenQT7jWMbplZfC9ydAuQBm5E/NhbBkPeD7eA1R/Haa3VlZHhOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953503; c=relaxed/simple;
	bh=edkynavJ5VvE+BFnPJz+wF1n6P/e3eWGMdXM2MhYFBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF67jHxU8h2hz3vBT/G9U6EiOReY+pCiqcMOxnpVGEFYp58kz+rECnYYkoDArVC63EovbGP9HO5pFsLCLNoMy1tH27AkcOQCNEXGmjD6ft2pXLfBlwi/ZscJ5F0V2OwXm/Ej7M97GX8SACEMBeqGW5G6fqtBkxSicdkE0oMFnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU0w4EuP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-70df2135426so2640558a12.2;
        Tue, 02 Jul 2024 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719953501; x=1720558301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR53/I1TAEgWYVC9f24xvmLcKegKGLx20WV7uCwyB2U=;
        b=JU0w4EuP4opPk4lPKioYmOQZ8Rgn4hBmBOimIFPwM3XnnEGbAaItVjAupl31jyJmc5
         0nTSbHky/aNx+C19uISxb+FDFy0AMxI10gkvBgYEHNQ69OBgzjdpZ5fehftvXwQAiezh
         cfLCaUxHAFdJFcLRVP8yWphOLWaO3r4X+doTAA+XJbGymsw4DCFYMLf+8VR/vNXukoiv
         KzceHiLDY9jjB2EGRvaqyjxK7d/To/WBRXcNzm8Oqq+L68KXEbHa9TBG9scLKsChbQpz
         LHVjLavWdATBf+7ZCE9ZgMP4Gc7V8qwR+8csd7qAIl1lu9MSx5BNw8IvAsKWUuracOfR
         0LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719953501; x=1720558301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR53/I1TAEgWYVC9f24xvmLcKegKGLx20WV7uCwyB2U=;
        b=VsxGVH0AlgNJjnqDhE9pTYEDioPm0y/mJuwVRxk+qr6JPdJ1r/ImRcnYdjkVqn1ByH
         JtAYhYPIPE4B0Uipyrxf6slc1H5lRzKV82rQ6oetMHsKNj2YDymdPCbk29/VHjzZRO4j
         O3UDCechlpIrbTHKcNRFGnEjjzWGbGuSxgX1LEuokrexQI4PF4f5rp8F2ugtXNTKUuBf
         Dzn3lV4ImDS6niK3NeQWPE36YIhsrXza5exHSrQYI1z6RuWAPvEcPyJsh6Eb2AXfUtQL
         BQPuJur14KsPAHEk2dFtYdjDm3N2E2MH2yujACsvsV+yL94DwReph/AubxfrBgEQoj8R
         1okQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYfSqnW+llII0WpY1Nqib8NlU7P/OzcvK2A1YDtAKpKhtaXtQWkVSaXx/vTQYoX/iwq6ug3sT32WDbiThHCkX5MX7ifAZoGneAlWf/s2SEDoEaBRzObWPvFcd6PsarPL0p9WXo46Sjo5oz0rAwXGZlUno++rCxzNq6p6ah2t78qpB2TFpG
X-Gm-Message-State: AOJu0Yx0cclwvSMrOF8Wkwid6VezgBgFihTr7yKnvFryGPDBcSev/GfU
	ROadQ7PXnrc4CoaTjMIIZeetLQd1R5diVIdSKpG5EF5+jDPVWkEpaJTpArmoRQklq7/pqss1e89
	MX3xVTlNkM72cMMOxgIR8qtmIBXM=
X-Google-Smtp-Source: AGHT+IEeyFhHTfoEkIzZ8iwuE9Yvef12wguG51MXbEJrS22nS8BQyBG3QldPqdKQ4skYyq1bGzDxEQtMEJjpDTGU1j0=
X-Received: by 2002:a05:6a21:196:b0:1bf:2bf:9ded with SMTP id
 adf61e73a8af0-1bf02bf9f24mr8324682637.38.1719953500773; Tue, 02 Jul 2024
 13:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 13:51:28 -0700
Message-ID: <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
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

On Mon, Jul 1, 2024 at 9:41=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for uprobe consumer to be defined as session and have
> new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
>
> The session means that 'handler' and 'ret_handler' callbacks are
> connected in a way that allows to:
>
>   - control execution of 'ret_handler' from 'handler' callback
>   - share data between 'handler' and 'ret_handler' callbacks
>
> The session is enabled by setting new 'session' bool field to true
> in uprobe_consumer object.
>
> We keep count of session consumers for uprobe and allocate session_consum=
er
> object for each in return_instance object. This allows us to store
> return values of 'handler' callbacks and data pointers of shared
> data between both handlers.
>
> The session concept fits to our common use case where we do filtering
> on entry uprobe and based on the result we decide to run the return
> uprobe (or not).
>
> It's also convenient to share the data between session callbacks.
>
> The control of 'ret_handler' callback execution is done via return
> value of the 'handler' callback. If it's 0 we install and execute
> return uprobe, if it's 1 we do not.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h     |  16 ++++-
>  kernel/events/uprobes.c     | 129 +++++++++++++++++++++++++++++++++---
>  kernel/trace/bpf_trace.c    |   6 +-
>  kernel/trace/trace_uprobe.c |  12 ++--
>  4 files changed, 144 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..903a860a8d01 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -34,15 +34,18 @@ enum uprobe_filter_ctx {
>  };
>
>  struct uprobe_consumer {
> -       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
);
> +       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
, __u64 *data);
>         int (*ret_handler)(struct uprobe_consumer *self,
>                                 unsigned long func,
> -                               struct pt_regs *regs);
> +                               struct pt_regs *regs, __u64 *data);
>         bool (*filter)(struct uprobe_consumer *self,
>                                 enum uprobe_filter_ctx ctx,
>                                 struct mm_struct *mm);
>
>         struct uprobe_consumer *next;
> +
> +       bool                    session;        /* marks uprobe session c=
onsumer */
> +       unsigned int            session_id;     /* set when uprobe_consum=
er is registered */
>  };
>
>  #ifdef CONFIG_UPROBES
> @@ -80,6 +83,12 @@ struct uprobe_task {
>         unsigned int                    depth;
>  };
>
> +struct session_consumer {
> +       __u64           cookie;
> +       unsigned int    id;
> +       int             rc;

you'll be using u64 for ID, right? so this struct will be 24 bytes.
Maybe we can just use topmost bit of ID to store whether uretprobe
should run or not? It's trivial to mask out during ID comparisons

> +};
> +
>  struct return_instance {
>         struct uprobe           *uprobe;
>         unsigned long           func;
> @@ -88,6 +97,9 @@ struct return_instance {
>         bool                    chained;        /* true, if instance is n=
ested */
>
>         struct return_instance  *next;          /* keep as stack */
> +
> +       int                     sessions_cnt;

there is 7 byte gap before next field, let's put sessions_cnt there

> +       struct session_consumer sessions[];
>  };
>
>  enum rp_check {
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2c83ba776fc7..4da410460f2a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -63,6 +63,8 @@ struct uprobe {
>         loff_t                  ref_ctr_offset;
>         unsigned long           flags;
>
> +       unsigned int            sessions_cnt;
> +
>         /*
>          * The generic code assumes that it has two members of unknown ty=
pe
>          * owned by the arch-specific code:
> @@ -750,11 +752,30 @@ static struct uprobe *alloc_uprobe(struct inode *in=
ode, loff_t offset,
>         return uprobe;
>  }
>
> +static void
> +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *u=
c)
> +{
> +       static unsigned int session_id;

(besides what Peter mentioned about wrap around of 32-bit counter)
let's use atomic here to not rely on any particular locking
(unnecessarily), this might make my life easier in the future, thanks.
This is registration time, low frequency, extra atomic won't hurt.

It might be already broken, actually, for two independently registering upr=
obes.

> +
> +       if (uc->session) {
> +               uprobe->sessions_cnt++;
> +               uc->session_id =3D ++session_id ?: ++session_id;
> +       }
> +}
> +
> +static void
> +uprobe_consumer_unaccount(struct uprobe *uprobe, struct uprobe_consumer =
*uc)

this fits in 100 characters, keep it single line, please. Same for
account function

> +{
> +       if (uc->session)
> +               uprobe->sessions_cnt--;
> +}
> +
>  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *=
uc)
>  {
>         down_write(&uprobe->consumer_rwsem);
>         uc->next =3D uprobe->consumers;
>         uprobe->consumers =3D uc;
> +       uprobe_consumer_account(uprobe, uc);
>         up_write(&uprobe->consumer_rwsem);
>  }
>
> @@ -773,6 +794,7 @@ static bool consumer_del(struct uprobe *uprobe, struc=
t uprobe_consumer *uc)
>                 if (*con =3D=3D uc) {
>                         *con =3D uc->next;
>                         ret =3D true;
> +                       uprobe_consumer_unaccount(uprobe, uc);
>                         break;
>                 }
>         }
> @@ -1744,6 +1766,23 @@ static struct uprobe_task *get_utask(void)
>         return current->utask;
>  }
>
> +static size_t ri_size(int sessions_cnt)
> +{
> +       struct return_instance *ri __maybe_unused;
> +
> +       return sizeof(*ri) + sessions_cnt * sizeof(ri->sessions[0]);

just use struct_size()?

> +}
> +
> +static struct return_instance *alloc_return_instance(int sessions_cnt)
> +{
> +       struct return_instance *ri;
> +
> +       ri =3D kzalloc(ri_size(sessions_cnt), GFP_KERNEL);
> +       if (ri)
> +               ri->sessions_cnt =3D sessions_cnt;
> +       return ri;
> +}
> +
>  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
>  {
>         struct uprobe_task *n_utask;
> @@ -1756,11 +1795,11 @@ static int dup_utask(struct task_struct *t, struc=
t uprobe_task *o_utask)
>
>         p =3D &n_utask->return_instances;
>         for (o =3D o_utask->return_instances; o; o =3D o->next) {
> -               n =3D kmalloc(sizeof(struct return_instance), GFP_KERNEL)=
;
> +               n =3D alloc_return_instance(o->sessions_cnt);
>                 if (!n)
>                         return -ENOMEM;
>
> -               *n =3D *o;
> +               memcpy(n, o, ri_size(o->sessions_cnt));
>                 get_uprobe(n->uprobe);
>                 n->next =3D NULL;
>
> @@ -1853,9 +1892,9 @@ static void cleanup_return_instances(struct uprobe_=
task *utask, bool chained,
>         utask->return_instances =3D ri;
>  }
>
> -static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *reg=
s)
> +static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *reg=
s,
> +                             struct return_instance *ri)
>  {
> -       struct return_instance *ri;
>         struct uprobe_task *utask;
>         unsigned long orig_ret_vaddr, trampoline_vaddr;
>         bool chained;
> @@ -1874,9 +1913,11 @@ static void prepare_uretprobe(struct uprobe *uprob=
e, struct pt_regs *regs)
>                 return;
>         }
>
> -       ri =3D kmalloc(sizeof(struct return_instance), GFP_KERNEL);
> -       if (!ri)
> -               return;
> +       if (!ri) {
> +               ri =3D alloc_return_instance(0);
> +               if (!ri)
> +                       return;
> +       }
>
>         trampoline_vaddr =3D get_trampoline_vaddr();
>         orig_ret_vaddr =3D arch_uretprobe_hijack_return_addr(trampoline_v=
addr, regs);
> @@ -2065,35 +2106,85 @@ static struct uprobe *find_active_uprobe(unsigned=
 long bp_vaddr, int *is_swbp)
>         return uprobe;
>  }
>
> +static struct session_consumer *
> +session_consumer_next(struct return_instance *ri, struct session_consume=
r *sc,
> +                     int session_id)
> +{
> +       struct session_consumer *next;
> +
> +       next =3D sc ? sc + 1 : &ri->sessions[0];
> +       next->id =3D session_id;

it's kind of unexpected that "session_consumer_next" would actually
set an ID... Maybe drop int session_id as input argument and fill it
out outside of this function, this function being just a simple
iterator?

> +       return next;
> +}
> +
> +static struct session_consumer *
> +session_consumer_find(struct return_instance *ri, int *iter, int session=
_id)
> +{
> +       struct session_consumer *sc;
> +       int idx =3D *iter;
> +
> +       for (sc =3D &ri->sessions[idx]; idx < ri->sessions_cnt; idx++, sc=
++) {
> +               if (sc->id =3D=3D session_id) {
> +                       *iter =3D idx + 1;
> +                       return sc;
> +               }
> +       }
> +       return NULL;
> +}
> +
>  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  {
>         struct uprobe_consumer *uc;
>         int remove =3D UPROBE_HANDLER_REMOVE;
> +       struct session_consumer *sc =3D NULL;
> +       struct return_instance *ri =3D NULL;
>         bool need_prep =3D false; /* prepare return uprobe, when needed *=
/
>
>         down_read(&uprobe->register_rwsem);
> +       if (uprobe->sessions_cnt) {
> +               ri =3D alloc_return_instance(uprobe->sessions_cnt);
> +               if (!ri)
> +                       goto out;
> +       }
> +
>         for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> +               __u64 *cookie =3D NULL;
>                 int rc =3D 0;
>
> +               if (uc->session) {
> +                       sc =3D session_consumer_next(ri, sc, uc->session_=
id);
> +                       cookie =3D &sc->cookie;
> +               }
> +
>                 if (uc->handler) {
> -                       rc =3D uc->handler(uc, regs);
> +                       rc =3D uc->handler(uc, regs, cookie);
>                         WARN(rc & ~UPROBE_HANDLER_MASK,
>                                 "bad rc=3D0x%x from %ps()\n", rc, uc->han=
dler);
>                 }
>
> -               if (uc->ret_handler)
> +               if (uc->session) {
> +                       sc->rc =3D rc;
> +                       need_prep |=3D !rc;

nit:

if (rc =3D=3D 0)
    need_prep =3D true;

and then it's *extremely obvious* what happens and under which conditions

> +               } else if (uc->ret_handler) {
>                         need_prep =3D true;
> +               }
>
>                 remove &=3D rc;
>         }
>
> +       /* no removal if there's at least one session consumer */
> +       remove &=3D !uprobe->sessions_cnt;

this is counter (not error, not pointer), let's stick to ` =3D=3D 0`, pleas=
e

is this

if (uprobe->sessions_cnt !=3D 0)
   remove =3D 0;

? I can't tell (honestly), without spending ridiculous amounts of
mental resources (for the underlying simplicity of the condition).

> +
>         if (need_prep && !remove)
> -               prepare_uretprobe(uprobe, regs); /* put bp at return */
> +               prepare_uretprobe(uprobe, regs, ri); /* put bp at return =
*/
> +       else
> +               kfree(ri);
>
>         if (remove && uprobe->consumers) {
>                 WARN_ON(!uprobe_is_active(uprobe));
>                 unapply_uprobe(uprobe, current->mm);
>         }
> + out:
>         up_read(&uprobe->register_rwsem);
>  }
>

[...]


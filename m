Return-Path: <bpf+bounces-31214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6448D8741
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15DAB21433
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27EC136E17;
	Mon,  3 Jun 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvKoGruj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEA13666E
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431962; cv=none; b=XZ+mPT7tel35NSKmNhOqdmpd9qmG79SUKxa8yii5I5PgQtO+A9oeBd3jMJgcs5Kl65ZgPzu1qfb9Kp7S62Z78buFVW392z3ZDc6BA/3PqN3eU6yqaenUYZTvCB8uA7lfSh7pEv3PWQ0qys3T9n9QwHJWO5m/9lZ8MNrxL4PsOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431962; c=relaxed/simple;
	bh=kw2wRP4Cy2Udlie3uy/tDoDySPHXDtXyjDE46bGWp1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EezHD91ndIxGBO/MpIRIBU2SQecq3Q/lHuMvHQfzJUuWe7686+b0TK8tshmPyCMn7MSXqgX0tZwdBD0ELxMznGnrNSxA6PWq4eDR3OT/Sy8Ws6D1dygzph1M/y6p5X3GvdnZlz6y79IbIosDofyoRQ0MXzdXFhsvcTzAT4vWBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvKoGruj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351da5838fcso4482704f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431959; x=1718036759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ygwrzrt3WbfrkffjKxr7z1t1frQGsfxJ2sarBqgejXo=;
        b=UvKoGrujTQm3iB0ycxidUfzYl8yDLanmV3YiGbEhedWy9KlZmGDql2CCLWakbR9eLE
         qxgdsrMCNLhTF4wrsMokN9M+suS7Gj0iuae2J9TCGUrFPr0qBQDuS5qnjdiBvIzimmuE
         p85kRTVjRU9YPK+zEiAhPJjEHzAyoYv2dOFJHqbz42mFmNFrZkUHcZGGeDrK4GkQse7K
         WQMdK1T0rwju0/KnyjA3KPblnn/pAJaBh+KhF2YCe8ScAmB/2WVYbbg7WwGF75Z2UM2U
         IORWLGWebr5+FvYWo9ApQbnvWCoBrgAqM6Nf37AjsXEoZKUhKCwb3JFIQTtUxDMxdWFC
         Udug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431959; x=1718036759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ygwrzrt3WbfrkffjKxr7z1t1frQGsfxJ2sarBqgejXo=;
        b=EoNodKYqNAYD1BOvJoZvU6LHjUnJs6OXDxpM8x4E5cUpsqGa0hhn6+ogWTcc2NoNKh
         W+lX18tW+GOVkvg0OljY8ATiOIpPrnlzOkghs8uKyQ/HLAybvLEvKdwsVFRjojWi84+G
         isb7HplmG9LUhWxv8YmImVIute6NAQdZ+buZ48zd018BpphvUxuP4NYTxbF7WmofiXVz
         onM/xakXTvl6Lyj+L32fvuvJhl1Y5rIiSL7Hk8I0KcZRdPgFYARJo8lGcZo7wf3lXVcb
         FAA4zkXbhyWg8WOqkYL/LmbOO7uVZgcfLOE/9pGo/38B6EoZb8tx9Hba6s4Rw+Fo/S5A
         n4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXPdYyUjviPYjyTsUHIsttpnhM3W6rrgu6u3A7jTsPSDSXtouE4Wsy6sGTky1WdjRll5eNNiAeKSprIxP6KGtMz9lz
X-Gm-Message-State: AOJu0YzRhcHA44OeQxjgUYjukkZJVJlbkBgnHf7703PmpgqBj8BKmJ7P
	iZmUCwPkDjxJNY0DpdJHO3rbKAu4Fa6jzW+B48UgENdL1eeIh75dlNn0iMm2HYxxBbqUDnKU5RP
	CnbiKeXxp3W/aAk2vstrXrm+s/N8=
X-Google-Smtp-Source: AGHT+IGt+ua6mLWt/VzIEBDUHvp6m+x9RMjjXEZeawSCh2WWyNTrvImsYq0qp6RdBQK4ECrlVW1QLzQswyq7DLzzM0g=
X-Received: by 2002:adf:b306:0:b0:35d:ce01:7957 with SMTP id
 ffacd0b85a97d-35e0f32e2a0mr7258743f8f.66.1717431958544; Mon, 03 Jun 2024
 09:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603111408.3981087-1-jolsa@kernel.org>
In-Reply-To: <20240603111408.3981087-1-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Jun 2024 09:25:47 -0700
Message-ID: <CAADnVQJVSTywwCseE_9u9JmsxKowL119yUUmp+w+eYNS=1T73A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Set run context for rawtp test_run callback
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> syzbot reported crash when rawtp program executed through the
> test_run interface calls bpf_get_attach_cookie helper or any
> other helper that touches task->bpf_ctx pointer.
>
> We need to setup bpf_ctx pointer in rawtp test_run as well,
> so fixing this by moving __bpf_trace_run in header file and
> using it in test_run callback.
>
> Also renaming __bpf_trace_run to bpf_prog_run_trace.
>
> Fixes: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to acce=
ss bpf_cookie value")
> Reported-by: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D3ab78ff125b7979e45f9
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      | 27 +++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 28 ++--------------------------
>  net/bpf/test_run.c       |  4 +---
>  3 files changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5e694a308081..4eb803b1d308 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2914,6 +2914,33 @@ static inline void bpf_dynptr_set_rdonly(struct bp=
f_dynptr_kern *ptr)
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
>
> +static __always_inline int
> +bpf_prog_run_trace(struct bpf_prog *prog, u64 cookie, u64 *ctx,
> +                  bpf_prog_run_fn run_prog)
> +{
> +       struct bpf_run_ctx *old_run_ctx;
> +       struct bpf_trace_run_ctx run_ctx;
> +       int ret =3D -1;
> +
> +       cant_sleep();

I suspect you should see a splat with that.

Overall I think it's better to add empty run_ctx to
__bpf_prog_test_run_raw_tp()
instead of moving such a big function to .h

No need for prog->active increments. test_run is running
from syscall. If the same prog is attached somewhere as well
it may recurse once and it's fine imo.

pw-bot: cr

> +       if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> +               bpf_prog_inc_misses_counter(prog);
> +               goto out;
> +       }
> +
> +       run_ctx.bpf_cookie =3D cookie;
> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> +
> +       rcu_read_lock();
> +       ret =3D run_prog(prog, ctx);
> +       rcu_read_unlock();
> +
> +       bpf_reset_run_ctx(old_run_ctx);
> +out:
> +       this_cpu_dec(*(prog->active));
> +       return ret;
> +}
> +
>  static __always_inline int
>  bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr=
)
>  {
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d1daeab1bbc1..8a23ef42b76b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2383,31 +2383,6 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_m=
ap *btp)
>         preempt_enable();
>  }
>
> -static __always_inline
> -void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> -{
> -       struct bpf_prog *prog =3D link->link.prog;
> -       struct bpf_run_ctx *old_run_ctx;
> -       struct bpf_trace_run_ctx run_ctx;
> -
> -       cant_sleep();
> -       if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> -               bpf_prog_inc_misses_counter(prog);
> -               goto out;
> -       }
> -
> -       run_ctx.bpf_cookie =3D link->cookie;
> -       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> -
> -       rcu_read_lock();
> -       (void) bpf_prog_run(prog, args);
> -       rcu_read_unlock();
> -
> -       bpf_reset_run_ctx(old_run_ctx);
> -out:
> -       this_cpu_dec(*(prog->active));
> -}
> -
>  #define UNPACK(...)                    __VA_ARGS__
>  #define REPEAT_1(FN, DL, X, ...)       FN(X)
>  #define REPEAT_2(FN, DL, X, ...)       FN(X) UNPACK DL REPEAT_1(FN, DL, =
__VA_ARGS__)
> @@ -2437,7 +2412,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, =
u64 *args)
>         {                                                               \
>                 u64 args[x];                                            \
>                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);                  \
> -               __bpf_trace_run(link, args);                            \
> +               (void) bpf_prog_run_trace(link->link.prog, link->cookie,\
> +                                         args, bpf_prog_run);          \
>         }                                                               \
>         EXPORT_SYMBOL_GPL(bpf_trace_run##x)
>  BPF_TRACE_DEFN_x(1);
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index f6aad4ed2ab2..84d1c91b01ab 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -728,9 +728,7 @@ __bpf_prog_test_run_raw_tp(void *data)
>  {
>         struct bpf_raw_tp_test_run_info *info =3D data;
>
> -       rcu_read_lock();
> -       info->retval =3D bpf_prog_run(info->prog, info->ctx);
> -       rcu_read_unlock();
> +       info->retval =3D bpf_prog_run_trace(info->prog, 0, info->ctx, bpf=
_prog_run);
>  }
>
>  int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
> --
> 2.45.1
>


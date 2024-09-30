Return-Path: <bpf+bounces-40609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354AD98AF3B
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590D91C22C41
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C09184520;
	Mon, 30 Sep 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI7lx5bR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73AEDE;
	Mon, 30 Sep 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732171; cv=none; b=RL2eyVNlXXLBsuxe1tnK9Ah0MgvSmbbehGsJdx9BN1x347v6iYHPw17jppizrw71Mg/fXZp0fwAiOu+hX8/9IIjccJkR7HZ6vdxG5DYFIBbb4JcRqkmt94acRVv1nz3PRt1LZE7Sxt869D35HitG27wU8ql7HXie2mCposeOaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732171; c=relaxed/simple;
	bh=9tfL9wQxgrBlxahazI54GgJyU0iR6ozS3a21nGuIk2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG9IN9w+fbBRG8sCnIWnPdeyFJhSCayvIuourb111o76Otbh2ZYS7pCsFul0govRATSHE4uvkhBKKJcwWk4ZoUJg8fwdx0KrrYB5yygZXDpraKFUTr3gYvJKlnnbMF+6zlZGCJIj98hPXAUtKHUYkfPk9K5SfEg/rkNnr7dppsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI7lx5bR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so4052028a91.0;
        Mon, 30 Sep 2024 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727732169; x=1728336969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5TNy8FUp7Y17NDv++FYm3jaxXapKnzyrZ3LuJg6jIQ=;
        b=TI7lx5bRJ5+9tlI5JcdU6jPHHyqN2COINhY4zJQYIJpMVt6ZMQo+chEHfq928jFg+C
         EtRv/oOwmI2UzTh4Q1QD5S2gQKHR7rYu4mnnfvj+UMG4Jr1jRNDIeMfT1t66dYtgmQ0C
         SU9xxaQ52+8vRcuc5KETnpoYi16zBtgzthyaWjJXLCSFCzd/Dvp9q8M58ou0t0i/ZaAg
         OsBQYuN5s9tpc79V26Lo/ys7xFn8coN5fZB03pLCPTy56I3O2C9xY6YENL4QHEwsjUvJ
         2BFNydTRkZ4Q5+65Xb9H18vU2J3aaiwyuSRedldX5x8u0AMAp0Gm2RNfKD2dsdTYHptx
         GuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732169; x=1728336969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5TNy8FUp7Y17NDv++FYm3jaxXapKnzyrZ3LuJg6jIQ=;
        b=fntn8oEWPsF/uG0xvH+IRgeRsjxmGRLJ+WaJ89M4zN8tHKUzvhGnPxzcaEUdEdRqvP
         jBWJKXDNYzt4ZLvlS+i9pdrTtFdoBtXG99Ve74uQoXkfOGpl/z4bMMQBD1gSVj5AOVXg
         Qp6ipUTgm4CbU72D7XdvDlX71k2w3MSLez1STESBdfDBMIcYy+O1DgxJSe/e5PXLBAMR
         BDum9xR6EVvThfVY9u8FV3Xre1ALw+WUhvNArZYJhuum1mBsdOAdR1aqAoAJO3v6BqNj
         hdODYBZO9VySs7svIM+WGO0MAIekNnKVUVc4XLlEmhcQ8OLWJMgZ4GGOZjEA/fgjjh/t
         xjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUobS81iJNV0JhjPMjht+o8v6K+I3Qb79v0DuPLlPqXDX2FWay9rHpYnLoJv7bNmsIEQoQjJH6qXRzbubRv@vger.kernel.org, AJvYcCX02IrnmW8/Nsp9R6eswD/xLC4uJxEF8KmSR2wmscINr7kldhTDR+Yh9FkOboT4J2cNJec=@vger.kernel.org, AJvYcCXPPlGvUYWbCT7hdFsFpo9+cdLIDusPRqmdRVxWTAMLB0RWr/4hxzJkWyU7vRncY2rw7i8IlSbrZGVXIkQUFHRBFz9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8AtzBpUdzMbcDE32ZMVNoAdfmbRO7KZrXENEQv0y14XEl2GV
	UmfLCtmZfAkRknvL/iPYUmA5O82iPcg2xYm1qHP+13h4IrvIQKhQcsJCtuucUy9gqHEXuIxtXSS
	Knh/haMQtkJ5Y4jbSOb2GSLONI9qAEA==
X-Google-Smtp-Source: AGHT+IFFXWQ5Z2qvn32uDaXHYCPmS6wjmK5V5OmdaaKB1A1pOvX5kfq+v8VzPRst+a0PDmyQvlNnm0+R3rD6PVt5dgc=
X-Received: by 2002:a17:90a:d3c1:b0:2d8:8175:38c9 with SMTP id
 98e67ed59e1d1-2e0b8b41469mr15798989a91.20.1727732169114; Mon, 30 Sep 2024
 14:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-2-jolsa@kernel.org>
In-Reply-To: <20240929205717.3813648-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:35:56 -0700
Message-ID: <CAEf4BzaOSShQu7M2p0AMJp_+podqakap_c9XWadd4f_40XG-Ng@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 01/13] uprobe: Add data pointer to consumer handlers
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:57=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding data pointer to both entry and exit consumer handlers and all
> its users. The functionality itself is coming in following change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h                              |  4 ++--
>  kernel/events/uprobes.c                              |  4 ++--
>  kernel/trace/bpf_trace.c                             |  6 ++++--
>  kernel/trace/trace_uprobe.c                          | 12 ++++++++----
>  .../testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  2 +-
>  5 files changed, 17 insertions(+), 11 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 2b294bf1881f..bb265a632b91 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -37,10 +37,10 @@ struct uprobe_consumer {
>          * for the current process. If filter() is omitted or returns tru=
e,
>          * UPROBE_HANDLER_REMOVE is effectively ignored.
>          */
> -       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
);
> +       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
, __u64 *data);
>         int (*ret_handler)(struct uprobe_consumer *self,
>                                 unsigned long func,
> -                               struct pt_regs *regs);
> +                               struct pt_regs *regs, __u64 *data);
>         bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm=
);
>
>         struct list_head cons_node;
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2ec796e2f055..2ba93f8a31aa 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2139,7 +2139,7 @@ static void handler_chain(struct uprobe *uprobe, st=
ruct pt_regs *regs)
>                 int rc =3D 0;
>
>                 if (uc->handler) {
> -                       rc =3D uc->handler(uc, regs);
> +                       rc =3D uc->handler(uc, regs, NULL);
>                         WARN(rc & ~UPROBE_HANDLER_MASK,
>                                 "bad rc=3D0x%x from %ps()\n", rc, uc->han=
dler);
>                 }
> @@ -2179,7 +2179,7 @@ handle_uretprobe_chain(struct return_instance *ri, =
struct pt_regs *regs)
>         list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
>                                  srcu_read_lock_held(&uprobes_srcu)) {
>                 if (uc->ret_handler)
> -                       uc->ret_handler(uc, ri->func, regs);
> +                       uc->ret_handler(uc, ri->func, regs, NULL);
>         }
>         srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a582cd25ca87..fdab7ecd8dfa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3244,7 +3244,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *co=
n, struct mm_struct *mm)
>  }
>
>  static int
> -uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *r=
egs)
> +uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *r=
egs,
> +                         __u64 *data)
>  {
>         struct bpf_uprobe *uprobe;
>
> @@ -3253,7 +3254,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *c=
on, struct pt_regs *regs)
>  }
>
>  static int
> -uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long=
 func, struct pt_regs *regs)
> +uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long=
 func, struct pt_regs *regs,
> +                             __u64 *data)
>  {
>         struct bpf_uprobe *uprobe;
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index f7443e996b1b..11103dde897b 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -88,9 +88,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn=
_event *ev)
>  static int register_uprobe_event(struct trace_uprobe *tu);
>  static int unregister_uprobe_event(struct trace_uprobe *tu);
>
> -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs=
 *regs);
> +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs=
 *regs,
> +                            __u64 *data);
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> -                               unsigned long func, struct pt_regs *regs)=
;
> +                               unsigned long func, struct pt_regs *regs,
> +                               __u64 *data);
>
>  #ifdef CONFIG_STACK_GROWSUP
>  static unsigned long adjust_stack_addr(unsigned long addr, unsigned int =
n)
> @@ -1500,7 +1502,8 @@ trace_uprobe_register(struct trace_event_call *even=
t, enum trace_reg type,
>         }
>  }
>
> -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs=
 *regs)
> +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs=
 *regs,
> +                            __u64 *data)
>  {
>         struct trace_uprobe *tu;
>         struct uprobe_dispatch_data udd;
> @@ -1530,7 +1533,8 @@ static int uprobe_dispatcher(struct uprobe_consumer=
 *con, struct pt_regs *regs)
>  }
>
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> -                               unsigned long func, struct pt_regs *regs)
> +                               unsigned long func, struct pt_regs *regs,
> +                               __u64 *data)
>  {
>         struct trace_uprobe *tu;
>         struct uprobe_dispatch_data udd;
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 8835761d9a12..12005e3dc3e4 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -461,7 +461,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file=
 __ro_after_init =3D {
>
>  static int
>  uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
> -                  struct pt_regs *regs)
> +                  struct pt_regs *regs, __u64 *data)
>
>  {
>         regs->ax  =3D 0x12345678deadbeef;
> --
> 2.46.1
>
>


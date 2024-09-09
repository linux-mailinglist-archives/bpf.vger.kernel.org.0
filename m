Return-Path: <bpf+bounces-39216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA9970C2B
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 05:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CFA2836B8
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9889D1ACDE0;
	Mon,  9 Sep 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYe6j1fo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E44C81;
	Mon,  9 Sep 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725851604; cv=none; b=YEY4GcnlMnv2PmGMh3M/3ITOPyFQwkWYanpOLRFQNEwvJt+IYMlxphj+m/uK19SGnx+RSM9NTiF/K2UzfQd5qJTncsgqm96C0odmGzVq0hwjM8HSjKwJ5rVNK3GMnPCd7P/2bsPcZpdNwEE+lKT0pwawIVNee+7dJtDZD60GsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725851604; c=relaxed/simple;
	bh=HJxQSpdQ2Sar8wCHVwwgQqdCfmbMUxcd7uizAdrvU5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXZR3XV9eo3xs7YoUMCrUd0xXBizhZTq6VSqSuauc15QM2khRBywQ4E9xWXqkExX67EjTZ4t4I8289dFIdvkraXo+S90i2IAyH7yx8IXNTyD/VQvAexsuQKMWoIDEuEidhv91QQKAh+zRG8rN7WY0H0tzivqs92Hp1JtsFF/H0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYe6j1fo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so3777928a12.1;
        Sun, 08 Sep 2024 20:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725851601; x=1726456401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcQx4vSk1WDBIFdGJdgeYgWLIddU3+oNu6pAPjOlvI4=;
        b=KYe6j1fofJVMat7Pl9jGOIRz9eaGAA8MqrR7/16J2YmuG0tlkXO8ptIf1n3N8TGkli
         SrZ4Y1lCPlXdTPumGNYyR/klwayoVdnb8D+S4oFGg0AzvNKyci1d/q5dSuoxz/bWU65z
         FyVqmEW9wl3Vzfu/cW8Ht3OP7KnoGovWKidUI3G6pX8ozBttEPG/JnpalYe07zuACMcu
         jLGeIfJYv2nztuCX+KvTHrK+faJ5qGAv//1m9GvUiQNTg4jWPF6iZi2qdhtunIvij4kD
         dHECqG/FHxdl/Rxag9h2EKePakRzXfuxaAUkx2M2OT39H3xziQDxdj5D0lP/XI3yNXS8
         d5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725851601; x=1726456401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcQx4vSk1WDBIFdGJdgeYgWLIddU3+oNu6pAPjOlvI4=;
        b=qKiKrDNlJZauRbRQG6sANgp3ea6s5q+/LZ+2ZckPjeglQ+k/TaiH8yXg++CPINVyio
         +LOZkl7ikEVyRrzxwwXa5zMC6QGY0BqIF0giHwvirRnDm6rl34rWsJiFjadbEVm8RU5H
         hEf2BFY2bJ8wzxVWE+h9FpPvFyZH4w3rU7Ydh3IsPXzJidp7Jqvm0spm9mYbQCf018jD
         sdI7VFnKLfqj0ERLPrbEIjb8F+BnW0Uhke8KhbazDGiouYf9JgyJcOUJasKgm/iuTjMg
         0NoF8ODMNUjsTNTSg1BmjtEo3ms/LJRbzDGkXp78x2GJDWLUVM78RrECYGEzt6djArvr
         oxEA==
X-Forwarded-Encrypted: i=1; AJvYcCVYg69v81ZYaGunsonjFdeAO6e1BmYjh7gi0TyYZBpa1z1ZVHaFYNvumWThWoPHIUW6thYM2tmcQJPfLdesDsdxla+v@vger.kernel.org, AJvYcCWjZY75dfeDHfJqqmWCzWFAdD2pbhZfk42DC1wtj8i9rJvEi9qWIHuMoGYZWS2v2JU4dnI=@vger.kernel.org, AJvYcCXlrM7MXvsgHGDcgYki3QKtgfKbiJRlYFa/N4+lJ3CJELPZfw0/PV8WTIaHD+HlSn8LLqwnFQZhQd/cZVQm@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaisZYGvwiw9OUmfYgYMzu9S+Uhh1YmzRGE8Sf/zIAX7ZaOXc
	J/Zs9gDR1Dl50jCssEpVow3DDGpkwvAlen8Wg6q7ds5cHPDPgIWdGvlB0pt+xLvmQKnUE9F+95v
	7BOKx3Zcpo0JQgDbi/WwH5Ij9gck=
X-Google-Smtp-Source: AGHT+IGaCZWvfZnq0huibOAYFMtLB/ByxZ0cAq1YXvND6Fb8vPtEgadkVGpblgM1NGP4MTMGBCO+xWcTKzlewwbHqV0=
X-Received: by 2002:a05:6402:3514:b0:5c3:2440:856f with SMTP id
 4fb4d7f45d1cf-5c3dc7bb513mr7657627a12.27.1725851600380; Sun, 08 Sep 2024
 20:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904065908.1009086-1-svens@linux.ibm.com> <20240904065908.1009086-5-svens@linux.ibm.com>
In-Reply-To: <20240904065908.1009086-5-svens@linux.ibm.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 9 Sep 2024 11:13:05 +0800
Message-ID: <CAErzpmugJ3Uz=YF9k-OBHehd3RrKQ4CrORsNXbngRWbQ_yoELw@mail.gmail.com>
Subject: Re: [PATCH 4/7] Add print_function_args()
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:59=E2=80=AFPM Sven Schnelle <svens@linux.ibm.com> =
wrote:
>
> Add a function to decode argument types with the help of BTF. Will
> be used to display arguments in the function and function graph
> tracer.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/trace/trace_output.c | 68 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_output.h |  9 +++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index d8b302d01083..70405c4cceb6 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -12,8 +12,11 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/mm.h>
>  #include <linux/idr.h>
> +#include <linux/btf.h>
> +#include <linux/bpf.h>
>
>  #include "trace_output.h"
> +#include "trace_btf.h"
>
>  /* must be a power of 2 */
>  #define EVENT_HASHSIZE 128
> @@ -669,6 +672,71 @@ int trace_print_lat_context(struct trace_iterator *i=
ter)
>         return !trace_seq_has_overflowed(s);
>  }
>
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
> +                        unsigned long func)
> +{
> +       const struct btf_param *param;
> +       const struct btf_type *t;
> +       const char *param_name;
> +       char name[KSYM_NAME_LEN];
> +       unsigned long arg;
> +       struct btf *btf;
> +       s32 tid, nr =3D 0;
> +       int i;
> +
> +       trace_seq_printf(s, "(");
> +
> +       if (!ftrace_regs_has_args(fregs))
> +               goto out;
> +       if (lookup_symbol_name(func, name))
> +               goto out;
> +
> +       btf =3D bpf_get_btf_vmlinux();
> +       if (IS_ERR_OR_NULL(btf))
> +               goto out;
> +
> +       t =3D btf_find_func_proto(name, &btf);

This is an excellent feature, and I am crafting a series of patches aimed
 at enhancing the search performance for locating the btf by its name.

> +       if (IS_ERR_OR_NULL(t))
> +               goto out;
> +
> +       param =3D btf_get_func_param(t, &nr);
> +       if (!param)
> +               goto out_put;
> +
> +       for (i =3D 0; i < nr; i++) {
> +               arg =3D ftrace_regs_get_argument(fregs, i);
> +
> +               param_name =3D btf_name_by_offset(btf, param[i].name_off)=
;
> +               if (param_name)
> +                       trace_seq_printf(s, "%s =3D ", param_name);
> +               t =3D btf_type_skip_modifiers(btf, param[i].type, &tid);
> +               if (!t)
> +                       continue;
> +               switch (BTF_INFO_KIND(t->info)) {
> +               case BTF_KIND_PTR:
> +                       trace_seq_printf(s, "0x%lx", arg);
> +                       break;
> +               case BTF_KIND_INT:
> +                       trace_seq_printf(s, "%ld", arg);
> +                       break;
> +               case BTF_KIND_ENUM:
> +                       trace_seq_printf(s, "%ld", arg);
> +                       break;
> +               default:
> +                       trace_seq_printf(s, "0x%lx (%d)", arg, BTF_INFO_K=
IND(param[i].type));
> +                       break;
> +               }
> +               if (i < nr - 1)
> +                       trace_seq_printf(s, ", ");
> +       }
> +out_put:
> +       btf_put(btf);
> +out:
> +       trace_seq_printf(s, ")");
> +}
> +#endif
> +
>  /**
>   * ftrace_find_event - find a registered event
>   * @type: the type of event to look for
> diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
> index dca40f1f1da4..a21d8ce606f7 100644
> --- a/kernel/trace/trace_output.h
> +++ b/kernel/trace/trace_output.h
> @@ -41,5 +41,14 @@ extern struct rw_semaphore trace_event_sem;
>  #define SEQ_PUT_HEX_FIELD(s, x)                                \
>         trace_seq_putmem_hex(s, &(x), sizeof(x))
>
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
> +                        unsigned long func);
> +#else
> +static inline void print_function_args(struct trace_seq *s, struct ftrac=
e_regs *fregs,
> +                                      unsigned long func) {
> +       trace_seq_puts(s, "()");
> +}
> +#endif
>  #endif
>
> --
> 2.43.0
>
>


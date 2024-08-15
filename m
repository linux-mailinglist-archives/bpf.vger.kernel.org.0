Return-Path: <bpf+bounces-37333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD7953D54
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C42860CF
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4081552E1;
	Thu, 15 Aug 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRG/LJax"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE814F12F;
	Thu, 15 Aug 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760644; cv=none; b=It2PbooxJnUpCgicr569U/3dbc+AvhoN6EQ8qGcq2XIvqsjxuNzc3uAq5bSccodgNXI1IhUn/tR369aBlNXkHzFzChnQEZPxHHZhZD6DjrGX40iMK7rerdG/LXoDgMG9buG4aXW8ipzLI0n+7yvVxETGYmNgcQHUc3H+liq80Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760644; c=relaxed/simple;
	bh=5gHL2W6+2LdrbOOiuc7/mt9rBJLzNQU5VbTap5irY4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyQPf1mPcKQaWf6dOuVQaZtoqbu5BJ4oWJ3IeQ2BIw413uIjXJ/OhbBqLfjuF3zEZ1QEVdiffLGXosXLsc7yTjNLePiZfvNH47KImHBlV+8ZY7yCBc2LHcKDbnNDbO1SBqW88c84+2jE9WzlsIzHUW4MKrlSP0TG4ZeSYprhSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRG/LJax; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso1037667a91.0;
        Thu, 15 Aug 2024 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760642; x=1724365442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb3MI3AyTHKAYC7F+1evxF8uf5GKN6AVavaMK377xno=;
        b=WRG/LJaxHZolWmnkY8kNOIz4DftQARvky39cgWw1+S9+5HP6q+wquodWiARJkqf6mL
         eTtFsr0ESDBox5oTJ/LPFjrxLJwQPaqLQfKL3RErWpFChQOeEfD+w7BmXbVlphOzloZh
         9HEnE8oJXRO5nvcu1p2bPsYWA+rXkBgYBGuhaRWtIBPDOH8A+jr42pOZNEHw85wDzk+r
         kmumXxuHPk0ckzsBZlyoj2HegxuQiEiHsJ1Pi3ydyLzXy136peSYVhvBa5ZnPuxmSrpN
         QcYT9+uVwR/K3+cTjAqBHnuux+rZsSPdd5LFVf2PkGnWZq5emxjfbX055DQdc0jA+WmN
         NZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760642; x=1724365442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb3MI3AyTHKAYC7F+1evxF8uf5GKN6AVavaMK377xno=;
        b=NuUqKVD+qrIEJ3WnAcKt8xJ7NzJ9lY90nUoI7k7bPFFdHeVMVTmxsbtv6xdudWDZvA
         gG+jJxAteP7zE7edX3P5sbILn35XZZTENiFIr8OcEjnj+tafYi7ZZ8wCmq70Aial6Dku
         ZLugQ72MBpD7vBvf4LzbNB0aJjQbJjurox6qvf6nopOcwJ382KPWdRUxjuUJ2fAnF0qo
         H/NHH9RfTex68+QVjVpxQl8+Zp7XJC9VD2VVNggD2BSibHRcjpqyYOdiK1y+YXEl48eC
         4YYI5MX/lVOGoIRciya6kUNlBAUz/fmaoKfyIkDp70eMTReQZKzAqFWNAquXBz+dpAsR
         k71Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQLxbDqvUTgkjfaSk07l381NkxReJmLpeI0tGTzK2UBIy6tnaCtEmqGBb0Fhk3RGYlwt6Hq1eHcPUB808tG8b4x+UP9PZzI0TZcnlosDN8xHrJrNgLjCNtTlwVtFyqCHr0SCWoLwDrZjCcYHryIRFatw+0O1d6NB8c3tWUUltI4dDp5/UI
X-Gm-Message-State: AOJu0Yzeivi/VuzvnCRqPXHdj2a815W634nzcagQ4q02M9SV8bFyE1eF
	+me+IXCDEv96R4PfZ23pd+0+t0G+1B1TVniN5tkaVcaoA3H6jexJ3yQQU1XS4QrGdc6KyvDShQo
	iyORaCl2ljnSxdSNiGHtqnEfYMnQ=
X-Google-Smtp-Source: AGHT+IF8x0g2NwhyPc5r0SlfDFXJpXXi6Asxaf8ldKXtPfS6lKjgWRo7oC0rXQtwdfV+sNlR9D70b1LLSAhHB3fMdig=
X-Received: by 2002:a17:90b:234f:b0:2d3:dd75:224a with SMTP id
 98e67ed59e1d1-2d3dfc7e4b7mr1288247a91.23.1723760642213; Thu, 15 Aug 2024
 15:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132831.184362-1-technoboy85@gmail.com> <20240813132831.184362-3-technoboy85@gmail.com>
In-Reply-To: <20240813132831.184362-3-technoboy85@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:23:50 -0700
Message-ID: <CAEf4BzZiO1XdiRcrNu6n=_cdxT+0zRnByCuL7zNi0Aw7ohUCnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: allow bpf_current_task_under_cgroup()
 with BPF_CGROUP_*
To: Matteo Croce <technoboy85@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:28=E2=80=AFAM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The helper bpf_current_task_under_cgroup() currently is only allowed for
> tracing programs, allow its usage also in the BPF_CGROUP_* program types.
>
> Move the code from kernel/trace/bpf_trace.c to kernel/bpf/helpers.c,
> so it compiles also without CONFIG_BPF_EVENTS.
>
> This will be used in systemd-networkd to monitor the sysctl writes,
> and filter it's own writes from others:
> https://github.com/systemd/systemd/pull/32212
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/bpf/cgroup.c      |  2 ++
>  kernel/bpf/helpers.c     | 23 +++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 23 -----------------------
>  4 files changed, 26 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b9425e410bcb..f0192c173ed8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3206,6 +3206,7 @@ extern const struct bpf_func_proto bpf_sock_hash_up=
date_proto;
>  extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
>  extern const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_pr=
oto;
>  extern const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto;
> +extern const struct bpf_func_proto bpf_current_task_under_cgroup_proto;
>  extern const struct bpf_func_proto bpf_msg_redirect_hash_proto;
>  extern const struct bpf_func_proto bpf_msg_redirect_map_proto;
>  extern const struct bpf_func_proto bpf_sk_redirect_hash_proto;
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 8ba73042a239..e7113d700b87 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2581,6 +2581,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         case BPF_FUNC_get_cgroup_classid:
>                 return &bpf_get_cgroup_classid_curr_proto;
>  #endif
> +       case BPF_FUNC_current_task_under_cgroup:
> +               return &bpf_current_task_under_cgroup_proto;
>         default:
>                 return NULL;
>         }
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 0d1d97d968b0..8502cfed2926 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2458,6 +2458,29 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task=
_struct *task,
>         return ret;
>  }
>
> +BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, id=
x)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       struct cgroup *cgrp;
> +
> +       if (unlikely(idx >=3D array->map.max_entries))
> +               return -E2BIG;
> +
> +       cgrp =3D READ_ONCE(array->ptrs[idx]);
> +       if (unlikely(!cgrp))
> +               return -EAGAIN;
> +
> +       return task_under_cgroup_hierarchy(current, cgrp);
> +}
> +
> +const struct bpf_func_proto bpf_current_task_under_cgroup_proto =3D {
> +       .func           =3D bpf_current_task_under_cgroup,
> +       .gpl_only       =3D false,
> +       .ret_type       =3D RET_INTEGER,
> +       .arg1_type      =3D ARG_CONST_MAP_PTR,
> +       .arg2_type      =3D ARG_ANYTHING,
> +};
> +
>  /**
>   * bpf_task_get_cgroup1 - Acquires the associated cgroup of a task withi=
n a
>   * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by it=
s
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d557bb11e0ff..e4e1f5d8b2a6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -797,29 +797,6 @@ const struct bpf_func_proto bpf_task_pt_regs_proto =
=3D {
>         .ret_btf_id     =3D &bpf_task_pt_regs_ids[0],
>  };
>
> -BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, id=
x)
> -{
> -       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> -       struct cgroup *cgrp;
> -
> -       if (unlikely(idx >=3D array->map.max_entries))
> -               return -E2BIG;
> -
> -       cgrp =3D READ_ONCE(array->ptrs[idx]);
> -       if (unlikely(!cgrp))
> -               return -EAGAIN;
> -
> -       return task_under_cgroup_hierarchy(current, cgrp);
> -}
> -
> -static const struct bpf_func_proto bpf_current_task_under_cgroup_proto =
=3D {
> -       .func           =3D bpf_current_task_under_cgroup,
> -       .gpl_only       =3D false,
> -       .ret_type       =3D RET_INTEGER,
> -       .arg1_type      =3D ARG_CONST_MAP_PTR,
> -       .arg2_type      =3D ARG_ANYTHING,
> -};
> -

Seems like you need to adjust bpf_tracing_func_proto() function and
move BPF_FUNC_current_task_under_cgroup into #ifdef CONFIG_CGROUPS
block together with cgrp_storage_get and delete.

>  struct send_signal_irq_work {
>         struct irq_work irq_work;
>         struct task_struct *task;
> --
> 2.46.0
>


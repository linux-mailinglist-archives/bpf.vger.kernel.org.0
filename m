Return-Path: <bpf+bounces-35582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475D93B979
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4279B21B7A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E777143736;
	Wed, 24 Jul 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlZdwK6z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22713BC3E;
	Wed, 24 Jul 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864190; cv=none; b=X4tFutTWwuyGneiw5YYvvwgvEhhZwjtWxKItV8GL1WXza1Nb3G6gbctvCsJeE3gZ+1YVU3l7cEkb9It9BuFFU8maxScFKf3s5IzoGOhBGKxZR+CfyhmrilqDDrLlLbNja4tOfk3SA6YBve0+9Z6xodyAAsz/T4BuNqPgUPmjKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864190; c=relaxed/simple;
	bh=v0cplce2tzPzwHLYMPoK1AW+JPhYPj6UsSiXffY89E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwktmXVoijM2DdcopU0GpJdWB6yGFkHvEKcQudTRSBRoScr7d/fAVxNDjGvtMlgZYpB/xoPpYa4xFko3eSI5g6kf+wH9Za1JRLewZSWsgNuUb7d6IR5NjPab2OxY10u8j+K3S3kbNqF1T5XKPskmKIKYFhHs8IqqmGFWMoYDMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlZdwK6z; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb55ff1007so277763a91.0;
        Wed, 24 Jul 2024 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721864188; x=1722468988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK2FM6lOlx5cfPYB46q0e/cGTyIFnUfJAfoncQFYXHI=;
        b=hlZdwK6zsannUaMx1szWl+q38NcNvykZQg03LPZ2KS9BFLn5jJuI0kkazFkMbiUjOZ
         Py7nEI5uOanJ+3+Ojv9zc012qREXG7nrDrG/xxrvuL2+TOZPcTR/t5jSjPjaWYn66UR5
         aq8bUplDMk295fF0Z+2ysbguQCALOANfzb9dwIGev280Vl1YX0yujAk8CQtfZeKnO0Jw
         IBt1ns/Mypq2Sf8JMIOU6MPNuDsNiMtRtpRx2ZLgUDb+u5H9KtW6+Ckjomlh5obU6QJG
         LUQgiJwlQyspcU9bvoKdjENWCjq7FrvnVCzeVPNBLDIJiMn6SyNWnoqC1kBPOdEElLsP
         HXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721864188; x=1722468988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK2FM6lOlx5cfPYB46q0e/cGTyIFnUfJAfoncQFYXHI=;
        b=oSpWIbJ6uz1IuS5+WX9OvTUar9DWsxBOTNguw5lu/Dl7bRo1ZdxAJDHSGBHMOs1GHs
         zcPQXzBUFzA5ykOHBDXJTb5g4wDVQdnA3ZKS4hNBPNCWL6I88gZdurRMCCNE4idxJRZR
         y5U8dKoaWgqpEwGwDbQ1+9rqTp5eYf9/HwJ51ZCbTs7STLsiP/XtcAO+4y0cl/iqZq8T
         bZtHTCCIq8YlpTsRvAVWM89RDXCXfkBRc6IjgqGSDCHnfckYTIuRypuvw059/skdmvRb
         C8ICN12Oph23BmxhHywsTxNE+yqLzvQYl5vMG6pLc4udPxsNdAGIWsMOfbf1ZPCeEAOK
         kRvw==
X-Forwarded-Encrypted: i=1; AJvYcCX8MMJLFTyyBnj3lhw+eGQAXTgaC5fW3bdFQhL/CC720FuGE0aJQY2vUUUNqBZylqvgKAEjxuqu0Q4VdvnymhJrmw7EQD02kup7mGuvzowC2uIqTJdfHPfd7ls8qQ1KofjZcK6fgTUQPXGpPiRkkVjPWLBseeUw5HFcTD5TOhmpdYi2fE6H
X-Gm-Message-State: AOJu0YyGCVV/Z+/v0ArR0dg8SuVAGvxyUieMNhpUvlHDRv0+wEjpX2q6
	FARZe3Vm7dfKrAAH+QQ3xUjJnxzBy2Wa9zin9g01EOLDGRrsLpOBleDgbDrO1MMXwvfoUmZtt1S
	mTgYeO6LsIjf3KIhPpE+R7Iof344=
X-Google-Smtp-Source: AGHT+IHGDfCHclzNg7U3IDvhSMvISBvenREVAyFtis0W8nr+Oj8JpFQImEbkv3cFy+WKNs0G8d/pyp5HbMArvIpCwxA=
X-Received: by 2002:a17:90b:157:b0:2c9:80fd:a111 with SMTP id
 98e67ed59e1d1-2cf2e9daf6dmr92137a91.18.1721864188408; Wed, 24 Jul 2024
 16:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723012827.13280-1-technoboy85@gmail.com> <20240723012827.13280-3-technoboy85@gmail.com>
In-Reply-To: <20240723012827.13280-3-technoboy85@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 16:36:16 -0700
Message-ID: <CAEf4BzZwCJB=1C3k+=9SCUQwWkaJusjxna+Vi6C3HypYwccooQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: allow bpf_current_task_under_cgroup()
 with BPF_CGROUP_*
To: technoboy85@gmail.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:29=E2=80=AFPM <technoboy85@gmail.com> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The helper bpf_current_task_under_cgroup() currently is only allowed for
> tracing programs.
> Allow its usage also in the BPF_CGROUP_* program types.
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
>  kernel/trace/bpf_trace.c | 27 ++-------------------------
>  4 files changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4f1d4a97b9d1..4000fd161dda 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3188,6 +3188,7 @@ extern const struct bpf_func_proto bpf_sock_hash_up=
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
> index 23b782641077..eaa3ce14028a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2457,6 +2457,29 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task=
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
> index cd098846e251..ea5cdd122024 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -798,29 +798,6 @@ const struct bpf_func_proto bpf_task_pt_regs_proto =
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
>  struct send_signal_irq_work {
>         struct irq_work irq_work;
>         struct task_struct *task;
> @@ -1548,8 +1525,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
>                 return &bpf_get_numa_node_id_proto;
>         case BPF_FUNC_perf_event_read:
>                 return &bpf_perf_event_read_proto;
> -       case BPF_FUNC_current_task_under_cgroup:
> -               return &bpf_current_task_under_cgroup_proto;
>         case BPF_FUNC_get_prandom_u32:
>                 return &bpf_get_prandom_u32_proto;
>         case BPF_FUNC_probe_write_user:
> @@ -1578,6 +1553,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
>                 return &bpf_cgrp_storage_get_proto;
>         case BPF_FUNC_cgrp_storage_delete:
>                 return &bpf_cgrp_storage_delete_proto;
> +       case BPF_FUNC_current_task_under_cgroup:
> +               return &bpf_current_task_under_cgroup_proto;

let's not change this part unnecessarily? It clearly works if
!CONFIG_CGROUPS, so why move them? On the other hand, this,
technically, can regress some BPF program verification on
!CONFIG_CGROUPS. So I'd drop this part, but the rest looks good.

With that, feel free to add my ack for the next revision:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


pw-bot: cr

>  #endif
>         case BPF_FUNC_send_signal:
>                 return &bpf_send_signal_proto;
> --
> 2.45.2
>
>


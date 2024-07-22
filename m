Return-Path: <bpf+bounces-35273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64482939533
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9085AB21AF7
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493223D0A9;
	Mon, 22 Jul 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYm75zr2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186038F83;
	Mon, 22 Jul 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682496; cv=none; b=pAznC+eTFTWbrc2ha/7HuzY4nT1rYGJ9yec3E+cTHzoVLnn1aAYKIfxyASf5PGuadnzpztN3pKlPpCog7QDXFhSIJxDrLWXPJe2HpfcZIvlgaetZqdbCl3MEmpJxvtRM8yk5bGxowYiYIkdM3a7E1qJXS+0MFLG/5QEMcjCzUJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682496; c=relaxed/simple;
	bh=Xbyd/70IHOv1ezkPeRZVUOlK4Zy9BuBOOSYr+GjtXjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDtHTIFwcOHU34k64s2WYuhPXaZcBjFv0B6S2XBvHI72/LBjR1H46xGvgyXqntcPFCTsKEjF0/3r/e2OIU5hKuXRHxMcpUV6TYfE71LZD2OSC9mC+0sdhcb8ZtbFe5NyvAnGllmsEiKCr7HUcfOQ7s6Spz0xmH+FAgf5BJYLTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYm75zr2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d316f0060so625277b3a.1;
        Mon, 22 Jul 2024 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721682495; x=1722287295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLNHOJdoQ1OpK4qxqT1/Vb6qgV4yW7MKmMSvNb+jevk=;
        b=LYm75zr2ucNXwhgCcqwAjda8W2r34SeXxeoDbwMXt0q+mYrm8ODeuJWgCWwoH3AQ53
         0mW0g9WZ54KflV/xowVzaYjXi+SOMsKQ5zxN/kXqLQRJ3HFnAu7TNvNJRw0BjN6JJ/vf
         11z9k9kCjPBX+tBlaQTaXNFiX0wu5ii5hAq0tl/xQbsTmvxiB+U2kKiti1TJ2/u9818j
         VawYvmQxT5YD9TfdxldPnjO123fJYbziUEDflY2obgVs1gUxsxcvXw7SWx1Glqd6Ri6L
         UXguq8fEykqaIQb4IIBFTi+BEGvnLK6aetvpiBgKAB9Ii5TmyJexln/kKteuIvyyFHLs
         7DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682495; x=1722287295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLNHOJdoQ1OpK4qxqT1/Vb6qgV4yW7MKmMSvNb+jevk=;
        b=I1FeoE8oAZf1ZGD0uGT3rcQ83ON+J28bghzjiAhIOnAfaiIsurz0DB7uD3qtDy6Hp2
         VlozvJrPZ9Yd2bxK9vq7W0xfOyM1Khs+b4/ORQgDyAmE0dDFxJ5+9Xyciivtqefk8UNv
         JORROPXy3aLocctsDzBT3qMEQ+gV1fCWXWPyHXhgqIQMIEC7nX0bJlZpFbs26biLTCUn
         fwBIRN+HtouEy1uApthA0/oyUxkrt5x7PRnVpaRcGcwryjMDUQuxWfPTIq+3fl7nIxG1
         Hb1pvtpXQs4k5dKJFT3ikCSAn/1Rk8L4L952WpyYtXaeCNHJB2ocJF9Xy5DoCMyc0Ejn
         43rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGZf+0Se/0oNqffTznd9EOVLicehOIY6nV/dNu85IaSnMWHAPjNicytTaAg4r9R64+qKef7WytkZq9q3jOJOBOo9SSY+S364eJ+b58jYY6gjplilwxLun8yAiekHSmEmSiJduM+o0aUd3OtOZbXzuYh4dzqh9eAnxUaRaLH62/+UH9fdeb
X-Gm-Message-State: AOJu0YwCI6PRQHDiT+QubIIckNu2p9BlvR80EyhoY5NlmCjHtZC3zifO
	DHbZE2dPTL6xf3FsU+LPrt7XVZ/MMIR309GKPOLZs/KQUNNvpz623/rVkJXjDgx2gM2sypKsz82
	+4dF+eLoXVsGOqs4Fql0P9b9h4fU=
X-Google-Smtp-Source: AGHT+IHfxRH5gJ/iWcX51rzb+TbNkPuOf3fN5Ga2EkXNJJCXLrrTS9QRLiA+Qsgb5/ys1MirkiBCuk5xVq8GLhhrvkE=
X-Received: by 2002:a17:90a:bd8f:b0:2c8:2cd1:881b with SMTP id
 98e67ed59e1d1-2cd8d11ca43mr150402a91.20.1721682494568; Mon, 22 Jul 2024
 14:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722182050.38513-1-technoboy85@gmail.com>
In-Reply-To: <20240722182050.38513-1-technoboy85@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jul 2024 14:08:02 -0700
Message-ID: <CAEf4BzbzPWCY0uJGNG-hBvDrUc_KMYNpQ2KnzFO6+K3ML6NcwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
To: technoboy85@gmail.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:21=E2=80=AFAM <technoboy85@gmail.com> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The helper bpf_current_task_under_cgroup() currently is only allowed for
> tracing programs.
> Allow its usage also in the BPF_CGROUP_* program types.
> Move the code from kernel/trace/bpf_trace.c to kernel/bpf/cgroup.c,
> so it compiles also without CONFIG_BPF_EVENTS.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/bpf/cgroup.c      | 25 +++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 27 ++-------------------------
>  3 files changed, 28 insertions(+), 25 deletions(-)
>

It seems fine to allow this, but also note that we have
bpf_task_under_cgroup() kfunc, which you might want to check if it is
allowed where you need it as well.

And the latter one is defined in kernel/bpf/helpers.c, so I'd move
this one next to it to keep them close.

pw-bot: cr


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
> index 8ba73042a239..b99add9570e6 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2308,6 +2308,29 @@ static const struct bpf_func_proto bpf_get_netns_c=
ookie_sockopt_proto =3D {
>  };
>  #endif
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
>  static const struct bpf_func_proto *
>  cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *p=
rog)
>  {
> @@ -2581,6 +2604,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         case BPF_FUNC_get_cgroup_classid:
>                 return &bpf_get_cgroup_classid_curr_proto;
>  #endif
> +       case BPF_FUNC_current_task_under_cgroup:
> +               return &bpf_current_task_under_cgroup_proto;
>         default:
>                 return NULL;
>         }
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
>  #endif
>         case BPF_FUNC_send_signal:
>                 return &bpf_send_signal_proto;
> --
> 2.45.2
>
>


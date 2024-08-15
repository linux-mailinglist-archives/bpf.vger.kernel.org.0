Return-Path: <bpf+bounces-37329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619A953D4A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8FE285B13
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1047154C04;
	Thu, 15 Aug 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljuaBqxA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6180B;
	Thu, 15 Aug 2024 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760356; cv=none; b=Wn7MeMyIMDEeKGGpAiKmYWaR1CRslI0y545R7n5+jfN/sOGXgAzrEUu7hq72Q0jHTnF1IQdzrwOsnxNORQAPtp2NuaFfKj3i58sSQLyfFwDDjwtnTzju+0LWOBYxGHFM4nze6zyvW/As9249QdRvevhe9yS1EMttPyh0HYCi9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760356; c=relaxed/simple;
	bh=icHSIu0l7pBrco4Eu2cNoXgmfprBwfnaEs5muYDiy20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j86enu4UxSjFLDJIv6N5AJJ4epiIIrKvaT2Wd9L11PDdfrmQ2SRbG68WImzh8x7qJfUXK/BtzuZO/V0oyZQ0U2mIQvESCd8BpxZdkApKNfjO/PU3PADXuWZb//9sHek+/Ev5eaUP9TElJ/nwTcL/+BboYXPiAk+91PqXgXmZMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljuaBqxA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so1039660a91.1;
        Thu, 15 Aug 2024 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760354; x=1724365154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLJHHKDAwig/AQRi9bGoaIZfCY+PqMjFwCKMZdglFC0=;
        b=ljuaBqxABx8qS2Jb4TdU4XyDTwzM2OSDI7GtXuyKhxgpEFpoeCKy3++r+m3XI157iM
         x6FluH7DNUTiKdaVoESZH0aQHbwJuxQtIFHI3L8r3os3va0YSKGxSV0Hg5Z3wBQcoZ8J
         tD9TB2BQGEaa+Dj9qcviAoMaJh79rNwevJqLcFTXUTesKUNh1TrTsyM2WjaYI/W7bRnj
         akTcD4fwuJef0jxodYpr26lOMZDH9YNoJltRkal60jhxd55GQkJcnn0uiOHvxr8epsvR
         IQ+DAkdyIcgVFhyN3dhJ/p3/inxgNRy4bZZaBYlJP7B4UO+83RCWWIA0Zu/YIs0BgY2H
         JlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760354; x=1724365154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLJHHKDAwig/AQRi9bGoaIZfCY+PqMjFwCKMZdglFC0=;
        b=GfKbgRmllFFMKKfP++LaRFuSAmMovkyehCU3ABX3lfkoVRYm9FOHqYMnYf2NFxthyH
         flOM39qp7dLmWPZXFVGeqddZbQn7glOkMadTGddCl8/Uhx0cvZiZKuPLFV9xSYfJoIO+
         /8Z5cqOwCTHe5R6ewMueGm3lULOYd3odtJJQD9C/mAFSSNFNJgGnWwr653e77tqqduOR
         q/+KTGDt6G5+yMfMiOKvepUqMSRUQQuTAZH0t2bgSJU59FnaJfTcqtwzLLlVGPUKKt4E
         LNZrl9JvBuFHK8FFp7G3xjlfx1HzHOvVlK48CR22Phbyi4Xd/Nz7+gE3IolMF671HA5v
         2ggA==
X-Forwarded-Encrypted: i=1; AJvYcCX4MV9qcUKrXXybizO9dYrG6Z2nF+m3pSKEit+lMjgU0k8jOQX9PhmWSw94jv5/NCTYj9qWw5mZ4lwLHGwbpGJS1U7UUy5xKILYzQxqHF2CS0EPsCYGhJ0YS1pRIyCqJsWvF9XDa7STnHqtDh0YInE/I8+GjhVuigZw9FISudDtBuHQGtlP
X-Gm-Message-State: AOJu0YzaXhJ1SrWpOkNyj1gthRMEVvafEOPx88G+QCkMkDSvYLRt5g6I
	c4n7zVFeELAJzkkZIkFpXIi/Yn+6YQIT4vkCXTG4x8Tkfq6Ge+8Fy1hiAQMkKuoBNMk3IvGIuEw
	QMVH13PtV0TvlMIBN1JyjQchuYcPNb8aH
X-Google-Smtp-Source: AGHT+IFG7mY0qYN+Y5hIyJtTq3AVU8LkUpa5/f8B367RmJz9R34MnxjEQ9P6YpDxp84/cNS2FYoD+Ad1Kk9lMjzUvA8=
X-Received: by 2002:a17:90a:5e0f:b0:2c8:e3e6:ec99 with SMTP id
 98e67ed59e1d1-2d3e03f2820mr1075505a91.43.1723760354003; Thu, 15 Aug 2024
 15:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132831.184362-1-technoboy85@gmail.com> <20240813132831.184362-2-technoboy85@gmail.com>
In-Reply-To: <20240813132831.184362-2-technoboy85@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:19:02 -0700
Message-ID: <CAEf4Bzbq6YoSW3VOENP6AKBXHXF6C2UJbreq6Y=bfGHA-e3YKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: enable generic kfuncs for
 BPF_CGROUP_* programs
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
> These kfuncs are enabled even in BPF_PROG_TYPE_TRACING, so they
> should be safe also in BPF_CGROUP_* programs.
>
> In enum btf_kfunc_hook, rename BTF_KFUNC_HOOK_CGROUP_SKB to a more
> generic BTF_KFUNC_HOOK_CGROUP, since it's used for all the cgroup
> related program types.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  kernel/bpf/btf.c     | 8 ++++++--
>  kernel/bpf/helpers.c | 6 ++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 95426d5b634e..08d094875f00 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -212,7 +212,7 @@ enum btf_kfunc_hook {
>         BTF_KFUNC_HOOK_TRACING,
>         BTF_KFUNC_HOOK_SYSCALL,
>         BTF_KFUNC_HOOK_FMODRET,
> -       BTF_KFUNC_HOOK_CGROUP_SKB,
> +       BTF_KFUNC_HOOK_CGROUP,
>         BTF_KFUNC_HOOK_SCHED_ACT,
>         BTF_KFUNC_HOOK_SK_SKB,
>         BTF_KFUNC_HOOK_SOCKET_FILTER,
> @@ -8312,8 +8312,12 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pr=
og_type prog_type)
>         case BPF_PROG_TYPE_SYSCALL:
>                 return BTF_KFUNC_HOOK_SYSCALL;
>         case BPF_PROG_TYPE_CGROUP_SKB:
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_CGROUP_DEVICE:
>         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> -               return BTF_KFUNC_HOOK_CGROUP_SKB;
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +               return BTF_KFUNC_HOOK_CGROUP;
>         case BPF_PROG_TYPE_SCHED_ACT:
>                 return BTF_KFUNC_HOOK_SCHED_ACT;
>         case BPF_PROG_TYPE_SK_SKB:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..0d1d97d968b0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3052,6 +3052,12 @@ static int __init kfunc_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &gene=
ric_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
, &generic_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &=
generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB=
, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEV=
ICE, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYS=
CTL, &generic_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
KOPT, &generic_kfunc_set);

So given all those CGROUP_xxx program types map to the same
cgroup-generic BTF_KFUNC_HOOK_CGROUP hook, why do we need 6
repetitions of the same thing?

I'd say let's keep just one (pick any, CGROUP_SKB, for example)
registration. And then we should follow up with cleaning up
register_btf_kfunc_id_set() to accept hook type, not program type. And
then it will be clean and will make most sense.

But other than that looks good to me.

pw-bot: cr


>         ret =3D ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
>                                                   ARRAY_SIZE(generic_dtor=
s),
>                                                   THIS_MODULE);
> --
> 2.46.0
>


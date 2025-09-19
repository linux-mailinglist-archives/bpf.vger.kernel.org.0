Return-Path: <bpf+bounces-69007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE9B8B92A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F574E333B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8D2BEC2A;
	Fri, 19 Sep 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7ORJ2E2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD620DD72
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322244; cv=none; b=Eh0NJYgz9rBlPc4o+STZx5Frjsg3bzR7DW3ywSZgNn4U+S5hvZPM1wabZv3qs0dED0cm8d3Un5Q2eOpKXWqhUiVzUNlUYVkozyzR1wcaALWvwe39G6tkaiYATU1HrCGmDoSnvTQW4xzZIVkqYOwvu4/T82X3n41rxqdPpuBdvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322244; c=relaxed/simple;
	bh=srk3tQGCt+JcCjtRzkedwXeQ0nOjYEJiSBZjD2j21lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmA0Q5XY6SeJJrXLViab/xtOyuTjRXYUQuHKG0ulrGAH5qKXpKLXG1hUWPlYGV4FpalZp/oLOfuUJyGUWxwjF8c2KuYu1nhZitm28WbHDLJrmOYFDIeLSJS0itHH5tEkFJ7iqIse/UxsA7iFJnvBLAeq1eLrynSeocvVzvS2URM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7ORJ2E2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so2900340a91.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758322242; x=1758927042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncxVAcplLY/qj8J+x8rmUBGn4YTMqx5VPLaWAJCfbS4=;
        b=B7ORJ2E2Oy+/0j6/ZhBYAEm4m4VIYwvRvCIQ30rT45HEaIro4bqdYlIuC5sYSwqs3Q
         HTjKNEuaeAEf9MSTqiuKGwxb6m6tp3ZaTVQ6dSJugLzG90Fq88uUF2cBIUkKHfqviET4
         TyV8jaoLXOihe8tH6jPONEDuc8fiOQczqvV1AzVEiEsdR9YIyVN+bdeXx0ejqz2uxT61
         STOw432nZG1+Pf7nrbGxsyXj6YdQU9yvDRPQbWb8FbbaJpVE9Zbbd9dkJ3WBr+ijSI6G
         klK8NpZmQgy2OXcFWpI+Am8rZyb6Ve9GxgiTVW+C7/mvR2ijRW6dVPxOS4OcVonAoF81
         woKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758322242; x=1758927042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncxVAcplLY/qj8J+x8rmUBGn4YTMqx5VPLaWAJCfbS4=;
        b=Fsc0P10MuBq93Fhc0McYKn1BeG9OxtCrg4o3jvwSKzYNPQx4SdDZa24xMxlKZ+1Ugw
         XxVn2gG74eD8aOIT86rvRYCwlqRQOB/G2d1GVrQ1huishqUClsP5pRBZRRzR+fXJWB9U
         ogLG7Up/yhbN+RIUUwxX+AA5GQRar9LmimDNbklCkzwP7438L1L83fLkX0G33OrMXSA8
         Xx+4Or7jUcRqzXiRjfxj9xz9QQM2K5ZcVOj+Tz3Dg4RYMpQA60slqhPv3u2X0UAToXpK
         tGYOEX4oNrQKLHb0mdEQaIUZ3phc9mtSnaZrS68s2a1lqJ3omoZJFo3boSOEMpufXSfu
         Uc9g==
X-Forwarded-Encrypted: i=1; AJvYcCWFIsS+9O2W8/OoSDqAU3aYjNbOuQk1nonrPuLp7LkoMRbJKQ7kfPUR+bdusq2fQl3P/EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LK4SBNpAIr2f5uD8BMcIY0yP9MyNDVLTLOn5xopANNX30rTe
	9pS+L5se4aPVlxwobrpx1eycE0xpDmWQ+LuJfHxgy2okc6j7fcXMxWpBmP/nCKWiI9ntAvSA/rr
	wUPpDJYmf5rWSwQs3wZGe340fuUOOE7Q=
X-Gm-Gg: ASbGncv6JaxlJE55vFFb/qyp3sEDurGl+hcalMoI54HxNmuytmO/EcbDpXBhNFWm8vr
	457qTNN+HuQnRg4P2sDZL7YGlneX1xJoV66OKuc3VPeeDiqGjdgMTxAcbs3imcwSXdKKleUmJvP
	wbskoxHRHxuTEqWB1W/wk949AwAJHfdfyKYBuechRcwBi9iFlduVPX1fOnmMCtH+wsjnB6h14c1
	58Nh7ztVcfCrxLjIji/H50=
X-Google-Smtp-Source: AGHT+IF0peO2YY7Fw7O86xxZEWLeF6XAmeRdd1HdOlgIP8gzwZrUeI0z2siyG4o8DrOw0Ek2J9Gr0WIbw/FEo7HPk90=
X-Received: by 2002:a17:90b:164d:b0:32e:e150:8937 with SMTP id
 98e67ed59e1d1-33097fd4137mr6903544a91.6.1758322241976; Fri, 19 Sep 2025
 15:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912233409.74900-1-contact@arnaud-lcm.com>
In-Reply-To: <20250912233409.74900-1-contact@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:50:27 -0700
X-Gm-Features: AS18NWB6NPyeHNKO4NrOq2GJyJN3R_ig8aHwgj1n_phhmlyfG-EirSUmkSi9Dy4
Message-ID: <CAEf4BzZ-ovqXqLJ5oJ95n9prFnXsLOkO1UvdycUcON77=Akv-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/3] bpf: refactor max_depth computation in bpf_get_stack()
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, 
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:34=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lcm.=
com> wrote:
>
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Changes in v2:
>  - Removed the checking 'map_size % map_elem_size' from
>    stack_map_calculate_max_depth
>  - Changed stack_map_calculate_max_depth params name to be more generic
>
> Changes in v3:
>  - Changed map size param to size in max depth helper
>
> Changes in v4:
>  - Fixed indentation in max depth helper for args
>
> Changes in v5:
>  - Bound back trace_nr to num_elem in __bpf_get_stack
>  - Make a copy of sysctl_perf_event_max_stack
>    in stack_map_calculate_max_depth
>
> Changes in v6:
>  - Restrained max_depth computation only when required
>  - Additional cleanup from Song in __bpf_get_stack
>
> Changes in v7:
>  - Removed additional cleanup from v6
>
> Changes in v9:
>  - Fixed incorrect removal of num_elem in get stack
>
> Link to v8: https://lore.kernel.org/all/20250905134625.26531-1-contact@ar=
naud-lcm.com/
> ---
> ---
>  kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..a794e04f5ae9 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *=
map)
>                 sizeof(struct bpf_stack_build_id) : sizeof(u64);
>  }
>
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace=
 depth
> + * @size:  Size of the buffer/map value in bytes
> + * @elem_size:  Size of each stack trace element
> + * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID=
, ...)
> + *
> + * Return: Maximum number of stack trace entries that can be safely stor=
ed
> + */
> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 fl=
ags)
> +{
> +       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       u32 max_depth;
> +       u32 curr_sysctl_max_stack =3D READ_ONCE(sysctl_perf_event_max_sta=
ck);
> +
> +       max_depth =3D size / elem_size;
> +       max_depth +=3D skip;
> +       if (max_depth > curr_sysctl_max_stack)
> +               return curr_sysctl_max_stack;
> +
> +       return max_depth;
> +}
> +
>  static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>  {
>         u64 elem_size =3D sizeof(struct stack_map_bucket) +
> @@ -300,20 +322,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
>            u64, flags)
>  {
> -       u32 max_depth =3D map->value_size / stack_map_data_size(map);
> -       u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       u32 elem_size =3D stack_map_data_size(map);
>         bool user =3D flags & BPF_F_USER_STACK;
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
> +       u32 max_depth;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
>                 return -EINVAL;
>
> -       max_depth +=3D skip;
> -       if (max_depth > sysctl_perf_event_max_stack)
> -               max_depth =3D sysctl_perf_event_max_stack;
> -
> +       max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
>         trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
>                                    false, false);
>
> @@ -406,7 +425,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                             struct perf_callchain_entry *trace_in,
>                             void *buf, u32 size, u64 flags, bool may_faul=
t)
>  {
> -       u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> +       u32 trace_nr, copy_len, elem_size, max_depth;
>         bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
>         bool crosstask =3D task && task !=3D current;
>         u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> @@ -438,10 +457,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>                 goto clear;
>         }
>
> -       num_elem =3D size / elem_size;
> -       max_depth =3D num_elem + skip;
> -       if (sysctl_perf_event_max_stack < max_depth)
> -               max_depth =3D sysctl_perf_event_max_stack;
> +       max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
>
>         if (may_fault)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> @@ -461,7 +477,6 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         trace_nr =3D trace->nr - skip;
> -       trace_nr =3D (trace_nr <=3D num_elem) ? trace_nr : num_elem;

Is this also part of refactoring? If yes, it deserves a mention on why
it's ok to just drop this.

pw-bot: cr



>         copy_len =3D trace_nr * elem_size;
>
>         ips =3D trace->ip + skip;
> --
> 2.43.0
>


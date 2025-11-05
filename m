Return-Path: <bpf+bounces-73748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D452EC38619
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 00:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FF4EC0D8
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5B2F3C21;
	Wed,  5 Nov 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz3dGCum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2C2D0C60
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385638; cv=none; b=sLjjQiXLSe3OuavowBljheGdL/V8/n2aLLK13kyLh0+5hgG73FFpt/SLoO3i0eGIUnU3mSZOsYmYKn3IUhsqKosTvFobm1M9Lf+tNlcTtEM1uqjCcog+EluBkbi9GrbBTew9vl3VoBROjix5k5ekbGfFVCQAFXQbmkDyaulgPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385638; c=relaxed/simple;
	bh=DY85F7w9n5W9EyWsPr9s7I6bxONhVevP0FIBVbj9NlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owhIaJ+LFxWJR3++SwfSnBszpPH5+pxfTEnWUy6YeT7mZcKBSIRJvHU1++BCm2PGQziAjL+blcmLz0WwNo7P2lhkCmRDBntvVuOK4O0aBTYwz7KJbxdjkARXor5p596HZlVMOD2Iq2L0CD1mWVxkQXHxa7DyweSvNiDK1pzpAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz3dGCum; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso342173b3a.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385636; x=1762990436; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1iDoj6IeeWtf5dP9neeyY3HaJEmQ5QSkOd5nz1eJUOc=;
        b=lz3dGCumAIf2Ae8hdzqeiFpinh/yLOP41OhLVSc58ekjWE6kKRxiTWyaZ7jD0mXqkp
         tfsO36LqjOX05OOz5qnO0ue4nctuEVaSFX/63KU5UuO8n5j8c+KScr3mKHOv4WuCoVy4
         1Wp+XsdEcMRNKFc2VLxlgPW2k535a9KrJ+5YphJ47bGJLj2NETCtjwINqS09tpt/3vy6
         0F4FM85fOp4Sp0Wv6Xz7w0YoY0m2Wh3uiC4dt/punXmEdvPnJ1Endqbk+7cYSU0QxdMB
         VtSBadnVwS7WpAiNlvsZlvcvOurgfPLzxBwGfdIlhnoNPUa4zC89+jsFo/yZFOvn8Uof
         yNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385636; x=1762990436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iDoj6IeeWtf5dP9neeyY3HaJEmQ5QSkOd5nz1eJUOc=;
        b=Kly7o9QoG9ToKxjZlvYUNDyfc8hqidhyTzbYEMvsFR3w1qUC+1kIzoiRF1W1w+kjVB
         FPf0PQumWos2DNfcaRNQXaLtJKDxoLjMa/jaPzxXzJpxWbZtNGhbh+3rLXtMPXQc9uuk
         TRid7KG5HjHONFK77r24eaOD2ks0lvoktVkP73jiCZQQeMvMPKjyBTKT/pkg8fmj2UN9
         1t9Ujt2KbOos6lKGYHdZesKlAQfmy6iXimJ6lcWZRFNcyG9jfvpaO/nKcxKHCn4B7Opa
         11jZEDMemBG5hrHx8Dl8OpBHxTYzBO0RlgK8Ju4B+8PYOpg+QBvdCynDJhw8i40EdHoM
         SKxg==
X-Forwarded-Encrypted: i=1; AJvYcCXCfrivpaB2RF+9J69QXI0t8+2taPst/Dc80IthwD8ESBzHzWhSZSyEg//yLTkdOKlc6Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsRVRV+vFju0/OqyU7FeQLpgN68NCBaBm27jiaUdzUCHIzSJy
	VcbXAAzQy/4zzoKYJTh5fbz5XYaEtSnTx76GXPICLTCoZcTuTSRSVayv
X-Gm-Gg: ASbGncu5furHpb9qBDWiWuldWu9jHbOqWmRYsKiQ4s5ZBEhaRdH6q6LWKCMcCd6CAIa
	MukOf0xhY+0cI/fNnXjW8LGvGWYUhZYipPVQMUqm8pjqbOJAh00pDi+gvQDQSTpAWB5jJQD0JfA
	194hd0J0szC0sWOaZlSSKzFd+EKiNJbL58wV1cabk2uLyDnOwPm1K5vrkpt5ww1qlUtaAcndcUN
	sxfOJK46zBBebusmOPJTOMID6BJcvXuDeZ9zHcWD45BbHW7zJYqn61uozv8Ninam2SORCYJYR7X
	u8WY/RsCF79mj+Ig69KCrE6Q1McYhv1AwJ62jWeCRa5i4cHarsJc+3lV7HOX6czWTTHOBcTCamn
	RMMjuND+w0sIOODX6yJ305Qdfe3tIoOmqvTMSB6jHoK4NO0FRUepZ2yoxxWs7T5bGZgZ9nhLSay
	PLWFVm5sHdwp+Hp8lANOGi7wOz
X-Google-Smtp-Source: AGHT+IH8xjOwjCaMRpqdraAbHYZuJ3W8Czo6y6eO8GoTDNWUfBBMZGHpExZZ0nH5L5fkLhcDzkgaxA==
X-Received: by 2002:a05:6a00:b45:b0:7ab:e007:deec with SMTP id d2e1a72fcca58-7ae1f983ffamr6579377b3a.32.1762385636370;
        Wed, 05 Nov 2025 15:33:56 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82204ecbsm570681b3a.38.2025.11.05.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:33:56 -0800 (PST)
Message-ID: <a0acd787192bef94c7da88c40c4693bc67876b32.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire	
 <alan.maguire@oracle.com>, Pu Lehui <pulehui@huawei.com>
Date: Wed, 05 Nov 2025 15:33:54 -0800
In-Reply-To: <20251105100302.2968475-1-pulehui@huaweicloud.com>
References: <20251105100302.2968475-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:03 +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Syzkaller triggers an invalid memory access issue following fault
> injection in update_effective_progs. The issue can be described as
> follows:
>
> __cgroup_bpf_detach
>   update_effective_progs
>     compute_effective_progs
>       bpf_prog_array_alloc <-- fault inject
>   purge_effective_progs
>     /* change to dummy_bpf_prog */
>     array->items[index] =3D &dummy_bpf_prog.prog
>
> ---softirq start---
> __do_softirq
>   ...
>     __cgroup_bpf_run_filter_skb
>       __bpf_prog_run_save_cb
>         bpf_prog_run
>           stats =3D this_cpu_ptr(prog->stats)
>           /* invalid memory access */
>           flags =3D u64_stats_update_begin_irqsave(&stats->syncp)
> ---softirq end---
>
>   static_branch_dec(&cgroup_bpf_enabled_key[atype])
>
> The reason is that fault injection caused update_effective_progs to fail
> and then changed the original prog into dummy_bpf_prog.prog in
> purge_effective_progs. Then a softirq came, and accessing the members of
> dummy_bpf_prog.prog in the softirq triggers invalid mem access.
>
> To fix it, we can skip executing the prog when it's dummy_bpf_prog.prog.
>
> Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effec=
tive_progs")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Is there a link for syzkaller report?

[...]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 248f517d66d0..baad33b34cef 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -77,7 +77,9 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>  	item =3D &array->items[0];
>  	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>  	while ((prog =3D READ_ONCE(item->prog))) {
> -		run_ctx.prog_item =3D item;
> +		run_ctx.prog_item =3D item++;
> +		if (prog =3D=3D &dummy_bpf_prog.prog)
> +			continue;

Will the following fix the issue?

    diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
    index d595fe512498..c7c9c78f171a 100644
    --- a/kernel/bpf/core.c
    +++ b/kernel/bpf/core.c
    @@ -2536,11 +2536,14 @@ static unsigned int __bpf_prog_ret1(const void =
*ctx,
            return 1;
     }

    +DEFINE_PER_CPU(struct bpf_prog_stats, __dummy_stats);
    +
     static struct bpf_prog_dummy {
            struct bpf_prog prog;
     } dummy_bpf_prog =3D {
            .prog =3D {
                    .bpf_func =3D __bpf_prog_ret1,
    +               .stats =3D &__dummy_stats,
            },
     };

Or that's too much memory wasted?

[...]


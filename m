Return-Path: <bpf+bounces-65465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A35B23BAA
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95BC3A41B6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592CC2DC32F;
	Tue, 12 Aug 2025 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBH1HYIN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD429E118;
	Tue, 12 Aug 2025 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036357; cv=none; b=Yk2Xkxc9XkMx57GQQgnDje7z79gPbszdoWVNhLF3eRYI+m1qBKwgeB2e6TJ1Fe/xeAeGdrMmgBA5+ToE0R+9BiAEAmWoaWHXA/8bxAcUDYe1GwhELBFZxac4pI4SEhzBq8T9eLDH7h3PJYSZ0SjSjpvxYyzpWd94qfub4/Hx5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036357; c=relaxed/simple;
	bh=7vU9b2/WLgLlkhPQGcXM/AT/0+Xalwd2JBYFg8y5ghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIwI0aRC+o5Sx9ZVlqczcXeX5SXwb39q6QVLSHcj5CDsaBpC9QcU0DZIi/w+H8N/2rQDk05U1s4zWUnsJ3JiYgUkVqi2YDMmBAc1cwdCDdF5WSxtb4Nsbt6jKrnDmurXsvbjpv39C5JVSpbaXGHr30Io0zDixTB0H31+aKi1vpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBH1HYIN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3218283cf21so3823008a91.3;
        Tue, 12 Aug 2025 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036356; x=1755641156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K19hmRrCGq8ySmSs4QmCJw+lx+t8zsWX4huMnV+KYw=;
        b=fBH1HYINGDctZk9XCI9vR7oqhnmhpuUqyeeW3CE5SP9mfCGsoHFFIyetWKcXu4ADkD
         gaMyaR/2ttAa3edDHV+uq+LCTd5yNeFtWV39hM+kX2rRGW+YJxYeed/8vHWxVpur8yb5
         hr8l69limWDnNDezDIyambZnMO1yWvuc9sXfEURfx2BpcHYu2sW+BapyeqmAL3rJJ7l7
         p2gk+hcLTRz85jPIA0XpfjIDAnb8LUdbjorwVMZ3CMJpISyk+MbEOKc7O77mYD7zLBkJ
         oNxXULWupnK/Ss/wU+yIePbnGvwtvd/tkyOHvUXQ3mR5crppdWZJGCWvySdg826RUT/Z
         KHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036356; x=1755641156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K19hmRrCGq8ySmSs4QmCJw+lx+t8zsWX4huMnV+KYw=;
        b=r3tQZQcwS2PsJErc2My3c8heyVRUKlSZ9yr01mBs/0DJ5GO2RxFVfVh6wIPwRkFxC5
         U2S3iqPFyLR1Qmnmj845UDrwCie8ODBqdlKNMPvgxqzuL8IMbhkqgg0F9PiniSAFJgyw
         8DsRthDOXwR9ZjiMFk7Kb4wDBXxZSB3tvRUX3R5WQb5gtBbKz7kt9lshjlLuIUTEbQvJ
         kZ5qvr3DXpzj/AJYhCo5+yT/WXwRVtvbW3KDqn9R3aPO/BlBummfgkFbqiy4SH7eVLf2
         ZzD04n6Aks8/rtpUe84CRhrUh4ZtPfqx9NJDiixcCUHuxBncoh+L6HFDaVrJLFnyBnX3
         OaFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKtFIzWp3N7r1PVYflWF7RrdxbwT1ssY4n0ZlkfNVyqAYQxVPkY9ykjPkD+QKRuuLZa2g=@vger.kernel.org, AJvYcCWU7UpbZsIwDqzinKRdB7lUTjkwXMuYszTusqLPnde4aBL7is+D5ZFNAJsRi561IlLO11/hNtNEx80hq/X9@vger.kernel.org, AJvYcCX1mb6lMrfjnKXIFbN/OQE8xVCOWHPXNeusNu+GLCXCZFb7X+e2BjJOGsoCkm68J5WAkZ04BpFy43S7NgTB+ZGY34d7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2uKZ1eVF7m7qCj4P2KNG+Gw3C3bZJdk5UW+sBVpmqa4pgvXX
	n00FEcwMo2IlQbcd5FDc/8nAwYElOaiwPIVNJvaNpb0PZTg5SC8h5CPdUTxR7//hk20dcjV0itN
	ECzYBcQzOF7QRvMWueY17N8GgsqQ0SijMeYZE
X-Gm-Gg: ASbGncuwDeLLWevQc2fxz28mPZ4BOmxL0Alsrf4R/stk1NHOd5Kb9zszgZ7NGN8yGUp
	gACwea8Y1veKIGC/zooJDTR6Aa94xMu6b61kOSFVZaLTqUrDqT9thuVGMkUUsYZRqQKWDdvk96X
	yEuK/RghGVhpCn7/hYyWFRvRz6hdoqEcgmnoATSWJ0B9z2q2SEIOjq6dWHIpM6BXljdbbQ06m9Q
	D4EEPQYVwMGJT7gFuj/s68=
X-Google-Smtp-Source: AGHT+IHFdFm/t+gCO48q6ASsX7fi0/iT6wy9cCDmPb3p84rqTNdHO5whpONfWcHPLPEzYdpQgkUexWYzdN0f53r1mdw=
X-Received: by 2002:a17:90b:2889:b0:315:c77b:37d6 with SMTP id
 98e67ed59e1d1-321d0ead31dmr762446a91.23.1755036355658; Tue, 12 Aug 2025
 15:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805162732.1896687-1-chen.dylane@linux.dev>
In-Reply-To: <20250805162732.1896687-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 15:05:40 -0700
X-Gm-Features: Ac12FXyl0-HsasWd1Isl9YCPBEnUDkqMYJ3nGywa9HCKiqliAnYBZl7feFZ4rEw
Message-ID: <CAEf4BzZduEdBCzm56zwgrHpzV=CsMbzfVi5oR9w3H4vUQL6FYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Remove migrate_disable in kprobe_multi_link_prog_run
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 9:28=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> bpf program should run under migration disabled, kprobe_multi_link_prog_r=
un
> called all the way from graph tracer, which disables preemption in
> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
> need to use migrate_disable. As a result, some overhead maybe will be
> reduced.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> Change list:
>  v1 -> v2:
>   - s/called the way/called all the way/.(Jiri)
>  v1: https://lore.kernel.org/bpf/f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@lin=
ux.dev
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae..5701791e3cb 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_mult=
i_link *link,

even though bpf_prog_run() eventually calls cant_migrate(), we should
add it before that __this_cpu_inc_return() call as well, because that
one is relying on that non-migration independently from bpf_prog_run()

>                 goto out;
>         }
>
> -       migrate_disable();
> +       /*
> +        * bpf program should run under migration disabled, kprobe_multi_=
link_prog_run
> +        * called all the way from graph tracer, which disables preemptio=
n in
> +        * function_graph_enter_regs, so there is no need to use migrate_=
disable.
> +        * Accessing the above percpu data bpf_prog_active is also safe f=
or the same
> +        * reason.
> +        */

let's shorten this a bit to something like:

/* graph tracer framework ensures we won't migrate */
cant_migrate();

all the other stuff in the comment can become outdated way too easily
and/or is sort of general BPF implementation knowledge

pw-bot: cr


>         rcu_read_lock();
>         regs =3D ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr(=
));
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>         err =3D bpf_prog_run(link->link.prog, regs);
>         bpf_reset_run_ctx(old_run_ctx);
>         rcu_read_unlock();
> -       migrate_enable();
>
>   out:
>         __this_cpu_dec(bpf_prog_active);
> --
> 2.48.1
>


Return-Path: <bpf+bounces-65069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1FB1B7E7
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5C62428A
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27A291C0D;
	Tue,  5 Aug 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7qBOpXR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918D2918EB;
	Tue,  5 Aug 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409878; cv=none; b=Lt1gVSru4Xvo5YZNqweCq8yTEqT1LmnfcXjKSlaUDr8iTTm0EVxjB6MsKE/B71VVPSkBGcUIwyEJ0rK0aqYVQT1UQ1MHsETKloO+tE1fa1AA9dIacJnSDFuM+/BHKsnDd4VU0ocjQwuBA8lLlPGBU2cYjhr3hBYMxYgeFKiBxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409878; c=relaxed/simple;
	bh=VThxAdB/2Y+Jdt40uJjus0ud/1yWXgDqWmk+TaU2VcY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL4VPWnA3qJGu67EhgqqU7nEUFA2mW8UL5/GuEmytSgJ8UFCzjTPQQILsBN+2QJbQrx14oz0GDdh6JAgTX7J21KLSNk/zVyL/rgXjVxyS5Y5r1EvAazeI6R98SOD9Z29HZQnPxpNnK+HKrv+LXoPHrXAPn03s8t/WpsXQwZo76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7qBOpXR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af949891d3aso473976966b.1;
        Tue, 05 Aug 2025 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754409875; x=1755014675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zW5XnwvRnVdJJ+cAhOOasohl6rlynnfn9jddIi3nc2M=;
        b=f7qBOpXRjx4DDc/FsbaldeElEyktIelZANf7BUd1M+NC94cl9HoRhRk+TeitJa+kq0
         TAEF4HKP5jPCEV8Uj9ekvR9Whq9xl9jKeohyEGpsSDXtkCRULvIbE88fB93b7bhS1itS
         5p+XEIsm/aVB8OkAqcQ7JaYm7QzZsCIjL89Uz7/sv8CRcQFmkFfnEd5Z91t4o9fZyhzn
         /oE7u2QfyxtxOi/jvDa3Co/ryPVuZt99CxrJH+swWHcrXOzhh4zJT+Trm3yB9XCKEYg3
         YVF/s0jQ7uRU2bWDbIj6Ga8bErWCdCt5oi6D6Th1hpzpgZFdZpM78ZCNGVCmvQjZGwE0
         SK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409875; x=1755014675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW5XnwvRnVdJJ+cAhOOasohl6rlynnfn9jddIi3nc2M=;
        b=BHJSszswcV0F/jWpjpNX1rVU9luD4kqGQmMjI5B5xY67Kk5EYjPaH419OfOJPOkweQ
         rUtsNMFq9WDdENaLgUnxzRkmByQmLc471r+0yU70dmQabDf+n/KC9E9oziFgBd1q12EN
         q9eBwS+M2DDpEfS0n+VNa+43v5qX0QFZ/qA2rS/frxnHt2jwDMNLPYYGkwMdYAfdIjGp
         WDCWNnGNPpJCPC1g8zvbm2m+eLjWC7s+v30Fsdo3RCn07Zyi+RLni54ynnoV/BQM0pQz
         uRArBjLkHo5IgRTZeoJ06xQoFrZAbrp5jOpjnyesx8l68TQndCQCpWy7IytEHvbd432K
         Xecg==
X-Forwarded-Encrypted: i=1; AJvYcCUBM/h9UWVSgzUK2JOJMI3pjLw9gOf0kgaGVw2euS0JwpsW0/WXiM+BqvGXHhX/2rF/12BfDe8ppXgyLgPF@vger.kernel.org, AJvYcCVB/5oR+kf4eY8bTnT/yNZm94tLM3vgXE5fg3ylwpR7D39lHcWR2j5NmsJszmt/3imcP1A=@vger.kernel.org, AJvYcCWcSU7nlhHGIbiccDNdKQ+opgZvR78pTxX4Hi6l8T/x4pKTjkmsgJ+mYwYLW4DZqz3MBohQ69kUUaDKk2ejqe+pnYJ/@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDU6h6lVgb1ODEOwWcf+32PBfcAMcqQu1NsrBtajct/dJjoUR
	j1eeAlghuHy3fiA1rIYq47ZTMrsWMjlbFvfLZACoWLkbBWZc8YP9mJG4
X-Gm-Gg: ASbGnctjABGIcNfYi7lfgLPEGF3lXUbEg+omCqB5W6yI4FwqL94ObTFbbV5q4JqlmFW
	jM3q6Du5yA17XqI0oMw/ml9kbWeKxvp/Czr9io9fbdjeWgKGzGm2glGNYxpCTuU3/4tOAD1YRRk
	63n5hU7MZRc6G376ky8G1IsKaKar0H8p9mGzFhNYQNvVFnmdb8EaMP9dbNWjs2gHSIAFpq7+vGk
	jpai4yb6IPoslY5hpPenMg9gNC6+fkXGhvH26PYkFmcqWAn6HPmm2W3HFu77oXhGzDJR18iT3eF
	R+++0r4us6ANHIC35kB3eIwNQouE7NndVhnHdrwBMPL+20MfQ+uJx9yQlt5Q4/2cjwc/l2c1Flp
	2spgIgfbNGEIHe2SVQKOF
X-Google-Smtp-Source: AGHT+IFsGbxoitQgaDTuWWerUcysDhLNpOtjOqjhEDRPOvL4+sN45YmfmemONRCxs+DN1AEwjFAGwA==
X-Received: by 2002:a17:907:72cd:b0:ae0:d804:5bca with SMTP id a640c23a62f3a-af940083b73mr1507588266b.17.1754409874653;
        Tue, 05 Aug 2025 09:04:34 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92b650c8asm790559666b.65.2025.08.05.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:04:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Aug 2025 18:04:32 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
Message-ID: <aJIrkAWK4ob5rCZ5@krava>
References: <20250805122312.1890951-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805122312.1890951-1-chen.dylane@linux.dev>

On Tue, Aug 05, 2025 at 08:23:12PM +0800, Tao Chen wrote:
> bpf program should run under migration disabled, kprobe_multi_link_prog_run
> called the way from graph tracer, which disables preemption in
> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
> need to use migrate_disable. As a result, some overhead maybe will be
> reduced.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  kernel/trace/bpf_trace.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae..1993fc62539 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  		goto out;
>  	}
>  
> -	migrate_disable();
> +	/*
> +	 * bpf program should run under migration disabled, kprobe_multi_link_prog_run
> +	 * called the way from graph tracer, which disables preemption in

nit, s/called the way/called all the way/


> +	 * function_graph_enter_regs, so there is no need to use migrate_disable.
> +	 * Accessing the above percpu data bpf_prog_active is also safe for the same
> +	 * reason.
> +	 */
>  	rcu_read_lock();
>  	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>  	err = bpf_prog_run(link->link.prog, regs);
>  	bpf_reset_run_ctx(old_run_ctx);
>  	rcu_read_unlock();
> -	migrate_enable();
>  
>   out:
>  	__this_cpu_dec(bpf_prog_active);
> -- 
> 2.48.1
> 


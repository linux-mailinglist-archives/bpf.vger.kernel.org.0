Return-Path: <bpf+bounces-21395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6084C758
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 10:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26C31C23255
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E2219E9;
	Wed,  7 Feb 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L14RdYo0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0E23741
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298182; cv=none; b=TeTUOAfxDX0lG79S7RR8uZtfmJI4KQ/Ui//ElAYgRUlnae5qpb/2WOJwNddrYwi/4OcWBPkTIYSKeOCWNzgpMrTobyP0MoHSpIiIQd/M5ynkrehrXDhSZJ2PtBkn9zbtPY144n8cv4hl8fmEK1cg3qrGFlDeHqDobjMaoD55sWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298182; c=relaxed/simple;
	bh=2E6NM8NN/7ZLpODDmIG1m0B2ICRCHHzRYB//XRCEnrQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3IaEwMtfr2y4ffT3w6B7rJwNWRFCk8aLTjodzQfnGwWD3Z9besCvW0picHfuJ9mzklrQwlXXu9vWgdc43bYCZCi0LDCD9wW2fKSJWSYGoLG0xqCHrQbEtaAb9lz6ixzVGPve1+HHu1OWtlqGZ9f8aW8GHpeS9jXtscf2jcjkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L14RdYo0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3832ef7726so47200866b.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707298179; x=1707902979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwd1V/Fb3PIyVO4NJaaO/+/+xz1if385OnGeDhl/S/0=;
        b=L14RdYo0TZbt3YYH3kSL2NHiray0OvyZ0LRFJu7POT9FYIhE+aJb5FAFDEs9BmG52N
         EaAhYEIXqYDhgie3FlOFhavyZx3fePMjVdak6LqU2XNyLlMOXlv2lYbvfX6GSch+geMd
         NXl+oBCudgdgi3C3DAX//zxqvsTk8iDzJFys8nSizQttzUhX0uEGBTZ658DNnnpS6hfX
         cubMjm8mDX4/Jfp1hcoSthuMNx+GFNQgPT7LfJHwvYUX0Op5vdeHeeaFw+ekkbK2KpVV
         x9rnzclkVRLJpXafiH2uQmntFAMZXpyyrpnG/mPBEhXgQqCED87I6QF3QetFocj0xG7b
         Eojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298179; x=1707902979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwd1V/Fb3PIyVO4NJaaO/+/+xz1if385OnGeDhl/S/0=;
        b=HYKZiowOUxqbG5NCuFJcoCoiGoph63EsI1IQWcYH22bVTTrjnoIiRQnuVM7hiyJ09z
         JNSV/DtWtNJlZlK9aVfD+RuRlrL8HzDDslDET/zDET+BpKxoagQBCobEIclrmBGwVnAR
         GgzDA/zOzBcVUajLtDlf9v3zg4H7ndZls56MFpfPhPUbDxG+OOw4B8uaPRBjOfTjNlDn
         2b9pwU+AEkx3aQheeDz1Yw8sy5uCdJuYMvgO6QUiiODDK4qeQOQiBdPeltEsJojhojSt
         br9CFm9epYq6F8LG+zpAQS/q9IiWJrZ73FitGWRhOXwfGLosuZAm5z2ZghKWiEmPpTZD
         35Rg==
X-Gm-Message-State: AOJu0Yw2g2wcjwTvQpEFp6LLqhePNHWsA/dXBwCq4KcdtXwzJVwU3ZVn
	870HedNO36HI0AkdpqnruOtvUNeSmWhJQW7sGaxk1xucUhexTbdooldafXCgNqE=
X-Google-Smtp-Source: AGHT+IGZPoEBZnpcZHa8zAP/c0ZrkzOdvYt2hoZ53X0bQPqm9ZIY+1GE2b5gIPKNydhPgr+/d7CQZg==
X-Received: by 2002:a17:906:3153:b0:a38:52f0:4c49 with SMTP id e19-20020a170906315300b00a3852f04c49mr1617555eje.64.1707298178577;
        Wed, 07 Feb 2024 01:29:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrampRKHAHRkXzwReD36382aJeHG999ESuKxBJuSSC4mG+PhFmwb1SparN9ms8BcNqWn7hs24oPoGt/hrjU0llSfFUaQIiZ8ewFYETF8Us5rlbZNc+HiAH9LIzNiNQOH14UYAG/s2NkZCikHqPU80l4MS90++5Hc0Sbqmc7Itl5hJdwVN06xc60xiG2HLA+FvIz8I66fwN94J4B65UyANsO9JJMVd9Jm5fhRoAoQ==
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id x27-20020a170906135b00b00a359afad88dsm552354ejb.10.2024.02.07.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:29:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Feb 2024 10:29:37 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Mark bpf_spin_{lock,unlock}() helpers
 with notrace correctly
Message-ID: <ZcNNgQo6HQl0uNQ3@krava>
References: <20240207070102.335167-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207070102.335167-1-yonghong.song@linux.dev>

On Tue, Feb 06, 2024 at 11:01:02PM -0800, Yonghong Song wrote:
> Currently tracing is supposed not to allow for bpf_spin_{lock,unlock}()
> helper calls. This is to prevent deadlock for the following cases:
>   - there is a prog (prog-A) calling bpf_spin_{lock,unlock}().
>   - there is a tracing program (prog-B), e.g., fentry, attached
>     to bpf_spin_lock() and/or bpf_spin_unlock().
>   - prog-B calls bpf_spin_{lock,unlock}().
> For such a case, when prog-A calls bpf_spin_{lock,unlock}(),
> a deadlock will happen.
> 
> The related source codes are below in kernel/bpf/helpers.c:
>   notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
>   notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
> notrace is supposed to prevent fentry prog from attaching to
> bpf_spin_{lock,unlock}().
> 
> But actually this is not the case and fentry prog can successfully
> attached to bpf_spin_lock(). Siddharth Chintamaneni reported
> the issue in [1]. The following is the macro definition for
> above BPF_CALL_1:
>   #define BPF_CALL_x(x, name, ...)                                               \
>         static __always_inline                                                 \
>         u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
>         typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
>         u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
>         u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))          \
>         {                                                                      \
>                 return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
>         }                                                                      \
>         static __always_inline                                                 \
>         u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
> 
>   #define BPF_CALL_1(name, ...)   BPF_CALL_x(1, name, __VA_ARGS__)
> 
> The notrace attribute is actually applied to the static always_inline function
> ____bpf_spin_{lock,unlock}(). The actual callback function
> bpf_spin_{lock,unlock}() is not marked with notrace, hence
> allowing fentry prog to attach to two helpers, and this
> may cause the above mentioned deadlock. Siddharth Chintamaneni
> actually has a reproducer in [2].
> 
> To fix the issue, a new macro NOTRACE_BPF_CALL_1 is introduced which
> will add notrace attribute to the original function instead of
> the hidden always_inline function and this fixed the problem.
> 
>   [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com/
>   [2] https://lore.kernel.org/bpf/CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2srJnef0ZrQkZew@mail.gmail.com/
> 
> Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/linux/filter.h | 21 ++++++++++++---------
>  kernel/bpf/helpers.c   |  4 ++--
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fee070b9826e..36cc29a2934c 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -547,24 +547,27 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>  	__BPF_MAP(n, __BPF_DECL_ARGS, __BPF_N, u64, __ur_1, u64, __ur_2,       \
>  		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
>  
> -#define BPF_CALL_x(x, name, ...)					       \
> +#define BPF_CALL_x(x, attr, name, ...)					       \
>  	static __always_inline						       \
>  	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
>  	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
> -	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
> -	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
> +	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));    \
> +	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))     \
>  	{								       \
>  		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
>  	}								       \
>  	static __always_inline						       \
>  	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
>  
> -#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, name, __VA_ARGS__)
> -#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, name, __VA_ARGS__)
> -#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, name, __VA_ARGS__)
> -#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, name, __VA_ARGS__)
> -#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, name, __VA_ARGS__)
> -#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, name, __VA_ARGS__)
> +#define __NOATTR
> +#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, __NOATTR, name, __VA_ARGS__)
> +#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, name, __VA_ARGS__)
> +#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, __NOATTR, name, __VA_ARGS__)
> +#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, __NOATTR, name, __VA_ARGS__)
> +#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, __NOATTR, name, __VA_ARGS__)
> +#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, __NOATTR, name, __VA_ARGS__)
> +
> +#define NOTRACE_BPF_CALL_1(name, ...)	BPF_CALL_x(1, notrace, name, __VA_ARGS__)
>  
>  #define bpf_ctx_range(TYPE, MEMBER)						\
>  	offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4db1c658254c..87136e27a99a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -334,7 +334,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
>  	__this_cpu_write(irqsave_flags, flags);
>  }
>  
> -notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
> +NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
>  {
>  	__bpf_spin_lock_irqsave(lock);
>  	return 0;
> @@ -357,7 +357,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
>  	local_irq_restore(flags);
>  }
>  
> -notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
> +NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
>  {
>  	__bpf_spin_unlock_irqrestore(lock);
>  	return 0;
> -- 
> 2.34.1
> 
> 


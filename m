Return-Path: <bpf+bounces-38620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FFB966CBF
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54071284BA1
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA718DF7F;
	Fri, 30 Aug 2024 22:56:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FCD15C150;
	Fri, 30 Aug 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058577; cv=none; b=G4CEgI5z3xG9e3N9R7eX9GL+vMqLJmmd4R2f344YQzamb2bD/myGUCMNghQ9IfuzWLwYhAT1bLEcnnQ/g5joAFnx4m3pu4tBhmvsBoDNQ7tEhL1hW93uIvc6ewSB7sJnLu78Pxisq8gSeNXD1X+mCtpJt4Qz01gs4ATCvTaOTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058577; c=relaxed/simple;
	bh=8XF3vmvNdNn9zLKrZfImEFFGflqsckIYF0ke9GOgNEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoI+kgcLTmc7kwDvDj2Ziq5RAmLaJrl76EZov8D4WUmvoQM0ALWCj02/SHjnKVY1krzDL5iB1h+aNSeg2Gy3Rd7v/50uofg9NCGXaDmGxMLh4A7uX0bVOJ2kQyys4dJ/yi0E58+xGquGe1BYBaz8O4TT1cuppJuPbEElFvRoJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7148912a1ebso1505523b3a.0;
        Fri, 30 Aug 2024 15:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725058574; x=1725663374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeH8hxTVMFEpq7p+SlKqJlF16p+IrHAk0EJziH2/pls=;
        b=nNcyosSl9EUljUD2AxlzbFXqGDivqmhNZ5ZRdsoqjCBCuUpfcVu94sDe9A53cp4avG
         eGziM0fR4MDIBPkK4lVggr8IxQyoDJiJF4cww7y69Iqew5zlZULw6/Upb9RuKkSIfRY9
         STHhh/7KcQ1eR+pEYA/JYdVAW889b1SzaKiWvRIRhnyWp98O37auN6zKZ/5/JrYlxgJm
         2O9fv9d0aLgGDIFMmKw8hhdYxndQBihKuIMNcYxM951Ob/gfOZRx+T46Iw1LWxGlPysR
         fCrdiPHuJd/X/MsiKgpVY1nDq2VngdNNCsdD5QfD407tjQmXJj5GIZ0d+NRLjlNuYp6W
         8S5A==
X-Forwarded-Encrypted: i=1; AJvYcCUUgLKZFF8436siSkKW97I67seiOVtt/vRxN1Aty+dQp/vv95lfeIBzk2eJXaXbpPJz5xY=@vger.kernel.org, AJvYcCW5omjajJU0Pqr4c+zq3UpK0VnLafmPgKTluRPigF17ZMfhDzLWPuLJ3vlLNJv7s1HelkuVS1P1nJcYuSnN@vger.kernel.org, AJvYcCXJEoYjKNAq6XJDXOnvr7kiv8kfrUqH+jcogIrWIuBB3byPYP6KreIpQCMJD1hwYnuWtvXkXgFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOeGt5lNjPwgDQYASgGeHov+uOMrtLZREvv2rLXDzEOjPw+BX
	Ti3eRgr27G4j4cHkbbQR7Ppg8zqro3g1REeMunDZVLNFTdOdLLE=
X-Google-Smtp-Source: AGHT+IEVf5r+rolkiQ44IlQkVBbOxszPSaCFQ1vOzTxxgkXxPkhviLvJWKAGztNLO3pgEF5XOYsKrA==
X-Received: by 2002:a05:6a21:e8f:b0:1c6:a4e7:bd1a with SMTP id adf61e73a8af0-1ced04c1224mr799255637.32.1725058573729;
        Fri, 30 Aug 2024 15:56:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155424e7sm31450635ad.208.2024.08.30.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 15:56:13 -0700 (PDT)
Date: Fri, 30 Aug 2024 15:56:12 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/9] kthread: allow vararg
 kthread_{create,run}_on_cpu()
Message-ID: <ZtJODFOYkjgRTPCh@mini-arch>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240830162508.1009458-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830162508.1009458-3-aleksander.lobakin@intel.com>

On 08/30, Alexander Lobakin wrote:
> Currently, kthread_{create,run}_on_cpu() doesn't support varargs like
> kthread_create{,_on_node}() do, which makes them less convenient to
> use.
> Convert them to take varargs as the last argument. The only difference
> is that they always append the CPU ID at the end and require the format
> string to have an excess '%u' at the end due to that. That's still true;
> meanwhile, the compiler will correctly point out to that if missing.
> One more nice side effect is that you can now use the underscored
> __kthread_create_on_cpu() if you want to override that rule and not
> have CPU ID at the end of the name.
> The current callers are not anyhow affected.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/kthread.h | 51 ++++++++++++++++++++++++++---------------
>  kernel/kthread.c        | 22 ++++++++++--------
>  2 files changed, 45 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index b11f53c1ba2e..27a94e691948 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -27,11 +27,21 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
>  #define kthread_create(threadfn, data, namefmt, arg...) \
>  	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
>  
> -
> -struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
> -					  void *data,
> -					  unsigned int cpu,
> -					  const char *namefmt);
> +__printf(4, 5)
> +struct task_struct *__kthread_create_on_cpu(int (*threadfn)(void *data),
> +					    void *data, unsigned int cpu,
> +					    const char *namefmt, ...);
> +
> +#define kthread_create_on_cpu(threadfn, data, cpu, namefmt, ...)	   \
> +	_kthread_create_on_cpu(threadfn, data, cpu, __UNIQUE_ID(cpu_),	   \
> +			       namefmt, ##__VA_ARGS__)
> +
> +#define _kthread_create_on_cpu(threadfn, data, cpu, uc, namefmt, ...) ({   \
> +	u32 uc = (cpu);							   \
> +									   \
> +	__kthread_create_on_cpu(threadfn, data, uc, namefmt,		   \
> +				##__VA_ARGS__, uc);			   \
> +})
>  
>  void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk);
>  bool set_kthread_struct(struct task_struct *p);
> @@ -62,25 +72,28 @@ bool kthread_is_per_cpu(struct task_struct *k);
>   * @threadfn: the function to run until signal_pending(current).
>   * @data: data ptr for @threadfn.
>   * @cpu: The cpu on which the thread should be bound,
> - * @namefmt: printf-style name for the thread. Format is restricted
> - *	     to "name.*%u". Code fills in cpu number.
> + * @namefmt: printf-style name for the thread. Must have an excess '%u'
> + *	     at the end as kthread_create_on_cpu() fills in CPU number.
>   *
>   * Description: Convenient wrapper for kthread_create_on_cpu()
>   * followed by wake_up_process().  Returns the kthread or
>   * ERR_PTR(-ENOMEM).
>   */
> -static inline struct task_struct *
> -kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
> -			unsigned int cpu, const char *namefmt)
> -{
> -	struct task_struct *p;
> -
> -	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
> -	if (!IS_ERR(p))
> -		wake_up_process(p);
> -
> -	return p;
> -}
> +#define kthread_run_on_cpu(threadfn, data, cpu, namefmt, ...)		   \
> +	_kthread_run_on_cpu(threadfn, data, cpu, __UNIQUE_ID(task_),	   \
> +			    namefmt, ##__VA_ARGS__)
> +
> +#define _kthread_run_on_cpu(threadfn, data, cpu, ut, namefmt, ...)	   \
> +({									   \
> +	struct task_struct *ut;						   \
> +									   \
> +	ut = kthread_create_on_cpu(threadfn, data, cpu, namefmt,	   \
> +				   ##__VA_ARGS__);			   \
> +	if (!IS_ERR(ut))						   \
> +		wake_up_process(ut);					   \
> +									   \
> +	ut;								   \
> +})

Why do you need to use __UNIQUE_ID here? Presumably ({}) in _kthread_run_on_cpu
should be enough to avoid the issue of non unique variable in the parent
scope. (and similar kthread_run isn't using any __UNIQUE_IDs)

The rest of the patches look good.


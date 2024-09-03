Return-Path: <bpf+bounces-38799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D496A4FA
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41E21C23370
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052D18CC15;
	Tue,  3 Sep 2024 17:04:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D21C14;
	Tue,  3 Sep 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383053; cv=none; b=UTTRwaeLdmxLA2ZUKTAKkF/RSlXCtdM7a1EN+fI7qAVzxjofhcxVbusvQcSvZsxAjLfoM1KgzjYvPjR6SAN2jCZXkD0dxGQI5nC+OplhOYrEzrH6fWXttebB2skO9ZmkHOybbe+olwq/nLqgfmr+/CvKVB4tFlmohmUHo1DSLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383053; c=relaxed/simple;
	bh=Kb50wC/hoCRwCoOcj4VfXvEouLo6N8aFx37rX4Igv94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvE1twLPuAPh/ci6gTzyF8tBHnizTZrR0SHJU9dECUFw4T3sIPWzuxj4B4kC//TpMrxJixyIGxwHbsfWMfXf8r6TWiCeIjIP4vaJNVFLt578Ltzo5SHS0tO5fmqkaZ7Rd1U1ExVUQ9T+mHsJLngSMD2V9lGt+eO2R+CvAXEU3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20693995f68so9198135ad.1;
        Tue, 03 Sep 2024 10:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383051; x=1725987851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkZ76k+RsmoQcSUxXQqUyd32+/1Llwux3no1WyFmKNY=;
        b=goTYMbkl+yhwbuPyM7683SwSM1RTIdvJ6vItOWYsRw9utl0+kqYRXyKiYOXbfQyUAk
         4NM1xEb/t2G8sXZwYL+ENbhZDBvYFtt0WfhXXN2evacMWKkgqLGxm0QmaRGpGcJUOzk6
         HuDK9sLsCwxpN1GD9HuBF6Y6SVHozdxKXsNcq65kho8pFB9SzbfJa1UgH2O58O+g5vPw
         LaOiBeyDjGfmbAoCfw37Z95Im7HbB0lH2/NIoRPHdyCCEi9wt6vkklPDq48WhBuwp0S6
         YN+bf54TNe332H+vlX52xGA7Pomm1XubcYFMGk4nR80il+69ilRSCAhfw58NbP2p9PkQ
         yHsw==
X-Forwarded-Encrypted: i=1; AJvYcCVnKaSAhrcRoeE02l7Nm+Eb/j/6Vzo3oS90rmjGqvL1bCe0BNgqHPBUUJ44fDnu7wqR+FJfJB8D6YPRZZKC@vger.kernel.org, AJvYcCVs5jylmaXO2yALVslAp9bk8KNNt3aaJrCxk8zT/qDaS9wYmmyeJzsWGggHg7i7FupYGoWETXtH@vger.kernel.org, AJvYcCWiq2MDzLJuZ6A9biZtdMG8MYt8v2/lD3KOjkjiJO4qQh/mbLmaFzeVEaT3hwPIPSBgmYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXgE4tBgWU0Qz+iOVfSi86Ld+6kerPiY1LFLd1cdms/tRq1fV
	956fxJj1KPuTMW6HvunbhjL1Zzi9vJbNkr2d44GcOT3H0pq1Xkpn9fVk2O0=
X-Google-Smtp-Source: AGHT+IEC/oNDVBEgRcjtgGrRziLB/9VT3hq01Ir0SbzHbnfr0qbKxeamnnnnwV5VEunrkdgPn0ebaA==
X-Received: by 2002:a17:902:dad1:b0:206:97d6:be8b with SMTP id d9443c01a7336-20697d6bf68mr33781695ad.25.1725383050534;
        Tue, 03 Sep 2024 10:04:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3866dsm784975ad.153.2024.09.03.10.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:04:10 -0700 (PDT)
Date: Tue, 3 Sep 2024 10:04:09 -0700
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
Message-ID: <ZtdBieFVdpT4Jsf_@mini-arch>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240830162508.1009458-3-aleksander.lobakin@intel.com>
 <ZtJODFOYkjgRTPCh@mini-arch>
 <235dcd89-54a6-43ca-bbb3-45dfd6db97e6@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <235dcd89-54a6-43ca-bbb3-45dfd6db97e6@intel.com>

On 09/03, Alexander Lobakin wrote:
> From: Stanislav Fomichev <sdf@fomichev.me>
> Date: Fri, 30 Aug 2024 15:56:12 -0700
> 
> > On 08/30, Alexander Lobakin wrote:
> >> Currently, kthread_{create,run}_on_cpu() doesn't support varargs like
> >> kthread_create{,_on_node}() do, which makes them less convenient to
> >> use.
> >> Convert them to take varargs as the last argument. The only difference
> >> is that they always append the CPU ID at the end and require the format
> >> string to have an excess '%u' at the end due to that. That's still true;
> >> meanwhile, the compiler will correctly point out to that if missing.
> >> One more nice side effect is that you can now use the underscored
> >> __kthread_create_on_cpu() if you want to override that rule and not
> >> have CPU ID at the end of the name.
> >> The current callers are not anyhow affected.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >>  include/linux/kthread.h | 51 ++++++++++++++++++++++++++---------------
> >>  kernel/kthread.c        | 22 ++++++++++--------
> >>  2 files changed, 45 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> >> index b11f53c1ba2e..27a94e691948 100644
> >> --- a/include/linux/kthread.h
> >> +++ b/include/linux/kthread.h
> >> @@ -27,11 +27,21 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
> >>  #define kthread_create(threadfn, data, namefmt, arg...) \
> >>  	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
> >>  
> >> -
> >> -struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
> >> -					  void *data,
> >> -					  unsigned int cpu,
> >> -					  const char *namefmt);
> >> +__printf(4, 5)
> >> +struct task_struct *__kthread_create_on_cpu(int (*threadfn)(void *data),
> >> +					    void *data, unsigned int cpu,
> >> +					    const char *namefmt, ...);
> >> +
> >> +#define kthread_create_on_cpu(threadfn, data, cpu, namefmt, ...)	   \
> >> +	_kthread_create_on_cpu(threadfn, data, cpu, __UNIQUE_ID(cpu_),	   \
> >> +			       namefmt, ##__VA_ARGS__)
> >> +
> >> +#define _kthread_create_on_cpu(threadfn, data, cpu, uc, namefmt, ...) ({   \
> >> +	u32 uc = (cpu);							   \
> >> +									   \
> >> +	__kthread_create_on_cpu(threadfn, data, uc, namefmt,		   \
> >> +				##__VA_ARGS__, uc);			   \
> >> +})
> >>  
> >>  void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk);
> >>  bool set_kthread_struct(struct task_struct *p);
> >> @@ -62,25 +72,28 @@ bool kthread_is_per_cpu(struct task_struct *k);
> >>   * @threadfn: the function to run until signal_pending(current).
> >>   * @data: data ptr for @threadfn.
> >>   * @cpu: The cpu on which the thread should be bound,
> >> - * @namefmt: printf-style name for the thread. Format is restricted
> >> - *	     to "name.*%u". Code fills in cpu number.
> >> + * @namefmt: printf-style name for the thread. Must have an excess '%u'
> >> + *	     at the end as kthread_create_on_cpu() fills in CPU number.
> >>   *
> >>   * Description: Convenient wrapper for kthread_create_on_cpu()
> >>   * followed by wake_up_process().  Returns the kthread or
> >>   * ERR_PTR(-ENOMEM).
> >>   */
> >> -static inline struct task_struct *
> >> -kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
> >> -			unsigned int cpu, const char *namefmt)
> >> -{
> >> -	struct task_struct *p;
> >> -
> >> -	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
> >> -	if (!IS_ERR(p))
> >> -		wake_up_process(p);
> >> -
> >> -	return p;
> >> -}
> >> +#define kthread_run_on_cpu(threadfn, data, cpu, namefmt, ...)		   \
> >> +	_kthread_run_on_cpu(threadfn, data, cpu, __UNIQUE_ID(task_),	   \
> >> +			    namefmt, ##__VA_ARGS__)
> >> +
> >> +#define _kthread_run_on_cpu(threadfn, data, cpu, ut, namefmt, ...)	   \
> >> +({									   \
> >> +	struct task_struct *ut;						   \
> >> +									   \
> >> +	ut = kthread_create_on_cpu(threadfn, data, cpu, namefmt,	   \
> >> +				   ##__VA_ARGS__);			   \
> >> +	if (!IS_ERR(ut))						   \
> >> +		wake_up_process(ut);					   \
> >> +									   \
> >> +	ut;								   \
> >> +})
> > 
> > Why do you need to use __UNIQUE_ID here? Presumably ({}) in _kthread_run_on_cpu
> 
> It will still be a -Wshadow warning if the caller has a variable with
> the same name. I know it's enabled only on W=2, but anyway I feel like
> we shouldn't introduce any new warnings when possible.

Makes sense, thanks! That's why, presumably, kthread_run uses __k name
to avoid the warning..


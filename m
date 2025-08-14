Return-Path: <bpf+bounces-65692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2FB27071
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A66A087C6
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B43272E5E;
	Thu, 14 Aug 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XnxdYUoD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD9244662
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204993; cv=none; b=N28X46nLtau/YK6aIeGGZ0krYy0XVFhdl9UNzHO+oL7QTx1yAo0yXxs2L6xq1uEirm1MKSDTCPLzya1JI3F7erLGyM237CvGzUu4fniT6fNQ+rbiC4gu55V6bLOQVzprg+u/uAnqL8OQ9Knro3ktHbNwgCHmjeBAJ7iWz+/r0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204993; c=relaxed/simple;
	bh=j6JPZONw9/j0dLXlcsyc7hoC6rAkX3Y3VABybTvHwIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svndvts0FgUcAIXjUTHsaH+WfoUgrPqgxkMsufWc1DSH+o5ttwrjog9VKFFm7t63vbChJhhmjNoO1v0mdTbJH4ywU4Z01treE5JMYZZvJgzUsivKA+UIm/haXMMYTGMSRnV6QD8DjonHKVPYeTRD4cOYH8KUsgZSGjCctPPXDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XnxdYUoD; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce90227aso570008fac.1
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755204990; x=1755809790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCOW4bsDUhYI0x0xwfM8hqboWSnjWIjYYmU3Is7O8PQ=;
        b=XnxdYUoDyBUiFKfS6QOLN7NrHV7sLC/qFpcJo+GkdcmOJQPQcuy7P2PDdGYnVqXR3k
         N/3Q9yhhf8iM6/spnEf/n2rIHxxnG7D71sakc9WxY1W40E2mCUIcajS22EmNw5P30vHd
         0/Hr8qpxPhfS3Jxz22LHMHD8MlAhVEwkdqO2oqFEMOricBbGVbZiErWeAF9pNDqCPJPA
         A+2Z9k8YIiFRoT0XzbJTf02sZSeqLgpfE8juGFU8DqoXD+oqcWsBBKTVLj/HZbD4vJwY
         mPH2vb9/nKkbHtWuFf7b2djXtXxNRch+xKstxs6xgzG43aEriily2pt80eDIcf4CATxd
         XJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204990; x=1755809790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCOW4bsDUhYI0x0xwfM8hqboWSnjWIjYYmU3Is7O8PQ=;
        b=EK3SrNVDP5fPPwSF1AsnAF7iq+EuisZJJjdm3mJxEAHQkwH3/pQ0VkozE4wAQuP3Pt
         wI5Sql9Pf3kisNrLZatmGc66vj8pDLeqU1M6m4Eaqq1TDPechqGIqZ3YmkC1ve66v6Y3
         Aoa0/AGOZlVgmNCKhLTAtmA/HI9vejz2l3ee4SlcbX5OPPHv3H0NNHypbA51wH7BcxQC
         9/7ClASMcNQsopCvv1wGxptdQSx52ZBh2wcO5Tas1lN316tIiI2hAkDWp+A/sq4kVTGg
         drK1mXCPWv84hfXftOaUdjCRgCsrso9BFiVoCYy6oHEJkoOVBCeBohgGndo+EbD2IpXs
         StCg==
X-Gm-Message-State: AOJu0Yyhj0iIjOHDbuL/rE2L7wquPmf4T0SmWVRlPiBPZe3JetFdzFBX
	1lPZpnuA3ewWYY338Ka/00kZ77cKLsG4oNT4F9ZzijPdfS/EfTlP0Ls2+tKQUg6/4I0=
X-Gm-Gg: ASbGncvxQ6XohNYuLZBb7FPc7mwYFGQXJwbnPiCwxkAKPYipwJM9MEpcsdaX9Opzh3a
	VV8boaorLD2eHAQab9LqEyw4r78HjPv2S9JFhRXU/9ag1gNIdagLGlQkZbiJIzfV0j23ScpmOhw
	n+vaD2OnaPVd3YApiskfJFyFs70QX6gXtxle3QjU8I86aeuIcE6kGjuXx3tYAUQXXpSvBsLtnRM
	XUb35hwkUg5zD7Esb4djldPT2PBTwrbMiRba84/XG4KFJtUVK5xnDW2fCu1COwSh7QhwKVBaRyQ
	vXUsou36/fj/5nB5j/9Xku65xNZOo9R2de4+IpO5Mpg/9VBRmLXb7x2vqP1IBgpPpkwq8zSo1LV
	o30YW
X-Google-Smtp-Source: AGHT+IFfrlqwWeK98t7G2HWzL4XLwAjvfYLspD0bNCez3QfcF5IqCjUnVUbYVJkKThNj5NayL33EmA==
X-Received: by 2002:a05:6870:8926:b0:30b:85e1:d3ea with SMTP id 586e51a60fabf-30cd12e313fmr3030460fac.21.1755204990536;
        Thu, 14 Aug 2025 13:56:30 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::f:384])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30cd00ddd98sm895032fac.18.2025.08.14.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:56:29 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:56:27 -0500
From: Chris Arges <carges@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	dtatulea@nvidia.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, tariqt@nvidia.com,
	memxor@gmail.com, john.fastabend@gmail.com,
	kernel-team@cloudflare.com, yan@cloudflare.com,
	jbrandeburg@cloudflare.com, arzeznik@cloudflare.com
Subject: Re: [PATCH bpf] cpumap: disable page_pool direct xdp_return need
 larger scope
Message-ID: <aJ5Ne4U2nLY5DmCL@861G6M3>
References: <175519587755.3008742.1088294435150406835.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175519587755.3008742.1088294435150406835.stgit@firesoul>

On 2025-08-14 20:24:37, Jesper Dangaard Brouer wrote:
> When running an XDP bpf_prog on the remote CPU in cpumap code
> then we must disable the direct return optimization that
> xdp_return can perform for mem_type page_pool.  This optimization
> assumes code is still executing under RX-NAPI of the original
> receiving CPU, which isn't true on this remote CPU.
> 
> The cpumap code already disabled this via helpers
> xdp_set_return_frame_no_direct() and xdp_clear_return_frame_no_direct(),
> but the scope didn't include xdp_do_flush().
> 
> When doing XDP_REDIRECT towards e.g devmap this causes the
> function bq_xmit_all() to run with direct return optimization
> enabled. This can lead to hard to find bugs.  The issue
> only happens when bq_xmit_all() cannot ndo_xdp_xmit all
> frames and them frees them via xdp_return_frame_rx_napi().
> 
> Fix by expanding scope to include xdp_do_flush().
> 
> Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
> Found-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  kernel/bpf/cpumap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index b2b7b8ec2c2a..c46360b27871 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -186,7 +186,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  	struct xdp_buff xdp;
>  	int i, nframes = 0;
>  
> -	xdp_set_return_frame_no_direct();
>  	xdp.rxq = &rxq;
>  
>  	for (i = 0; i < n; i++) {
> @@ -231,7 +230,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  		}
>  	}
>  
> -	xdp_clear_return_frame_no_direct();
>  	stats->pass += nframes;
>  
>  	return nframes;
> @@ -255,6 +253,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>  
>  	rcu_read_lock();
>  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> +	xdp_set_return_frame_no_direct();
>  
>  	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
>  	if (unlikely(ret->skb_n))
> @@ -264,6 +263,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>  	if (stats->redirect)
>  		xdp_do_flush();
>  
> +	xdp_clear_return_frame_no_direct();
>  	bpf_net_ctx_clear(bpf_net_ctx);
>  	rcu_read_unlock();
>  
> 
>

FWIW, I tested this patch and could no longer reproduce the original issue.

Tested-By: Chris Arges <carges@cloudflare.com>

--chris


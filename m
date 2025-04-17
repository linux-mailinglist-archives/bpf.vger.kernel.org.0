Return-Path: <bpf+bounces-56156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33053A92AB1
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86641189C30E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7525A35A;
	Thu, 17 Apr 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0p7/yyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAD2571A1;
	Thu, 17 Apr 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915872; cv=none; b=hIrmCL74hsPFWL/3MX/a+otBwzx2/MdZp7a8UtbR9w0C6Cs72IKhcRBaCbVIgqGNS15EdeImsXEWq/JT9vyqUT784eSVR009MDb28PybO5gk6MfM6D4S7cyABxuRXe0xN7pMJnLfiqPvKqCfrNtlbI/rONkKzJ8uCwDm2jWWYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915872; c=relaxed/simple;
	bh=65Vd07+eu4sGros2pqdClyFy6VqYsYQhxtJYsLClcvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d59m1GZwzxyP6B7Du8TFyP4hc4m9zKkeYqW2rRymG24c5DrJLJEzljqB1Hy5VXU8eKLJVtK4xe4Q7PXSDxi0wlOqh7Nd2mmXvA66izbzti8AY37fHevuEFu6mJTXooi1f5MjrX+PjYfD43SovxIJaZDbDPrxiSGh4NxWD04FMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0p7/yyS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af589091049so897767a12.1;
        Thu, 17 Apr 2025 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744915870; x=1745520670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbHnfA5ct33ORVZ7TPi/aq+sM7vHxqt+w+RbszLa+gE=;
        b=S0p7/yySlbVOyHTzdRIheW5hGa3TSTccneyTvBMap0y6Rp+icg1/lmUanOq+JUD4Wo
         gCFU54RwMiFtql6BFjbnVQchqdQFBEKXqDjT5qh4k0tZOQ/x20mM7SJ9Rk4SWhwR6XgD
         QXh4iMDW0fbPqRDRn6vN0IZxfoOEsMPXwJPbxjSERjBpKrBGqr5nj0QFl8IkmeJLJjbf
         AivQd48/tHoPpXX00ZDgbeYPfynnSNgEjlm5tOSIWQd0PN/2ZONd05rtGQrjJKDskjvi
         Suyi6xS4yWQOq7Ygo8wMeAzVNXEgT5inbFj5ivpLBoSr/HZ6TjlMcZL9fD0LYHLfGuVm
         jTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915870; x=1745520670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbHnfA5ct33ORVZ7TPi/aq+sM7vHxqt+w+RbszLa+gE=;
        b=h95f8U0myTiUvCM1SBXaqDGPtVugPVbZbQvU2dDN/ZfW6uXzPPsdvq7VCQBn2MZKCS
         hIsiBn9EQEoMMYC0tL+f/iSLd1BJ9Ih9DSAprB21vPnz3yFuIUMXGyQFI+JnHjqjXNsX
         HYV/wHYLliRcmKl2plBmh0+z2nkvvV+Bt1WT7rLhWdPBexY2ABwpUEGRsRabslFAI2Qq
         PuwOpplJaM+4uyano7Z6ko++oH+2ZVQ04gcrvXnzI1HezSH7eYuegXLdPBiPYIMIvxwQ
         pmcylIC2Tt0QN2ZrFs8/LszG0wzTTC9Az2ambG83JYU9uJUpB8viPcHTkrAfDdKD1oj4
         qq6A==
X-Forwarded-Encrypted: i=1; AJvYcCUJM1t2QloonbE2FvvyPEv5I2uvlQvZ+CvvLeRwja4RPeRmTYenU2fFQy8p+Lr/HcqLFHGaNp3C@vger.kernel.org, AJvYcCV+j7KyN0mcEN36xD2NK5EK1m9jQEzL5kw1kxO7f7hmHEQH8h69/vGK8Hq79Q21P1CJhHpYwzv2kuBUMQsYuDYOusrJ@vger.kernel.org, AJvYcCWlNcxt0mQKzfZQBZSEs3/7wch9o44Wat64xxP4d2tL/bLTTJrAazkFhLFD0rSHN7uqngr8otJT4Cu7Yn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSe4sno406GiFyUqdYJvhqShlJaNrlOEH8oSgcT7QC/yNb+U4U
	4v7DNs6FjURArKXFF4lJa9vkQDd74pXEePJRML/rbZ1BImWD3+qd4Vp5xEur2Fs=
X-Gm-Gg: ASbGncsqE9rklzLMcuVTNUa/++JjdGx/jspAumQRyrgB3sRGj2i5StqTFeBFnAnP7r/
	xmnZTmiyNnR/vEYuD4RxzIP8hG7OGyi1IgGJF9xr9wNa5In6Z87dX2suZKrL+LrB+r7fPZtM/Iy
	LPeORJzSX2On13Nibqvv6npOh1aFlVCvQ1gk2KG7D0U0CXiOJYnO5qyNkUoXTprcb6w7c+AovZG
	CzNfZBsIAe6kVljKKg/a+vv6SAIScRNgEyU7GqafEWGl9U53OAnhswRFMYXi+fpXT+puwtfH+D8
	1xXA1JBSV4eOsHQTS7cQZTqPVaiXOcjY9c0gKYDnMmLK
X-Google-Smtp-Source: AGHT+IFvPh3/w+OkOXKkRlC6hIs8p5S4OKSna69ZSXyEm+nJ0unq0K6ZwOVCOOEtJ2ttLK51bu4ktg==
X-Received: by 2002:a17:90b:6ce:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-3087ba51b57mr233223a91.0.1744915870440;
        Thu, 17 Apr 2025 11:51:10 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdaad1sm3615545ad.28.2025.04.17.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:51:09 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:51:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
Message-ID: <aAFNna3T2tzj9VZt@pop-os.localdomain>
References: <20250414161153.14990-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414161153.14990-1-jiayuan.chen@linux.dev>

On Tue, Apr 15, 2025 at 12:11:45AM +0800, Jiayuan Chen wrote:
> Sockmap has the same high-performance forwarding capability as XDP, but
> operates at Layer 7.
> 
> Introduce tracing capability for sockmap, to trace the execution results
> of BPF programs without modifying the programs themselves, similar to
> the existing trace_xdp_redirect{_map}.
> 
> It is crucial for debugging sockmap programs, especially in production
> environments.
> 
> Additionally, the new header file has to be added to bpf_trace.h to
> automatically generate tracepoints.
> 
> Test results:
> $ echo "1" > /sys/kernel/tracing/events/sockmap/enable
> 
> msg/skb:
> '''
> sockmap_redirect: sk=000000000ec02a93, netns=4026531840, inode=318, \
> family=2, protocol=6, prog_id=59, len=8192, type=msg, action=REDIRECT, \
> redirect_type=ingress
> 
> sockmap_redirect: sk=00000000d5d9c931, netns=4026531840, inode=64731, \
> family=2, protocol=6, prog_id=91, len=8221, type=skb, action=REDIRECT, \
> redirect_type=egress
> 
> sockmap_redirect: sk=00000000106fc281, netns=4026531840, inode=64729, \
> family=2, protocol=6, prog_id=94, len=8192, type=msg, action=PASS, \
> redirect_type=none
> '''
> 
> strparser:
> '''
> sockmap_strparser: sk=00000000f15fc1c8, netns=4026531840, inode=52396, \
> family=2, protocol=6, prog_id=143, in_len=1000, full_len=10
> '''
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!


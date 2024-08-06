Return-Path: <bpf+bounces-36453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B17948A3C
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 09:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0108A1C2284B
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986A166F3A;
	Tue,  6 Aug 2024 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/aCrdog"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33561547DE;
	Tue,  6 Aug 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929852; cv=none; b=azqdGf3PSkLdOQw+VJvksop6+gKE9OMDBXoIynxOcn2NTxgADtvx+4RqQ09KQgXaFD2ri2HSDmIE52Mz1PhEvhV22c/kHQXnSxKXbP4sUBvlR+cLeuOnW48qQOaSgwyElalOTqDkXi5RWOX+sL/gbCJQrx1mtn8dzjjH5TLPrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929852; c=relaxed/simple;
	bh=3+zwEqXz+fYU8Gxi7D99H4tzMa/JaN2qBbi6McWAwTI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awcO3DeSotDaCdhCGsExsc3d4Nfiq0SHKHfb0JVxlGLplSXNuNiawkPwmB0HhEBcfcXJWRvezYfj6THF+GIVj5EPebr37zV/qEe20G+7gKVDhiAhwLqptPoC697NJaMVkn0mH0gRb18hdVIKmga0IP4/l1BEl6rdxZngQqCwmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/aCrdog; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7ad02501c3so22050466b.2;
        Tue, 06 Aug 2024 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722929849; x=1723534649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ7FZFwGz1gAcWdTtjlB5MKOIDdPcTV08aJDW70MNMY=;
        b=F/aCrdogGj4DOVEZyBhWFpbgIukAjRAwYQItTepJa5dhsxKTjnmuOI7rrnZdrb8CE7
         GoiATD037qEOREl60XcEmTjHk0+wPYN5zhZRX5BH0E2UvC1wEJPaV6mVv28uFnXO1YBe
         q+/9L3nSkJkxwmD/uCKJ8bHDomk+cUF3+mOEArQDE0QlKo2xYz8EB5mxbQGHNoLeQr0Z
         RLa5yI3XOfadVNcJ/Enc9jSjwGbNi9LuaR5IlX2xBA+E09FH1XbHXpvJawy+zhAHwIyg
         mshLHimuv54+6lTixG8ryhTNxJbCl/r7TPTX0dRlmemRZMRtdiHiqmY1fk52ZAbAGQi2
         5OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722929849; x=1723534649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ7FZFwGz1gAcWdTtjlB5MKOIDdPcTV08aJDW70MNMY=;
        b=kNxw+QaNqr+HcD37crcTz6U15NARbu4ETKC3E6jbjxy35o0JxEYdF5NflEjF4ruQ3p
         jHHjKdOrz5mzvWFrEZ6MweIlyc/xZdcC/ouCsToJ8Lw1fmw74tA2wQsrMZLxWj3koosI
         mDL5iqhdriHH/Ya6+F64xh2UcIc9jh1X8VBgJYiiIGm42J/2FTewGB8Lz1FSlyFi61DL
         a8SUQ78fEhMcTY/Ymhe2Mz7l1jXj/idrUz1SaAnAtK/M0TfjmFjafFra10d/iGnj2hYj
         LX0xi4IFUoS6fkg2vBQS9oCvbFOxQ04TE8H4MCHsX8bCB5TyE7hfniRwftwwtqSE0+uF
         PQdA==
X-Forwarded-Encrypted: i=1; AJvYcCUrwzIWok/s3DFouFv4IWaQmV9AQ6LRNoYa4m8hzYXS07kOGmC12pYlRbe17QBYxo+r+4Z5hkdezjMjdWhxYH+HmW7hhOVmyWaH3qjVvvZSqxsdzu5ZsCAUjpwvCG3LFE73
X-Gm-Message-State: AOJu0Yy+NVkfvgyJK0fptCA0aOCy+dDhRSsEQ/i2vQHoVlUM12daAeaK
	MpCDfMmwX/y1wjM7lkdTpvxAVNblqpdRIl9Z0aL9wnM/1RwL8Dvu
X-Google-Smtp-Source: AGHT+IEvWbctqO1kfR3DaY9osbMiWxnq9byNhzbUjfdi2B4O0dEUE2uNEZTrK6LOOncdf4Aj0ywM4Q==
X-Received: by 2002:a17:907:72c5:b0:a7a:929f:c0d6 with SMTP id a640c23a62f3a-a7dc508005bmr1193767766b.38.1722929848882;
        Tue, 06 Aug 2024 00:37:28 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3ce6sm524081466b.4.2024.08.06.00.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:37:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Aug 2024 09:37:26 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, oleg@redhat.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: get rid of bogus trace_uprobe hit counter
Message-ID: <ZrHSts7eySxHs4wh@krava>
References: <20240805202803.1813090-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805202803.1813090-1-andrii@kernel.org>

On Mon, Aug 05, 2024 at 01:28:03PM -0700, Andrii Nakryiko wrote:
> trace_uprobe->nhit counter is not incremented atomically, so its value
> is bogus in practice. On the other hand, it's actually a pretty big
> uprobe scalability problem due to heavy cache line bouncing between CPUs
> triggering the same uprobe.

so you're seeing that in the benchmark, right? I'm curious how bad
the numbers are

> 
> Drop it and emit obviously unrealistic value in its stead in
> uporbe_profiler seq file.
> 
> The alternative would be allocating per-CPU counter, but I'm not sure
> it's justified.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 52e76a73fa7c..5d38207db479 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -62,7 +62,6 @@ struct trace_uprobe {
>  	struct uprobe			*uprobe;
>  	unsigned long			offset;
>  	unsigned long			ref_ctr_offset;
> -	unsigned long			nhit;
>  	struct trace_probe		tp;
>  };
>  
> @@ -821,7 +820,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
>  
>  	tu = to_trace_uprobe(ev);
>  	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> -			trace_probe_name(&tu->tp), tu->nhit);
> +		   trace_probe_name(&tu->tp), ULONG_MAX);

seems harsh.. would it be that bad to create per cpu counter for that?

jirka

>  	return 0;
>  }
>  
> @@ -1507,7 +1506,6 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
>  	int ret = 0;
>  
>  	tu = container_of(con, struct trace_uprobe, consumer);
> -	tu->nhit++;
>  
>  	udd.tu = tu;
>  	udd.bp_addr = instruction_pointer(regs);
> -- 
> 2.43.5
> 


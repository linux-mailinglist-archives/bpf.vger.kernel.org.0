Return-Path: <bpf+bounces-69383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08AB9593C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E963B20CF
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC74321268;
	Tue, 23 Sep 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae9YOFtj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3131197E
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625840; cv=none; b=AOXpFQsyLQ+wV5jg0rNEHZCjIsUXLKJYkMoOmwfWR4CTqtAKQ58tKu3cdsnKnXX4egfuzg3NbHvNt5MyYN6tBFxCxiE7cBt7uqoH0tAShcL+pBKbE2Qx2WVm9hTHGFH/FLxwVwJpLwi2BN0MEdQle9JE8UNsCo2sN3IVKDiFw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625840; c=relaxed/simple;
	bh=wGRrexcrJiOYxex9LPSrvm70Gi0w/jmnAo5XesaOW1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzTh6M0p9pp9sXi8Awy9Hs17q1e91SERTSNaKkkUa1S+OoasLfh9r/OIJQtDJ29cbIlQselGCyEMGOfWnuNb1S+J0u1kGOUyxJJZrODt8zHzJwAbCAvDmSCa3cWB4GpXgBsWTIosBXNPbDp599LyVB265CqfEELNJ6BAFA6Qk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae9YOFtj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3264776f8f.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758625836; x=1759230636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tUjJweEPB4TqONfwC9fpDlwaU6QM2qlfDS5A23MkLtU=;
        b=Ae9YOFtjcOo9kCmzREoCWChl1wKvUdJjZlm+TsEylERaa1L4kkSYi+K4uNEbWmLv4K
         XxmlPS0SsGU8mT51meZiuelPgpFr9j5DTe0ZuYhITHLvQQdjOpapgHuFPEUJE5Cfb5Ab
         L32H9SewvMcaq18c7QfR5xDiFytSw5K8ZkY1sJewx77eVR9wLuxCSl9NLsJi1+zCT3X3
         3IhXYZ/3XrZxcLudVDpJcGEWvGoOe0N7J6BLDsznSh1EIWBNtd3W7ZlBd3sBdPLU3M9F
         DC7z4SPl1R2nk1S4iSqIfvNxFz+k2eb0mL4fqiI7ZDUwwYfzNSfr+/DOHpe7D74Mx4Bk
         qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625836; x=1759230636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUjJweEPB4TqONfwC9fpDlwaU6QM2qlfDS5A23MkLtU=;
        b=NiP6kvgyUHKRSmBD9S+cjUV+UDSdeON54bEwkzbp8/x8iLXSqAIeRkkBgKiQsoXR2e
         81y6517lgSp36GDFmgHMyqn9I0gfDYNDRC9GylhJhrHTX/vd5sgOMrA9FkYrVd97KBUK
         EAYa/f11A51Z/NY4ZRhLrWZ/dUYp0lSCxhz9xC0Xaq8y3Etp6QwQ9xEz+gcTbVEth7H3
         ks8743DeVp+M557zRgkcRcan5IxV+q1w3YOPCarswHQiVlbIifPUuCDmCqsnedwvqXrQ
         nF9q9QWJv/LdxpR8UCCEGIWQbKStVaMaV/354nndWwHH415W25Pe0l0kRqJCiwp9ZdlZ
         oZaA==
X-Forwarded-Encrypted: i=1; AJvYcCVJzvjwT1FcfZtLcZLd+L+P49BNxWY11yyR7dBxiMnVt5TkVhnUqOcMGXjaIaJXDJHCcuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Tvj2o5JrkNZQP1BpeilEozrefYZBiho4n/vK+EncbO2bm4dp
	IBoAzlN4E8CnfPoyLQyUrJl7XC1Q9J4MxiiCH+PojPbs+GfT+FXKP90V
X-Gm-Gg: ASbGncvml02+x83HG3ICijDAK1RXNPfwZloOYgzBW379t7D/xTrndjM9sg0hwTFyGW+
	z4uIkL5LgUEowuCB00O0piRxuqX06UxXHy8KYu2dMV6EV+840CARt9X8Jh3lMegsutSRTr7VPWt
	1ZUCHLc/I0P7d3tSssJJC1dSatvgBZJncO3yeNqP/tJjNCdXKTKqtyyW3UzDtraXjqrcanx4y1k
	Ie4pLcqI+rNByjz0RiVMdp7wpETNXp86aVh5WYGCAhTt3Df4XoUg0mJja7iUXSQiQQq/vS1ta6X
	NRdOjPAMAPqzPXvjyue5/mBbEJgwd8ZK8Z74nSvJcR58K+STxLaxZzXtHwH+8sPBcV1D6rZz
X-Google-Smtp-Source: AGHT+IHgMX3BiSNRvfrTGGdpNnaqqWvHnAmBH8PkRL8VnvuR0hyv/WFqY9PPvGGhOMcdRD/JvBVOdg==
X-Received: by 2002:a05:6000:186f:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-405d090c6d0mr2107024f8f.16.1758625836201;
        Tue, 23 Sep 2025 04:10:36 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm23503973f8f.21.2025.09.23.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:10:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Sep 2025 13:10:26 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Message-ID: <aNKAIsHQZySyrV4o@krava>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250923092001.1087678-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923092001.1087678-2-dongml2@chinatelecom.cn>

On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
> For now, fgraph is used for the fprobe, even if we need trace the entry
> only. However, the performance of ftrace is better than fgraph, and we
> can use ftrace_ops for this case.
> 
> Then performance of kprobe-multi increases from 54M to 69M. Before this
> commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   54.663 ± 0.493M/s
> 
> After this commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   69.447 ± 0.143M/s
> 
> Mitigation is disable during the bench testing above.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1785fba367c9..de4ae075548d 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  				if (node->addr != func)
>  					continue;
>  				fp = READ_ONCE(node->fp);
> -				if (fp && !fprobe_disabled(fp))
> +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
>  					fp->nmissed++;
>  			}
>  			return 0;
> @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		if (node->addr != func)
>  			continue;
>  		fp = READ_ONCE(node->fp);
> -		if (!fp || fprobe_disabled(fp))
> +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
>  			continue;
>  
>  		data_size = fp->entry_data_size;
> -		if (data_size && fp->exit_handler)
> +		if (data_size)
>  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
>  		else
>  			data = NULL;
> @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
>  
>  		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> -		if (!ret && fp->exit_handler) {
> +		if (!ret) {
>  			int size_words = SIZE_IN_LONG(data_size);
>  
>  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
>  };
>  static int fprobe_graph_active;
>  
> +/* ftrace_ops backend (entry-only) */
> +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
> +	struct fprobe *fp;
> +
> +	guard(rcu)();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);

hi,
so this is based on yout previous patch, right?
  fprobe: use rhltable for fprobe_ip_table

would be better to mention that..  is there latest version of that somewhere?

thanks,
jirka


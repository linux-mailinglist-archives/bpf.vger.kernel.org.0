Return-Path: <bpf+bounces-73135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F85C23D8F
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 863884F4070
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF682E3B08;
	Fri, 31 Oct 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WoyDtMBu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661B1C8605
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899561; cv=none; b=MLQZ/r5M/1U/EzpVVK/bBLcqKfoSap/X5pkr9zkPLTJaChAooABYyP7fkiDbeN6pL94MtFfc7ULOt8FFW2oO+skXIeZS4Nbdm5sBXLOQ2bVIoIVasTATmPNaYo3L0hHHMnLOyhCkz2DKhfEPwPvOXejERROSU6KgeCJeTsa+t/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899561; c=relaxed/simple;
	bh=3j8afmSJ7Nmsi16sNeqRifyt/WmVa4gl82NY0GZWAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVUCYv59OhSTL9YD3SnyzWy5WtZKjIM9Sjocq1EF+rgMZWtPm94MmnN5rNaW2MIPXpo5k/UFWhz3E6Mw0OjvmGvfiXL2xXOQH6VnHz3HLctR+rIfGkiSvt557quB1NX3feKXjcM/zsKKjielwwjiklKvFK4UDt5cmP92iaPnxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WoyDtMBu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47112a73785so14271795e9.3
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899557; x=1762504357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4h4q0wa7BdASeLKkAa33sOr+LqpNtBVUob6S/qE5mOw=;
        b=WoyDtMBuNhhFFznEpNIVqcF2X8Widy/OoxXlAPNS9tf4RR1UCNUREksKORQRI6yHHa
         Z0XjnXYYxmTep6USUQftuXPQ3AKA3IOLtlc1K5UrfKYJzIkvcXYzVYvqvq93a/eODgSt
         fNmeJIAoydG1RoAtJAc53SELCfJzaqJDms83Z+HfMZs8ZZd06vetrDwxcnqbWlT+Bhsx
         n3qz0JDHWCbYfLpbZTghOvE2Y3XqVOtRecg0gjvV/3NGn9eMZsx9t4KywxXTkZesTyFT
         TRez8XiTcf77/jOFeVVke5YfzY7UVYW4G2kz59apMI1vXAs7kdwJzqfdC5+RzCoMOO9N
         NnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899557; x=1762504357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h4q0wa7BdASeLKkAa33sOr+LqpNtBVUob6S/qE5mOw=;
        b=KWiV8cLASZOH8jOKSqUs14OioCy0PSU3uxLPInjWrKjNc6+6GpmF3vxOiORsOLIM9J
         a7krcQ/yWVQ79l9xIxG7UBXmuq6C8B+L0sl49Rq8SrxAo4BDJSkNrQ33zKabTlAYt7Sg
         TcDdic0o4sch3RW0nZ5159nCTcitRNTAmgJ+DuVLRXKqsl84CfGubYySPcDMzxbG1qoi
         zNYAQ+NSyp0eB6vWJjrTutbKABGKrFQdpMsvNk+nTWx3mhpr1SmrGFAgp+X/A21zTD0Q
         5cF485qvW1Zx6evnFvlahEdvcPf27p/9r6ikte7V+MPQoMQx5U9wYvkdMl+Pp9T67gc4
         ZKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4xU4Oa8zKQb6DOFUR+FZCWrBBomG9EfOzXoHn8w5hK/R5iMX37rqSIZKYPn7GYVhI68=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk70kfBcfl7DDmpX5YqcgbfSxCsWpSpCwQHIVqfupjroLoe4hy
	kyN0Ly24//IfboqcDJf/RAdWs20moAYZtU04zdbYswyKRHxfTGSGZtK5bDDA4j+C000=
X-Gm-Gg: ASbGnctdSJ8gwRPecEmO5oAxO33wZyBFeqlGnBp4Q6ex0H50Yd0uOUKjlUt0B/L/qDI
	21BoG9VJ/otJNoR+HR8usONNgNREIInY3dpmqtlJ+T4BIxyGc4NSoxrM40dW02BRelDIrjexbb6
	FNfBcQt8bodUg5rxtw5+TQwH0Am7b74f39m66yfYSuvlZMQG4BTFz0MqiWBp9E44MI0mO0eihIE
	hPiqCHSxHVb717rRuVesGXZcTCY+9/wFNkA8ukH6+X4T8WyxnZvBl4ejG4ATP3ibhHkKx99o/ky
	90zV54Si5/QRjnICr1206GRRrddea+apJLBGNwreH1rFbe5UMeCGTrtw4lhk4MxR3UvRQ1atCM6
	VPCAhVqSBfSSru6kpUPPGpUan7TZaorBLA003bQzFxQI1HoixF9UivZj6AacYzMvDE2ZYa/9RXY
	Rbs0MqT6kcFQwGrETkcVizZQCe
X-Google-Smtp-Source: AGHT+IGfDhEwc+4540g9zxrsusq87Jw5oannsM7AsDgvzrefgTdYZ1mcnrXQoAnn7esV8SehlhvpnQ==
X-Received: by 2002:a05:600c:1f91:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-477307c51d5mr21021365e9.13.1761899556870;
        Fri, 31 Oct 2025 01:32:36 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732cb7f41sm20722905e9.0.2025.10.31.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:32:36 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:32:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 04/23] mm: define mem_cgroup_get_from_ino() outside of
 CONFIG_SHRINKER_DEBUG
Message-ID: <aQR0I9B9b1VvmYl2@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-5-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:07, Roman Gushchin wrote:
> mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation,
> but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c            | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..9af9ae28afe7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -832,9 +832,9 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
>  {
>  	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
>  }
> +#endif
>  
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> -#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> @@ -1331,12 +1331,12 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
>  {
>  	return 0;
>  }
> +#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  {
>  	return NULL;
>  }
> -#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..5d27cd5372aa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3618,7 +3618,6 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  	return xa_load(&mem_cgroup_ids, id);
>  }
>  
> -#ifdef CONFIG_SHRINKER_DEBUG
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  {
>  	struct cgroup *cgrp;
> @@ -3639,7 +3638,6 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  
>  	return memcg;
>  }
> -#endif
>  
>  static void free_mem_cgroup_per_node_info(struct mem_cgroup_per_node *pn)
>  {
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs


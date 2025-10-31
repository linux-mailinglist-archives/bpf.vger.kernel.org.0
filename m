Return-Path: <bpf+bounces-73136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88229C23D53
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34D1234F158
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEF2E336E;
	Fri, 31 Oct 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CcNSXCN8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFA26A1AB
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899670; cv=none; b=QwPir5thRMfwkMcbb23s/AukaEyQMXAqoE31wKA+gAPlQAOcsb0Ju10gRzfGFTz3vy0IkVS2hNwqWjVghUE//LYiriYfgzTYkGxhu2NLVjwRVBrWsdlcnU7rsF+B+jQx+TPKvt+AbnFDOA0w2BuqxKWqh8Ki78aDKKhP+4jZuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899670; c=relaxed/simple;
	bh=JQVFkql8pWeK7mXHaJQC6Gx6KXjAssW26okHU8bcIA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNYAKc99ubrpFB9XzwyjaaXquO6UyqNM5OzUqXvtCFhg+1hM98xpMa6InUbklIfCmYOuc53KoA10Uxia95kmX5zlRw9NJxsDHzNdj6q85shpYXDDUeMct5pa0y4vuoLXrv5ANCVLR5sDenNBBu9taZg41C2FZLpnD48Z6BtaeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CcNSXCN8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so20034175e9.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899667; x=1762504467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Brce2942SeTVJJTNYHk2AtyCkePvDy1yHUmXXiPEbXA=;
        b=CcNSXCN8WDDng70OdVvWRSucR6peMiB+orO6aX3K3eviSeNCIrRkQLHtz4RSn7OYQ9
         rtjwdOAWKsx4/jkLbhh8f3Z1d8Rey9454hMhCsqKisgPtKn5YMBguXDtbcM3qr+8cuWw
         4Gt+cwJi2dwb408jjCcuCHA5XDagHWbvfLNCXoHBu3dEtQB4bZRaF2GOP6HV1ozRysT2
         zMhcxOcq534VG6DI4dNzP9jYEdRLTWkI39K5jwVLh2iVJKZRcVjXa2pMEEdRsFQDgtO9
         jnT0pfY4655UvndmSOkz0H/aNTt4EOOqvp061i0dojQDcSw7DtUfEdd6+fMfJGJ5RqkR
         AAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899667; x=1762504467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Brce2942SeTVJJTNYHk2AtyCkePvDy1yHUmXXiPEbXA=;
        b=kMCReMdSAFJiHJCp9awcnib6Z5a8S9J1sxSx9AGI1+4v/PdZJw7kfCcCVPGgJ9nKAa
         QpNaofbQZZEs/WlCcRzFldBSOJlirPsscESI1UNYqw24VbcXM4rnurPPGFMqkczPFiyT
         Zq8O7JhLe3lDz5wioWqvEWx1SF9Lt40CrJnVC4haWww6fb9SpbYG1QhmuPUKQxtyqeOI
         w8MgZhI/2b5AmmBRLyHUdYo4XkflZHB6XQNxdrPnKU0a79d3c9dysho8yh5aHh1Zdn7z
         m26Gq7Aa7hpudHY9qUUKSWrwxR+jzGcIq+bOjc2PnkB/bx/dASwZYK7XYaWgvx0kKuAz
         7tFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6vYjM73vmkhz0VCzYtlGsWbwhHPxnmGVgU48eIiqqr8Du+CGX9TlLunHw7tw1BuQac1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0e++lWtNhBgMSTjTO11e2xmvBr4l2SOU7Fbqq/FtMxaJ2td1T
	YIBvAuxomsaxoVv4hHqxlDRKPIpXf4EWm3qdw/CLDhx1dpBc5OXyafelWOi+jAFRkUc=
X-Gm-Gg: ASbGncvEiGiPUHyB5DylJ+F1Dw62mJJiaageUokCZvQk90VcMm/ZI2I0w/7d3M4P3vL
	FDDstaooWhcjIyoYocAFE0WXatIVkPo6d5yuuqaP6n6tFbrIMgtQBRw6T9Uoi5l7TC8XX82jX5S
	kJZDXTCtIiKZSa9CozYd+yGYWtG7Gkx/hj83AqV2YRJamocKqFAHTy+I9wUx8bn1jEfaP64H7iK
	5ynqKa71hSRaco9mcI/N9ikAHlvVCH+cxuA/idXtOzVI9BXgn7K30hp8Na0QGXvEzHC+YZNLx8+
	AO4YAP4I64E5/nVgQGMPIW0o+t+QZLFTZWexa9djCgPuXKj5ZabX/0o9cr/Xl2cp5IQpefo5EJR
	ed8VNly8eLVL4YV9Og4jSfqcyu14GA4e6vR7D0ZKwdu0T9QJqucX8198B9JvL/WPt4Z7aCSwzkO
	4hoISkSMu5XRLoIQ==
X-Google-Smtp-Source: AGHT+IEqeWzc1dYod8DDM80O+3DfRoIrCHAb+32/10VgcqcE8gyD3g3E2A+vxz5v6zZlDzTIz39ZaQ==
X-Received: by 2002:a05:600c:34d0:b0:475:daa7:ec60 with SMTP id 5b1f17b1804b1-47730872dcamr20908505e9.21.1761899666777;
        Fri, 31 Oct 2025 01:34:26 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf6c05sm17137655e9.4.2025.10.31.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:34:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:34:25 +0100
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
Subject: Re: [PATCH v2 05/23] mm: declare memcg_page_state_output() in
 memcontrol.h
Message-ID: <aQR0kf_g2e59JCmz@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-6-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:08, Roman Gushchin wrote:
> To use memcg_page_state_output() in bpf_memcontrol.c move the
> declaration from v1-specific memcontrol-v1.h to memcontrol.h.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 1 +
>  mm/memcontrol-v1.h         | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9af9ae28afe7..50d851ff3f27 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -949,6 +949,7 @@ static inline void mod_memcg_page_state(struct page *page,
>  }
>  
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
> +unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  				      enum node_stat_item idx);
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6358464bb416..a304ad418cdf 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -27,7 +27,6 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  void drain_all_stock(struct mem_cgroup *root_memcg);
>  
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> -unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  int memory_stat_show(struct seq_file *m, void *v);
>  
>  void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs


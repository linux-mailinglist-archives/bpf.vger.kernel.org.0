Return-Path: <bpf+bounces-73142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF48FC24019
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2ADA1A2243B
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFB32E6AC;
	Fri, 31 Oct 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RzzqwFHe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2132D7D6
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901346; cv=none; b=g9iH+BnYItQQbBzD3xG0SIRIp/+GLE7PrGfaZZbY+m1HlE7GSfAHoHRPdTK+I49TN87uMN1HQIhtlnIZlAcEze/nV+fofhNEhsaEs8dH7ipN/Vker8yRCBfvebH76pvWwJQo1DnbcNUnzGhejpRJraJIGuRBTCMXI5pRbwU/7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901346; c=relaxed/simple;
	bh=5L+p7IGlH9yxzXYuJ5A/xcCJdZwumWBo4CpmEJWmbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLG3dWybRD9x41RbQVIOkaa9RtT+A57FU3bOUVrgP7HRmkDY64uEg9VXBVT5XIZqTyCoVZI1bj9zi1+C8A7fvu/ieTKNLLVFe2AN0Cw+s5pMtStZLYtj5wKzAQEqW8F3fPFWch13T3zjXSSRJgTrpmEoRytOY/Z5f0rZNeAjVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RzzqwFHe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso12803415e9.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761901342; x=1762506142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=riW5F2YSMNEn22/E8/Ov0+qACVsdJ9lrTJanAog9mm0=;
        b=RzzqwFHeq8mHTQQLBrfVbIaGKcPNijJcRahj6PCDHLbN4OfRBAhOiqIHBsPDHR4WMz
         J2kqpovmbFY8RTTR21Ri1n8n8kY3UdPdg6/lydX2fNRaYBkQfVmLAj6+lnJBrB+xYjsk
         uB9gxnQBqs35PRI79TLrvrNULt+JQeTU1zJvfzUpG+MEpeHMHWyOsUxtsarC/XBbxD4G
         YsmqsBW7GgQc8WFfb61+zqj5Y+lg0quMCGut54tjF3Lr+Yu2lpsfccsv8LecJs/h8G/Z
         3GuK844tywnUnj0pGJeODekBQ8wXlnYvcWEMRh3ZwxfCAAsj4sfWtf6tl82LxO3HhV/S
         xwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901342; x=1762506142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riW5F2YSMNEn22/E8/Ov0+qACVsdJ9lrTJanAog9mm0=;
        b=RDwwwpKgnXIx4sQl5aeTTBz6L1SpNdOXaSVgf2mn6rH6Q+zZ/zOTtcT+2qB9xQ6iy2
         J5Aqm+CBMKyGJdZIaQ+ATnxSilNpELzExygaN2/loiRYaaF6EpF7Pe3EaVlthkVVqyOI
         1cGnhOBIiAeVGm7HpygnHwD8tIAp7Vynn/QsYXpmcRAQ59TlJKFv1NO2bvB14ppz/neL
         RBlm3CBWA2wRlkuMAFa9V3AJnz0NkBwz1KC92MLDIfx0EIyoFokAEgu56Aoqs+MCXZan
         pOvMeeI+3f/aF1bIUG/OsjK20IhsACmj3eHfu9q1BV4hSjKbWcrb0ABmKUSzpU1kBLte
         lk8w==
X-Forwarded-Encrypted: i=1; AJvYcCXzGX5qrup94CGUmXYpH10+TXE6cNWsykeZO/cCpu/IU/cuwYyskSRfEJa/Lx8NkTyXm0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvB7S0CYES6mQmx2tn5aVfU3gCXgPUiK4RF6/FbzwU9FtMarQ3
	SjhLC/8xRtHakVN4Mc0URbXzZaomXjYTaUeZ8g4IZF9iuHN7Bu0PbDmmFCcUlE9OgvY=
X-Gm-Gg: ASbGncuqF9rF1AQ0LF9KihC6+f1ixIgEb2VfsQMsZRtvTLltQLUAriNQHs8P4ekdzBN
	o6/h8MO5ijWSvL22iPO2hC0lMEiNcuXv8rQGw3PEO5uETDtxcO6oBi8hjVL2ItMgASfTHW00mEC
	4NciJKY/QU2jmZNvB3vVIeEl+RnnnyyThT2239YjoIyt+0ZPaiJFc/175Fl8Oi6JMFCjWYG0hcK
	dCVhd2xdCE6ynxxADs4shbFWkRvNMZaABxs7ytOwgirEDhIw49Y7PBg+Gzqt/nNp/8l0mJVeG+u
	HIPiiXZBLsZVeXcsXueVvqyErgk4rWWIA/U0oz/UuaJo3cp27UcqTR80i5YlUOZb5BDuan+Y7Uo
	GZTstRzsw7Ajuc0e+c4QLeY8m2J8HkzCzAA8xX0wInag9XEudbrQbIt5ssfQIVd29MRL9n6V0gb
	A9O2a8zNFjOMf+QnVFZomp3cf302G2ZFyCgk0=
X-Google-Smtp-Source: AGHT+IEfIG+L9PugHrFEoMpYM/xl7+uFJi6ldJ6zhfB62Pmwm0o3+Vbm3I+W0dyQ0yvCl4rrfOq5Ig==
X-Received: by 2002:a05:600c:1d9b:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-477308c8b64mr25548685e9.36.1761901342084;
        Fri, 31 Oct 2025 02:02:22 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd38c4esm16895485e9.12.2025.10.31.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:02:21 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:02:20 +0100
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
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aQR7HIiQ82Ye2UfA@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:09, Roman Gushchin wrote:
> Introduce a bpf struct ops for implementing custom OOM handling
> policies.
> 
> It's possible to load one bpf_oom_ops for the system and one
> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> cgroup tree is traversed from the OOM'ing memcg up to the root and
> corresponding BPF OOM handlers are executed until some memory is
> freed. If no memory is freed, the kernel OOM killer is invoked.

Do you have any usecase in mind where parent memcg oom handler decides
to not kill or cannot kill anything and hand over upwards in the
hierarchy?

> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory. If both are set, OOM is
> considered handled, otherwise the next OOM handler in the chain
> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
> killer) is executed.

Could you explain why do we need both? Why is not bpf_memory_freed
return value sufficient?

> The bpf_handle_out_of_memory() callback program is sleepable to enable
> using iterators, e.g. cgroup iterators. The callback receives struct
> oom_control as an argument, so it can determine the scope of the OOM
> event: if this is a memcg-wide or system-wide OOM.

This could be tricky because it might introduce a subtle and hard to
debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
Sleepable locks should be only allowed in trylock mode.

> The callback is executed just before the kernel victim task selection
> algorithm, so all heuristics and sysctls like panic on oom,
> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> are respected.

I guess you meant to say and sysctl_panic_on_oom.

> BPF OOM struct ops provides the handle_cgroup_offline() callback
> which is good for releasing struct ops if the corresponding cgroup
> is gone.

What kind of synchronization is expected between handle_cgroup_offline
and bpf_handle_out_of_memory?
 
> The struct ops also has the name field, which allows to define a
> custom name for the implemented policy. It's printed in the OOM report
> in the oom_policy=<policy> format. "default" is printed if bpf is not
> used or policy name is not specified.

oom_handler seems like a better fit but nothing I would insist on. Also
I would just print it if there is an actual handler so that existing
users who do not use bpf oom killers do not need to change their
parsers.

Other than that this looks reasonable to me.

-- 
Michal Hocko
SUSE Labs


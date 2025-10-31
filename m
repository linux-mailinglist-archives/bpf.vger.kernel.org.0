Return-Path: <bpf+bounces-73145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC37C242BD
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AC1888E18
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FA304963;
	Fri, 31 Oct 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a1XIlnFG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728830C373
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903102; cv=none; b=VtI9cGbcl7j71dsSOl8pdhBLiHMqKGbgQfw1xrfDOvCSdgbBS+bQQlhbZAh0cWQslOFelZ3oOr6PoHsTw0fffenGwfpRDVICxN4HAZgRZvaBrQNgJhuv8VTnVeuKuPsZ2am67UCR8Bno6+elKShjAagVSH6b+rPuiraFDnUhUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903102; c=relaxed/simple;
	bh=i4aMKq8odkJsmnkgFgZb/jGnVc3hqLQys6Z2jKNzKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZhbcKVTGVc4BHE4cctDeD19awmd2uCLLYm1ba2TDgJdsYCXA+vNXnsSHlaS8/Y+KYMpN5dnc05VOESf3L4yxouPx0SIj1LbkT30kjIgbc7ygwJ+ranGtgsdXSCu4MrtoiE2ZKcVmoKPQHbIg+rT77xs0Rmj51HTBo5gtjj9nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a1XIlnFG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1626578f8f.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761903098; x=1762507898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZqsIXX4i9fDMKAO6vBiIA93QUBSotAqCxkbGp8FfSY=;
        b=a1XIlnFGbVmSXPIHKjrxruZ3Z2498LvXcobTpqUdQUR9MFYuQyd24n7i/YARgRZxR1
         TYecy44ZiilnBYTWe0m6wYXmN7Kx6bRYSZGQpM9NldJgYGPbNn8kT0fe/p43Y4yojfY6
         Mc6JuF6rxIDWn13xGQ782UIJnBVExxtpgLipGeexq7DHgcjHXZ4DMZ7Zs5Ug4LtSCrou
         bJD7YS5GLhhB4QjPpN0dMjI2cR3pnK2XGapHnjroIWpuLSM2GV7RQPq7/FZsc1J+VTDP
         ZPlGmZGU9WOB6/bl+2yUJIycEXrVTFmvJxx8wVTU36ytYsadSZZN+7oaY7+8YeAAaP/p
         LZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903098; x=1762507898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZqsIXX4i9fDMKAO6vBiIA93QUBSotAqCxkbGp8FfSY=;
        b=n5pU2Q1Vqm6iCn3dOQY2+PYgIZD/tSJFSHFdogOWRFwvzkbxihiKDNSvPo/hUtLAQD
         FIjlDQtMZA07f7THUF3dB6ssDzyml0l6co11L0ozoV7FDIkM3Qa0QgQkiegtRzopQkyR
         mQ19Jdb59+2C+nFIrrWSjD5Aj722majXKGRYjcYreZEzbJxmMeIRPJWLltIHTG3OeAYJ
         pGu/rGSC5fMspUQqcITCPOkoGUjrwccJkK+J+ETymcAfI8hvUo366stNuMgA68BUySCq
         vZ3Rm+yQHOY59qy97RNsshh8pgJB8CrL/uSaAcVMbGOot3kOfnR7aZUixPCfMAKe0H0R
         bnuw==
X-Forwarded-Encrypted: i=1; AJvYcCURCkHieBJHBKS6bJy4+etc1ztxdtNPpV47lmFjMwLvWL3uO6ydyR27gfZzdHIxNFTpy8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38KIZ/rQKXEhp4n5eSiZvJUMSJtwZjIlQzyoYJxaNodV1ISzL
	2a0HrnTf/jgnPN/cVqBVmHGriJGca7kjn80RlTc4EBBLFtDbq9I0pUtPkgpY1Vba9l4=
X-Gm-Gg: ASbGncscsII7poUdVoCSGU91i2tq76rA2kLmvCcLXY8TcqQqlP2kUn+AGlCu/dHXTyI
	lf9Z2RB3oJdaXlsNonHZuJ2rF1FxXqIawhW46Zv+aelhXNWE3UvjrmCBroFwULc9576/898yhTH
	q/XBR9UPrbOkH6xi8jnelPJQNTu7GShLUJri2KX6LWyGBSsNOYe0CL1YzLVZY6KqESnRILSeEoJ
	XIo6rtSbVZwcwdsSMfzzvMKObDs83Z5j17F8eNBJiK4qjl5Dbg1em8GbvA3a8eEdix1OedaHmXR
	kXwaIaJGe4MX/KdGUGrUXe5YwPfCVvtvl9TzhgN7YvOZO/vKZU+WOn+0bVCtflpJoStAfOotZnT
	KsH77d1SafKignmgAamK59M3PrtJ+WEZ8pwyepV0R866NTNKVJbhLP+9w+daxMrOqf0v0PrPL5q
	/MbatMLxniO0q5iw==
X-Google-Smtp-Source: AGHT+IG50zQtJd3CIUQKj9ncFkPdrH/t/rsOh53ftoZJnLGX9Bc7esexz1A2xxBb08Zp7FtUCXSR/Q==
X-Received: by 2002:a5d:588a:0:b0:429:b52e:351c with SMTP id ffacd0b85a97d-429bd69ff31mr2719399f8f.38.1761903098515;
        Fri, 31 Oct 2025 02:31:38 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13edc36sm2536910f8f.37.2025.10.31.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:31:37 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:31:36 +0100
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
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Message-ID: <aQSB-BgjKmSkrSO7@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls. In this scenario the userspace daemon was supposed to handle
> the majority of OOMs, while the in-kernel OOM killer worked as the
> last resort measure to guarantee that the system would never deadlock
> on the memory. But this approach creates additional infrastructure
> churn: userspace OOM daemon is a separate entity which needs to be
> deployed, updated, monitored. A completely different pipeline needs to
> be built to monitor both types of OOM events and collect associated
> logs. A userspace daemon is more restricted in terms on what data is
> available to it. Implementing a daemon which can work reliably under a
> heavy memory pressure in the system is also tricky.

I do not see this part addressed in the series. Am I just missing
something or this will follow up once the initial (plugging to the
existing OOM handling) is merged?

-- 
Michal Hocko
SUSE Labs


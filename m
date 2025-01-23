Return-Path: <bpf+bounces-49593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B77A1A94B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A44A188AB09
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57425154C07;
	Thu, 23 Jan 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HZ7OiVjq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2785FEE6
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655307; cv=none; b=Psso62gmkxqWYgJ+Wwp5JJ2FrT6iaxpOs3w0b4+KyLmXJ7eFJq5G9OKGAmaisJy7K2hlRicRV78Od4006UCr6xU+8iT/v45aYfnpVhgBcEfcih7llE41vwP5f7J6Wyc3IfM8Vhxr6XHgzXObuAuKUNfs99pjkhJO0UpYcaJVp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655307; c=relaxed/simple;
	bh=a+wvI6s5OG0/4/Kp81DJZpgEQT6Tr4dBQvYiZd85jJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aksevuEIhHYYCLYXiujvLl/zlytDzTLICDESw0mBbwt65hWu6Sh4/SMIJHYkkevHIOCnghlVMV9CcGWDSD8yIDfEXxoJsyb/0yEk3BeKomdvdQqLKmx4GwrmVCc9L38QfvPdvE/hjIlXsZkIf8n8yCZiczIqyRMbFoAgYTbTkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HZ7OiVjq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f7d35de32dso294690a91.3
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 10:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737655305; x=1738260105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZA/H5bVrFbA/i0rTND2KaNKy+1cl1snV3q4LxBnVjo=;
        b=HZ7OiVjqmneQu4pE5GKoYSgUS2Kl3+LOAttmMLTe0TZDqjLXsHWqTtaAGP43SG/ih7
         3gDX3Y/4HHO64wTp+5gSIwKnYlA/+1q8npoZBxSGojfGadQyC0L2KweGAy4ifasHUo2U
         D19knnd/zxWQKTEc+5OItmBOzgCI1Su64Km12/r1DyGUER4azAlD1CHlRYfJRLWxWOQm
         IH8hMy45usHDC8xG4o7Ntt/B+kXmfSvyoYBt3EGmdTHvXjnKqTTga8fHx0AyXl0ourpc
         3QOfEiKy1R8WGqi3b8Fe5Un2kRJS5h9GJ9QaGtmK+wSYeFQ15032WZQSK5utXDWT58wF
         d79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737655305; x=1738260105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZA/H5bVrFbA/i0rTND2KaNKy+1cl1snV3q4LxBnVjo=;
        b=TH7fABxMAQuj5KaUl3bJd0i6BQrL1dnD/1zr4SMNphfFyRUGhuSOF5HGU9alkfty1Q
         VjWzCgYbOB5hRdQL95Avm3PGvP4IXvntWhchEYYL1q64Y4QlqMdCDpMnNq2d/TFAaTVo
         VMT/S0i+QZvBnkUE7jR6LebwvkSVMLLbg3XcXWQGQBjDSy/ZUwuiXXymtWm60Yd3bZRk
         tiaR6AXDBB92FxDDQmjWsbDfXFca5IeIo5zMmPi1N5KFFCqQNX3nI8tpmUfneOolvkob
         zl0w7yb10ivnFScVWlMidN5lnc5OdDgQjZjkNjP6jFWdCjjlaVN8rciVW/n4HHq5Mee8
         FSUw==
X-Gm-Message-State: AOJu0YyLmJeoGsavcrK0SghxpQ/l/7pUE4GO8RNzi2jj2oR+8hnWxEe9
	FXjZNPQC7V3Rx/Ev6OlKtlNf3zdjvgAKXSKHn2Js5h4BpDFotIxU5xWVQ92upRs=
X-Gm-Gg: ASbGncsPAbBB6h8dFQ6eeJzUBxHW8QZNQJa8RvcfUkhmiBFYgr9WNyQs3PCarbIUemm
	xWUbdUNQo607hElA/AjV0rfWYiKdG4JszcmNb6Gx7lo6i6Z/MNPGDb4ApZeDNS4L+pABLWxY84O
	/fypxVszsnC42g8D2X5OcqmMdea6G/dkSzK5poYh3FmeO9vRvMqQLwXWdOmGDarsmswmc+fQaDB
	e5WCkHf6zWQn7uncsE05aTyidInsv45w63TWjGBfZ2PEH2LSzwk2O/yR+YPOzxDgTcni8+Hb39I
	E/8MfwHcNaleNqqw2Sv2SvldFe3AvQ==
X-Google-Smtp-Source: AGHT+IFuj2y9YbAJGQzA2qK0yg55WTeAT3tbvUZTLLGYrpLVA3b5dcRHTVoHkhgxBynypxV8UNKxsQ==
X-Received: by 2002:a17:90a:c2c6:b0:2ee:3fa7:ef23 with SMTP id 98e67ed59e1d1-2f782da78e4mr14670308a91.8.1737655304639;
        Thu, 23 Jan 2025 10:01:44 -0800 (PST)
Received: from [10.254.144.106] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7fe97010bsm196773a91.40.2025.01.23.10.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 10:01:44 -0800 (PST)
Message-ID: <69264563-bad1-4c22-8165-822784091dcd@bytedance.com>
Date: Fri, 24 Jan 2025 02:01:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>
Cc: "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20241221061018.37717-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping :)

On 12/21/24 2:10 PM, Abel Wu Wrote:
> The following commit
> bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
> first introduced deadlock prevention for fentry/fexit programs attaching
> on bpf_task_storage helpers. That commit also employed the logic in map
> free path in its v6 version.
> 
> Later bpf_cgrp_storage was first introduced in
> c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
> which faces the same issue as bpf_task_storage, instead of its busy
> counter, NULL was passed to bpf_local_storage_map_free() which opened
> a window to cause deadlock:
> 
> 	<TASK>
> 		(acquiring local_storage->lock)
> 	_raw_spin_lock_irqsave+0x3d/0x50
> 	bpf_local_storage_update+0xd1/0x460
> 	bpf_cgrp_storage_get+0x109/0x130
> 	bpf_prog_a4d4a370ba857314_cgrp_ptr+0x139/0x170
> 	? __bpf_prog_enter_recur+0x16/0x80
> 	bpf_trampoline_6442485186+0x43/0xa4
> 	cgroup_storage_ptr+0x9/0x20
> 		(holding local_storage->lock)
> 	bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
> 	bpf_selem_unlink_storage+0x6f/0x110
> 	bpf_local_storage_map_free+0xa2/0x110
> 	bpf_map_free_deferred+0x5b/0x90
> 	process_one_work+0x17c/0x390
> 	worker_thread+0x251/0x360
> 	kthread+0xd2/0x100
> 	ret_from_fork+0x34/0x50
> 	ret_from_fork_asm+0x1a/0x30
> 	</TASK>
> 
> Progs:
>   - A: SEC("fentry/cgroup_storage_ptr")
>     - cgid (BPF_MAP_TYPE_HASH)
> 	Record the id of the cgroup the current task belonging
> 	to in this hash map, using the address of the cgroup
> 	as the map key.
>     - cgrpa (BPF_MAP_TYPE_CGRP_STORAGE)
> 	If current task is a kworker, lookup the above hash
> 	map using function parameter @owner as the key to get
> 	its corresponding cgroup id which is then used to get
> 	a trusted pointer to the cgroup through
> 	bpf_cgroup_from_id(). This trusted pointer can then
> 	be passed to bpf_cgrp_storage_get() to finally trigger
> 	the deadlock issue.
>   - B: SEC("tp_btf/sys_enter")
>     - cgrpb (BPF_MAP_TYPE_CGRP_STORAGE)
> 	The only purpose of this prog is to fill Prog A's
> 	hash map by calling bpf_cgrp_storage_get() for as
> 	many userspace tasks as possible.
> 
> Steps to reproduce:
>   - Run A;
>   - while (true) { Run B; Destroy B; }
> 
> Fix this issue by passing its busy counter to the free procedure so
> it can be properly incremented before storage/smap locking.
> 
> Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   kernel/bpf/bpf_cgrp_storage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index 20f05de92e9c..7996fcea3755 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>   
>   static void cgroup_storage_map_free(struct bpf_map *map)
>   {
> -	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
> +	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
>   }
>   
>   /* *gfp_flags* is a hidden argument provided by the verifier */



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5092491F3
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHSAsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHSAsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 20:48:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB5EC061389
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 17:48:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so10007057plr.7
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iEPCmFRkwYg3QsJdcethGpWETNkcC27/ovRpKU64XS8=;
        b=JLmdhOkuLX0hWDiUIwgQPlRgjdCecpzAyCJ44pmrLXKB//kpAOF3XWJXm8kPRaTXOl
         t3fwNApOOnIQiy+JeEpDXSSp1hT3UUqMQmJpXgCeN69np77R8FA3IWU+gCzsFFJ1WLBr
         wlUMDVS5jaT4T4YVQtuVUEtxZWPXMeoK0n9UFstva0/0IRO4Qf+CMFaABWq2SQqeNQ4h
         dgT3nH2UFmZoA7DPqREB7tE+poysnbEfwgVoHnI7PorOoWZF0//xRs7bQcS/uOc9lURV
         Djf4R6txwTAOAcTyNnWl6pvY5S0rrog/S0S6i+F7kckrUCobPaHXQS5z7py9W7LriXZ6
         QUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iEPCmFRkwYg3QsJdcethGpWETNkcC27/ovRpKU64XS8=;
        b=U75s5pJOZUVVHY555K3VTlzBUv4CbKHL4fjRZKfOWf9LaeL+bTCuZstuY+ygOWs08u
         sGCF9yGin5qytzHQP4rwi5f9BTPbf9KXhyBc+5MU+osGZwCsANsGss4Cqv3K2jqzgBAr
         A0IQZlWlu31jchQfZmMB/3iVyJfb/OB/IYatKxgie6PBL7rET8EwOueAph5TGhULkuWy
         INttAjnrP9VkV44ogQp1dzR7CIC9pFOO3ccPgBjEvAPYvM0A9AhiCbxCZsWWQiWTEoVj
         OE0kQ527UFlOL1mHC+nX7RsRVREiyGyqXq64nFzE/gKKVCiHhLZ73uz3nYBHnhPbM+2p
         LHGQ==
X-Gm-Message-State: AOAM532O0JWNapXawiKUHBlGvgysaqctpSyCbVHWeHgbdLclrdnkGR+e
        y4fKUUaKnebO0vUwP7BdY84=
X-Google-Smtp-Source: ABdhPJyh6cmBeQa9pcloVvsi2HZiL/YHG14u6A49AQ9okA5u6yT0d2Kya+P7smg2+MSJ4r6GgqrvZA==
X-Received: by 2002:a17:90a:1347:: with SMTP id y7mr1917120pjf.183.1597798132627;
        Tue, 18 Aug 2020 17:48:52 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:20fd])
        by smtp.gmail.com with ESMTPSA id k12sm973874pjp.38.2020.08.18.17.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 17:48:51 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:48:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: RCU protect used_maps array and
 count
Message-ID: <20200819004849.xyeciwi4tpsxauee@ast-mbp.dhcp.thefacebook.com>
References: <cover.1597427271.git.zhuyifei@google.com>
 <7e37411ca33ae89e2a98dd95707a35caf2fd542e.1597427271.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e37411ca33ae89e2a98dd95707a35caf2fd542e.1597427271.git.zhuyifei@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 14, 2020 at 02:15:54PM -0500, YiFei Zhu wrote:
> @@ -3263,6 +3268,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  	struct bpf_prog_stats stats;
>  	char __user *uinsns;
>  	u32 ulen;
> +	const struct bpf_used_maps *used_maps;
>  	int err;
>  
>  	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
> @@ -3284,19 +3290,24 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  	memcpy(info.tag, prog->tag, sizeof(prog->tag));
>  	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
>  
> +	rcu_read_lock();
> +	used_maps = rcu_dereference(prog->aux->used_maps);
> +
>  	ulen = info.nr_map_ids;
> -	info.nr_map_ids = prog->aux->used_map_cnt;
> +	info.nr_map_ids = used_maps->cnt;
>  	ulen = min_t(u32, info.nr_map_ids, ulen);
>  	if (ulen) {
>  		u32 __user *user_map_ids = u64_to_user_ptr(info.map_ids);
>  		u32 i;
>  
>  		for (i = 0; i < ulen; i++)
> -			if (put_user(prog->aux->used_maps[i]->id,
> +			if (put_user(used_maps->arr[i]->id,

put_user() under rcu_read_lock() is not allowed.
You should see a splat like this:
[    2.297943] BUG: sleeping function called from invalid context at kernel/bpf/syscall.c:3305
[    2.305554] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 81, name: test_progs
[    2.312802] 1 lock held by test_progs/81:
[    2.316545]  #0: ffffffff82265760 (rcu_read_lock){....}-{1:2}, at: bpf_prog_get_info_by_fd.isra.31+0xb9/0xdf0
[    2.325446] Preemption disabled at:
[    2.325454] [<ffffffff812aec64>] __fd_install+0x24/0x2b0
[    2.333571] CPU: 1 PID: 81 Comm: test_progs Not tainted 5.8.0-ga96d3fdf9 #1
[    2.339818] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    2.347795] Call Trace:
[    2.350082]  dump_stack+0x78/0xab
[    2.353109]  ___might_sleep+0x17d/0x260
[    2.356554]  __might_fault+0x34/0x90
[    2.359873]  bpf_prog_get_info_by_fd.isra.31+0x21b/0xdf0
[    2.364674]  ? __lock_acquire+0x2e4/0x1df0
[    2.368377]  ? bpf_obj_get_info_by_fd+0x20f/0x3e0
[    2.372621]  bpf_obj_get_info_by_fd+0x20f/0x3e0

Please test your patches with kernel debug flags
like CONFIG_DEBUG_ATOMIC_SLEEP=y at a minimum.
kasan and lockdep are good to have as well.

In general I think rcu here is overkill.
Why not to use mutex everywhere? It's not like it's in critical path.

Also I think better name is needed. ADD_MAP is too specific.
When we get around to implement Daniel's suggestion of replacing
one map with another ADD_MAP as command won't fit.
Single purpose commands are ok, but this one feels too narrow.
May be BPF_PROG_BIND_MAP ?
Then later adding target_map_fd field to prog_bind_map struct would do it.
I thought about BPF_PROG_ATTACH_MAP name, but we use the word "attach"
in too many places and it could be confusing.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6B44E448
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 10:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhKLKAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 05:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhKLKAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 05:00:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E72C061766;
        Fri, 12 Nov 2021 01:57:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6869931pja.1;
        Fri, 12 Nov 2021 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0Djl+coVap5g5AYtIOSpP+Dwu88sLdonLbR8C/Yz5+U=;
        b=WWjIAKWA7sGIgncZNFH1IQO8FgRsjlcCngf/pkToHjD7ZK5pOHv020u7J69T7NSiuo
         jhRrPROmNr0bLsF32QXhEQcxXLvPxg8qSHt/rE901E9ejP6dWI8PDF5LQ2RDRkaq1QjA
         IIB6SwdgeLOo7r+qnU5DEHIrRyT1RpmnXTz2xAI0V0wjuCeTWu8KQvddLK2MG+XoZQfQ
         jvRlZnmi2VPQWifyFy6O6HyTA8iedYsmgq12seV1rA7Opg5zbQFK6rUynBxA6ozs1tMQ
         bw9T81/Dtx/ktimSqGPwux2QaKK7vjgCU7Yg5gbUeiOXdKoxYuMQhBm0Xh9ARTpVK7ea
         K1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0Djl+coVap5g5AYtIOSpP+Dwu88sLdonLbR8C/Yz5+U=;
        b=ioHR9FQniQkXtBSFVs9JAEWjo/0QYlc+2Mim1S8J1EbPJ5yvj4nj0caS6A5SEOiwr9
         K36WXISfqHUfhBAaoFxdHAdPoxpHksLwylX4hDAdnp8JbCnHw2osBd+lOeeTpKSYrWBm
         aQGZ9yJiv7Qe5mXh+RqXTQO7lNcP+u/NyT3StBEv844i66LdebFxKfzPO3AEXCIV0SQ2
         QfT8Sasv+05SsLfsm+yYRjJ4B5xP+ERB0zBZorC2zNUFF79BBEMAG9TETlfkMUmRF1iw
         yP7Y4NEPtFGgPDLvRWlEELf3O6R81VrekiO4rEElnb3xPFIXc2la6VxQmg1P8oUK8CU6
         8tUQ==
X-Gm-Message-State: AOAM533Xgan3HDKGrie2aK+Hm6YRuUWNgswxs2wKJ9YlHJvVhUmiReJO
        n4KFakZcdJtrDWQcUhd+u/w=
X-Google-Smtp-Source: ABdhPJxyUhVusbRbpuxgYokSGwf/3JQKccFFf/E6rnnKQuq8Dm70W6lks2VDg3gm3fP6YB9sRqtnQg==
X-Received: by 2002:a17:902:d4c2:b0:142:76f:3200 with SMTP id o2-20020a170902d4c200b00142076f3200mr6522058plg.53.1636711073077;
        Fri, 12 Nov 2021 01:57:53 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id x20sm4612772pjp.48.2021.11.12.01.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:57:52 -0800 (PST)
Message-ID: <1a1c39a1-1b23-520a-d912-b77dfd59ce21@gmail.com>
Date:   Fri, 12 Nov 2021 17:57:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] x86/perf: fix snapshot_branch_stack warning in VM
Content-Language: en-US
To:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211112054510.2667030-1-songliubraving@fb.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <20211112054510.2667030-1-songliubraving@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/11/2021 1:45 pm, Song Liu wrote:
> When running in VM intel_pmu_snapshot_branch_stack triggers WRMSR warning
> like:
> 
> [  252.599708] unchecked MSR access error: WRMSR to 0x3f1 (tried to write 0x0000000000000000) at rIP: 0xffffffff81011a5b (intel_pmu_snapshot_branch_stack+0x3b/0xd0)
> [  252.601886] Call Trace:
> [  252.602215]  <TASK>
> [  252.602516]  bpf_get_branch_snapshot+0x17/0x40
> [  252.603109]  bpf_prog_5c58f41f99af93ce_test1+0x33/0xd54
> [  252.603777]  bpf_trampoline_15032502913_0+0x4c/0x1000
> [  252.604435]  bpf_testmod_loop_test+0x5/0x20 [bpf_testmod]
> [  252.605127]  bpf_testmod_test_read+0x8f/0x3b0 [bpf_testmod]
> [  252.605864]  ? bpf_testmod_loop_test+0x20/0x20 [bpf_testmod]
> [  252.606612]  ? __kasan_kmalloc+0x84/0xa0
> [  252.607146]  ? lock_is_held_type+0xd8/0x130
> [  252.607736]  ? sysfs_kf_bin_read+0xbe/0x110
> [  252.608513]  ? bpf_testmod_loop_test+0x20/0x20 [bpf_testmod]
> [  252.609332]  kernfs_fop_read_iter+0x1ac/0x2c0
> [  252.609901]  ? kernfs_create_link+0x110/0x110
> [  252.610509]  new_sync_read+0x25a/0x380
> [  252.610994]  ? __x64_sys_llseek+0x1e0/0x1e0
> [  252.611538]  ? rcu_read_lock_sched_held+0xa1/0xd0
> [  252.612165]  ? find_held_lock+0xac/0xd0
> [  252.612700]  ? security_file_permission+0xe7/0x2c0
> [  252.613326]  vfs_read+0x1a4/0x2a0
> [  252.613780]  ksys_read+0xc0/0x160
> [  252.614218]  ? vfs_write+0x510/0x510
> [  252.614684]  ? ktime_get_coarse_real_ts64+0xe4/0xf0
> [  252.615423]  do_syscall_64+0x3a/0x80
> [  252.615886]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  252.616553] RIP: 0033:0x7f62aa7f08b2
> [  252.617011] Code: 97 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 96 db 20 00 85 c0 75 12 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
> [  252.619333] RSP: 002b:00007ffe72c83628 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  252.620252] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f62aa7f08b2
> [  252.621138] RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000028
> [  252.622035] RBP: 00007ffe72c83660 R08: 0000000000000000 R09: 00007ffe72c83507
> [  252.622951] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000040d090
> [  252.623890] R13: 00007ffe72c83900 R14: 0000000000000000 R15: 0000000000000000
> [  252.624829]  </TASK>
> 
> This can be triggered with BPF selftests:
> 
>    tools/testing/selftests/bpf/test_progs -t get_branch_snapshot
> 
> This warning is caused by __intel_pmu_pebs_disable_all() in the VM. Since
> it is not necessary to disable PEBs for LBR, remove it from
> intel_pmu_snapshot_branch_stack and intel_pmu_snapshot_arch_branch_stack.
> 
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Cc: Like Xu <like.xu.linux@gmail.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Tested-by: Like Xu <likexu@tencent.com>

I guess bpf users will be happier with the usages of Intel PT snapshot mode.

> ---
>   arch/x86/events/intel/core.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 42cf01ecdd131..ec6444f2c9dcb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2211,7 +2211,6 @@ intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int
>   	/* must not have branches... */
>   	local_irq_save(flags);
>   	__intel_pmu_disable_all(false); /* we don't care about BTS */
> -	__intel_pmu_pebs_disable_all();
>   	__intel_pmu_lbr_disable();
>   	/*            ... until here */
>   	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
> @@ -2225,7 +2224,6 @@ intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned
>   	/* must not have branches... */
>   	local_irq_save(flags);
>   	__intel_pmu_disable_all(false); /* we don't care about BTS */
> -	__intel_pmu_pebs_disable_all();
>   	__intel_pmu_arch_lbr_disable();
>   	/*            ... until here */
>   	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
> 

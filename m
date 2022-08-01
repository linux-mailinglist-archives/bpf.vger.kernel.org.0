Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD52587462
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 01:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiHAX3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 19:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiHAX3G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 19:29:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12022182D;
        Mon,  1 Aug 2022 16:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58412B815BE;
        Mon,  1 Aug 2022 23:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5927CC433D6;
        Mon,  1 Aug 2022 23:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659396543;
        bh=EthOnS7yDEmr90RlBcQIT6E/wUDMKFGG1x8VYcmF1j0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EiBIfttFLAvYAdzaQGF4B8h2IEm4SBhwDILvRRFvzTt3VDaIJ5x8zzSABoaE5ybLA
         kh3Xc3yV7ZNFlKG1JCySUUtn3eeRsW3t6QtSbytwOlrXGG1CmjADE0f4PJY4vetFH6
         J2IBlR1XZn2uTTW6jc3TFA6gcERxIZXcsB1FR8epqlhGHnu9BK5pK7K1T5O6HKLkNG
         ze7g+CPf3VxH8cdB/Xhlu84ac5CIaBVP3J0SoModjTXUKgQTUEsVgErFKV9EDgQKri
         DXR2zujgF3fftvBqx8qlgZYnXjM6i/BO1zsqyXVCSyDQ/AUl4iGqY0mYQvUck3nMWy
         QOlB5uNS1oKvQ==
Date:   Tue, 2 Aug 2022 08:28:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>
Subject: Re: [PATCH v3] kprobes: Forbid probing on trampoline and bpf prog
Message-Id: <20220802082857.51a92a167876a2e3ba270aa7@kernel.org>
In-Reply-To: <20220801033719.228248-1-chenzhongjin@huawei.com>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Aug 2022 11:37:19 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> kernel_text_address returns ftrace_trampoline, kprobe_insn_slot
> and bpf_text_address as kprobe legal address.
> 
> These text are removable and changeable without any notifier to
> kprobes. Probing on them can trigger some unexpected behavior[1].
> 
> Considering that jump_label and static_call text are already be
> forbiden to probe, kernel_text_address should be replaced with
> core_kernel_text and is_module_text_address to check other text
> which is unsafe to kprobe.
> 
> [1] https://lkml.org/lkml/2022/7/26/1148
> 
> Fixes: 5b485629ba0d ("kprobes, extable: Identify kprobes trampolines as kernel text area")
> Fixes: 74451e66d516 ("bpf: make jited programs visible in traces")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Thanks! this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> ---
> v2 -> v3:
> Remove '-next' carelessly added in title.
> 
> v1 -> v2:
> Check core_kernel_text and is_module_text_address rather than
> only kprobe_insn.
> Also fix title and commit message for this. See old patch at [1].
> ---
>  kernel/kprobes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c088ed..80697e5e03e4 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	preempt_disable();
>  
>  	/* Ensure it is not in reserved area nor out of text */
> -	if (!kernel_text_address((unsigned long) p->addr) ||
> +	if (!(core_kernel_text((unsigned long) p->addr) ||
> +	    is_module_text_address((unsigned long) p->addr)) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
>  	    static_call_text_reserved(p->addr, p->addr) ||
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

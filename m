Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2714250E382
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiDYOpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiDYOpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 10:45:32 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666571C925
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 07:42:27 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nizuq-000CDp-Ep; Mon, 25 Apr 2022 16:42:16 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nizup-000Kjg-W8; Mon, 25 Apr 2022 16:42:16 +0200
Subject: Re: [PATCH bpf] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
To:     Adam Zabrocki <pi3@pi3.com.pl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Cc:     bpf@vger.kernel.org, rostedt@goodmis.org
References: <20220422164027.GA7862@pi3.com.pl>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <008a7004-ede5-8ffe-062c-ca77649ce3a7@iogearbox.net>
Date:   Mon, 25 Apr 2022 16:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220422164027.GA7862@pi3.com.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26523/Mon Apr 25 10:20:35 2022)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/22/22 6:40 PM, Adam Zabrocki wrote:
> [PATCH bpf] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set
> 
> The recent kernel change "kprobes: Use rethook for kretprobe if possible",
> introduced a potential NULL pointer dereference bug in the KRETPROBE
> mechanism. The official Kprobes documentation defines that "Any or all
> handlers can be NULL". Unfortunately, there is a missing return handler
> verification to fulfill these requirements and can result in a NULL pointer
> dereference bug.
> 
> This patch adds such verification in kretprobe_rethook_handler() function.
> 
> Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
> Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

I don't mind if this fix gets routed via bpf tree if all parties are okay with
it (Masami? Steven?). Just noting that there is currently no specific dependency
in bpf tree for it, but if it's easier to route this way, happy to take it.

> ---
>   kernel/kprobes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index dbe57df2e199..dd58c0be9ce2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2126,7 +2126,7 @@ static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
>   	struct kprobe_ctlblk *kcb;
>   
>   	/* The data must NOT be null. This means rethook data structure is broken. */
> -	if (WARN_ON_ONCE(!data))
> +	if (WARN_ON_ONCE(!data) || !rp->handler)
>   		return;
>   
>   	__this_cpu_write(current_kprobe, &rp->kp);
> 

Thanks,
Daniel

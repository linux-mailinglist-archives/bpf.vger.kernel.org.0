Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E6615346
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKAU3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKAU2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 16:28:45 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7C167F6
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 13:28:44 -0700 (PDT)
Message-ID: <2efac61c-a477-d3c1-4270-3c98998e6497@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667334522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7VweGWTu3qLunb4EHktFAdB1jk/2Ru+GS1K3CsODsw=;
        b=LAtVugb2OBnZwcSD4TJRd8SEUyUNMCYlInr1Ai1Ulkx4O+n2hyysJMNgP5O6MJRMxQ94zi
        1fWWiC6iIS/++JZzCqVqUjsvmaceZfCMxj9Mas4QhxaD+lftim/o0xY0DQXPGFq0fiknNP
        6+HvYq1R2BKy4+puWJxt4fiVBmQNeaA=
Date:   Tue, 1 Nov 2022 13:28:38 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: make sure skb->len != 0 when redirecting to
 a tunneling device
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com,
        bpf@vger.kernel.org
References: <20221027225537.353077-1-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221027225537.353077-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/27/22 3:55 PM, Stanislav Fomichev wrote:
> syzkaller managed to trigger another case where skb->len == 0
> when we enter __dev_queue_xmit:
> 
> WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 skb_assert_len include/linux/skbuff.h:2576 [inline]
> WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 __dev_queue_xmit+0x2069/0x35e0 net/core/dev.c:4295
> 
> Call Trace:
>   dev_queue_xmit+0x17/0x20 net/core/dev.c:4406
>   __bpf_tx_skb net/core/filter.c:2115 [inline]
>   __bpf_redirect_no_mac net/core/filter.c:2140 [inline]
>   __bpf_redirect+0x5fb/0xda0 net/core/filter.c:2163
>   ____bpf_clone_redirect net/core/filter.c:2447 [inline]
>   bpf_clone_redirect+0x247/0x390 net/core/filter.c:2419
>   bpf_prog_48159a89cb4a9a16+0x59/0x5e
>   bpf_dispatcher_nop_func include/linux/bpf.h:897 [inline]
>   __bpf_prog_run include/linux/filter.h:596 [inline]
>   bpf_prog_run include/linux/filter.h:603 [inline]
>   bpf_test_run+0x46c/0x890 net/bpf/test_run.c:402
>   bpf_prog_test_run_skb+0xbdc/0x14c0 net/bpf/test_run.c:1170
>   bpf_prog_test_run+0x345/0x3c0 kernel/bpf/syscall.c:3648
>   __sys_bpf+0x43a/0x6c0 kernel/bpf/syscall.c:5005
>   __do_sys_bpf kernel/bpf/syscall.c:5091 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5089 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5089
>   do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> The reproducer doesn't really reproduce outside of syzkaller
> environment, so I'm taking a guess here. It looks like we
> do generate correct ETH_HLEN-sized packet, but we redirect
> the packet to the tunneling device. Before we do so, we
> __skb_pull l2 header and arrive again at skb->len == 0.
> Doesn't seem like we can do anything better than having
> an explicit check after __skb_pull?
hmm... I recall there was similar report but I didn't follow those earlier fixes 
and discussion.  Not sure if this has been considered:
If this skb can only happen in the bpf_prog_test_run (?),
how about ensure that the skb will at least have some header after l2 header in 
bpf_prog_test_run_skb().  Adding some headers/bytes if the data_size_in does not 
have it.  This may break some external test cases that somehow has no l3/4? 
test_progs should be mostly fine considering they are using the pkt_v[46] in 
network_helpers.h.

> 
> Cc: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   net/core/filter.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bb0136e7a8e4..cb3b635e35be 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2126,6 +2126,10 @@ static int __bpf_redirect_no_mac(struct sk_buff *skb, struct net_device *dev,
>   
>   	if (mlen) {
>   		__skb_pull(skb, mlen);
> +		if (unlikely(!skb->len)) {
> +			kfree_skb(skb);
> +			return -ERANGE;
> +		}
>   
>   		/* At ingress, the mac header has already been pulled once.
>   		 * At egress, skb_pospull_rcsum has to be done in case that


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203EB67B9B2
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjAYSlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjAYSlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:41:22 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79F5AB5A
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:41:14 -0800 (PST)
Message-ID: <e12013e7-7878-f726-ecdd-9b3ff02a5fc5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674672073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCr+Lq00X1aFUXCpQl79DGmVOVSlkbJXvf2KjuPn4AE=;
        b=vaGQmFJw2219lpbJubFSw+f618KCSR78Tdl9Bn6G9iLyDic+sffEk91x8GGfkOrZbt5mXM
        tidIztHhcGD6zJjwtXalSQ0E9DaJcgEuiXZVbQysYszyi+rNCez1n2tIkcjiQ3SYxUxT6L
        d3J9mfmY68g8uhU2uoQYtpClirn3kAk=
Date:   Wed, 25 Jan 2023 10:41:10 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix the kernel crash caused by
 bpf_setsockopt().
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230125000244.1109228-1-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com
In-Reply-To: <20230125000244.1109228-1-kuifeng@meta.com>
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

On 1/24/23 4:02 PM, Kui-Feng Lee wrote:
> The kernel crash was caused by a BPF program attached to the
> "lsm_cgroup/socket_sock_rcv_skb" hook, which performed a call to
> `bpf_setsockopt()` in order to set the TCP_NODELAY flag. This flag

Note that this race is not limited to TCP_NODELAY.

> causes the kernel to flush the outgoing queue of a socket, and this
> hook can be triggered during a softirq. The issue was that in certain
> circumstances, when `tcp_write_xmit()` was called to flush the queue,
> it would also allow BH (bottom-half) to run. This could lead to our
> program attempting to flush the same socket recursively, which caused
> a `skbuf` to be unlinked twice.

Thanks for the fix.

The commit message could use more details about this particular 
security_sock_rcv_skb() hook. Something like,

security_sock_rcv_skb() is called from tcp_filter(). In tcp_v4_rcv(), 
tcp_filter() is called before the sock_owned_by_user() check. If a bpf prog is 
run in security_sock_rcv_skb() from the softirq, it may not own the sock lock 
and break the bpf_setsockopt() assumption.

> 
> The patch fixes this issue by ensuring that a BPF program attached to
> the "lsm_cgroup/socket_sock_rcv_skb" hook is not allowed to call
> `bpf_setsockopt()`.

Please add Fixes tag. Also, this should target for the bpf tree.

Fixes: 9113d7e48e91 ("bpf: expose bpf_{g,s}etsockopt to lsm cgroup")

> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   kernel/bpf/bpf_lsm.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index a4a41ee3e80b..e14c822f8911 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -51,7 +51,6 @@ BTF_SET_END(bpf_lsm_current_hooks)
>    */
>   BTF_SET_START(bpf_lsm_locked_sockopt_hooks)
>   #ifdef CONFIG_SECURITY_NETWORK
> -BTF_ID(func, bpf_lsm_socket_sock_rcv_skb)
>   BTF_ID(func, bpf_lsm_sock_graft)
>   BTF_ID(func, bpf_lsm_inet_csk_clone)
>   BTF_ID(func, bpf_lsm_inet_conn_established)


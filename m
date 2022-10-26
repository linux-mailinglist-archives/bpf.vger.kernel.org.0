Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7F60D84B
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiJZAC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZAC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 20:02:58 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46988A02F5
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 17:02:57 -0700 (PDT)
Message-ID: <f48318a0-b155-fd3f-cbaa-39de793bf2f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666742574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NESkg+twT12z9/tT678ZBFsdIn5Nxu5U3XP7BkxREyY=;
        b=XO9et6l6dk6pYhYbQq3AN8rzIb9UwZ1AIBpeSERIS2NfNr4SCIfl2iz9k6ZmXdFrKBuXB1
        WvVz82qrUnSoIRX2c+/PsKvWueREeOjtddj3bat89i8xOiNPnI7tU3S5JcIZyW5yitZTbn
        Tor0b+H6L3utjA+qkY5tZWW+CfQEGqA=
Date:   Tue, 25 Oct 2022 17:02:51 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Return -EINVAL on calling
 bpf_setsockopt(TCP_SAVED_SYN)
Content-Language: en-US
To:     Rongfeng Ji <SikoJobs@outlook.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org
References: <DU0P192MB1547197315863E8092FC603AD6319@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <DU0P192MB1547197315863E8092FC603AD6319@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/25/22 4:22 AM, Rongfeng Ji wrote:
> TCP_SAVED_SYN is not supported by do_tcp_setsockopt(), but it is not
> rejected by sol_tcp_sockopt() during calling bpf_setsockopt(), which
> results in returning -ENOPROTOOPT instead of common -EINVAL.
> 
> This patch fixes the issue.
> 
> Signed-off-by: Rongfeng Ji <SikoJobs@outlook.com>
> ---
>   net/core/filter.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bb0136e7a8e4..42cd7ec8cc4c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5206,6 +5206,9 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>   		return do_tcp_getsockopt(sk, SOL_TCP, optname,
>   					 KERNEL_SOCKPTR(optval),
>   					 KERNEL_SOCKPTR(optlen));
> +	} else {
> +		if (optname == TCP_SAVED_SYN)
> +			return -EINVAL;

ENOPROTOOPT is fine and is better imo.  man 7 setsockopt:

        ENOPROTOOPT
                  The option is unknown at the level indicated.

It is why I did not single out the TCP_SAVED_SYN again to return -EINVAL.
I don't see how the bpf_prog would handle them differently (bpf prog does not 
allow it -EINVAL or the underlying kernel's setsockopt does not know it 
-ENOPROTOOPT).  In general, the bpf_{get,set}sockopt caller has to be ready to 
handle any errno from the kernel underlying {get,set}sockopt.

Also, some of the -EINVAL in bpf_{get,set}sockopt() is not the best one to 
return.  It is not very helpful for the bpf prog to figure out what is wrong. 
They should be fixed in the future also.


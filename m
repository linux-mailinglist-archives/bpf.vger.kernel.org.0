Return-Path: <bpf+bounces-9594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72917996BF
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039581C20C8A
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72817184C;
	Sat,  9 Sep 2023 07:32:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5C370
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 07:32:05 +0000 (UTC)
Received: from out-213.mta1.migadu.com (out-213.mta1.migadu.com [IPv6:2001:41d0:203:375::d5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837399C
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 00:32:01 -0700 (PDT)
Message-ID: <acdb12bc-518a-c3f6-ef09-2dfd714770b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694244719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNUTZSlQo/rdmCU8i48yBpvPP7gagrjHqmKJYst6mug=;
	b=R7uEP+zCWlhj1ABFDfPIxOIMzPNDaMcvL2QPNCmw4DDoOMxPsTCgXP29x90zV22c8gaP/Y
	evzE68G6KTC6mfKam7scMU7iuR8hzqrPVvlDIQtYAu4SfpocKq5CBuNZ8b9Y7DOONGuYB5
	c+a69t0vnhWMpyn/oubwyq/BO5vt8zw=
Date: Sat, 9 Sep 2023 00:31:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from
 bpf_clone_redirect
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20230908210007.1469091-1-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230908210007.1469091-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 2:00 PM, Stanislav Fomichev wrote:
> Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
> packets") exposed the fact that bpf_clone_redirect is capable of
> returning raw NET_XMIT_XXX return codes.
> 
> This is in the conflict with its UAPI doc which says the following:
> "0 on success, or a negative error in case of failure."
> 
> Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
> net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
> as -ENOBUFS instead of 1.
> 
> Note, this is technically breaking existing UAPI where we used to
> return 1 and now will do -ENOBUFS. The alternative is to
> document that bpf_clone_redirect can return 1 for DROP and 2 for CN.
> 
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   net/core/filter.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a094694899c9..9e297931b02f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
>   	ret = dev_queue_xmit(skb);
>   	dev_xmit_recursion_dec();
>   
> +	if (ret > 0)
> +		ret = net_xmit_errno(ret);

I think it is better to have bpf_clone_redirect returning -ENOBUFS instead of 
leaking NET_XMIT_XXX to the uapi. The bpf_clone_redirect in the uapi/bpf.h also 
mentions

  *      Return
  *              0 on success, or a negative error in case of failure.

If -ENOBUFS is returned in __bpf_tx_skb, should the same be done for 
__bpf_rx_skb? and should net_xmit_errno() only be done for bpf_clone_redirect()? 
  __bpf_{tx,rx}_skb is also used by skb_do_redirect() which also calls 
__bpf_redirect_neigh() that returns NET_XMIT_xxx but no caller seems to care the 
NET_XMIT_xxx value now.

Daniel should know more here. I would wait for Daniel to comment.

~~~~

For the selftest, may be another option is to use a 28 bytes data_in for the lwt 
program redirecting to veth? 14 bytes used by bpf_prog_test_run_skb and leave 14 
bytes for veth_xmit. It seems the original intention of the "veth ETH_HLEN+1 
packet ingress" test is expecting it to succeed also.

> +
>   	return ret;
>   }
>   



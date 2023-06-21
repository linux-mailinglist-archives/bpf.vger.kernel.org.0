Return-Path: <bpf+bounces-3074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF8739232
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 00:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48EE2816D3
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 22:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687521D2CE;
	Wed, 21 Jun 2023 22:01:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682D19BD9;
	Wed, 21 Jun 2023 22:01:44 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95364120;
	Wed, 21 Jun 2023 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pRRBqrE3FZEwlFe7ojZoqTLqtWARHj/yvV5QqcS0aMA=; b=jiM3pJ1r7KJlEGJBoZfF5wHyQf
	VMTgI8zeeuhwKhOM+KfY4nfrBHq9q7OYeica6/Mmd8WkNHSsHDpAwzQLqi33ezoYMZsXoOygmWSOC
	IoH46+Z9T6FsBl2JnmCybSBhQZuF+9n7Zbfxen9bznppUkefCGcoeTt+70qSFEUQmjXzMT8AbnUk5
	twy+1smQb5Hy953cd3E38CmWsfH5GDS0V8iazBHphUxnX7TufegLVntDXEI9OQz5DL0U11LC0CaAH
	SGpIm+qYqNY1igvFeSNIz9QcvDZ1+IxTzTFX47bPHK5PvbcHBu/zkhUQD1QOz9lXOac2oZnKP/2zF
	3x/luaiw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qC5lu-0004EB-6b; Wed, 21 Jun 2023 23:53:50 +0200
Received: from [178.197.248.38] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qC5lt-000XaG-CL; Wed, 21 Jun 2023 23:53:49 +0200
Subject: Re: [PATCH bpf,v6 3/4] bpf: fix bpf socket lookup from tc/xdp to
 respect socket VRF bindings
To: Gilad Sever <gilad9366@gmail.com>, dsahern@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, hawk@kernel.org, joe@wand.net.nz
Cc: eyal.birger@gmail.com, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230621104211.301902-1-gilad9366@gmail.com>
 <20230621104211.301902-4-gilad9366@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <85d41eee-d912-3203-9291-a52326e7c162@iogearbox.net>
Date: Wed, 21 Jun 2023 23:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230621104211.301902-4-gilad9366@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26946/Wed Jun 21 09:30:19 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/21/23 12:42 PM, Gilad Sever wrote:
> When calling bpf_sk_lookup_tcp(), bpf_sk_lookup_udp() or
> bpf_skc_lookup_tcp() from tc/xdp ingress, VRF socket bindings aren't
> respoected, i.e. unbound sockets are returned, and bound sockets aren't
> found.
> 
> VRF binding is determined by the sdif argument to sk_lookup(), however
> when called from tc the IP SKB control block isn't initialized and thus
> inet{,6}_sdif() always returns 0.
> 
> Fix by calculating sdif for the tc/xdp flows by observing the device's
> l3 enslaved state.
> 
> The cg/sk_skb hooking points which are expected to support
> inet{,6}_sdif() pass sdif=-1 which makes __bpf_skc_lookup() use the
> existing logic.
> 
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
> Signed-off-by: Gilad Sever <gilad9366@gmail.com>
[...]
>   static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
> @@ -6776,12 +6788,17 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
>   BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
>   	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
>   {
> -	struct net *caller_net = dev_net(skb->dev);
> -	int ifindex = skb->dev->ifindex;
> +	struct net_device *dev = skb->dev;
> +	struct net *caller_net;
> +	int ifindex, sdif;
> +
> +	caller_net = dev_net(dev);
> +	ifindex = dev->ifindex;
> +	sdif = dev_sdif(dev);
>   
>   	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
>   					      ifindex, IPPROTO_UDP, netns_id,
> -					      flags);
> +					      flags, sdif);
>   }

Applied, thanks! Btw, the above looks now way uglier than before, so I fixed this
up wrt how it should have looked like for the submission:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=9a5cb79762e0eda17ca15c2a6eaca4622383c21c

Thanks,
Daniel


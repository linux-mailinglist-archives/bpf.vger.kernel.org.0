Return-Path: <bpf+bounces-42829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352F9AB802
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849461F23F1F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14491CCB30;
	Tue, 22 Oct 2024 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oVFfqgii"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B81A4F0A;
	Tue, 22 Oct 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630366; cv=none; b=bgg40OoRPaRvR2r74Qha7iUoe+OEuTqVu+rLbGgCiHHZD8qOS7l3/SLHQkDxzSK/mgQmR4xApcsH8JW1xXNPGV9t5TDrclDC1bMRXtQrWpFXES+XBhG77uBeblwA7E2VolNLL2VvfkEDILY21R8v7UWKaOefLUXqqfsVNGmFS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630366; c=relaxed/simple;
	bh=HzVNjNmjAs2K1dvh9cypS2eq3OXyIm5PVGt8qZ/FDXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQFPbsa+Xeomkzvv3VRay/S80sdQ01EjicRmCJqYVnsP3CdAfjo6XatkiXfQftxwUT8pc/DmvrGnwrRuQx1nW0b1wqtHIQyjMo4XiNvzvruR9ijnvIF8HFtqojLhXFYUyQyUAJnxOdLa2LdWa8ViHWLIBuzuIqyp/YpRTB6xr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oVFfqgii; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nRcLMu9gxh3VcvnT8UJJ1V0H3Dl8r9hgOGJUAf8a7d8=; b=oVFfqgii1hiyQjNp+r64kR+U6q
	abv6DWfsdwCZuNXxf4eH4fF791uPZ95Yc4u/bA/cLYpJ7WhexBZN4k32pbwstTVW3Y8vZTZAcOPdl
	KeDFpIF3OGApGDdTjbGvtmtTr+lExsHSxGbw+/3syznioM9fzOWK2tzNm3lKE3GtiOd36YCVZ+D+5
	H7j892rJ0zVQUcTNimDVkGpsk2qaLCF6YjbPLnIla7j7zlWf77SNB+WZginmkMEGWFBMwvY2/+DI5
	bjhD3JEBg26bxi5MkoKjceisFHodvOMTF36PuJeMBsuh7nN3647c6DdlbodgZgCmQKA7yV74zqBMf
	gjpX3wSw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t3Lrk-0000Kz-Nu; Tue, 22 Oct 2024 22:52:32 +0200
Received: from [178.197.249.42] (helo=[192.168.1.114])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1t3Lrk-0003d7-0x;
	Tue, 22 Oct 2024 22:52:32 +0200
Message-ID: <de2e0d8e-e7eb-4cbd-9397-29ddc79f1961@iogearbox.net>
Date: Tue, 22 Oct 2024 22:52:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf] bpf: check negative offsets in __bpf_skb_min_len()
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com,
 Cong Wang <cong.wang@bytedance.com>
References: <20241008053350.123205-1-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20241008053350.123205-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27435/Tue Oct 22 10:45:05 2024)

On 10/8/24 7:33 AM, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> skb_transport_offset() and skb_transport_offset() can be negative when

nit: I presume the 2nd one is skb_network_offset?

> they are called after we pull the transport header, for example, when
> we use eBPF sockmap (aka at the point of ->sk_data_ready()).
> 
> __bpf_skb_min_len() uses an unsigned int to get these offsets, this
> leads to a very large number which causes bpf_skb_change_tail() failed
> unexpectedly.
> 
> Fix this by using a signed int to get these offsets and test them
> against zero.
> 
> Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Is there any chance you could also extend the sockmap BPF selftest with
this case you're hitting so that BPF CI can run this regularly?

> ---
>   net/core/filter.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4e3f42cc6611..10ef27639a5d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3737,13 +3737,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
>   
>   static u32 __bpf_skb_min_len(const struct sk_buff *skb)
>   {
> -	u32 min_len = skb_network_offset(skb);
> +	int offset = skb_network_offset(skb);
> +	u32 min_len = 0;
>   
> -	if (skb_transport_header_was_set(skb))
> -		min_len = skb_transport_offset(skb);
> -	if (skb->ip_summed == CHECKSUM_PARTIAL)
> -		min_len = skb_checksum_start_offset(skb) +
> -			  skb->csum_offset + sizeof(__sum16);
> +	if (offset > 0)
> +		min_len = offset;
> +	if (skb_transport_header_was_set(skb)) {
> +		offset = skb_transport_offset(skb);
> +		if (offset > 0)
> +			min_len = offset;
> +	}
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		offset = skb_checksum_start_offset(skb) +
> +			 skb->csum_offset + sizeof(__sum16);
> +		if (offset > 0)
> +			min_len = offset;
> +	}
>   	return min_len;

I'll let John chime in, but does this mean in case of sockmap min_len always ends
up at 0? I just wonder whether we should pass a custom __bpf_skb_min_len to
__bpf_skb_change_tail for bpf_skb_change_tail vs sk_skb_change_tail assuming the
compiler is able to inlining all this (instead of indirect call).


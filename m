Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740BA1F1A77
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgFHN4t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 09:56:49 -0400
Received: from www62.your-server.de ([213.133.104.62]:34880 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFHN4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 09:56:48 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jiIGd-0005jO-D6; Mon, 08 Jun 2020 15:56:47 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jiIGd-000WFp-5i; Mon, 08 Jun 2020 15:56:47 +0200
Subject: Re: [PATCH bpf 1/2] net/filter: Permit reading NET in
 load_bytes_relative when MAC not set
To:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1591315176.git.zhuyifei@google.com>
 <4f13798ae41986f8fe8a6f8698c7cbeaefba93b0.1591315176.git.zhuyifei@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8b8290bf-2691-4c1e-07ae-e3262ef25632@iogearbox.net>
Date:   Mon, 8 Jun 2020 15:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4f13798ae41986f8fe8a6f8698c7cbeaefba93b0.1591315176.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25837/Mon Jun  8 14:50:11 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/5/20 2:07 AM, YiFei Zhu wrote:
> Added a check in the switch case on start_header that checks for
> the existence of the header, and in the case that MAC is not set
> and the caller requests for MAC, -EFAULT. If the caller requests
> for NET then MAC's existence is completely ignored.
> 
> There is no function to check NET header's existence and as far
> as cgroup_skb/egress is concerned it should always be set.
> 
> Removed for ptr >= the start of header, considering offset is
> bounded unsigned and should always be true. ptr + len <= end is
> overflow-unsafe and replaced with len <= end - ptr, and
> len <= end - mac is redundant to this condition.
> 
> Fixes: 3eee1f75f2b9 ("bpf: fix bpf_skb_load_bytes_relative pkt length check")
> Reviewed-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   net/core/filter.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d01a244b5087..d3e8445b5494 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1755,25 +1755,27 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
>   	   u32, offset, void *, to, u32, len, u32, start_header)
>   {
>   	u8 *end = skb_tail_pointer(skb);
> -	u8 *net = skb_network_header(skb);
> -	u8 *mac = skb_mac_header(skb);
> -	u8 *ptr;
> +	u8 *start, *ptr;
>   
> -	if (unlikely(offset > 0xffff || len > (end - mac)))
> +	if (unlikely(offset > 0xffff))
>   		goto err_clear;
>   
>   	switch (start_header) {
>   	case BPF_HDR_START_MAC:
> -		ptr = mac + offset;
> +		if (unlikely(!skb_mac_header_was_set(skb)))
> +			goto err_clear;
> +		start = skb_mac_header(skb);
>   		break;
>   	case BPF_HDR_START_NET:
> -		ptr = net + offset;
> +		start = skb_network_header(skb);
>   		break;
>   	default:
>   		goto err_clear;
>   	}
>   
> -	if (likely(ptr >= mac && ptr + len <= end)) {
> +	ptr = start + offset;
> +
> +	if (likely(len <= end - ptr)) {

Couldn't you run into the case above where the passed offset is large enough
that start + offset goes beyond end pointer [and then above comparison is
performed as unsigned ..]? (At least on x86-64, the 'ptr + len <= end' should
never have an issue [0].) Either way, maybe lets add a test in 2/2 to assert
correct behavior there.

   [0] https://www.kernel.org/doc/Documentation/x86/x86_64/mm.txt

>   		memcpy(to, ptr, len);
>   		return 0;
>   	}
> 


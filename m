Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861F572F20
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiGMHX0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 03:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGMHXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 03:23:25 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED1C48C9
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 00:23:24 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oBWiQ-0002YU-4j; Wed, 13 Jul 2022 09:23:22 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oBWiP-000TSo-Vy; Wed, 13 Jul 2022 09:23:22 +0200
Subject: Re: [PATCH bpf-next v1] bpf: Fix bpf/sk_skb_pull_data for flags == 0
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org
References: <20220713012621.2485047-1-joannelkoong@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc84acdc-9221-2d99-f65a-fd9d0de87e32@iogearbox.net>
Date:   Wed, 13 Jul 2022 09:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220713012621.2485047-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26599/Tue Jul 12 10:00:48 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/13/22 3:26 AM, Joanne Koong wrote:
> In the case where flags is 0, bpf_skb_pull_data and sk_skb_pull_data
> should pull the entire skb payload including the bytes in the non-linear
> page buffers.
> 
> This is documented in the uapi:
> "If a zero value is passed for *len*, then the whole length of the *skb*
> is pulled"
> 
> Fixes: 36bbef52c7eb6 ("bpf: direct packet write and access for helpers
> for clsact progs")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

This is not correct. We should fix the helper doc fa15601ab31e ("bpf: add
documentation for eBPF helpers (33-41)"). It will make the head private
for writing (e.g. for direct packet access), but not linearize the entire
skb, so skb_headlen is correct here.

> ---
>   net/core/filter.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4ef77ec5255e..97eb15891bfc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1838,7 +1838,7 @@ BPF_CALL_2(bpf_skb_pull_data, struct sk_buff *, skb, u32, len)
>   	 * access case. By this we overcome limitations of only current
>   	 * headroom being accessible.
>   	 */
> -	return bpf_try_make_writable(skb, len ? : skb_headlen(skb));
> +	return bpf_try_make_writable(skb, len ? : skb->len);
>   }
>   
>   static const struct bpf_func_proto bpf_skb_pull_data_proto = {
> @@ -1878,7 +1878,7 @@ BPF_CALL_2(sk_skb_pull_data, struct sk_buff *, skb, u32, len)
>   	 * access case. By this we overcome limitations of only current
>   	 * headroom being accessible.
>   	 */
> -	return sk_skb_try_make_writable(skb, len ? : skb_headlen(skb));
> +	return sk_skb_try_make_writable(skb, len ? : skb->len);
>   }
>   
>   static const struct bpf_func_proto sk_skb_pull_data_proto = {
> 


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D435762FF
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiGONn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiGONnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 09:43:22 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10C8048A
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 06:43:18 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oCLbA-0004CS-D8; Fri, 15 Jul 2022 15:43:16 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oCLbA-000DXk-6w; Fri, 15 Jul 2022 15:43:16 +0200
Subject: Re: [PATCH bpf-next v1] bpf: fix bpf_skb_pull_data documentation
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     quentin@isovalent.com, andrii@kernel.org, ast@kernel.org
References: <20220714224721.2615592-1-joannelkoong@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <43bbdc5a-000d-0aed-f325-2b942aa1fc02@iogearbox.net>
Date:   Fri, 15 Jul 2022 15:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220714224721.2615592-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26602/Fri Jul 15 09:57:14 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/15/22 12:47 AM, Joanne Koong wrote:
> Fix documentation for bpf_skb_pull_data() helper for
> when flags == 0.
> 
> Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   include/uapi/linux/bpf.h       | 3 ++-
>   tools/include/uapi/linux/bpf.h | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 379e68fb866f..a80c1f6bbe25 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2361,7 +2361,8 @@ union bpf_attr {
>    * 		Pull in non-linear data in case the *skb* is non-linear and not
>    * 		all of *len* are part of the linear section. Make *len* bytes
>    * 		from *skb* readable and writable. If a zero value is passed for
> - * 		*len*, then the whole length of the *skb* is pulled.
> + *		*len*, then all bytes in the head of the skb will be made readable

Quentin, should the formatting be '*skb*' instead of 'skb'?

Maybe it's more clear if we speak of 'all bytes in the linear part' instead of 'all
bytes in the head' of the skb to make it clearer? Either is ok with me though.

Thanks,
Daniel

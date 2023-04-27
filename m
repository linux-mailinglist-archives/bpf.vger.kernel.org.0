Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDC6F0D0D
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjD0UXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjD0UXV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:23:21 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4F1993
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9w+/kyX3U9h6trth+KkmQa52z7NgmXHs9LUDJnaFXSg=; b=nvkEZ4N5rDRzHyaCubXcZvmtLz
        jBHjmHUCrGDPa7XXaz2E7Eeil959Mt3szSc7gJD+vlCdLaGrtNq2gs3Ut09Yj4HQ02HusFW5XK2rT
        dDX51vVYukBfZR50koogwpHQaVKONpNCrw97gkA+B6VuXUxOHxkvMzr7fBqY+jlXVYt4sWeiPEDCF
        wjed+coTdD++yokL3ZhpekC7EWlPkXbfrYHHbnp/Cw00+w8Pq/cZEpSaM+U6uxwXlb9dDHMZnDAgr
        YRm2Ez/kFoXMhXLymzM/+HgShE3Ri1tOImsD0aw0RxlfMNr1No5ykAP2u9DUMS9I8Hh5tXsMqGzHU
        FypuAPlA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps88t-000NWx-DF; Thu, 27 Apr 2023 22:23:03 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps88t-000S9c-4P; Thu, 27 Apr 2023 22:23:03 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 test_global_funcs/global_func1 failure with latest clang
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230425174744.1758515-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e6b0a452-3f5e-2eea-51cb-484b342361c0@iogearbox.net>
Date:   Thu, 27 Apr 2023 22:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230425174744.1758515-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26889/Thu Apr 27 09:25:48 2023)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/25/23 7:47 PM, Yonghong Song wrote:
> The selftest test_global_funcs/global_func1 failed with the latest clang17.
> The reason is due to upstream ArgumentPromotionPass ([1]),
> which may manipulate static function parameters and cause inlining
> although the funciton is marked as noinline.
> 
> The original code:
>    static __attribute__ ((noinline))
>    int f0(int var, struct __sk_buff *skb)
>    {
>          return skb->len;
>    }
> 
>    __attribute__ ((noinline))
>    int f1(struct __sk_buff *skb)
>    {
> 	...
>          return f0(0, skb) + skb->len;
>    }
> 
>    ...
> 
>    SEC("tc")
>    __failure __msg("combined stack size of 4 calls is 544")
>    int global_func1(struct __sk_buff *skb)
>    {
>          return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
>    }
> 
> After ArgumentPromotionPass, the code is translated to
>    static __attribute__ ((noinline))
>    int f0(int var, int skb_len)
>    {
>          return skb_len;
>    }
> 
>    __attribute__ ((noinline))
>    int f1(struct __sk_buff *skb)
>    {
> 	...
>          return f0(0, skb->len) + skb->len;
>    }
> 
>    ...
> 
>    SEC("tc")
>    __failure __msg("combined stack size of 4 calls is 544")
>    int global_func1(struct __sk_buff *skb)
>    {
>          return f0(1, skb->len) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
>    }
> 
> And later llvm InstCombine phase recognized that f0()
> simplify returns the value of the second argument and removed f0()
> completely and the final code looks like:
>    __attribute__ ((noinline))
>    int f1(struct __sk_buff *skb)
>    {
> 	...
>          return skb->len + skb->len;
>    }
> 
>    ...
> 
>    SEC("tc")
>    __failure __msg("combined stack size of 4 calls is 544")
>    int global_func1(struct __sk_buff *skb)
>    {
>          return skb->len + f1(skb) + f2(2, skb) + f3(3, skb, 4);
>    }
> 
> If f0() is not inlined, the verification will fail with stack size
> 544 for a particular callchain. With f0() inlined, the maximum
> stack size is 512 which is in the limit.
> 
> Let us add a `asm volatile ("")` in f0() to prevent ArgumentPromotionPass
> from hoisting the code to its caller, and this fixed the test failure.
> 
>    [1] https://reviews.llvm.org/D148269
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   tools/testing/selftests/bpf/progs/test_global_func1.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
> index b85fc8c423ba..17a9f59bf5f3 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func1.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
> @@ -10,6 +10,8 @@
>   static __attribute__ ((noinline))
>   int f0(int var, struct __sk_buff *skb)
>   {
> +	asm volatile ("");
> +
>   	return skb->len;

Is it planned to get this reverted before the final llvm/clang 17 is
officially released (you mentioned the TTI hook in [1])?

Thanks,
Daniel

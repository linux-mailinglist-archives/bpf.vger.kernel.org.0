Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED15526C2
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 23:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiFTV7L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTV7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 17:59:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65CB10FC4
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Rtn6GPVxiSNL7Ytm2ON65PYWe5egleDXKFU32GkmmC8=; b=hPjv/dL6LkDumbCWDISpI/X/ko
        ClQerm1nqCe3Nf4gsn1hx2LAReI/ZLTxwcrqcC9Yps6BfcNddGGpW9DSYuq3VXBCs6vYqNxANF/OA
        I33DDYVLmy7b0iGd52edfkS9pRDyggfibFI/lym6mupcUTt4kVj1TJZonZWy7hZ6e9MOXWjfE/wwd
        jYikG93YDyxc+qpRIQy1rtqX4gg3K3mgGwi3dZpc+aRWe3RpiWyHrYWvXTYoAtRRYmVfQivsL1cPM
        VH4tS3MZ6mJRlp9zCT9XAkjPcjpyXpfCYyuSCuooPN8DexMpKi1PF0wbySU0jk15pF6j2kzRd2hjn
        iBMCqNGw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3PPN-009wlj-3o; Mon, 20 Jun 2022 21:58:10 +0000
Message-ID: <acc867e4-6b2f-df58-ee4b-71743640af69@infradead.org>
Date:   Mon, 20 Jun 2022 14:58:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf-next] uprobe: gate bpf call behind BPF_EVENTS
Content-Language: en-US
To:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>
References: <cb8bfbbcde87ed5d811227a393ef4925f2aadb7b.camel@fb.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cb8bfbbcde87ed5d811227a393ef4925f2aadb7b.camel@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/20/22 14:47, Delyan Kratunov wrote:
> The call into bpf from uprobes needs to be gated now that it doesn't use
> the trace_events.h helpers.
> 
> Randy found this as a randconfig build failure on linux-next [1].
> 
>   [1]: https://lore.kernel.org/linux-next/2de99180-7d55-2fdf-134d-33198c27cc58@infradead.org/
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/trace/trace_uprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 0282c119b1b2..326235fd2346 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1344,6 +1344,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	int size, esize;
>  	int rctx;
> 
> +#ifdef CONFIG_BPF_EVENTS
>  	if (bpf_prog_array_valid(call)) {
>  		u32 ret;
> 
> @@ -1351,6 +1352,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  		if (!ret)
>  			return;
>  	}
> +#endif /* CONFIG_BPF_EVENTS */
> 
>  	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
> 
> --
> 2.36.1

-- 
~Randy

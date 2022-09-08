Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246A5B1D34
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIHMgk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiIHMgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 08:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED903F311
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 05:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD7C661CD4
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 12:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BC2C433D6;
        Thu,  8 Sep 2022 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662640557;
        bh=I+UgnYnVYHbLwsApzs1D0lLKBngxhcnXkc0R0l+zB5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCuKpLEYn+4cpHKpAC/86zDDUAcx1vfsldloAF86O4aXl4TGI/1VjJ4d5UOumtalH
         Jq3DO25QrgV/ZcfRGBfafIrtnDV0nOQsoKOmXxJjgx3M913KoU6eP5az7lsgxQhcW9
         LIOyoQfvVTwxA6Kbcf5Zz4X1PD6rTR8NoK5aoE2bb8tJY0pgetzg0Q7HEfVnveCmNn
         HO5pKQ0Ng2IKqObJ244o2WEHGaxziArxf9rYdExhjCE9M+CoILji0jaUfMQtdyDA/e
         QyjgTu5aGvQlZn4+1Zr5xuDHVPopKG7guVVe3G7WnaDEJlkdfxY1g9QjtPhgyBSmn/
         y3GZHEfhNPYHA==
Date:   Thu, 8 Sep 2022 21:35:51 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/6] ftrace: Keep the resolved addr in
 kallsyms_callback
Message-Id: <20220908213551.5d51406ff9846bcd079fcc3f@kernel.org>
In-Reply-To: <20220811091526.172610-3-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
        <20220811091526.172610-3-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Aug 2022 11:15:22 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Keeping the resolved 'addr' in kallsyms_callback, instead of taking
> ftrace_location value, because we depend on symbol address in the
> cookie related code.
> 
> With CONFIG_X86_KERNEL_IBT option the ftrace_location value differs
> from symbol address, which screwes the symbol address cookies matching.
> 
> There are 2 users of this function:
> - bpf_kprobe_multi_link_attach
>     for which this fix is for
> 
> - get_ftrace_locations
>     which is used by register_fprobe_syms
> 
>     this function needs to get symbols resolved to addresses,
>     but does not need 'ftrace location addresses' at this point
>     there's another ftrace location translation in the path done
>     by ftrace_set_filter_ips call:
> 
>      register_fprobe_syms
>        addrs = get_ftrace_locations
> 
>        register_fprobe_ips(addrs)
>          ...
>          ftrace_set_filter_ips
>            ...
>              __ftrace_match_addr
>                ip = ftrace_location(ip);
>                ...
> 

Yes, this looks OK for fprobe. I confirmed above.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

One concern was that the caller might expect that the address
must be ftrace_location(), but as far as I can read the function
document, there is no such description.

 * ftrace_lookup_symbols - Lookup addresses for array of symbols
...
 * This function looks up addresses for array of symbols provided in
 * @syms array (must be alphabetically sorted) and stores them in
 * @addrs array, which needs to be big enough to store at least @cnt
 * addresses.

So this change is OK.

Thank you,

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/ftrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index bc921a3f7ea8..8a8c90d1a387 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8268,8 +8268,7 @@ static int kallsyms_callback(void *data, const char *name,
>  	if (args->addrs[idx])
>  		return 0;
>  
> -	addr = ftrace_location(addr);
> -	if (!addr)
> +	if (!ftrace_location(addr))
>  		return 0;
>  
>  	args->addrs[idx] = addr;
> -- 
> 2.37.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

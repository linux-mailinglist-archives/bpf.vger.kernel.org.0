Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FFD5A2C24
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbiHZQSC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344452AbiHZQSC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:18:02 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8ADA3DF;
        Fri, 26 Aug 2022 09:18:00 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oRc1m-0003hS-ML; Fri, 26 Aug 2022 18:17:50 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oRc1m-000GQ7-EB; Fri, 26 Aug 2022 18:17:50 +0200
Subject: Re: [PATCH bpf-next] bpf, mips: No need to use min() to get
 MAX_TAIL_CALL_CNT
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     bpf@vger.kernel.org, linux-mips@vger.kernel.org
References: <1661479927-6953-1-git-send-email-yangtiezhu@loongson.cn>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e785ac4b-c1d6-e9e9-df2f-869e474e18ba@iogearbox.net>
Date:   Fri, 26 Aug 2022 18:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1661479927-6953-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26639/Fri Aug 26 09:54:45 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 4:12 AM, Tiezhu Yang wrote:
> MAX_TAIL_CALL_CNT is 33, so min(MAX_TAIL_CALL_CNT, 0xffff) is always
> MAX_TAIL_CALL_CNT, it is better to use MAX_TAIL_CALL_CNT directly.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/mips/net/bpf_jit_comp32.c | 2 +-
>   arch/mips/net/bpf_jit_comp64.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
> index 83c975d..8fee671 100644
> --- a/arch/mips/net/bpf_jit_comp32.c
> +++ b/arch/mips/net/bpf_jit_comp32.c
> @@ -1381,7 +1381,7 @@ void build_prologue(struct jit_context *ctx)
>   	 * 16-byte area in the parent's stack frame. On a tail call, the
>   	 * calling function jumps into the prologue after these instructions.
>   	 */
> -	emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO, min(MAX_TAIL_CALL_CNT, 0xffff));

I presume this is the max that can be encoded, right? Maybe just convert this
to a BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff) with a comment on why the assertion
is there?

> +	emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
>   	emit(ctx, sw, MIPS_R_T9, 0, MIPS_R_SP);
>   
>   	/*
> diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
> index 6475828..ac175af 100644
> --- a/arch/mips/net/bpf_jit_comp64.c
> +++ b/arch/mips/net/bpf_jit_comp64.c
> @@ -552,7 +552,7 @@ void build_prologue(struct jit_context *ctx)
>   	 * On a tail call, the calling function jumps into the prologue
>   	 * after this instruction.
>   	 */
> -	emit(ctx, ori, tc, MIPS_R_ZERO, min(MAX_TAIL_CALL_CNT, 0xffff));
> +	emit(ctx, ori, tc, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
>   
>   	/* === Entry-point for tail calls === */
>   
> 


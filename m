Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44C5B36D1
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiIIL5o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIIL5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:57:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8857136CC1
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fDKQhERJ8ttv4RXCt3DeZXMwQXc/k6EUgB10DFVYJTc=; b=ZSS/oOWUDJFsmEg7LxOxLaSo+6
        0rkF4h2QZ3cIFZmKz0fdvwMiLDSNrqSfBJpbuBNSEEvm/sNmpmolzGqV2XeZgQ+QoFzaAxwxpiB+t
        12Fxk78sGaXtMDLZGH88ObeXGQR+4Koq3whtGoR6kRR8/sRhT0whYnmTVuhWYTkZSz7ESHl9/jPtM
        xawpj4q8ckd8SfIy4r7o8jS9JYTovbbSbcOsUH3UXTKF87pLMRr70QnAKsvJlwd4NWMMyzX4X+AEk
        qLS1sz2rxIhSSp+Dc1Obh6ibBRzfmZE+Pk6pMkWwBhz5DFNzxRIE6rcf1YdG20OfEvoG8D64dxxyE
        ir5fQRMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWcdX-00DEZ7-92; Fri, 09 Sep 2022 11:57:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC599300023;
        Fri,  9 Sep 2022 13:57:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C05FA29A24303; Fri,  9 Sep 2022 13:57:28 +0200 (CEST)
Date:   Fri, 9 Sep 2022 13:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCHv3 bpf-next 5/6] bpf: Return value in kprobe get_func_ip
 only for entry address
Message-ID: <YxsqKFyk69B6pmUf@hirez.programming.kicks-ass.net>
References: <20220909101245.347173-1-jolsa@kernel.org>
 <20220909101245.347173-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909101245.347173-6-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 12:12:44PM +0200, Jiri Olsa wrote:
> Changing return value of kprobe's version of bpf_get_func_ip
> to return zero if the attach address is not on the function's
> entry point.
> 
> For kprobes attached in the middle of the function we can't easily
> get to the function address especially now with the CONFIG_X86_KERNEL_IBT
> support.
> 
> If user cares about current IP for kprobes attached within the
> function body, they can get it with PT_REGS_IP(ctx).
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c                             | 11 ++++++++++-
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c |  4 ++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index bcada91b0b3b..027abc38faab 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1029,8 +1029,17 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
>  BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>  {
>  	struct kprobe *kp = kprobe_running();
> +	uintptr_t addr;
>  
> -	return kp ? (uintptr_t)kp->addr : 0;
> +	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> +		return 0;
> +
> +	addr = (uintptr_t)kp->addr;
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	if (is_endbr(*((u32 *) addr - 1)))
> +		addr -= ENDBR_INSN_SIZE;
> +#endif

This has the same problem; -1 might not be a valid address. But since
this it not he multi stuff, I think you can more easily store state if
this correction is needed or not.

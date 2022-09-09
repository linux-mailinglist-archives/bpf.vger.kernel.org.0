Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9D5B36B8
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiIILtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiIILth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:49:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7FD13E13
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T24rfweRwMUEYoRSKe7a3EP0QE2CQRmkvfQQd2k+xMo=; b=wIH4w3CGmWBD9FyxNfoPSCmls0
        zmIwaPiOGaA+goVjUp4m4Fhx0wjzEXKewIpRTZ0pQhSeabhqGh+EQru90eu3hIExyMiCGo61BiDWD
        lRwrvBv4liRHgTZLyZiBFawvlFpYvb4Vo2a+dbcNhnSPnQVw3QlsLHjjt5NZic8fb945+Vs5VU6Uk
        i06vslhUTUdOvvlZAqEdAQea7TevMQPC8Kuk7tAcPERG0VUJ2FXdbd1T0dM2TZceKDBE+tP1Lc5TD
        Jhj09lp9F13st+TP9J7KmiZTRK9AtiSoiX7/r1SSJRxb087ydZxmavvqq3atAz6Dkabi5w4IdEe7z
        VyY9YCVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWcVc-00DEIj-4s; Fri, 09 Sep 2022 11:49:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3FB2300074;
        Fri,  9 Sep 2022 13:49:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AD8B29A24303; Fri,  9 Sep 2022 13:49:16 +0200 (CEST)
Date:   Fri, 9 Sep 2022 13:49:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv3 bpf-next 4/6] bpf: Adjust kprobe_multi entry_ip for
 CONFIG_X86_KERNEL_IBT
Message-ID: <YxsoPLVnSjcTqQDf@hirez.programming.kicks-ass.net>
References: <20220909101245.347173-1-jolsa@kernel.org>
 <20220909101245.347173-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909101245.347173-5-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 12:12:43PM +0200, Jiri Olsa wrote:

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..bcada91b0b3b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2419,6 +2419,10 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long entry_ip,
>  {
>  	struct bpf_kprobe_multi_link *link;
>  
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	if (is_endbr(*((u32 *) entry_ip - 1)))
> +		entry_ip -= ENDBR_INSN_SIZE;
> +#endif
>  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
>  	kprobe_multi_link_prog_run(link, entry_ip, regs);
>  }

Strictly speaking this can explode if this function is one without ENDBR
and it's on a page-edge and -1 is a guard page or something silly like
that (could conceivably happen for a module or so).

I'm also thinking this function might be a bit clearer if the argument
were called fentry_ip -- that way it would be clearer this is an ftrace
__fentry__ ip.

The canonical way to get at +0 would be something like:

	kallsyms_lookup_size_offset(fentry_ip, &size, &offset);
	entry_ip = fentry_ip - offset;

But I appreciate that might be too expensive here; is this a hot path?

Could you store this information in struct bpf_kprobe_multi_link?

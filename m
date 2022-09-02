Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC575AAD41
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIBLOn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIBLOm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 07:14:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D58D3D5
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJtvlrry1aJRpz/ZVNJNsFlXZKeHSsUFfZB+aJFX5U4=; b=gynKsGBJWdg1St1P4U5Td6KJhm
        n1Ebrq98EsVgDtWUHiGSJ4s5/sY8mAmcny59DrNJM/r0h8FnoCEAUXzrUk1DRVfeod541FyyUqb2g
        Av9gz3c2G6Go5ZMtrnThtwYQuwA9+1N3nIO9lr++hlvhU1u8P0cs2nvyCH5qdqWfYMNiCFrA2W/lR
        u37SExDLakIOl0yhaBIEesHLyJHZS7gq1CN3sQYFqyx20J/2ZRpu9V6BntFwFpxD75kQzDr1Gufxj
        kUNFIS8NoQqi9idPdKqd+RMCPMpPAsr06lLllLDz2iKZdbojF8T1ubBEwKlmAG2/BEMIABhJyVsQp
        W5zvlexg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU4cw-006yDb-DC; Fri, 02 Sep 2022 11:14:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 980EE300223;
        Fri,  2 Sep 2022 13:14:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A82D20853050; Fri,  2 Sep 2022 13:14:19 +0200 (CEST)
Date:   Fri, 2 Sep 2022 13:14:19 +0200
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
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <YxHli+6C5rylF3EH@hirez.programming.kicks-ass.net>
References: <20220901134150.418203-1-jolsa@kernel.org>
 <20220901134150.418203-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901134150.418203-3-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 03:41:50PM +0200, Jiri Olsa wrote:

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9c1674973e03..4ab4b0a1beb8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -924,7 +924,15 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
>  	},							\
>  }
>  
> +#ifdef CONFIG_X86_64
> +#define BPF_DISPATCHER_ATTRIBUTES __attribute__((__no_instrument_function__)) \
> +				   __attribute__((patchable_function_entry(5)))
> +#else
> +#define BPF_DISPATCHER_ATTRIBUTES
> +#endif
> +
>  #define DEFINE_BPF_DISPATCHER(name)					\
> +	BPF_DISPATCHER_ATTRIBUTES					\
>  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
>  		const void *ctx,					\
>  		const struct bpf_insn *insnsi,				\

Are you sure you want the notrace x86_64 only?

That is, perhaps something like this...

+#ifdef CONFIG_X86_64
+#define BPF_DISPATCHER_ATTRIBUTES	   __attribute__((patchable_function_entry(5)))
+#else
+#define BPF_DISPATCHER_ATTRIBUTES
+#endif
+
 #define DEFINE_BPF_DISPATCHER(name)					\
+	notrace BPF_DISPATCHER_ATTRIBUTES				\
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\




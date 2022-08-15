Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C74592BC2
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiHOKOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242488AbiHOKOU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 06:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E0A1838F
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=94mknGMm7mI4VqlZFtaFa4uxvsWZSNfDJ0hpPYKdDDo=; b=E/N6uqxoGf82WRiXlgfjIZeGRZ
        nOSMNdhD1Xsd7rptt46qU/xAW2IFzONteVQ6JOfhBWI59kaJT26DnRJ1Z0ryLVKvhCoVkm7O5dWcW
        wdmue6mxLefOrFts7UBos6fOkOMkko+B8GT8xDwnE0FRshjffF42f/sTaCL1KA4tw+i3DFvtvDSx4
        JBwEBXRj1JIlbiTxIAhJ/P+Iqh+t63DfrRewR81k2ASEQ7JMgR11YulSU9Tpdi/30lQX7e/QkN2eN
        /jenCvhamtn3zoU6NRPwmUmuYOfpQ2lkHZl8sQu7pLtdAwyldGBAXwGFM61IqFsAlNsXEWmqrsFH6
        MweDznsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNX6K-005clC-5d; Mon, 15 Aug 2022 10:13:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C19B980153; Mon, 15 Aug 2022 12:13:39 +0200 (CEST)
Date:   Mon, 15 Aug 2022 12:13:39 +0200
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/6] ftrace: Keep the resolved addr in
 kallsyms_callback
Message-ID: <YvocUzp5PobPKv5R@worktop.programming.kicks-ass.net>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811091526.172610-3-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 11:15:22AM +0200, Jiri Olsa wrote:
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

Except you fail to explain what the problem is and how this helps
anything.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE0592F39
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbiHOMvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiHOMvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 08:51:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6014D2A
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DU4pm7h/bsh7qBnaJGn1UPaGYV/lLGoaVsQ02CWGKZw=; b=FJeivCVmLAduCqXfMb+3AR/ff5
        XuAhNrtXUrjmj/jgSOee1OdbDSHworW6HnRLwRw1a+VpIXmou8JZQn18iT00esLdJMLcVNHw8j1mY
        Jr0QFDtimH/n9ixH+RY144jBGbL+Edm13yure3lYR6+r3NeT9acnAIEiKz7YQc3QrzXDsG4k5faq7
        wT04MMIyfgqKm0vrYcv9TrbQAWqFci9FTohieD+n9HfHBabTFQ+wzZ3z5BdAJu0LtgdvWlUjumzc7
        fylZ3jTZGAfuTXq5L5rVYQs3T5n4Zw9kLjQvcXF1djevXgCMaoTkzYfnvFvZLJ4UeesTMzVHGKyW6
        ae8SDGsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZZ8-002fqz-00; Mon, 15 Aug 2022 12:51:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01484980153; Mon, 15 Aug 2022 14:51:32 +0200 (CEST)
Date:   Mon, 15 Aug 2022 14:51:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <olsajiri@gmail.com>
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
Subject: Re: [PATCHv2 bpf-next 3/6] bpf: Use given function address for
 trampoline ip arg
Message-ID: <YvpBVDP3FydnAtHA@worktop.programming.kicks-ass.net>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-4-jolsa@kernel.org>
 <Yvodfh6OJhSIq8X9@worktop.programming.kicks-ass.net>
 <YvomoyS/3Op8FAMa@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvomoyS/3Op8FAMa@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 12:57:39PM +0200, Jiri Olsa wrote:
> On Mon, Aug 15, 2022 at 12:18:38PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 11, 2022 at 11:15:23AM +0200, Jiri Olsa wrote:
> > > Using function address given at the generation time as the trampoline
> > > ip argument. This way we get directly the function address that we
> > > need, so we don't need to:
> > >   - read the ip from the stack
> > >   - subtract X86_PATCH_SIZE
> > >   - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
> > >     which is not even implemented yet ;-)
> > 
> > Can you please tell me what all this does and why?
> > 
> 
> arch_prepare_bpf_trampoline prepares bpf trampoline for given function
> specified by 'func_addr' argument

The bpf trampoline is what's used for ftrace direct call, no?

> the changed code is storing/preparing caller's 'ip' address on the
> trampoline's stack so the get_func_ip helper can use it

I've no idea what get_func_ip() helper is...

> currently the trampoline code gets the caller's ip address by reading
> caller's return address from stack and subtracting X86_PATCH_SIZE from
> it
> 
> the change uses 'func_addr' as caller's 'ip' address when trampoline is
> generated .. this way we don't need to retrieve the return address from
> stack and care about endbr instruction if IBT is enabled

Ok, I *think* I sorta understand that.

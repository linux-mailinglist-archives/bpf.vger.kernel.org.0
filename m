Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92382592F28
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiHOMqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiHOMqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 08:46:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB318A190
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3J8ib5HrOtCwlEtjZ3kw5OuNXGug/r+lFB8F4aeMIPQ=; b=RQJWbd1los41EqtSNTt2TsbsVb
        ucpThJL1uaHirqL/vYLicK8xM30wrBBoyp9pcRQQXjxCu6b8KyJVeVSMtqlizi8GY6uK0rekOnXhi
        QqbEk4hTjQpweeGCV2YrVycdKnTJxfbODOsf+qJ8hEzARpHGuuyusYhKbpj23SvPoPsBGpbFv8r7w
        qYw7Odjdd4U+tHQDAx1IY1mkd+51U93AHrD73EGFh/gJqI0rdD8IiBT8AdV6u+EYFRzhs9wlVWvr5
        h8eP/+c6FQhyfNZAR7orKvnc+L1sNK3eOWsnS69hE/y4cHKpTqUlkwYg9I0yIs1BlgBb4Ia+HpEHB
        fZVu9jhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZTf-002fn7-Ea; Mon, 15 Aug 2022 12:45:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13168980153; Mon, 15 Aug 2022 14:45:55 +0200 (CEST)
Date:   Mon, 15 Aug 2022 14:45:54 +0200
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
Subject: Re: [PATCHv2 bpf-next 2/6] ftrace: Keep the resolved addr in
 kallsyms_callback
Message-ID: <YvpAAitklP35uCZo@worktop.programming.kicks-ass.net>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-3-jolsa@kernel.org>
 <YvocUzp5PobPKv5R@worktop.programming.kicks-ass.net>
 <YvogVuh278uRdbq2@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvogVuh278uRdbq2@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 12:30:46PM +0200, Jiri Olsa wrote:
> On Mon, Aug 15, 2022 at 12:13:39PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 11, 2022 at 11:15:22AM +0200, Jiri Olsa wrote:
> > > Keeping the resolved 'addr' in kallsyms_callback, instead of taking
> > > ftrace_location value, because we depend on symbol address in the
> > > cookie related code.
> > > 
> > > With CONFIG_X86_KERNEL_IBT option the ftrace_location value differs
> > > from symbol address, which screwes the symbol address cookies matching.
> > > 
> > > There are 2 users of this function:
> > > - bpf_kprobe_multi_link_attach
> > >     for which this fix is for
> > 
> > Except you fail to explain what the problem is and how this helps
> > anything.
> 
> we search this array of resolved addresses later in cookie code
> (bpf_kprobe_multi_cookie) for address returned by fprobe, which
> is not 'ftrace_location' address

What is fprobe?

> so we want ftrace_lookup_symbols to return 'only' resolved address
> at this point, not 'ftrace_location' address

In general; I'm completely confused what any of this code is doing.
Mostly I don't speak BPF *at*all*. And have very little clue as to what
things are supposed to do, please help me along.

But the thing is, we're likely going to change all this (function call
abi) again in the very near future; it would be very nice if all this
code could grow some what/why comments, because I've gotten lost
multiple times in all this.

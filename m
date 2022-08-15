Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0D592F15
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHOMkv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiHOMkn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 08:40:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BD95AB
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4UN5Pmfmyn+e2DOwus4KmGsUQpb5jjpmfcZtWnN8ZM=; b=dlgvvFs8LN8MbPjxeglae1EHLE
        zaW3uGRzC8nsWDWG6PJjRGN7daeLz1vh0RAK0Qt94nSbFSrPqd1oiIyijfPwITgOudEKJg9+K2Dri
        L6+YK46L1+YR+l8M1H6W9ExmqaPF8qZCELTAS/SauJIaO1JET8GVC0mbpqiKpJeMVKTBn4uYuxwsl
        X/O8inHajsl5DBlhG7jw+QhHgoskuhQn+Ngh/hqn4jbO2Pw6fv7cDLLUl2/VJL7eii7roSSQEKb1K
        TTD6rdrP3FslzIqkEVHY9920EsZGYaHiQI9cilx6oCpoSkxyGj67IUtdbrk//A5t3rMp0Ftnh3ZTW
        2Ysei+OQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZOQ-002fjy-6j; Mon, 15 Aug 2022 12:40:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9080980153; Mon, 15 Aug 2022 14:40:29 +0200 (CEST)
Date:   Mon, 15 Aug 2022 14:40:29 +0200
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
Subject: Re: [PATCHv2 bpf-next 1/6] kprobes: Add new
 KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Message-ID: <Yvo+vQ+egjJBOmP+@worktop.programming.kicks-ass.net>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-2-jolsa@kernel.org>
 <YvoYlCz0Ej7t9yDV@worktop.programming.kicks-ass.net>
 <YvobjEIHV3XPSeez@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvobjEIHV3XPSeez@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 12:10:20PM +0200, Jiri Olsa wrote:
> On Mon, Aug 15, 2022 at 11:57:40AM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 11, 2022 at 11:15:21AM +0200, Jiri Olsa wrote:
> > > Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> > > attach address is on function entry. This is used in following
> > > changes in get_func_ip helper to return correct function address.
> > 
> > IIRC (and I've not digested patch) the intent was to have func+0 mean
> > this. x86-IBT is not the only case where this applies, there are
> > multiple architectures where function entry is not +0.
> 
> we can have kprobe created by user passing just the address
> 
> in this case _kprobe_addr still computes the address's offset
> from the symbol but does not store it back to 'struct kprobe'

Ah, this is an internal thing to record, in the struct kprobe if the
thing is on the function entry or not?

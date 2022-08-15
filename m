Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF165930D2
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiHOOdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiHOOd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 10:33:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9324F2D;
        Mon, 15 Aug 2022 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vjSauRMX6lTklAqGe35XwanARw4Uk+6GG0LElIUJ4nU=; b=kYO5LYDtCo7aS3KwRENHNp1AVR
        hVNK/WgcdT4gGqGdYDnpZHf3z4Ea9VmykBH0/dGM8Q3B5DTUU865iD79AohFJASEC9nS7AYESLmCX
        uR6niPOBt/N6TryyinJX44KHpmLtowwPIjGoe/mX8zlExHVK9329qxWIRFwwWqotYSNlqIHZjDeMD
        SvrQ2jbDO4Vea75cqkCU5vBm05q1LIXzQeAx87gOMkniXORVzm0t0EbktR6tbXrJgrvQFOAdSgbEQ
        /3HS/KecRfKn2KMHuAOjpNbjZD5wq1ygwxibIh3I1GvnVqYIXy0NzKd5nFClsqio7r6FrTYIM2UDB
        DZRTWdow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNb9S-005n8I-15; Mon, 15 Aug 2022 14:33:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37A84980153; Mon, 15 Aug 2022 16:33:09 +0200 (CEST)
Date:   Mon, 15 Aug 2022 16:33:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
References: <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava>
 <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
 <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 07:25:24AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 15, 2022 at 5:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 15, 2022 at 11:44:32AM +0200, Jiri Olsa wrote:
> > > On Mon, Aug 15, 2022 at 10:03:17AM +0200, Peter Zijlstra wrote:
> > > > On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> > > > > On Fri, 12 Aug 2022 23:18:15 +0200
> > > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > > the patch below moves the bpf function into sepatate object and switches
> > > > > > off the -mrecord-mcount for it.. so the function gets profile call
> > > > > > generated but it's not visible to ftrace
> > > >
> > > > Why ?!?
> > >
> > > there's bpf dispatcher code that updates bpf_dispatcher_xdp_func
> > > function with bpf_arch_text_poke and that can race with ftrace update
> > > if the function is traced
> >
> > I thought bpf_arch_text_poke() wasn't allowed to touch kernel code and
> > ftrace is in full control of it ?
> 
> ftrace is not in "full control" of nop5 and must not be.

It is in full control of the 'call __fentry__'. Absolute full NAK on you
trying to make it otherwise.

> Soon we will have nop5 in the middle of the function.
> ftrace must not touch it.

How are you generating that NOP and what for?


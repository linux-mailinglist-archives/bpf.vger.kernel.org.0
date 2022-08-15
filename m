Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF30592ACA
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiHOIDk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiHOIDj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 04:03:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA351E3E9;
        Mon, 15 Aug 2022 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZV7O1q7GRRTf8eDqThhTkWt59oZOPqEye5wXP3M1qao=; b=ajHARInlfJPzdTXMO14RRLBPOG
        AGU1h0X8dJ3JZD4TBQiCrgVP+EdnB/1zO2Z/bz8JZNNpmJ71TQ9ga46wSCMJCz6jtncIPMtRCdYgU
        fKF879gEU8JxR7KKcILpijWstXw+YpR6sKOTrD4JDz3lKTKhRZgP00tMYF/fSayICwAk7jOtYdQrP
        a3Vx1x+xp0EL09DAsRvRDsGxIusafbhYZuCOcwos/4PIjaEEnDKGpJQmJekvOqrPeqwDM8ACmF0ga
        45TU2hMS/HVDKjULd31XFHVZX4nvQDE7Til69Wnck6ck+IBrVm65Q6FlhNzO5jFCf2x54GxceoI+7
        V5Xk3ciw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNV4A-005XbO-8r; Mon, 15 Aug 2022 08:03:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D90B980153; Mon, 15 Aug 2022 10:03:17 +0200 (CEST)
Date:   Mon, 15 Aug 2022 10:03:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava>
 <20220813150252.5aa63650@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813150252.5aa63650@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> On Fri, 12 Aug 2022 23:18:15 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > the patch below moves the bpf function into sepatate object and switches
> > off the -mrecord-mcount for it.. so the function gets profile call
> > generated but it's not visible to ftrace

Why ?!?

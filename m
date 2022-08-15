Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD923592F02
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiHOMiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHOMiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 08:38:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E020F6E;
        Mon, 15 Aug 2022 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Ly2/Q/Gj3PGUvgRwRp1buJOUgaq2gWZGs2NW4e5dCw=; b=j01s9Ia7TTbz0+edCRg71r8pvK
        OPJ21hUqbOgDyr5Xs0qjReFV+8PmFn8bKn17bK2rIvIu5FF1WJCnsxqCFLlzZ5Uil0OtdU272EMJG
        5vXELWjfKBx8OOyGHHjmRZQUU14/e3ve+NtHackjQ8hpIxoYaOlNwh9NFshwi02bZ1MvTGBx/Jmee
        WYtCxOTOZ8usZd6IrqUQA9RV1YOVoqaB95HJQAp4aAA/8t5k9p3wSiNXm8W+dY3R+fdZ8wUdPxGNq
        T4+ZATJnRe9FZN/Mk7ArdEbj780Kwm0tEJarX9kLfR171evapy3Zl58jpjSmrtnFsPqPMG/npfGGK
        pKGPvrqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZLf-002fiF-9x; Mon, 15 Aug 2022 12:37:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AF07980153; Mon, 15 Aug 2022 14:37:38 +0200 (CEST)
Date:   Mon, 15 Aug 2022 14:37:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
References: <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava>
 <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
 <YvoVgMzMuQbAEayk@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvoVgMzMuQbAEayk@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 11:44:32AM +0200, Jiri Olsa wrote:
> On Mon, Aug 15, 2022 at 10:03:17AM +0200, Peter Zijlstra wrote:
> > On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> > > On Fri, 12 Aug 2022 23:18:15 +0200
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > 
> > > > the patch below moves the bpf function into sepatate object and switches
> > > > off the -mrecord-mcount for it.. so the function gets profile call
> > > > generated but it's not visible to ftrace
> > 
> > Why ?!?
> 
> there's bpf dispatcher code that updates bpf_dispatcher_xdp_func
> function with bpf_arch_text_poke and that can race with ftrace update
> if the function is traced

I thought bpf_arch_text_poke() wasn't allowed to touch kernel code and
ftrace is in full control of it ?

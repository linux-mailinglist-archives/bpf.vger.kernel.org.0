Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448657E8F8
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 23:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGVVl0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 17:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVVlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 17:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC9AB5CAF
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 14:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF97D62154
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 21:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC077C341C6;
        Fri, 22 Jul 2022 21:41:22 +0000 (UTC)
Date:   Fri, 22 Jul 2022 17:41:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220722174120.688768a3@gandalf.local.home>
In-Reply-To: <YtsRD1Po3qJy3w3t@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
        <20220722072608.17ef543f@rorschach.local.home>
        <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
        <20220722120854.3cc6ec4b@gandalf.local.home>
        <20220722122548.2db543ca@gandalf.local.home>
        <YtsRD1Po3qJy3w3t@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 22 Jul 2022 23:05:19 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> ok, I think we could use that, I'll check
> 
> > 
> > But other than that, we don't need infrastructure to hide any mcount/fentry
> > locations from ftrace. Those were add *for* ftrace.  
> 
> I think I understand the fentry/ftrace equivalence you see, I remember
> the perl mcount script ;-)

It's even more than that. We worked with the compiler folks to get fentry
for ftrace purposes (namely to speed it up, and not rely on frame
pointers, which mcount did). fentry never existed until then. Like I said.
fentry was created *for* ftrace. And currently it's x86 specific, as it
relies on the calling convention that a call does both, push the return
address onto the  stack, and jump to a function. The blr
(branch-link-register) method is more complex, which is where the
"patchable" work comes from.

> 
> still I think we should be able to define function that has fentry
> profile call and be able to manage it without ftrace
> 
> one other thought.. how about adding function that would allow to disable
> function in ftrace, with existing FTRACE_FL_DISABLED or some new flag
> 
> that way ftrace still keeps track of it, but won't allow to use it in
> ftrace infra

Another way is to remove it at compile time from the mcount_loc table, and
add it to your own table. I take it, this is for bpf infrastructure code
and not for any code that's in the day to day processing of the kernel,
right?

-- Steve

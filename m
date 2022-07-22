Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562C57E51E
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiGVROX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiGVROW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53475465D
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73AE16221B
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 17:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7286DC341C6;
        Fri, 22 Jul 2022 17:14:19 +0000 (UTC)
Date:   Fri, 22 Jul 2022 13:14:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <20220722131417.566c2cb9@gandalf.local.home>
In-Reply-To: <CAADnVQJTT7h3MniVqdBEU=eLwvJhEKNLSjbUAK4sOrhN=zggCQ@mail.gmail.com>
References: <20220722110811.124515-1-jolsa@kernel.org>
        <20220722072608.17ef543f@rorschach.local.home>
        <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
        <20220722120854.3cc6ec4b@gandalf.local.home>
        <20220722122548.2db543ca@gandalf.local.home>
        <CAADnVQJTT7h3MniVqdBEU=eLwvJhEKNLSjbUAK4sOrhN=zggCQ@mail.gmail.com>
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

On Fri, 22 Jul 2022 09:53:32 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > Sounds like a BPF bug to me. Ftrace did nothing to cause this breakage. It
> > was something BPF must have done. What exactly is BPF doing to ftrace
> > locations anyway?  
> 
> ftrace location?
> fentry != ftrace.

It was the entire reason to add that. Basically, Yes, fentry == ftrace!
BPF can not steal it. Look at the history of it. Everything to do with
fentry being added to Linux was for ftrace, and ftrace was designed
specifically for fentry.

The ftrace infrastructure was designed around fentry/mcount. The rest of
the tracing infrastructure was called "ftrace" for the same reason people
call distros Linux (and why FSF hates that). Just because it was built
around the ftrace infrastructure, not the other way around. This is why I
renamed all the ftrace.h files in include/trace/ to trace_event.h. Because
calling it ftrace.h was a misnomer.

> nop5 in the beginning of the function or in the middle of it
> doesn't mean that it's safe for ftrace to attach there.

How did that nop5 get put there?

Before compilers added support for doing that at compile time (which they
added *FOR* ftrace), it was ftrace that converted the calls to
mcount/fentry to nops. In fact, the fentry trampoline exists in ftrace_64.S.


> In some cases bpf has custom calling convention
> like it preserves %rax.
> In other cases there will be multiple nop5 locations
> through the function where special care needs to be taken
> to attach.
> 
> > > >
> > > > If you don't like Jiri's approach please propose something else.  
> > >
> > > So, why not mark it as notrace? That will prevent ftrace from looking at it.
> > >  
> >
> > And if for some strange reason you need the mcount/fentry on some internal
> > BPF infrastructure, the work around is to register two ftrace_ops() that
> > have filters to that function. In which case ftrace will force the call to
> > the ftrace iterator loop, and any more ops attached will simply be added to
> > that loop, and ftrace will no longer touch that location.
> >
> > Then you can do whatever you want to it without fear of racing with ftrace.  
> 
> Jiri,
> that sounds like a workable solution.
> wdyt?
> 
> > But other than that, we don't need infrastructure to hide any mcount/fentry
> > locations from ftrace. Those were add *for* ftrace.  
> 
> fentry != ftrace.

I 100% disagree with the above statement.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/ftrace_64.S#n134

-- Steve

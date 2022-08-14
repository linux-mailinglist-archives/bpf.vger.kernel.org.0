Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89A591FA1
	for <lists+bpf@lfdr.de>; Sun, 14 Aug 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiHNLcY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Aug 2022 07:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNLcX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 07:32:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D52521811;
        Sun, 14 Aug 2022 04:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9FBCCE0B57;
        Sun, 14 Aug 2022 11:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C505DC433D6;
        Sun, 14 Aug 2022 11:32:16 +0000 (UTC)
Date:   Sun, 14 Aug 2022 07:32:15 -0400
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
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220814073215.0a030a45@rorschach.local.home>
In-Reply-To: <20220813150252.5aa63650@rorschach.local.home>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 13 Aug 2022 15:02:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Index: linux-trace.git/scripts/Makefile.lib
> ===================================================================
> --- linux-trace.git.orig/scripts/Makefile.lib
> +++ linux-trace.git/scripts/Makefile.lib
> @@ -233,7 +233,8 @@ objtool_args =								\
>  	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
>  	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
>  	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
> -	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
> +	$(if $(filter $(shell basename $@),$(NO_MCOUNT_FILES)),,	\
> +		$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount))	\

I believe there's some security and other validations that objtool does
that requires it to know about the mcount locations.

If BPF is doing something unique, and modifying code as well (outside
the jump label and ftrace work), does objtool need to know about that too?

-- Steve


>  	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
>  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
>  	$(if $(CONFIG_SLS), --sls)					\

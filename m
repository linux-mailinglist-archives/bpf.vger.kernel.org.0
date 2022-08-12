Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF55916D5
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiHLVuw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHLVuv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 17:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB95B277A
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 14:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34AA260FB6
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 21:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD45C433C1;
        Fri, 12 Aug 2022 21:50:47 +0000 (UTC)
Date:   Fri, 12 Aug 2022 17:50:45 -0400
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
Message-ID: <20220812175045.5020cfcf@rorschach.local.home>
In-Reply-To: <YvbDlwJCTDWQ9uJj@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
        <20220722072608.17ef543f@rorschach.local.home>
        <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
        <20220722120854.3cc6ec4b@gandalf.local.home>
        <20220722122548.2db543ca@gandalf.local.home>
        <YtsRD1Po3qJy3w3t@krava>
        <20220722174120.688768a3@gandalf.local.home>
        <YtxqjxJVbw3RD4jt@krava>
        <YvbDlwJCTDWQ9uJj@krava>
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

On Fri, 12 Aug 2022 23:18:15 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> the patch below moves the bpf function into sepatate object and switches
> off the -mrecord-mcount for it.. so the function gets profile call
> generated but it's not visible to ftrace
> 
> this seems to work, but it depends on -mrecord-mcount support in gcc and
> it's x86 specific... other archs seems to use -fpatchable-function-entry,
> which does not seem to have option to omit symbol from being collected
> to the section
> 
> disabling specific ftrace symbol with FTRACE_FL_DISABLED flag seems to
> be easir and generic solution.. I'll send RFC for that

No, please don't.

I could help you with recordmcount (which creates the .mcount_loc
locations when -mrecordmcount is not enabled) and remove it for you.

I still want this solution over the easy-way-out that can lead to half
of the kernel being hidden from ftrace.

This is the point that I made about fentry == ftrace. Because we did
the hard part to make fentry work. That included creating sections that
point to them.

All your patch needs is to tell the build not to run recordmcount on
the file. Remember that perl script I wrote? It (and the C version) is
what creates the mcount_loc location that you need to hide these files from.


-- Steve

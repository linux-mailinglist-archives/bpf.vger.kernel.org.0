Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7813F57E0C7
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiGVL0R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGVL0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 07:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD730F67
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 04:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE02618F3
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31E8C341C6;
        Fri, 22 Jul 2022 11:26:10 +0000 (UTC)
Date:   Fri, 22 Jul 2022 07:26:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220722072608.17ef543f@rorschach.local.home>
In-Reply-To: <20220722110811.124515-1-jolsa@kernel.org>
References: <20220722110811.124515-1-jolsa@kernel.org>
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

On Fri, 22 Jul 2022 13:08:11 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> hi,
> we recently hit bug where ftrace update raced with bpf_dispatcher_update
> that calls directly bpf_arch_text_poke [1].
> 
> The bpf_dispatcher_update creates special trampoline and attaches it to
> designated bpf_dispatcher_xdp_func function, which is run for xdp bpf
> programs from several places.
> 
> After discussion with Alexei we'd rather keep this code update out of
> ftrace, because it's already slow and had troubles with CI because of
> that.
> 
> This patch is presenting the idea to allow some functions not to be
> managed by ftrace by marking them with NOFTRACE_SYMBOL macro and
> such symbols will not be added to ftrace_pages on the kernel start.

NACK on any generic way to hide mcount/fentry functions from ftrace.

There's a lot of infrastructure to see what functions are being
modified, as the user should know. (See tracefs/enabled_functions).

There's no need for a generic way to hide functions. Once that happens,
it will grow and then it will be more confusing to why some functions are
traced while others are not.

> 
> Please note it's RFC so I did not bother with some fast search for
> is_noftrace_function function.
> 
> Perhaps we could use existing NOKPROBE_SYMBOL for this? but I'm not
> sure you can (or want) to run function trace on such symbols.

I trace those functions all the time. Yes, I want to continue doing so.

-- Steve

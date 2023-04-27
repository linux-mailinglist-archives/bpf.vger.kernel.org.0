Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6156F0818
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbjD0PSs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0PSr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF24224;
        Thu, 27 Apr 2023 08:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292AF63DF1;
        Thu, 27 Apr 2023 15:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7954C433EF;
        Thu, 27 Apr 2023 15:18:43 +0000 (UTC)
Date:   Thu, 27 Apr 2023 11:18:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <20230427111842.2e40fe3c@gandalf.local.home>
In-Reply-To: <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
        <20230417154737.12740-6-laoar.shao@gmail.com>
        <20230427092628.21fd23e4@gandalf.local.home>
        <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
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

On Thu, 27 Apr 2023 22:22:22 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> IIUC, the acquire/release pair works as follows,
> 
>    test_recursion_try_acquire
>      [ protection area ]
>    test_recursion_release
> 
> After release, there will be no protection, and thus it will fail the
> tools/testing/selftests/bpf/progs/recursion.c[1] test case, because
> the recursion occurs in the bpf_prog_run() itself,

But bpf programs are allowed to recurs. Hence, you need separate logic to
detect that. The test_recursion_*() code is for cases that are not allowed
to recurs.

> 
>   __bpf_prog_enter
>      test_recursion_try_acquire
>      [...]
>      test_recursion_release
>   // no protection after the release
>   bpf_prog_run()
>     bpf_prog_run() // the recursion can't be prevented.

But I thought you can run a bpf_prog from another bpf_prog. So you don't
want to prevent it. You need other logic to detect if it was not suppose to
recurs.

-- Steve


>         __bpf_prog_enter
>             test_recursion_try_acquire
>             [...]
>             test_recursion_release
>        bpf_prog_run()
>            bpf_prog_run()
>                __bpf_prog_enter
>                   test_recursion_try_acquire
>                   [...]
>                   test_recursion_release
>               bpf_prog_run()
>               [ And so on ... ]
> 
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/recursion.c#n38

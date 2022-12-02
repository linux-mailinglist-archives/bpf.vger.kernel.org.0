Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599FE640091
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 07:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiLBGdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 01:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiLBGdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 01:33:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A991350;
        Thu,  1 Dec 2022 22:33:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8930361263;
        Fri,  2 Dec 2022 06:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569D4C433D6;
        Fri,  2 Dec 2022 06:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669962794;
        bh=Yv0oeZfvoloe2s8/P9d5XMpUMasrNBnv39bbXAx17jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p41ZSnI7xof4Vfjd+ZhXN99ojeePR16sjvm0Vhl1AqeofeJRfiS7hV4g2MITSZUfl
         OjzFphelA+l10EJRKjdLGQlYZqpmp7iW5w0tmofh2XCWg0EvYylrSK0UsqcWY9d3uO
         0n0+/JhA2IxxqvqmaUs41Aq+qTCbf/bsJTJyndUQ=
Date:   Fri, 2 Dec 2022 07:33:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH] panic: Taint kernel if fault injection has been used
Message-ID: <Y4mcJ61TPBgvBEWr@kroah.com>
References: <166995635931.455067.17768077948832448089.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166995635931.455067.17768077948832448089.stgit@devnote3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 02, 2022 at 01:45:59PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the function error injection framework in the fault injection
> subsystem can change the function code flow forcibly, it may cause
> unexpected behavior (and that is the purpose of this feature) even
> if it is applied to the ALLOW_ERROR_INJECTION functions.
> So this feature must be used only for debugging or testing purpose.
> 
> To identify this in the kernel oops message, add a new taint flag
> for the fault injection. This taint flag will be set by either
> function error injection is used or the BPF use the kprobe_override
> on error injectable functions (identified by ALLOW_ERROR_INJECTION).
> 
> Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/T/#u
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Documentation/admin-guide/tainted-kernels.rst |    5 +++++
>  include/linux/panic.h                         |    3 ++-
>  kernel/fail_function.c                        |    2 ++
>  kernel/panic.c                                |    1 +
>  kernel/trace/bpf_trace.c                      |    2 ++
>  5 files changed, 12 insertions(+), 1 deletion(-)

I think you forgot to also update tools/debugging/kernel-chktaint with
this new entry :(


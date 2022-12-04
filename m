Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF6641FFF
	for <lists+bpf@lfdr.de>; Sun,  4 Dec 2022 23:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiLDWW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 17:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDWW2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 17:22:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF31208E;
        Sun,  4 Dec 2022 14:22:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5C860F17;
        Sun,  4 Dec 2022 22:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD06C433C1;
        Sun,  4 Dec 2022 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670192546;
        bh=WPtcDEfHJt/O7gAG5TXEo2xTN4qotOLlkgPOPqlvdqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cn4QF8BqPRA76+1gVVayfuGcTbj6ApXIe5pHlvxGFfBbX9jbY8A9+SCEpF4C60hbd
         OTdj5JtJ3oLO2EfjN84acKqM/SIuSz3fRiu05/n7inknrzc9oXvMhKRUv/kg6TIhs2
         8woF5y/iFXXI+54qQ+4riYl+UPNzA63jXB4HmRPCQM5FFdUKS5yWpzZ8gFn2cZNrAR
         Rah88wYUr3nNvydQeECS48PqlUtlTSx/oS3Ssc02U3vkZkKuB95oiVWDaO58Ky0eE2
         xNjPQFdUA2NbP5rzXulVx+MHdxhyjWODXTU52EzIByBHcFhDHKkJDpfPXYr+185qAu
         bG19P6APltV2w==
Date:   Mon, 5 Dec 2022 07:22:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-Id: <20221205072221.63e14cfb08531fc418ab6d1d@kernel.org>
In-Reply-To: <Y4mcJ61TPBgvBEWr@kroah.com>
References: <166995635931.455067.17768077948832448089.stgit@devnote3>
        <Y4mcJ61TPBgvBEWr@kroah.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2 Dec 2022 07:33:11 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Dec 02, 2022 at 01:45:59PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the function error injection framework in the fault injection
> > subsystem can change the function code flow forcibly, it may cause
> > unexpected behavior (and that is the purpose of this feature) even
> > if it is applied to the ALLOW_ERROR_INJECTION functions.
> > So this feature must be used only for debugging or testing purpose.
> > 
> > To identify this in the kernel oops message, add a new taint flag
> > for the fault injection. This taint flag will be set by either
> > function error injection is used or the BPF use the kprobe_override
> > on error injectable functions (identified by ALLOW_ERROR_INJECTION).
> > 
> > Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/T/#u
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Documentation/admin-guide/tainted-kernels.rst |    5 +++++
> >  include/linux/panic.h                         |    3 ++-
> >  kernel/fail_function.c                        |    2 ++
> >  kernel/panic.c                                |    1 +
> >  kernel/trace/bpf_trace.c                      |    2 ++
> >  5 files changed, 12 insertions(+), 1 deletion(-)
> 
> I think you forgot to also update tools/debugging/kernel-chktaint with
> this new entry :(

Oops, thanks for pointing!
Let me update the patch.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

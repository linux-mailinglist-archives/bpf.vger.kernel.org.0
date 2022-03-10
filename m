Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52F4D4C48
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiCJOy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 09:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345916AbiCJOmX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 09:42:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000935273;
        Thu, 10 Mar 2022 06:37:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96629B8267B;
        Thu, 10 Mar 2022 14:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B86C340E8;
        Thu, 10 Mar 2022 14:37:33 +0000 (UTC)
Date:   Thu, 10 Mar 2022 09:37:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, mhiramat@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220310093731.78a6a8d5@gandalf.local.home>
In-Reply-To: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
        <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
        <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
        <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
        <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
        <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
        <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
        <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
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

On Thu, 10 Mar 2022 14:47:18 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index acb50fb7ed2d..2d86d3c09d64 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5354,6 +5381,11 @@ int modify_ftrace_direct(unsigned long ip,
>  	mutex_lock(&direct_mutex);
>  
>  	mutex_lock(&ftrace_lock);
> +
> +	ip = ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +

Perhaps this should go into find_direct_entry() instead, as I think you are
adding it before all the find_direct_entry() callers.

And find_direct_entry will update the ip.

-- Steve

>  	entry = find_direct_entry(&ip, &rec);
>  	if (!entry)
>  		goto out_unlock;


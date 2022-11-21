Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E629F63283B
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiKUPbt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiKUPb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:31:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB48BE257
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 07:30:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9850FB81091
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 15:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED0C43150
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669044608;
        bh=aFTolxzt0R2H3SpbdBNTNqc5USoDLvTFgxXSFnvJ4ts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cLN2HXPqBvynej0YnscnFIDytdgN6QcOf1rw3DvzdDg+afZGJENgxIcHdq+j4nHS0
         3vBxF7NqUyZ7PFCcKzEW88y2zqga3L21rQS1Ox3a5Rq4CdUtzQHgR/YUFlkXrI2jF2
         V1/F/qALui/Dfszu2aPViNJVu7shr3O1ECNK4/Ipe5wiXVXRndtRZ/DgJROdvBMa/L
         2Tr926igsLYuzQ7GrsX2GU7nwdPqkO6khu5K5ZFsh1mYbfOH1a00lYjJ5fD09G05+e
         9ab/vg3eOlZCUwH7+kn60/1aR0cM8L7zFC75GHFqLyPd7uSk8XdkwcxAGce8CRXWqG
         OMZZSDD83GucA==
Received: by mail-lf1-f49.google.com with SMTP id d6so19352874lfs.10
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 07:30:08 -0800 (PST)
X-Gm-Message-State: ANoB5pmN42a1kR+umvZaodG9Jd3DOMJptsaeIbhdddoFO0qCxUscgiP8
        IPwg+lPpdtUzgrTp5HggVN7Roa7BEtNCqgAogqQOTQ==
X-Google-Smtp-Source: AA0mqf6v2VbUAN2Mjgc3JnBIdXL9SwjFTGzeZLpiteg3s5FrpXpb9Ee6tkQSyim1rWABBRXNjIsPlkQhix6mDckTWGU=
X-Received: by 2002:a19:5049:0:b0:4b4:661a:1ce1 with SMTP id
 z9-20020a195049000000b004b4661a1ce1mr3765485lfj.136.1669044606050; Mon, 21
 Nov 2022 07:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20221108220651.24492-1-revest@chromium.org> <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home> <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home> <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home> <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home> <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
 <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com> <20221121101537.674f5aca@gandalf.local.home>
In-Reply-To: <20221121101537.674f5aca@gandalf.local.home>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 21 Nov 2022 16:29:54 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6n-9rH7hCeFVtFYFQ9+6MOuQ+J6LwR4PJ6zUN7w3zQhA@mail.gmail.com>
Message-ID: <CACYkzJ6n-9rH7hCeFVtFYFQ9+6MOuQ+J6LwR4PJ6zUN7w3zQhA@mail.gmail.com>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chris Mason <clm@meta.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 4:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 21 Nov 2022 14:47:10 +0100
> KP Singh <kpsingh@kernel.org> wrote:
>
> > This annotation already exists, i.e. ALLOW_ERROR_INJECTION
> >
> > Users, with CONFIG_FUNCTION_ERROR_INJECTION, can already modify return
> > values of kernel functions using kprobes and the failure injection
> > framework [1] for functions annotated with ALLOW_ERROR_INJECTION.
> >
> > BPF just provides another way to do the same thing with "modify
> > return" programs and this also respects the error injection list [2]
> > and users can *only* attach these programs to the functions annotated
> > with ALLOW_ERROR_INJECTION.
>
> WAIT!
>
> Looking at the Kconfigs, I see
>
> CONFIG_FUNCTION_ERROR_INJECTION is set when
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION is set, and when CONFIG_KPROBES is set.
>
> And ALLOW_ERROR_INJECTION() is set when CONFIG_FUNCTION_ERROR_INJECTION is.
>
> There's no way to turn it off on x86 except by disabling kprobes!
>
> WTF!
>
> I don't want a kernel that can add error injection just because kprobes is
> enabled. There's two kinds of kprobes. One that is for visibility only (for
> tracing) and one that can be used for functional changes. I want the
> visibility without the ability to change the kernel. The visibility portion
> is very useful for security, where as the modifying one can be used to
> circumvent security.

I am not sure how they can circumvent security since this needs root /
root equivalent permissions. Fault injection is actually a very useful
debugging tool.

>
> As kprobes are set in most production environments, so is error injection.
> Do we really want error injection enabled on production environments?
> I don't.
>
> I think we need this patch ASAP!
>
> -- Steve
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c3c0b077ade3..9ee72d8860c3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1874,8 +1874,14 @@ config NETDEV_NOTIFIER_ERROR_INJECT
>           If unsure, say N.
>
>  config FUNCTION_ERROR_INJECTION
> -       def_bool y
> +       bool "Fault-injections of functions"
>         depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> +       help
> +         Add fault injections into various functions that are annotated with
> +         ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
> +         value of theses functions. This is useful to test error paths of code.
> +
> +         If unsure, say N
>
>  config FAULT_INJECTION
>         bool "Fault-injection framework"

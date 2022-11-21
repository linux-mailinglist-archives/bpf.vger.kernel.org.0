Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC8632865
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKUPk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiKUPk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:40:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD5419BD;
        Mon, 21 Nov 2022 07:40:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so29585133ejh.0;
        Mon, 21 Nov 2022 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COoPgvnYK1SFCOLn0lHl9w/NcHb1rVbYH+J4oOi9Dc4=;
        b=DMLGICqccGObYCVEYuQgWtsQzkGw1R8WW0q/A2f2KtdYe4vMRI6tb8juqShkogJuaa
         3j1tspGBDUqSvU2MBqd1BU8SsjcTxSjzviSZ77I23ynMPldZeciFvtx+RHLxs8rTfeQ0
         3Gdsb3kqUoHbF2faBvyJ1uBVggxY0gd/rZ2vzj6+jMCttVGrAzBL1URzdyoIJYzx8eou
         azUWq/OZdi/lKfb7QjFdtRy2QPOG3hptK8jmTtiaMm28YRXNbG47SJ/n1JtUi7NPCs3h
         xGBxjR8qEv5Qzafp6Ir12HQncthscYvZEheg62WvBR9Q5Dqxv5a1yiv/7HOvIHyoYWyE
         e0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COoPgvnYK1SFCOLn0lHl9w/NcHb1rVbYH+J4oOi9Dc4=;
        b=ZxG7+4Zpvu6XHJ+Z8DZ35Wg2HakJel0uAuIWyi9F2e4/3i836UsFo4gU8G8zQHeDIq
         XU9G2Q44f/dqkf85D6vSOU4ep7u+aawU3YW8z5NCHmgxvpk4mAb7GXq4nTUZi/FtJISW
         472O5e5pD1oOHZH7PcWSmtd6pmjMXBoM+3GQ5GeaHMkoH8/VbaQKRB6cbybo3xCt7L7R
         +AXtgq4Zg/jfSBS9+NURt1Dc14njq10ye9224Ck5w+CLYZKGPeGt+LKDn3BkwRkXHGCs
         cUAAcI5Yz8r2ZsbXEn9u9xgczTckG2Smk12AOTXCbP+ZQJpqHRdEp9p+LUu0516+KIQ/
         zEBw==
X-Gm-Message-State: ANoB5pkMx1nGZwrzciD8DjU0OmCxlI0FLI++k0J47Llt8TlKKZKxqDrx
        MRlvqPHcvYs9kM7S1woxG9STWeA9Vr70cj6wUac=
X-Google-Smtp-Source: AA0mqf4UTV+sn0XWyKpSebDcvoh3eCcNM6WL30i5v1b4VUA2kJsKMWXxMZdYI5fBxacjQqhOmKFyvULnESuuK40pDYQ=
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id
 z17-20020a170906435100b0078d513df447mr2086377ejm.708.1669045223995; Mon, 21
 Nov 2022 07:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20221108220651.24492-1-revest@chromium.org> <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home> <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home> <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home> <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home> <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
 <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com> <20221121101537.674f5aca@gandalf.local.home>
In-Reply-To: <20221121101537.674f5aca@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Nov 2022 07:40:11 -0800
Message-ID: <CAADnVQJzRTEWkJoB3B4tgFLtoVRHWnsUvB5ZKSfBsswV3ck1zw@mail.gmail.com>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 7:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
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
>
> As kprobes are set in most production environments, so is error injection.
> Do we really want error injection enabled on production environments?

We absolutely want it enabled in production.

> I don't.

Speak for yourself, because your employer thinks otherwise.

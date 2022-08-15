Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C559326F
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiHOPt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHOPtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:49:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F013DE8;
        Mon, 15 Aug 2022 08:49:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w3so10100964edc.2;
        Mon, 15 Aug 2022 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=G4cO6s3qScJFyAmSKt+kQ7AhUurhwnO0tt2HqC4K7iw=;
        b=lamXrIt0Q5Jv7XJgyzmy2ynQ9YMY3vsYI92trxy20BtU7Rl6iT4T+EX+k37pUT8+H9
         ywVe7Spo7TWEM6qTJDxVHaX6NoSwVr77URHonRkpPwPWjy6owlQVs/B1BzNj+OJKDIIo
         +usxso8YEHXodCllQDcISisGCPEtIRLcqVCwwqabd0oJn7IwXPNQdJsCMPFjVI7GmTK5
         a0O7Yi0uKYCBig1WLzJJtzzYAY/AWL9zG4SpGEjz/tBMcCC6IN50ytCAL5uHGRKaDaPn
         BkPxVGzLM2HLc6+3QG0u+pKhMbzjCI6v+Q5T3Vi5J9/BFiQnucAqrHMBs3hzOtbeTnL2
         6zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G4cO6s3qScJFyAmSKt+kQ7AhUurhwnO0tt2HqC4K7iw=;
        b=pWBhDGwWvRw8rcNDNNmH430sKIZ5FoG+6ydIC6jA93EmFhYDZRC1zAF0PmBdp1o7BG
         Tb3AW+MngJAkZqU9etuN3UWNtrVbY1IxqoAVvFr6Qlev2BhhDCco+wuwjrP0vqjm1orT
         F8KUZbJncvVsvviAhQ4VeOZe4U/Yrnvk8f0KUfIuVYCSnqT16P05xDQDCU6IJ33Y0WBZ
         gq75EAK2R2Xz2NWtwIlzZzaq8+Py76iPthb3lgkE1QYV1p7CXkEmKBLFErHTl61othFs
         TexeCa9vQXG58R9W9+tSZoJevoofZb4+nejgBwGupOfBvdUHE9oyhESrwO72IazvVH/v
         DLEQ==
X-Gm-Message-State: ACgBeo2t+1TyiRRjhx8ut4H3KKJP6opXrpQmaQAW27GXV45WKgpkSEts
        f2iK4SpdE/KyDpti1mnMV6nvrrOObRkV9BgOI7U=
X-Google-Smtp-Source: AA6agR4yu4YrHcYNYrMG6wSnhZ8OTWcNzFNXEIWdabPx9/cauL4JET/2PVw1pnyK1jTW8xXFcBB/qUeAvqY8Sbr53qo=
X-Received: by 2002:aa7:d60b:0:b0:43c:f7ab:3c8f with SMTP id
 c11-20020aa7d60b000000b0043cf7ab3c8fmr15070755edr.6.1660578562710; Mon, 15
 Aug 2022 08:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220813150252.5aa63650@rorschach.local.home> <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net>
 <YvoVgMzMuQbAEayk@krava> <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net> <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net> <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net> <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
In-Reply-To: <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 08:49:11 -0700
Message-ID: <CAADnVQ+QTMRnCpmqPcovcbAXmtVz2Kefyr0E++P7CTRq6=PCVw@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 8:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 05:28:02PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > It's hiding a fake function from ftrace, since it's not a function
> > > and ftrace infra shouldn't show it tracing logs.
> > > In other words it's a _notrace_ function with nop5.
> >
> > Then make it a notrace function with a nop5 in it. That isn't hard.
> >
> > The whole problem is that it isn't a notrace function and you're abusing
> > a __fentry__ site.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/fineibt&id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e

Brand new stuff.
Awesome. That should fit perfectly.

> foo.c:
>
> __attribute__((__no_instrument_function__))
> __attribute__((patchable_function_entry(5)))

Interesting. Didn't know about this attribute.

> void my_func(void)
> {
> }
>
> void my_foo(void)
> {
> }

Great.
Jiri, could you please revise your patch with this approach?

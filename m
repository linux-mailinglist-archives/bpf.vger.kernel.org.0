Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B76593280
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiHOPxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHOPxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:53:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134417593;
        Mon, 15 Aug 2022 08:53:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f22so10085026edc.7;
        Mon, 15 Aug 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NuCd4TB1hMQ+t6weyPyWMKD9kURNOerl6EJQJBh4dcw=;
        b=mi+JUVCcD8IzdfApRzWmEbzfa2LDlDc4X2teLk6SNYfpW3qmnmO12eMQ9YHiabe3ys
         IdbrlnXoZeE5yV7KBpL2HD5pLHyNuaOaX7/Jlpx36P9YHEbACB7Zev5wdsitTyy6l3fx
         ucQGixYTpYnJrtu6/t8NqvFKMVqvIBoGKj3HTZuBJm7429IVyGsOtgYoKHAFfSNWmj79
         Y6vogxvMXR7sIsm5jwBsPFeXxMp6n7Ezk8KuCcS3ozU0OSJy7xtN5ZZOmcS4Yp9GFDz1
         zdPFLgLCSLLonH0hEuLthmWcbqgtZp5G3RTWFSixuHuo9QAOpBS2AbX/H8ok8TVI8MzF
         Ep7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NuCd4TB1hMQ+t6weyPyWMKD9kURNOerl6EJQJBh4dcw=;
        b=QGLzNFpczbxll0xOisazpCw3bq6NgyODyvadpxxtslyAA8YDxyolx/bosN4VaZhNQt
         s/6OiZQCIKH2mlMOzcZQeR+sCSBYDXD5JZukBJzqmbPTEQSl3sFh+i1F5z15pI9tFaUy
         nZjHMHpsTWhpehq/2lHJZba7qaSpj7vdjrzGX4fItw69mIHFbgktd7/cfI2NlfIw2mAl
         /RGOGjLxtdJTRq5PEegXUyHK6YHugMTcfWzUQuX6/f683lCBuf4db4ljYHzjzqThCHY0
         OU/SOMdwBNOOZ2/ebHwddEHgJaZAEhcCp3gUjjkmtltYchh6vHr9p94R8XGM2QkQJajK
         qcJw==
X-Gm-Message-State: ACgBeo0tw+FxSSm5z0gJouQ4lc6/O9UbKg0Y5+LuUJ/6pKSbgDa1EUZl
        qJ+QPwUNuTdHk22NtmobTG2Gmqp68P32vtVCRHY=
X-Google-Smtp-Source: AA6agR6hBzk3ZG+Q0IHJJ2AQTXTqLOBLLy293K/qytljlcU5Q+rpEHRzlDK9F3mruP/ap3qhKwBxCqx5/lDAO9hJDKg=
X-Received: by 2002:a05:6402:3697:b0:443:1c6:acc3 with SMTP id
 ej23-20020a056402369700b0044301c6acc3mr15377241edb.421.1660578797154; Mon, 15
 Aug 2022 08:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net> <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net> <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net> <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net> <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net> <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
 <20220815114453.08625089@gandalf.local.home>
In-Reply-To: <20220815114453.08625089@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 08:53:05 -0700
Message-ID: <CAADnVQK9v8nW4rSwqB3rOkL5POogMQxyTJVUSAOyT=sS6Rv4QA@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
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

On Mon, Aug 15, 2022 at 8:44 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 15 Aug 2022 08:35:53 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > Then make it a notrace function with a nop5 in it. That isn't hard.
> >
> > That's exactly what we're trying to do.
> > Jiri's patch is one way to achieve that.
> > What is your suggestion?
> > Move it from C to asm ?
> > Make it naked function with explicit inline asm?
> > What else?
>
> The dispatcher is already in the kernel so it's too late to complain about
> it. Jiri's patch (with my extensions) will hopefully fix the breakage BPF
> did to ftrace.
>
> My ask now is to be more inclusive when doing anything that deals with
> modification of text, or other infrastructures. This "go it alone" approach
> really needs to stop. Linux is an open source project and collaboration is
> key. I know you don't care about others use cases (as you told me in that
> BPF meeting last year), but any maintainer in the Linux kernel must care
> about the use case of others or this will all fail.

Please don't misrepresent. Not cool.

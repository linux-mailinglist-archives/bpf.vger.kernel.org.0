Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A446E5930ED
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiHOOpe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHOOpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 10:45:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AF25D5;
        Mon, 15 Aug 2022 07:45:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y3so9855701eda.6;
        Mon, 15 Aug 2022 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2r6NzV5K6JWHUt1ICx2UuX4Y6Ch+fw7Dtg6Kfge6QGc=;
        b=GbLvWxDIxgFLq5piP6F2dgRYWQ7rxguDDupe74SrAo+hBy5g3C1mk2+YmJ0k+PTxMQ
         PL/jU34GR/M47O/iNmJg77vJxUJcZUPo0CyVNv/hL+A+XM9D9ci6LI79UjLt9Scwc/8V
         Ru6Bds+2ciVWKzxnWXuIHak+rf47n2Hjw+zTz9JEZTyvH11eoEiS+BbTehbWr/9x6E2Y
         bKatp+ABbIJ3XeAADXbpVBk5aoyFHe6Znbudn5TZapQexuNE6skwj3xkl2eZ8Asrn7Tl
         JcmmSsWLqGcfrSOH+YpMQQpaSZt72DWQsvafSlK7vSuw0gzoGoqdhLm91dXRnMlIHQT8
         vL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2r6NzV5K6JWHUt1ICx2UuX4Y6Ch+fw7Dtg6Kfge6QGc=;
        b=rFVUZR5kwK2BSVn9mIuScrhFmsUpADFpjELiHrjLnf3vfBEBVTv5966NF4VxdA1o0G
         EODqsPILm6p/M8cuVEHEoBHnrQVcZwit7VfOmHp7YU24CrmCIAOr2Y//Jf+2F9fOfJo9
         rHB9/9aQ0JfT833N6ECkyz9ZZISIxMzxseKk2lSIW9gKCj2BGwtJVe1Mvv17Hd2Yz5YU
         aBFozAuTI7tKMVDKzgihZDgyjqiOuOMTXzdVAXALdu1D4yYhI0oVA3tBE2tQYsrOnRmo
         /1ItVg3HeQ5X8h+qw8hNEFvv+hif/DJ9uQ1XgyiERsvj8yKarz32WtLRoZpHlsw3HZCT
         h0Tg==
X-Gm-Message-State: ACgBeo16xEkt94tgkCnR82vB0qFE3Q8VT2eDg7fTD9K/naYtpIt5wPdI
        y27nmrdyG6NdEwo/jylDQESgAGhsNd6UrePKA7Q=
X-Google-Smtp-Source: AA6agR6sEWTbe+AyeLWfPPx+Mli/Iunqsj4kcwNNs+U3AAwcbcjUBRp3ZwsZF65gr3elWP/aT3KIeEXR6DWqUi1Ibt8=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr15211708edb.333.1660574728199; Mon, 15
 Aug 2022 07:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220722122548.2db543ca@gandalf.local.home> <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home> <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net> <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net> <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
In-Reply-To: <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 07:45:16 -0700
Message-ID: <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
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

On Mon, Aug 15, 2022 at 7:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 07:25:24AM -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 15, 2022 at 5:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Aug 15, 2022 at 11:44:32AM +0200, Jiri Olsa wrote:
> > > > On Mon, Aug 15, 2022 at 10:03:17AM +0200, Peter Zijlstra wrote:
> > > > > On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> > > > > > On Fri, 12 Aug 2022 23:18:15 +0200
> > > > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > > the patch below moves the bpf function into sepatate object and switches
> > > > > > > off the -mrecord-mcount for it.. so the function gets profile call
> > > > > > > generated but it's not visible to ftrace
> > > > >
> > > > > Why ?!?
> > > >
> > > > there's bpf dispatcher code that updates bpf_dispatcher_xdp_func
> > > > function with bpf_arch_text_poke and that can race with ftrace update
> > > > if the function is traced
> > >
> > > I thought bpf_arch_text_poke() wasn't allowed to touch kernel code and
> > > ftrace is in full control of it ?
> >
> > ftrace is not in "full control" of nop5 and must not be.
>
> It is in full control of the 'call __fentry__'. Absolute full NAK on you
> trying to make it otherwise.

Don't mix 'call fentry' generated by the compiler with nop5 inserted
by macroses or JITs.

> > Soon we will have nop5 in the middle of the function.
> > ftrace must not touch it.
>
> How are you generating that NOP and what for?

We're generating nop5-s in JITed code to further
attach to. For example when one bpf prog is being replaced by another.
Currently it's in the func prologue only.
In the future it will be anywhere in the body.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114634E7946
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376986AbiCYQvd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356491AbiCYQvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 12:51:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7BC12CF;
        Fri, 25 Mar 2022 09:49:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so6879533pfh.8;
        Fri, 25 Mar 2022 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kOdsZwrQL1XfPdlkXlj/9Xa+AzVdDQNepJd8esNMSA=;
        b=RH/4wmzM1N3goA6fDZmEOIqtcFbnwVj6hl5sryG3LVcXbBaAg9OcTs0/mLXdIkBzIN
         KoStwbD4ZY9nNn9EgZkemVf1m6GGtdopt2bFVM4viCuyBJRomC+f7npkNtNB0fCB/KB4
         gvoZNLNQUKQI2VLfiNYQ7/C4/QdOLqYznSm6nM2jR3aMfDDTntAeCmuvwIezXqUbDHfy
         pBQad0mQ0n3cJseK4nbrh610UoIoqXdFPu9AwgRu5nm7mLEzdEkSzIUUkM81ksnI6MLx
         +vsIvtoxlIWvxM8xyEhQmDGBITfT4k6qkRN7BRv0aH/wP+jQLLWc17mqgQCJzVz+mHc9
         55PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kOdsZwrQL1XfPdlkXlj/9Xa+AzVdDQNepJd8esNMSA=;
        b=YRXWdSBiWJT2UGH0wzFFudCzNVApWWKeLF5vXeNRlyv0IVmrd2cOUhyLNeiN8nrhSS
         IKpaYOlCSgN2BZKhvnqhyK6FoSE23FW3/IUi2CKJ3C/G17fzyfuArcyxMNPQ/aQu7HG5
         1UP8gZptuaegkpbFDcvcA5LxSkAn5eLYglDCCMIT8adIk4QVisA2y9ErFxrexy0asgZF
         i4/IvyviY8+4bBvX6CkIzmM2tBxEEOTf3+WDjX4A325AOp0Q6uBAIOqx3M6p/dZU3rY3
         kjkOKpMKf4DoXDunzhZxoDNM2FMCRVevw/zRpaHmBX02oSEaNmw9ZdH2SBIk6OlgnorB
         Wb7Q==
X-Gm-Message-State: AOAM531rRkfbZBsz0l46Lub7HFPl2A3jdewE9x/W+aQJGrV7g6gAZBn0
        KFgeTgsdC/0KYA7qHgr+oKeb2hUbnX7GOkfRTWU=
X-Google-Smtp-Source: ABdhPJyfhFBRXE5h3qte2x1DrZmNxncfozsOwJFINaTypXcQNRxAhkfoT3oCXvO/uJG6iEaiY9FupxTkU1CGWVRTEBo=
X-Received: by 2002:a63:c00c:0:b0:37c:942e:6c3c with SMTP id
 h12-20020a63c00c000000b0037c942e6c3cmr398099pgg.336.1648226998607; Fri, 25
 Mar 2022 09:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <164821817332.2373735.12048266953420821089.stgit@devnote2> <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
In-Reply-To: <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 25 Mar 2022 09:49:47 -0700
Message-ID: <CAADnVQLg0h7aJBPSfmQdL_M=S9QHWe+xLXZPL4gzMYejz=Mf0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace kretprobe
 trampoline with rethook
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Mar 25, 2022 at 7:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 25, 2022 at 11:22:53PM +0900, Masami Hiramatsu wrote:
>
> > Masami Hiramatsu (3):
> >       kprobes: Use rethook for kretprobe if possible
> >       rethook: kprobes: x86: Replace kretprobe with rethook on x86
> >       x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
> >
> > Peter Zijlstra (1):
> >       Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
>
> You fat-fingered the subject there ^
>
> Other than that:
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Hopefully the ftrace return trampoline can also be switched over..

Thanks Peter. What's an ETA on landing endbr set?
Did I miss a pull req?
I see an odd error in linux-next with bpf selftests
which may or may not be related. Planning to debug it
when everything settles in Linus's tree.

Masami, could you do another respin?

Also do you mind squashing patches 2,3,4 ?
It's odd to have the same lines of code patched up 3 times.
Just do it right once.

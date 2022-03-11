Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F134D6741
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 18:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350077AbiCKRKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 12:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349007AbiCKRKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 12:10:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F17D444E;
        Fri, 11 Mar 2022 09:09:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id f8so8361725pfj.5;
        Fri, 11 Mar 2022 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIifNEL223B4Q2cC9Cr3V2sE1A970stkqMVY6Ytp1f0=;
        b=H8iikbdM7qPlNb22UcDTD2aGwWXFDeRZbdCezuETwBJIwTXE5G7rICTtFqWpEnqJMy
         dv8/hW5OepQoLY8trtjVjtlXIA2Aa1MiooCruVm9NDVxwCfqJFPVK40u5bvfmh7lHFRA
         5JL1gBsT7txcofpgktrMYPf4P5g3/vU5guoLLzWR0bVMpoKmFDsofXxhn6rM1iX9RBMX
         zOs6Fx/qbKFsTxeFjfjAnFxZdrAWKY4MlLiTt1AmnkUIQBf3Razrr3Vt2iL6esw1NXmA
         hlELyJsD7A4fWA/47ag17Swoe+KHwo533y7A+dxXL4sskpqs+A3vqNVuZmJHk5o5uNKZ
         xyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIifNEL223B4Q2cC9Cr3V2sE1A970stkqMVY6Ytp1f0=;
        b=2cN4IBIptN82IvOqE8pD9OOXiW9QpmQf8uzS5Nh4m8Xrjn19nxtG8Dqr/bgCf8fUtX
         dIxOs7/BV49SDdvZ6v88Ma3QCiJZQoJNMah+uP7lsRe2di4r+eH8qNpFHrn6wfuvSOtz
         bs1trxwHLRSKrP/MuPWc912HaXwsT+DuSdIkUluzEYVbu8V9yp6DI3MKBmQVCEebUUM2
         MCGK0GgQPThPHQzg/A4UoSdvNX+BSF7YKK50G8rfM+sZHxr7LiMJrNqAl2K2Ht8jIZvS
         Fw/yubJcJBL+ctzPEz+5KobPpmG7ihAr076Ar3ePG0ygi4Hhyo+gBBkU94Lq3u9uHqHr
         dVeA==
X-Gm-Message-State: AOAM532TSPKS1wjVR0P1QozU65siT0zUgK5qFrzr6wLwuRhTNw6xJlel
        12gWbrbGd4C86+/9/iimpd04jeEWUDVHu3BBgbk=
X-Google-Smtp-Source: ABdhPJziCmcDqqb028R5oB78OOeUFH41SSAnC+DRmTfu5ERq7qEKOzhe8Jv2Q3IlO7l1Yv+YqW4R3ggzmXOHWcwUfSI=
X-Received: by 2002:a63:6809:0:b0:37c:68d3:1224 with SMTP id
 d9-20020a636809000000b0037c68d31224mr9049808pgc.287.1647018589126; Fri, 11
 Mar 2022 09:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20220308153011.021123062@infradead.org> <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net> <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net> <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net> <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net> <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
In-Reply-To: <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 11 Mar 2022 09:09:38 -0800
Message-ID: <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
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

On Fri, Mar 11, 2022 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 10, 2022 at 05:29:11PM +0100, Peter Zijlstra wrote:
>
> > This seems to cure most of the rest. I'm still seeing one failure:
> >
> > libbpf: prog 'connect_v4_prog': BPF program load failed: Invalid argument
> > libbpf: failed to load program 'connect_v4_prog'
> > libbpf: failed to load object './connect4_prog.o'
> > test_fexit_bpf2bpf_common:FAIL:tgt_prog_load unexpected error: -22 (errno 22)
> > #48/4 fexit_bpf2bpf/func_replace_verify:FAIL
>
>
> Hmm, with those two patches on I get:
>
> root@tigerlake:/usr/src/linux-2.6/tgl-build# ./test_progs -t fexit
> #46 fentry_fexit:OK
> #48 fexit_bpf2bpf:OK
> #49 fexit_sleep:OK
> #50 fexit_stress:OK
> #51 fexit_test:OK
> Summary: 5/9 PASSED, 0 SKIPPED, 0 FAILED
>
> On the tigerlake, I suppose I'm doing something wrong on the other
> machine because there it's even failing on the pre-ibt kernel image.
>
> I'll go write up changelogs and stick these on.

What is the latest branch I can use to test it?

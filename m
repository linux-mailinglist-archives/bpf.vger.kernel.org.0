Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1934F645327
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 05:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGEpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 23:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGEpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 23:45:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C5C56EFD;
        Tue,  6 Dec 2022 20:45:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c17so14716003edj.13;
        Tue, 06 Dec 2022 20:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9rz5RXsefs8IUrVRbKuQXJ4nANoI2MNNqTGiEbhFsD4=;
        b=cwvIfXQ9y3KKIaXZ4Pf9AL8BHYbLgALfc9c3tr8apSNTJpatt4tT0wdHxfswZSpDBN
         HePwJZvGZlLnbxgzB+MMFbARgeAN0eEMoVcvMhcrGXZUuNYY4dqSv2ut28oi+CcUm/VC
         bd3Ioy7SLHZ1B8Z8zt7Je9vulJvF9wxp5gACsNVg3N8rIcJXVITV1N2oN0PSq35GIYTL
         +7zJAHjk2QE6/40nDTU4usYqptQZ2QiLHjtWqfqsSJJmgD1fuuflw03peDN8GSSmxAs8
         MIqXNTDMHU/LlBW3XoNNzbD9cDGYRvufXZn1kJPiZfwXZl0pTroT3wtfpB1u91w/zGtA
         oBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rz5RXsefs8IUrVRbKuQXJ4nANoI2MNNqTGiEbhFsD4=;
        b=ggYPeP8uNf6hgcPG/goyG4DfzSlGuUypsHUlsReQGNtu52tzBan7/bxrAj7et0PDMC
         dfxoQldiaEc0405+yenWkDVG0pSRM+rO34c/S2nvpw//s/BjbvLJ93vCU9tJmZuGEx0N
         p+4r0G8jgBhSeGAW/lFo0zm691O2bvOCiS9sbPN/pf7MS+c+h1gveWatpMVfhYMFvprr
         Cge9T/XxfxoL+uADb11r54DPowWqVSbH4i6wVbb3Ua4sznJKE5LVEE/H6oFvYlZe6KDL
         bNukds9cm7KoHMdhfEqFPWncxhpYz+5rbU9lGzHZhRL4v6n8zd42oadTtC9mqWwCdN7w
         29CA==
X-Gm-Message-State: ANoB5plVYobmCuypJfsT8pCUi7i18s8STYDHSW/UgFjSGL96YSxn/Y0Z
        tNbmhSnfFWPmPv8AxItGtLskdVxz+n1Hb36khvE=
X-Google-Smtp-Source: AA0mqf58yA7mZKTc3sjRqY2HADZUwkR0MOmXUiNeyLQ9N68tP9LjTiRynocXIGHORETS+Phn2Pqjc+89CK0OHxhbmKk=
X-Received: by 2002:a05:6402:5289:b0:462:70ee:fdb8 with SMTP id
 en9-20020a056402528900b0046270eefdb8mr46162424edb.66.1670388328609; Tue, 06
 Dec 2022 20:45:28 -0800 (PST)
MIME-Version: 1.0
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org> <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
 <20221206162035.97ae19674d6d17108bed1910@kernel.org> <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
 <20221206233947.4c27cc9d@gandalf.local.home>
In-Reply-To: <20221206233947.4c27cc9d@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Dec 2022 20:45:17 -0800
Message-ID: <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
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

On Tue, Dec 6, 2022 at 8:39 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > [   49.281382] general protection fault, probably for non-canonical address 0x57e006e00000000: 0000 [#1] PREEMPT SMP KASAN
> > [   49.282226] CPU: 6 PID: 1688 Comm: test_progs Tainted: G    B      O       6.1.0-rc7-01508-gf0c5a2d9f234 #4343
> > [   49.283751] RIP: 0010:rethook_trampoline_handler+0xff/0x1d0
> > [   49.289900] Call Trace:
> > [   49.290083]  <TASK>
> > [   49.290248]  arch_rethook_trampoline_callback+0x6c/0xa0
> > [   49.290631]  arch_rethook_trampoline+0x2c/0x50
> > [   49.290964]  ? lock_release+0xad/0x3f0
> > [   49.291245]  ? bpf_prog_test_run_tracing+0x235/0x380
> > [   49.291609]  trace_clock_x86_tsc+0x10/0x10
> >
> > This is just running bpf selftests in parallel mode on 16-cpu VM on bpf-next.
> > Notice 'Tained' flags.
> > Please take a look.
> >
>
> "G - Proprietary module" - "O - out of tree module"
>
> Can you reproduce this without those taints?

Lol. That question is exactly the reason why my Nack stands.

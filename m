Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF817878C
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 02:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgCDB0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 20:26:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36720 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgCDB0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 20:26:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id j16so333562wrt.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 17:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jrmU0aUpyeiczxdUe8N4p4XFs4SNd8CWnE3coIhgCAs=;
        b=AJEN3CitJU/4Z0JTnLw/ey04m43KyIRnf3pgOjFiKT+U6iwItjQytak+e97bRM59WH
         /0mVfLRbbbWjrEoZdKJ2NorfsJk6k0MxZ+XYdVn3HRYRu8t1OiF+5xjVv5AnRqQTqp7R
         ztjHJUEORGnsiclnTsjGRYXYq5bRfPhxJq2I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jrmU0aUpyeiczxdUe8N4p4XFs4SNd8CWnE3coIhgCAs=;
        b=n8w0wsnEvSvyt/dH7+FixBKf++8fMjYVp5BNGX9pCNz6HYwxCWxcTbmcrS0dVqEme2
         JoekOqNTTnduwC/eZ1k450YQ1RCa5UVfRX4dxLlDmbTLYgTIaFjZyRSdeIPShMOTnZkR
         DyiBhazTETD/urQy74rwywc2eS6/9LhYPrIRymwJPK1uW6I5q6xRCIC3WSGyMVdZySLv
         AIo5GSnrY7KZi0C5Whh291AGRhCGggBMZEwo1G/ZWCrKrMWslTs1h1d1nloAO9/srBvF
         lE0r/ZaAupxc9dXUVQ+bYQdX0bq3g0t30c8wjzLd0weW+2KMb1pHgIbxA5rK4JKLl0CO
         i8dQ==
X-Gm-Message-State: ANhLgQ0GrTfSOMFZhdwjtfCg5zwKx6HmDjnpITHN6qOEXy/x9e2nTnVL
        KhV2w42bpVk1TP6Dz/h5JgSjDQ==
X-Google-Smtp-Source: ADFU+vtMtYSgZIYl+yREwwcH4jOyLaoAv0iOxtAoJ1Pwlhws2x7ue8V4D25DPLPrqKgrQk6X81VErQ==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr964900wrv.157.1583285164578;
        Tue, 03 Mar 2020 17:26:04 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id j4sm25875474wrr.0.2020.03.03.17.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:26:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 02:26:02 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 2/7] bpf: JIT helpers for fmod_ret progs
Message-ID: <20200304012602.GB14634@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-3-kpsingh@chromium.org>
 <CAEf4BzZJ2E2rmyz7k4F7s=EXPbaAX7XncvUcHukX_FYDWeD7BA@mail.gmail.com>
 <20200303222812.GA5265@chromium.org>
 <20200303235604.mdlamwx4z2ws3fzy@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303235604.mdlamwx4z2ws3fzy@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 15:56, Alexei Starovoitov wrote:
> On Tue, Mar 03, 2020 at 11:28:12PM +0100, KP Singh wrote:
> > > > +static void align16_branch_target(u8 **pprog)
> > > > +{
> > > > +       u8 *target, *prog = *pprog;
> > > > +
> > > > +       target = PTR_ALIGN(prog, 16);
> > > > +       if (target != prog)
> > > > +               emit_nops(&prog, target - prog);
> > > > +       if (target != prog)
> > > > +               pr_err("calcultion error\n");
> > > 
> > > this wasn't in the original code, do you feel like it's more important
> > > to check this and print error?
> > > 
> > > also typo: calculation error, but then it's a bit brief and
> > > uninformative message. So I don't know, maybe just drop it?
> > 
> > Ah, good catch! this is deinitely not intended to be here.
> > It's a debug artifact and needs to dropped indeed.
> 
> That spurious pr_err() caught my attention as well.
> After further analysis there is a bug here.
> The function is missing last line:
>         *pprog = prog;

Great catch! Fixed.

> Without it the nop insertion is actually not happenning.
> Nops are being written, but next insns will overwrite them.
> When I noticed it by code review I applied the patches to my tree
> and run the tests and, as expected, all tests passed.
> The existing test_xdp_veth.sh emits the most amount of unaligned
> branches. Since then I've been thinking whether we could add a test
> to catch things like this and couldn't come up with a way to test it
> without burning a lot of code on it. So let's fix it and move on.
> Could you rename this helper? May be emit_align() and pass 16 into it?

Seems reasonable. Done.

> The code is not branch target specific. It's aligning the start
> of the next instruction.
> Also could you add a comment to:

Done. Sending v2 out.

- KP

>         align16_branch_target(&prog);
>         for (i = 0; i < fmod_ret->nr_progs; i++)
>                 emit_cond_near_jump(&branches[i], prog, branches[i],
>                                     X86_JNE);
>         kfree(branches);
> to say that the loop is updating prior location to jump to aligned
> branch target ?

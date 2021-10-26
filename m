Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA42643BC08
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhJZVId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbhJZVIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 17:08:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EDAC061348;
        Tue, 26 Oct 2021 14:06:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so455901pjb.4;
        Tue, 26 Oct 2021 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIlg9pcglox4T7ATE2cET/B8l0TxcSrLbPwLhUNDR0M=;
        b=oVK903AIVsoG2KrYw5P6WncWnxZeFUL9X8SnFTK5FkszxkOE6GXX6GIeJjw6Futr9+
         d4Tkg+VNVjDpefWQqcfEYf3/EHH0JU7voYoMhAXFRwZHeo1CWIeWsS9LCR/T4DuauGbb
         VXP68AXOsCQnc/6B//ah5NjrkNF5R7hfrmAV8LvtD/NvSvkqxGGlUA/2NprAcsvVj/BF
         keokXK5LA/Z7C1jGvkbGItRQ87cm1GKeZr6nsaUWAdqAQif9F4tt6mCoWvmlWQrB9rGz
         hlqUU1N4Pt8OY3yGPG6WmUSR7EXbMr6D5SG7SPqCEhKdkW6Ls4bZIzqtot04gzK00i3+
         dOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIlg9pcglox4T7ATE2cET/B8l0TxcSrLbPwLhUNDR0M=;
        b=tuGqSob8iSEpBRyV8W43jsHYjSaDJ3CK36hdplO80WBkATR79yHqJEB+bLUwV+Nq+c
         fBnlGSuN2QHngonxDulmDWUrVcfKOpXNxow5C4sixSJA+ZIvPGGcd4SQEho7Je18CgdO
         igIyU6GRNiEo7FFDI7k8mgzj4FX785/Ex9FCapxb2Jt5RdE/5w7jDVWJHEkIO4QzzXeP
         hT+Vn8GNdAGnixCIs7ha36CSRr+HR3Qalc1AbST/op45m197TRUx6GkqfZo7+AiNnmw0
         9yE2FMPJ5dXb2uM5lWl3itLOV+tKnqcqHBnWeCkhPv286x1SZ7e/h38ggJ2V+aXyum8I
         57EQ==
X-Gm-Message-State: AOAM530Rk4z27eollcrd/VOmrvw3eim0zGhC8b9GJ3z9cKrKQyfacexS
        wEMGdqW4RQDQE7NGnMJyTc15ksUfWeQh4FUOyxThqbkm
X-Google-Smtp-Source: ABdhPJxQV1IT9aGON+yzfyu4hI4UZZ5M3cqUXzsa4bx4C3RvFEoAcO/fYc2GhqkQ5G59X+yI8ket218G8kGTLZDo1V4=
X-Received: by 2002:a17:902:8211:b0:13f:afe5:e4fb with SMTP id
 x17-20020a170902821100b0013fafe5e4fbmr24803576pln.20.1635282366365; Tue, 26
 Oct 2021 14:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211026120132.613201817@infradead.org> <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
 <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net> <CAADnVQ+w_ww3ZR_bJVEU-PxWusT569y0biLNi=GZJNpKqFzNLA@mail.gmail.com>
 <20211026210509.GH174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211026210509.GH174703@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Oct 2021 14:05:55 -0700
Message-ID: <CAADnVQ+NA2J3Lxvb8Y31yaubM6ntx5LtoSEaLziZ1b8qiY4oYQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 2:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 01:00:04PM -0700, Alexei Starovoitov wrote:
> > On Tue, Oct 26, 2021 at 11:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Oct 26, 2021 at 11:26:57AM -0700, Alexei Starovoitov wrote:
> > >
> > > > It's a merge conflict. The patchset failed to apply to both bpf and
> > > > bpf-next trees:
> > >
> > > Figures :/ I suspect it relies on tip/objtool/core at the very least and
> > > possibly some of the x86 trees as well.
> > >
> > > I can locally merge tip/master with bpf, but getting a CI to do that
> > > might be tricky.
> >
> > We have an ability in CI to supply few additional patches on top bpf/bpf-next
> > trees, but that's usually done for the cases where we've merged a fix into
> > one tree, but it's needed in both while bpf->net->linus->net-next->bpf-next
> > circle is still pending.
> >
> > Does tip/objtool/core dependency relevant for this set?
> > Can you rebase the current set on top of bpf-next and send it to the list
> > just to get CI to run it? We won't be merging it into bpf-next, of course.
> > I'm mainly interested in seeing all that additional tests passing that
> > we have in bpf-next.
>
> I should be able to rebase it just to that, let me try that in the am
> though, brain is fairly fried atm. Do you really want me to post it to
> the list, or is a git repo good enough?

Please post it. CI cannot pull it from the repo.

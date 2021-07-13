Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E767C3C76C6
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhGMTHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMTHO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 15:07:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E07C0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 12:04:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 141so15025590ljj.2
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=024UQOG3GqmthMWzeIdY8pP5YY7/J0NACcNv5wsZ+1Y=;
        b=OZ76qRkugVXs+1Cqa3HrDrynoY4myYssv1r+6YrLWr8E1sg/eA0BDx4Gwos+l2l4Nf
         rT14k5QkfJjL6/D1FeCtDDEgmOKIUjdBHFPkd2QYHvo8RIFQOaE5pGSqLXt0ytZs8nUx
         mW+W6M7dfDZOrCw69dDKRiMhzrJFs8e9ieRcs52ULSYcOhUGCR6chRkL3CNhyi4T4lCw
         Sb8pK9NnB/FY+2z6I0EkJbn8Bn/Vf3/fv7ZYx7zSseFSClEP5/EYueM4EgXSXSvT7qZI
         XHYBKua7wdWQjdDKTI/JZsinAuE2E/iKhnvMDBpxYpOsm43rpQLv9GgFvmqCH1smp70Y
         SQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=024UQOG3GqmthMWzeIdY8pP5YY7/J0NACcNv5wsZ+1Y=;
        b=tpgyUJNa7illvxgW0F99n7b/TVpxHNTLv+oj+pB7sc4Rv0kQVYMy+l/7UlVZ5GFQUE
         +HSQwvzD4etMS0JntTFXq9g/V5QcuCOY3uKbqBYhC+xPBpdS0YUdTklTWK52S2S4xIU6
         63uAwXt9Cne1mh4S4WWLztKJ6l128bYIyO6FAblRms7jg5HSckZHHOAMzajBEFYRGkhr
         w6jA4Yi1Qj60wDqn5ACqgK20nucU0dTNC07caZxPOGIL9j/iuVRoK27MYKLfJRwrc07O
         tVWdx2SEexX73HZvLX06D7fUAGa8vFkjKkwMGUDmq7TavTFUbB3jBLO5HfUkvO7XbdHe
         4azw==
X-Gm-Message-State: AOAM5327HHv+9/jiWF+aSqXnip1cryrCngrxlf+QocnF/TfK40TnaaL3
        BQXF8cV2Z7KhL+pJ6mSowx10tpCnEfHyd1DIuqw=
X-Google-Smtp-Source: ABdhPJyc0fnW3GqeeSFRXC8X6q0qp+Wm58IMd8OXVwpZczDG2DNsr6McYNKRvddlSHEKVefub1SzII+dCIb5++DsNyw=
X-Received: by 2002:a2e:3214:: with SMTP id y20mr5057065ljy.486.1626203062146;
 Tue, 13 Jul 2021 12:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <618c34e3163ad1a36b1e82377576a6081e182f25.1626123173.git.daniel@iogearbox.net>
 <20210713083941.GB60476@ranger.igk.intel.com> <30504db2-5362-2e73-8d6c-93ef3ba875fc@iogearbox.net>
In-Reply-To: <30504db2-5362-2e73-8d6c-93ef3ba875fc@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 13 Jul 2021 12:04:10 -0700
Message-ID: <CAADnVQJacx8fOr-p810myqTMXRt4N14hZebHs26zqkk8=a1azw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix tail_call_reachable rejection for
 interpreter when jit failed
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 13, 2021 at 3:58 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> >> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Co-developed-by: John Fastabend <john.fastabend@gmail.com>
> >> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> >> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >> ---
> >>   kernel/bpf/verifier.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 42a4063de7cd..9de3c9c3267c 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -3677,6 +3677,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
> >>      if (tail_call_reachable)
> >>              for (j = 0; j < frame; j++)
> >>                      subprog[ret_prog[j]].tail_call_reachable = true;
> >> +    if (subprog[0].tail_call_reachable)
> >
> > This could be just:
> >       if (tail_call_reachable)
> >
> > But what you propose is fine to me as well. Not sure how we missed it.
> > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> Thanks! Yeah I wanted to also use subprog[0] here given this really denotes
> the main prog. We have a similar case elsewhere too where we set the stack
> depth for env->prog->aux->stack_depth from env->subprog_info[0].stack_depth.

Applied. Thanks

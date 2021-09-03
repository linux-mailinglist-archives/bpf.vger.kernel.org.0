Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CE4003EF
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbhICRL3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 13:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhICRL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 13:11:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB06C061575;
        Fri,  3 Sep 2021 10:10:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j195so3298241ybg.6;
        Fri, 03 Sep 2021 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MjMHuC+roNm7Spa73SgumLohK2Wfsd4VJdqj/W1924=;
        b=VIZ3CL/+O3UuYMs8eVjmKMQ1O4PiKyZlLSGb+YS/eZDENI7Vh6DXz6ha6ZNMlari+x
         y/ze7Ji0aApiBcNbJY+FOvDQFRAPGpEA63Q/F73ioEgJHanNl7ZZkUifaQ0x51wGSKNa
         xR61VTmokLrpYELWjMX9M9rt+AJe7e7r2j9QWsk8YF/vHzb/nCQykFTLkMXoJ5yXvfLj
         Db6eJKEVUPSVDKyxeiP+78gdEYSl9sVN15q4dyXA6gqwr//3poaJ7rjqYtgMs8f1ZkzV
         kc8rAD8yj2AM1+lByqHnZQSYMsihCmdBaDIBOo/6V+30udlCZwibcUOj3rQov6DwD8Cx
         fXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MjMHuC+roNm7Spa73SgumLohK2Wfsd4VJdqj/W1924=;
        b=oQbDipayy25PijDEONkDHx0tS2wMTgKDUZtzzNFKR3zroh5Apn18tADIYIC1aSAS/l
         WfgkhFTtSCSxxh6XQKty9+YpN97aO2umIZK49lGxffS6qJYudcll5oLBl9pcRgjmQwVT
         Jl+FK95m/WFyjy/RZdnn7RG365DvkFa2Y0VO4ReZbESPf9GMCNRWTP6W+r+jz4LELRGl
         DO00rZDqvaeD85oRoACMdEC4pc62ja0gui7wKXodRXZFSrVHnVAVflLMueHPN11ekM7S
         XDZF0l0+1/px/Cdw8rtbydjfkFD535blRbhbt8fKlR2+kiFCUfwCD0cvqaVD0gVCrO2D
         FjRQ==
X-Gm-Message-State: AOAM531n+HlZxMmrvUqiWpfHYSh+e+9u28smzbVYMifxkwg0rld9p1OO
        Lpb0hlFdc/Di2h90xV55lZsG5Vz11p8RwNW75Cs=
X-Google-Smtp-Source: ABdhPJxAwhbn6BupCHaSyKoQeKtU3NA6uno4HUm2g/J3uxG5aJ7h5UIVbOVsRd7X4ri/XV6ah82YYMmWuQOJREMDflo=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr67041ybi.369.1630689027611;
 Fri, 03 Sep 2021 10:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com> <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
In-Reply-To: <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Sep 2021 10:10:16 -0700
Message-ID: <CAEf4BzZ0eq1iFh1oVwTZ7+bQkb=pJShgDWzUSAp41sk30iQunQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 3, 2021 at 1:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 02, 2021 at 09:57:05AM -0700, Song Liu wrote:
> > +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
> > +{
> > +     static const u32 br_entry_size = sizeof(struct perf_branch_entry);
> > +     u32 entry_cnt = size / br_entry_size;
> > +
> > +     if (unlikely(flags))
> > +             return -EINVAL;
> > +
> > +     if (!buf || (size % br_entry_size != 0))

I think buf can't be NULL, this should be enforced already by verifier
due to ARG_PTR_TO_UNINIT_MEM, so we can drop that.

> > +             return -EINVAL;
> > +
> > +     entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
>
> That's at least 2, possibly 3 branches just from the sanity checks, plus
> at least one from starting the BPF prog and one from calling this
> function, gets you at ~5 branch entries gone before you even do the
> snapshot thing.
>
> Less if you're in branch-stack mode.
>
> Can't the validator help with getting rid of the some of that?
>

Good points. I think we can drop !buf check completely. The flags and
size checks can be moved after perf_snapshot_branch_stack call. In
common cases those checks should always pass, but even if they don't
we'll just capture the LBR anyways, but will return an error later,
which seems totally acceptable.

As Alexei mentioned, there is a whole non-inlined migrate_disable()
call before this, which we should inline as well. It's good for
performance, not just LBR.

> I suppose you have to have this helper function because the JIT cannot
> emit static_call()... although in this case one could cheat and simply
> emit a call to static_call_query() and not bother with dynamic updates
> (because there aren't any).

If that's safe, let's do it.

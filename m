Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49183403BB5
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhIHOpG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhIHOpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 10:45:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48923C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 07:43:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t19so4688473ejr.8
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uabt4pKuf2kBSNv+i0qvyQ7gGTLuhCK/E/pLJaOpcUI=;
        b=led/LN2yMve9BoUBIhjG1AHu8ACK+rW3hw3Oy1SqXgFlTum0aLIn44Ifb94ULoUILi
         /Ap+SMj84d9jHlUHsmU3N/jEJnRo3r4LujzdvhLMfNv9EuMvXo1U/cjibCcKzgxTG8Xo
         ETBTWXFNAXQfMufWeNSNmqLfOXVrLl58/DN1jVyXZCIgRFnBsQUEVYR5HzAlplPCkyaY
         w/1Yaj1LBm1YT5+4UNem7fMi93GV2RMOnTOCEJuY85zy3SqERXhm54SHzuvKe9KZ8Rtz
         HN7Zq4kIGs/Cpx969P0qpx3DsZfxCJK48FZt5+M0SU3LAymtvVV+KB663T8+DDMaQ83f
         5SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uabt4pKuf2kBSNv+i0qvyQ7gGTLuhCK/E/pLJaOpcUI=;
        b=22u5PDl/DCyk3+2oWbq2rBwvEPxuiMUVmfqPGj7Ux/5stC685zyhX8AWV6fhMOqFZE
         MTRAYbJkpVXFZJtL91agZPp6fI9ph3B5ZQfQCO63+uEe6C4DahRs2PSXUaMOoKiF1ave
         YeBk/pSkY9/wzGnOqnNp8yXxNqVLVihzNR7RFB+b/u6P9ywZZqbSBzal6U3xOJc/YORN
         8hMxf5zHOmQHb6a7Z4mVTVEgKDL2aDJ9S8xnO8dL2XRIt8efc8YP4uxqTsxsdpKBDDei
         avujsP+t5iqVkE+7czjDCyhVUzczK0K0YpHskujd+mvr8IoaLfui9SyDhlg8jkLpPXqD
         BFXw==
X-Gm-Message-State: AOAM5320jEeuu54Fx8PIEC/wPodT5kTr+WngqaXpoEmWKHvG5C61vUMv
        eUR3gwR1cK3zegKoqRv4Fft1FvLZIKoR9NWm2FnVIA==
X-Google-Smtp-Source: ABdhPJwsIEqxGFffEBu189b/kMWOmdnA7n6KsndujfJWWNRveBZQSPJvlyjTExPZGsFlfiO7K/AhKS/FBYW3YXZXQA8=
X-Received: by 2002:a17:906:584b:: with SMTP id h11mr197985ejs.209.1631112235567;
 Wed, 08 Sep 2021 07:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210908044427.3632119-1-yhs@fb.com> <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca> <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
In-Reply-To: <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 8 Sep 2021 16:43:43 +0200
Message-ID: <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 4:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 08, 2021 at 10:53:26AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:
> >
> > > > The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> > > > which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
> > > > asserts that mm->mmap_lock needs to be held. But this is not the case for
> > > > bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
> > > > uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> > > > in bpf_get_stack[id]() use case, the above warning is emitted during test run.
...
> > > Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
> > > fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?
> >
> > Michel added this remark along with the mmap_read_trylock_non_owner:
> >
> >     It's still not ideal that bpf/stackmap subverts the lock ownership in this
> >     way.  Thanks to Peter Zijlstra for suggesting this API as the least-ugly
> >     way of addressing this in the short term.
> >
> > Subverting lockdep and then adding more and more core MM APIs to
> > support this seems quite a bit more ugly than originally expected.
> >
> > Michel's original idea to split out the lockdep abuse and put it only
> > in BPF is probably better. Obtain the mmap_read_trylock normally as
> > owner and then release ownership only before triggering the work. At
> > least lockdep will continue to work properly for the find_vma.
>
> The only right solution to all of this is the below. That function
> downright subverts all the locking rules we have. Spreading the hacks
> any further than that one function is absolutely unacceptable.

I'd be inclined to agree that we should not introduce hacks around
locking rules. I don't know enough about the constraints of
bpf/stackmap, how much of a performance penalty do we pay with Peter's
patch,
and ow often one is expected to call this function ?

cheers
luigi

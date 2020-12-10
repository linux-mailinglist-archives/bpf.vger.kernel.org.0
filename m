Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E942D511C
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 04:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLJDDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 22:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLJDDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 22:03:05 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D5CC0613CF;
        Wed,  9 Dec 2020 19:02:24 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s11so5018716ljp.4;
        Wed, 09 Dec 2020 19:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VknBs3+OO4cbPFyac6UMvtv/ygbv9sRyQgm0I2urpo=;
        b=j+aa7raWma8/6rkZiaQr+3m+3eWKFsEjNE2U004caJXgeqcLOk/0EKUSSxYF1AnZa7
         qowaaEO66hpXpFQoRi2dLfJRIH7Z9LIlcmEkm6WLOzqLOJDcQu8B679Hxc+5YzaFQKfu
         VKSE3GHyafnkGyZNudp2lDvCya3eH3tNh311Ue7d6j6nVyOqzPmf/FBy5Q7/qLlJXwXO
         2MfdooZFVmgqzFs9XB/pJuFYIM8akbY2HJebXyLMM0VsgBzjx3Rl6ptJ0sAscl378Dv8
         0V7q/Gb7jYRvbTm1SC8OAodTySZYNtXgDkrbl9OcLlWD0l611UJcv4tR1wdmWquXUyip
         yS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VknBs3+OO4cbPFyac6UMvtv/ygbv9sRyQgm0I2urpo=;
        b=ofEc38aMdnS2SzWtYfyQZMjUnhMIfnk035LgPjS000fY+irBd4fsGKJyKTZ4qHoCA4
         AFuApU94DbuJg+9pKWPbi8rbyZvrJxsUXwD4IRcYZ+Zfu9GHh0GbYEEo4O13pF0pX8Cr
         7I3rAGCVC/917r8VmriPjqwpxaofl78AeihV08ULdc0C2zBbm6KMFK6eZUtlOIZltVeK
         xgPGqmC5tQ0NKSqwbxJFhhb1FVQZIPIEvSOYfkaw5P9NmYhp87T/b/fz56D3GOAfY3NC
         7odfxAWrJeJlQ2F/910PHKPqO/Yqt8t2hIxFN8p0igosV5KfvzLlFxNQ4WAgbEHWs8Xl
         TYRQ==
X-Gm-Message-State: AOAM530zg2nzH70JmRlcwU/HkxQ6t/0A9W8SBKkYZKvwsdDVNAL86pCI
        XfED4DqhzCQhesZwpfTCSRnQBiSOcVgWTT+frMA=
X-Google-Smtp-Source: ABdhPJwjascmpY96Tnzqi0NKpxktPoJnXSP0VBwfFTVswcQyH7eU8Zay190L548EDADATSwsDcNP6YaEq3VulbQW7HU=
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr2243344ljj.258.1607569343217;
 Wed, 09 Dec 2020 19:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz> <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
 <20201209144628.GA3474@wp.pl> <20201209150826.GP7338@casper.infradead.org>
 <20201209155148.GA5552@wp.pl> <20201209180552.GA28692@infradead.org>
 <20201209223206.GA1935@home.goodmis.org> <CAADnVQKiBWG9NVNEV9EqGkyd-n3Yj88cNJpH997js-63eTVAOQ@mail.gmail.com>
 <20201209213126.79ca1326@oasis.local.home>
In-Reply-To: <20201209213126.79ca1326@oasis.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Dec 2020 19:02:11 -0800
Message-ID: <CAADnVQ+6n4Nf5TczYWqLBrYJF_fEmRVyEbGqmaT0G9XoS7iMxA@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 9, 2020 at 6:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 9 Dec 2020 17:12:43 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > > > > FWIW, I intend to do some consolidation/renaming in this area.  I
> > > > > > trust that will not be a problem?
> > > > >
> > > > > If it does not break anything, it will be not a problem ;-)
> > > > >
> > > > > It's possible that __add_to_page_cache_locked() can be a global symbol
> > > > > with add_to_page_cache_lru() + add_to_page_cache_locked() being just
> > > > > static/inline wrappers around it.
> > > >
> > > > So what happens to BTF if we change this area entirely?  Your IDs
> > > > sound like some kind of ABI to me, which is extremely scary.
> > >
> > > Is BTF becoming the new tracepoint? That is, random additions of things like:
> > >
> > >    BTF_ID(func,__add_to_page_cache_locked)
> > >
> > > Like was done in commit 1e6c62a882155 ("bpf: Introduce sleepable BPF
> > > programs") without any notification to the maintainers of the
> > > __add_to_page_cache_locked code, will suddenly become an API?
> >
> > huh? what api/abi you're talking about?
>
> If the function __add_to_page_cache_locked were to be removed due to
> the code being rewritten,  would it break any user space? If not, then
> there's nothing to worry about. ;-)

That function is marked with ALLOW_ERROR_INJECTION.
So any script that exercises it via debugfs (or via bpf) will not work.
That's nothing new. Same "breakage" happens with kprobes, etc.
The function was marked with error_inject for a reason though.
The refactoring or renaming of this code ideally should provide a way to do
similar pattern of injecting errors in this code path.
It could be a completely new function, of course.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC54DA11F
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbiCOR3G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiCOR3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 13:29:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD71142
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 10:27:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v14so12108500qta.2
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dR5ednAuivheslMdbA8lSv7LtQURKSYeYic+EaoGiM=;
        b=KzkYQqtRQrG2h9DQbzl9S69dP29Ym/FTat20XRl3lHJ6CbIUEoeND6fpndc0FcXgUh
         ePyYdd7xUuKYn1NSqAi7Lc73xdRg7v3t2vZcTaMhGijbG85YYfG7UyFRMs/QGcmRH+Q8
         YRT64JUCzcHXp1FQAKJszjOf3fWqhFqc+3RV78rDaiv6inKoHZbAwNttUBYkTe/BRDz4
         TVaxgDHrxMksZkaQMcaDKWsl2CrZJkR9PX9Hnw5BhR41T5V+hy8mkuS+OtyC9qY8ghtp
         DKxeeJH9ttzPbuQUHFCT9kgxELydtbRRyvaa3Oznpy7yGmQHp4oHWKhh8KL3ySzHnqPG
         G+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dR5ednAuivheslMdbA8lSv7LtQURKSYeYic+EaoGiM=;
        b=7ThG0aZJ30QV6QZQiZHwWoIrXxvqEI9ZwDaIs9zAi4fQZl7IvuOwnn0IKShdRIE3kJ
         ifl7rdnCopE2+S/nsHro/ZyJLbf75O6q9i30aQzYqJp4ujXY8j0ErMcjrSla7B7zsHqU
         Y6fkTLoXQou7+ZKtOqKefeRm5uTPyfO8xXdvfiEKvdRWLd7WfVdGNPe7pLORTQ9KWkPD
         Ubgi7jZ9kOyqZw9xiF3OvARCZsv44xvXz/JZP9+GmZR0aYgegMlYQgR4wBALvl87VJaR
         u16anT/J92sZ4jFOkEznKiniVfhn3MVT/cJQ/N6MeXfJ6di+a6ZJ2UWjzSLiv26lqyqr
         51ZA==
X-Gm-Message-State: AOAM531GNYFvbvv8MfA3ewVFaMyt7pCTwXO/7vuhhP8R0Qo/hQDaAOuy
        Z2+Hb4mhc+LUkms3VfqR6lzgdx+9YXGmLZAgs11RPw==
X-Google-Smtp-Source: ABdhPJx1++PpaWMWUFpwAInRieMduBGSPX6FQuyqDVX1DvQJlTCYBiCVuK425IpwF7LmCBiVsVrafIxb6cIaekQvmIs=
X-Received: by 2002:ac8:7c4f:0:b0:2e1:a763:da87 with SMTP id
 o15-20020ac87c4f000000b002e1a763da87mr22988918qtv.478.1647365271174; Tue, 15
 Mar 2022 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk> <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
 <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk>
In-Reply-To: <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 15 Mar 2022 10:27:39 -0700
Message-ID: <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 14, 2022 at 4:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Mar 14, 2022 at 10:07:31AM -0700, Hao Luo wrote:
> > Hello Al,
>
> > > In which contexts can those be called?
> > >
> >
> > In a sleepable context. The plan is to introduce a certain tracepoints
> > as sleepable, a program that attaches to sleepable tracepoints is
> > allowed to call these functions. In particular, the first sleepable
> > tracepoint introduced in this patchset is one at the end of
> > cgroup_mkdir(). Do you have any advices?
>
> Yes - don't do it, unless you really want a lot of user-triggerable
> deadlocks.
>
> Pathname resolution is not locking-agnostic.  In particular, you can't
> do it if you are under any ->i_rwsem, whether it's shared or exclusive.
> That includes cgroup_mkdir() callchains.  And if the pathname passed
> to these functions will have you walk through the parent directory,
> you would get screwed (e.g. if the next component happens to be
> inexistent, triggering a lookup, which takes ->i_rwsem shared).

I'm thinking of two options, let's see if either can work out:

Option 1: We can put restrictions on the pathname passed into this
helper. We can explicitly require the parameter dirfd to be in bpffs
(we can verify). In addition, we check pathname to be not containing
any dot or dotdot, so the resolved path will end up inside bpffs,
therefore won't take ->i_rwsem that is in the callchain of
cgroup_mkdir().

Option 2: We can avoid pathname resolution entirely. Like above, we
can adjust the semantics of this helper to be: making an immediate
directory under the dirfd passed in. In particular, like above, we can
enforce the dirfd to be in bpffs and pathname to consist of only
alphabet and numbers. With these restrictions, we call vfs_mkdir() to
create directories.

Being able to mkdir from bpf has useful use cases, let's try to make
it happen even with many limitations.

Thanks!

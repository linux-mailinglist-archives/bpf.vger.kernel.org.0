Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B405A0248
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiHXTuL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHXTuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:50:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CFF6FA21
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:50:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b142so14262194iof.10
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=67HetFVTHgGvVwniBUmcRBQFAPcPJ4hXbIOD6A2xOdQ=;
        b=PLy5hz4MGCrRBCh/6Bn3mQVmr4Z6VgelYYMv4f7EVeIMltq2zDvY7MkwND6d15+8va
         Zf5QUZlTUx2LlWszsTfGl7p2hGfTbkakhJK5rBhtsfeX3eR80LGiLixDnQedwY6RbcGN
         padI/3c04h0PTnI1sP2CTMhu0OlSjRDXNu1nHl/LPRP28/g4AvjW2tSVx9TPL1Pp8E1w
         RwexSXnbgQHNRBnGyZ20lUv4BpOjdwqmlzE8MzQnHDDXO6guF2E/m/lb5bi1eIClVkOE
         tpUpPSaHSfM96DS80j6jk/C0k98in81EmFnlHHUStP/2DcjVTXKYEqxtGXT4+ftiPgKb
         eGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=67HetFVTHgGvVwniBUmcRBQFAPcPJ4hXbIOD6A2xOdQ=;
        b=gIn543SMj5yQ4gGw7V8l8MyUhZGhqrktxkDThthakVHTXe2+5tCxotcNEO8vlWgNR3
         MX2vCZVvUEQNfikpIpDkMKApo/OzuaTRKzlZAO71O3IUE9tHpxhK7NqY0dc6CV2A7qvZ
         ZgtrE5N/kSTkzzEWzGeSboRrc7YLDpdVUh8eoZuu73yiHKxEI9JQO4c7xNs9SIN4qtB1
         +/JGDWswFhw3J10zbxrjDcBpv4sLU9qG6YlpZs7/9ixndBoNZBSmxFqBOjzxKwbE42Tb
         5Gj6gJz9jCa/I137X3PKnYr3KRUkezjHFGi3dHOA31TUPUMmrmtpnxYdHaRjpM7xaiX8
         FvFw==
X-Gm-Message-State: ACgBeo0UuCUd+LU5H6dwlSat+1sLERIFpnaYRI9IWFgwyXOrBisLzaMg
        pq8Bh5KARSS4rZR7TmUzulU4uaTHG5cTtDLa/kM=
X-Google-Smtp-Source: AA6agR5GNMJChj+zdWSqkI+hhJccBHDwi4B5HBeNbQNapq4ho+GX2kqQ0DfKDoW7c6Fe+mRVhVSbpBZ47gvtKC9wh1c=
X-Received: by 2002:a5e:a815:0:b0:688:f11a:6e11 with SMTP id
 c21-20020a5ea815000000b00688f11a6e11mr245674ioa.10.1661370608050; Wed, 24 Aug
 2022 12:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-14-alexei.starovoitov@gmail.com> <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
 <20220819224317.i3mwmr5atdztudtt@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <CAP01T77A1pqYQKeECDSCoxH1pQ1Vxcm84B8_D_r0xoZv_bbq_A@mail.gmail.com> <CAADnVQLXKaNsP7VuGBfnrsNwEZ2BYQYcQ=s3EGS-g6HhM9E1uA@mail.gmail.com>
In-Reply-To: <CAADnVQLXKaNsP7VuGBfnrsNwEZ2BYQYcQ=s3EGS-g6HhM9E1uA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 24 Aug 2022 21:49:30 +0200
Message-ID: <CAP01T76YDGtF0tV6cDvzANW2oyJTGvSVGsT-F-YDozWjg9HnMw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used
 by sleepable bpf programs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Sat, 20 Aug 2022 at 01:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 19, 2022 at 3:56 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 20 Aug 2022 at 00:43, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Aug 20, 2022 at 12:21:46AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > >
> > > > > Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> > > > > Then use call_rcu() to wait for normal progs to finish
> > > > > and finally do free_one() on each element when freeing objects
> > > > > into global memory pool.
> > > > >
> > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > ---
> > > >
> > > > I fear this can make OOM issues very easy to run into, because one
> > > > sleepable prog that sleeps for a long period of time can hold the
> > > > freeing of elements from another sleepable prog which either does not
> > > > sleep often or sleeps for a very short period of time, and has a high
> > > > update frequency. I'm mostly worried that unrelated sleepable programs
> > > > not even using the same map will begin to affect each other.
> > >
> > > 'sleep for long time'? sleepable bpf prog doesn't mean that they can sleep.
> > > sleepable progs can copy_from_user, but they're not allowed to waste time.
> >
> > It is certainly possible to waste time, but indirectly, not through
> > the BPF program itself.
> >
> > If you have userfaultfd enabled (for unpriv users), an unprivileged
> > user can trap a sleepable BPF prog (say LSM) using bpf_copy_from_user
> > for as long as it wants. A similar case can be done using FUSE, IIRC.
> >
> > You can then say it's a problem about unprivileged users being able to
> > use userfaultfd or FUSE, or we could think about fixing
> > bpf_copy_from_user to return -EFAULT for this case, but it is totally
> > possible right now for malicious userspace to extend the tasks trace
> > gp like this for minutes (or even longer) on a system where sleepable
> > BPF programs are using e.g. bpf_copy_from_user.
>
> Well in that sense userfaultfd can keep all sorts of things
> in the kernel from making progress.
> But nothing to do with OOM.
> There is still the max_entries limit.
> The amount of objects in waiting_for_gp is guaranteed to be less
> than full prealloc.

My thinking was that once you hold the GP using uffd, we can assume
you will eventually hit a case where all such maps on the system have
their max_entries exhausted. So yes, it probably won't OOM, but it
would be bad regardless.

I think this just begs instead that uffd (and even FUSE) should not be
available to untrusted processes on the system by default. Both are
used regularly to widen hard to hit race conditions in the kernel.

But anyway, there's no easy way currently to guarantee the lifetime of
elements for the sleepable case while being as low overhead as trace
RCU, so it makes sense to go ahead with this.

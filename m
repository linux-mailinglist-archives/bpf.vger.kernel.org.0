Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92E42A11CE
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 01:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJaACz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 20:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgJaACz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 20:02:55 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FD822245;
        Sat, 31 Oct 2020 00:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604102574;
        bh=XcayW/yJcfpBZonnL860+1oal+jGF2JlNLnO8iX0Adg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gf4UuXuAvIBbtl18fjaZNvFv65PQhSxdu5jKSG5abh4Kc1iVeYGsAvEbcd7zTA+vs
         rckw14QUGGSDXcwPvj4Wd2XMLw+1nd4Yn/uLpQPm9YSKyO18THJi1pPtrZsGJCj9jj
         UjaNr7iKuIasSVZEJL+J6IWmDUG6zS6DnA1JjAGA=
Received: by mail-lf1-f43.google.com with SMTP id l28so9990729lfp.10;
        Fri, 30 Oct 2020 17:02:53 -0700 (PDT)
X-Gm-Message-State: AOAM531hk0EVOpO0YwKYmLs2tTWztjFPR/boh30sNSLMsuDHlTmhjaVM
        c647WHPLEnpP4bIQ/YmxIrJCqsUfabtN7qV+5Z4=
X-Google-Smtp-Source: ABdhPJyMlt+0q1vF2Zy8DUufSjl9eV6bNPhC3X8kZTVnObP+T1whIr7MqwR62B3BcC0HoEIpJ9Yz1rQdL/NL4eOJAEo=
X-Received: by 2002:a19:804d:: with SMTP id b74mr1837998lfd.55.1604102572217;
 Fri, 30 Oct 2020 17:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org> <CAPhsuW6yFbWLGZwpCE4whUm_ncJG4Fr7kf75XeqYLRWG8PvnWQ@mail.gmail.com>
 <CACYkzJ7kbq0Nq71fJCkHSwEmJfKFKOsvRZos_tT64N1f-aT4-A@mail.gmail.com>
In-Reply-To: <CACYkzJ7kbq0Nq71fJCkHSwEmJfKFKOsvRZos_tT64N1f-aT4-A@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 30 Oct 2020 17:02:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4z4b83AeTB_MUWzVWcZxvQ+hdbN9riL77t4j9uBfDdGA@mail.gmail.com>
Message-ID: <CAPhsuW4z4b83AeTB_MUWzVWcZxvQ+hdbN9riL77t4j9uBfDdGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 30, 2020 at 4:07 AM KP Singh <kpsingh@chromium.org> wrote:
>
> "
>
> On Fri, Oct 30, 2020 at 12:28 AM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Oct 28, 2020 at 9:17 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > Similar to bpf_local_storage for sockets and inodes add local storage
> > > for task_struct.
> > >
> > > The life-cycle of storage is managed with the life-cycle of the
> > > task_struct.  i.e. the storage is destroyed along with the owning task
> > > with a callback to the bpf_task_storage_free from the task_free LSM
> > > hook.
> >
> > It looks like task local storage is tightly coupled to LSM. As we discussed,
> > it will be great to use task local storage in tracing programs. Would you
> > like to enable it from the beginning? Alternatively, I guess we can also do
> > follow-up patches.
> >
>
> I would prefer if we do it in follow-up patches.
>
> > >
> > > The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> > > the security blob which are now stackable and can co-exist with other
> > > LSMs.
> > >
> > > The userspace map operations can be done by using a pid fd as a key
> > > passed to the lookup, update and delete operations.
> >
> > While testing task local storage, I noticed a limitation of pid fd:
> >
> > /* Currently, the process identified by
> >  * @pid must be a thread-group leader. This restriction currently exists
> >  * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> >  * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> >  * leaders).
> >  */
> >
> > This could be a problem for some use cases. How about we try to remove
> > this restriction (maybe with a new flag to pidfd_open) as part of this set?
>
> I would appreciate it if we could also do this in a follow-up patch.
>
> I do see that there is a comment in fork.c:
>
>     "CLONE_THREAD is blocked until someone really needs it."
>
> But I don't understand the requirements well enough and would thus prefer
> to do this in a follow-up series.

Sounds good. Let's work on these in follow-up patches.

Thanks,
Song

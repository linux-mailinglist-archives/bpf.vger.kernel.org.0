Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859DA31021E
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 02:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhBEBQf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 20:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhBEBQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 20:16:34 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFBBC0613D6
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 17:15:53 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id m76so5189903ybf.0
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 17:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vuJgR/P2QbPl86wa4YQdQ1porwlhP/v7xEoIpCvw1A=;
        b=hRYvVmYVlbnLoyaDHPT0I95W5lNTfVulV1H2bHfnO6Wu4Z9ZimruDNcr2nZ+StOet5
         jDgqWRHsSQbysUJGUOmAD9+Hgns0jzcMyjs4i97spJE5o9lNLZ9t9KeHlmZffZR0LqYY
         3QUU+SnDVLxolZm3N0dHs5gXYJ6jOfGuwPNFaN6f4BN33FkT2nPp8QlhnBzkpwTS9ECU
         dSLgNGilruZSudVo0imLhmVhopowJRjML+RZQFG+9bc+oP9DUi3PJ00Js9a9uFBe2ZcP
         u6lin5XcZZnxDlYv2ih7k9gW46sCSiQ6uw0JR4k3ksOoEPUOwCrviNzDj2lDzntsbo+N
         5a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vuJgR/P2QbPl86wa4YQdQ1porwlhP/v7xEoIpCvw1A=;
        b=qTFyOCTjvVOlSGhvHmx71n9leRxO+/0Ac7Se5gitlhtJ9q9q3y0rQu7ABk1Amx7YnT
         cQY2aUYx13lH0UwTz37PfzwUjJ63kxHoMD0WhHEA4vZU6l5+2z3AQaBOqbz4NRS/ujA9
         fv1rG6tJYE49YwIC6k8e887iOXxGHnawgmCdjbcBZ6e8TQkMJpQP3GW01qjgz05zjicQ
         3Ky4rJLJbY6lh1F4WLoEB5LnqcDtJ1b2rkMOAoKvZB8xx6oXo5ojEcVnZK7teLryJFfq
         4BUgxYSa48zU7ca8xiW8A57LO35KyiX5eH3NwezgFsl1Etnzk66AjLojJ6rCC5RRqB7K
         U0lA==
X-Gm-Message-State: AOAM532bvoGWHyD6d8KEu6JXiAyybU/UVWCNbvIJZrSKtXv0j5Tq0+53
        DJ7hU8vyoe6PLHtZTZsn7WAvqm3y44Tp171I7kQ=
X-Google-Smtp-Source: ABdhPJz/ULu2izH4ySSstEHa2T+YAbdwbF5K5W3stzkH4XnTBIQPpeX9LKJG9QAGUXCnGCh0WFDToKzD0l2acLb8068=
X-Received: by 2002:a25:d844:: with SMTP id p65mr2673328ybg.27.1612487753004;
 Thu, 04 Feb 2021 17:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20210204193622.3367275-1-kpsingh@kernel.org> <20210204193622.3367275-2-kpsingh@kernel.org>
 <CAPhsuW7faA0t+VjrzDcxv0mmvB7FVDVeKyfgU+P7N5Uz+S=98A@mail.gmail.com>
In-Reply-To: <CAPhsuW7faA0t+VjrzDcxv0mmvB7FVDVeKyfgU+P7N5Uz+S=98A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 17:15:42 -0800
Message-ID: <CAEf4Bza_E+wbfgzCVYvR9VKxUkspyshas7wXi0Gf5ZfDZvODdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow usage of BPF ringbuffer in
 sleepable programs
To:     Song Liu <song@kernel.org>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 12:57 PM Song Liu <song@kernel.org> wrote:
>
> On Thu, Feb 4, 2021 at 11:39 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > The BPF ringbuffer map is pre-allocated and the implementation logic
> > does not rely on disabling preemption or per-cpu data structures. Using
> > the BPF ringbuffer sleepable LSM and tracing programs does not trigger
> > any warnings with DEBUG_ATOMIC_SLEEP, DEBUG_PREEMPT,
> > PROVE_RCU and PROVE_LOCKING and LOCKDEP enabled.
> >
> > This allows helpers like bpf_copy_from_user and bpf_ima_inode_hash to
> > write to the BPF ring buffer from sleepable BPF programs.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5e09632efddb..4c33b4840438 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10024,6 +10024,8 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >                                 return -EINVAL;
> >                         }
> >                         break;
> > +               case BPF_MAP_TYPE_RINGBUF:
> > +                       break;
> >                 default:
> >                         verbose(env,
> >                                 "Sleepable programs can only use array and hash maps\n");
>
> Shall we update this message?
>

I fixed it up while applying. Thanks for staying alert!

> Thanks,
> Song
>
> > --
> > 2.30.0.365.g02bc693789-goog
> >

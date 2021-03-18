Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37537340CC9
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhCRST1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCRSTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 14:19:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE72C06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 11:19:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u5so5447662ejn.8
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sse64bqIOWwkx9kqYUy4ajU7Bzc2Pb4HNGntqpA0mM=;
        b=1WNUJrDfvEhcj70yijsJeUt9Yq8eCTCc2Xlu19qqYJiwqfU18DiPMLx1LVkoxxkDhh
         NtJMzw/0gCG2gAfazKZktFJTCyOZaj4gV1+R5WiMhF4ggQG3NDbwQ9th9mqNHmam56nw
         6TC5HQcry7vhch0Nh1tXa70Z7QLJ7XJ+ocYeTLhspTTOBtKz+3tmyky/BcAhO9OL1RVD
         qP4VrSOyIP/wnSHzeA4o8TJjFinF6WSvyr5qON1JKvWpLGq9FqZwM2kQJa8dkTcrDxpD
         xtQsKpv1xgFbGdfYwjJ0aHt/y+T6Gs8gul6AVt+5t7yu/mEbXWCUTqknt6NZPSP5VBRZ
         ko4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sse64bqIOWwkx9kqYUy4ajU7Bzc2Pb4HNGntqpA0mM=;
        b=cPCED03UX7HCQJmeS4ybeFkR2/HAJNw9rYY9ajNypmHnOWIO775xlO0deSIN7f8o0z
         dmWOheIKUO9KsvwHL5/xu76ieAeoMwGFR9V1GpluLlLBexxEeTZ5a9rGbfjT2L+qgu9V
         VZvAHAzIDPcSn/Ml0B3q/EBDGdRp1qbGlLdDoC5wGkHJZ/D7ticjlwmSA68UnWwY6Q3m
         Rvz56KakgTRXZtHe/nCa7fxCyQDSzu7cS2Mcl/ScNbajuYFgVT7cO7BjUSrPMyb4CyU3
         gNLwrw6Eg+MZW4qBT+MARtJ/7p7Kfp19qg003Ur7mXd1ydTfZqyMjG3CIWjXArD2TWU1
         y0kw==
X-Gm-Message-State: AOAM530D97nd0U2RAp4JfMqENRDuBiaPQGtyJN0J5rkLiXoYzZFHKYpW
        cDPmqkNlWKnRcc1e5QGxYincBySccT6flyO6Ty6K
X-Google-Smtp-Source: ABdhPJz3ZhyPn56X7wMia/HfV+uHSUf5OdJlPqCXRQwY+sZNLIXnrBAWLfGC9myUp3XOXqFIONy9n0/+0d2i9slNCo0=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr41708535ejf.488.1616091557890;
 Thu, 18 Mar 2021 11:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <2ed7a55e-7def-7faf-fc47-991b867bff9e@iogearbox.net>
 <CANYvDQOfygmqv0V-1PuzXV8ZFzk0uD566oEF3v9uX21G4fSFKg@mail.gmail.com>
 <1e410caf-019a-ade7-465d-3d936d2f7dc6@iogearbox.net> <5845cef9-5aaf-f85e-8280-472f61ddaeed@iogearbox.net>
 <CANYvDQNCKmEy9ZzPRvhNYvK0=TKk1pRS=seUuAkby92ic8tVqw@mail.gmail.com>
 <f97bd923-bf12-69a0-f0a8-c9a764abbed2@iogearbox.net> <YFIwzhE00OpU1zro@krava>
 <ff0db44e-aa55-da94-785f-ba10792a5ae1@iogearbox.net> <YFKOeGqUwBPTkPzT@krava>
 <61494cfb-1ceb-4886-3023-1ac0b35697d6@iogearbox.net> <YFM+Ijeu4bN4IzH1@krava>
 <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com>
 <CANYvDQOH5ZDpQBAHtz13YNiJ2Bhd56wnoas71UdYco62g-xBDg@mail.gmail.com>
 <CAHC9VhRMsWJmRr=OZ7FSj2sBmNRJHKNGMPv5nLY6RGX_dxroPA@mail.gmail.com> <CAHC9VhQQ48yDLWObTjO0Su6mQ2R0QgAWqnuWCb2cZC5qUp_Fqg@mail.gmail.com>
In-Reply-To: <CAHC9VhQQ48yDLWObTjO0Su6mQ2R0QgAWqnuWCb2cZC5qUp_Fqg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 14:19:05 -0400
Message-ID: <CAHC9VhTD3+-tvC2Nxj0bpmcK2SaS50wUQmKtqQ1FSPcO1a-P3A@mail.gmail.com>
Subject: Re: deadlock bug related to bpf,audit subsystems
To:     Serhei Makarov <smakarov@redhat.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Jerome Marchand <jmarchan@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        Frank Eigler <fche@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        guro@fb.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 1:45 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 18, 2021 at 1:44 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Mar 18, 2021 at 12:57 PM Serhei Makarov <smakarov@redhat.com> wrote:
> > > On Thu, Mar 18, 2021 at 10:43 AM Serhei Makarov <smakarov@redhat.com> wrote:
> > > > Jiri Olsa also reports seeing a similar deadlock at v5.10. I'm in the
> > > > middle of double-checking my bisection which ended up at a
> > > > seemingly-unrelated commit [2]
> > > >
> > > > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1938312
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=2dcb3964544177c51853a210b6ad400de78ef17d
> > >
> > > I've confirmed that my first bisection was incorrect by testing
> > > @1c2f67308af4 mm: thp: fix MADV_REMOVE deadlock on shmem THP
> > > and reproducing the deadlock. Previously this commit was marked as
> > > good, so it seems a kernel with the bug can sometimes pass the test.
> > >
> > > I'll double check rc6 next since I have the kernel handy. If
> > > 5.11.0-rc6 can also be made to fail, with Jiri Olsa's report it'd be
> > > necessary to do a wider search.
> > > There may be commits with intent similar to
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d92db5c04d103
> > > which tightened some of the behaviour of kernel reads, but affecting
> > > the audit subsystem?
> > > The actual stack trace that leads to deadlock goes through
> > > security_locked_down() which was present since the original patch
> > > reworking probe_read into separate probe_read_{user,kernel} helpers
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=6ae08ae3dea2
> >
> > Added thee SELinux list to the To/CC line; they should really be
> > involved.  I'm also CC'ing the LSM list for good measure as there may
> > be other people that care about this.
>
> Argh, hit send a bit too quickly :/
>
> > FYI, the first instance of this thread that I saw can be found here
> > via the linux-audit list:
> >
> > https://lore.kernel.org/linux-audit/CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com/

Previously in the thread there was a question about why audit events
are being generated inside bpf_probe_read_compat(); the answer is
pretty simple, we do an access check in the security_locked_down()
hook, inside the call to bpf_probe_read_kernel_common(), and that can
result in an audit event depending on the LSM and it's policy.
Skipping the audit event in the case of a LSM access denial, e.g. a
SELinux AVC denial, could result in a silent access denial which can
be maddening both to users and admins.

-- 
paul moore
www.paul-moore.com

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2C340C0A
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCRRob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCRRo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:44:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F36C06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:44:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b9so5289755ejc.11
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qU1aub0/jj/+qJtgvXqKzP6GZJ9Mncd2OEdNT9QZSDo=;
        b=BlBLerF6ZwQogZ9DS4YCh3oE2SOMLxuLlwWxOvc1HpJpbirUfn0ehCT7oFh65jZpGw
         L2NWhcWUnNXtjRuXTfDy3M2saZ9FPatFZrtJw5+QbYm3ZWDCtotfAflD+D/R7QtvU+sn
         iffMoj0kEx968u5rhCNwilLFJ1SVwpY1j1y6ZbKqm+OKLrOKwX+jhxsTu+Z2hyRwfNpf
         gY0si2yTRFIhOf4mm7pdmBF+8G8710hJ6bvRiOaIkt9l7JfzRKPu6xwMfyV0GqomFRuV
         jA2nC7o5PWOB0tWYh8mcxKsluDOEDwt4DUkXOSjWqGo5B6PGgUpEOsLgjnXN9sR4ZsxE
         tpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qU1aub0/jj/+qJtgvXqKzP6GZJ9Mncd2OEdNT9QZSDo=;
        b=M4aFEzxGpftI0QWK6ahx9YNW3902e5Nquamw71XAM8SehDJSW8x22qiNtXBvpTtaQr
         /+mfZw4Gyqui9hiIcT4JqP4Y6nuYhBm1xRFQzveSyCAf4x/aSRABiPUFzQ8dC4Gi7eqb
         sbq0qyjghHJtvS7aTVXSnYWLXnrxSaBlrDgJQps1i1Z10P52+lMMk62BfE0afNo7P/hI
         eTju+WEXq/R4CD0GZ9RX3ux+oL6qbZzalCN4/LUitiiw4P/m7wKsH7IFslKFA9oKjaUd
         6pSEB0g6+yqPCYLfNFI6kkeOyT9wFDsAMUIILMqWdUgA3mgJQwDbEjToSfJWI/L2JbsU
         REYw==
X-Gm-Message-State: AOAM532k7+v18kmgpIoKljyQYrD77VQVmhXncbdBpTknS4peTjblCZTD
        we7ADtCUNECSQogIQiUcUQK0a2BDUglbqudbkGZ9
X-Google-Smtp-Source: ABdhPJwPWNcgnTRsosElvQoIKogEpbe3lSGJ5tmxa6D3WGDmH/m/+olCJtP/t5WzyO3NNwbARO28cBcRNdrntraV1mI=
X-Received: by 2002:a17:906:edca:: with SMTP id sb10mr25272305ejb.398.1616089467599;
 Thu, 18 Mar 2021 10:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <2ed7a55e-7def-7faf-fc47-991b867bff9e@iogearbox.net>
 <CANYvDQOfygmqv0V-1PuzXV8ZFzk0uD566oEF3v9uX21G4fSFKg@mail.gmail.com>
 <1e410caf-019a-ade7-465d-3d936d2f7dc6@iogearbox.net> <5845cef9-5aaf-f85e-8280-472f61ddaeed@iogearbox.net>
 <CANYvDQNCKmEy9ZzPRvhNYvK0=TKk1pRS=seUuAkby92ic8tVqw@mail.gmail.com>
 <f97bd923-bf12-69a0-f0a8-c9a764abbed2@iogearbox.net> <YFIwzhE00OpU1zro@krava>
 <ff0db44e-aa55-da94-785f-ba10792a5ae1@iogearbox.net> <YFKOeGqUwBPTkPzT@krava>
 <61494cfb-1ceb-4886-3023-1ac0b35697d6@iogearbox.net> <YFM+Ijeu4bN4IzH1@krava>
 <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com> <CANYvDQOH5ZDpQBAHtz13YNiJ2Bhd56wnoas71UdYco62g-xBDg@mail.gmail.com>
In-Reply-To: <CANYvDQOH5ZDpQBAHtz13YNiJ2Bhd56wnoas71UdYco62g-xBDg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 13:44:16 -0400
Message-ID: <CAHC9VhRMsWJmRr=OZ7FSj2sBmNRJHKNGMPv5nLY6RGX_dxroPA@mail.gmail.com>
Subject: Re: deadlock bug related to bpf,audit subsystems
To:     Serhei Makarov <smakarov@redhat.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Jerome Marchand <jmarchan@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        Frank Eigler <fche@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        guro@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 12:57 PM Serhei Makarov <smakarov@redhat.com> wrote:
> On Thu, Mar 18, 2021 at 10:43 AM Serhei Makarov <smakarov@redhat.com> wrote:
> > Jiri Olsa also reports seeing a similar deadlock at v5.10. I'm in the
> > middle of double-checking my bisection which ended up at a
> > seemingly-unrelated commit [2]
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1938312
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=2dcb3964544177c51853a210b6ad400de78ef17d
>
> I've confirmed that my first bisection was incorrect by testing
> @1c2f67308af4 mm: thp: fix MADV_REMOVE deadlock on shmem THP
> and reproducing the deadlock. Previously this commit was marked as
> good, so it seems a kernel with the bug can sometimes pass the test.
>
> I'll double check rc6 next since I have the kernel handy. If
> 5.11.0-rc6 can also be made to fail, with Jiri Olsa's report it'd be
> necessary to do a wider search.
> There may be commits with intent similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d92db5c04d103
> which tightened some of the behaviour of kernel reads, but affecting
> the audit subsystem?
> The actual stack trace that leads to deadlock goes through
> security_locked_down() which was present since the original patch
> reworking probe_read into separate probe_read_{user,kernel} helpers
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=6ae08ae3dea2

Added thee SELinux list to the To/CC line; they should really be
involved.  I'm also CC'ing the LSM list for good measure as there may
be other people that care about this.

FYI, the first instance of this thread that I saw can be found here
via the linux-audit list:

https://lore.kernel.org/linux-audit/CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com/

-- 
paul moore
www.paul-moore.com

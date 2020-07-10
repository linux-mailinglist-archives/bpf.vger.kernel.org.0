Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9345021BEBB
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 22:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJUrs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 16:47:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8933AC08C5DC
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 13:47:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q198so6630524qka.2
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmFhT5YJS2BvLLS2Yiuq0X86CgA2uNKdbH9GMkWSN4I=;
        b=CEInXCrgI8E96N7NzclHeURL9Cf1aTCe0iHnDxbAQ+GVZMyqHyiTp8cNX9FMQoFiNX
         GjA8cxakVe7bZcgJCVmmFHRZS3B1LNVHnVuPWk2D3HQHjLXyrQ/vJxJa9Q9gY6EdukPz
         q8LRR/9pJCnX91eRrDeSOCsndM107OTRtrY5QGyAQsURMsMHY+ifTrQBTRh5R6Ti25GM
         91+QpbHqUsPmQTNWFPJAp3NONGFYdFgfdvyHr0rYj+eh946FXLaEcjvUxSLskreyv/WN
         3C3S0Gt1enYOgVQPvYlcUsEM9zJKLOMk4JMekyfp2kKWZEoae7KBStkhjD3t+C8Zv1jE
         FmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmFhT5YJS2BvLLS2Yiuq0X86CgA2uNKdbH9GMkWSN4I=;
        b=Df0BHMEcAFrt3ZI+tz/unvGd4wguLej2HU27ekNXQOQH13UvEuC40JC16iFUsot7+C
         F4JEUlR1RqutdZMLet+G2kUbibPWrOK8Lkj16xSEZN7aNZn+qFsEriruqnjRDp5gyoVo
         BtyTURoHwAFT8NhnsL6Gmg3QB+hN2P88ulVAGIFNLId6zAG4JnuYxTPX8nUwxiz/gdZA
         EgQ4cwJ6Zn234VrV44rDExqlBX2lExxBlFTOPpa68nW5QuVngXOu5bX3gLqFpre7KMV1
         AkhJRITc3S4YIpM7kPyWxxLO0O0H/sVs7ykHv1hz9JBbcRYICZxLQfh9b5HotfBwAvZX
         ejAA==
X-Gm-Message-State: AOAM532k0pfemUrlDdFi4qLzl9/r3VgSYGVzLXtqGSiA9YgDEoih9IBw
        uXpve0DgFqX5aizaZaiSFqHDcHgW4GpDpw/Rqro=
X-Google-Smtp-Source: ABdhPJytAnp6Hzdp4r8PGVBfdn/hmVRzaaqrinthaIZd3waRTZ+fa84vf98ZBrjMZvowZpZ3SMWn0QH6IT9W5TikvQk=
X-Received: by 2002:a05:620a:2409:: with SMTP id d9mr72851439qkn.36.1594414066768;
 Fri, 10 Jul 2020 13:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzY0-bVNHmCkMFPgObs=isUAyg-dFzGDY7QWYkmm7rmTSg@mail.gmail.com>
 <20200710202056.GA184844@google.com>
In-Reply-To: <20200710202056.GA184844@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Jul 2020 13:47:35 -0700
Message-ID: <CAEf4BzZ9FdU84xYm_MOjxFAo3=JMbPMEbyLkeuUceHZ4FsGfNA@mail.gmail.com>
Subject: Re: Occasionally hanging sockopts selftests
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 10, 2020 at 1:20 PM <sdf@google.com> wrote:
>
> On 07/10, Andrii Nakryiko wrote:
> > Hey Stanislav,
>
> > I've noticed that on 5.5 kernel libbpf Travis CI test runs
> > occasionally fail due to selftests hanging indefinitely. It seems like
> > it always happens after sockopt tests succeed, and while
> > sockopt_inherit test is running. Doesn't seem like the latest kernel
> > is affected (I haven't found hangs for the latest kernel in recent
> > history).
>
> > This is the latest version of selftests, but running on an older (5.5)
> > version of kernel. So whatever fixes went into selftests are there
> > already. So I wonder if there were any kernel bugs that were fixed
> > already but could cause hangs on 5.5?
>
> > I can disable that specific test for 5.5, but though I should bring
> > this up first, just in case there are still some bugs in selftests.
>
> > Thanks for checking!
>
> > Two most recent failures (not that they are helpful, because there is
> > no output until tests completes, but still):
>
> >    - https://travis-ci.com/github/libbpf/libbpf/jobs/359067538
> >    - https://travis-ci.com/github/libbpf/libbpf/jobs/359784775
> Nothing pops up, I don't think we did any fixes to address any
> occasional failles like that.
>
> The only fixes we did are:
> d8fe449a9c51 - bpf: Don't return EINVAL from {get,set}sockopt when optlen >
> PAGE_SIZE
> 9babe825da76 - bpf: always allocate at least 16 bytes for setsockopt hook
>
> And I don't see how this test can hang without any of those (should
> either always pass or fail).
>
> Let's maybe try to disable it, as you suggested, and see if that's

I'm pretty sure it's sockopt_inherit, because I compared what's the
next test after sockopt in the normal case. So there is no doubt at
which test it hangs, but why is a different matter. I'll leave it
enabled for now, it doesn't fail very often, so it's ok.

> indeed this sockopt_inherit test that's misbehaving?
> I can try to find some time next week to reproduce.

Thanks!

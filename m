Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7193980D7
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 07:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFBGAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 02:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhFBGAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 02:00:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6012C061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 22:58:59 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 207so2262425ybd.1
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnRIbHdk0oRSirfKsqqeGT8yjQJ+vkuV85ZTm77ZK64=;
        b=dR48B2Ery5uP49EuxsQIn27u4OzM0IPoGFSZX/vxzRz7AiGwKg1awAobqGGkGngV3N
         sqxR3sBKSW6Lrk1SU6Xd+OWgHZTMPHBEAcvS0bvBHQGyqbbUCqvKQIOopIqVx4wM5/uE
         1h5LTdk0x802N9yFOF64WBwDDgMcTJQggJ6F6RdE3qQQPjaWkQb9a0IkrDLBgoFmz9oZ
         2EHvfTkSx0NaGBc4O2f9lxYS2BCFJHY45XUxKCOgItI25+CgiCkzNZ4bfp0YEmPNz7dF
         SOYkXx92D60n65DPCP6a91+9umIrvAxW1uVTkbXU8QIP0q+lHdZxYJR+Y9qDYYrHbxz2
         ZrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnRIbHdk0oRSirfKsqqeGT8yjQJ+vkuV85ZTm77ZK64=;
        b=e0UpCbfuCH1UUJrob5v0DSRQUDZibvVHE28hyxTuQg5wfmxQGbxuerMQCvyASmi2zr
         118rHfp7zDMXLaF1Q69/8t1VrruMvTX8aIlhkpKjKGATHjt9QW2R4h1AFDU1CBHUv5oM
         J8etd4eCbvxGDDDo9ABWtCjrJjR3vJFyKqo7TiUTvE/t4F8hmb/hnlPXlm5d1082xzbx
         AW2w+7RQa7DJ5d7lIKwpiLoz5DU1i7xHknooQYjw0QqoJEDAT306zomYEmX96BeQ3X7W
         seQE4UuU2xpqqLoLQzIbC84mZacJeIFNaTV67KJnFCasjr7ZvhvbG/71SZ+tpAGwufgU
         e3Tg==
X-Gm-Message-State: AOAM532yDcys0j4Cgiy+/OPfo5daqVRkkLZ9xdVfscYbYz1jybH6WzMg
        CyG4+3BRx/cqHk1lKu5GERy1awZGthRrv2vME+FUvyTz
X-Google-Smtp-Source: ABdhPJw/AF7rrdsAT86qEDv9E2NfUYEatixRKjxVQSxUWf4F4VEhPqx6wh3sc9aV2HeTZjrCeOCHbtsgB5JBmMXkLvU=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr43806953ybr.425.1622613538618;
 Tue, 01 Jun 2021 22:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ+jJs7-HtjVLzcevmGf78PHxEsrk66FwKvy6FCsiU=nQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+jJs7-HtjVLzcevmGf78PHxEsrk66FwKvy6FCsiU=nQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Jun 2021 22:58:47 -0700
Message-ID: <CAEf4BzYQ5_b=G31=tUk36gLp+q2Q8m98EERv4ThyhYvzDzFdfw@mail.gmail.com>
Subject: Re: libbpf: the road to v1.0
To:     bpf <bpf@vger.kernel.org>
Cc:     Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 11:44 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Hi all,
>
> So I've been ruminating on getting libbpf to 1.0 version for a while
> now and finally got to write down most of the major (and not so much)
> things I wanted to change and/or break, given v1.0 gives an
> opportunity to break API/ABI compatibility, where necessary.
>
> I decided to share this with the community in the form of a Google Doc
> (check [0]), open to commenting by anyone, because there are many
> different things, quite often completely independent from each other.
> So email doesn't feel like the right medium to have a discussion given
> the amount of people that might be interested about just pieces of the
> plan.
>
> The overarching idea is to streamline APIs, make them overall more
> consistent throughout, as well as eliminate some very common pitfalls.
> Any such changes means potentially more pain for existing users during
> the transition period. I realize that, but I hope everyone will keep
> in mind the longer term goal of making libbpf easier to use both for
> the new and existing users.
>
> My intent is to spend some time in discussions and see what I have
> missed and what would be argued to be too drastic/problematic. So the
> plan is not set in stone and can/will be adjusted (within reason, of
> course, I don't believe everyone is going to converge and be happy
> about all the changes, but that's OK). But once decided on the plan, I
> (and hopefully others will help) will start implementing changes, will
> probably create a wiki page documenting API migration paths, etc, etc.
> My current thinking is to do a gradual transition, rather than a big
> bang breaking change in 1.0 release. This should give people more time
> to find any possible breakages and adopt their code base gradually, so
> that by the 1.0 time there isn't much surprise left. But feel free to
> argue the other way.
>
> BTW, that document is only describing potentially breaking changes, it
> doesn't mean libbpf won't get any other new functionality. I still
> plan a bunch of other (new) features to be added before v1.0. E.g.,
> stuff like BPF static linking support (merging together multiple BPF
> .o files) and declarative PROG_ARRAY map initialization pops to mind
> immediately.
>
> So, please check the document, leave comments, make yourself aware of
> upcoming changes. Thank you!
>
>   [0] https://docs.google.com/document/d/1UyjTZuPFWiPFyKk1tV5an11_iaRuec6U-ZESZ54nNTY/edit?usp=sharing
>

Ok, so a bunch of time passed since this email and I have a few
updates and calls to actions.

The above Google doc was transformed into a wiki page ([0]) almost
intact. That should make linking to various sections a bit easier, and
it lives next to libbpf source code on Github.

I've also created a lot of Github issues (42, I believe) for each part
of libbpf 1.0 plan. Those issues are cross-linked from the above
mentioned wiki page. See all the libbpf 1.0-related issues at [1]. If
anyone would like to contribute and help, please check those (and
other, see below) issues, assign them to yourself or just comment on
the issue that you are interested, and start working on the parts of
libbpf 1.0 plan. A good chunk of those issues are marked with "good
first issue" tag and should be a good place to start for those willing
to contribute but are hesitant and/or new to libbpf.

That's not all, though. The first set of changes towards libbpf 1.0
went in recently ([2]) changing and streamlining libbpf API error
returning behaviors. That patch set also introduced a new
libbpf_set_strict_mode() API allowing to have a fine-grained control
over backwards-breaking changes and "simulate" a new libbpf 1.0
behavior. This should give users a way to test and adopt their code
ahead of final libbpf 1.0 release. Furthermore, I've started a "Libbpf
migration guide" wiki ([3]) that is designed to have (relatively)
short instructions on how to adopt pre-libbpf 1.0 code that might
break into libbpf 1.0-compatible code. Often proposed code patterns
will handle both libbpf modes transparently. This migration guide is
supposed to be updated and extended as we deprecate more APIs and/or
implement all the other previously laid out breaking changes. For
deprecated APIs we'll just directly link to specific sections of that
wiki from the LIBBPF_DEPRECATED() annotations.

And last but not least. Since we started utilizing Github issues for
tracking various tasks and features, I've created a few issues for
features and work to be done (help with CI, anyone?) that I had on my
mind for some time. I tried to leave a bit more details, but if you
are eager to help with them and need more info then feel free to
comment on the specific issue and I'll try to elaborate some more. You
can see a pretty short list of those at [4].

  [0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0
  [1] https://github.com/libbpf/libbpf/issues?q=is%3Aissue+is%3Aopen+label%3Alibbpf-1.0
  [2] https://patchwork.kernel.org/project/netdevbpf/list/?series=487853&state=*
  [3] https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide
  [4] https://github.com/libbpf/libbpf/issues?q=is%3Aissue+is%3Aopen+-label%3Alibbpf-1.0

> -- Andrii

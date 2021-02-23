Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1EF32234E
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 01:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBWAyE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 19:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBWAyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 19:54:03 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F9C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 16:53:23 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id f4so14799111ybk.11
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 16:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzfvTmJd82Sdz6bHiF0nKCH4Jfo/+Y/2USudU6z+2R0=;
        b=XouYYqPNr9mJtPcxuApcQcP4/BJ0oy1qUPZ37C0UByMEoJNxCAWPSfTOftZePSxDy3
         815Fq9U6XLhs17hkHorGj01hPx719RuEYb4knQ27k80nkaw3bxaFAoDkNsaBehtvUJ3V
         WOE88w6R93HAoC9ZG/1dJI8SpTH2eAF70YlxGt4PYvMZ97INEwPLkq9DybtXm16649+L
         Juk1a6fGqNw0n6g7X+Mxqo/k9t4HJiq4Gp7QIjvtGufh0Ztlun3ctnj9JsjxRIhinH1o
         91mc63hEUauS+/z+zYF10gS+/5hFQG9WKzprkrCTgZQZ3VpexHQuKnZ8jSDFDiN4jvZ8
         d3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzfvTmJd82Sdz6bHiF0nKCH4Jfo/+Y/2USudU6z+2R0=;
        b=hjEg8EKhkJP3/X5tm6VoA11BHyJto0NpIMGZin6ET2/WbhploBPSjoNIuGqPSMnNbk
         z1JUT33nErbnosIbdOV4MELlbRh8C8PpNxz04Hme5ZT0TeV8LEyW6pm4xxJx29ALOLyU
         reSFhaXz/ZgUrYfADunsz5cM5Agze+h9CxRBl5myqJ6RjC5RNyb4T4xFZMP8G9vPJFd9
         3euzSZNhsL0zJhmxeJAhuGKcuFKQYA/cPpfeFff9n9f9N+5uRrGMzJuCwITstWztOpyy
         rcRWut0kvGK/NGpyeuOcu1qXBvkIYMllRGpfyfRAOShMFGVLNTOQLfjss8/U/VLtP60H
         USqA==
X-Gm-Message-State: AOAM533azqoTwRlpC0D20qfQl+mAw2jwj6kZfFZ9Sl3pMQ8kiHH6zfAy
        PcrCnR4z42J1IeU+GXFr3X+7vfRQbhL9xTNkU7cF2M3Y
X-Google-Smtp-Source: ABdhPJz49bF3BORgmz6iQbCEMzjlmOT4qAXUZtGn0lohpGEub3qOMgaaUjQd914VwPIMfCywKeSGPWez++R1ri2MUus=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr5240734yba.510.1614041602845;
 Mon, 22 Feb 2021 16:53:22 -0800 (PST)
MIME-Version: 1.0
References: <YBGe5WFzSc3Z8Oh5@gmail.com> <CAEf4Bzab4fZm04xR+3DYEHNaxAoaNM+hZFdYWGJ_qk1fNyAitQ@mail.gmail.com>
 <YCwIMN3btcpQbIxZ@gmail.com>
In-Reply-To: <YCwIMN3btcpQbIxZ@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Feb 2021 16:53:12 -0800
Message-ID: <CAEf4BzbckC2K29OWp=e7+oJd7U+NPszOkd=pp2RawOVC8SK0Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add lookup_and_delete_elem support to hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 16, 2021 at 10:00 AM Denis Salopek <denis.salopek@sartura.hr> wrote:
>
> On Mon, Feb 08, 2021 at 09:44:59PM -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 27, 2021 at 9:15 AM Denis Salopek <denis.salopek@sartura.hr> wrote:
> > >
> > > Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> > > hashtab maps, in addition to stacks and queues.
> > > Create a new hashtab bpf_map_ops function that does lookup and deletion
> > > of the element under the same bucket lock and add the created map_ops to
> > > bpf.h.
> > > Add the appropriate test case to 'maps' selftests.
> > >
> > > Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> > > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > > ---
> >
> > I think this patch somehow got lost, even though it seems like a good
> > addition. I'd recommend rebasing and re-submitting to let people take
> > a fresh look at this.
> >
> > It would also be nice to have a test_progs test added, not just
> > test_maps. I'd also look at supporting lookup_and_delete for other
> > kinds of hash maps (LRU, per-CPU), so that the support is more
> > complete. Thanks!
> >
>
> Hi Andrii,
>
> I'll also implement the LRU and per-CPU ones and resubmit. I don't quite
> understand the test_progs, what kind of test(s) exactly should I add there?

test_progs is our preferred test runner. It's a collection of
independent tests (sometimes including subtests). See any of the
recently added tests to get a feel for it. test_progs' tests resemble
real-world applications much closer than test_verifier or test_maps
tests, so it serves both as a readable test and as an API demo.

>
> Denis
>
> > >  include/linux/bpf.h                     |  1 +
> > >  kernel/bpf/hashtab.c                    | 38 +++++++++++++++++++++++++
> > >  kernel/bpf/syscall.c                    |  9 ++++++
> > >  tools/testing/selftests/bpf/test_maps.c |  7 +++++
> > >  4 files changed, 55 insertions(+)
> > >
> >
> > [...]

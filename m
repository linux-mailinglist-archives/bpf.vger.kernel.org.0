Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42C21BE65
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJUU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 16:20:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC2C08C5DC
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 13:20:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d27so8497654ybe.20
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CCfVk47cKFyn5A7kSIRBR/MSG0dqmh+4caIuYgMADCE=;
        b=Gh+opm5uBDlogGnNxbr3R+dFOcm2dfawQS+Zcs+sV2i3ShlyhC6RqL/2PTxEZKikym
         a+dNeJXm2+glFOZkKgjMKhOv6kizFoIXhgy5kwJuAqDBfhoZj12EVBGKK3iw3QOOm2rk
         3QpnBeo67Nc7/P75jFjdjppCxF03kIyVu8NSpv+O6WplZcYKBxftgtL9pIG0SAqgjk6M
         L8MmZdFOPxPibJLIy9kd4ehw+/Bzu32IYKgKtMDQ8Nq+zyJl7vQzkzPNYlUaV4GD+He6
         Hzk5tyDMKq+4yaiqYyuE5pZTv9QZIoYMC/gi9YGKrXWawDPESSNjtaT/A8JggByQk3F+
         m3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CCfVk47cKFyn5A7kSIRBR/MSG0dqmh+4caIuYgMADCE=;
        b=LGqgxEeofDMDFzNhCdbK6cgskhLzGfOTy3OmQFJBqA3M7H5qjT4BP0Zx1WCdSrzYxj
         5npDTyQUcLhl1NQn5TY0Ld6iMWdd6BqMUuRLhY17jSHbtfwUENoEiVqvuMqzK9zNrwci
         yK7tGVOAKqhZ2uMYu1WtGSskUjH3VeqIG0jvK+MxHh0SjGXLdb1pxv52nMEeYIZVjR3u
         bR6JEtwFAcfAdeBJV/OTkd4U4FJbx/+yKswZvjWQsky8SAAUVOkwQYvhoLabxF3xdBfj
         tEftgownboG2BSusXyAI2nnsI4S+fBmQDx0cuJGfvwlOuDXy7CJzpB6SKUJlTaL6E/5E
         3oDQ==
X-Gm-Message-State: AOAM530zvKCJYkp4l2wuiAxbb8v7bDeWWvznh8PnzVULx6Ldn5FC1p2Q
        uQ2g9E/EHZOuFJz+81dsNVj4RVg=
X-Google-Smtp-Source: ABdhPJyq0f/0ap3e6q+tJUZYqlfYpnW1KIpvVCRlZd1e4ndXoOdgn8UTMuX9vjHi6FmgEFD/6W6QjDk=
X-Received: by 2002:a25:d4d6:: with SMTP id m205mr17904366ybf.390.1594412458376;
 Fri, 10 Jul 2020 13:20:58 -0700 (PDT)
Date:   Fri, 10 Jul 2020 13:20:56 -0700
In-Reply-To: <CAEf4BzY0-bVNHmCkMFPgObs=isUAyg-dFzGDY7QWYkmm7rmTSg@mail.gmail.com>
Message-Id: <20200710202056.GA184844@google.com>
Mime-Version: 1.0
References: <CAEf4BzY0-bVNHmCkMFPgObs=isUAyg-dFzGDY7QWYkmm7rmTSg@mail.gmail.com>
Subject: Re: Occasionally hanging sockopts selftests
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/10, Andrii Nakryiko wrote:
> Hey Stanislav,

> I've noticed that on 5.5 kernel libbpf Travis CI test runs
> occasionally fail due to selftests hanging indefinitely. It seems like
> it always happens after sockopt tests succeed, and while
> sockopt_inherit test is running. Doesn't seem like the latest kernel
> is affected (I haven't found hangs for the latest kernel in recent
> history).

> This is the latest version of selftests, but running on an older (5.5)
> version of kernel. So whatever fixes went into selftests are there
> already. So I wonder if there were any kernel bugs that were fixed
> already but could cause hangs on 5.5?

> I can disable that specific test for 5.5, but though I should bring
> this up first, just in case there are still some bugs in selftests.

> Thanks for checking!

> Two most recent failures (not that they are helpful, because there is
> no output until tests completes, but still):

>    - https://travis-ci.com/github/libbpf/libbpf/jobs/359067538
>    - https://travis-ci.com/github/libbpf/libbpf/jobs/359784775
Nothing pops up, I don't think we did any fixes to address any
occasional failles like that.

The only fixes we did are:
d8fe449a9c51 - bpf: Don't return EINVAL from {get,set}sockopt when optlen >  
PAGE_SIZE
9babe825da76 - bpf: always allocate at least 16 bytes for setsockopt hook

And I don't see how this test can hang without any of those (should
either always pass or fail).

Let's maybe try to disable it, as you suggested, and see if that's
indeed this sockopt_inherit test that's misbehaving?
I can try to find some time next week to reproduce.

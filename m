Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F32289A17
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391023AbgJIU7p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 16:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732748AbgJIU7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 16:59:45 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD375222C8
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602277185;
        bh=K2FMVcPnwpnFdFTH0nWKguSV5alJGPLhcP/xaLhn8SY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0WbDWoyJhSvlQ/9KmhcYAraUDQn9/GNW1Dgw0FK6r6Kx9ocUAq9ltOKxoWihM/jJM
         9+PDgGyjK9I7t+Oag/P2EdOyb2jiNSR0r7uB4kouuLpmbA2wzxPexcXryPXXZBpSlp
         STMGl7CsXcGiTdduLMw4vkXoQtfsyhpJ6E0mJsgQ=
Received: by mail-wr1-f45.google.com with SMTP id h5so1576610wrv.7
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 13:59:44 -0700 (PDT)
X-Gm-Message-State: AOAM533VeoKGCRJ78bkAYokeHx8MtHNm0G+R/bXbIbBw0KYfpaik7XsR
        YSR5Ed5ZgLM6LiPkmEYcmFhlTsEmM03ig1bZMlZ3IQ==
X-Google-Smtp-Source: ABdhPJxJKqPctdujsV6zYIcj1iFFsZubnKUTdB+gOUvULrurNfsxzHCDMX9gfPQHrqmvwfwZlZHma48kDaamaiRKqbs=
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr16591334wrx.75.1602277183196;
 Fri, 09 Oct 2020 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <122e3e70cf775e461ebdfadb5fbb4b6813cca3dd.1602263422.git.yifeifz2@illinois.edu>
 <CALCETrUD7z3-zL_rATzTyDUzgerOzXJHdn-hntNMG=vnX8ZF2w@mail.gmail.com> <CABqSeAS0WdkLHGMg3TRKkzsUE=JJYwY4iuBgYpdp-kLd9ASOfg@mail.gmail.com>
In-Reply-To: <CABqSeAS0WdkLHGMg3TRKkzsUE=JJYwY4iuBgYpdp-kLd9ASOfg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 9 Oct 2020 13:59:31 -0700
X-Gmail-Original-Message-ID: <CALCETrUcsQhYM3+y+geFNmVzscv30Rg=8P50zNtEpLBgEwf9Pg@mail.gmail.com>
Message-ID: <CALCETrUcsQhYM3+y+geFNmVzscv30Rg=8P50zNtEpLBgEwf9Pg@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 3/5] x86: Enable seccomp architecture tracking
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 11:32 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 12:25 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > Is the idea that any syscall that's out of range for this (e.g. all of
> > the x32 syscalls) is unoptimized?  I'm okay with this, but I think it
> > could use a comment.
>
> Yes, any syscall number that is out of range is unoptimized. Where do
> you think I should put a comment? seccomp_cache_check_allow_bitmap
> above `if (unlikely(syscall_nr < 0 || syscall_nr >= bitmap_size))`,
> with something like "any syscall number out of range is unoptimized"?
>

I was imagining a comment near the new macros explaining that this is
the range of syscalls that seccomp will optimize, that behavior is
still correct (albeit slower) for out of range syscalls, and that x32
is intentionally not optimized.

This avoids people like future me reading this code, not remembering
the context, and thinking it looks buggy.

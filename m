Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392DA2771AF
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIXM4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgIXM4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:56:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B9C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 05:56:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n22so3263542edt.4
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PIyzkE03cr+kvJe1Aijo1Xyt0QaH2RNf7w1MklGRBQ=;
        b=kJB1nGYxP0Y6X5WheYqJQFpCi5sL6A711gpSeHDvuzgkectzUE/MXMOOEAnyElFD9v
         iqJyfIN/NSmWXrpVuFZ0aho0aDIFIpkMOw1pyuVo0+VxTny2vbcrMcsb9bSkOD2pXiG3
         Dvl8rC/5qu8B0ATDNukQW590sTpDnKOF0N0ECVTvm6I8NaeU/cOkLhrQclT3Uw6+H6sk
         /qht2lFhpsGuqbERJ1ekX/lZmTpUh5+Dak+m/8EL3mc+x8jKSLvoDXJXDjOHzU8GK7vZ
         udXjSph+fxFzM8V094eG/lbsSo3u9cohPOEWwxr8UoH1Ss++gokbpNmfxCbBkzFK3vEe
         Rtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PIyzkE03cr+kvJe1Aijo1Xyt0QaH2RNf7w1MklGRBQ=;
        b=ckaaOChzFJ2yfWTbTrOOlRABeIofjQ5XfqENaquhr6a0q+zPBJBo4ZT3XNwqknUkMX
         jK30bXJFSrz0VrpgMvMfs2c/2UnNFhdSvKKvNdGv84XoTLqZDqV6eTsATXo3Y+wdAah8
         zyfpFangVLdZoVZq3oDlDkfty3Z7cAu5anh1x2AxqewK+ftHfjP0OIMSk0+DU/xyhybJ
         ToK2C7tQZEawLD+xs60Y+mKY00EuJkvNWnOeOGTa/4DLOdUNpgMn89wEfBjHgBflUQdd
         ikNBDNEJmJvfS/T+c1blLrhE3Kty0ahELQy3HnH4Y9q1Rg9SkOQXiyXusaf7GbZM25LM
         ehBA==
X-Gm-Message-State: AOAM531N3eFcgfP3EpAlvrJhMR6rnB6fls7mlRrOygv9OBP4ImY8nydy
        4rUp+/HGlZy3Xdd00weYxLw1qO49gbpZ8GDB0+h7jA==
X-Google-Smtp-Source: ABdhPJyZT+GnEERoDowCMN+gaCS8CKBwR2yALNltlIzprycdqYNWKl35K4oZS3REzkERw/iLp6ynqEQMU4tQidSctwU=
X-Received: by 2002:a50:ccd2:: with SMTP id b18mr885315edj.51.1600952205967;
 Thu, 24 Sep 2020 05:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org> <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
 <202009240018.A4D8274F@keescook> <CAG48ez1MWhrtkbWTNpc1v-WqWYiLM_JrCKvuE6DdH6vBY3MJzQ@mail.gmail.com>
 <ec31caaea19247f0b9bd9c73ccaa7dbd@AcuMS.aculab.com>
In-Reply-To: <ec31caaea19247f0b9bd9c73ccaa7dbd@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 14:56:19 +0200
Message-ID: <CAG48ez0n-oqivqDCFjHo1UOuNN3HnP+mi2UGB_Xqf3TwwO+ZuQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 2:37 PM David Laight <David.Laight@aculab.com> wrote:
> From: Jann Horn
> > Sent: 24 September 2020 13:29
> ...
> > I think our goal here should be that if a syscall is always allowed,
> > seccomp should execute the smallest amount of instructions we can get
> > away with, and touch the smallest amount of memory possible (and
> > preferably that memory should be shared between threads). The bitmap
> > fastpath should probably also avoid populate_seccomp_data().
>
> If most syscalls are expected to be allowed

E.g. OpenSSH's privilege-separated network process only permits
something like 26 specific syscalls.

> then an initial:
>         if (global_mask & (1u << (syscall_number & 63))
> test can be used to skip any further lookups.

I guess that would work in principle, but I'm not convinced that it's
worth adding another layer of global caching just to avoid one load
instruction for locating the correct bitmask from the current process.
Especially when it only really provides a benefit when people use
seccomp improperly - for application sandboxing, you're supposed to
only permit a list of specific syscalls, the smaller the better.

> Although ISTR someone suggesting that the global_mask should
> be per-cpu because even shared read-only cache lines were
> expensive on some architecture.

If an architecture did make that expensive, I think we have bigger
problems to worry about than a little bitmap in seccomp. (Like the
system call table.) So I think we don't have to worry about that here.

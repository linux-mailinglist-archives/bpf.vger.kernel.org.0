Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BC2795F3
	for <lists+bpf@lfdr.de>; Sat, 26 Sep 2020 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgIZBXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgIZBXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 21:23:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D40C0613CE;
        Fri, 25 Sep 2020 18:23:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so355940pjd.3;
        Fri, 25 Sep 2020 18:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjsiX96TOZRrX+VWB5R73a/e4ejGDQtJ92tP2rTnjOs=;
        b=Imh+a54pvSI9sfrjTL6vFP9BP8aCNTez3j81G7yDGDS59MGe4mxIsT5JeEXn51ynmf
         wGIDMu7h37nNhagccGZt84pZgsS7AIKEs40qYkX+MHQvkVfOZnoakZdz9M8u4vdlGb5P
         8yQBq6S01sczjE5nT0niD5iVgLXYHTUBp939DUYIPIZ879aB1GcXRZUeBdlAUbyC7Cwv
         Ruy2U3hxVwfr9jds0Vmo66h6zEqsxKqrQaYwuXyW6bIR73SwpKlLTyTsnpk6LVgFZAn+
         Idqwu5WQx3/qfn2BlC4gVXLpxxMbuXM3P/UHb4FqM95OyYoD0Mhuvp9ibx5dstPe7H1G
         +hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjsiX96TOZRrX+VWB5R73a/e4ejGDQtJ92tP2rTnjOs=;
        b=K0yYy9z5ixroqP9VKrjyubskWP17lt/iDJ58S7j3oclpeBVU/rMr2iP5p2qNFcYgxB
         e+vvURV2S55QdmLld5vsHq1ft2tuS/vw1Nkoe7VSSbZz0EP5r1ar1H99g5/xbjyPV75m
         3WHIVrSkFrY1w2USVydmTbwGH5Rs5itpKvkw4gx7OcUzcYxnOM5gxuXBiv+kgyUsXHLK
         QRPtthwJAnRWhhoS7LjHsxSR3rvRHxpL6/qc3Zjf5+YHnEpY7pPVxCSvHZT6KHUTO+1I
         /J907avbe7XEQ98NgD64wxKYnkYhwG4e6+ROhBORhVqO6cnmt2EmpZQ/piSfDkYs00v/
         ajzA==
X-Gm-Message-State: AOAM533IvuITJ8YWwmzgZzirtVeXkIDi7QNf7DkyVEB0tEEXF2lHgtOU
        KQKvQ++FzKu269bliHhSr/KKNUYLd+csyOiHoeM=
X-Google-Smtp-Source: ABdhPJzOKTBS/qfK2ZK7IckkNEZ2COxbBRpCd5qZvLpE47fez0OjnTD6tKlcc+G9j0e6gphevIVvtwX2kJMYareLyfQ=
X-Received: by 2002:a17:902:778e:b029:d2:8046:efe2 with SMTP id
 o14-20020a170902778eb02900d28046efe2mr172074pll.44.1601083422286; Fri, 25 Sep
 2020 18:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <202009251223.8E46C831E2@keescook> <2FA23A2E-16B0-4E08-96D5-6D6FE45BBCF6@amacapital.net>
 <202009251332.24CE0C58@keescook> <CALCETrU_UpcLhXSG84SA6QkAYe8xXn4AXPKeud-=Adp57u54Mg@mail.gmail.com>
In-Reply-To: <CALCETrU_UpcLhXSG84SA6QkAYe8xXn4AXPKeud-=Adp57u54Mg@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 25 Sep 2020 20:23:30 -0500
Message-ID: <CABqSeASR0bQ7Y302SkZ639NM=roSVRmd3ROGm0YDEFCTxxd63w@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 4:07 PM Andy Lutomirski <luto@amacapital.net> wrote:
> We'd need at least three states per syscall: unknown, always-allow,
> and need-to-run-filter.
>
> The downsides are less determinism and a bit of an uglier
> implementation.  The upside is that we don't need to loop over all
> syscalls at load -- instead the time that each operation takes is
> independent of the total number of syscalls on the system.  And we can
> entirely avoid, say, evaluating the x32 case until the task tries an
> x32 syscall.

I was really afraid of multiple tasks writing to the bitmaps at once,
hence I used bitmap-per-task. Now I think about it, if this stays
lockless, the worst thing that can happen is that a write undo a bit
set by another task. In this case, if the "known" bit is cleared then
the worst would be the emulation is run many times. But if the "always
allow" is cleared but not "known" bit then we have an issue: the
syscall will always be executed in BPF.

Is it worth holding a spinlock here?

Though I'll try to get the benchmark numbers for the emulator later tonight.

YiFei Zhu

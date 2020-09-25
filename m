Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAED27811F
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgIYHHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYHHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 03:07:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A2BC0613CE;
        Fri, 25 Sep 2020 00:07:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so1292163pjr.3;
        Fri, 25 Sep 2020 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXHAzrDSGjCjB2rkCK3StmtVizqd8imW6WJ6CCyJZeQ=;
        b=gt9l35Cg3svYq9N0uBGPNxc+e9Lj33iOExb3HpMPwqd2IPv6C27pIvDXvzxWOzcHBW
         Yh6glD+IXSLk5VfF1jBzqvUUkan5XiVd6XlMp+D3SVOURcaVZ3nn2+1MK3naJ7SRwHJT
         VQ+9/V2/FG6I3s/4f6i3P5/lZ05PsRTL9Avex18L+gg4JE3fmaJDBPu0MGlCNYxRDVEt
         QIEcXSjUOn52P6voDi2cMT4cgBLkxfo/Jh1fns0C9xKWvlYlMBlOg6y/rZGEd5SbFpAI
         KDzO3BcKFpdoY8pgwzuEdmuNrO5qQPcTyFezyookmPHET2xLWBBgUm/ISJ2ttmeyDB9c
         FnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXHAzrDSGjCjB2rkCK3StmtVizqd8imW6WJ6CCyJZeQ=;
        b=QU7sH8hi7L1z3Bkf/69V5ROTu+zPZXbnU09D8aLB/zDE+5ZmuwDKftmjRdf+KL3m4X
         jrElQQKMy5LAapRGaqArc+AnPVGsSuPvYXj9DGXd3cXjrs5QvE2Mm1X8n+4R6xuwAIej
         Zvbk1vX4rm3xK7zl6RbBl0NbnFpcnKgdtsj1X3Vnc+C5drcGdIlbokONDv6DrP07xToA
         rhm5AN8X67aJ8DphpkeIxnUuVuhpjwEfE/aJXLVquslg/Fgzwe8pCYkl1KVGkpGryzGb
         CuGOIiaCs4w2QprKsm+CksksxJRp4felDkBMH1O07uUk8oCF+evSHyp3EWjV8D6zdKEm
         5gPA==
X-Gm-Message-State: AOAM530cWSKJNp0oAFaLJNlwlfHgHltKrFXZQOHGe6xnVaIfKAwiYnyn
        XEODrSt7XRSWD/YkWHWkZHdI4pkt/fwTLkT3v68=
X-Google-Smtp-Source: ABdhPJzlGUGW2iKkTkrAVqTUKcvO9npurfnjC2yNvq753E1M0AVW5b7tjO01qNJKAYI3kQSCeflzbuJKPBvB5TUeDog=
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr1374059pjm.12.1601017631436;
 Fri, 25 Sep 2020 00:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk> <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
 <27b4ef86-fee5-fc35-993b-3352ce504c73@rasmusvillemoes.dk>
In-Reply-To: <27b4ef86-fee5-fc35-993b-3352ce504c73@rasmusvillemoes.dk>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 25 Sep 2020 02:07:00 -0500
Message-ID: <CABqSeATHtvA7qm7j_kxBsbxRCd5B=MHtxGdsYsXEJ-TRRYKTgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Valentin Rothberg <vrothber@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 12:56 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> Yes, the man page would read something like
>
>        SECCOMP_SET_MODE_FILTER_BITMAP
>               The system calls allowed are defined by a pointer to a
> Berkeley Packet Filter (BPF) passed  via  args.
>               This argument is a pointer to a struct sock_fprog_bitmap;
>
> with that struct containing whatever information/extra pointers needed
> for passing the bitmap(s) in addition to the bpf prog.
>
> And SECCOMP_SET_MODE_FILTER would internally just be updated to work
> as-if all-zero allow-bitmaps were passed along. The internal kernel
> bitmap would just be the and of the bitmaps in the filter stack.
>
> Sure, it's UAPI, so would certainly need more careful thought on details
> of just how the arg struct looks like etc. etc., but I was wondering why
> it hadn't been discussed at all.

If SECCOMP_SET_MODE_FILTER is attached before / after
SECCOMP_SET_MODE_FILTER_BITMAP, does it mean all bitmap gets void?

Would it make sense to have SECCOMP_SET_MODE_FILTER run through the
emulator to see if we can construct a bitmap anyways for "legacy
no-bitmap" support?

Another thing to consider is that in both patch series we only
construct one final bitmap that, if the bit is set, seccomp will not
call into the BPF filter. If the bit is not set, then all filters are
called in sequence, even if some of them "must allow the syscall".
With SECCOMP_SET_MODE_FILTER_BITMAP, the filter BPF code will no
longer have the "if it's this syscall" for any syscalls that are given
in the bitmaps, and calling into these filters will be a false
negative. So we would need extra logic to make "does this filter have
a bitmap? if so check bitmap first". Probably won't be too
complicated, but idk if it is actually worth the complexity. wdyt?

> Regardless, I'd like to see some numbers, certainly for the "how much
> faster does a getpid() or read() or any of the other syscalls that
> nobody disallows" get, but also "what's the cost of doing that emulation
> at seccomp(2) time".

The former has been given in my RFC patch [1]. In an extreme case of
no side channel mitigations, in the same amount of time, unixbench
syscall mixed runs 33295685 syscalls without seccomp, 20661056
syscalls with docker profile, 25719937 syscalls with bitmapped docker
profile. Though, I think Jack was running on Ubuntu and it did not
have a libseccomp shipped with the distro that's new enough to do the
binary decision tree generation [2].

I'll try to profile the latter later on my qemu-kvm, with a recent
libsecomp with binary tree and docker's profile, probably both direct
filter attaches and filter attaches with fork(). I'm guessing if I
have fork() the cost of fork() will overshadow seccomp() though.

[1] https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
[2] https://github.com/seccomp/libseccomp/pull/152

YiFei Zhu

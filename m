Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D2E27FEC2
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 14:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgJAMGo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgJAMGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 08:06:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340EC0613D0;
        Thu,  1 Oct 2020 05:06:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so1854151pjh.5;
        Thu, 01 Oct 2020 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sV74BIakUvCRx9xcShItHkPBiKSDkVPNapmNdKhM3Fw=;
        b=E/mNGlILRl6AHiL3qGtevUrxp3GXKf9RRaYnjJ56vO+Bw7X/VenWRMl/YHLAQLyXp2
         5tu9fs7q81Pfl9SncMeOSscxQc2DVUSotpGa3RhCZ/APh/Z1aqlZrJaHDitCIK4GO2xr
         VFaPnKjF7s0DG+BR8TRCEuXyfhI76FEq8wzJmCtZkn0Md70rhlLWsK/u1DokcOm/oq96
         sEzmpGaxL5WWn6nMkpgholDXMNy2Gg28eyWrAgnMBHgl0qJne3jpLWDW/QnjxJYGWo/z
         BH3gFJfEntDFHgkwPt50iHZRIwXG/rH0drVrWD2R4ua3ish3KYeERc+D1c+eSoYdvOfc
         yWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sV74BIakUvCRx9xcShItHkPBiKSDkVPNapmNdKhM3Fw=;
        b=CLlvW9yroauY/YZTMrp+ac4mbSj/+424x3v5yTjntOhm4mdtEDFQnCwbU8Ns10qNu2
         PwgetaNO0SdOxJLxBrbBz9wBCxfnv02NPYml5MzpF3K9H3+34Wu9uHtdtkl9gEpTNniH
         isNwlVWlJrYgEYonMvhwLNn8qOaJwWGitTZ9kkYGrszwErhYtmsl6XtaGg6bNOZs/VB7
         2CSlUGCcrGxR6pCzbwv1I4/Gfuw+Mq8h1Iphp4aUPgCkVWpiBaO/HCR3wrcE3yxkBm8Y
         jrxqqNunWWTmjy269YFe9mvVx+AVcnT1G9WeN0qLb29v6Ft/eJBLQJnPWAJbMZRbcedD
         0I+g==
X-Gm-Message-State: AOAM531c81CBoK3Fqs1AEEs95qt3vhWfuG5OLJ3nOLTZnzD8A3LLUijk
        2Sk9tK/wm/JIa65Fiytt1FEl0I0gUwvO98XqybM=
X-Google-Smtp-Source: ABdhPJxFIrcPL34IzL0lczgzrednTeL9WUedF7XaOVI+sCHu376fT8D6xN93NHnFrJalk3Lnw2G5vzRnU6419m15U8w=
X-Received: by 2002:a17:90a:d495:: with SMTP id s21mr6547846pju.1.1601554003886;
 Thu, 01 Oct 2020 05:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com>
In-Reply-To: <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 1 Oct 2020 07:06:32 -0500
Message-ID: <CABqSeATEMTB_hRt9D9teW6GcDvz4VLfMQyvX=nvgR4Uu4+AgoA@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Jann Horn <jannh@google.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
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

On Wed, Sep 30, 2020 at 5:01 PM Jann Horn <jannh@google.com> wrote:
> Hmm, this won't work, because the task could be exiting, and seccomp
> filters are detached in release_task() (using
> seccomp_filter_release()). And at the moment, seccomp_filter_release()
> just locklessly NULLs out the tsk->seccomp.filter pointer and drops
> the reference.
>
> The locking here is kind of gross, but basically I think you can
> change this code to use lock_task_sighand() / unlock_task_sighand()
> (see the other examples in fs/proc/base.c), and bail out if
> lock_task_sighand() returns NULL. And in seccomp_filter_release(), add
> something like this:
>
> /* We are effectively holding the siglock by not having any sighand. */
> WARN_ON(tsk->sighand != NULL);

Ah thanks. I was thinking about how tasks exit and get freed and that
sort of stuff, and how this would race against them. The last time I
worked with procfs there was some magic going on that I could not
figure out, so I was thinking if some magic will stop the task_struct
from being released, considering it's an argument here.

I just looked at release_task and related functions; looks like it
will, at the end, decrease the reference count of the task_struct.
Does procfs increase the refcount while calling the procfs functions?
Hence, in procfs functions one can rely on the task_struct still being
a task_struct, but any direct effects of release_task may happen while
the procfs functions are running?

YiFei Zhu

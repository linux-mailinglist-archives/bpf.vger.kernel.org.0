Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2222C13D6
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgKWSqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 13:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732301AbgKWSqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 13:46:46 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020CC061A4D
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:46:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so25232544lfc.4
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9BHXyWFj10xWcwujIs4dXnL9WUMRwoUF5d33ZfnS3g=;
        b=mImY9iotviSUpccYlY57NxeoOjkByLCewvzY67q7V5+w5771rSl7PimMIHy2BTWA02
         mSecZCcfVYWwPKyWWSsmBHsr8TX99kbBLSdUXwlX890cEs2a77UwKmthMDcm2NY9Gwco
         AS+uEAI9ngPl2w4t18qMyhxSOTdhY+qeM7DXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9BHXyWFj10xWcwujIs4dXnL9WUMRwoUF5d33ZfnS3g=;
        b=R+ogveuJM1I2j0kZ8KcwTtPCo80R+uivn7zFh84yoqSUzb4mQHDdq622oXlGXNC073
         4LiSK7GBQaDS3MwHaZF4PVZ1YKZflXfrdZ46zSkKLHOxFAEfhEHLdF5KphmqgcxVTyr5
         q5ctnn6ouG03XYiYM3VMTfIHHQLlrrag0xZuW1+Kyb5wHLrREy3vlQOq3Cuetw9pVnLN
         0vea9xmsrgfvW3YxMeQ5O1baS667fj8cSQGLgL1Sn6bRzrdJbPt+SxJ5w6t2IC/R2b65
         rFwPVf35zrALeUbz69Vdl7TLRZVZSK7JlA2wUdiyPJEGCHq+Z3FGWcWlGCcK8BPzIOYP
         Rlrg==
X-Gm-Message-State: AOAM532Gm/I8fFE8cPF4fRqaz1Cp4ZLBgHxb74Wa0NSfprOQQtSawVkb
        6/SPEexjL9vFk62ttzllrN5eyl31CJv9ZUJlvSrbzg==
X-Google-Smtp-Source: ABdhPJztvNCcwogoA0f2GBgX20o1qMkXIjfhJfZKvK5/zjRoiuEE7ZMUaYGFhhjf2/Tq0dxwizfKLd56uu9M6FmB+I0=
X-Received: by 2002:a19:f114:: with SMTP id p20mr204531lfh.146.1606157204393;
 Mon, 23 Nov 2020 10:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org> <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
 <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
 <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com> <cf0d94ca-b6a0-1a1a-6cf2-a641002588bf@fb.com>
In-Reply-To: <cf0d94ca-b6a0-1a1a-6cf2-a641002588bf@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 23 Nov 2020 19:46:33 +0100
Message-ID: <CACYkzJ6RK=bhdGphbK6VZoLdvEfEo9rtYKCS=-dfyt5F=AujnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 7:36 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/23/20 10:27 AM, KP Singh wrote:
> > [...]
> >
> >>>>
> >>>> Even if a custom policy has been loaded, potentially additional
> >>>> measurements unrelated to this test would be included the measurement
> >>>> list.  One way of limiting a rule to a specific test is by loopback
> >>>> mounting a file system and defining a policy rule based on the loopback
> >>>> mount unique uuid.
> >>>
> >>> Thanks Mimi!
> >>>
> >>> I wonder if we simply limit this to policy to /tmp and run an executable
> >>> from /tmp (like test_local_storage.c does).
> >>>
> >>> The only side effect would be of extra hashes being calculated on
> >>> binaries run from /tmp which is not too bad I guess?
> >>
> >> The builtin measurement policy (ima_policy=tcb") explicitly defines a
> >> rule to not measure /tmp files.  Measuring /tmp results in a lot of
> >> measurements.
> >>
> >> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
> >>
> >>>
> >>> We could do the loop mount too, but I am guessing the most clean way
> >>> would be to shell out to mount from the test? Are there some other examples
> >>> of IMA we could look at?
> >>
> >> LTP loopback mounts a filesystem, since /tmp is not being measured with
> >> the builtin "tcb" policy.  Defining new policy rules should be limited
> >> to the loopback mount.  This would pave the way for defining IMA-
> >> appraisal signature verification policy rules, without impacting the
> >> running system.
> >
> > +Andrii
> >
> > Do you think we can split the IMA test out,
> > have a little shell script that does the loopback mount, gets the
> > FS UUID, updates the IMA policy and then runs a C program?
> >
> > This would also allow "test_progs" to be independent of CONFIG_IMA.
> >
> > I am guessing the structure would be something similar
> > to test_xdp_redirect.sh
>
> Look at sk_assign test.
>
> sk_assign.c:    if (CHECK_FAIL(system("ip link set dev lo up")))
> sk_assign.c:    if (CHECK_FAIL(system("ip route add local default dev lo")))
> sk_assign.c:    if (CHECK_FAIL(system("ip -6 route add local default dev
> lo")))
> sk_assign.c:    if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
> sk_assign.c:    if (CHECK(system(tc_cmd), "BPF load failed;"
>
> You can use "system" to invoke some bash commands to simulate a script
> in the tests.

Heh, that's what I was trying to avoid, I need to parse the output to the get
the name of which loop device was assigned and then call a command like:

# blkid /dev/loop0
/dev/loop0: UUID="607ed7ce-3fad-4236-8faf-8ab744f23e01" TYPE="ext3"

Running simple commands with "system" seems okay but parsing output
is a bit too much :)

I read about:

https://man7.org/linux/man-pages/man4/loop.4.html

But I still need to create a backing file, format it and then get the UUID.

Any simple trick that I may be missing?

- KP

>
> >
> > - KP
> >
> >>
> >> Mimi
> >>

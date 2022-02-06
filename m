Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E04AADB0
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 05:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiBFE3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Feb 2022 23:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBFE3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Feb 2022 23:29:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC0C06173B;
        Sat,  5 Feb 2022 20:29:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z5so8613460plg.8;
        Sat, 05 Feb 2022 20:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jdhw7mSR7V7cNcaM0UCeu+GU2bmiq3T19a9N118Zppg=;
        b=Cd+ijFk/74tk8ZNujs8fsDYd1sTXI5V/wGkDR0Fi92TrXWNha4DUr2B62eZNiFm4lw
         lornrc25uXGBV8m9I7uqUKok5hGpfLrnjmPt3u1ZAFfeKVXtpqOkOCJO/EWgx7vrWJdC
         2WF5ogO26iW7WTGKMGpEJCJHESEVdlI/DG5JWyEXLoLBDVvyvDEwTUW7/RkDop7INl44
         LckVO0k9clUROBR5+IgXhfP2UEB3gr23nWPfxBaoldKDCj015MM60H/CEiKLVTh2EH24
         nTFIlyztZGJ2gDziCu6w5Q09K/7k9n5eCid3hIs94RwI4c7UFNw/xvjtTykZ7uImKVAl
         KBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jdhw7mSR7V7cNcaM0UCeu+GU2bmiq3T19a9N118Zppg=;
        b=dixe0EsVrjLPWcomXwFVfdeclgc46Ei/g3+zP2aTNNxQJxzcnap9dqSDhfLW5RqSEl
         kgk4Qt3Yssu6JSFWkS+b+Zi8/BMs2/NBR/zzJCzFTFx6zIrLWh0FlNfdBxlYg00j6DU5
         KHBMiaiD23ppilF52kaR5xq6o0DwohKPxJbDAmn9lVeAUj1G0CfMpcPOIV3Uvpxta83h
         /Mcsbj1MvASdATbPZiwFI5C6fFwe/xizfqeOl1svodQgfDKqrS5yzNgH/ZnrAMwHTAWF
         Y+5CFMZcXXz4VaMiqtUHafhbYIfxY5M+muOGo1esFARZjezL5+mcllapVLLY1jg+DpDd
         5YPQ==
X-Gm-Message-State: AOAM5303UEZwtxnqrDMw3kMP6gG6avflh7MzxSFlPxMo+5zoFxq1MnZ2
        GTPG6czZXc/C/FRjGe8wPeeyVOsffDzIMlo6OLqdS8Xe
X-Google-Smtp-Source: ABdhPJxSbBYDlrcxjq4UdQFxjJ6+qrQz4UnDrLrww5Fn3AkoCYVzGO+fdu52p+w79IDqfhZo1gZK2VPPm5RnUpN047Y=
X-Received: by 2002:a17:90b:4ac6:: with SMTP id mh6mr7409716pjb.138.1644121761313;
 Sat, 05 Feb 2022 20:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
 <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com> <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
In-Reply-To: <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 5 Feb 2022 20:29:10 -0800
Message-ID: <CAADnVQ+-29CS7nSXghKMgZjKte84L0nRDegUE0ObFm3d7E=eWw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 10:27 AM Hao Luo <haoluo@google.com> wrote:
> >
> > > In our use case, we can't ask the users who create cgroups to do the
> > > pinning. Pinning requires root privilege. In our use case, we have
> > > non-root users who can create cgroup directories and still want to
> > > read bpf stats. They can't do pinning by themselves. This is why
> > > inheritance is a requirement for us. With inheritance, they only need
> > > to mkdir in cgroupfs and bpffs (unprivileged operations), no pinning
> > > operation is required. Patch 1-4 are needed to implement inheritance.
> > >
> > > It's also not a good idea in our use case to add a userspace
> > > privileged process to monitor cgroupfs operations and perform the
> > > pinning. It's more complex and has a higher maintenance cost and
> > > runtime overhead, compared to the solution of asking whoever makes
> > > cgroups to mkdir in bpffs. The other problem is: if there are nodes in
> > > the data center that don't have the userspace process deployed, the
> > > stats will be unavailable, which is a no-no for some of our users.
> >
> > The commit log says that there will be a daemon that does that
> > monitoring of cgroupfs. And that daemon needs to mkdir
> > directories in bpffs when a new cgroup is created, no?
> > The kernel is only doing inheritance of bpf progs into
> > new dirs. I think that daemon can pin as well.
> >
> > The cgroup creation is typically managed by an agent like systemd.
> > Sounds like you have your own agent that creates cgroups?
> > If so it has to be privileged and it can mkdir in bpffs and pin too ?
>
> Ah, yes, we have our own daemon to manage cgroups. That daemon creates
> the top-level cgroup for each job to run inside. However, the job can
> create its own cgroups inside the top-level cgroup, for fine grained
> resource control. This doesn't go through the daemon. The job-created
> cgroups don't have the pinned objects and this is a no-no for our
> users.

We can whitelist certain tracepoints to be sleepable and extend
tp_btf prog type to include everything from prog_type_syscall.
Such prog would attach to cgroup_mkdir and cgroup_release
and would call bpf_sys_bpf() helper to pin progs in new bpffs dirs.
We can allow prog_type_syscall to do mkdir in bpffs as well.

This feature could be useful for similar monitoring/introspection tasks.
We can write a program that would monitor bpf prog load/unload
and would pin an iterator prog that would show debug info about a prog.
Like cat /sys/fs/bpf/progs.debug shows a list of loaded progs.
With this feature we can implement:
ls /sys/fs/bpf/all_progs.debug/
and each loaded prog would have a corresponding file.
The file name would be a program name, for example.
cat /sys/fs/bpf/all_progs.debug/my_prog
would pretty print info about 'my_prog' bpf program.

This way the kernfs/cgroupfs specific logic from patches 1-4
will not be necessary.

wdyt?

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008602C130F
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgKWS15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 13:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgKWS14 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 13:27:56 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F06C061A4D
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:27:56 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id z1so739151ljn.4
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgU9p94kvA07oQrdAsYiX/LIRMr6ln5r4nCdzUpy7o4=;
        b=ANbUWVwuYddoy3gY/bocFyh5hQNt+h3KoI3AHjcaYTZ0evyDqwLXLEvh5IHaIDYDPb
         ijvo4CAg9ebzTa4ARSGN499RtHon9GqnfrJYuy06yyb/lbQFc4e1U2t0r7waRnZQb4/f
         yAMxbAR5foJyFqxS0PsPj0FXOMJW+JBdUykTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgU9p94kvA07oQrdAsYiX/LIRMr6ln5r4nCdzUpy7o4=;
        b=GHjsi3hdHIIQrW5c3T3rg04t7VCDs2VVNP+j4DLZUw0zpMNNZ1IbZzuT2FhOHz46/d
         fOcfWiFZC2xiP1nIap3MSew7DZt188hEt8ciJE9nq0p3BGhAqk03ThNKZiSGkD/Ea5Aw
         W5mqGNZjvDdOIC8c+WskE/Jv08ldaZfnR9TjRC5zdivcumGKzYszSMBSFM3Xp58HiEc8
         EhVPqhMWGOI7x5o0GkUPEgObiHDIjJ8/nBdziBZf8Yx0GN+Ww3P0SqEgYI9fcGGSac19
         cbScAtY5Mp/eOwq9tNb2r8du4v18TG8VaMNqOvOuPUQKut1Ryfr7CV2pmS3K/OMjRZjy
         ZcoA==
X-Gm-Message-State: AOAM530RIe3rgr3uHsSUCLeXka4KIZqtDIgH2RB1XiIISE3Z0HK02um4
        NcrVc3qBIfBk3aifZ+z4dkQaexapC93Bh0vdPq20Dg==
X-Google-Smtp-Source: ABdhPJwkrFSNlfqwKOFD9vRpU4Bd/UVNbWjZfjxZomwpoP6hhcrhsrMTmb08rhFJdH7XN2M+FVxvNtHTO5cjG1ItJKo=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr303035ljo.82.1606156074562;
 Mon, 23 Nov 2020 10:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org> <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com> <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
In-Reply-To: <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 23 Nov 2020 19:27:43 +0100
Message-ID: <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> > >
> > > Even if a custom policy has been loaded, potentially additional
> > > measurements unrelated to this test would be included the measurement
> > > list.  One way of limiting a rule to a specific test is by loopback
> > > mounting a file system and defining a policy rule based on the loopback
> > > mount unique uuid.
> >
> > Thanks Mimi!
> >
> > I wonder if we simply limit this to policy to /tmp and run an executable
> > from /tmp (like test_local_storage.c does).
> >
> > The only side effect would be of extra hashes being calculated on
> > binaries run from /tmp which is not too bad I guess?
>
> The builtin measurement policy (ima_policy=tcb") explicitly defines a
> rule to not measure /tmp files.  Measuring /tmp results in a lot of
> measurements.
>
> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
>
> >
> > We could do the loop mount too, but I am guessing the most clean way
> > would be to shell out to mount from the test? Are there some other examples
> > of IMA we could look at?
>
> LTP loopback mounts a filesystem, since /tmp is not being measured with
> the builtin "tcb" policy.  Defining new policy rules should be limited
> to the loopback mount.  This would pave the way for defining IMA-
> appraisal signature verification policy rules, without impacting the
> running system.

+Andrii

Do you think we can split the IMA test out,
have a little shell script that does the loopback mount, gets the
FS UUID, updates the IMA policy and then runs a C program?

This would also allow "test_progs" to be independent of CONFIG_IMA.

I am guessing the structure would be something similar
to test_xdp_redirect.sh

- KP

>
> Mimi
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED72A5AE0
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 01:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgKDAFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 19:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgKDAFu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 19:05:50 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7A7C061A47
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 16:05:49 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 184so24682345lfd.6
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 16:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eq/hKMyLgdp/QXXnQV5r6IWOxg03mEPCZUhhSNnW7WQ=;
        b=kGbCaylyi3k1edOqC9ql7Ui7JoWXWXg6MNLPnsqRDCSqzBsrZ0+FWoh1oZ9OUo8SbC
         wm654Ccbvp3ZTzDnAtEoYjzR5/5Ho9Nrayfi4QGYwRueZ/YErdfLFzGXCWNWsOJCHpK8
         UPppa7VdIAXGPMtTUU1c6bV/Onokcw6tn8Sg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eq/hKMyLgdp/QXXnQV5r6IWOxg03mEPCZUhhSNnW7WQ=;
        b=FzYrbhNwR+fKHsBWLkcMMJ/cX4wYzYcSjGYVP/V35lVzgHtdaf6uWFUj/Unxx+USe8
         itAjUtYoH9sQsVULH1r5XsIOxeHVMfNsVTRVvaxnj4C9zC8Wx/+0IgSHVX6WBKAxCwwY
         laFWf9Mo+A1Nup7jXiUu4i7gUmnKiQln6cX5oAaougStiMrN7/QNZ6ij6yWTLw37Pwdn
         O7R3rcjH6KDVgbemMNbXGUAZ0XTiCXQXrHb7TlfXf31SStnYxR7lSthp+4ptNewN7+ag
         NfdxhkZSCEukgdbIkVzMgLnjz3mP9BDPOIsXqomNA+HJxPNvL6Lgu4qL0Kghos6Io7Ja
         gBsw==
X-Gm-Message-State: AOAM530zmuKas/E13YFuGhDnLGp3btQkgGlJINwpyOI2BCejxTmTld42
        H3/MFLAAOOO9z8hMZvy7pZnU9fv28Fk40wYvMO75Yg==
X-Google-Smtp-Source: ABdhPJyaQiAijXHPV9yeVkPh8oqSfakHStF6zz7Ot5pXha23zseqo/DSuoaYALXBcHKNlHfshHPlApWX9Z2AFXr6E70=
X-Received: by 2002:ac2:44a4:: with SMTP id c4mr9029079lfm.365.1604448348193;
 Tue, 03 Nov 2020 16:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
In-Reply-To: <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 01:05:37 +0100
Message-ID: <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 7:59 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On Tue, Nov 3, 2020 at 7:47 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 03, 2020 at 04:31:31PM +0100, KP Singh wrote:
> > > +
> > > +struct storage {
> > > +     void *inode;
> > > +     unsigned int value;
> > > +     /* Lock ensures that spin locked versions of local stoage operations
> > > +      * also work, most operations in this tests are still single threaded
> > > +      */
> > > +     struct bpf_spin_lock lock;
> > > +};
> >
> > I think it's a good idea to test spin_lock in local_storage,
> > but it seems the test is not doing it fully.
> > It's only adding it to the storage, but the program is not accessing it.
>
> I added it here just to check if the offset calculations (map->spin_lock_off)
> are correctly happening for these new maps.
>
> As mentioned in the updates, I do intend to generalize
> tools/testing/selftests/bpf/map_tests/sk_storage_map.c which already has
>  the threading logic to exercise bpf_spin_lock in storage maps.
>

Actually, after I added simple bpf_spin_{lock, unlock} to the test programs, I
ended up realizing that we have not exposed spin locks to LSM programs
for now, this is because they inherit the tracing helpers.

I saw the docs mention that these are not exposed to tracing programs due to
insufficient preemption checks. Do you think it would be okay to allow them
for LSM programs?


- KP

> Hope this is an okay plan?

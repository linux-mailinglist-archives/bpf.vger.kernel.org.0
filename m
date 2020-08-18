Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0C247BCD
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 03:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHRBZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHRBZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 21:25:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689AC061389
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 18:25:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so19584149ljn.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jO6k+zx2QyYG7TMnQ5c6/6yeQvSBLn9YZjhaXafaPvk=;
        b=eHsDhhag9rrcZCLW4PVvHzOSXn+lP4FTzkwXO8QbMaXFsoRdcItDm4EaUIv9k9Eayj
         DrMKFoyqJ82ML0/jpilgEzHE0oovbm1sqBsCjmoGO2+tOR9O7zFUyZoSgpXghA0LrnSJ
         pzyGN+EBFFdYxkC7yV+8bD6gAtHXA0066kioo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jO6k+zx2QyYG7TMnQ5c6/6yeQvSBLn9YZjhaXafaPvk=;
        b=duDPBbhuw5wA/oanokW2PXNJIJ0s1RRugZFNzGIQErGywleMMa8h34C6Ii8b96NH/C
         4is6DH3q1yTUT4CCc3sufHnQjmQYtLIqhCB/OBThfDXr6NMJIVp7hpbobKYlulOdx6gE
         0Ln4jaLWGm1sn5ZiVJJ6Y3xiqkZbrpPCdP8Py9klSMR3dVoj+e64fg8Q8uMxGLBzAnfj
         v0IqfzPkoWMr1Up1Mgp8Z0b2/b8aCUO2K1lMe65r/c1s+u9frKCbfD9HYNIPgxpbf4Xw
         LVXkgJ5smriPv1nUBaeERWnxcqsVCBY1DYNm+Vybp3jGv8CI9hu0XGILEzwdVuh5UNxY
         veDA==
X-Gm-Message-State: AOAM530stKKhX40Y4GmqCRNzN7SoWL+4MhESs/T+QiYyMnDLphZV1BEE
        QiV9UFl7LZEUjLwFRTfOyEb5oB3P82RH1Q==
X-Google-Smtp-Source: ABdhPJyzJQRQ++lf+kF5Ey1vH8iTGJ4bG4GuRAoFhGzOvLsV+hzQeNg5yGJaVrCV6pxT8cT5YLZclQ==
X-Received: by 2002:a2e:8589:: with SMTP id b9mr8434882lji.126.1597713938718;
        Mon, 17 Aug 2020 18:25:38 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x13sm5962515lfr.95.2020.08.17.18.25.38
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:25:38 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 185so19540887ljj.7
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 18:25:38 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr9127085ljp.312.1597713472024;
 Mon, 17 Aug 2020 18:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com> <875z9g7oln.fsf@x220.int.ebiederm.org>
In-Reply-To: <875z9g7oln.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 18:17:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
Message-ID: <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 6:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I struggle with the fcheck name as I have not seen or at least not
> registed on the the user that just checks to see if the result is NULL.
> So the name fcheck never made a bit of sense to me.

Yeah, that name is not great. I just don't want to make things even worse.

> I will see if I can come up with some good descriptive comments around
> these functions.  Along with describing what these things are doing I am
> thinking maybe I should put "_rcu" in their names and have a debug check
> that verifies "_rcu" is held.

Yeah, something along the lines of "rcu_lookup_fd_task(tsk,fd)" would
be a *lot* more descriptive than fcheck_task().

And I think "fnext_task()" could be "rcu_lookup_next_fd_task(tsk,fd)".

Yes, those are much longer names, but it's not like you end up typing
them all that often, and I think being descriptive would be worth it.

And "fcheck()" and "fcheck_files()" would be good to rename too along
the same lines.

Something like "rcu_lookup_fd()" and "rcu_lookup_fd_files()" respectively?

I'm obviously trying to go for a "rcu_lookup_fd*()" kind of pattern,
and I'm not married to _that_ particular pattern but I think it would
be better than what we have now.

                       Linus

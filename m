Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC92247B5C
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHRABk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 20:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHRABk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 20:01:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4080C061389
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:01:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so9249864lfe.11
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRD9fxr2dmL3cWS6/haxe+/7+RVNAwBfQJLvwFE/2BM=;
        b=GttK3xwVXIEnQDmtYMvF2IJlJWEatfccGGsHzVm20TPi9ekAoaV3TrMSE8QIJupeaU
         o5VYt+7CPeShna6icVTEVqf0cqW5xz6D3gxuRcD4PasdgxEfOrygjNQEgJGTOM8C+RQ7
         unaPe2LNmBbFRNpH7o6v91jPT9h97hM2C5bOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRD9fxr2dmL3cWS6/haxe+/7+RVNAwBfQJLvwFE/2BM=;
        b=gVprdIUzSlmC7qYo4vBwmwrbuTMPzPcAd8rCUg56NmvBrLOu1CbbvTufv8pO465IHK
         ks+x4LtCZDnB7lVA/L4icse0TPMpau0PS75kZ2ciZb7U+ypicVr9QjdHOfISqnz7M3XE
         GSHvzRPu7Aa9sZ1jvLpNVmyRx0s1P5KdklgW34lPr+8zbTVTXFWguTz9RLOmZ+NO4Ws9
         E30QkFxoLpCp33nbqZwqBf18e3PFUbwQTsEkpFHSTqWg+eP1MvUybc4VV9j/YATUAHkG
         fqo+uQUQt+kyAPY3QJ58I6O41D2L8CS2Oi/OUnEI8JlL/MB9YktgGsOBG3iDv/pVj/mW
         A86Q==
X-Gm-Message-State: AOAM530sw6tixJoMHl0PakyAhy7VSlZoQVTjqNGdeN8o1UEXHXdWpMyg
        er1Pg0gMbhlKtijJlknYqFqNq3cgJuQHLQ==
X-Google-Smtp-Source: ABdhPJxdBSLICUakdxD8QmlWHHWmKsLfT42XQmmYrTZnEpIZC6W+0Y8O1ijscZKnsa+qBKKS6afePw==
X-Received: by 2002:a19:c3d0:: with SMTP id t199mr8331217lff.56.1597708898051;
        Mon, 17 Aug 2020 17:01:38 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g6sm5929308lfr.51.2020.08.17.17.01.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:01:37 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m22so19396226ljj.5
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:01:37 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr7971652lji.314.1597708490610;
 Mon, 17 Aug 2020 16:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
In-Reply-To: <20200817220425.9389-9-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
Message-ID: <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
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

I like the series, but I have to say that the extension of the
horrible "fcheck*()" interfaces raises my hackles..

That interface is very very questionable to begin with, and it's easy
to get wrong.

I don't see you getting it wrong - you do seem to hold the RCU read
lock in the places I checked, but it worries me.

I think my worry could be at least partially mitigated with more
comments and docs:

On Mon, Aug 17, 2020 at 3:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +struct file *fnext_task(struct task_struct *task, unsigned int *ret_fd)

Please please *please* make it clear that because this does *not*
increment any reference counts, you have to be very very careful using
the "struct file" pointer this returns.

I really dislike the naming. The old "fcheck()" naming came from the
fact that at least one original user just mainly checked if the result
was NULL or not. And then others had to be careful to either hold the
file_lock spinlock, or at least the RCU read lock so that the result
didn't go away.

Here, you have "fnext_task()", and it doesn't even have that "check"
warning mark, or any comment about how dangerous it can be to use..

So the rule is that the "struct file" pointer this returns can only be
read under RCU, but the 'fd' it returns has a longer lifetime.

I think your uses are ok, and I think this is an improvement in
general, I just want a bigger "WARNING! Here be dragons!" sign (and
naming could be nicer).

            Linus

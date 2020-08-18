Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C001247B62
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgHRAIu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgHRAIs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 20:08:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D5C061389
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:08:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so19447081ljc.3
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PUubmKG0qCUbLC0lny1sEZMsh6oDctj94eQbjDTgwk=;
        b=Cc93yVMbx3RvLnq5PLotBg+roGGu69+/Dx9uDZdnFaQvTrkIzdLU5lhrEDOPiq2+fN
         5E+MIu8qQiaA07jjpGceLS5/FUXItwiiQf3jrnqL+6nxCyP1OYWmoOUBc1tR+82IoQ3t
         pB1HfO6+D8i21tTtZuIWUIjxWkjP3RCPMcq/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PUubmKG0qCUbLC0lny1sEZMsh6oDctj94eQbjDTgwk=;
        b=n+JbVPZ6B3Gh+otwm3qdV3vrA1cjyQ+Qhb7yn/146bFkxFI54LOXFROvssGf7F5aBt
         WYmghKv+9veCqp6KV66loj1NnG8YEIVDXHrpBKcjbBc0P/HdkDIbKkrG+tBJBBehBXkM
         xSZk7YvmvWKtDC7xXHIhIqonSG1I4iilS9REipPJlWGsRpxQZIYUOCsLenpAW42skHOV
         xbZNcZLbh8Mfvcm/ftKq059GlBEu8SR4sp0Jdkgs2UZVYipSKdkR4n4PaTJWg45eN4sM
         NZ7k3OmCO5ClcCpEeGp1b/bSodjKfhB4eXraPrrFdWCjaJRWBGIiKMdt22RleYJrr+fw
         6j/w==
X-Gm-Message-State: AOAM5319lVTJjEZINPBxjZzP41vjIpzrZwoUmHGp4Qro+28jH+LyAeCA
        doXchUxaPc6FxQ4FKVHCjKv/u4XdXr8cYQ==
X-Google-Smtp-Source: ABdhPJyIx02RwUtcvRde34zG7lbea0Fa2mXoIyX2Q9DIfqUQV3LXlDpUJUf3Tds3OGT7Mc8YNhlfhw==
X-Received: by 2002:a2e:80a:: with SMTP id 10mr8137750lji.122.1597709325380;
        Mon, 17 Aug 2020 17:08:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t12sm5195171lfe.43.2020.08.17.17.08.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:08:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id b11so9273219lfe.10
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 17:08:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr8518837lfp.10.1597709323252;
 Mon, 17 Aug 2020 17:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-12-ebiederm@xmission.com>
In-Reply-To: <20200817220425.9389-12-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 17:08:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com>
Message-ID: <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
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

On Mon, Aug 17, 2020 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead hold task_lock for the duration that task->files needs to be
> stable in seq_show.  The task_lock was already taken in
> get_files_struct, and so skipping get_files_struct performs less work
> overall, and avoids the problems with the files_struct reference
> count.

Hmm. Do we even need that task_lock() at all? Couldn't we do this all
with just the RCU lock held for reading?

As far as I can tell, we don't really need the task lock. We don't
even need the get/pid_task_struct().

Can't we just do

        rcu_read_lock();
        task = pid_task(proc_pid(inode), PIDTYPE_PID);
        if (task) {
                unsigned int fd = proc_fd(m->private);
                struct file *file = fcheck_task(task, fd);
                if (file)
                        .. do the seq_printf ..

and do it all with no refcount games or task locking at all?

Anyway, I don't dislike your patch per se, I just get the feeling that
you could go a bit further in that cleanup..

And it's quite possible that I'm wrong, and you can't just use the RCU
lock, but as far as I can tell, both the task lookup and the file
lookup *already* really both depend on the RCU lock anyway, so the
other locking and reference counting games really do seem superfluous.

Please just send me a belittling email telling me what a nincompoop I
am if I have missed something.

             Linus

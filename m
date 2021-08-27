Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A833F9142
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 02:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhH0AOm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 20:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhH0AOm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 20:14:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F19860FF2
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 00:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630023234;
        bh=8+20GDS1bVvbE1x+HnPTO0BWxoS3ZeFtWiSAW1yYu+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y9h23pGcKzI8iySvjrwAbMB3N5lBDIoGe1YcJ5lgoftSo1cxwaquZ2/ssjZYpf5eD
         YMImDIz7eJYs0UtMZjw7qf5gmM3M0pQgIHqAWjq0OAU59PjkVY9zfDdOJ+RE0vBhEc
         4nO7EMpbe34mQTJWAQHJOIWUROJlISgtjKET041AREp7BSa77w64wQ4AzA1ZxYh6XW
         aeASoyUxnzF7V+O3mIplonhQQGPGISSeqxAgAgc0sNZFzQmT/foIW16nmQZNgL7kav
         T6LHX71HtwAoDINKIcbNK6qWRFytYXHOK+Uhxzb7sZkrn0Fl8d0UrEJcwzknUjmmNT
         hXgzNM2MylPyw==
Received: by mail-ej1-f43.google.com with SMTP id a25so10009139ejv.6
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 17:13:53 -0700 (PDT)
X-Gm-Message-State: AOAM530Y1DtAOxbfwgZmXO/HtX+rMIHUWZAjF3e2Ru3Uxppqk4VewRQj
        gJIfxJwyW94BDoK1jhgO21LpA/Zen7kuI3IRoNmx9w==
X-Google-Smtp-Source: ABdhPJwrEvWZj4Gw/kGE72tI1xtiT0acEysutyJ6BlBDXu+rTG0IcKC18+f6/qVnGBhJ8+L332REzTfreetxvofdpRo=
X-Received: by 2002:a17:906:d8a8:: with SMTP id qc8mr6853805ejb.368.1630023232505;
 Thu, 26 Aug 2021 17:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210826133913.627361-1-memxor@gmail.com> <20210826133913.627361-2-memxor@gmail.com>
 <20210826222347.3bf5q5ehdfnrblir@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210826222347.3bf5q5ehdfnrblir@ast-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 27 Aug 2021 02:13:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6G-E6X2hxwQfwqJ6Hgm-CbiNnY6h+xZRhO1AuOUu0NJA@mail.gmail.com>
Message-ID: <CACYkzJ6G-E6X2hxwQfwqJ6Hgm-CbiNnY6h+xZRhO1AuOUu0NJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Implement file local storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 27, 2021 at 12:23 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 26, 2021 at 07:09:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> > +BPF_CALL_2(bpf_file_storage_delete, struct bpf_map *, map, struct file *, file)
> > +{
> > +     if (!file)
> > +             return -EINVAL;
> > +
> > +     return file_storage_delete(file, map);
> > +}
>
> It's exciting to see that file local storage is coming to life.
>

+1 Thanks for your work!

> What is the reason you've copy pasted inode_local_storage implementation,
> but didn't copy any comments?
> They were relevant there and just as relevant here.
> For example in the above *_storage_delete, the inode version would say:
>
> /* This helper must only called from where the inode is guaranteed
>  * to have a refcount and cannot be freed.
>  */
>
> That comment highlights the important restriction.
> The 'file' pointer should have similar restriction, right?
> But files are trickier than inodes in terms of refcnt.
> They are more similar to sockets,
> the socket_local_storage is doing refcount_inc_not_zero() in similar

Even the task_local_storage checks if the task is refcounted and going to
be around while we do a get / delete.

> case to make sure socket doesn't disappear.
>

Agreed, I would prefer if we also revisit inode_local_storage
in this respect pretty much because of what Alexei said.
One could end up with an inode (e.g. by walking pointers) in an LSM hook
whose life-cycle is not guaranteed in the current context.

This is generally not that big a deal with inodes because they are
not as ephemeral as tasks, sockets and files.

e.g. your userspace "_fd_" version of the helper does the right thing
by grabbing a
reference to the file and then dropping it once the storage is updated.

> May be socket_local_storage implementation should have been a base
> of copy-paste instead of inode_local_storage?
> Not paying attention to comments leads to this fundamental question:
> What analysis have you done to prove that this approach is correct vs
> life time of the file object?
>
> The selftest hooks into lsm/file_open and lsm/file_fcntl.
> In these cases the file pointer is valid, but the file ptr
> can be accessed via walking pointers of other objects.
>
> See commit cf28f3bbfca0 ("bpf: Use get_file_rcu() instead of get_file() for task_file iterator")
> that fixes a tricky issue with file iterator.
> It highlights that it's pretty difficult to implement 'struct file' access
> correctly. Let's double down on the safety analysis of the file local storage.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33B3E0A81
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 00:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhHDWot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Aug 2021 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhHDWot (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Aug 2021 18:44:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC7C0613D5
        for <bpf@vger.kernel.org>; Wed,  4 Aug 2021 15:44:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id w17so6058701ybl.11
        for <bpf@vger.kernel.org>; Wed, 04 Aug 2021 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6EnkuAx53dPwdZRKiXg6cLUA4uROzub5Xdmh+A9rUI=;
        b=oyW4rAuvGQMt9QhwIcKjS6/gVSKq1jAX46ECgRRJL0L+o7ZhDnTaWZHzcAF1AiVH7Q
         4S4B3BMgPgW+Daz/9L82Q9knIZXjwxhmTb9+syELotWzh7U164o051xb1KUT9aRJjY9R
         cjuj9iSvRo+4+y0vupcHQJe+8b6nMGcItwUIq9ZmNBnv0whv659jJly7WD3DXGkpYRqf
         Y50t9UVYFNh2OuZoURBqDgecSPFS3IolxaKtGx5T1uKGJ5Ow0x+3KMhN+nRzYj81+xfM
         b9Rk+995CjkLMHOVfhG5fdCE7on2inMfN4Vx3TFKlan2N022UvwVY8XCRG4W/FecX1WZ
         cYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6EnkuAx53dPwdZRKiXg6cLUA4uROzub5Xdmh+A9rUI=;
        b=cI5QxG+xGHAm8q48QmlDcz0Zk31lxGbS8lSu6BNzhFeCnG8fcBWBvecJgU8nkNpgKA
         w/jsYMLdvU6v5eL/JXtQF8tY2MEo0j7KALquqwlqDfRjwCAQvQbtvprrYajFtuxJWj/U
         VGco2TZkmw5WhvNTiKuYpnSDH08KOmFOlU9zwlxKpm0hz6oBJt3lAVwJ54QYBdWLmtvE
         bclj3El+pZ+bxCAVx5Egm5L6WVdOuwx86SHSIlJbiJu7LojLwG5Z8Ke3AYBUohRAPvla
         bhRTWTdmt+O7XxqPIiX4pp4xQIeu+65EQcrt0aRXcI9CjMd42xA3TkKmpp1P60Q6Lh8S
         mI7w==
X-Gm-Message-State: AOAM533PErrsdRYFu9hJrq9cOgb3zfzpgTaDliA4+xLPx/y2NoboWHTu
        UD4De5bpc6BYPqHXVHG8zQjQ2mZPmEgRQx73gMs=
X-Google-Smtp-Source: ABdhPJxNEkAsybkRX2l1JrXsj04wP50Xi8sY02qKMtHvTcRX4cGZqnCIOe6rmJaYgBcIR9KzJy5fp0Eqxq2BfyUgxY4=
X-Received: by 2002:a25:9942:: with SMTP id n2mr2186232ybo.230.1628117074865;
 Wed, 04 Aug 2021 15:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210727132532.2473636-1-hengqi.chen@gmail.com>
 <20210727132532.2473636-3-hengqi.chen@gmail.com> <ff963256-ea65-b8ba-05d0-fba3b03843d0@iogearbox.net>
In-Reply-To: <ff963256-ea65-b8ba-05d0-fba3b03843d0@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Aug 2021 15:44:23 -0700
Message-ID: <CAEf4BzZqvVVTRjoe2h9LyrYKwH=JwbEnzOWzBqnNCVLJfbeuYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: expose bpf_d_path helper to vfs_*
 and security_* functions
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yaniv Agman <yanivagman@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 4, 2021 at 3:35 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/27/21 3:25 PM, Hengqi Chen wrote:
> > Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
> > bpf_d_path helper to extract full file path from these functions' arguments.
> > This will help tools like BCC's filetop[1]/filelife to get full file path.
> >
> > [1] https://github.com/iovisor/bcc/issues/3527
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >   kernel/trace/bpf_trace.c | 60 +++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 56 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index c5e0b6a64091..e7b24abcf3bf 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -849,18 +849,70 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
> >
> >   BTF_SET_START(btf_allowlist_d_path)
> >   #ifdef CONFIG_SECURITY
> > +BTF_ID(func, security_bprm_check)
> > +BTF_ID(func, security_bprm_committed_creds)
> > +BTF_ID(func, security_bprm_committing_creds)
> > +BTF_ID(func, security_bprm_creds_for_exec)
> > +BTF_ID(func, security_bprm_creds_from_file)
> > +BTF_ID(func, security_file_alloc)
>
> Did you actually try these out, e.g. attaching BPF progs invoking bpf_d_path() to all
> these, then generate some workload like kernel build for testing?
>
> I presume not, since something like security_file_alloc() would crash the kernel. Right
> before it's called in __alloc_file() we fetch a struct file from kmemcache, and only
> populate f->f_cred there. Most LSMs, for example, only populate their secblob through the
> callback. If you call bpf_d_path(&file->f_path, ...) with it, you'll crash in d_path()
> when path->dentry->d_op is checked.. given f->f_path is all zeroed structure at that
> point.
>
> Please do your due diligence and invest each of them manually, maybe the best way is
> to hack up small selftests for each enabled function that our CI can test run? Bit of a
> one-time effort, but at least it ensures that those additions are sane & checked.

I think it's actually a pretty fun exercise and a good selftest to
have. We can have a selftest which will attach a simple BPF program
just to grab a contents of btf_allowlist_d_path (with typeless ksyms,
for instance). Then for each BTF ID in there, as a subtest, attach
another BPF object with fentry BPF program doing something with
d_path.

Hengqi, you'd need to have few variants for each possible position of
file or path struct (e.g., file as first arg; as second arg; etc, same
for hooks working with path directly), but I don't think that's going
to be a lot of them.

So as Daniel said, a bit of a work, but we'll have a much better
confidence that we are not accidentally opening a big kernel crashing
loophole.

>
> > +BTF_ID(func, security_file_fcntl)
> > +BTF_ID(func, security_file_free)
> > +BTF_ID(func, security_file_ioctl)
> > +BTF_ID(func, security_file_lock)
> > +BTF_ID(func, security_file_open)
> >   BTF_ID(func, security_file_permission)
> > +BTF_ID(func, security_file_receive)
> > +BTF_ID(func, security_file_set_fowner)
> >   BTF_ID(func, security_inode_getattr)
> > -BTF_ID(func, security_file_open)
> > +BTF_ID(func, security_sb_mount)
> >   #endif
> >   #ifdef CONFIG_SECURITY_PATH
> > +BTF_ID(func, security_path_chmod)
> > +BTF_ID(func, security_path_chown)
> > +BTF_ID(func, security_path_chroot)
> > +BTF_ID(func, security_path_link)
> > +BTF_ID(func, security_path_mkdir)
> > +BTF_ID(func, security_path_mknod)
> > +BTF_ID(func, security_path_notify)
> > +BTF_ID(func, security_path_rename)
> > +BTF_ID(func, security_path_rmdir)
> > +BTF_ID(func, security_path_symlink)
> >   BTF_ID(func, security_path_truncate)
> > +BTF_ID(func, security_path_unlink)
> >   #endif
> > -BTF_ID(func, vfs_truncate)
> > -BTF_ID(func, vfs_fallocate)
> >   BTF_ID(func, dentry_open)
> > -BTF_ID(func, vfs_getattr)
> >   BTF_ID(func, filp_close)
> > +BTF_ID(func, vfs_cancel_lock)
> > +BTF_ID(func, vfs_clone_file_range)
> > +BTF_ID(func, vfs_copy_file_range)
> > +BTF_ID(func, vfs_dedupe_file_range)
> > +BTF_ID(func, vfs_dedupe_file_range_one)
> > +BTF_ID(func, vfs_fadvise)
> > +BTF_ID(func, vfs_fallocate)
> > +BTF_ID(func, vfs_fchmod)
> > +BTF_ID(func, vfs_fchown)
> > +BTF_ID(func, vfs_fsync)
> > +BTF_ID(func, vfs_fsync_range)
> > +BTF_ID(func, vfs_getattr)
> > +BTF_ID(func, vfs_getattr_nosec)
> > +BTF_ID(func, vfs_iocb_iter_read)
> > +BTF_ID(func, vfs_iocb_iter_write)
> > +BTF_ID(func, vfs_ioctl)
> > +BTF_ID(func, vfs_iter_read)
> > +BTF_ID(func, vfs_iter_write)
> > +BTF_ID(func, vfs_llseek)
> > +BTF_ID(func, vfs_lock_file)
> > +BTF_ID(func, vfs_open)
> > +BTF_ID(func, vfs_read)
> > +BTF_ID(func, vfs_readv)
> > +BTF_ID(func, vfs_setlease)
> > +BTF_ID(func, vfs_setpos)
> > +BTF_ID(func, vfs_statfs)
> > +BTF_ID(func, vfs_test_lock)
> > +BTF_ID(func, vfs_truncate)
> > +BTF_ID(func, vfs_utimes)
> > +BTF_ID(func, vfs_write)
> > +BTF_ID(func, vfs_writev)
> >   BTF_SET_END(btf_allowlist_d_path)
> >
> >   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> >
>

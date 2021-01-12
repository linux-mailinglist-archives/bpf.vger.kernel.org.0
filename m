Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60242F2903
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbhALHgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhALHgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 02:36:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4619E22CBE
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610436952;
        bh=c+57gT08wHmO0uTf1XcWzTlK1Vv+kpJKqI53a2kE5MA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjwK4CsZeXST0hmyPnPs+EXes7OqVauXXaY0de6/DGA6CTW5Qix+txCDAcrijZi01
         hx9EMCNaUqyEk3e6cFx2fBWydzJEsrH6P2kKRBWflJ1yOV9Nzr2OXh2RmBbfeC3GgW
         AAqYVoKuXz8iGa8iJ5embmEVq3VJkBqhk+++m5d7VNIBRnlhHljKnHd52h5VMfU47x
         dQwgg3WPGeJhMCqjHHaL85gzucDIrxOJApKhYAZUbSeVZqXOgedarAE1uQdmA55p3m
         RBd09R+547m/VQn4APspjRO8LxYOGDuVDmzyvx8kLagRNqB3TaWP8dl2fvGMqA+XjH
         35EJ1VB7rXUxQ==
Received: by mail-lj1-f182.google.com with SMTP id n8so1780056ljg.3
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 23:35:52 -0800 (PST)
X-Gm-Message-State: AOAM532lKG7KDC3acETcWwFEDSsflDwPz4AT9bms6U5FI+pjpfQFw766
        4zHR20g4yjv54ZDoIZvPkIgCcrILbKrIcSmdAHh2aw==
X-Google-Smtp-Source: ABdhPJyJ1Nq4oHk69WibvenikicFG3kzrs7xCOALAIbYD3CLE7wpJ2QHJFbm1w2HKL0yP0ESytPPEKf1QhUGRTR9js8=
X-Received: by 2002:a2e:b5dc:: with SMTP id g28mr1472972ljn.112.1610436950465;
 Mon, 11 Jan 2021 23:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20210111212340.86393-1-kpsingh@kernel.org> <20210111212340.86393-2-kpsingh@kernel.org>
 <317e2cb6-3774-b343-d93b-5b6f1d41b97e@fb.com>
In-Reply-To: <317e2cb6-3774-b343-d93b-5b6f1d41b97e@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Jan 2021 08:35:39 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4+H1XLF4DW7+0K+zFCFtzkdZQQAzk_UWsj5Bs9HaTa=Q@mail.gmail.com>
Message-ID: <CACYkzJ4+H1XLF4DW7+0K+zFCFtzkdZQQAzk_UWsj5Bs9HaTa=Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: update local storage test to check
 handling of null ptrs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 8:25 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/11/21 1:23 PM, KP Singh wrote:
> > It was found in [1] that bpf_inode_storage_get helper did not check
> > the nullness of the passed owner ptr which caused an oops when
> > dereferenced. This change incorporates the example suggested in [1] into
> > the local storage selftest.
> >
> > The test is updated to create a temporary directory instead of just
> > using a tempfile. In order to replicate the issue this copied rm binary
> > is renamed tiggering the inode_rename with a null pointer for the
> > new_inode. The logic to verify the setting and deletion of the inode
> > local storage of the old inode is also moved to this LSM hook.
> >
> > The change also removes the copy_rm function and simply shells out
> > to copy files and recursively delete directories and consolidates the
> > logic of setting the initial inode storage to the bprm_committed_creds
> > hook and removes the file_open hook.
> >
> > [1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
> >
> > Suggested-by: Gilad Reti <gilad.reti@gmail.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Ack with one nit below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---

[...]

> > @@ -189,18 +136,24 @@ void test_test_local_storage(void)
> >                                     task_fd))
> >               goto close_prog;
> >
> > -     err = copy_rm(tmp_exec_path);
> > -     if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
> > +     mkdtemp(tmp_dir_path);
> > +     if (CHECK(errno < 0, "mkdtemp", "unable to create tmpdir: %d\n", errno))
>
> I think checking mkdtemp return value is more reliable than checking
> errno. It is possible mkdtemp returns 0 and errno is not 0 (inheritted
> from previous syscall).

You are right, I will send in a v3 with this fixed and also add your Acks.
Thanks!

>
> >               goto close_prog;
> >
> > +     snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
> > +              tmp_dir_path);
> > +     snprintf(cmd, sizeof(cmd), "cp /bin/rm %s", tmp_exec_path);
> > +     if (CHECK_FAIL(system(cmd)))
> > +             goto close_prog_rmdir;
> > +
> [...]

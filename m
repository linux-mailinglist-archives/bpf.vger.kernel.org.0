Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06833D30AD
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 02:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGVXeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhGVXeI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Jul 2021 19:34:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69FC061575
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 17:14:42 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t186so8158326ybf.2
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHJH5c9B6WYweioonEdOW0lhsr+fwKwl9h4lA9WawaA=;
        b=pOckPTksVlp+b0DxGP7yLE52xRjhAx00DJkKXcSUbGbE4Kk1Y6yRdfuFLt3GW9MAtK
         sW0ltBDzcNgng+ce5siAVY9QpY6kBXlPlVnxSG/JHPdRIOIYsH1ZK+8jIqZpy4aF1pU0
         R595eJ1bv+wXJhA/wjXX0CHR1/19LwWbP+/AUJf7hA1ba8pIeANxLuFkfghFT51VtR/A
         JKwWgdTCo/mqfClY0Cf/Je/7FhPJ7cQPGJq4KkZcRtGkanVzZX9BkcGNHFgWIcrwPUD2
         WvvRCH1J1nobW2tPasO2svYgvkdYvfEBW8iUWfKD7NIJoozFO5VoUVtw4R9OIbKh1FSa
         P4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHJH5c9B6WYweioonEdOW0lhsr+fwKwl9h4lA9WawaA=;
        b=F6o+YPXUPhrT1ORbCEL12SBZfczM/ODul75lf+TcJ19S8a5ynXD9l/kx+uh1N0uDic
         1Bt5qwUN9qDcsXjr0mxCfyR2OlfR6C+GHZJuzlJbueHySkhENXYA1nQvRRA25DsJsW1+
         ergur8PruhzgXZM5lVDVTJA793vHUwOksItNgq8WnD2Kiq0kfknbWGgH3MBr65Bicuot
         5qrzTrwTxm8Ebx2rzBTP7fx+39ZRyPhOI3OmGzpjsKHRUjr3uecfQMovozPBXI5SjAd8
         vQ2vb/j1o85BS2xjgD8S1uSd+8G6WtI0YGTfSybe/EAEtrv6/+Lbin1vOpyu3TVPFzpU
         sGbw==
X-Gm-Message-State: AOAM53292EaiW/f9ZpHfs8AAXGiqiSbA5BsAp5zPmSyyuv/FEHagW4iB
        +yXX8JMSM0dqroQeLrK/3P1ysJA1hZ6Hm3Hd5us=
X-Google-Smtp-Source: ABdhPJy7HuJco1ADRnSuAxoTZleGuqG9xq9Scus6uZotz9VTb84diCKAO+OmwNcknsVbwMB5yBn4V6llsSfTwqscORA=
X-Received: by 2002:a25:9942:: with SMTP id n2mr2975879ybo.230.1626999281795;
 Thu, 22 Jul 2021 17:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210719151753.399227-1-hengqi.chen@gmail.com>
 <CAEf4BzborEP9oEa9VHkMnWFozXHOdVRf9BbbdNYOT5PEX6cdcQ@mail.gmail.com> <bf75e892-80f9-da10-599a-c89043a5a9e8@gmail.com>
In-Reply-To: <bf75e892-80f9-da10-599a-c89043a5a9e8@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Jul 2021 17:14:30 -0700
Message-ID: <CAEf4BzYYg4WM-Sh8GKyNB-j+KXSHsCBRTxe96HQ1uah6JSkuoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: expose bpf_d_path helper to vfs_* and
 security_* functions
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 21, 2021 at 10:01 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2021/7/20 3:02 AM, Andrii Nakryiko wrote:
> > On Mon, Jul 19, 2021 at 8:18 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
> >> bpf_d_path helper to extract full file path from these functions'
> >> `struct path *` and `struct file *` arguments. This will help tools
> >> like IOVisor's filetop[2]/filelife to get full file path.
> >>
> >> Changes since v1: [1]
> >>  - Alexei and Yonghong suggested that bpf_d_path helper could also
> >>    apply to vfs_* and security_file_* kernel functions. Added them.
> >>
> >> [1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
> >> [2] https://github.com/iovisor/bcc/issues/3527
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>  kernel/trace/bpf_trace.c | 50 ++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 48 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 08906007306d..c784f3c7143f 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -850,16 +850,62 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
> >>  BTF_SET_START(btf_allowlist_d_path)
> >>  #ifdef CONFIG_SECURITY
> >>  BTF_ID(func, security_file_permission)
> >> -BTF_ID(func, security_inode_getattr)
> >>  BTF_ID(func, security_file_open)
> >> +BTF_ID(func, security_file_ioctl)
> >> +BTF_ID(func, security_file_free)
> >> +BTF_ID(func, security_file_alloc)
> >> +BTF_ID(func, security_file_lock)
> >> +BTF_ID(func, security_file_fcntl)
> >> +BTF_ID(func, security_file_set_fowner)
> >> +BTF_ID(func, security_file_receive)
> >> +BTF_ID(func, security_inode_getattr)
> >>  #endif
> >>  #ifdef CONFIG_SECURITY_PATH
> >>  BTF_ID(func, security_path_truncate)
> >> +BTF_ID(func, security_path_notify)
> >> +BTF_ID(func, security_path_unlink)
> >> +BTF_ID(func, security_path_mkdir)
> >> +BTF_ID(func, security_path_rmdir)
> >> +BTF_ID(func, security_path_mknod)
> >> +BTF_ID(func, security_path_symlink)
> >> +BTF_ID(func, security_path_link)
> >> +BTF_ID(func, security_path_rename)
> >> +BTF_ID(func, security_path_chmod)
> >> +BTF_ID(func, security_path_chown)
> >> +BTF_ID(func, security_path_chroot)
> >>  #endif
> >>  BTF_ID(func, vfs_truncate)
> >>  BTF_ID(func, vfs_fallocate)
> >> -BTF_ID(func, dentry_open)
> >>  BTF_ID(func, vfs_getattr)
> >> +BTF_ID(func, vfs_fadvise)
> >> +BTF_ID(func, vfs_fchmod)
> >> +BTF_ID(func, vfs_fchown)
> >> +BTF_ID(func, vfs_open)
> >> +BTF_ID(func, vfs_setpos)
> >> +BTF_ID(func, vfs_llseek)
> >> +BTF_ID(func, vfs_read)
> >> +BTF_ID(func, vfs_write)
> >> +BTF_ID(func, vfs_iocb_iter_read)
> >> +BTF_ID(func, vfs_iter_read)
> >> +BTF_ID(func, vfs_readv)
> >> +BTF_ID(func, vfs_iocb_iter_write)
> >> +BTF_ID(func, vfs_iter_write)
> >> +BTF_ID(func, vfs_writev)
> >> +BTF_ID(func, vfs_copy_file_range)
> >> +BTF_ID(func, vfs_getattr_nosec)
> >> +BTF_ID(func, vfs_ioctl)
> >> +BTF_ID(func, vfs_fsync_range)
> >> +BTF_ID(func, vfs_fsync)
> >> +BTF_ID(func, vfs_utimes)
> >> +BTF_ID(func, vfs_statfs)
> >> +BTF_ID(func, vfs_dedupe_file_range_one)
> >> +BTF_ID(func, vfs_dedupe_file_range)
> >> +BTF_ID(func, vfs_clone_file_range)
> >> +BTF_ID(func, vfs_cancel_lock)
> >> +BTF_ID(func, vfs_test_lock)
> >> +BTF_ID(func, vfs_setlease)
> >> +BTF_ID(func, vfs_lock_file)
> >> +BTF_ID(func, dentry_open)
> >>  BTF_ID(func, filp_close)
> >>  BTF_SET_END(btf_allowlist_d_path)
> >>
> >
> > Before we lend this expanded list of allowed functions, I think we
> > should address an issue that comes up from time to time with .BTF_ids.
> > Sometimes the referenced function can be changed from global to static
> > and get inlined by the compiler, and thus disappears from BTF
> > altogether. This will result in kernel build failure causing a lot of
> > confusion, because the change might be done by people unfamiliar with
> > the BTF_ID() stuff and not even aware of it.
> >
>
> Thanks for the detailed background.
> I was able to reproduce this kernel build failure.
>
> > This came up a few times before and it's frustrating for everyone
> > involved. Before we proceed with extending the list further, let's
> > teach resolve_btfids to warn on such missing function (so that we are
> > at least aware) but otherwise ignore it (probably leaving ID as zero,
> > but let's also confirm that all the users of BTF_ID() stuff handle
> > those zeros correctly).
> >
>
> Do you mean that resolve_btfids should be updated to emit warning messages
> instead of aborting the build process ?

Yes. Just double-check that unresolved BTF IDs are filled out as zeros
and don't break anything.

>
> >> --
> >> 2.25.1
> >>

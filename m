Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0A3D21EA
	for <lists+bpf@lfdr.de>; Thu, 22 Jul 2021 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGVJdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGVJdu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Jul 2021 05:33:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5EC061575
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 03:14:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id go30so7568869ejc.8
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o/vyMP1jVs4gcQJMyYNogSkDkyiN1hvhWkhIaERfqpA=;
        b=bTW4VizRgZ9eoP0UC38XHDstg6hT1NHCRSDKE6XwsIIaQ8FnYrj6oC+MnV1CLCUHWx
         HKycFPa5tnCGF382JCGO7BDBp13bpgNn/oyTBnsQEtkgTgtqoJF/9YchGs7qAJNsBdfC
         gA7xF4zuUmFe0qs8OF6PdzUq+NUSuN0o+CIGeVu9ocqsd00UDgbkr6OD2q0noPeY9ihX
         Zw1L7kpWoorDJ8r/ClLlTbPTSNg3voyhiYikIX1owJ4nlnisHRvAPGxfl6Jb1AX93kw6
         e2v7jEB5FRCl1jrBXCDV2Zu0yZMPQ/B2m1c3LyrpCjwI4Ys6+Rfve5Nf5FEFRH7vUqxU
         0LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o/vyMP1jVs4gcQJMyYNogSkDkyiN1hvhWkhIaERfqpA=;
        b=NZLa1FpweQHMHCwtc5ObOjyIYHB27FOEw/XYrW9BCxzydkHipvRherBPZRiUsilACC
         J4nJ7sDAg2uuKBDR8RhwYr3nKab2za52fD4EP2mGY3yEfLf7Yjllw9FLNKZppvXcNSzw
         npEoGGEKCzEXNUrHqqwg6gHc831YYurSo+56l8L6YfkKHVgjt6830d7H1FbR3hsfbg78
         o1By7iCIQFHBCJwPTjYd7w/YJdaGtue5Vzou9ngvs9BcEQBWtEfutspbg0e0dUt4rFMQ
         vN3VS/2hbDYkZlP1g1t3F9eL9eMq9ZCfNcZ1Z/T3/hfN5epWhJAC+XACIN6Ii8Uwpl4u
         LUyQ==
X-Gm-Message-State: AOAM533B4z0IeWJuN7OT3j9pcPpe1XBe3vDcAnz47Ec45B/gLzFAvSJV
        Uvwlg7e0owWt3XHMzK1GtiWPRW12ESxHP386iAw=
X-Google-Smtp-Source: ABdhPJxxXQkaFFaPOqYwHW3G1hLGZjH0DHwTvzRwKu7gUlJpWlWMivtlNXN1ZvDuUOU1f4Z42Cn8tJ7PXOmFP/KcGj4=
X-Received: by 2002:a17:906:d961:: with SMTP id rp1mr9315603ejb.68.1626948863562;
 Thu, 22 Jul 2021 03:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210719151753.399227-1-hengqi.chen@gmail.com>
In-Reply-To: <20210719151753.399227-1-hengqi.chen@gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Thu, 22 Jul 2021 13:15:11 +0300
Message-ID: <CAMy7=ZUB36TL-8PmtJ_Nm48PFmdjSBVLYXWKyFiqm6QCOYZrMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: expose bpf_d_path helper to vfs_* and
 security_* functions
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        Yonghong Song <yhs@fb.com>, john.fastabend@gmail.com,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 19 =D7=91=D7=99=D7=95=D7=9C=D7=99 2021 =D7=91-18:43 =D7=9E=D7=90=D7=AA=
 =E2=80=AAHengqi Chen=E2=80=AC=E2=80=8F
<=E2=80=AAhengqi.chen@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
> bpf_d_path helper to extract full file path from these functions'
> `struct path *` and `struct file *` arguments. This will help tools
> like IOVisor's filetop[2]/filelife to get full file path.
>
> Changes since v1: [1]
>  - Alexei and Yonghong suggested that bpf_d_path helper could also
>    apply to vfs_* and security_file_* kernel functions. Added them.
>
> [1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmai=
l.com/
> [2] https://github.com/iovisor/bcc/issues/3527
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  kernel/trace/bpf_trace.c | 50 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 08906007306d..c784f3c7143f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -850,16 +850,62 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *,=
 buf, u32, sz)
>  BTF_SET_START(btf_allowlist_d_path)
>  #ifdef CONFIG_SECURITY
>  BTF_ID(func, security_file_permission)
> -BTF_ID(func, security_inode_getattr)
>  BTF_ID(func, security_file_open)
> +BTF_ID(func, security_file_ioctl)
> +BTF_ID(func, security_file_free)
> +BTF_ID(func, security_file_alloc)
> +BTF_ID(func, security_file_lock)
> +BTF_ID(func, security_file_fcntl)
> +BTF_ID(func, security_file_set_fowner)
> +BTF_ID(func, security_file_receive)
> +BTF_ID(func, security_inode_getattr)
>  #endif
>  #ifdef CONFIG_SECURITY_PATH
>  BTF_ID(func, security_path_truncate)
> +BTF_ID(func, security_path_notify)
> +BTF_ID(func, security_path_unlink)
> +BTF_ID(func, security_path_mkdir)
> +BTF_ID(func, security_path_rmdir)
> +BTF_ID(func, security_path_mknod)
> +BTF_ID(func, security_path_symlink)
> +BTF_ID(func, security_path_link)
> +BTF_ID(func, security_path_rename)
> +BTF_ID(func, security_path_chmod)
> +BTF_ID(func, security_path_chown)
> +BTF_ID(func, security_path_chroot)
>  #endif
>  BTF_ID(func, vfs_truncate)
>  BTF_ID(func, vfs_fallocate)
> -BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
> +BTF_ID(func, vfs_fadvise)
> +BTF_ID(func, vfs_fchmod)
> +BTF_ID(func, vfs_fchown)
> +BTF_ID(func, vfs_open)
> +BTF_ID(func, vfs_setpos)
> +BTF_ID(func, vfs_llseek)
> +BTF_ID(func, vfs_read)
> +BTF_ID(func, vfs_write)
> +BTF_ID(func, vfs_iocb_iter_read)
> +BTF_ID(func, vfs_iter_read)
> +BTF_ID(func, vfs_readv)
> +BTF_ID(func, vfs_iocb_iter_write)
> +BTF_ID(func, vfs_iter_write)
> +BTF_ID(func, vfs_writev)
> +BTF_ID(func, vfs_copy_file_range)
> +BTF_ID(func, vfs_getattr_nosec)
> +BTF_ID(func, vfs_ioctl)
> +BTF_ID(func, vfs_fsync_range)
> +BTF_ID(func, vfs_fsync)
> +BTF_ID(func, vfs_utimes)
> +BTF_ID(func, vfs_statfs)
> +BTF_ID(func, vfs_dedupe_file_range_one)
> +BTF_ID(func, vfs_dedupe_file_range)
> +BTF_ID(func, vfs_clone_file_range)
> +BTF_ID(func, vfs_cancel_lock)
> +BTF_ID(func, vfs_test_lock)
> +BTF_ID(func, vfs_setlease)
> +BTF_ID(func, vfs_lock_file)
> +BTF_ID(func, dentry_open)
>  BTF_ID(func, filp_close)
>  BTF_SET_END(btf_allowlist_d_path)
>
> --
> 2.25.1
>

Thanks for opening this PR!
I was looking for a way to do that in a tool I develop (Tracee), and
had to implement this functionality by myself:
https://github.com/aquasecurity/tracee/blob/main/tracee-ebpf/tracee/tracee.=
bpf.c#L1494

Maybe It's too much to ask, but I wonder if it will be possible to add
other functions to this allowlist.
Currently, other than vfs_write(v), and security_file_open, we also
need it for security_sb_mount and security_bprm_check.
For security_bprm_check() we extract the path from bprm->file->f_path.
Actually, any securty_* function that has a struct argument from which
it is possible to reach a path struct is a possible candidate for us.
In addition to this, we also use it for the sched_process_exec
tracepoint, but I'm not sure if adding a tracepoint is related here,
as it is not exactly a function.

Yaniv

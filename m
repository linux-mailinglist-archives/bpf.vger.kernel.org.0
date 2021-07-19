Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557B13CEF51
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhGSVuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384129AbhGSSVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 14:21:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19FC061574
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 11:51:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k184so29298180ybf.12
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=097gXe1prrDPd8B5+US0+iz7zu/vpU0vNyLIb8eV0qo=;
        b=NhcIIR5ilBZjJPGxhXBeiH4hOwcEyhd48BmJE19lTlMhLoQWIOCJZfubvJcov1qijY
         m2t1y8lGJYvtImLaemeJzr5U3vHxSTqVQYvJECKmtcW3//N5UBzT8gqOa/8Y7fl+HXTy
         2Y2jj5dH46iwIMHy3MdBnC1M1GUiq2Gg+8YwTsNiY2hNdQx81Taf+X+m76QlXLvh1OzL
         3XjfoIgVvj4OD/iRZgRLqKn3/D5oc9Pf6D9bFAbnxtMHrStUs4+MhFzoK1h5d1K55ZAz
         fq0frxCK61knfXxSAWLDGL8cuixArfvJeNKYLaZNuQOkHEdm7kS5hdhPWRFV3uBqRvVo
         ACnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=097gXe1prrDPd8B5+US0+iz7zu/vpU0vNyLIb8eV0qo=;
        b=jYrnoFLbK6oWQ+l669Y63dNCyHlw3oUpP2+hyvU/5XLBFVpqW2P2oyh5DSRMGrm+DX
         COSe0WbAQwnYgki3Ac8CYoAVgf2vmNgGb2LN4c5WLTQPWJ08RfleC+UkCR1lIlaiMsjN
         aYyi0b/KS8v4aKDArIf3DRxFIBWF41qbLPXvy0qbC/DXXsPmX18MYhAFfoWCNogE21s1
         jWgRsYJRRH3QNZJCG/v6lgOvBroIVcGka57OBqGD5ulD7OrEyU8Zs7AlKS7uZsmaELQL
         QG3TpV+KS0389DuTiqr5fl6HJMlscP2pYm30m55z2YfoHnu+Y7ojIzK1XQyVw92qOw8s
         eEdg==
X-Gm-Message-State: AOAM530jcjqvDtszwpKCfBvh40K1HdnpHf8s5q5Q5d+uOIPc9LJfpgVa
        QS+tzNpb6DAtYTR/fICqj1KpSTu82ve08lNJ7AU=
X-Google-Smtp-Source: ABdhPJyFKCIWbniRbOOHZ1Pd686e2IcV4DwdKD7Rx1CjwdnrpUa71goWdSbN5GLzLXsIq5zQiI/DcOic4rt2+7Crxzs=
X-Received: by 2002:a25:b741:: with SMTP id e1mr34345954ybm.347.1626721337825;
 Mon, 19 Jul 2021 12:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210719151753.399227-1-hengqi.chen@gmail.com>
In-Reply-To: <20210719151753.399227-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Jul 2021 12:02:06 -0700
Message-ID: <CAEf4BzborEP9oEa9VHkMnWFozXHOdVRf9BbbdNYOT5PEX6cdcQ@mail.gmail.com>
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

On Mon, Jul 19, 2021 at 8:18 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
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
> [1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
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
> @@ -850,16 +850,62 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
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

Before we lend this expanded list of allowed functions, I think we
should address an issue that comes up from time to time with .BTF_ids.
Sometimes the referenced function can be changed from global to static
and get inlined by the compiler, and thus disappears from BTF
altogether. This will result in kernel build failure causing a lot of
confusion, because the change might be done by people unfamiliar with
the BTF_ID() stuff and not even aware of it.

This came up a few times before and it's frustrating for everyone
involved. Before we proceed with extending the list further, let's
teach resolve_btfids to warn on such missing function (so that we are
at least aware) but otherwise ignore it (probably leaving ID as zero,
but let's also confirm that all the users of BTF_ID() stuff handle
those zeros correctly).

> --
> 2.25.1
>

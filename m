Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA54C5956
	for <lists+bpf@lfdr.de>; Sun, 27 Feb 2022 06:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiB0FTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Feb 2022 00:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiB0FTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Feb 2022 00:19:01 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D02BF0;
        Sat, 26 Feb 2022 21:18:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id ay5so5272416plb.1;
        Sat, 26 Feb 2022 21:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYI+LXbbkZPFFC9XcDUXZG81aMQ2hosXWFW9b6ZreDc=;
        b=UdFNT83gCTMmhxLP6Ui+tTWUGiIulf/rG5QlpYS/3oCJjAonujj1+M1a0tGPmaDWBY
         I2mslnulgrfIndJTTV7cOMUEjOGPk2sizZnwj36QgmJRtjPV51YZ7SecbYq1edGe8El7
         f4P+L+EZSw9sGrriIKLiPRn3BlwjZqOjARp/THAHeVRFZOcZAei6T1pMnQVs6OVXD3+z
         Q1LpPL7ifjXrx2UtrwHETQuJ3HRkv3SpaGikTT5UO5myE89c47fMsZluRZf3eJLfcpl2
         ThuOngFQpb+sqlWNmSN09uhyESOmNNKGGRPBSWjvSKHbmWFsJSD//yt02Ua20zHHm9l/
         azvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYI+LXbbkZPFFC9XcDUXZG81aMQ2hosXWFW9b6ZreDc=;
        b=HNj0gfQduZM0CxQdXlKk84TQDkQPChc8Huj4ndeu5mtcIJCMkqJHsxX9Jl+V0gMTpm
         E1Cup893LUGxPCzvVs5XC3n6Z4xACrXXuZY6Lt/PGbVgeVvZlKXE41pIbHbzpnofMXq5
         4hUdfhGhSac9/FUnf+ub165f/wrweNjrq9Npy64PMeoo0JeQbpeRvw7Gm0H70uuI2/u8
         X+glCF6eRa1UV6mi1ILD7apw/oJsS80mwycZOauz/Oqf6it43M0Jow6NnJeG3w0VB+lN
         IP72mZu3xnPYxkXQWQ2KK91VB/wJO+W42JjElo/QXlVjnLtmwGIwP76/g2jUQ5eMliRw
         QJ1g==
X-Gm-Message-State: AOAM532dDwhXpExof9S2Dubmh5v3duYRzux5Vet5902S+t0WEzP77P+i
        JgG7YRGMWCmuS2oD2TX7jdA=
X-Google-Smtp-Source: ABdhPJzPIeMNveCUomXkPpScbpB3z9dFlIxzuDvnkt9ldQMVIpMPaUVaHrBxw13PbZcxGyCuVQlPeA==
X-Received: by 2002:a17:90a:de02:b0:1bc:d277:66bd with SMTP id m2-20020a17090ade0200b001bcd27766bdmr10698864pjv.109.1645939104628;
        Sat, 26 Feb 2022 21:18:24 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id n125-20020a632783000000b003788c95b222sm450485pgn.9.2022.02.26.21.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 21:18:24 -0800 (PST)
Date:   Sun, 27 Feb 2022 10:48:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
Message-ID: <20220227051821.fwrmeu7r6bab6tio@apollo.legion>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-2-haoluo@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 26, 2022 at 05:13:31AM IST, Hao Luo wrote:
> This patch allows bpf_syscall prog to perform some basic filesystem
> operations: create, remove directories and unlink files. Three bpf
> helpers are added for this purpose. When combined with the following
> patches that allow pinning and getting bpf objects from bpf prog,
> this feature can be used to create directory hierarchy in bpffs that
> help manage bpf objects purely using bpf progs.
>
> The added helpers subject to the same permission checks as their syscall
> version. For example, one can not write to a read-only file system;
> The identity of the current process is checked to see whether it has
> sufficient permission to perform the operations.
>
> Only directories and files in bpffs can be created or removed by these
> helpers. But it won't be too hard to allow these helpers to operate
> on files in other filesystems, if we want.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h            |   1 +
>  include/uapi/linux/bpf.h       |  26 +++++
>  kernel/bpf/inode.c             |   9 +-
>  kernel/bpf/syscall.c           | 177 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  26 +++++
>  5 files changed, 236 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f19abc59b6cd..fce5e26179f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1584,6 +1584,7 @@ int bpf_link_new_fd(struct bpf_link *link);
>  struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>
> +bool bpf_path_is_bpf_dir(const struct path *path);
>  int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>  int bpf_obj_get_user(const char __user *pathname, int flags);
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index afe3d0d7f5f2..a5dbc794403d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5086,6 +5086,29 @@ union bpf_attr {
>   *	Return
>   *		0 on success, or a negative error in case of failure. On error
>   *		*dst* buffer is zeroed out.
> + *
> + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
> + *	Description
> + *		Attempts to create a directory name *pathname*. The argument
> + *		*pathname_sz* specifies the length of the string *pathname*.
> + *		The argument *mode* specifies the mode for the new directory. It
> + *		is modified by the process's umask. It has the same semantic as
> + *		the syscall mkdir(2).
> + *	Return
> + *		0 on success, or a negative error in case of failure.
> + *
> + * long bpf_rmdir(const char *pathname, int pathname_sz)
> + *	Description
> + *		Deletes a directory, which must be empty.
> + *	Return
> + *		0 on sucess, or a negative error in case of failure.
> + *
> + * long bpf_unlink(const char *pathname, int pathname_sz)
> + *	Description
> + *		Deletes a name and possibly the file it refers to. It has the
> + *		same semantic as the syscall unlink(2).
> + *	Return
> + *		0 on success, or a negative error in case of failure.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -5280,6 +5303,9 @@ union bpf_attr {
>  	FN(xdp_load_bytes),		\
>  	FN(xdp_store_bytes),		\
>  	FN(copy_from_user_task),	\
> +	FN(mkdir),			\
> +	FN(rmdir),			\
> +	FN(unlink),			\
>  	/* */
>

How about only introducing bpf_sys_mkdirat and bpf_sys_unlinkat? That would be
more useful for other cases in future, and when AT_FDCWD is passed, has the same
functionality as these, but when openat/fget is supported, it would work
relative to other dirfds as well. It can also allow using dirfd of the process
calling read for a iterator (e.g. if it sets the fd number using skel->bss).
unlinkat's AT_REMOVEDIR flag also removes the need for a bpf_rmdir.

WDYT?

> [...]

--
Kartikeya

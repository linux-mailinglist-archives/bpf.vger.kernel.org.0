Return-Path: <bpf+bounces-611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A7704835
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498B71C20DB5
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064372C732;
	Tue, 16 May 2023 08:52:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE742C72E
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 08:52:35 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C8E448B
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 01:52:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965e93f915aso2477086266b.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684227143; x=1686819143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tO0c/BywFTnjdDcELi/kEm5j/zZ8DLnzA4mRKEi3Fmc=;
        b=PO+G6kjo0ZwUIgMBb0+sz/23vLVT6RTS30qmUxZ1hVkjo1P3CERxQwVOqn1ycWcjVs
         b/sxi2l3P1/O5EVEQqITEB/60+IUVC9tgPNidZAtOe4QVmEdYwZzDYofPc97kQczTPQu
         uOTEJZ688G+xquJ9myE7XX9Lemq7+CARoSZ/v42LraaFsH6zFNrDX1vKzhVed8+v1ZGS
         dMw9TCpEtrMUxo4+Lq02tY31LzPfMM3zXWyPyKOtUgmQlwbaAC2nh0+Ya9ez2UpqWgq7
         0vTlp6K+lP7Q3IlPkfsUyYlBsIacGNaWqpGh0Vi5lAzD/lCWLcJqsUysjo7fn5N62s48
         V7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227143; x=1686819143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO0c/BywFTnjdDcELi/kEm5j/zZ8DLnzA4mRKEi3Fmc=;
        b=L33YsHDB2XlPPVUN+qXSertP4dOp+o5qtZyUtWS+kJgNaDy8U2uin6WQDQpVXcffTx
         +wloZg4GVAa2kfFTtlCcO1fhopzwY6Vjwmhk5sRv9tA7pAezV7phYV1vvqzcOet0EvTw
         8aAQyI0ZHEhijSNqyLZDONyV4vldQgQMMQRwm83rGSy+Gkx1kfOXIdG+pNtNR5cQgeCc
         9AqNuq5+Foa14Y9OOfLrmXwKpD17le0F+OWuJYoRlY4nJ3PYRQSpH8uPkcKNCmonysxO
         Qpnu+1UDiHQEsU0sOPL0CXVRLuVpVLJ58QV9Todrxmiv6ZxYYCA8CVOuAkZi+XUI0wXS
         3aAw==
X-Gm-Message-State: AC+VfDza+V6cNPouNouRXOdqGa2icVVE4bNbJyHrIPdaJ1fK4mM6Bh+a
	qK59T0PxPx8HOY3E9cpDfGg=
X-Google-Smtp-Source: ACHHUZ6oTdkKmPsBoNWzab1HxKgqAUAk7UgHGyLEv8x0lGnVI+x6WxaDNVpkYLreG9w/fwwRwtctDA==
X-Received: by 2002:a17:907:60d2:b0:966:1813:3393 with SMTP id hv18-20020a17090760d200b0096618133393mr30493907ejc.46.1684227142694;
        Tue, 16 May 2023 01:52:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906064f00b0096a91ab434fsm6406238ejb.40.2023.05.16.01.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:52:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 May 2023 10:52:20 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, cyphar@cyphar.com, brauner@kernel.org,
	lennart@poettering.net
Subject: Re: [PATCH bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN and
 BPF_OBJ_GET commands
Message-ID: <ZGNERLZH65QgGGEE@krava>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516001348.286414-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 05:13:46PM -0700, Andrii Nakryiko wrote:
> Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> forces users to specify pinning location as a string-based absolute or
> relative (to current working directory) path. This has various
> implications related to security (e.g., symlink-based attacks), forces
> BPF FS to be exposed in the file system, which can cause races with
> other applications.
> 
> One of the feedbacks we got from folks working with containers heavily
> was that inability to use purely FD-based location specification was an
> unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> commands. This patch closes this oversight, adding path_fd field to
> BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> *at() syscalls for dirfd + pathname combinations.
> 
> This now allows interesting possibilities like working with detached BPF
> FS mount (e.g., to perform multiple pinnings without running a risk of
> someone interfering with them), and generally making pinning/getting
> more secure and not prone to any races and/or security attacks.
> 
> This is demonstrated by a selftest added in subsequent patch that takes
> advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> creating detached BPF FS mount, pinning, and then getting BPF map out of
> it, all while never exposing this private instance of BPF FS to outside
> worlds.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  4 ++--
>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/bpf/inode.c             | 16 ++++++++--------
>  kernel/bpf/syscall.c           |  8 +++++---
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  5 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 36e4b2d8cca2..f58895830ada 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>  
> -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> -int bpf_obj_get_user(const char __user *pathname, int flags);
> +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
> +int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
>  
>  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
>  #define DEFINE_BPF_ITER_FUNC(target, args...)			\
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1bb11a6ee667..db2870a52ce0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1420,6 +1420,11 @@ union bpf_attr {
>  		__aligned_u64	pathname;
>  		__u32		bpf_fd;
>  		__u32		file_flags;
> +		/* same as dirfd in openat() syscall; see openat(2)
> +		 * manpage for details of dirfd/path_fd and pathname semantics;
> +		 * zero path_fd implies AT_FDCWD behavior
> +		 */
> +		__u32		path_fd;

I'd probably call it dir_fd to emphasize the similarity,
but I don't mind path_fd as well

I have a note that you suggested to introduce this for uprobe
multi link as well, so I'll do something similar

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  	};
>  
>  	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9948b542a470..13bb54f6bd17 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -435,7 +435,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
>  	return ret;
>  }
>  
> -static int bpf_obj_do_pin(const char __user *pathname, void *raw,
> +static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void *raw,
>  			  enum bpf_type type)
>  {
>  	struct dentry *dentry;
> @@ -444,7 +444,7 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
>  	umode_t mode;
>  	int ret;
>  
> -	dentry = user_path_create(AT_FDCWD, pathname, &path, 0);
> +	dentry = user_path_create(path_fd, pathname, &path, 0);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> @@ -478,7 +478,7 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
>  	return ret;
>  }
>  
> -int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
> +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname)
>  {
>  	enum bpf_type type;
>  	void *raw;
> @@ -488,14 +488,14 @@ int bpf_obj_pin_user(u32 ufd, const char __user *pathname)
>  	if (IS_ERR(raw))
>  		return PTR_ERR(raw);
>  
> -	ret = bpf_obj_do_pin(pathname, raw, type);
> +	ret = bpf_obj_do_pin(path_fd, pathname, raw, type);
>  	if (ret != 0)
>  		bpf_any_put(raw, type);
>  
>  	return ret;
>  }
>  
> -static void *bpf_obj_do_get(const char __user *pathname,
> +static void *bpf_obj_do_get(int path_fd, const char __user *pathname,
>  			    enum bpf_type *type, int flags)
>  {
>  	struct inode *inode;
> @@ -503,7 +503,7 @@ static void *bpf_obj_do_get(const char __user *pathname,
>  	void *raw;
>  	int ret;
>  
> -	ret = user_path_at(AT_FDCWD, pathname, LOOKUP_FOLLOW, &path);
> +	ret = user_path_at(path_fd, pathname, LOOKUP_FOLLOW, &path);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> @@ -527,7 +527,7 @@ static void *bpf_obj_do_get(const char __user *pathname,
>  	return ERR_PTR(ret);
>  }
>  
> -int bpf_obj_get_user(const char __user *pathname, int flags)
> +int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags)
>  {
>  	enum bpf_type type = BPF_TYPE_UNSPEC;
>  	int f_flags;
> @@ -538,7 +538,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
>  	if (f_flags < 0)
>  		return f_flags;
>  
> -	raw = bpf_obj_do_get(pathname, &type, f_flags);
> +	raw = bpf_obj_do_get(path_fd, pathname, &type, f_flags);
>  	if (IS_ERR(raw))
>  		return PTR_ERR(raw);
>  
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 909c112ef537..65a46f6d4be0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2697,14 +2697,15 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	return err;
>  }
>  
> -#define BPF_OBJ_LAST_FIELD file_flags
> +#define BPF_OBJ_LAST_FIELD path_fd
>  
>  static int bpf_obj_pin(const union bpf_attr *attr)
>  {
>  	if (CHECK_ATTR(BPF_OBJ) || attr->file_flags != 0)
>  		return -EINVAL;
>  
> -	return bpf_obj_pin_user(attr->bpf_fd, u64_to_user_ptr(attr->pathname));
> +	return bpf_obj_pin_user(attr->bpf_fd, attr->path_fd ?: AT_FDCWD,
> +				u64_to_user_ptr(attr->pathname));
>  }
>  
>  static int bpf_obj_get(const union bpf_attr *attr)
> @@ -2713,7 +2714,8 @@ static int bpf_obj_get(const union bpf_attr *attr)
>  	    attr->file_flags & ~BPF_OBJ_FLAG_MASK)
>  		return -EINVAL;
>  
> -	return bpf_obj_get_user(u64_to_user_ptr(attr->pathname),
> +	return bpf_obj_get_user(attr->path_fd ?: AT_FDCWD,
> +				u64_to_user_ptr(attr->pathname),
>  				attr->file_flags);
>  }
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 1bb11a6ee667..db2870a52ce0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1420,6 +1420,11 @@ union bpf_attr {
>  		__aligned_u64	pathname;
>  		__u32		bpf_fd;
>  		__u32		file_flags;
> +		/* same as dirfd in openat() syscall; see openat(2)
> +		 * manpage for details of dirfd/path_fd and pathname semantics;
> +		 * zero path_fd implies AT_FDCWD behavior
> +		 */
> +		__u32		path_fd;
>  	};
>  
>  	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
> -- 
> 2.34.1
> 
> 


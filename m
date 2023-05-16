Return-Path: <bpf+bounces-613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B588E704870
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3AF1C20DD1
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B01156F3;
	Tue, 16 May 2023 09:07:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9558156E4
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E52C433EF;
	Tue, 16 May 2023 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684228069;
	bh=lwTD+igr56O+aSo6LJhqI5ug1YobfopbceuhPYkGax4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRSc3cWNduqR+TwU+h0/ru1tUb3xJqaai+B0n/QsaIx07XQSxkeb5fjmxk86lOv2P
	 R7RLGKAuY69nPciyBmAYGRgGOLPLz9s5KP+vyKpy7NsDFdYKLPVjO6Yz7N3C/cGAvg
	 z9rKxyhSsffzNn3KSfppiUflMggbrPK+GNnqk/0iLQn5HzHJLk+f8jObyW3wY0ZRN5
	 1UqhshPAePMwuAQa7E/h/V2hSoO9g+B4NRp03FqqVdR4lBwrDQYqVpWuNV+7ylf0fP
	 cR+hQ//M1LbcJCSEtB5un9z+oItuEv6bfYgeQ9cTiFjIPKmxUaPp3wNqG4+PYf3BqD
	 RyQ5w+zd6oTcA==
Date: Tue, 16 May 2023 11:07:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, cyphar@cyphar.com, lennart@poettering.net
Subject: Re: [PATCH bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN and
 BPF_OBJ_GET commands
Message-ID: <20230516-briefe-blutzellen-0432957bdd15@brauner>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516001348.286414-2-andrii@kernel.org>

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

Cool!

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
>  	};

So 0 is a valid file descriptor and can trivially be created and made to
refer to any file. Is this a conscious decision to have a zero value
imply AT_FDCWD and have you done this somewhere else in bpf already?
Because that's contrary to how any file descriptor based apis work.

How this is usually solved for extensible structs is to have a flag
field that raises a flag to indicate that the fd fiel is set and thus 0
can be used as a valid value.

The way you're doing it right now is very counterintuitive to userspace
and pretty much guaranteed to cause subtle bugs.


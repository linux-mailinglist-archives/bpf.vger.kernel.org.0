Return-Path: <bpf+bounces-958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F1670974D
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82456281C8D
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564F6AA8;
	Fri, 19 May 2023 12:37:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260A7C
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 12:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A689C433D2;
	Fri, 19 May 2023 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684499860;
	bh=R4EVhjhpgezvGhcJ1rV29LbGDOpa0u2W5P9ZfvrYWlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8xBBpYyQRaIs0yTaNAnSLlS2fixkSTPPROhZIgMGu+sIJGJ5evQ48Os4Bdev/9dM
	 Uk9UU30352149DwKwJ03G6i/TaBI/ocOr3PJ4UmdW2RjA+8gFm/sBbwxI/2aWPBSwy
	 p88pcpuqzNuJJvN1W7FvANVOrYnrwXloFuocTIaHNjtTG24zWcgWV+ZMbR3Nq/TPDO
	 pBKqIfQ2H5Fsx8ubVHvKOc85j4d7sakKAxRv6Ce2C058LmANm/1NdNwZCA7NEWYPJ0
	 mXLz+Ts/QuoUdGZdet1gzb+SuyPynmyD2xqE1deZqAihEWNlbEKGrbksmcYYUoH5AY
	 JEBPucONB0KLQ==
Date: Fri, 19 May 2023 14:37:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, cyphar@cyphar.com, lennart@poettering.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
Message-ID: <20230519-ratschlag-gockel-c27d5fdfb72d@brauner>
References: <20230518215444.1418789-1-andrii@kernel.org>
 <20230518215444.1418789-2-andrii@kernel.org>
 <20230519-eiswasser-leibarzt-ed7e52934486@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519-eiswasser-leibarzt-ed7e52934486@brauner>

On Fri, May 19, 2023 at 11:49:50AM +0200, Christian Brauner wrote:
> On Thu, May 18, 2023 at 02:54:42PM -0700, Andrii Nakryiko wrote:
> > Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> > forces users to specify pinning location as a string-based absolute or
> > relative (to current working directory) path. This has various
> > implications related to security (e.g., symlink-based attacks), forces
> > BPF FS to be exposed in the file system, which can cause races with
> > other applications.
> > 
> > One of the feedbacks we got from folks working with containers heavily
> > was that inability to use purely FD-based location specification was an
> > unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> > commands. This patch closes this oversight, adding path_fd field to
> > BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> > *at() syscalls for dirfd + pathname combinations.
> > 
> > This now allows interesting possibilities like working with detached BPF
> > FS mount (e.g., to perform multiple pinnings without running a risk of
> > someone interfering with them), and generally making pinning/getting
> > more secure and not prone to any races and/or security attacks.
> > 
> > This is demonstrated by a selftest added in subsequent patch that takes
> > advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> > creating detached BPF FS mount, pinning, and then getting BPF map out of
> > it, all while never exposing this private instance of BPF FS to outside
> > worlds.
> > 
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  4 ++--
> >  include/uapi/linux/bpf.h       | 10 ++++++++++
> >  kernel/bpf/inode.c             | 16 ++++++++--------
> >  kernel/bpf/syscall.c           | 25 ++++++++++++++++++++-----
> >  tools/include/uapi/linux/bpf.h | 10 ++++++++++
> >  5 files changed, 50 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 36e4b2d8cca2..f58895830ada 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
> >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> >  
> > -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> > -int bpf_obj_get_user(const char __user *pathname, int flags);
> > +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
> > +int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
> >  
> >  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
> >  #define DEFINE_BPF_ITER_FUNC(target, args...)			\
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..3731284671e4 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1272,6 +1272,9 @@ enum {
> >  
> >  /* Create a map that will be registered/unregesitered by the backed bpf_link */
> >  	BPF_F_LINK		= (1U << 13),
> > +
> > +/* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
> > +	BPF_F_PATH_FD		= (1U << 14),
> >  };
> >  
> >  /* Flags for BPF_PROG_QUERY. */
> > @@ -1420,6 +1423,13 @@ union bpf_attr {
> >  		__aligned_u64	pathname;
> >  		__u32		bpf_fd;
> >  		__u32		file_flags;
> > +		/* Same as dirfd in openat() syscall; see openat(2)
> > +		 * manpage for details of path FD and pathname semantics;
> > +		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
> > +		 * file_flags field, otherwise it should be set to zero;
> > +		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
> > +		 */
> > +		__u32		path_fd;
> >  	};
> 
> Thanks for changing that.
> 
> This is still odd though because you prevent users from specifying
> AT_FDCWD explicitly. They should be allowed to do that plus file
> descriptors are signed integers so please s/__u32/__s32/. AT_FDCWD
> should be passable anywhere where we have at* semantics. Plus, if in the
> vfs we ever add
> #define AT_ROOT -200
> or something you can't use without coming up with your own custom flags.
> If you just follow what everyone else does and use __s32 then you're
> good.
> 
> File descriptors really need to be signed. There's no way around that.
> See io_uring as a good example
> 
> io_uring_sqe {
>           __u8    opcode;         /* type of operation for this sqe */
>           __u8    flags;          /* IOSQE_ flags */
>           __u16   ioprio;         /* ioprio for the request */
>           __s32   fd;             /* file descriptor to do IO on */
> }
> 
> where the __s32 fd is used in all fd based requests including
> io_openat*() (See io_uring/openclose.c) which are effectively the
> semantics you want to emulate here.

I should clarify that this is mainly for apis that return fds or that
provide at* semantics. We certainly do use unsigned in cases where the
system call operates directly on an fd without any lookup semantics.


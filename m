Return-Path: <bpf+bounces-17414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B080CF54
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A2E1F21888
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CA4AF79;
	Mon, 11 Dec 2023 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVXGn0EU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31C4AF6C
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 15:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0DCC433C7;
	Mon, 11 Dec 2023 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308081;
	bh=fSanMRc7ugaLHgy4W7PjcepuiheQMtac1IykkK26R0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVXGn0EUcUtho0b/WjuZrZQf3SteH4m28jIJ6YK7w/DJk6Sa9vVExHT5O+0sufdpn
	 zQfrZnlLwHr8FMSGab1U759flsAK0uOoTPtWZ8jlMC7p9ipuLc6yrUdSxvh9CFNo+A
	 nVeJK8mJZgo4EYkP9DZtm2nsNa5qf46Xpffp+C6d+/UhVGp0zT59p2FEVyBbIED/FJ
	 ++rRPZ+12C9P+QD/IktXhS5w/QAzgjvUzWUEEcV0aYpsWldBTfxqFLYKGTvRNCzkR4
	 ZxH+5UJ+VsKDgo0L3K2JcShJT+p7fNwPikZUWXWmqPc5+LxqUPgMk87zCpJTw4oh75
	 bKj8VMPFlRInA==
Date: Mon, 11 Dec 2023 16:21:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jie Jiang <jiejiang@chromium.org>, bpf@vger.kernel.org,
	vapier@chromium.org, andrii@kernel.org, ast@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: Support uid and gid when mounting bpffs
Message-ID: <20231211-beide-golden-84ecb9d596c1@brauner>
References: <20231207035706.2797103-1-jiejiang@chromium.org>
 <c9a98edc-f8cb-e52d-e9e6-53834193aee8@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9a98edc-f8cb-e52d-e9e6-53834193aee8@iogearbox.net>

On Mon, Dec 11, 2023 at 03:26:12PM +0100, Daniel Borkmann wrote:
> On 12/7/23 4:57 AM, Jie Jiang wrote:
> > Parse uid and gid in bpf_parse_param() so that they can be passed in as
> > the `data` parameter when mount() bpffs. This will be useful when we
> > want to control which user/group has the control to the mounted bpffs,
> > otherwise a separate chown() call will be needed.
> > 
> > Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> > Acked-by: Mike Frysinger <vapier@chromium.org>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> > v2 -> v3: Rebase to resolve conflicts.
> > v1 -> v2: Add additional validation in bpf_parse_param() for if the
> >    requested uid/gid is representable in the fs's idmapping.
> > 
> >   include/linux/bpf.h |  2 ++
> >   kernel/bpf/inode.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> Looks good, for clarity, should this be folded into the patch?
> 
> Thanks,
> Daniel
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 273d7e0cfbde..f5ca533c62af 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -889,6 +889,8 @@ static int bpf_init_fs_context(struct fs_context *fc)
>                 return -ENOMEM;
> 
>         opts->mode = S_IRWXUGO;
> +       opts->uid = GLOBAL_ROOT_UID;
> +       opts->gid = GLOBAL_ROOT_GID;

I think you want

opt->uid = current_fsuid();
opt->gid = current_fsgid();

because bpf_init_fs_context() is called from fsopen() which may be
called inside a user namespace. Then you can just transfer

s_fs_info->uid = opts->uid;
s_fs_info->gid = opts->gid;

and then always use:

inode->i_uid = s_fs_info->uid;
inode->i_gid = s_fs_info->gid;

when initializing inodes. Otherwise looks good.


Return-Path: <bpf+bounces-16749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A08059F9
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 17:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D5A1C211B4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9046675C7;
	Tue,  5 Dec 2023 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehh4DRYF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A947675C6
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 16:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2C1C433C7;
	Tue,  5 Dec 2023 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701793893;
	bh=ktrEWZOjnqQzAUHeJFjl/mC2yymCstVvDAJMXrepafc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehh4DRYFznqN6fwLF6WVYrzl9dpVJBBd+r0HWLs6KRPJwLK6/wwM85M+zUirDrap/
	 JGcHn1YFdIBS/ZXDPIftZMXV0UMidvGE4APB9O2uWfsQ5I8t0fqT4JFrnhfizgCV8t
	 3/R2pIkhSilWJIXmAPJdeyx+NxzPXRn+dypfnKbvN7greIrC3lwaPtE+TGdMn1qdmk
	 sQUt1iV5AYDhXiyhuEPtiT+3aEciMI1Cls4ndArNYn5iRO4zt0AcjVko8W5FCx7iHb
	 qoBLqwgOXdeEYBKno9ZLTvkoG6JgwjF5epohKwpxzIoZm5Qy4lQReSyU6Y8BhaJLj6
	 3N3HKSVxpf9JQ==
Date: Tue, 5 Dec 2023 17:31:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jie Jiang <jiejiang@chromium.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, vapier@chromium.org
Subject: Re: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
Message-ID: <20231205-versorgen-funde-1184ee3f6aa4@brauner>
References: <20231201094729.1312133-1-jiejiang@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201094729.1312133-1-jiejiang@chromium.org>

On Fri, Dec 01, 2023 at 09:47:29AM +0000, Jie Jiang wrote:
> Parse uid and gid in bpf_parse_param() so that they can be passed in as
> the `data` parameter when mount() bpffs. This will be useful when we
> want to control which user/group has the control to the mounted bpffs,
> otherwise a separate chown() call will be needed.
> 
> Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> ---

Sorry, I was asked to take a quick look at this. The patchset looks fine
overall but it will interact with Andrii's patchset which makes bpffs
mountable inside a user namespace (with caveats).

At that point you need additional validation in bpf_parse_param(). The
simplest thing would probably to just put this into this series or into
@Andrii's series. It's basically a copy-pasta from what I did for tmpfs
(see below).

I plan to move this validation into the VFS so that {g,u}id mount
options are validated consistenly for any such filesystem. There is just
some unpleasantness that I have to figure out first.

@Andrii, with the {g,u}id mount option it means that userns root can

fsconfig(..., FSCONFIG_SET_STRING, "uid", "1000", ...)
fsconfig(..., FSCONFIG_SET_STRING, "gid", "1000", ...)
fsconfig(..., FSCONFIG_CMD_CREATE, ...)

If you delegate CAP_BPF in that userns to uid 1000 then an unpriv user
in that userns can create bpf tokens. Currently this would require
userns root to give both CAP_DAC_READ_SEARCH and CAP_BPF to such an
unprivileged user.

Depending on whether or not that's intended you might want to add an
additional check into bpf_token_create() to verify that the caller's
{g,u}id resolves to 0:

if (from_kuid(current_user_ns(), current_fsuid()) != 0)
        return -EINVAL;

That's basically saying you're restricting this to userns root. Idk,
that's up to you. (Note that you currently enforce current_user_ns() ==
token->user_ns == s_user_ns which is why it doesn't matter what userns
you pass here. You'd just error out later.)

>  kernel/bpf/inode.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 1aafb2ff2e953..826fe48745ee2 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -599,8 +599,15 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
>   */
>  static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  {
> -	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
> -
> +	struct inode *inode = d_inode(root);
> +	umode_t mode = inode->i_mode & S_IALLUGO & ~S_ISVTX;
> +
> +	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
> +		seq_printf(m, ",uid=%u",
> +			   from_kuid_munged(&init_user_ns, inode->i_uid));
> +	if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
> +		seq_printf(m, ",gid=%u",
> +			   from_kgid_munged(&init_user_ns, inode->i_gid));
>  	if (mode != S_IRWXUGO)
>  		seq_printf(m, ",mode=%o", mode);
>  	return 0;
> @@ -625,15 +632,21 @@ static const struct super_operations bpf_super_ops = {
>  };
>  
>  enum {
> +	OPT_UID,
> +	OPT_GID,
>  	OPT_MODE,
>  };
>  
>  static const struct fs_parameter_spec bpf_fs_parameters[] = {
> +	fsparam_u32	("gid",				OPT_GID),
>  	fsparam_u32oct	("mode",			OPT_MODE),
> +	fsparam_u32	("uid",				OPT_UID),
>  	{}
>  };
>  
>  struct bpf_mount_opts {
> +	kuid_t uid;
> +	kgid_t gid;
>  	umode_t mode;
>  };
>  
> @@ -641,6 +654,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct bpf_mount_opts *opts = fc->fs_private;
>  	struct fs_parse_result result;
> +	kuid_t uid;
> +	kgid_t gid;
>  	int opt;
>  
>  	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
> @@ -662,6 +677,18 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	}
>  
>  	switch (opt) {
> +	case OPT_UID:
> +		uid = make_kuid(current_user_ns(), result.uint_32);
> +		if (!uid_valid(uid))
> +			return invalf(fc, "Unknown uid");

		/*
		 * The requested uid must be representable in the
		 * filesystem's idmapping.
		 */
		if (!kuid_has_mapping(fc->user_ns, kuid))
			goto bad_value;

> +		opts->uid = uid;
> +		break;
> +	case OPT_GID:
> +		gid = make_kgid(current_user_ns(), result.uint_32);
> +		if (!gid_valid(gid))
> +			return invalf(fc, "Unknown gid");

		/*
		 * The requested gid must be representable in the
		 * filesystem's idmapping.
		 */
		if (!kgid_has_mapping(fc->user_ns, kgid))
			goto bad_value;

> +		opts->gid = gid;
> +		break;
>  	case OPT_MODE:
>  		opts->mode = result.uint_32 & S_IALLUGO;
>  		break;
> @@ -750,6 +777,8 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_op = &bpf_super_ops;
>  
>  	inode = sb->s_root->d_inode;
> +	inode->i_uid = opts->uid;
> +	inode->i_gid = opts->gid;
>  	inode->i_op = &bpf_dir_iops;
>  	inode->i_mode &= ~S_IALLUGO;
>  	populate_bpffs(sb->s_root);
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 


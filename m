Return-Path: <bpf+bounces-3968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3383747199
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5F41C2099D
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161715661;
	Tue,  4 Jul 2023 12:44:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6D4417
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 12:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC44AC433C8;
	Tue,  4 Jul 2023 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688474638;
	bh=3uWWXYQi7kK6BpqNYFmpjXEJwOshnrKioFoy1EDIkNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GttEWMebhIP3hGh4P0Vw1ZOC3oAxq88jxrLylBbuFhwu/ObeeoHTDvDM8GPJp9M2b
	 7nblJb/wszRUs3mThk5hxlVwcUE+lcAM4XQi+VN586WOv8eYL4xZzQpFnU7Rs5g5pz
	 2yitpwrZ8voQGWXsiUVcr68tw2jRMRr2rc1M5MEBIxI4UX1l2Fw/YJQaXpZLtRbYRp
	 4VJY883r1jv7y6QiR9YFq1vWlWugi810xh59Ni8DkLgfqK/n2TKGxngDiGwXBqyL95
	 AqxgovhOGAYQjHSg44yPjpMhqx8RZiztOPKiplsTa+UQpX+HyuAeEQg7/bTZSI8lRI
	 IaRuj6rR8Fk7g==
Date: Tue, 4 Jul 2023 14:43:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
	luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
Message-ID: <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629051832.897119-2-andrii@kernel.org>

On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while have a good amount of control over which
> privileged operations could be performed using provided BPF token.
> 
> This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> allows to create a new BPF token object along with a set of allowed
> commands that such BPF token allows to unprivileged applications.
> Currently only BPF_TOKEN_CREATE command itself can be
> delegated, but other patches gradually add ability to delegate
> BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> 
> The above means that new BPF tokens can be created using existing BPF
> token, if original privileged creator allowed BPF_TOKEN_CREATE command.
> New derived BPF token cannot be more powerful than the original BPF
> token.
> 
> Importantly, BPF token is automatically pinned at the specified location
> inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
> command, unlike BPF prog/map/btf/link. This provides more control over
> unintended sharing of BPF tokens through pinning it in another BPF FS
> instances.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

The main issue I have with the token approach is that it is a completely
separate delegation vector on top of user namespaces. We mentioned this
duringthe conf and this was brought up on the thread here again as well.
Imho, that's a problem both security-wise and complexity-wise.

It's not great if each subsystem gets its own custom delegation
mechanism. This imposes such a taxing complexity on both kernel- and
userspace that it will quickly become a huge liability. So I would
really strongly encourage you to explore another direction.

I do think the spirit of your proposal is workable and that it can
mostly be kept in tact.

As mentioned before, bpffs has all the means to be taught delegation:

        // In container's user namespace
        fd_fs = fsopen("bpffs");

        // Delegating task in host userns (systemd-bpfd whatever you want)
        ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ...);

        // In container's user namespace
        fd_mnt = fsmount(fd_fs, 0);

        ret = move_mount(fd_fs, "", -EBADF, "/my/fav/location", MOVE_MOUNT_F_EMPTY_PATH)

Roughly, this would mean:

(i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "delegate"
    mount option. IOW, it's only possibly to mount bpffs as an
    unprivileged user if a delegating process like systemd-bpfd with
    system-level privileges has marked it as delegatable.
(ii) add fine-grained delegation options that you want this
     bpffs instance to allow via new mount options. Idk,

     // allow usage of foo
     fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");

     // also allow usage of bar
     fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");

     // reset allowed options
     fsconfig(fd_fs, FSCONFIG_SET_STRING, "");

     // allow usage of schmoo
     fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");

This all seems more intuitive and integrates with user and mount
namespaces of the container. This can also work for restricting
non-userns bpf instances fwiw. You can also share instances via
bind-mount and so on. The userns of the bpffs instance can also be used
for permission checking provided a given functionality has been
delegated by e.g., systemd-bpfd or whatever.

So roughly - untested and unfinished:

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index b9b93b81af9a..c021b0a674bb 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -623,15 +623,24 @@ struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);
 
+struct bpf_mount_opts {
+	umode_t mode;
+	bool delegate;
+	u64 abilities;
+};
+
 /*
  * Display the mount options in /proc/mounts.
  */
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
+	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
 	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
 
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
+	if (opts->delegate)
+		seq_printf(m, ",delegate");
 	return 0;
 }
 
@@ -655,17 +664,17 @@ static const struct super_operations bpf_super_ops = {
 
 enum {
 	OPT_MODE,
+	Opt_delegate,
+	Opt_abilities,
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
-	fsparam_u32oct	("mode",			OPT_MODE),
+	fsparam_u32oct	     ("mode",			OPT_MODE),
+	fsparam_flag_no	     ("delegate",		Opt_delegate),
+	fsparam_string       ("abilities",		Opt_abilities),
 	{}
 };
 
-struct bpf_mount_opts {
-	umode_t mode;
-};
-
 static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct bpf_mount_opts *opts = fc->fs_private;
@@ -694,6 +703,16 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case OPT_MODE:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
+	case Opt_delegate:
+		if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		if (!result.negated)
+			opts->delegate = true;
+		break;
+	case Opt_abilities:
+		// parse param->string to opts->abilities
+		break;
 	}
 
 	return 0;
@@ -768,10 +787,20 @@ static int populate_bpffs(struct dentry *parent)
 static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr bpf_rfiles[] = { { "" } };
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = sb->s_fs_info;
 	struct inode *inode;
 	int ret;
 
+	if (fc->user_ns != &init_user_ns && !opts->delegate) {
+		errorfc(fc, "Can't mount bpffs without delegation permissions");
+		return -EPERM;
+	}
+
+	if (opts->abilities && !opts->delegate) {
+		errorfc(fc, "Specifying abilities without enabling delegation");
+		return -EINVAL;
+	}
+
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -793,7 +822,10 @@ static int bpf_get_tree(struct fs_context *fc)
 
 static void bpf_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct bpf_mount_opts *opts = fc->s_fs_info;
+
+	if (opts)
+		kfree(opts);
 }
 
 static const struct fs_context_operations bpf_context_ops = {
@@ -815,17 +847,30 @@ static int bpf_init_fs_context(struct fs_context *fc)
 
 	opts->mode = S_IRWXUGO;
 
-	fc->fs_private = opts;
+	/* If an instance is delegated it will start with no abilities. */
+	opts->delegate = false;
+	opts->abilities = 0;
+
+	fc->s_fs_info = opts;
 	fc->ops = &bpf_context_ops;
 	return 0;
 }
 
+static void bpf_kill_super(struct super_block *sb)
+{
+	struct bpf_mount_opts *opts = sb->s_fs_info;
+
+	kill_litter_super(sb);
+	kfree(opts);
+}
+
 static struct file_system_type bpf_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "bpf",
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= bpf_kill_super,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 static int __init bpf_init(void)


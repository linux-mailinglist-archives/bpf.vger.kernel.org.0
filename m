Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F34D6C57
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 04:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiCLDrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 22:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiCLDrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 22:47:53 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11052396BD;
        Fri, 11 Mar 2022 19:46:48 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSsiD-00A6aq-T5; Sat, 12 Mar 2022 03:46:37 +0000
Date:   Sat, 12 Mar 2022 03:46:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
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
Message-ID: <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-2-haoluo@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 25, 2022 at 03:43:31PM -0800, Hao Luo wrote:
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

In which contexts can those be called?

> +BPF_CALL_2(bpf_rmdir, const char *, pathname, int, pathname_sz)
> +{
> +	struct user_namespace *mnt_userns;
> +	struct path parent;
> +	struct dentry *dentry;
> +	int err;
> +
> +	if (pathname_sz <= 1 || pathname[pathname_sz - 1])
> +		return -EINVAL;
> +
> +	err = kern_path(pathname, 0, &parent);
> +	if (err)
> +		return err;
> +
> +	if (!bpf_path_is_bpf_dir(&parent)) {
> +		err = -EPERM;
> +		goto exit1;
> +	}
> +
> +	err = mnt_want_write(parent.mnt);
> +	if (err)
> +		goto exit1;
> +
> +	dentry = kern_path_locked(pathname, &parent);

This can't be right.  Ever.  There is no promise whatsoever
that these two lookups will resolve to the same place.

> +BPF_CALL_2(bpf_unlink, const char *, pathname, int, pathname_sz)
> +{
> +	struct user_namespace *mnt_userns;
> +	struct path parent;
> +	struct dentry *dentry;
> +	struct inode *inode = NULL;
> +	int err;
> +
> +	if (pathname_sz <= 1 || pathname[pathname_sz - 1])
> +		return -EINVAL;
> +
> +	err = kern_path(pathname, 0, &parent);
> +	if (err)
> +		return err;
> +
> +	err = mnt_want_write(parent.mnt);
> +	if (err)
> +		goto exit1;
> +
> +	dentry = kern_path_locked(pathname, &parent);
> +	if (IS_ERR(dentry)) {
> +		err = PTR_ERR(dentry);
> +		goto exit2;
> +	}

Ditto.  NAK; if you want to poke into fs/namei.c guts, do it right.
Or at least discuss that on fsdevel.  As it is, it's completely broken.
It's racy *and* it blatantly leaks both vfsmount and dentry references.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

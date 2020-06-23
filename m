Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F6206891
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 01:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgFWXlA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 19:41:00 -0400
Received: from namei.org ([65.99.196.166]:40328 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387651AbgFWXlA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 19:41:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 05NNee89008693;
        Tue, 23 Jun 2020 23:40:40 GMT
Date:   Wed, 24 Jun 2020 09:40:40 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] security: Fix hook iteration and default value for
 inode_copy_up_xattr
In-Reply-To: <20200621222135.9136-1-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2006240940080.8534@namei.org>
References: <20200621222135.9136-1-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Jun 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> inode_copy_up_xattr returns 0 to indicate the acceptance of the xattr
> and 1 to reject it. If the LSM does not know about the xattr, it's
> expected to return -EOPNOTSUPP, which is the correct default value for
> this hook. BPF LSM, currently, uses 0 as the default value and thereby
> falsely allows all overlay fs xattributes to be copied up.
> 
> The iteration logic is also updated from the "bail-on-fail"
> call_int_hook to continue on the non-decisive -EOPNOTSUPP and bail out
> on other values.
> 
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: KP Singh <kpsingh@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.8

> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  security/security.c           | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 6791813cd439..f4b2e54162ae 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -150,7 +150,7 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
>  	 size_t buffer_size)
>  LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
>  LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
> -LSM_HOOK(int, 0, inode_copy_up_xattr, const char *name)
> +LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
>  LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>  	 struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
> diff --git a/security/security.c b/security/security.c
> index 0ce3e73edd42..70a7ad357bc6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1414,7 +1414,22 @@ EXPORT_SYMBOL(security_inode_copy_up);
>  
>  int security_inode_copy_up_xattr(const char *name)
>  {
> -	return call_int_hook(inode_copy_up_xattr, -EOPNOTSUPP, name);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	/*
> +	 * The implementation can return 0 (accept the xattr), 1 (discard the
> +	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
> +	 * any other error code incase of an error.
> +	 */
> +	hlist_for_each_entry(hp,
> +		&security_hook_heads.inode_copy_up_xattr, list) {
> +		rc = hp->hook.inode_copy_up_xattr(name);
> +		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(inode_copy_up_xattr);
>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
>  
> 

-- 
James Morris
<jmorris@namei.org>


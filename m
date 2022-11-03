Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FF6182CD
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiKCP30 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiKCP2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 11:28:46 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835D1B1FD;
        Thu,  3 Nov 2022 08:28:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4N36vh3grZz9xGYy;
        Thu,  3 Nov 2022 23:22:56 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAH9HD83WNjZPQ1AA--.45963S2;
        Thu, 03 Nov 2022 16:28:12 +0100 (CET)
Message-ID: <2b10941d35ab833dbb0e5858489fefc33d11c010.camel@huaweicloud.com>
Subject: Re: [PATCH v4] evm: Correct inode_init_security hooks behaviors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        linux-integrity@vger.kernel.org
Cc:     philippe.trebuchet@ssi.gouv.fr, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org
Date:   Thu, 03 Nov 2022 16:27:51 +0100
In-Reply-To: <Y1lElHVQGT/1Pa6O@archlinux>
References: <Y1lElHVQGT/1Pa6O@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAH9HD83WNjZPQ1AA--.45963S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4kJr4fuw43ZF47Kw4kJFb_yoWfCF4UpF
        WYqa43Grs5AFyjgryIyF4Uua1Sg3yrGrWUK3s3Cr1jyF90qr1IqryIyr15ur1rWrWrKrn2
        qa12vrsxuwn8t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4UFsgABsC
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-10-26 at 16:30 +0200, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Fixes a NULL pointer dereference occurring in the
> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.
> 
> The `call_int_hook_xattr` macro has been inlined into the
> `security_inode_init_security` hook in order to check hooks return
> values and skip ones who doesn't init `xattrs`.
> 
> Modify `evm_init_hmac` function to init the EVM hmac using every
> entry of the given xattr array.
> 
> The `MAX_LSM_EVM_XATTR` value is now based on the security modules
> compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
> IMA/EVM security attributes.
> 
> Changes the default return value of the `inode_init_security` hook
> definition to `-EOPNOTSUPP`.
> 
> Changes the hook documentation to match the behavior of the LSMs using
> it (only xattr->value is initialised with kmalloc and thus is the only
> one that should be kfreed by the caller).
> 
> Cc: roberto.sassu@huaweicloud.com
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
> Changes since v3:
> https://lore.kernel.org/linux-integrity/Y1fu4jofqLHVDprT@archlinux/
> 
> * Fixes compilation error reported by the kernel test robot.
> ---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  4 ++--
>  security/integrity/evm/evm.h        |  1 +
>  security/integrity/evm/evm_crypto.c |  9 +++++++--
>  security/integrity/evm/evm_main.c   |  7 ++++---
>  security/security.c                 | 31 ++++++++++++++++++++++-------
>  6 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 806448173033..e5dd0c0f6345 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>  	 unsigned int obj_type)
>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>  	 struct inode *dir, const struct qstr *qstr, const char **name,
>  	 void **value, size_t *len)
>  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 84a0d7e02176..95aff9383de1 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -229,8 +229,8 @@
>   *	This hook is called by the fs code as part of the inode creation
>   *	transaction and provides for atomic labeling of the inode, unlike
>   *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> - *	is expected to allocate the name and value via kmalloc, with the caller
> - *	being responsible for calling kfree after using them.
> + *	is expected to allocate the value via kmalloc, with the caller
> + *	being responsible for calling kfree after using it.

Please also update the description of @name as well (remove allocated).

>   *	If the security module does not use security attributes or does
>   *	not wish to put a security attribute on this particular inode,
>   *	then it should return -EOPNOTSUPP to skip this processing.
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index f8b8c5004fc7..6d9628ca7c24 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -61,5 +61,6 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
>  		  char *hmac_val);
>  int evm_init_secfs(void);
> +int evm_protected_xattr(const char *req_xattr_name);
>  
>  #endif
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 708de9656bbd..06639f3cfb38 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -385,7 +385,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>  	return rc;
>  }
>  
> -int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
> +int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattrs,
>  		  char *hmac_val)
>  {
>  	struct shash_desc *desc;
> @@ -396,7 +396,12 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
>  		return PTR_ERR(desc);
>  	}
>  
> -	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
> +	for (int i = 0; lsm_xattrs[i].value != NULL; i++) {
> +		if (evm_protected_xattr(lsm_xattrs[i].name))
> +			crypto_shash_update(desc,
> +					    lsm_xattrs[i].value,
> +					    lsm_xattrs[i].value_len);
> +	}
>  	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
>  	kfree(desc);
>  	return 0;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 2e6fb6e2ffd2..0420453a80e8 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -284,6 +284,8 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
>  	int found = 0;
>  	struct xattr_list *xattr;
>  
> +	if (!req_xattr_name)
> +		return found;

Remove, and use the check below.

>  	namelen = strlen(req_xattr_name);
>  	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		if (!all_xattrs && !xattr->enabled)
> @@ -305,7 +307,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
>  	return found;
>  }
>  
> -static int evm_protected_xattr(const char *req_xattr_name)
> +int evm_protected_xattr(const char *req_xattr_name)
>  {
>  	return evm_protected_xattr_common(req_xattr_name, false);
>  }
> @@ -841,8 +843,7 @@ int evm_inode_init_security(struct inode *inode,
>  	struct evm_xattr *xattr_data;
>  	int rc;
>  
> -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> -	    !evm_protected_xattr(lsm_xattr->name))
> +	if (!(evm_initialized & EVM_INIT_HMAC))
>  		return 0;
>  
>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..79524f8734f1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,7 +30,11 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
>  
> -#define MAX_LSM_EVM_XATTR	2
> +#define MAX_LSM_EVM_XATTR                                \
> +	((IS_ENABLED(CONFIG_EVM) ? 1 : 0) +              \
> +	 (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	 (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) +   \
> +	 (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -1091,9 +1095,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> +	int i = 0;
> +	int ret = -EOPNOTSUPP;
>  	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>  	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -	int ret;
> +	struct security_hook_list *hook_ptr;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return 0;
> @@ -1103,15 +1109,26 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				     dir, qstr, NULL, NULL, NULL);
>  	memset(new_xattrs, 0, sizeof(new_xattrs));
>  	lsm_xattr = new_xattrs;
> -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> -						&lsm_xattr->name,
> -						&lsm_xattr->value,
> -						&lsm_xattr->value_len);
> +	hlist_for_each_entry(hook_ptr, &security_hook_heads.inode_init_security,
> +			     list) {
> +		ret = hook_ptr->hook.inode_init_security(inode, dir, qstr,
> +				&lsm_xattr->name,
> +				&lsm_xattr->value,
> +				&lsm_xattr->value_len);
> +		if (ret == -EOPNOTSUPP)
> +			continue;

This does not work properly. Suppose that you have an LSM with xattr
and another without. The final ret will be -EOPNOTSUPP. Instead declare
new_xattrs_set boolean, and set to true if ret = 0. After the loop,
check the boolean instead of ret. If ret != 0 goto out.

> +		if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))
> +			ret = -ENOMEM;
> +		if (ret != 0)
> +			break;

We can check here if the LSM behaved properly, i.e. it set the xattr
name and value:

if (WARN_ON_ONCE(!lsm_xattr->name || !lsm_xattr->value)) {
	ret = -ENOMEM;
	goto out;
}

> +		lsm_xattr++;
> +		i++;
> +	}
>  	if (ret)
>  		goto out;
>  
>  	evm_xattr = lsm_xattr + 1;

It should be:

	evm_xattr = lsm_xattr;

You incremented lsm_xattr already, after the LSMs set their xattr.

Once you complete the changes, I will send a patch set including your
patch with some more patches.

Roberto

> -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
>  	if (ret)
>  		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);


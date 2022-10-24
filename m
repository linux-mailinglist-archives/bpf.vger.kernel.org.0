Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592060B677
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJXS7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJXS6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 14:58:48 -0400
X-Greylist: delayed 6316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 10:38:24 PDT
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DB230806;
        Mon, 24 Oct 2022 10:38:22 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 25686CE53D;
        Mon, 24 Oct 2022 12:52:40 +0000 (UTC)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 95E4FE000E;
        Mon, 24 Oct 2022 12:50:57 +0000 (UTC)
Date:   Mon, 24 Oct 2022 14:50:55 +0200
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        philippe.trebuchet@ssi.gouv.fr, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y1aKL/lzDD52RFLv@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <613858e0606da03f36703d6a2f46fdecbf0c69ee.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613858e0606da03f36703d6a2f46fdecbf0c69ee.camel@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roberto,

On Fri, Oct 21, 2022 at 04:02:11PM +0200, Roberto Sassu wrote:
> On Thu, 2022-10-20 at 15:55 +0200, Nicolas Bouchinet wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Fixes a NULL pointer dereference occuring in the
> > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > triggered if a `inode_init_security` hook returns 0 without
> > initializing
> > the given `struct xattr` fields (which is the case of BPF) and if no
> > other LSM overrides thoses fields after. This also leads to memory
> > leaks.
> 
> + eBPF mailing list, KP
> 
> Looking at include/linux/lsm_hooks.h:
> 
>  * @inode_init_security:
> 
> [...]
> 
>  *	If the security module does not use security attributes or does
>  *	not wish to put a security attribute on this particular inode,
>  *	then it should return -EOPNOTSUPP to skip this processing.
> 
> [...]
> 
>  *	Returns 0 if @name and @value have been successfully set,
>  *	-EOPNOTSUPP if no security attribute is needed, or
> 
> In my opinion, it should be responsibility of the eBPF infrastructure
> to ensure that this is true (meaning that it cannot let security
> modules attach to that hook without an additional check).
> 
> What do you think?
> 
> Nicolas, in the past I addressed the same issue of lacking support of
> multiple LSMs providing an xattr at inode creation time.
> 
> Would this patch set be fine for you, or you would still do
> differently?

IMHO, changing the default return value of the hook to `-EOPNOTSUPP`
in the lsm_hook_defs.h should be enough, the LSM implementation however
does not follows the current documentation as returning `-EOPNOTSUPP`
skips the whole processing of LSMs `xattrs`. This is why I check the
return value of each LSM `inode_init_security()` functions in the patch.
> 
> https://lore.kernel.org/all/20210427113732.471066-1-roberto.sassu@huawei.com/
> 
> At the end of the cover letter, you can find also a TestLSM I developed
> to ensure that support for multiple LSMs works correctly. I also tested
> the patch set with the SELinux and SMACK test suites.

Thanks, I'll give it a look !
> 
> Thanks
> 
> Roberto
> 
> > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > `new_xattrs` array with every called hook xattr values.
> > 
> > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > entry of the array contrary to `evm_init_hmac`.
> > 
> > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> > 
> > The `MAX_LSM_EVM_XATTR` value has been raised to 5 which gives room
> > for
> > SMACK, SELinux, Apparmor, BPF and IMA/EVM security attributes.
> > 
> > Changes the default return value of the `inode_init_security` hook
> > definition to `-EOPNOTSUPP`.
> > 
> > Changes the hook documentation to match the behavior of the LSMs
> > using
> > it (only xattr->value is initialised with kmalloc and thus is the
> > only
> > one that should be kfreed by the caller).
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  include/linux/lsm_hook_defs.h       |  2 +-
> >  include/linux/lsm_hooks.h           |  4 ++--
> >  security/integrity/evm/evm.h        |  2 ++
> >  security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++++++++-
> >  security/integrity/evm/evm_main.c   | 11 ++++++-----
> >  security/security.c                 | 29 ++++++++++++++++++++++++++-
> > --
> >  6 files changed, 59 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h
> > b/include/linux/lsm_hook_defs.h
> > index 806448173033..e5dd0c0f6345 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path
> > *path, u64 mask,
> >  	 unsigned int obj_type)
> >  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> >  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode
> > *inode)
> > -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> >  	 struct inode *dir, const struct qstr *qstr, const char **name,
> >  	 void **value, size_t *len)
> >  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 84a0d7e02176..95aff9383de1 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -229,8 +229,8 @@
> >   *	This hook is called by the fs code as part of the inode
> > creation
> >   *	transaction and provides for atomic labeling of the inode,
> > unlike
> >   *	the post_create/mkdir/... hooks called by the VFS.  The hook
> > function
> > - *	is expected to allocate the name and value via kmalloc, with
> > the caller
> > - *	being responsible for calling kfree after using them.
> > + *	is expected to allocate the value via kmalloc, with the caller
> > + *	being responsible for calling kfree after using it.
> >   *	If the security module does not use security attributes or does
> >   *	not wish to put a security attribute on this particular inode,
> >   *	then it should return -EOPNOTSUPP to skip this processing.
> > diff --git a/security/integrity/evm/evm.h
> > b/security/integrity/evm/evm.h
> > index f8b8c5004fc7..a2f9886e924d 100644
> > --- a/security/integrity/evm/evm.h
> > +++ b/security/integrity/evm/evm.h
> > @@ -60,6 +60,8 @@ int evm_calc_hash(struct dentry *dentry, const char
> > *req_xattr_name,
> >  		  struct evm_digest *data);
> >  int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
> >  		  char *hmac_val);
> > +int evm_init_hmacs(struct inode *inode, const struct xattr *xattrs,
> > +		  char *hmac_val);
> >  int evm_init_secfs(void);
> >  
> >  #endif
> > diff --git a/security/integrity/evm/evm_crypto.c
> > b/security/integrity/evm/evm_crypto.c
> > index 708de9656bbd..e5a34306cab6 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -347,7 +347,6 @@ static int evm_is_immutable(struct dentry
> > *dentry, struct inode *inode)
> >  	return rc;
> >  }
> >  
> > -
> >  /*
> >   * Calculate the hmac and update security.evm xattr
> >   *
> > @@ -385,6 +384,28 @@ int evm_update_evmxattr(struct dentry *dentry,
> > const char *xattr_name,
> >  	return rc;
> >  }
> >  
> > +int evm_protected_xattr(const char *req_xattr_name);
> > +
> > +int evm_init_hmacs(struct inode *inode, const struct xattr
> > *lsm_xattrs,
> > +		  char *hmac_val)
> > +{
> > +	struct shash_desc *desc;
> > +
> > +	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
> > +	if (IS_ERR(desc)) {
> > +		pr_info("init_desc failed\n");
> > +		return PTR_ERR(desc);
> > +	}
> > +
> > +	for (int i = 0; lsm_xattrs[i].value != NULL; i++) {
> > +		if (evm_protected_xattr(lsm_xattrs[i].name))
> > +			crypto_shash_update(desc, lsm_xattrs[i].value,
> > lsm_xattrs[i].value_len);
> > +	}
> > +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> > +	kfree(desc);
> > +	return 0;
> > +}
> > +
> >  int evm_init_hmac(struct inode *inode, const struct xattr
> > *lsm_xattr,
> >  		  char *hmac_val)
> >  {
> > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c
> > index 2e6fb6e2ffd2..bb071c55d656 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -284,6 +284,8 @@ static int evm_protected_xattr_common(const char
> > *req_xattr_name,
> >  	int found = 0;
> >  	struct xattr_list *xattr;
> >  
> > +	if (!req_xattr_name)
> > +		return found;
> >  	namelen = strlen(req_xattr_name);
> >  	list_for_each_entry_lockless(xattr, &evm_config_xattrnames,
> > list) {
> >  		if (!all_xattrs && !xattr->enabled)
> > @@ -305,7 +307,7 @@ static int evm_protected_xattr_common(const char
> > *req_xattr_name,
> >  	return found;
> >  }
> >  
> > -static int evm_protected_xattr(const char *req_xattr_name)
> > +int evm_protected_xattr(const char *req_xattr_name)
> >  {
> >  	return evm_protected_xattr_common(req_xattr_name, false);
> >  }
> > @@ -835,14 +837,13 @@ void evm_inode_post_setattr(struct dentry
> > *dentry, int ia_valid)
> >   * evm_inode_init_security - initializes security.evm HMAC value
> >   */
> >  int evm_inode_init_security(struct inode *inode,
> > -				 const struct xattr *lsm_xattr,
> > +				 const struct xattr *lsm_xattrs,
> >  				 struct xattr *evm_xattr)
> >  {
> >  	struct evm_xattr *xattr_data;
> >  	int rc;
> >  
> > -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> > -	    !evm_protected_xattr(lsm_xattr->name))
> > +	if (!(evm_initialized & EVM_INIT_HMAC))
> >  		return 0;
> >  
> >  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> > @@ -850,7 +851,7 @@ int evm_inode_init_security(struct inode *inode,
> >  		return -ENOMEM;
> >  
> >  	xattr_data->data.type = EVM_XATTR_HMAC;
> > -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> > +	rc = evm_init_hmacs(inode, lsm_xattrs, xattr_data->digest);
> >  	if (rc < 0)
> >  		goto out;
> >  
> > diff --git a/security/security.c b/security/security.c
> > index 14d30fec8a00..47012c118536 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -30,7 +30,7 @@
> >  #include <linux/msg.h>
> >  #include <net/flow.h>
> >  
> > -#define MAX_LSM_EVM_XATTR	2
> > +#define MAX_LSM_EVM_XATTR	5
> >  
> >  /* How many LSMs were built into the kernel? */
> >  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> > @@ -746,6 +746,29 @@ static int lsm_superblock_alloc(struct
> > super_block *sb)
> >  	RC;							\
> >  })
> >  
> > +#define call_int_hook_xattr(XATTRS, FUNC, IRC, ...) ({		
> > \
> > +	int RC = IRC;						\
> > +	int i = 0;						\
> > +	do {							\
> > +		struct security_hook_list *P;			\
> > +								\
> > +		hlist_for_each_entry(P, &security_hook_heads.FUNC,
> > list) { \
> > +			RC = P->hook.FUNC(__VA_ARGS__);		\
> > +			if (RC == -EOPNOTSUPP)			\
> > +				continue;			\
> > +			if (RC != 0 && RC != IRC)		\
> > +				break;				\
> > +			if (i >= MAX_LSM_EVM_XATTR) {		\
> > +				RC = -ENOMEM;			\
> > +				break;				\
> > +			}					\
> > +			XATTRS++;				\
> > +			i++;					\
> > +		}						\
> > +	} while (0);						\
> > +	RC;							\
> > +})
> > +
> >  /* Security operations */
> >  
> >  int security_binder_set_context_mgr(const struct cred *mgr)
> > @@ -1103,7 +1126,7 @@ int security_inode_init_security(struct inode
> > *inode, struct inode *dir,
> >  				     dir, qstr, NULL, NULL, NULL);
> >  	memset(new_xattrs, 0, sizeof(new_xattrs));
> >  	lsm_xattr = new_xattrs;
> > -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > dir, qstr,
> > +	ret = call_int_hook_xattr(lsm_xattr, inode_init_security,
> > -EOPNOTSUPP, inode, dir, qstr,
> >  						&lsm_xattr->name,
> >  						&lsm_xattr->value,
> >  						&lsm_xattr->value_len);
> > @@ -1111,7 +1134,7 @@ int security_inode_init_security(struct inode
> > *inode, struct inode *dir,
> >  		goto out;
> >  
> >  	evm_xattr = lsm_xattr + 1;
> > -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
> >  	if (ret)
> >  		goto out;
> >  	ret = initxattrs(inode, new_xattrs, fs_data);
> 

Best regards,

Nicolas Bouchinet

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A462F726
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 15:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiKROU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 09:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242310AbiKROUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 09:20:55 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9226FAC5;
        Fri, 18 Nov 2022 06:20:53 -0800 (PST)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D2B421C000A;
        Fri, 18 Nov 2022 14:20:45 +0000 (UTC)
Date:   Fri, 18 Nov 2022 15:20:44 +0100
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v4] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y3eUvBadW87f9PaL@archlinux>
References: <Y1lElHVQGT/1Pa6O@archlinux>
 <2b10941d35ab833dbb0e5858489fefc33d11c010.camel@huaweicloud.com>
 <f292d4f68e540f394504cbc8a4b98132cca09209.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f292d4f68e540f394504cbc8a4b98132cca09209.camel@huaweicloud.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 02:43:25PM +0100, Roberto Sassu wrote:
> On Thu, 2022-11-03 at 16:27 +0100, Roberto Sassu wrote:
> > On Wed, 2022-10-26 at 16:30 +0200, Nicolas Bouchinet wrote:
> > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > 
> > > Fixes a NULL pointer dereference occurring in the
> > > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > > triggered if a `inode_init_security` hook returns 0 without initializing
> > > the given `struct xattr` fields (which is the case of BPF) and if no
> > > other LSM overrides thoses fields after. This also leads to memory
> > > leaks.
> > > 
> > > The `call_int_hook_xattr` macro has been inlined into the
> > > `security_inode_init_security` hook in order to check hooks return
> > > values and skip ones who doesn't init `xattrs`.
> > > 
> > > Modify `evm_init_hmac` function to init the EVM hmac using every
> > > entry of the given xattr array.
> > > 
> > > The `MAX_LSM_EVM_XATTR` value is now based on the security modules
> > > compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
> > > IMA/EVM security attributes.
> > > 
> > > Changes the default return value of the `inode_init_security` hook
> > > definition to `-EOPNOTSUPP`.
> > > 
> > > Changes the hook documentation to match the behavior of the LSMs using
> > > it (only xattr->value is initialised with kmalloc and thus is the only
> > > one that should be kfreed by the caller).
> > > 
> > > Cc: roberto.sassu@huaweicloud.com
> > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > ---
> > > Changes since v3:
> > > https://lore.kernel.org/linux-integrity/Y1fu4jofqLHVDprT@archlinux/
> > > 
> > > * Fixes compilation error reported by the kernel test robot.
> > > ---
> > >  include/linux/lsm_hook_defs.h       |  2 +-
> > >  include/linux/lsm_hooks.h           |  4 ++--
> > >  security/integrity/evm/evm.h        |  1 +
> > >  security/integrity/evm/evm_crypto.c |  9 +++++++--
> > >  security/integrity/evm/evm_main.c   |  7 ++++---
> > >  security/security.c                 | 31 ++++++++++++++++++++++-------
> > >  6 files changed, 39 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index 806448173033..e5dd0c0f6345 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> > >  	 unsigned int obj_type)
> > >  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> > >  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> > > -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > > +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> > >  	 struct inode *dir, const struct qstr *qstr, const char **name,
> > >  	 void **value, size_t *len)
> > >  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index 84a0d7e02176..95aff9383de1 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -229,8 +229,8 @@
> > >   *	This hook is called by the fs code as part of the inode creation
> > >   *	transaction and provides for atomic labeling of the inode, unlike
> > >   *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> > > - *	is expected to allocate the name and value via kmalloc, with the caller
> > > - *	being responsible for calling kfree after using them.
> > > + *	is expected to allocate the value via kmalloc, with the caller
> > > + *	being responsible for calling kfree after using it.
> > 
> > Please also update the description of @name as well (remove allocated).
> 
> While you update the patch, I worked on the other patches: reiserfs
> fixes, if we want still to apply them; expand the call_int_hook() loop
> also for security_old_inode_init_security() to have consistent behavior
> across all filesystems.

Thank's I didn't had time to read the patch, will do it.
> 
> The patches are available here:
> 
> https://github.com/robertosassu/linux/tree/evm-multiple-lsms-nicolas-v1-devel-v6
> 
> Other than Github Actions related patches, there is also TestLSM, which
> I developed to ensure that xattrs are correctly created.
> 
> I also adapted the IMA/EVM tests, which are available here:
> 
> https://github.com/robertosassu/ima-evm-utils/tree/evm-multiple-lsms-nicolas-v1-devel-v6
> 
> Nicolas, if you want to test the new patch locally, build the UML
> kernel with:
Will surely do ! Thanks.
> 
> make ARCH=um -j$(nproc)
> 
> Build ima-evm-utils, and copy linux and certs/signing_key.pem from the
> kernel source directory to the ima-evm-utils directory. Then, run:
> 
> tests/evm_multiple_lsms.test
> 
> It basically runs the UML kernel with different combinations of LSMs
> (some providing an xattr, some not) and compares the HMAC calculated by
> EVM in the kernel with the HMAC calculated by evmctl in user space.
> 
> Roberto
> 

Best regards,

Nicolas Bouchinet

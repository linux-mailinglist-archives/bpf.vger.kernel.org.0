Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D576631B2C
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 09:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKUIVV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 03:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKUIVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 03:21:14 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A683A6DFF2;
        Mon, 21 Nov 2022 00:21:12 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NG0Xn30dmz9xqcM;
        Mon, 21 Nov 2022 16:14:17 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3YG3KNHtjPkCBAA--.28046S2;
        Mon, 21 Nov 2022 09:20:40 +0100 (CET)
Message-ID: <36ec31d29127496531eb08234c4234568cdbdc3b.camel@huaweicloud.com>
Subject: Re: [PATCH v4] evm: Correct inode_init_security hooks behaviors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org
Date:   Mon, 21 Nov 2022 09:20:16 +0100
In-Reply-To: <Y3eUvBadW87f9PaL@archlinux>
References: <Y1lElHVQGT/1Pa6O@archlinux>
         <2b10941d35ab833dbb0e5858489fefc33d11c010.camel@huaweicloud.com>
         <f292d4f68e540f394504cbc8a4b98132cca09209.camel@huaweicloud.com>
         <Y3eUvBadW87f9PaL@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwB3YG3KNHtjPkCBAA--.28046S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4fGrW3Ww18KF4DuFW3Wrg_yoW7CFW8pF
        WUK3Wakr4kJFy8CrZ2y3W7Za1fK3yrGrWUWryakr1YvF90vFn2qr40kr15uF95CrW8GFy2
        qF17ZrZxuw1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj4WldwAAsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-11-18 at 15:20 +0100, Nicolas Bouchinet wrote:
> On Fri, Nov 04, 2022 at 02:43:25PM +0100, Roberto Sassu wrote:
> > On Thu, 2022-11-03 at 16:27 +0100, Roberto Sassu wrote:
> > > On Wed, 2022-10-26 at 16:30 +0200, Nicolas Bouchinet wrote:
> > > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > > 
> > > > Fixes a NULL pointer dereference occurring in the
> > > > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > > > triggered if a `inode_init_security` hook returns 0 without initializing
> > > > the given `struct xattr` fields (which is the case of BPF) and if no
> > > > other LSM overrides thoses fields after. This also leads to memory
> > > > leaks.
> > > > 
> > > > The `call_int_hook_xattr` macro has been inlined into the
> > > > `security_inode_init_security` hook in order to check hooks return
> > > > values and skip ones who doesn't init `xattrs`.
> > > > 
> > > > Modify `evm_init_hmac` function to init the EVM hmac using every
> > > > entry of the given xattr array.
> > > > 
> > > > The `MAX_LSM_EVM_XATTR` value is now based on the security modules
> > > > compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
> > > > IMA/EVM security attributes.
> > > > 
> > > > Changes the default return value of the `inode_init_security` hook
> > > > definition to `-EOPNOTSUPP`.
> > > > 
> > > > Changes the hook documentation to match the behavior of the LSMs using
> > > > it (only xattr->value is initialised with kmalloc and thus is the only
> > > > one that should be kfreed by the caller).
> > > > 
> > > > Cc: roberto.sassu@huaweicloud.com
> > > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > > ---
> > > > Changes since v3:
> > > > https://lore.kernel.org/linux-integrity/Y1fu4jofqLHVDprT@archlinux/
> > > > 
> > > > * Fixes compilation error reported by the kernel test robot.
> > > > ---
> > > >  include/linux/lsm_hook_defs.h       |  2 +-
> > > >  include/linux/lsm_hooks.h           |  4 ++--
> > > >  security/integrity/evm/evm.h        |  1 +
> > > >  security/integrity/evm/evm_crypto.c |  9 +++++++--
> > > >  security/integrity/evm/evm_main.c   |  7 ++++---
> > > >  security/security.c                 | 31 ++++++++++++++++++++++-------
> > > >  6 files changed, 39 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > > index 806448173033..e5dd0c0f6345 100644
> > > > --- a/include/linux/lsm_hook_defs.h
> > > > +++ b/include/linux/lsm_hook_defs.h
> > > > @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> > > >  	 unsigned int obj_type)
> > > >  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> > > >  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> > > > -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > > > +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> > > >  	 struct inode *dir, const struct qstr *qstr, const char **name,
> > > >  	 void **value, size_t *len)
> > > >  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> > > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > > index 84a0d7e02176..95aff9383de1 100644
> > > > --- a/include/linux/lsm_hooks.h
> > > > +++ b/include/linux/lsm_hooks.h
> > > > @@ -229,8 +229,8 @@
> > > >   *	This hook is called by the fs code as part of the inode creation
> > > >   *	transaction and provides for atomic labeling of the inode, unlike
> > > >   *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> > > > - *	is expected to allocate the name and value via kmalloc, with the caller
> > > > - *	being responsible for calling kfree after using them.
> > > > + *	is expected to allocate the value via kmalloc, with the caller
> > > > + *	being responsible for calling kfree after using it.
> > > 
> > > Please also update the description of @name as well (remove allocated).
> > 
> > While you update the patch, I worked on the other patches: reiserfs
> > fixes, if we want still to apply them; expand the call_int_hook() loop
> > also for security_old_inode_init_security() to have consistent behavior
> > across all filesystems.
> 
> Thank's I didn't had time to read the patch, will do it.

Hi Nicolas

in the meantime we went further. As Paul commented that he would prefer
to use the reservation mechanism for xattrs, instead of a static
allocation, I resumed my old patch set, which would include also your
changes.

Will send a new version shortly. Will appreciate your feedback!

Thanks

Roberto

> > The patches are available here:
> > 
> > https://github.com/robertosassu/linux/tree/evm-multiple-lsms-nicolas-v1-devel-v6
> > 
> > Other than Github Actions related patches, there is also TestLSM, which
> > I developed to ensure that xattrs are correctly created.
> > 
> > I also adapted the IMA/EVM tests, which are available here:
> > 
> > https://github.com/robertosassu/ima-evm-utils/tree/evm-multiple-lsms-nicolas-v1-devel-v6
> > 
> > Nicolas, if you want to test the new patch locally, build the UML
> > kernel with:
> Will surely do ! Thanks.
> > make ARCH=um -j$(nproc)
> > 
> > Build ima-evm-utils, and copy linux and certs/signing_key.pem from the
> > kernel source directory to the ima-evm-utils directory. Then, run:
> > 
> > tests/evm_multiple_lsms.test
> > 
> > It basically runs the UML kernel with different combinations of LSMs
> > (some providing an xattr, some not) and compares the HMAC calculated by
> > EVM in the kernel with the HMAC calculated by evmctl in user space.
> > 
> > Roberto
> > 
> 
> Best regards,
> 
> Nicolas Bouchinet


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189F61F2C2
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiKGMRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 07:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiKGMRb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:31 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B35418341;
        Mon,  7 Nov 2022 04:17:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4N5VR84PMgz9ygfw;
        Mon,  7 Nov 2022 20:09:56 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAX_vn69mhjUrFFAA--.24935S2;
        Mon, 07 Nov 2022 13:16:04 +0100 (CET)
Message-ID: <24860ff87aa8098fa934d7de31e4bb28a80bfd95.camel@huaweicloud.com>
Subject: Re: [PATCH v4] evm: Correct inode_init_security hooks behaviors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>,
        Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org
Date:   Mon, 07 Nov 2022 13:15:49 +0100
In-Reply-To: <CAHC9VhRoRQQO5v1J1r_dA6kO0AnC1WvpBGONEe-weJ_=vnntJA@mail.gmail.com>
References: <Y1lElHVQGT/1Pa6O@archlinux>
         <CAHC9VhRoRQQO5v1J1r_dA6kO0AnC1WvpBGONEe-weJ_=vnntJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX_vn69mhjUrFFAA--.24935S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr17KF1rGw4DJr18JrW8Zwb_yoWrtr47pF
        WUKa45Kr4DJFyxWrWxAF47u3WfKrWrGrWDCrZ3Gw1jvFyDur1xtr1Skr1Y9ryrurW8Cr1v
        qa17Zwsxuwn0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4Ej1AAAsI
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2022-11-05 at 07:06 -0400, Paul Moore wrote:
> On Wed, Oct 26, 2022 at 10:30 AM Nicolas Bouchinet
> <nicolas.bouchinet@clip-os.org> wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Fixes a NULL pointer dereference occurring in the
> > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > triggered if a `inode_init_security` hook returns 0 without initializing
> > the given `struct xattr` fields (which is the case of BPF) and if no
> > other LSM overrides thoses fields after. This also leads to memory
> > leaks.
> > 
> > The `call_int_hook_xattr` macro has been inlined into the
> > `security_inode_init_security` hook in order to check hooks return
> > values and skip ones who doesn't init `xattrs`.
> > 
> > Modify `evm_init_hmac` function to init the EVM hmac using every
> > entry of the given xattr array.
> > 
> > The `MAX_LSM_EVM_XATTR` value is now based on the security modules
> > compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
> > IMA/EVM security attributes.
> > 
> > Changes the default return value of the `inode_init_security` hook
> > definition to `-EOPNOTSUPP`.
> > 
> > Changes the hook documentation to match the behavior of the LSMs using
> > it (only xattr->value is initialised with kmalloc and thus is the only
> > one that should be kfreed by the caller).
> > 
> > Cc: roberto.sassu@huaweicloud.com
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> > Changes since v3:
> > https://lore.kernel.org/linux-integrity/Y1fu4jofqLHVDprT@archlinux/
> > 
> > * Fixes compilation error reported by the kernel test robot.
> > ---
> >  include/linux/lsm_hook_defs.h       |  2 +-
> >  include/linux/lsm_hooks.h           |  4 ++--
> >  security/integrity/evm/evm.h        |  1 +
> >  security/integrity/evm/evm_crypto.c |  9 +++++++--
> >  security/integrity/evm/evm_main.c   |  7 ++++---
> >  security/security.c                 | 31 ++++++++++++++++++++++-------
> >  6 files changed, 39 insertions(+), 15 deletions(-)
> 
> ...
> 
> > diff --git a/security/security.c b/security/security.c
> > index 14d30fec8a00..79524f8734f1 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -30,7 +30,11 @@
> >  #include <linux/msg.h>
> >  #include <net/flow.h>
> > 
> > -#define MAX_LSM_EVM_XATTR      2
> > +#define MAX_LSM_EVM_XATTR                                \
> > +       ((IS_ENABLED(CONFIG_EVM) ? 1 : 0) +              \
> > +        (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> > +        (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) +   \
> > +        (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
> 
> ...
> 
> > @@ -1091,9 +1095,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >                                  const struct qstr *qstr,
> >                                  const initxattrs initxattrs, void *fs_data)
> >  {
> > +       int i = 0;
> > +       int ret = -EOPNOTSUPP;
> >         struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> >         struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > -       int ret;
> > +       struct security_hook_list *hook_ptr;
> > 
> >         if (unlikely(IS_PRIVATE(inode)))
> >                 return 0;
> > @@ -1103,15 +1109,26 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >                                      dir, qstr, NULL, NULL, NULL);
> >         memset(new_xattrs, 0, sizeof(new_xattrs));
> >         lsm_xattr = new_xattrs;
> > -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > -                                               &lsm_xattr->name,
> > -                                               &lsm_xattr->value,
> > -                                               &lsm_xattr->value_len);
> > +       hlist_for_each_entry(hook_ptr, &security_hook_heads.inode_init_security,
> > +                            list) {
> > +               ret = hook_ptr->hook.inode_init_security(inode, dir, qstr,
> > +                               &lsm_xattr->name,
> > +                               &lsm_xattr->value,
> > +                               &lsm_xattr->value_len);
> > +               if (ret == -EOPNOTSUPP)
> > +                       continue;
> > +               if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))
> > +                       ret = -ENOMEM;
> 
> It would really like to see us get rid of the MAX_LSM_EVM_XATTR macro
> and determine the array size similar to what we do with the security
> blob sizes.  The macro definition is a kludgy hack that is bound to
> get out of sync at some point and this extra checking inside the hook
> is something we should work to remove.

In this case, I already implemented this, as it was originally
suggested by Casey. I will resend this:

https://lore.kernel.org/linux-integrity/20210427113732.471066-1-roberto.sassu@huawei.com/

with few minor tweaks.

Roberto

> > +               if (ret != 0)
> > +                       break;
> > +               lsm_xattr++;
> > +               i++;
> > +       }
> >         if (ret)
> >                 goto out;
> > 
> >         evm_xattr = lsm_xattr + 1;
> > -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > +       ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
> >         if (ret)
> >                 goto out;
> >         ret = initxattrs(inode, new_xattrs, fs_data);
> > --
> > 2.38.1


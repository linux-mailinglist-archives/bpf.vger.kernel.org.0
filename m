Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0563C0AF
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiK2NNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiK2NMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 08:12:39 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE861BB7;
        Tue, 29 Nov 2022 05:11:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NM2b870fsz9yHSc;
        Tue, 29 Nov 2022 21:03:48 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnGvexBIZjFeWlAA--.44616S2;
        Tue, 29 Nov 2022 14:10:22 +0100 (CET)
Message-ID: <b01474bc5f19e98ff30ddc16a5d783c84ed1a486.camel@huaweicloud.com>
Subject: Re: [PATCH v5] evm: Correct inode_init_security hooks behaviors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        philippe.trebuchet@ssi.gouv.fr, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org
Date:   Tue, 29 Nov 2022 14:10:06 +0100
In-Reply-To: <Y4YCElqX9jp5r8sO@archlinux>
References: <Y4Dl2yjVRkJvBflq@archlinux>
         <086b6d26895b84ad4086ac9f191ede6f705f9b6b.camel@linux.ibm.com>
         <Y4YCElqX9jp5r8sO@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnGvexBIZjFeWlAA--.44616S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr18KFWUJrW8uw17GFW7Jwb_yoW5Aw4DpF
        W3tasIkr4DtF48WrW3tF4UZw4SkrWSgrWDWFn7C34jvas8Kr1xtrWSvF4Y9Fyfur4FkFyq
        qF12y3W3Zwn8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4YGrQABsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-11-29 at 13:58 +0100, Nicolas Bouchinet wrote:
> Hi Mimi,
> 
> On Tue, Nov 29, 2022 at 06:28:09AM -0500, Mimi Zohar wrote:
> > On Fri, 2022-11-25 at 16:57 +0100, Nicolas Bouchinet wrote:
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
> > 
> > What  is the relationship between this patch and Roberto's patch set? 
> > Roberto, if there is an overlap, then at minimum there should be a
> > Reported-by tag indicating that your patch set addresses a bug reported
> > by Nicolas.
> 
> This patch fixes the EVM NULL pointer dereference I have reported, and additionally
> improves the stackability of this LSM hook. This latter improvement was originally
> addressed by Roberto's patchset, and thus I see no problem for my fix to be merged
> within his patchset.

+       if (!num_filled_xattrs)
                goto out;
 
-       evm_xattr = lsm_xattr + 1;
-       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+       ret = evm_inode_init_security(inode, new_xattrs,
+                                     new_xattrs + num_filled_xattrs);

This part of patch 4 should be enough to fix the issue, until EVM is
outside the LSM infrastructure.

It prevents EVM from being called if there are no xattrs filled (the
panic occurred due to xattr->name being NULL).

Then, this part of patch 6:

+       for (xattr = xattrs; xattr->value != NULL; xattr++) {
+               if (evm_protected_xattr(xattr->name))
+                       evm_protected_xattrs = true;
+       }
+
+       /* EVM xattr not needed. */
+       if (!evm_protected_xattrs)
+               return -EOPNOTSUPP;

should be sufficient for when EVM is managed by the LSM infrastructure.

security_check_compact_filled_xattrs() ensures that if xattr->value is
not NULL, xattr->name is not NULL too.

Roberto

> > -- 
> > thanks,
> > 
> > Mimi
> > 
> 
> Thanks for your time,
> 
> Nicolas Bouchinet


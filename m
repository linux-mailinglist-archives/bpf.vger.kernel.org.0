Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF96DE26B
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDKRY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKRYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:24:25 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317AC12A;
        Tue, 11 Apr 2023 10:24:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PwsrY382dz9xGYd;
        Wed, 12 Apr 2023 01:14:05 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAXfOeilzVk2tkWAg--.696S2;
        Tue, 11 Apr 2023 18:23:57 +0100 (CET)
Message-ID: <6c48e6df58e9762607cf7f8287cc95f6a161c064.camel@huaweicloud.com>
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 11 Apr 2023 19:25:11 +0200
In-Reply-To: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
         <20230331123221.3273328-3-roberto.sassu@huaweicloud.com>
         <e65b6ea91d66b78c382acdec14003d3665fcfd3e.camel@linux.ibm.com>
         <64d8dcae509beca4cd763acb148d2665b805ee6e.camel@huaweicloud.com>
         <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAXfOeilzVk2tkWAg--.696S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4fuFyxuF43Gw43WF1kAFb_yoWxXF45pF
        WUJ3WUKFs5tFyUJrySyw15ua4S9rWfGr47Xr98tryUZF90qr1xKry0krW5uFykXrW8Jan0
        qF12yrW3uFn8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4fclgADs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-04-11 at 09:42 -0700, Casey Schaufler wrote:
> On 4/11/2023 12:53 AM, Roberto Sassu wrote:
> > On Tue, 2023-04-11 at 03:22 -0400, Mimi Zohar wrote:
> > > Hi Roberto,
> > > 
> > > Sorry for the delay in responding...
> > Hi Mimi
> > 
> > no worries!
> > 
> > > The patch description reads as though support for per LSM multiple
> > > xattrs is being added in this patch, though lsm_get_xattr_slot() only
> > > ever is incremented once for each LSM.  To simplify review, it would be
> > > nice to mention that lsm_get_xattr_slot() would be called multiple
> > > times per LSM xattr.
> > Ok, I will mention it.
> > 
> > > On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Currently, security_inode_init_security() supports only one LSM providing
> > > > an xattr and EVM calculating the HMAC on that xattr, plus other inode
> > > > metadata.
> > > > 
> > > > Allow all LSMs to provide one or multiple xattrs, by extending the security
> > > > blob reservation mechanism. Introduce the new lbs_xattr_count field of the
> > > > lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> > > > needs, and the LSM infrastructure knows how many xattr slots it should
> > > > allocate.
> > > > 
> > > > Dynamically allocate the new_xattrs array to be populated by LSMs with the
> > > > inode_init_security hook, and pass it to the latter instead of the
> > > > name/value/len triple. Unify the !initxattrs and initxattrs case, simply
> > > > don't allocate the new_xattrs array in the former.
> > > > 
> > > > Also, pass to the hook the number of xattrs filled by each LSM, so that
> > > > there are no gaps when the next LSM fills the array. Gaps might occur
> > > > because an LSM can legitimately request xattrs to the LSM infrastructure,
> > > > but not fill the reserved slots, if it was not initialized.
> > > The number of security xattrs permitted per LSM was discussed in the
> > > second paragraph.  The first line of this paragraph needs to be updated
> > > to reflect the current number of security xattrs used, though that is
> > > more related to the new lsm_get_xattr_slot().  Or perhaps the entire
> > > paragraph is unnecessary, a remnant from
> > > security_check_compact_filled_xattrs(), and should be removed.  
> > I would probably say in that paragraph that the number specified for
> > the lbs_xattr_count field determines how many times an LSM can call
> > lsm_get_xattr_slot().
> > 
> > > > Update the documentation of security_inode_init_security() to reflect the
> > > > changes, and fix the description of the xattr name, as it is not allocated
> > > > anymore.
> > > > 
> > > > Finally, adapt both SELinux and Smack to use the new definition of the
> > > > inode_init_security hook, and to fill the reserved slots in the xattr
> > > > array. Introduce the lsm_get_xattr_slot() helper to retrieve an available
> > > > slot to fill, and to increment the number of filled slots.
> > > > 
> > > > Move the xattr->name assignment after the xattr->value one, so that it is
> > > > done only in case of successful memory allocation. For Smack, also reserve
> > > > space for the other defined xattrs although they are not set yet in
> > > > smack_inode_init_security().
> > > This Smack comment should be moved to the previous paragraph and even
> > > expanded explaining that lsm_get_xattr_slot() will be called for each
> > > additional security xattr.
> > > From previous Paul's and Casey's comments, Smack will have just two
> > xattrs, assuming that security.SMACK_TRASMUTE64 can be set in
> > smack_inode_init_security(). I will change this part accordingly once
> > Casey can have a look at the function.
> 
> To be clear, Smack may use two xattrs from smack_inode_init_security(),
> SMACK64 and SMACK64_TRANSMUTE. SMACK64_TRANSMUTE is only set on directories.
> SMACK64_MMAP and SMACK64_EXEC can be set on files, but they have to be
> set explicitly. A file may have three xattrs, but only one from
> smack_inode_init_security().
> 
> I'm looking at the existing Smack function, and it includes checking for
> the transmute attribute. Your patch seems to have dropped this important
> behavior. That needs to be restored in any case. You can tell that you need
> to include the SMACK64_TRANSMUTE xattr if setting it is detected.

Uhm, I think it is simply omitted in the patch, not deleted.

I just sent a draft of the modifications required to set
SMACK64_TRANSMUTE in smack_inode_init_security().

Roberto

> > > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
> > > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > > index c2be66c669a..9eb9b686493 100644
> > > > --- a/include/linux/lsm_hooks.h
> > > > +++ b/include/linux/lsm_hooks.h
> > > > @@ -28,6 +28,7 @@
> > > >  #include <linux/security.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/rculist.h>
> > > > +#include <linux/xattr.h>
> > > >  
> > > >  union security_list_options {
> > > >  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
> > > > @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
> > > >  	int	lbs_ipc;
> > > >  	int	lbs_msg_msg;
> > > >  	int	lbs_task;
> > > > +	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> > > >  };
> > > >  
> > > > +/**
> > > > + * lsm_get_xattr_slot - Return the next available slot and increment the index
> > > > + * @xattrs: array storing LSM-provided xattrs
> > > > + * @xattr_count: number of already stored xattrs (updated)
> > > > + *
> > > > + * Retrieve the first available slot in the @xattrs array to fill with an xattr,
> > > > + * and increment @xattr_count.
> > > > + *
> > > > + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> > > > + */
> > > > +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> > > > +					       int *xattr_count)
> > > > +{
> > > > +	if (unlikely(!xattrs))
> > > > +		return NULL;
> > > > +	return xattrs + (*xattr_count)++;
> > > At some point, since lsm_get_xattr_slot() could be called multiple
> > > times from the same LSM, shouldn't there be some sort of bounds
> > > checking?
> > > From previous Paul's comments, I understood that he prefers to avoid
> > extra checks. It will be up to LSM developers to ensure that the API is
> > used correctly.
> > 
> > Thanks
> > 
> > Roberto
> > 


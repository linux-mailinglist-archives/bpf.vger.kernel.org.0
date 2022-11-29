Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C3663C28C
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiK2OcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 09:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiK2Ob7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 09:31:59 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77156572;
        Tue, 29 Nov 2022 06:31:57 -0800 (PST)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 280C720015;
        Tue, 29 Nov 2022 14:31:48 +0000 (UTC)
Date:   Tue, 29 Nov 2022 15:31:47 +0100
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        philippe.trebuchet@ssi.gouv.fr, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v5] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y4YX0+Bn3uyBO2S+@archlinux>
References: <Y4Dl2yjVRkJvBflq@archlinux>
 <086b6d26895b84ad4086ac9f191ede6f705f9b6b.camel@linux.ibm.com>
 <Y4YCElqX9jp5r8sO@archlinux>
 <b01474bc5f19e98ff30ddc16a5d783c84ed1a486.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01474bc5f19e98ff30ddc16a5d783c84ed1a486.camel@huaweicloud.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roberto,

On Tue, Nov 29, 2022 at 02:10:06PM +0100, Roberto Sassu wrote:
> On Tue, 2022-11-29 at 13:58 +0100, Nicolas Bouchinet wrote:
> > Hi Mimi,
> > 
> > On Tue, Nov 29, 2022 at 06:28:09AM -0500, Mimi Zohar wrote:
> > > On Fri, 2022-11-25 at 16:57 +0100, Nicolas Bouchinet wrote:
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
> > > 
> > > What  is the relationship between this patch and Roberto's patch set? 
> > > Roberto, if there is an overlap, then at minimum there should be a
> > > Reported-by tag indicating that your patch set addresses a bug reported
> > > by Nicolas.
> > 
> > This patch fixes the EVM NULL pointer dereference I have reported, and additionally
> > improves the stackability of this LSM hook. This latter improvement was originally
> > addressed by Roberto's patchset, and thus I see no problem for my fix to be merged
> > within his patchset.
> 
> +       if (!num_filled_xattrs)
>                 goto out;
>  
> -       evm_xattr = lsm_xattr + 1;
> -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +       ret = evm_inode_init_security(inode, new_xattrs,
> +                                     new_xattrs + num_filled_xattrs);
> 
> This part of patch 4 should be enough to fix the issue, until EVM is
> outside the LSM infrastructure.
> 
> It prevents EVM from being called if there are no xattrs filled (the
> panic occurred due to xattr->name being NULL).
> 
> Then, this part of patch 6:
> 
> +       for (xattr = xattrs; xattr->value != NULL; xattr++) {
> +               if (evm_protected_xattr(xattr->name))
> +                       evm_protected_xattrs = true;
> +       }
> +
> +       /* EVM xattr not needed. */
> +       if (!evm_protected_xattrs)
> +               return -EOPNOTSUPP;
> 
> should be sufficient for when EVM is managed by the LSM infrastructure.
> 
> security_check_compact_filled_xattrs() ensures that if xattr->value is
> not NULL, xattr->name is not NULL too.
> 
I think a Reported-by tag should enougth then !
> Roberto
> 
> > > -- 
> > > thanks,
> > > 
> > > Mimi
> > > 
> > 
> > Thanks for your time,
> > 
> > Nicolas Bouchinet
> 

Thanks !
Nicolas Bouchinet

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2F63C07F
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiK2M7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 07:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2M7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 07:59:10 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A4E0F;
        Tue, 29 Nov 2022 04:59:08 -0800 (PST)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id F1EC6C0005;
        Tue, 29 Nov 2022 12:58:59 +0000 (UTC)
Date:   Tue, 29 Nov 2022 13:58:58 +0100
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        philippe.trebuchet@ssi.gouv.fr, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v5] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y4YCElqX9jp5r8sO@archlinux>
References: <Y4Dl2yjVRkJvBflq@archlinux>
 <086b6d26895b84ad4086ac9f191ede6f705f9b6b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086b6d26895b84ad4086ac9f191ede6f705f9b6b.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mimi,

On Tue, Nov 29, 2022 at 06:28:09AM -0500, Mimi Zohar wrote:
> On Fri, 2022-11-25 at 16:57 +0100, Nicolas Bouchinet wrote:
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
> 
> What  is the relationship between this patch and Roberto's patch set? 
> Roberto, if there is an overlap, then at minimum there should be a
> Reported-by tag indicating that your patch set addresses a bug reported
> by Nicolas.

This patch fixes the EVM NULL pointer dereference I have reported, and additionally
improves the stackability of this LSM hook. This latter improvement was originally
addressed by Roberto's patchset, and thus I see no problem for my fix to be merged
within his patchset.
> 
> -- 
> thanks,
> 
> Mimi
> 

Thanks for your time,

Nicolas Bouchinet

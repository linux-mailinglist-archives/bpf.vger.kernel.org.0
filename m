Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F256C645650
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLGJSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLGJSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 04:18:22 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B05C00;
        Wed,  7 Dec 2022 01:18:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NRs3X4pZqz9v7H4;
        Wed,  7 Dec 2022 17:11:36 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDH+fVBWpBjTaXHAA--.61258S2;
        Wed, 07 Dec 2022 10:18:01 +0100 (CET)
Message-ID: <0682348d9601ca3847ce9ba035e4ab1b586cf712.camel@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and
 fix formatting
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 07 Dec 2022 10:17:49 +0100
In-Reply-To: <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com>
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
         <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
         <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
         <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDH+fVBWpBjTaXHAA--.61258S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWrZw1UJr47tF4Utw45trb_yoW5Jw4kpF
        Z5G3WYyF1kZryIkr43A3W7Jw4Sy395KF13XryxWw18Zw1YyrWxKryakF4Y9FWDGrWkCFyj
        vFWaq3sruFy7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4ZgCAAAsJ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-12-07 at 08:58 +0100, Roberto Sassu wrote:
> On Tue, 2022-12-06 at 19:21 -0500, Paul Moore wrote:
> > On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Ensure that for non-void LSM hooks there is a description of the return
> > > values.
> > > 
> > > Also, replace spaces with tab for indentation, remove empty lines between
> > > the hook description and the list of parameters, adjust semicolons and add
> > > the period at the end of the parameter description.
> > > 
> > > Finally, move the description of gfp parameter of the
> > > xfrm_policy_alloc_security hook together with the others.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hooks.h | 221 ++++++++++++++++++++++++--------------
> > >  1 file changed, 138 insertions(+), 83 deletions(-)
> > 
> > Thanks Roberto, I've merged this into lsm/next with one small tweak (below).
> > 
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index c35e260efd8c..6502a1bea93a 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -677,7 +695,7 @@
> > >   *     indicates which of the set*uid system calls invoked this hook.  If
> > >   *     @new is the set of credentials that will be installed.  Modifications
> > >   *     should be made to this rather than to @current->cred.
> > > - *     @old is the set of credentials that are being replaces
> > > + *     @old is the set of credentials that are being replaces.
> > 
> > Might as well change "replaces" to "replaced".  I'll go ahead and fix
> > that up during the merge.
> 
> Thanks a lot!

Ops, I found an issue for fs_context_parse_param. It seems that the
kernel doc and lsm_hooks.h provide different conventions for it.

+ David

Kernel doc:

It should return 0 to indicate that the parameter should be passed on
to the filesystem, 1 to indicate that the parameter should be discarded
or an error to indicate that the parameter should be rejected.

lsm_hooks.h:

The LSM may reject it with an error and may use it for itself, in which
case it should return 0; otherwise it should return -ENOPARAM to pass
it on to the filesystem.

Looking at the code, the latter seems the right one. I would send
another patch to fix the kernel doc.

For this patch, I saw it is already in lsm/next. Paul, should I do an
incremental patch or change the one in the repo and you force push it?
I would just remove the three lines after the parameters description.

Thanks

Roberto


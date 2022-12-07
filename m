Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56681645503
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 08:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLGH7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 02:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLGH7P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 02:59:15 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6115417A96;
        Tue,  6 Dec 2022 23:59:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NRqHm0zcXz9xFGy;
        Wed,  7 Dec 2022 15:52:04 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnG_i2R5Bj6WfHAA--.59725S2;
        Wed, 07 Dec 2022 08:58:53 +0100 (CET)
Message-ID: <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and
 fix formatting
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 07 Dec 2022 08:58:42 +0100
In-Reply-To: <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
         <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
         <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnG_i2R5Bj6WfHAA--.59725S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4Dtw17Ary5ArWfZFWxCrg_yoW8Wr48pF
        sxG3W3AFn5ZryIkF43X3W7Gw4S9395Gr1UJr17Ww18Z34FyrW2yFy7CF1YgFWDJrWkCFyj
        9Fyagw1DuFy7A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4ZeLgACsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-12-06 at 19:21 -0500, Paul Moore wrote:
> On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Ensure that for non-void LSM hooks there is a description of the return
> > values.
> > 
> > Also, replace spaces with tab for indentation, remove empty lines between
> > the hook description and the list of parameters, adjust semicolons and add
> > the period at the end of the parameter description.
> > 
> > Finally, move the description of gfp parameter of the
> > xfrm_policy_alloc_security hook together with the others.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hooks.h | 221 ++++++++++++++++++++++++--------------
> >  1 file changed, 138 insertions(+), 83 deletions(-)
> 
> Thanks Roberto, I've merged this into lsm/next with one small tweak (below).
> 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index c35e260efd8c..6502a1bea93a 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -677,7 +695,7 @@
> >   *     indicates which of the set*uid system calls invoked this hook.  If
> >   *     @new is the set of credentials that will be installed.  Modifications
> >   *     should be made to this rather than to @current->cred.
> > - *     @old is the set of credentials that are being replaces
> > + *     @old is the set of credentials that are being replaces.
> 
> Might as well change "replaces" to "replaced".  I'll go ahead and fix
> that up during the merge.

Thanks a lot!

Roberto


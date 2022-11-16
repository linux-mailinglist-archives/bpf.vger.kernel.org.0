Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6662B48D
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiKPIHo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 03:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiKPIHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 03:07:41 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303EBCA1;
        Wed, 16 Nov 2022 00:07:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBwTT16L0z9xFQ5;
        Wed, 16 Nov 2022 16:00:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAH828jmnRj9PRrAA--.63973S2;
        Wed, 16 Nov 2022 09:07:09 +0100 (CET)
Message-ID: <dd9215b603d9ff511c5c23998b4597b0eb55f0a7.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 2/4] lsm: Add missing return values doc in
 lsm_hooks.h and fix formatting
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 16 Nov 2022 09:06:55 +0100
In-Reply-To: <CAHC9VhQjtU0DFoVGav-nBh-09QXh+X=Cf8RgJz6nAjvcyNQ-5A@mail.gmail.com>
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
         <20221115175652.3836811-3-roberto.sassu@huaweicloud.com>
         <CAHC9VhQjtU0DFoVGav-nBh-09QXh+X=Cf8RgJz6nAjvcyNQ-5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAH828jmnRj9PRrAA--.63973S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4Dtw17AF47uF1xCF48WFg_yoW8tw1fpF
        Z5Ga1fGF4kCr97ua13G3WxJw4fuan5Cr1UJF9rWw1qv3savrnFg3y2kF1fuF9rCryIkw1j
        qF4rKFn8Cr9rCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4V8XAABsC
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-11-15 at 21:23 -0500, Paul Moore wrote:
> On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Ensure that for non-void LSM hooks there is a description of the return
> > values. Also replace spaces with tab for indentation, remove empty lines
> > between the hook description and the list of parameters and add the period
> > at the end of the parameter description.
> > 
> > Finally, replace the description of the sb_parse_opts_str hook, which was
> > removed with commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()"),
> > with one for the new hook sb_add_mnt_opt.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hooks.h | 123 ++++++++++++++++++++++++++------------
> >  1 file changed, 86 insertions(+), 37 deletions(-)
> 
> ...
> 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index f40b82ca91e7..c0c570b7eabd 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -176,18 +183,22 @@
> >   *     Set the security relevant mount options used for a superblock
> >   *     @sb the superblock to set security mount options for
> >   *     @opts binary data structure containing all lsm mount data
> > + *     Return 0 on success, error on failure.
> >   * @sb_clone_mnt_opts:
> >   *     Copy all security options from a given superblock to another
> >   *     @oldsb old superblock which contain information to clone
> >   *     @newsb new superblock which needs filled in
> > - * @sb_parse_opts_str:
> > - *     Parse a string of security data filling in the opts structure
> > - *     @options string containing all mount options known by the LSM
> > - *     @opts binary data structure usable by the LSM
> > + *     Return 0 on success, error on failure.
> > + * @add_mnt_opt:
> > + *     Add a new mount option @option with value @val and length @len to the
> > + *     existing mount options @mnt_opts.
> > + *     Return 0 if the option was successfully added, a negative value
> > + *     otherwise.
> 
> I really appreciate the effort to improve the LSM hook comments/docs,
> but the "sb_add_mnt_opt" hook was removed in 52f982f00b22
> ("security,selinux: remove security_add_mnt_opt()").

Right, sorry, didn't notice.

Thanks

Roberto


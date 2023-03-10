Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252276B4D20
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 17:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCJQgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 11:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjCJQgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 11:36:06 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D711758E;
        Fri, 10 Mar 2023 08:34:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PYBH22czzz9xqxf;
        Sat, 11 Mar 2023 00:25:18 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHCgbhWwtkQ6aJAQ--.27488S2;
        Fri, 10 Mar 2023 17:33:47 +0100 (CET)
Message-ID: <66e9fefe918463e8fbe2e8d8ca46a76f4428a944.camel@huaweicloud.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it
 for the integrity LSM
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 17:33:35 +0100
In-Reply-To: <CAHC9VhQ80t8z79iYaY8xpoiQ5fTURoesaau+5r0bCXZrsO5GUQ@mail.gmail.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
         <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
         <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
         <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com>
         <3c2ad86758d13939afa9dceaab87fee2ded8201f.camel@linux.ibm.com>
         <CAHC9VhQ80t8z79iYaY8xpoiQ5fTURoesaau+5r0bCXZrsO5GUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHCgbhWwtkQ6aJAQ--.27488S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3ArWkXr1UCF47WrykZrb_yoW7Jr4DpF
        W7Ga1Ykr4kJr45C3s2kw1a93y0y39xJFnxW3s8Xw1UZwn0yFyxtF1Ik3yfuFyDWwsagF1Y
        vr15tFZxCF1DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4pwWAAAsa
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-10 at 11:22 -0500, Paul Moore wrote:
> On Fri, Mar 10, 2023 at 8:39 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2023-03-09 at 17:04 -0500, Paul Moore wrote:
> > > On Thu, Mar 9, 2023 at 8:21 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
> > > > > last, e.g. the 'integrity' LSM, without changing the kernel command line or
> > > > > configuration.
> > > > > 
> > > > > Also, set this order for the 'integrity' LSM. While not enforced, this is
> > > > > the only LSM expected to use it.
> > > > > 
> > > > > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> > > > > and put at the end of the LSM list.
> > > > > 
> > > > > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> > > > > LSM is found, regardless of its order. In this way, the kernel would not
> > > > > wrongly report that the LSM is not built-in in the kernel if its order is
> > > > > LSM_ORDER_LAST.
> > > > > 
> > > > > Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > Warning: procedural nitpicking ahead ...
> > > 
> > > The 'Signed-off-by' tag is in reference to the DCO, which makes sense
> > > to add if you are a patch author or are merging a patch into a tree,
> > > but it doesn't make much sense as a ACK/thumbs-up; this is why we have
> > > the 'Acked-by' and 'Reviewed-by' tags.  I generally read the
> > > 'Acked-by' tag as "I'm the one responsible for a chunk of code
> > > affected by this patch and I'm okay with this change" and the
> > > 'Reviewed-by' tag as "I looked at this patch and it looks like a good
> > > change to me".  Perhaps surprisingly to some, while an 'Acked-by' is a
> > > requirement for merging in a lot of cases, I appreciate 'Reviewed-by'
> > > tags much more as it indicates the patch is getting some third-part
> > > eyeballs on it ... so all you lurkers on this list, if you're
> > > reviewing patches as they hit your inbox, don't be shy about posting
> > > your 'Reviewed-by' tag if your comfortable doing so, we all welcome
> > > the help :)
> > > 
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> > 
> > In this case, it was a bit unclear who actually was going to upstream
> > this patch set.
> 
> FWIW, I wasn't expecting to see your sign-off without a note that you
> had merged it.  Normally I would have expected either an acked-by or a
> note that you had merged it, a sign-off without a merge notice seemed
> a little odd to me so I thought I would mention the above :)  No harm
> either way, I just figured a little discussion on process might not be
> a terrible idea to make sure we are all on the same page.
> 
> > It's better that you upstream it,  but since this
> > affects subsequent IMA and EVM patches, please create a topic branch.
> 
> I generally don't do topic branches for work that has been merged into
> a -next or -stable branch. I prefer to limit topic branches to
> special-cases where there is some value in keeping a central branch
> for multiple people to coordinate while the patchset is still in
> development; once a patchset has progressed far enough to be merged
> into a -stable or -next branch I stop maintaining the topic branch.
> 
> In this particular case the changes to the IMA/EVM code looked very
> minor, so I doubt there would be a significant merge conflict with the
> IMA/EVM tree during this development cycle, but if you would prefer to
> take this patchset via the IMA/EVM tree that is okay with me; just let
> me know so I can ACK the two LSM-related patches (I'm going to review
> the latest posting today).

Probably it would be beneficial if you carry this patch set, so that
the next 'evm: Do HMAC of multiple per LSM xattrs for new inodes', and
'security: Move IMA and EVM to the LSM infrastructure' could be applied
on top (assuming that we are able to finish within this cycle).

Thanks

Roberto

> As a bit of an aside, while this doesn't cover topic branches (once
> again, I consider those special cases), when managing the LSM tree I
> follow the process that is documented here:
> 
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> 
> [NOTE: the above GH repo is a read-only mirror of the canonical LSM
> kernel.org repo, it just happens that GH does a better job rendering
> txt]
> 
> The main LSM repo process "docs" / pointers can be found in the main
> README or "about" page:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/about
> 
> If people have suggestions for a different approach to managing the
> LSM tree I'm always open to discussion.
> 


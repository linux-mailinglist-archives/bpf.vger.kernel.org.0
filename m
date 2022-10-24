Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B96609DF3
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJXJZm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJXJZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 05:25:39 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E4C645C;
        Mon, 24 Oct 2022 02:25:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MwqJY3nz0z9y0Bb;
        Mon, 24 Oct 2022 17:19:09 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3o3DzWVZjleQJAA--.1629S2;
        Mon, 24 Oct 2022 10:25:15 +0100 (CET)
Message-ID: <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from
 bpf_lsm_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Mon, 24 Oct 2022 11:25:01 +0200
In-Reply-To: <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
         <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3o3DzWVZjleQJAA--.1629S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryrXFWfWw17uFW8AFW8WFg_yoWxAF17pF
        WDK3Wakrs8AFW7WryIqa17u3WSg3yrGr4UGrnxJr17Z3ZIvrn7tr40yr1a9Fn5JrWkK3WF
        vw4avr15Ww1DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4CT3AACs1
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2022-10-23 at 16:36 -0700, Alexei Starovoitov wrote:

Sorry, forgot to CC Mimi and linux-integrity.

> On Fri, Oct 21, 2022 at 9:57 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > BPF LSM allows security modules to directly attach to the security
> > hooks,
> > with the potential of not meeting the kernel expectation.
> > 
> > This is the case for the inode_init_security hook, for which the
> > kernel
> > expects that name and value are set if the hook implementation
> > returns
> > zero.
> > 
> > Consequently, not meeting the kernel expectation can cause the
> > kernel to
> > crash. One example is evm_protected_xattr_common() which expects
> > the
> > req_xattr_name parameter to be always not NULL.
> 
> Sounds like a bug in evm_protected_xattr_common.

If an LSM implementing the inode_init_security hook returns -EOPNOTSUPP
or -ENOMEM, evm_protected_xattr_common() is not going to be executed.

This is documented in include/linux/lsm_hooks.h

Why it would be a bug in evm_protected_xattr_common()?

> > Introduce a level of indirection in BPF LSM, for the
> > inode_init_security
> > hook, to check the validity of the name and value set by security
> > modules.
> 
> Doesn't make sense.

Look at this example. The LSM infrastructure has a convention on return
values for the hooks (maybe there is something similar for other
hooks). The code calling the hooks relies on such conventions. If
conventions are not followed a panic occurs.

If LSMs go to the kernel, their code is checked for compliance with the
conventions. However, this does not happen for security modules
attached to the BPF LSM, because BPF LSM directly executes the eBPF
programs without further checks.

I was able to trigger the panic with this simple eBPF program:

SEC("lsm/inode_init_security")
int BPF_PROG(test_int_hook, struct inode *inode,
	 struct inode *dir, const struct qstr *qstr, const char **name,
	 void **value, size_t *len)
{
	return 0;
}

In my opinion, the level of indirection is necessary to ensure that
kernel expectations are met.

> You probably meant security_old_inode_init_security,
> because the hook without _old_ doesn't have such args:
> int security_inode_init_security(struct inode *inode, struct inode
> *dir,
>                                  const struct qstr *qstr,
>                                  initxattrs initxattrs, void
> *fs_data);

I meant inode_init_security. The signature of the hook is different
from that of security_inode_init_security():

LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
	 struct inode *dir, const struct qstr *qstr, const char **name,
	 void **value, size_t *len)

BPF LSM programs attach to the attachment points defined with:

#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
{						\
	return DEFAULT;				\
}

#include <linux/lsm_hook_defs.h>
#undef LSM_HOOK

> Encapsulate bpf_lsm_inode_init_security(), the existing attachment
> > point,
> > with bpf_inode_init_security(), the new function. After the
> > attachment
> > point is called, return -EOPNOTSUPP if the xattr name is not set,
> > -ENOMEM
> > if the xattr value is not set.
> > 
> > As the name still cannot be set, rely on future patches to the eBPF
> > verifier or introducing new kfuncs/helpers to ensure its
> > correctness.
> > 
> > Finally, as proposed by Nicolas, update the LSM hook documentation
> > for the
> > inode_init_security hook, to reflect the current behavior (only the
> > xattr
> > value is allocated).
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 520b7aa00d8cd ("bpf: lsm: Initialize the BPF LSM hooks")
> > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hooks.h |  4 ++--
> >  security/bpf/hooks.c      | 25 +++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 4ec80b96c22e..f44d45f4737f 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -229,8 +229,8 @@
> >   *     This hook is called by the fs code as part of the inode
> > creation
> >   *     transaction and provides for atomic labeling of the inode,
> > unlike
> >   *     the post_create/mkdir/... hooks called by the VFS.  The
> > hook function
> > - *     is expected to allocate the name and value via kmalloc,
> > with the caller
> > - *     being responsible for calling kfree after using them.
> > + *     is expected to allocate the value via kmalloc, with the
> > caller
> > + *     being responsible for calling kfree after using it.
> 
> must be an obsolete comment.
> 
> >   *     If the security module does not use security attributes or
> > does
> >   *     not wish to put a security attribute on this particular
> > inode,
> >   *     then it should return -EOPNOTSUPP to skip this processing.
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index e5971fa74fd7..492c07ba6722 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -6,11 +6,36 @@
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/bpf_lsm.h>
> > 
> > +static int bpf_inode_init_security(struct inode *inode, struct
> > inode *dir,
> > +                                  const struct qstr *qstr, const
> > char **name,
> > +                                  void **value, size_t *len)
> > +{
> > +       int ret;
> > +
> > +       ret = bpf_lsm_inode_init_security(inode, dir, qstr, name,
> > value, len);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * As the name cannot be set by the eBPF programs directly,
> > eBPF will
> > +        * be responsible for its correctness through the verifier
> > or
> > +        * appropriate kfuncs/helpers.
> > +        */
> > +       if (name && !*name)
> > +               return -EOPNOTSUPP;
> 
> bpf cannot write into such pointers.
> It won't be able to use kfuncs to kmalloc and write into them either.
> None of it makes sense to me.

Ok, so it is a technical limitation not being able to implement the
inode_init_security hook in eBPF. Should we always return -EOPNOTSUPP
even if eBPF programs are successully attached to inode_init_security?

Thanks

Roberto

> > +
> > +       if (value && !*value)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> >  static struct security_hook_list bpf_lsm_hooks[]
> > __lsm_ro_after_init = {
> >         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> >         LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> >         #include <linux/lsm_hook_defs.h>
> >         #undef LSM_HOOK
> > +       LSM_HOOK_INIT(inode_init_security,
> > bpf_inode_init_security),
> >         LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> >         LSM_HOOK_INIT(task_free, bpf_task_storage_free),
> >  };
> > --
> > 2.25.1
> > 


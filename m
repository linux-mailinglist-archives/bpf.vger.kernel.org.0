Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B537A610C7C
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJ1IuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 04:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJ1Itx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 04:49:53 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26514102F;
        Fri, 28 Oct 2022 01:49:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MzGK11SwTz9xFfs;
        Fri, 28 Oct 2022 16:43:01 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3o3B8l1tjSAUbAA--.18857S2;
        Fri, 28 Oct 2022 09:49:08 +0100 (CET)
Message-ID: <edf0ec89c61fbee68fd537981982e14b1674393d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from
 bpf_lsm_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Fri, 28 Oct 2022 10:48:56 +0200
In-Reply-To: <CACYkzJ4ak4=qPNQxVckvn3c8CZpXkXSLSyYa_HCU-RJNyuLoZg@mail.gmail.com>
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
         <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
         <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
         <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
         <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
         <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
         <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com>
         <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
         <34357c96-fe58-ffe5-e464-4bded8f119d5@huaweicloud.com>
         <CAADnVQKD5e9vKsSo1TPeBm5hr6j4GzQeHqRURoBJyB++VOwHCw@mail.gmail.com>
         <CACYkzJ4ak4=qPNQxVckvn3c8CZpXkXSLSyYa_HCU-RJNyuLoZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3o3B8l1tjSAUbAA--.18857S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1kXFWkuF4ruw4rZw45GFg_yoWrCrWDpF
        W5tF1jkr4DJFy7Cr1Iqa15XrWIyryfKrsrXwn8Jr1UZFyqvr1ayr17Jr4Y9FWUur4UGw1F
        vr4jvrW3Zw1DA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4TG5gAAsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-10-27 at 12:39 +0200, KP Singh wrote:
> On Wed, Oct 26, 2022 at 7:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Wed, Oct 26, 2022 at 1:42 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On 10/26/2022 8:37 AM, Alexei Starovoitov wrote:
> > > > On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <
> > > > casey@schaufler-ca.com> wrote:
> > > > > On 10/25/2022 12:43 AM, Roberto Sassu wrote:
> > > > > > On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov
> > > > > > wrote:
> > > > > > > I'm looking at security_inode_init_security() and it is
> > > > > > > indeed messy.
> > > > > > > Per file system initxattrs callback that processes
> > > > > > > kmalloc-ed
> > > > > > > strings.
> > > > > > > Yikes.
> > > > > > > 
> > > > > > > In the short term we should denylist inode_init_security
> > > > > > > hook to
> > > > > > > disallow attaching bpf-lsm there. set/getxattr should be
> > > > > > > done
> > > > > > > through kfuncs instead of such kmalloc-a-string hack.
> > > > > > Inode_init_security is an example. It could be that the
> > > > > > other hooks are
> > > > > > affected too. What happens if they get arbitrary positive
> > > > > > values too?
> > > > > 
> > > > > TL;DR - Things will go cattywampus.
> > > > > 
> > > > > The LSM infrastructure is an interface that has "grown
> > > > > organically",
> > > > > and isn't necessarily consistent in what it requires of the
> > > > > security
> > > > > module implementations. There are cases where it assumes that
> > > > > the
> > > > > security module hooks are well behaved, as you've discovered.
> > > > > I have
> > > > > no small amount of fear that someone is going to provide an
> > > > > eBPF
> > > > > program for security_secid_to_secctx(). There has been an
> > > > > assumption,
> > > > > oft stated, that all security modules are going to be
> > > > > reviewed as
> > > > > part of the upstream process. The review process ought to
> > > > > catch hooks
> > > > > that return unacceptable values. Alas, we've lost that with
> > > > > BPF.
> > > > > 
> > > > > It would take a(nother) major overhaul of the LSM
> > > > > infrastructure to
> > > > > make it safe against hooks that are not well behaved. From
> > > > > what I have
> > > > > seen so far it wouldn't be easy/convenient/performant to do
> > > > > it in the
> > > > > BPF security module either. I personally think that BPF needs
> > > > > to
> > > > > ensure that the eBPF implementations don't return
> > > > > inappropriate values,
> > > > > but I understand why that is problematic.
> > > > 
> > > > That's an accurate statement. Thank you.
> > > > 
> > > > Going back to the original question...
> > > > We fix bugs when we discover them.
> > > > Regardless of the subsystem they belong to.
> > > > No finger pointing.
> > > 
> > > I'm concerned about the following situation:
> > > 
> > > struct <something> *function()
> > > {
> > > 
> > >         ret = security_*();
> > >         if (ret)
> > >                 return ERR_PTR(ret);
> > > 
> > > }
> > > 
> > > int caller()
> > > {
> > >         ptr = function()
> > >         if (IS_ERR(ptr)
> > >                 goto out;
> > > 
> > >         <use of invalid pointer>
> > > }
> > > 
> > > I quickly found an occurrence of this:
> > > 
> > > static int lookup_one_common()
> > > {
> > > 
> > > [...]
> > > 
> > >         return inode_permission();
> > > }
> > > 
> > > struct dentry *try_lookup_one_len()
> > > {
> > > 
> > > [...]
> > > 
> > >          err = lookup_one_common(&init_user_ns, name, base, len,
> > > &this);
> > >          if (err)
> > >                  return ERR_PTR(err);
> > > 
> > > 
> > > Unfortunately, attaching to inode_permission causes the kernel
> > > to crash immediately (it does not happen with negative return
> > > values).
> > > 
> > > So, I think the fix should be broader, and not limited to the
> > > inode_init_security hook. Will try to see how it can be fixed.
> > 
> > I see. Let's restrict bpf-lsm return values to IS_ERR_VALUE.
> > Trivial verifier change.
> 
> Thanks, yes this indeed is an issue. We need to do a few things:
> 
> 1. Restrict some hooks that we know the BPF LSM will never need.
> 2. A verifier function that checks return values of LSM
> hooks.
> For most LSK hooks IS_ERR_VALUE is fine, however, there are some
> hooks
> like *xattr hooks that use a return value of 1 to indicate a
> capability check is required which might need special handling.

I looked at security.c:

/*
 * SELinux and Smack integrate the cap call,
 * so assume that all LSMs supplying this call do so.
 */

Other than checking the return value, probably we should also wrap
bpf_lsm_inode_{set,remove}xattr() to do the capability check, right?

Roberto


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB0632847
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKUPdd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiKUPdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:33:05 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6841B1CC;
        Mon, 21 Nov 2022 07:32:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NGB63737Bz9xqxj;
        Mon, 21 Nov 2022 23:25:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnGfbWmXtjPqGBAA--.27968S2;
        Mon, 21 Nov 2022 16:31:46 +0100 (CET)
Message-ID: <f1c18c3b37b36d7550a467f4fb03a0f15e7647d4.camel@huaweicloud.com>
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed
 code
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 21 Nov 2022 16:31:29 +0100
In-Reply-To: <ac7ed3d7-774c-dffe-7940-198cf32592b4@huaweicloud.com>
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
         <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
         <41c6eac1-4e02-3499-5d83-468dd1ca434a@schaufler-ca.com>
         <ac7ed3d7-774c-dffe-7940-198cf32592b4@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnGfbWmXtjPqGBAA--.27968S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4rZw47uFWUJr18Ar1DJrb_yoWrJr1rpa
        1IgayYkr4vkr1xC3Wjqws8uaySkrZ8Xr4UW3W5t34Yvas0vr1aqF1UGrWY9a90krnYkw1j
        qr4Yq39rCryDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj4GtKgAAsy
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-11-18 at 09:44 +0100, Roberto Sassu wrote:
> On 11/16/2022 6:12 PM, Casey Schaufler wrote:
> > On 11/16/2022 7:47 AM, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > eBPF allows certain types of eBPF programs to modify the return value of
> > > the functions they attach to. This is used for example by BPF LSM to let
> > > security modules make their decision on LSM hooks.
> > > 
> > > The JITed code looks like the following:
> > > 
> > >      ret = bpf_lsm_inode_permission_impl1(); // from a security module
> > >      if (ret)
> > >          goto out;
> > > 
> > > ..
> > > 
> > >      ret = bpf_lsm_inode_permission_implN(); // from a security module
> > >      if (ret)
> > >          goto out;
> > > 
> > >      ret = bpf_lsm_inode_permission(); // in the kernel, returns DEFAULT
> > > out:
> > > 
> > > If ret is not zero, the attachment points of BPF LSM are not executed. For
> > > this reason, the return value check cannot be done there.
> > > 
> > > Instead, the idea is to use the LSM_HOOK() macro to define a per-hook check
> > > function.
> > > 
> > > Whenever an eBPF program attaches to an LSM hook, the eBPF verifier
> > > resolves the address of the check function (whose name is
> > > bpf_lsm_<hook name>_ret()) and adds a call to that function just after the
> > > out label. If the return value is illegal, the check function changes it
> > > back to the default value defined by the LSM infrastructure:
> > > 
> > > ..
> > > 
> > > out:
> > >      ret = bpf_lsm_inode_permission_ret(ret);
> > 
> > As I've mentioned elsewhere, the return value is a small part of
> > the problem you have with eBPF programs and the BPF LSM. Because
> > the LSM infrastructure is inconsistent with regard to return codes,
> > values returned in pointers and use of secids there is no uniform
> > mechanism that I can see to address the "legitimate return" problem.
> > 
> > Lets look at one of the ickyest interfaces we have, security_getprocattr().
> > It returns the size of a string that it has allocated. It puts the
> > pointer to the allocated buffer into a char **value that was passed to it.
> > If bpf_getprocattr() returns a positive number and sets value to NULL Bad
> > Things can happen. If the return value is greater than the size allocated
> > ditto. If it returns an error but allocates a string you get a memory leak.
> 
> I hope I understood how it works correctly, but you cannot modify 
> directly data accessible from a pointer provided as parameter by the LSM 
> hook you attach to. The pointer is treated as scalar value and the eBPF 
> verifier detects any attempt to dereference as an illegal access. The 
> only way to modify such data is through helpers that need to be properly 
> declared to be usable by eBPF programs.

I wanted to double check about accessing the LSM hook arguments from an
eBPF program. I checked what it could prevent to access them.

First, in kernel/bpf/btf.c:

if (!btf_type_is_struct(t)) {
	bpf_log(log,
		"func '%s' arg%d type %s is not a struct\n",

If the argument is not a struct, it is not accessible.


Second, if a btf_struct_access method has not been defined for a
structure, only read can be done (kernel/bpf/verifier.c):

if (env->ops->btf_struct_access) {
	ret = env->ops->btf_struct_access(...);
} else {
	if (atype != BPF_READ) {
		verbose(env, "only read is supported\n");
		return -EACCES;
	}

I found four:

net/bpf/bpf_dummy_struct_ops.c: .btf_struct_access =
bpf_dummy_ops_btf_struct_access,
net/core/filter.c:      .btf_struct_access      =
tc_cls_act_btf_struct_access,
net/core/filter.c:      .btf_struct_access      =
xdp_btf_struct_access,
net/ipv4/bpf_tcp_ca.c:  .btf_struct_access      =
bpf_tcp_ca_btf_struct_access,

Anything else?

Thanks

Roberto


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0060C5AF
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiJYHo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiJYHoN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 03:44:13 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8764415F93A;
        Tue, 25 Oct 2022 00:43:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MxP1s09rBz9v7Yw;
        Tue, 25 Oct 2022 15:38:25 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAXTPigk1dj5OwNAA--.5676S2;
        Tue, 25 Oct 2022 08:43:37 +0100 (CET)
Message-ID: <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
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
Date:   Tue, 25 Oct 2022 09:43:25 +0200
In-Reply-To: <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
         <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
         <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
         <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
         <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAXTPigk1dj5OwNAA--.5676S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy3Cr1DWFWrtFWfuFWUXFb_yoWxGr4fpF
        W8JF1jkr4kJF15Gr129a1Uuw1Ik3y3Ca1UXF95Jr1UAF1q9rn5Ar10yF4UuF9rGr45u3W2
        vw4jvw4a9w1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj4CeEQABsp
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
> On Mon, Oct 24, 2022 at 8:28 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2022-10-24 at 11:25 +0200, Roberto Sassu wrote:
> > > On Sun, 2022-10-23 at 16:36 -0700, Alexei Starovoitov wrote:
> > > 
> > > Sorry, forgot to CC Mimi and linux-integrity.
> > > 
> > > > On Fri, Oct 21, 2022 at 9:57 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > BPF LSM allows security modules to directly attach to the
> > > > > security
> > > > > hooks,
> > > > > with the potential of not meeting the kernel expectation.
> > > > > 
> > > > > This is the case for the inode_init_security hook, for which
> > > > > the
> > > > > kernel
> > > > > expects that name and value are set if the hook
> > > > > implementation
> > > > > returns
> > > > > zero.
> > > > > 
> > > > > Consequently, not meeting the kernel expectation can cause
> > > > > the
> > > > > kernel to
> > > > > crash. One example is evm_protected_xattr_common() which
> > > > > expects
> > > > > the
> > > > > req_xattr_name parameter to be always not NULL.
> > > > 
> > > > Sounds like a bug in evm_protected_xattr_common.
> > > 
> > > If an LSM implementing the inode_init_security hook returns
> > > -EOPNOTSUPP
> > > or -ENOMEM, evm_protected_xattr_common() is not going to be
> > > executed.
> > > 
> > > This is documented in include/linux/lsm_hooks.h
> > > 
> > > Why it would be a bug in evm_protected_xattr_common()?
> > > 
> > > > > Introduce a level of indirection in BPF LSM, for the
> > > > > inode_init_security
> > > > > hook, to check the validity of the name and value set by
> > > > > security
> > > > > modules.
> > > > 
> > > > Doesn't make sense.
> > > 
> > > Look at this example. The LSM infrastructure has a convention on
> > > return
> > > values for the hooks (maybe there is something similar for other
> > > hooks). The code calling the hooks relies on such conventions. If
> > > conventions are not followed a panic occurs.
> > > 
> > > If LSMs go to the kernel, their code is checked for compliance
> > > with the
> > > conventions. However, this does not happen for security modules
> > > attached to the BPF LSM, because BPF LSM directly executes the
> > > eBPF
> > > programs without further checks.
> > > 
> > > I was able to trigger the panic with this simple eBPF program:
> > > 
> > > SEC("lsm/inode_init_security")
> > > int BPF_PROG(test_int_hook, struct inode *inode,
> > >        struct inode *dir, const struct qstr *qstr, const char
> > > **name,
> > >        void **value, size_t *len)
> > > {
> > >       return 0;
> > > }
> > > 
> > > In my opinion, the level of indirection is necessary to ensure
> > > that
> > > kernel expectations are met.
> > 
> > I investigated further. Instead of returning zero, I return one.
> > This
> > causes a crash even with the most recent kernel (lsm=bpf):
> > 
> > [   27.685704] BUG: kernel NULL pointer dereference, address:
> > 00000000000000e1
> > [   27.686445] #PF: supervisor read access in kernel mode
> > [   27.686964] #PF: error_code(0x0000) - not-present page
> > [   27.687465] PGD 0 P4D 0
> > [   27.687724] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   27.688155] CPU: 9 PID: 897 Comm: in:imjournal Not tainted
> > 6.1.0-rc2 #255
> > [   27.688807] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > [   27.689652] RIP: 0010:fsnotify+0x71a/0x780
> > [   27.690056] Code: ff 48 85 db 74 54 48 83 bb 68 04 00 00 00 74
> > 4a 41 8b 92 98 06 00 00 4d 85 ed
> > 0f 85 a6 f9 ff ff e9 ad f9 ff ff 48 8b 44 24 08 <4c> 8b 90 e0 00 00
> > 00 e9 00 fa ff ff 48 c7 c2 b8 12
> > 78 82 be 81 01
> > [   27.691809] RSP: 0018:ffffc90001307ca0 EFLAGS: 00010246
> > [   27.692313] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
> > ffff88811d73b4a8
> > [   27.692998] RDX: 0000000000000003 RSI: 0000000000000001 RDI:
> > 0000000000000100
> > [   27.693682] RBP: ffff888100441c08 R08: 0000000000000059 R09:
> > 0000000000000000
> > [   27.694371] R10: 0000000000000000 R11: ffff88846fc72d30 R12:
> > 0000000000000100
> > [   27.695073] R13: ffff88811a2a5200 R14: ffffc90001307dc0 R15:
> > 0000000000000001
> > [   27.695738] FS:  00007ff791000640(0000)
> > GS:ffff88846fc40000(0000) knlGS:0000000000000000
> > [   27.696137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   27.696430] CR2: 00000000000000e1 CR3: 0000000112aa6000 CR4:
> > 0000000000350ee0
> > [   27.696782] Call Trace:
> > [   27.696909]  <TASK>
> > [   27.697026]  path_openat+0x484/0xa00
> > [   27.697218]  ? rcu_read_lock_held_common+0xe/0x50
> > [   27.697461]  do_filp_open+0x9f/0xf0
> > [   27.697643]  ? rcu_read_lock_sched_held+0x13/0x70
> > [   27.697888]  ? lock_release+0x1e1/0x2a0
> > [   27.698085]  ? _raw_spin_unlock+0x29/0x50
> > [   27.698291]  do_sys_openat2+0x226/0x300
> > [   27.698491]  do_sys_open+0x34/0x60
> > [   27.698667]  do_syscall_64+0x3b/0x90
> > [   27.698861]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > Beeing positive, instead of negative, the return code is converted
> > to a legitimate pointer instead of an error pointer, causing a
> > crash
> > in fsnotify().
> 
> Could you point to the code that does that?

It happens when a new file is created:

#0  xfs_generic_create at fs/xfs/xfs_iops.c:253
#1  0xffffffff813f4508 in lookup_open at fs/namei.c:3413
#2  0xffffffff813f9b61 in open_last_lookups at fs/namei.c:3481

In open_last_lookups(), we have:

	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
		fsnotify_create(dir->d_inode, dentry);

But dentry is equal to 1:

(gdb) p dentry
$7 = (struct dentry *) 0x1 <fixed_percpu_data+1>

Continuing to debug, we encounter:

fsnotify_data_sb (data_type=3, data=0x1 <fixed_percpu_data+1>) at
./include/linux/fsnotify_backend.h:347
347			return ((struct dentry *)data)->d_sb;

which is an invalid access.

> I'm looking at security_inode_init_security() and it is indeed messy.
> Per file system initxattrs callback that processes kmalloc-ed
> strings.
> Yikes.
> 
> In the short term we should denylist inode_init_security hook to
> disallow attaching bpf-lsm there. set/getxattr should be done
> through kfuncs instead of such kmalloc-a-string hack.

Inode_init_security is an example. It could be that the other hooks are
affected too. What happens if they get arbitrary positive values too?

Thanks

Roberto


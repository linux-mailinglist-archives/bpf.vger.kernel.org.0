Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4366663C72
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 10:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjAJJMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 04:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbjAJJMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 04:12:06 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548974A965;
        Tue, 10 Jan 2023 01:12:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NrlHW6BZtz9v7Gc;
        Tue, 10 Jan 2023 17:04:23 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn913KK71jj+eDAA--.49127S2;
        Tue, 10 Jan 2023 10:11:46 +0100 (CET)
Message-ID: <981170d7e587ff2c7e4673b1acc2886200e22392.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Tue, 10 Jan 2023 10:11:12 +0100
In-Reply-To: <CAHC9VhSRs0cUowuedQ1Sth4U7P5vcJMqe-qTLMBvCpYbeZ5OxA@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
         <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
         <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
         <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
         <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
         <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
         <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
         <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com>
         <c0f7120e433c80b7c4e0af788eda58de8d1ecdad.camel@huaweicloud.com>
         <CAHC9VhQKa36C4xh1OiCdC1baNSeNL7OMLY9zg4O0UWahX-mzow@mail.gmail.com>
         <4175e56b-8522-5086-bdf1-b534122c841b@huaweicloud.com>
         <CAHC9VhSRs0cUowuedQ1Sth4U7P5vcJMqe-qTLMBvCpYbeZ5OxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAn913KK71jj+eDAA--.49127S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1DJw4rAF4xGF1xtFy8Grg_yoWrWrWDpr
        W5J3W3KF4DJ343Aan7tFyDJF1Fy3WfJr4UA34Yq348Zas8Zr1Fgr47JF4UuF9Fkrs3Zw1Y
        q3yYqFnrC3WqvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4NnJgAAs4
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-12-21 at 19:55 -0500, Paul Moore wrote:
> On Wed, Dec 21, 2022 at 4:54 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On 12/20/2022 9:44 PM, Paul Moore wrote:
> > > On Fri, Dec 16, 2022 at 5:24 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > Ok, let me try to complete the solution for the issues Lorenz pointed
> > > > out. Here I discuss only the system call side of access.
> > > > 
> > > > I was thinking on the meaning of the permissions on the inode of a
> > > > pinned eBPF object. Given that the object exists without pinning, this
> > > > double check of permissions first on the inode and then on the object
> > > > to me looks very confusing.
> > > > 
> > > > So, here is a proposal: what if read and write in the context of
> > > > pinning don't refer to accessing the eBPF object itself but to the
> > > > ability to read the association between inode and eBPF object or to
> > > > write/replace the association with a different eBPF object (I guess not
> > > > supported now).
> > > > 
> > > > We continue to do access control only at the time a requestor asks for
> > > > a fd. Currently there is only MAC, but we can add DAC and POSIX ACL too
> > > > (Andrii wanted to give read permission to a specific group). The owner
> > > > is who created the eBPF object and who can decide (for DAC and ACL) who
> > > > can access that object.
> > > > 
> > > > The requestor obtains a fd with modes depending on what was granted. Fd
> > > > modes (current behavior) give the requestor the ability to do certain
> > > > operations. It is responsibility of the function performing the
> > > > operation on an eBPF object to check the fd modes first.
> > > > 
> > > > It does not matter if the eBPF object is accessed through ID or inode,
> > > > access control is solely based on who is accessing the object, who
> > > > created it and the object permissions. *_GET_FD_BY_ID and OBJ_GET
> > > > operations will have the same access control.
> > > > 
> > > > With my new proposal, once an eBPF object is pinned the owner or
> > > > whoever can access the inode could do chown/chmod. But this does not
> > > > have effect on the permissions of the object. It changes only who can
> > > > retrieve the association with the eBPF object itself.
> > > 
> > > Just to make sure I understand you correctly, you're suggesting that
> > > the access modes assigned to a pinned map's fd are simply what is
> > > requested by the caller, and don't necessarily represent the access
> > > control modes of the underlying map, is that correct?  That seems a
> > 
> > The fd modes don't necessarily represent the access control modes of the
> > inode the map is pinned to. But they surely represent the access control
> > modes of the map object itself.
> > 
> > The access control modes of the inode tell if the requestor is able to
> > retrieve the map from it, before accessing the map is attempted. But,
> > even if the request is granted (i.e. the inode has read permission), the
> > requestor has still to pass access control on the map object, which is
> > separate.
> 
> Okay, good.  That should work.
> 
> > Fd modes are bound to the map access modes, but not necessarily bound to
> > the inode access modes (fd with write mode, on an inode with only read
> > permission). Fd modes are later enforced by map operations by checking
> > the compatibility of the operation (e.g. read-like operation requires fd
> > read mode).
> > 
> > The last point is what it means getting a fd on the inode itself. It is
> > possible, because inodes could have seq_file operations. Thus, one could
> > dump the map content by just reading from the inode.
> 
> Gotcha, yes, that would be bad.
> 
> > Here, I suggest that we still do two separate checks. One is for the
> > open(), done by the VFS, and the other to access the map object. Not
> > having read permission on the inode means that the map content cannot be
> > dumped. But, having read permission on the inode does not imply the
> > ability to do it (still the map object check has to be passed).
> 
> That makes sense to me.

Andrii, Lorenz, what do you think about the new interpretation of the
permissions of the inode of a pinned map?

Thanks

Roberto


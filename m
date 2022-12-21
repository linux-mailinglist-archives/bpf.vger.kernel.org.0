Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC7652F0B
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 10:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiLUJ7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiLUJ6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 04:58:40 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644B2253A;
        Wed, 21 Dec 2022 01:54:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NcT9l2V3Cz9xFGX;
        Wed, 21 Dec 2022 17:46:51 +0800 (CST)
Received: from [10.48.129.132] (unknown [10.48.129.132])
        by APP1 (Coremail) with SMTP id LxC2BwDHTwur16JjIoEvAA--.24993S2;
        Wed, 21 Dec 2022 10:53:56 +0100 (CET)
Message-ID: <4175e56b-8522-5086-bdf1-b534122c841b@huaweicloud.com>
Date:   Wed, 21 Dec 2022 10:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Closing the BPF map permission loophole
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
Content-Language: en-US
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAHC9VhQKa36C4xh1OiCdC1baNSeNL7OMLY9zg4O0UWahX-mzow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDHTwur16JjIoEvAA--.24993S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWfWF4UJr13WF4rtr4fZrb_yoW7WFy5pr
        W5J3W3KF4DJ3yfCan7tFyDt3WFy3WfArW5Aa4Yq3y8Z3Z8ZF1Fgr43JF4jvF9rGrs3Zw4Y
        grs0qF1DC3WqvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4bgkwAAsM
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/2022 9:44 PM, Paul Moore wrote:
> On Fri, Dec 16, 2022 at 5:24 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> Ok, let me try to complete the solution for the issues Lorenz pointed
>> out. Here I discuss only the system call side of access.
>>
>> I was thinking on the meaning of the permissions on the inode of a
>> pinned eBPF object. Given that the object exists without pinning, this
>> double check of permissions first on the inode and then on the object
>> to me looks very confusing.
>>
>> So, here is a proposal: what if read and write in the context of
>> pinning don't refer to accessing the eBPF object itself but to the
>> ability to read the association between inode and eBPF object or to
>> write/replace the association with a different eBPF object (I guess not
>> supported now).
>>
>> We continue to do access control only at the time a requestor asks for
>> a fd. Currently there is only MAC, but we can add DAC and POSIX ACL too
>> (Andrii wanted to give read permission to a specific group). The owner
>> is who created the eBPF object and who can decide (for DAC and ACL) who
>> can access that object.
>>
>> The requestor obtains a fd with modes depending on what was granted. Fd
>> modes (current behavior) give the requestor the ability to do certain
>> operations. It is responsibility of the function performing the
>> operation on an eBPF object to check the fd modes first.
>>
>> It does not matter if the eBPF object is accessed through ID or inode,
>> access control is solely based on who is accessing the object, who
>> created it and the object permissions. *_GET_FD_BY_ID and OBJ_GET
>> operations will have the same access control.
>>
>> With my new proposal, once an eBPF object is pinned the owner or
>> whoever can access the inode could do chown/chmod. But this does not
>> have effect on the permissions of the object. It changes only who can
>> retrieve the association with the eBPF object itself.
> 
> Just to make sure I understand you correctly, you're suggesting that
> the access modes assigned to a pinned map's fd are simply what is
> requested by the caller, and don't necessarily represent the access
> control modes of the underlying map, is that correct?  That seems a

The fd modes don't necessarily represent the access control modes of the 
inode the map is pinned to. But they surely represent the access control 
modes of the map object itself.

The access control modes of the inode tell if the requestor is able to 
retrieve the map from it, before accessing the map is attempted. But, 
even if the request is granted (i.e. the inode has read permission), the 
requestor has still to pass access control on the map object, which is 
separate.

> little odd to me, but I'll once again admit that I'm not familiar with
> all of the subtle nuances around eBPF maps.  I could understand
> allowing a process to grab a map fd where the access modes are bounded
> by the map's access modes, e.g. a read-only fd for a read-write map;
> however, that only makes sense if all of the map operations for *that
> process* are gated by the access control policy of the fd and not
> necessarily the map itself.  If the two access policies were disjoint
> (fd/map), one could/should do permission checks between the calling
> process and both the fd and the map ... although I'm having a hard
> time trying to think of a valid use case where a map's fd would have a
> *more* permissive access control policy than the map itself, I'm not
> sure that makes sense.

Fd modes are bound to the map access modes, but not necessarily bound to 
the inode access modes (fd with write mode, on an inode with only read 
permission). Fd modes are later enforced by map operations by checking 
the compatibility of the operation (e.g. read-like operation requires fd 
read mode).

The last point is what it means getting a fd on the inode itself. It is 
possible, because inodes could have seq_file operations. Thus, one could 
dump the map content by just reading from the inode.

Here, I suggest that we still do two separate checks. One is for the 
open(), done by the VFS, and the other to access the map object. Not 
having read permission on the inode means that the map content cannot be 
dumped. But, having read permission on the inode does not imply the 
ability to do it (still the map object check has to be passed).

Roberto

>> Permissions on the eBPF object could be changed with the bpf() syscall
>> and with new operations (such as OBJ_CHOWN, OBJ_CHMOD). These
>> operations are of course subject to access control too.
>>
>> The last part is who can do pinning. Again, an eBPF object can be
>> pinned several times by different users. It won't affect who can access
>> the object, but only who can access the association between inode and
>> eBPF object.
>>
>> We can make things very simple: whoever is able to read the association
>> is granted with the privilege to pin the eBPF object again.
>>
>> One could ask what happens if a user has only read permission on an
>> inode created by someone else, but has also write permission on a new
>> inode the user creates by pinning the eBPF object again (I assume that
>> changing the association makes sense). Well, that user is the owner of
>> the inode. If the user wants other users accessing it to see a
>> different eBPF object, it is the user's decision.
> 


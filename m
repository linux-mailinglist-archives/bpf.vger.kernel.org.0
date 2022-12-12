Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5464A49A
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiLLQLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 11:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiLLQLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 11:11:15 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431F2660;
        Mon, 12 Dec 2022 08:11:12 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NW5z02dmNz9xrch;
        Tue, 13 Dec 2022 00:03:56 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWSBUpdj5mgJAA--.15328S2;
        Mon, 12 Dec 2022 17:10:52 +0100 (CET)
Message-ID: <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Mon, 12 Dec 2022 17:10:37 +0100
In-Reply-To: <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
         <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
         <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
         <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
         <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCXHWSBUpdj5mgJAA--.15328S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45Kw4kAr1rGF45ZFyDGFg_yoW5Ar1DpF
        s8G3W3Kr1ktr4vk34xt3y5Ja4agw4rJF1jgr1Yy3ykZa909r1akF4IgF4YgasFkr4xGr1Y
        9rZ2v34DG3W7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj4aMxQAAs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-11-07 at 13:11 +0100, Roberto Sassu wrote:

[...]

> > > > P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> > > > BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> > > > user will control that. E.g., FS read-only permission, does it
> > > > restrict both user-space and BPF-view, or just user-space view? We can
> > > > certainly extend file_flags to allow users to get BPF-side read-only
> > > > and user-space-side read-write BPF map FD, for example. Obviously, BPF
> > > > verifier would need to know about struct bpf_map_view when accepting
> > > > BPF map FD in ldimm64 and such.
> > > 
> > > I guess, this patch could be used:
> > > 
> > > https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/
> > > 
> > > When passing a fd to an eBPF program, the permissions of the user space
> > > side cannot exceed those defined from eBPF program side.
> > 
> > Don't know, maybe. But I can see how BPF-side can be declared r/w for
> > BPF programs, while user-space should be restricted to read-only. I'm
> > a bit hesitant to artificially couple both together.
> 
> Ok. At least what I would do is to forbid write, if you provide a read-
> only fd.

Ok, we didn't do too much progress for a while. I would like to resume
the discussion.

Can we start from the first point Lorenz mentioned? Given a read-only
map fd, it is not possible to write to the map. Can we make sure that
this properly work?

In my opinion, to achieve this particular goal, the map view
abstraction Andrii suggested, should not be necessary. For pinning too,
I think incremental changes on top of the ones suggested below would be
sufficient, so I would rather discuss them separately.
 
As far as I know, there are two open issues that prevent Lorenz's
assertion on read-only map fds from being true. They are:

- map iterator
- map fd injected to eBPF programs

In both cases, a read-only map fd is sufficient to cause a map update.

I have proposed two patches to address the issues above:

https://lore.kernel.org/bpf/20220906170301.256206-2-roberto.sassu@huaweicloud.com/

If an iterator allows the key or value to be modified by an eBPF
program, ensure that the map fd passed to it is read-write. Otherwise,
read-only is sufficient if both cannot be modified.


https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/

Let the verifier allow the minimum operations granted by eBPF-side
permissions and by fd modes. The intersection needs to be applied
because the map can be modified by the eBPF program through map
helpers, so it is eBPF-side, but at the same time whoever granted the
requestor a map fd expects that the permissions included in that fd are
enforced by any function using it.

I believe that with these patches Lorenz's assertion of a read-only map
fd would be true. I'm not aware of other ways which would make the
assertion false.

Thanks

Roberto


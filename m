Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913FA5E6750
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIVPj6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIVPj5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 11:39:57 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2854B4AA
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 08:39:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MYK7v6wkwz9xHds
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 23:34:03 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXBF+1gSxjBhdqAA--.34800S2;
        Thu, 22 Sep 2022 16:39:39 +0100 (CET)
Message-ID: <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Date:   Thu, 22 Sep 2022 17:39:31 +0200
In-Reply-To: <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
         <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXBF+1gSxjBhdqAA--.34800S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF13tryDuF15Jw4xtFy3twb_yoW5ZFy7pa
        yrKF9rCFn7tFWxCFn7Za13ua1UtwsxXrW7GrZ8trWUZws8Wry5JryFqFWYvFy7uFs7A34Y
        vw43ZrWrAFyDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj4NclwAAs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-09-22 at 15:47 +0100, Lorenz Bauer wrote:
> On Wed, 21 Sep 2022, at 17:32, Roberto Sassu wrote:
> > I saw your fix #2, even if I didn't fully understand it. What do
> > you
> > think instead about converting the fd modes to map flags (e.g.
> > BPF_F_RDONLY -> BPF_RDONLY_PROG), and we rely on the existing
> > verifier
> > behavior for the _PROG counterparts? In this way, it will be the
> > verifier enforcing the decision made by security_bpf_map().
> 
> Thanks for that idea, I think something like it was floated during
> the discussion after my talk as well but I forgot about it. I gave it
> a shot, and it turns out okay actually. The biggest draw back is that
> this approach requires commit 591fe9888d78 ("bpf: add program side
> {rd, wr}only support for maps") which appeared after BPF_F_RDONLY.

Yes, true. Not sure if it makes sense to backport it to stable versions
(probably not). Or alternatively, for older versions we could ensure
that the fd is for read/write, even if as you said, there is a risk of
breakage of existing applications. It seems unlikely that this could
happen, as libbpf still does not support requesting a read-only fd,
although one could create an ad-hoc function to set the appropriate
parameters for the bpf() system call.

Actually, if it may help, I could send my version of the fix I
developed to validate the idea. I also wrote the tests.

> Problem #3: Read-only fds can be transmuted into read-write fds
> > > via
> > > object pinning
> > 
> > Maybe I'm missing something, but I consider pinning more like
> > adding a
> > new reference to an eBPF object (like the ID).
> > 
> > You are still subject to access control decision by
> > security_bpf_map(),
> > as for BPF_MAP_GET_FD_BY_ID().
> 
> I had a look, security_bpf_map() is only called from
> bpf_map_new_fd(), which in turn is invoked from GET_FD_BY_ID,
> MAP_CREATE and OBJ_GET. Checking at this point is too late, since
> OBJ_PIN + chmod allow escalating privileges. Can you explain your
> idea some more?

The ability to access the path of a pinned map does not give you the
ability to access the map itself. You still need to pass
security_bpf_map(). With SELinux, you would need a rule like:

allow <ctx of subject accessing the pinned map> <ctx of the map
creator>: bpf { map_read map_write };

The inode is not passed to security_bpf_map(), so likely it is not
taken into account for the security decision.

What you say, I think it applies to map iterators. The ability to
access the path of an iterator gives you the ability to make changes to
the map without further checks.

My further question, we could discuss it separately, is: by updating
the verifier to check fd modes, and by checking the fd modes for map
iterators, are we able to intercept any possible attempt from user
space to modify a map?

> Now, the security model is limited to two permissions (read,
> > write). If
> > we want to add a new one to decide whether or not a new reference
> > can
> > be added, we could revisit this.
> 
> Maybe, but that would preclude back porting any fixes. I'll write up
> another summary in a bit that shows that this problem goes back all
> the way to the introduction of BPF_F_RDONLY, etc.

Definitely, if possible, the fix should be backportable.

Roberto


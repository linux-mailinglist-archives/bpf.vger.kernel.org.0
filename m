Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8864A6D0
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiLLSTy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLLSTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:19:39 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB484E7;
        Mon, 12 Dec 2022 10:19:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NW8qD1wJmz9xs6R;
        Tue, 13 Dec 2022 02:12:24 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnsAuccJdjCMAJAA--.1357S2;
        Mon, 12 Dec 2022 19:19:17 +0100 (CET)
Message-ID: <3fa1fdafc4335c43f84259261dcd1f7d588985a6.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Mon, 12 Dec 2022 19:19:05 +0100
In-Reply-To: <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
         <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
         <a9367491-5ac3-385b-d0d6-820772ebd395@huaweicloud.com>
         <CAEf4BzZJDRNyafMEjy-1RX9cUmpcvZzYd9YBf9Q3uv_vVsiLCw@mail.gmail.com>
         <5abb0b0090fd0bce77dca0a6b9036de121b65cf5.camel@huaweicloud.com>
         <20f55084c341093d18d2bc462e49123c7f03cc8e.camel@huaweicloud.com>
         <CAADnVQLU+c+gsZ=V6myG0-GhU3EzZgqjzTPvqvYmCDBjqMoF+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAnsAuccJdjCMAJAA--.1357S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47XFy8CF43tr1kGF45Jrb_yoW8KFW8pF
        sxG3W7Kr1kJrnrCr4Ig3yUJa43KrWrJ3W5Wrn8A39Yq3s09r1akF4IgF4Yga47Cr18Jr1Y
        yrZ2v3sxG3W5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj4aOBQAAs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-12-12 at 09:07 -0800, Alexei Starovoitov wrote:
> On Mon, Dec 12, 2022 at 8:11 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2022-11-07 at 13:11 +0100, Roberto Sassu wrote:
> > 
> > [...]
> > 
> > > > > > P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
> > > > > > BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
> > > > > > user will control that. E.g., FS read-only permission, does it
> > > > > > restrict both user-space and BPF-view, or just user-space view? We can
> > > > > > certainly extend file_flags to allow users to get BPF-side read-only
> > > > > > and user-space-side read-write BPF map FD, for example. Obviously, BPF
> > > > > > verifier would need to know about struct bpf_map_view when accepting
> > > > > > BPF map FD in ldimm64 and such.
> > > > > 
> > > > > I guess, this patch could be used:
> > > > > 
> > > > > https://lore.kernel.org/bpf/20220926154430.1552800-3-roberto.sassu@huaweicloud.com/
> > > > > 
> > > > > When passing a fd to an eBPF program, the permissions of the user space
> > > > > side cannot exceed those defined from eBPF program side.
> > > > 
> > > > Don't know, maybe. But I can see how BPF-side can be declared r/w for
> > > > BPF programs, while user-space should be restricted to read-only. I'm
> > > > a bit hesitant to artificially couple both together.
> > > 
> > > Ok. At least what I would do is to forbid write, if you provide a read-
> > > only fd.
> > 
> > Ok, we didn't do too much progress for a while. I would like to resume
> > the discussion.
> > 
> > Can we start from the first point Lorenz mentioned? Given a read-only
> > map fd, it is not possible to write to the map. Can we make sure that
> > this properly work?
> > 
> > In my opinion, to achieve this particular goal, the map view
> > abstraction Andrii suggested, should not be necessary.
> 
> What do you 'not necessary' ?
> afair the map view abstraction is only one that actually addresses
> all the issues.

For the first issue, map iterators, you need to ensure that the fd is
read-write if the key/value can be modified.

For the second issue, fd modes ignored by the verifier, you need to
restrict operations on the map, to meet the expectactions of whoever
granted the fd to the requestor (as Lorenz said, if you have a read-
only fd, you should not be able to write to the map).

Maybe I missed something, I didn't get how the map view abstraction
could help better in these cases.

Thanks

Roberto


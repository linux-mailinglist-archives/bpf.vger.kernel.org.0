Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6115EDBB3
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 13:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiI1LYb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiI1LYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 07:24:18 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F8E99AE;
        Wed, 28 Sep 2022 04:24:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Mcv9x07Zgz9xHf0;
        Wed, 28 Sep 2022 19:18:13 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHP5PDLjRjJ5yAAA--.16292S2;
        Wed, 28 Sep 2022 12:23:54 +0100 (CET)
Message-ID: <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Wed, 28 Sep 2022 13:23:45 +0200
In-Reply-To: <87mtajss8j.fsf@toke.dk>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
         <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
         <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
         <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
         <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
         <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
         <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
         <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com>
         <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
         <87mtajss8j.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHP5PDLjRjJ5yAAA--.16292S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy5tr47Kw1rWF4fCFWxZwb_yoW8Kr43pF
        W8t3Z0kF4DJr1Fka9a9w1fJFy0v3yrGFnrWr13AryrZFyDZw1rtr40kF45uF92vr1Ikw1j
        vr4Fka43Za4kZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4OJHwABsp
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-09-28 at 12:33 +0200, Toke Høiland-Jørgensen wrote:
> Roberto Sassu <roberto.sassu@huaweicloud.com> writes:
> 
> > On Wed, 2022-09-28 at 09:52 +0100, Lorenz Bauer wrote:
> > > On Mon, 26 Sep 2022, at 17:18, Roberto Sassu wrote:
> > > > Uhm, if I get what you mean, you would like to add DAC controls
> > > > to
> > > > the
> > > > pinned map to decide if you can get a fd and with which modes.
> > > > 
> > > > The problem I see is that a map exists regardless of the pinned
> > > > path
> > > > (just by ID).
> > > 
> > > Can you spell this out for me? I imagine you're talking about
> > > MAP_GET_FD_BY_ID, but that is CAP_SYS_ADMIN only, right? Not
> > > great
> > > maybe, but no gaping hole IMO.
> > 
> > +linux-security-module ML (they could be interested in this topic
> > as
> > well)
> > 
> > Good to know! I didn't realize it before.
> > 
> > I figured out better what you mean by escalating privileges.
> > 
> > Pin a read-only fd, get a read-write fd from the pinned path.
> > 
> > What you want to do is, if I pin a read-only fd, I should get read-
> > only 
> > fds too, right?
> > 
> > I think here there could be different views. From my perspective,
> > pinning is just creating a new link to an existing object.
> > Accessing
> > the link does not imply being able to access the object itself (the
> > same happens for files).
> > 
> > I understand what you want to achieve. If I have to choose a
> > solution,
> > that would be doing something similar to files, i.e. add owner and
> > mode
> > information to the bpf_map structure (m_uid, m_gid, m_mode). We
> > could
> > add the MAP_CHMOD and MAP_CHOWN operations to the bpf() system call
> > to
> > modify the new fields.
> > 
> > When you pin the map, the inode will get the owner and mode from
> > bpf_map. bpf_obj_get() will then do DAC-style verification similar
> > to
> > MAC-style verification (with security_bpf_map()).
> 
> As someone pointed out during the discussing at LPC, this will
> effectively allow a user to create files owned by someone else, which
> is
> probably not a good idea either from a security PoV. (I.e., user A
> pins
> map owned by user B, so A creates a file owned by B).

Uhm, I see what you mean. Right, it is not a good idea, the owner of
the file should the one that pinned the map.

Other than that, DAC verification on the map would be still correct, as
it would be independent from the DAC verification of the file.

Roberto


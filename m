Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF15E74FE
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIWHkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIWHkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 03:40:11 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594BE12747
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 00:40:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MYkTG5w8gz9xFn5
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:35:30 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHtV+_Yi1jPORsAA--.37058S2;
        Fri, 23 Sep 2022 08:39:51 +0100 (CET)
Message-ID: <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:39:41 +0200
In-Reply-To: <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
         <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
         <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
         <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHtV+_Yi1jPORsAA--.37058S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1rWryrAr1kXF4fZryUAwb_yoW5Xw4Dpa
        yFgFy0kr1ktFy8Aryv9a47t3Wjv34rJa43Gas8JryUZ34q9FyfKr1IyFWrZFy3ZFs2yrWa
        qw4SvFyrGFyqvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj39h0wAAs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-09-22 at 17:21 +0100, Lorenz Bauer wrote:
> On Thu, 22 Sep 2022, at 16:39, Roberto Sassu wrote:
> > Yes, true. Not sure if it makes sense to backport it to stable
> > versions
> > (probably not). Or alternatively, for older versions we could
> > ensure
> > that the fd is for read/write, even if as you said, there is a risk
> > of
> > breakage of existing applications. It seems unlikely that this
> > could
> > happen, as libbpf still does not support requesting a read-only fd,
> > although one could create an ad-hoc function to set the appropriate
> > parameters for the bpf() system call.
> 
> You can create a r-o fd via bpf_map_create if you pass
> map_flags=BPF_F_RDONLY unfortunately. Were you thinking of OBJ_GET
> when you refer to libbpf?

Oh, right.

To be more precise, bpf_map_get_fd_by_id() does not support yet getting
a read-only fd. bpf_obj_get_opts() was recently introduced for this
purpose.

> Actually, if it may help, I could send my version of the fix I
> > developed to validate the idea. I also wrote the tests.
> 
> Yes please, I have also have a WIP patch that seems to work, but I'm
> curious what you came up with. Tests would also be great, mine are
> kinda janky.

Ok.

> The ability to access the path of a pinned map does not give you
> > the
> > ability to access the map itself.
> 
> I think there is a subtlety here I don't get.
> BPF_OBJ_GET(/sys/fs/bpf/foo) gives me an fd I can modify via syscall,
> no? Are you making a distinction between the inode and the bpf_map
> itself?

If you have write access to /sys/fs/bpf/foo, it does not mean that you
will have write access to the map, when you call OBJ_GET(). I don't
know if you could add more modes after getting a fd.

> You still need to pass
> > security_bpf_map(). With SELinux, you would need a rule like:
> > 
> > allow <ctx of subject accessing the pinned map> <ctx of the map
> > creator>: bpf { map_read map_write };
> > 
> > The inode is not passed to security_bpf_map(), so likely it is not
> > taken into account for the security decision.
> 
> Ok, you're saying that a user can prevent the escalation via SELinux?

Not only with SELinux, but with an eBPF program too (BPF LSM). What I
wanted to do is to deny write access to anyone except the eBPF program
that declares the map.

> What you say, I think it applies to map iterators. The ability to
> > access the path of an iterator gives you the ability to make
> > changes to
> > the map without further checks.
> 
> How? An example would really help me, I don't know much about
> iterators besides that I can pin them and that open() triggers the
> program.

I wrote an example here:

https://lore.kernel.org/bpf/8d7a713e500b5e3fce93e4c5c7b8841eb6dd28e4.camel@huaweicloud.com/

It shows that you can actually write to a map, despite SELinux gives
you only read permission.

Roberto


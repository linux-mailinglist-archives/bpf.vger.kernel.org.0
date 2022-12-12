Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922F9649A19
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 09:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiLLIgJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 03:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiLLIfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 03:35:52 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED1E017;
        Mon, 12 Dec 2022 00:35:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NVvt35MqQz9xFmB;
        Mon, 12 Dec 2022 16:28:59 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnsQzO55ZjW_YHAA--.12110S2;
        Mon, 12 Dec 2022 09:35:33 +0100 (CET)
Message-ID: <9514eb143542d67036a508db2e6acee7b959dccb.camel@huaweicloud.com>
Subject: Re: [PATCH 2/2] doc: Fix fs_context_parse_param description in
 mount_api.rst
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 12 Dec 2022 09:35:20 +0100
In-Reply-To: <CAHC9VhSz6b9AcpKzAn2Lz_9SW0yNqiQ0Ub8fXytFy7sSBmXipQ@mail.gmail.com>
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
         <20221209082936.892416-2-roberto.sassu@huaweicloud.com>
         <CAHC9VhSz6b9AcpKzAn2Lz_9SW0yNqiQ0Ub8fXytFy7sSBmXipQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAnsQzO55ZjW_YHAA--.12110S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4DJFWDKr1xGFyfAFy5Arb_yoW8Xry5pa
        yFq3W5Ar1vqw4xur1vkay7W3yrCrZ3JF45X3WDX345Zr1aqr1rtFWIgr4Y9ryDurZ2vryF
        vFWagryY9FnxA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj4aENQABsG
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-12-09 at 12:41 -0500, Paul Moore wrote:
> On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Align with the description of fs_context_parse_param in lsm_hooks.h, which
> > seems the right one according to the code.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  Documentation/filesystems/mount_api.rst | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> I'm going to leave this patch as a "hold" for right now.  The existing
> text is arguably not great, but I'm not really in love with the
> replacement text taken from the LSM hook comments; given the merge
> window opens in a couple of days, we don't have much time to fiddle
> with the wording so let's just hold this for a little bit.
> 
> These comment corrections (which are very welcome!) have also reminded
> me that we really should move the hook comment blocks out of the
> header file and into security.c like every other kernel function.
> This should help increase their discoverability while also making it
> easier to maintain the comments over time.  I'm going to post a first
> pass at this as soon as the merge window closes, and once that is done
> we can do further work to cleanup the descriptions and add more detail
> (including notes both for the other kernel subsystems that call the
> hooks and the LSM devs who provide implementations).

Ok, great!

Roberto


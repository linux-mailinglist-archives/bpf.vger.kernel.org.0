Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5D62C109
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPOhp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiKPOhh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 09:37:37 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6942871C;
        Wed, 16 Nov 2022 06:37:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NC57M42dnz9xFg4;
        Wed, 16 Nov 2022 22:30:39 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCXgm+C9XRjFB1tAA--.18710S2;
        Wed, 16 Nov 2022 15:37:02 +0100 (CET)
Message-ID: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 4/4] security: Enforce limitations on return values
 from LSMs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 16 Nov 2022 15:36:46 +0100
In-Reply-To: <CAHC9VhQ+fUZfJwJ=oJ9ieszKeicnS7Z-QcJuJVL9HF5F0tcA7Q@mail.gmail.com>
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
         <20221115175652.3836811-5-roberto.sassu@huaweicloud.com>
         <CAHC9VhQ+fUZfJwJ=oJ9ieszKeicnS7Z-QcJuJVL9HF5F0tcA7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCXgm+C9XRjFB1tAA--.18710S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW8uFyUGw48XryUJw4rAFb_yoW5Gr4rpa
        y5JFy5GF4v9r47AwnIyw43Zw1Fy393Gr4UJr9Iy347Zw15trZxKr40k3WY9FyUCr4S9w1j
        yr4YqF93Ca4DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBF1jj4GDggAAsl
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-11-15 at 21:35 -0500, Paul Moore wrote:
> On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > LSMs should not be able to return arbitrary return values, as the callers
> > of the LSM infrastructure might not be ready to handle unexpected values
> > (e.g. positive values that are first converted to a pointer with ERR_PTR,
> > and then evaluated with IS_ERR()).
> > 
> > Modify call_int_hook() to call is_ret_value_allowed(), so that the return
> > value from each LSM for a given hook is checked. If for the interval the
> > return value falls into the corresponding flag is not set, change the
> > return value to the default value, just for the current LSM.
> > 
> > A misbehaving LSM would not have impact on the decision of other LSMs, as
> > the loop terminates whenever the return value is not zero.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/security.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> 
> Casey touched on some of this in his reply to patch 0/4, but basically
> I see this as a BPF LSM specific problem and not a generalized LSM
> issue that should be addressed at the LSM layer.  Especially if the
> solution involves incurring additional processing for every LSM hook
> instantiation, regardless if a BPF LSM is present.  Reading your
> overall patchset description I believe that you understand this too.

Yes, I had this concern too. Thanks Paul and Casey for taking the time
to reply.

I liked the fact that the fix is extremely simple, but nevertheless it
should not impact the performance, if there are alternative ways. I
thought maybe we look at non-zero values, since the check is already
there. But it could be that there is an impact for it too (maybe for
audit_rule_match?).

> If you want to somehow instrument the LSM hook definitions (what I
> believe to be the motivation behind patch 3/4) to indicate valid
> return values for use by the BPF verifier, I think we could entertain
> that, or at least discuss it further, but I'm not inclined to support
> any runtime overhead at the LSM layer for a specific LSM.

Ok, yes. Patches 1-3 would help to keep in sync the LSM infrastructure
and eBPF, but it is not strictly needed. I could propose an eBPF-only
alternative to declare sets of functions per interval.

More or less, I developed an eBPF-based alternative also for patch 4.
It is just a proof of concept. Will propose it, to validate the idea.

Thanks

Roberto


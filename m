Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6B646BF0
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 10:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLHJ3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 04:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLHJ3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 04:29:51 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3D1D306;
        Thu,  8 Dec 2022 01:29:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSTFp12fyz9xFPw;
        Thu,  8 Dec 2022 17:22:38 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXfflzrpFj0QvMAA--.21566S2;
        Thu, 08 Dec 2022 10:29:31 +0100 (CET)
Message-ID: <b989b278a16c48e104b32ba7243e4298491a6056.camel@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and
 fix formatting
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     David Howells <dhowells@redhat.com>, casey@schaufler-ca.com,
        omosnace@redhat.com, john.johansen@canonical.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 08 Dec 2022 10:29:20 +0100
In-Reply-To: <CAHC9VhQZ3VKWsNarUGPcHZuoRLgb8owKgbdLymwR759qVyQ+2Q@mail.gmail.com>
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
         <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
         <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
         <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com>
         <0682348d9601ca3847ce9ba035e4ab1b586cf712.camel@huaweicloud.com>
         <CAHC9VhQZ3VKWsNarUGPcHZuoRLgb8owKgbdLymwR759qVyQ+2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCXfflzrpFj0QvMAA--.21566S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW8Jr45tryxJFW7XF4fKrg_yoWkuwbEkr
        Z8Ar48Jw45Crn7Cw12ka1F9r92g3srZw1rZ3WDXr1UWa48GrW5JF40kr93Xrs3CrW8Jrnr
        WFyDAFZ2kasIvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj4ZsWgACsG
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-12-07 at 14:34 -0500, Paul Moore wrote:
> On Wed, Dec 7, 2022 at 4:18 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > For this patch, I saw it is already in lsm/next. Paul, should I do an
> > incremental patch or change the one in the repo and you force push it?
> > I would just remove the three lines after the parameters description.
> 
> Just send a patch against the current lsm/next branch to remove those
> lines, and please do it ASAP as the merge window opens this
> weekend/Monday.

Ok, was about to send but I would need a clarification first.

In mount_api.rst, there is for security_fs_context_parse_param():

     The value pointed to by param may be modified (if a string) or stolen
     (provided the value pointer is NULL'd out).  If it is stolen, 0 must be
     returned to prevent it being passed to the filesystem.

Looking at security.c:

	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
			     list) {
		trc = hp->hook.fs_context_parse_param(fc, param);
		if (trc == 0)
			rc = 0;
		else if (trc != -ENOPARAM)
			return trc;
	}

If, as mount_api.rst says, the value is modified by an LSM or stolen,
should it be passed to other LSMs too?

Thanks

Roberto


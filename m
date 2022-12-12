Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033BA649A0E
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 09:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiLLIeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 03:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLLIef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 03:34:35 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C162D8;
        Mon, 12 Dec 2022 00:34:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NVvrW5x6Vz9v7cW;
        Mon, 12 Dec 2022 16:27:39 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXXWR955ZjkAoIAA--.20728S2;
        Mon, 12 Dec 2022 09:34:13 +0100 (CET)
Message-ID: <8b202f4e2e234e6786b1c078129e2c3e6853c404.camel@huaweicloud.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 12 Dec 2022 09:33:58 +0100
In-Reply-To: <CAHC9VhSKeTqR+m5g2Nacp9ZJbvD3=OADGMEfDRX4rsH8HmGO9g@mail.gmail.com>
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
         <CAHC9VhSKeTqR+m5g2Nacp9ZJbvD3=OADGMEfDRX4rsH8HmGO9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXXWR955ZjkAoIAA--.20728S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1DXw17Cr4rtrW7XF45trb_yoW3ZrgE93
        9rtrsrC398Xr4xZFy0qF1Sqry093y3Jr15Zw1rC3yavF4kW3s7Ga10yF1Fvwn3Jan7Xr97
        Zr95AF92kFyIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4KFyAAAs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-12-09 at 12:28 -0500, Paul Moore wrote:
> On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > The fs_context_parse_param hook already has a description, which seems the
> > right one according to the code.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hooks.h | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> I just merged this into lsm/next with a 'Fixes' tag pointing at the
> previous comment block commit, thanks Roberto.

Thanks Paul. Didn't include it, as I thought it is part of the stable
kernel process. I guess it is always fine to include it, and to not CC
the stable kernel mailing list, when the patch does not meet the
criteria.

Roberto


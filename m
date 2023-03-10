Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF06B37EB
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 08:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCJH6K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 02:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCJH6J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 02:58:09 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D414216;
        Thu,  9 Mar 2023 23:58:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PXyqb4fT0z9v7H3;
        Fri, 10 Mar 2023 15:49:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnvGPz4gpkCr6FAQ--.63736S2;
        Fri, 10 Mar 2023 08:57:47 +0100 (CET)
Message-ID: <93b680a9a31357b21610dd988d3c653a9ace3492.camel@huaweicloud.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it
 for the integrity LSM
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 08:57:36 +0100
In-Reply-To: <CAHC9VhRBxPnQeQ4SPHKXP_k1epoaZRGNUzCa+QJR9se_t+4+-Q@mail.gmail.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
         <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
         <CAHC9VhRBxPnQeQ4SPHKXP_k1epoaZRGNUzCa+QJR9se_t+4+-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnvGPz4gpkCr6FAQ--.63736S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kJryrtr45uw1rtFW7CFg_yoW8XFWUpF
        W7KayrCr1qvFWrCa9xA3W3ua48C393GFnrGrsxZw1DZas5Zry0kr1IgrZ7WryDXF4vyFyS
        9Fy3WFyakw1DArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4ppUQACsI
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-09 at 18:44 -0500, Paul Moore wrote:
> On Thu, Mar 9, 2023 at 3:55 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
> > last, e.g. the 'integrity' LSM, without changing the kernel command line or
> > configuration.
> > 
> > Also, set this order for the 'integrity' LSM. While not enforced, this is
> > the only LSM expected to use it.
> > 
> > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> > and put at the end of the LSM list.
> 
> Since you are respinning this patchset anyway, I might make it clear
> that the LSM_ORDER_LAST LSMs are always enabled only when they are
> enabled at kernel configure/build time.  Simply marking a LSM as
> LSM_ORDER_LAST does not mean you don't have to explicitly select the
> LSM in the rest of the Kconfig.

Ok, yes, better to clarify.

Thanks

Roberto

> > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> > LSM is found, regardless of its order. In this way, the kernel would not
> > wrongly report that the LSM is not built-in in the kernel if its order is
> > LSM_ORDER_LAST.
> > 
> > Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/linux/lsm_hooks.h |  1 +
> >  security/integrity/iint.c |  1 +
> >  security/security.c       | 12 +++++++++---
> >  3 files changed, 11 insertions(+), 3 deletions(-)


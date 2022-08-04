Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30425895B6
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 03:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiHDBoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 21:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiHDBoV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 21:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0475D0DD
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 18:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B7D61764
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 01:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DE5C433D6;
        Thu,  4 Aug 2022 01:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659577459;
        bh=5PYEIm5njlUAAry2OabjRW1bWaAlXNebD94LSMfq5Lo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j9fU8oJYRA1jaYdzTJRM/uODC7xQa0k1wJCo2xFJXEh7+itVp6ef9A+rXIepk7bjW
         D97z3mhf7H2VVezZMEHUhgQfmZT0nDhhakE4G4hS3Xxd32BT1RiYVRt53xX9TKMecr
         2/lun2U+twXh0u0qOdTTUOiLGELUKc3au9Hpa1tsPHhnPOKuWmgLABMrIBQnrMCizw
         zgjHMnMctjNMHxN9xgwE9N1HHBhge8yDakSRrxsAPT87XwYAiw75XWU1OKBI9L/8a+
         AjWAR8KXhMfHZlm09bYlQXJbR8ZA6H6EWvQI3bfaaCIV+RGQISBV8U5bjbZ+LidNS8
         ONcADtbAzbcag==
Date:   Wed, 3 Aug 2022 18:44:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220803184418.38f9ed42@kernel.org>
In-Reply-To: <20220804012756.2eqvkofecpthzcoi@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
        <20220726184706.954822-2-joannelkoong@gmail.com>
        <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
        <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
        <20220803162540.19d31294@kernel.org>
        <20220804012756.2eqvkofecpthzcoi@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 3 Aug 2022 18:27:56 -0700 Martin KaFai Lau wrote:
> On Wed, Aug 03, 2022 at 04:25:40PM -0700, Jakub Kicinski wrote:
> > The point of skb_header_pointer() is to expose the chunk of the packet
> > pointed to by [skb, offset, len] as a linear buffer. Potentially coping
> > it out to a stack buffer *IIF* the header is not contiguous inside the
> > skb head, which should very rarely happen.
> > 
> > Here it seems we return an error so that user must pull if the data is
> > not linear, which is defeating the purpose. The user of
> > skb_header_pointer() wants to avoid the copy while _reliably_ getting 
> > a contiguous pointer. Plus pulling in the header may be far more
> > expensive than a small copy to the stack.
> > 
> > The pointer returned by skb_header_pointer is writable, but it's not
> > guaranteed that the writes go to the packet, they may go to the
> > on-stack buffer, so the caller must do some sort of:
> > 
> > 	if (data_ptr == stack_buf)
> > 		skb_store_bits(...);
> > 
> > Which we were thinking of wrapping in some sort of flush operation.  
> Curious on the idea.  don't know whether this is a dynptr helper or
> should be a specific pkt helper though.

Yeah, I could well pattern matched the dynptr because it sounded
similar but it's a completely different beast.

> The idea is to have the prog keeps writing to a ptr (skb->data or stack_buf).

To be clear writing is a lot more rare than reading in this case.

> When the prog is done, call a bpf helper to flush.  The helper
> decides if it needs to flush from stack_buf to skb and
> will take care of the cloned skb ?

Yeah, I'd think for skb it'd just pull. Normally dealing with skbs
you'd indeed probably just pull upfront if you knew you're gonna write.
Hence saving yourself from the unnecessary trip thru the stack. But XDP
does not have strong pulling support, so if the interface must support
both then it's the lower common denominator.

> > If I'm reading this right dynptr as implemented here do not provide
> > such semantics, am I confused in thinking that this is a continuation
> > of the XDP multi-buff discussion? Is it a completely separate thing
> > and we'll still need a header_pointer like helper?  
> Can you share a pointer to the XDP multi-buff discussion?

https://lore.kernel.org/all/20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/

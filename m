Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD15895A8
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiHDBel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 21:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiHDBek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 21:34:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF455B7AB
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 18:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75F14B82444
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 01:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD203C433D6;
        Thu,  4 Aug 2022 01:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659576877;
        bh=fjDGRRSHgLbvYh51rstbY/HkKjl5wR4HbxvmPugGjWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMbPJHRd+G7XjqskXFge0Bs3tw13KDGpg28usRsKZBbLY2V2Bw0xSeJHER7xRaSVo
         sjZCQ2mBXQVMq1LqeQrSuwDrMNQ9LRsxIV7vj9EvgKmH1+l+lUf0TPnC8s13B81YMd
         T3Z3ZiYrVHBI63Ki4G0DvLtRbAgEDfkDboi6Ni2LJBancj+gro7dJPynDrR1uZDBim
         UY51IuLpzFArWO6UUCl2ZNG309ZklWbiPrRiSWCjYY8Pvro7rZJaPKbG9Wkk6cGfGc
         V6ECjvjaywscrIu0NtfNL2pqdMPlpVYnxgHm46RVJRQF8sN5/Q/zQecUFbSRpSsPru
         Xq6lgMYUkIQPA==
Date:   Wed, 3 Aug 2022 18:34:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220803183435.4d33dc2e@kernel.org>
In-Reply-To: <CAJnrk1YWvKqujw1py+HzV8QP1g=cCQmOJ0KtGkNXjdJ4PY3Zkg@mail.gmail.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
        <20220726184706.954822-2-joannelkoong@gmail.com>
        <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
        <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
        <20220803162540.19d31294@kernel.org>
        <CAJnrk1YWvKqujw1py+HzV8QP1g=cCQmOJ0KtGkNXjdJ4PY3Zkg@mail.gmail.com>
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

On Wed, 3 Aug 2022 18:05:44 -0700 Joanne Koong wrote:
> I think the problem is that the skb may be cloned, so a write into any
> portion of the paged data requires a pull. If it weren't for this,
> then we could do the write and checksumming without pulling (eg kmap
> the page, get the csum_partial of the bytes you'll write over, do the
> write, get the csum_partial of the bytes you just wrote, then unkmap,
> then update skb->csum to be skb->csum - csum of the bytes you wrote
> over + csum of the bytes you wrote). I think we would even be able to
> provide a direct data slice to non-contiguous pages without needing
> the additional copy to a stack buffer (eg kmap the non-contiguous
> pages to a contiguous virtual address that we pass back to the bpf
> program, and then when the bpf program is finished do the cleanup for
> the mappings).

The whole read/write/data concept is not a great match for packet
parsing. Primary use for packet parsing is that you want to read
a header and not have to deal with frags or pulling. In that case
you should get a direct pointer or a copy on the stack, transparently.

Maybe before I go on talking nonsense I should read up on what dynptr
is and what it's trying to achieve. Stan says its like unique_ptr in
C++ which tells me.. nothing :)

$ git grep dynptr -- Documentation/
$

Any pointers?

> Three ideas I'm thinking through as a possible solution:
> 1) Enforce that the skb is always uncloned for skb-type bpf progs (we
> currently do this just for the skb head, see bpf_unclone_prologue()),
> but I'm not sure if the trade-off (pulling all the packet data, even
> if it won't be used) is acceptable.
> 
> 2) Don't support cloned skbs for bpf_dynptr_write/data and don't do
> any pulling. If the prog wants to use bpf_dynptr_write/data, then they
> have to pull it first

I think all output skbs from TCP are cloned, so that's not gonna work.

> 2) (uglier than #1 and #2) For bpf_dynptr_write()s, pull if the write
> is to a paged area and the skb is cloned, otherwise write to the paged
> area without pulling; if we do this, then we always have to invalidate
> all data slices associated with the skb (even for writes to the head)
> since at prog load time, the verifier doesn't know if the pull happens
> or not. For bpf_dynptr_data()s, follow the same policy.
> 
> I'm leaning towards 2. What are your thoughts?

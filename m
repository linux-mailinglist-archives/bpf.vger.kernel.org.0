Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88005894C2
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 01:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiHCXZr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 19:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCXZp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 19:25:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3932DAB
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 16:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20620B82403
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 23:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F93C433C1;
        Wed,  3 Aug 2022 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659569141;
        bh=qs0Ie//moJ9Q5mN9w6Q+N0skuJfInjPBfYOt9FYlnB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+QMLac27BHHqS8lHm2lMvuehpFDc50toW+Z+3v3kTjQDl+xCjiR0TX7j4PzkYgCA
         ZXaGlw67Ox2GMk0qK/jaYd4k9oX6rmObvTRsDFYzWmBDQof3BE8UJpbG5K1DIOS9X3
         cYxyhLwMRjPUHckC/T/VQ+CH9sDYkPpk8AOY2L5ogYKoC0bew//EJp89iK47u35x0e
         RrnIoCq15f9z6LOG4C/vzWF/rz+HDSEgBzVXq8vtmiwmRr6nbPijx3Npr38QgxU6me
         sWpryhNa5Kw6nwqc0aFKDTWTnuBRwdXZuinYfCON3ur9JHRhfEMSZ7OahAvOmTMpjN
         6WZMvumzwWd7w==
Date:   Wed, 3 Aug 2022 16:25:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220803162540.19d31294@kernel.org>
In-Reply-To: <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
        <20220726184706.954822-2-joannelkoong@gmail.com>
        <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
        <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
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

On Wed, 3 Aug 2022 13:29:37 -0700 Joanne Koong wrote:
> Thinking about this some more, I think BPF_FUNC_dynptr_from_skb needs
> to be patched regardless in order to set the rd-only flag in the
> metadata for the dynptr. There will be other helper functions that
> write into dynptrs (eg memcpy with dynptrs, strncpy with dynptrs,
> probe read user with dynptrs, ...) so I think it's more scalable if we
> reject these writes at runtime through the rd-only flag in the
> metadata, than for the verifier to custom-case that any helper funcs
> that write into dynptrs will need to get dynptr type + do
> may_access_direct_pkt_data() if it's type skb or xdp. The
> inconsistency between not rd-only in metadata vs. rd-only in verifier
> might be a little confusing as well.
> 
> For these reasons, I'm leaning more towards having bpf_dynptr_write()
> and other dynptr write helper funcs be rejected at runtime instead of
> prog load time, but I'm eager to hear what you prefer.
> 
> What are your thoughts?

Oh. I thought dynptrs are an extension of the discussion we had about
creating a skb_header_pointer()-like abstraction but it sounds like 
we veered quite far off that track at some point :(

The point of skb_header_pointer() is to expose the chunk of the packet
pointed to by [skb, offset, len] as a linear buffer. Potentially coping
it out to a stack buffer *IIF* the header is not contiguous inside the
skb head, which should very rarely happen.

Here it seems we return an error so that user must pull if the data is
not linear, which is defeating the purpose. The user of
skb_header_pointer() wants to avoid the copy while _reliably_ getting 
a contiguous pointer. Plus pulling in the header may be far more
expensive than a small copy to the stack.

The pointer returned by skb_header_pointer is writable, but it's not
guaranteed that the writes go to the packet, they may go to the
on-stack buffer, so the caller must do some sort of:

	if (data_ptr == stack_buf)
		skb_store_bits(...);

Which we were thinking of wrapping in some sort of flush operation.

If I'm reading this right dynptr as implemented here do not provide
such semantics, am I confused in thinking that this is a continuation
of the XDP multi-buff discussion? Is it a completely separate thing
and we'll still need a header_pointer like helper?

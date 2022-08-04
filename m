Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48C589593
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 03:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbiHDBGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 21:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDBF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 21:05:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C357913CED
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 18:05:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j8so9043843ejx.9
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwT877vrDy5/zVB4Rq5sutLgOp/P9ieSgGViWyyn6M0=;
        b=QSG0z3e40By368z6ri8K4THgUvuPHlIniv27hivGPtANUXiX5Z1Rnsh/HKZu/zVHJQ
         FV4QOeOgtW/JFmM6UwotBApeFT68QnSyujFK8LzuS6t1GRR2MHcWetZUmlWRlzZryOx7
         2L3BhvvPvzsbHIUewL2DVyO54OYzNucvstexy10MhZXeehgzqP1x3kkzW3+2orFZJ/FH
         880L0eQLA77ofCsbbFx6kXJVSI8dCHYqyVmGGtM8/ZagT9xcF43LU2CBP4Ueys8bWP1e
         HQ3LVzH2k69DnoBVh1mXsC/4ukZu5xio5ZCAkdDZ57nAeYNZ5punHq+kucs5cDC6t+BR
         Z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwT877vrDy5/zVB4Rq5sutLgOp/P9ieSgGViWyyn6M0=;
        b=q1rob3rYIgMtYcjsbsNCD6UfeW1l01uFFF6akXf+fmRiW+JEQ0r4W2NWhivGhLfohY
         XzhPPu3jJAWucV8NYhsUf4EpfD1sE6GAWRnGS6WjN+jsTQfnUoig6RozyLYs0PMiYu1U
         6M3iClv6Y2X9AoZxE2hilsrLeKG9Ure1flvKpTswz58YOZZB+B4Tnf39twhefhEzJcDD
         F3SB1J0BI+30cwGi6QX3T+adZcLKaVlFlFtV0huO+QfC9EG/X3KKDvrW7Ncfq4oB/I+W
         WRemmEzTRz/n41MlVk2Shuw3JovkoaH22b8/TOeHll2d1d/pYZeeg6xmtMEPxpJNASkP
         jJKw==
X-Gm-Message-State: AJIora+98UWHRktYYlttKUGE/2edUlpJvnzvL/rB0BZ5c7/ZDhRe8TO/
        DdCF5d9/n6ROt/YjQXloY2gKWBZoAtc+JlgGbdZs/8x0SOE=
X-Google-Smtp-Source: AGRyM1usOeXvODPfZuOp3Wew3LkLfyp5twU5kxDZzw16Tjw7+SQlm5Egbgpqc6ygodX5e0Pxkv0b6lOCvziCZvdlj40=
X-Received: by 2002:a17:907:608f:b0:72b:7db9:4dc6 with SMTP id
 ht15-20020a170907608f00b0072b7db94dc6mr21156899ejc.463.1659575156353; Wed, 03
 Aug 2022 18:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com> <20220803162540.19d31294@kernel.org>
In-Reply-To: <20220803162540.19d31294@kernel.org>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 3 Aug 2022 18:05:44 -0700
Message-ID: <CAJnrk1YWvKqujw1py+HzV8QP1g=cCQmOJ0KtGkNXjdJ4PY3Zkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 3, 2022 at 4:25 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 3 Aug 2022 13:29:37 -0700 Joanne Koong wrote:
> > Thinking about this some more, I think BPF_FUNC_dynptr_from_skb needs
> > to be patched regardless in order to set the rd-only flag in the
> > metadata for the dynptr. There will be other helper functions that
> > write into dynptrs (eg memcpy with dynptrs, strncpy with dynptrs,
> > probe read user with dynptrs, ...) so I think it's more scalable if we
> > reject these writes at runtime through the rd-only flag in the
> > metadata, than for the verifier to custom-case that any helper funcs
> > that write into dynptrs will need to get dynptr type + do
> > may_access_direct_pkt_data() if it's type skb or xdp. The
> > inconsistency between not rd-only in metadata vs. rd-only in verifier
> > might be a little confusing as well.
> >
> > For these reasons, I'm leaning more towards having bpf_dynptr_write()
> > and other dynptr write helper funcs be rejected at runtime instead of
> > prog load time, but I'm eager to hear what you prefer.
> >
> > What are your thoughts?
>
> Oh. I thought dynptrs are an extension of the discussion we had about
> creating a skb_header_pointer()-like abstraction but it sounds like
> we veered quite far off that track at some point :(

I think the problem is that the skb may be cloned, so a write into any
portion of the paged data requires a pull. If it weren't for this,
then we could do the write and checksumming without pulling (eg kmap
the page, get the csum_partial of the bytes you'll write over, do the
write, get the csum_partial of the bytes you just wrote, then unkmap,
then update skb->csum to be skb->csum - csum of the bytes you wrote
over + csum of the bytes you wrote). I think we would even be able to
provide a direct data slice to non-contiguous pages without needing
the additional copy to a stack buffer (eg kmap the non-contiguous
pages to a contiguous virtual address that we pass back to the bpf
program, and then when the bpf program is finished do the cleanup for
the mappings).

Three ideas I'm thinking through as a possible solution:
1) Enforce that the skb is always uncloned for skb-type bpf progs (we
currently do this just for the skb head, see bpf_unclone_prologue()),
but I'm not sure if the trade-off (pulling all the packet data, even
if it won't be used) is acceptable.

2) Don't support cloned skbs for bpf_dynptr_write/data and don't do
any pulling. If the prog wants to use bpf_dynptr_write/data, then they
have to pull it first

2) (uglier than #1 and #2) For bpf_dynptr_write()s, pull if the write
is to a paged area and the skb is cloned, otherwise write to the paged
area without pulling; if we do this, then we always have to invalidate
all data slices associated with the skb (even for writes to the head)
since at prog load time, the verifier doesn't know if the pull happens
or not. For bpf_dynptr_data()s, follow the same policy.

I'm leaning towards 2. What are your thoughts?

>
> The point of skb_header_pointer() is to expose the chunk of the packet
> pointed to by [skb, offset, len] as a linear buffer. Potentially coping
> it out to a stack buffer *IIF* the header is not contiguous inside the
> skb head, which should very rarely happen.
>
> Here it seems we return an error so that user must pull if the data is
> not linear, which is defeating the purpose. The user of
> skb_header_pointer() wants to avoid the copy while _reliably_ getting
> a contiguous pointer. Plus pulling in the header may be far more
> expensive than a small copy to the stack.
>
> The pointer returned by skb_header_pointer is writable, but it's not
> guaranteed that the writes go to the packet, they may go to the
> on-stack buffer, so the caller must do some sort of:
>
>         if (data_ptr == stack_buf)
>                 skb_store_bits(...);
>
> Which we were thinking of wrapping in some sort of flush operation.
>
> If I'm reading this right dynptr as implemented here do not provide
> such semantics, am I confused in thinking that this is a continuation
> of the XDP multi-buff discussion? Is it a completely separate thing
> and we'll still need a header_pointer like helper?

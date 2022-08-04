Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA345896AF
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 05:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiHDDoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 23:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiHDDoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 23:44:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE323E767
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 20:44:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c24so3905052ejd.11
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 20:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn429SA+aeM9vWSZZTPKdXxtIKVeEfm8DW4amEqYQXY=;
        b=BXAZf/RnQsq2/ot+fcNGHbNrUSeSLOQvoBvgm509H3tE1kAahY+A+hlKMurbO89jkR
         lU/eS7Ra7S9TCmUH+JJ5m9W5gxOHqnLeuu2d82M05K5+crPWXDKrG4n5YfzL3m/faDH6
         JB0HNUAd/LaM0qCjLiOKEsWh5lCOg/OYKDm9GgjgkE0peOUyddIp5ZTLDAvKs98UZyi2
         iFg5A5jeRdACTSGP7bIlge5IW/6z8dJXfZw4yEnQao+0g8ziBQji8KLnnQS/Vqcfdglv
         2ywDfPBGqhmqU0DitHg4FZVofmoN8wz7HXgCRqjILnjlM2LZc6q3JASlj9lVtyBRGQko
         +7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn429SA+aeM9vWSZZTPKdXxtIKVeEfm8DW4amEqYQXY=;
        b=6nybc70hnVp8jSEZCNDjXG4QT0HP8EZNGQky29/LfMxAiWdQGrDd9oIVlp0b7rZyix
         DIAJ4Y/6eUJa3QqxtYXlJS4eafzvippHHSXU11Q3wK5v8W5BPhJOefXybettJ2v/1jcR
         kdtosHzxilV9vGDiX6JucaiSFtATBlq7aNUs6+4q0L5jTwzfhzZLeNJElW2hd5k5BVsn
         PkoRvCRXKsIKb324MQT0mp62o065J4+FcxfI8nf0LVDegUo1+6S5klQzZaqAzX00JmaI
         9Ycgwc1W3cIf+zFH9gDqjI8FKc7CX5gbo18Puj4N0WZJxewAEiMQugELqbw/Szffgu1a
         gg9g==
X-Gm-Message-State: AJIora8cGF9cjgKVrcASZRFeEubii8eRETknD+mPRbD3D99RHHrVIMMv
        QIkvcQDxRZLOmzhhS0ZXmEdL6XkfDJNgl82GrSiMbiktrdg=
X-Google-Smtp-Source: AGRyM1vy+uKMpAuMikkNrn9ZL6r1u1a7dSDlDjFRPi3uEFdLxfKYP+FDzSgg7lGaZZ42pBgrSe0JrvW/GRPHKSYvRh8=
X-Received: by 2002:a17:906:6c82:b0:709:f868:97f6 with SMTP id
 s2-20020a1709066c8200b00709f86897f6mr21669506ejr.555.1659584691283; Wed, 03
 Aug 2022 20:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
 <20220803162540.19d31294@kernel.org> <CAJnrk1YWvKqujw1py+HzV8QP1g=cCQmOJ0KtGkNXjdJ4PY3Zkg@mail.gmail.com>
 <20220803183435.4d33dc2e@kernel.org>
In-Reply-To: <20220803183435.4d33dc2e@kernel.org>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 3 Aug 2022 20:44:39 -0700
Message-ID: <CAJnrk1bROt-tPOYUPB=aOJ=e35aCMdRERffCDEh8sKN6gK3Cug@mail.gmail.com>
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

On Wed, Aug 3, 2022 at 6:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 3 Aug 2022 18:05:44 -0700 Joanne Koong wrote:
> > I think the problem is that the skb may be cloned, so a write into any
> > portion of the paged data requires a pull. If it weren't for this,
> > then we could do the write and checksumming without pulling (eg kmap
> > the page, get the csum_partial of the bytes you'll write over, do the
> > write, get the csum_partial of the bytes you just wrote, then unkmap,
> > then update skb->csum to be skb->csum - csum of the bytes you wrote
> > over + csum of the bytes you wrote). I think we would even be able to
> > provide a direct data slice to non-contiguous pages without needing
> > the additional copy to a stack buffer (eg kmap the non-contiguous
> > pages to a contiguous virtual address that we pass back to the bpf
> > program, and then when the bpf program is finished do the cleanup for
> > the mappings).
>
> The whole read/write/data concept is not a great match for packet
> parsing. Primary use for packet parsing is that you want to read
> a header and not have to deal with frags or pulling. In that case
> you should get a direct pointer or a copy on the stack, transparently.

The selftests [0] includes some examples of packet parsing using
dynptrs. You're able to get a pointer to the headers (if it's in the
head) directly, or you can use bpf_dynptr_read() to read the data from
the frag into a buffer (without needing to pull; bpf_dynptr_read()
essentially just calls bpf_skb_load_bytes()).

Does this address the use cases you have in mind?

I think the pull and unclone stuff only pertains to the cases for
writes into the frags.

[0] https://lore.kernel.org/bpf/20220726184706.954822-4-joannelkoong@gmail.com/

>
> Maybe before I go on talking nonsense I should read up on what dynptr
> is and what it's trying to achieve. Stan says its like unique_ptr in
> C++ which tells me.. nothing :)
>
> $ git grep dynptr -- Documentation/
> $
>
> Any pointers?

Ooh thanks for the reminder, adding a page for the dynptr
documentation is on my to-do list

A dynptr (also known as fat pointers in other languages) is a pointer
that stores extra metadata alongside the address it points to. In
particular, the metadata the bpf dynptr stores includes the length of
data it points to (so in the case of skb/xdp, the size of the packet),
the type of dynptr, and properties like whether it's read-only.
Dynptrs are an interface for bpf programs to dynamically access
memory, because the helper calls enforce that the accesses are safe.
For example, bpf_dynptr_read() allows reads at offsets and lengths not
statically known at compile time (in bpf_dynptr_read, the kernel uses
the metadata to check that the offset and length doesn't violate
memory bounds); without dynptrs, the verifier can't guarantee that the
offset or length of the read is safe since those values aren't
statically known at compile time, so for example you can't directly
read a dynamic number of bytes from a packet.

With regards to skb + xdp, the main use case of dynptrs are to 1)
allow dynamic-size accesses of packet data and 2) allow easier and
simpler packet parsing (for example, accessing skb->data directly
requires multiple if checks for ensuring it's within bounds of
skb->data_end in order to satisfy the verifier; with the dynptr
interface, you are able to get a direct data slice and access it
without needing the checks. The selftests 3rd patch has some
demonstrations of this).

>
> > Three ideas I'm thinking through as a possible solution:
> > 1) Enforce that the skb is always uncloned for skb-type bpf progs (we
> > currently do this just for the skb head, see bpf_unclone_prologue()),
> > but I'm not sure if the trade-off (pulling all the packet data, even
> > if it won't be used) is acceptable.
> >
> > 2) Don't support cloned skbs for bpf_dynptr_write/data and don't do
> > any pulling. If the prog wants to use bpf_dynptr_write/data, then they
> > have to pull it first
>
> I think all output skbs from TCP are cloned, so that's not gonna work.
>
> > 2) (uglier than #1 and #2) For bpf_dynptr_write()s, pull if the write
> > is to a paged area and the skb is cloned, otherwise write to the paged
> > area without pulling; if we do this, then we always have to invalidate
> > all data slices associated with the skb (even for writes to the head)
> > since at prog load time, the verifier doesn't know if the pull happens
> > or not. For bpf_dynptr_data()s, follow the same policy.
> >
> > I'm leaning towards 2. What are your thoughts?

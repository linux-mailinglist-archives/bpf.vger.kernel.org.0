Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B358A3BA
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 01:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiHDXAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbiHDW74 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 18:59:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DCE13E
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 15:58:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id x64so826808iof.1
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BflD3NK59wSaWBQ3niqRdcMqEaUbZlPy2dijUqlwa58=;
        b=LTAKWLZMCbgncOkjPto8zLTUg3XmUH6I0QdgU9NVB1089ATy7C4tWQByjwRBc9SagY
         VpWoJY98Gtlz8//jsmt9eb3ykFUkf7x4hRSkx829CaH8LtvBsw/z9gyF5wwm7rsjW3vn
         3FGg1JKJ9k4ZJhzN6vePCZqbqHQdRXd/nMd/zvwAmAOWAE5t04W8jru3O41ptKlT8w1T
         p5U32BSjVRUD3L0n85bKjY88vKVXuTeA+nxROcLXYz9oQERZ1HtjzBC7QTV7ftovQy5u
         I8bQfY3PMC6r6FoyUKyqd4iGc9EeafNs+ZOZpNwdjSuxuqckUaM0u89i5hK8m81F6HG6
         MqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BflD3NK59wSaWBQ3niqRdcMqEaUbZlPy2dijUqlwa58=;
        b=SiUdBoZYcFLAnWOuo8qUpbr4sa4Ov4t7u/7PVXMkDaFw0C8D5rJCiy0A7GRJxQM6Ol
         7OG+04aQmt9897obHlas7le+LTaxUQzcvQnPy0PCdxnRDNW0acS7340827LTuXAqZpA3
         bearqa/DHb4YI1KnWN7dJ+U7MIWfiV3/E1Pv5Ap97Z1EqpfbuS1oOzQpPHCKlkex+hey
         4GBclbRU/7Iw5IxF38C8nnla1WX7ebRNcTDbuaOJYCDtIRnGA2ByDgvnopcDcsB6eePq
         Ir0FrHHGroAjVqtfoVA29hZI7RxR5kMd8tclIbZGGFSNuQYIqWqutjtNSKgRBIyahWGG
         Yu4Q==
X-Gm-Message-State: ACgBeo1V2WNCnpVhF4ObFEmsKhH3SaHflHViVoHXnXpHZPOlgyZmz/1w
        XYtMrtfeDXRbyKVE4djtwX3PvTkBrBhLGC2tizY=
X-Google-Smtp-Source: AA6agR5PvZ9gTggEPzcsuCnBoCW0zZo37iMG8AvQUuARR5cgKWc8Vv72iRuptsnHhVzvhPmrPBcu+mLZ6FqXuK+hD1k=
X-Received: by 2002:a5d:9da8:0:b0:67c:557:2ab1 with SMTP id
 ay40-20020a5d9da8000000b0067c05572ab1mr1574570iob.18.1659653917122; Thu, 04
 Aug 2022 15:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com> <20220803162540.19d31294@kernel.org>
In-Reply-To: <20220803162540.19d31294@kernel.org>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 5 Aug 2022 00:58:01 +0200
Message-ID: <CAP01T764J7YR5CLfg0wxRFD+O9EQGUU=BkKk0tVme9HX3pomrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
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

On Thu, 4 Aug 2022 at 01:28, Jakub Kicinski <kuba@kernel.org> wrote:
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

When I worked on [0], I actually did it a bit like you described in
the original discussion under the xdp multi-buff thread, but I left
the other case (where data to be read resides across frag boundaries)
up to the user to handle, instead of automatically passing in pointer
to stack and doing the copy for them, so in my case
xdp_load_bytes/xdp_store_bytes is the fallback if you can't get a
bpf_packet_pointer for a ctx, offset, len which you can directly
access. But this was only for XDP, not for skb.

The advantage with a dynptr is that len for the slice from
bpf_packet_pointer style helper doesn't have to be a constant, it can
be a runtime value and since it is checked at runtime anyway, the
helper's code is the same but access can be done for slices whose
length is unknown to the verifier in a safe manner. The dynptr is very
useful as the return value of such a helper.

The suggested usage was like this:

    int err = 0;
    char buf[N];

    off &= 0xffff;
    ptr = bpf_packet_pointer(ctx, off, sizeof(buf), &err);
    if (unlikely(!ptr)) {
        if (err < 0)
            return XDP_ABORTED;
        err = bpf_xdp_load_bytes(ctx, off, buf, sizeof(buf));
        if (err < 0)
            return XDP_ABORTED;
        ptr = buf;
    }
    ...
    // Do some stores and loads in [ptr, ptr + N) region
    ...
    if (unlikely(ptr == buf)) {
        err = bpf_xdp_store_bytes(ctx, off, buf, sizeof(buf));
        if (err < 0)
            return XDP_ABORTED;
    }

So the idea was the same, there is still a "flush" (in that unlikely
branch), but it is done explicitly by the user (which I found less
confusing than it being done automagically or a by a new flush helper
which will do the same thing we do here, but YMMV).

[0]: https://lore.kernel.org/bpf/20220306234311.452206-1-memxor@gmail.com

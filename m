Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA08663732
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 03:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjAJCUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 21:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjAJCUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 21:20:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210012DB
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 18:20:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u19so24937230ejm.8
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TozxdXHYqTTtN+hzTEsjKWs7+H3ZQmp4afd2Ad41qpU=;
        b=gC+OMrUVf9D5TjPqmUDj0jWFxV3K/UxnNaVUgt17/iOZfAaWgdb9zlEW1kfHS+zo/P
         IyEeRTKWQXc2ld1Iu4BiFD4DcElVsXR6qpg8qsjyMOaSZNrTRmqH7eMzNiRyoOjhjv8z
         0z+PtNGoorz7lvlt1UXPtVfZFix/ZSHGCmYVBKoGs9thXdY0z2XghYn5QH+DplLEsVId
         AzKWv3qf9lj5M/oJwy7k2gBCJTb2rdoA2b/NvGsa96GcPlCkkthZTTNQqwF+rkTDqh5t
         xIjt4vLpL5LSSsb/MX3gZ2I/fq9Y+b2426JaBjbSqMAtkmbCrSpQVjCv8IdBdzYeAW2X
         9Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TozxdXHYqTTtN+hzTEsjKWs7+H3ZQmp4afd2Ad41qpU=;
        b=gyqReNYthB9bEqhKeYBSFjMKEynkuz4/jbd+m7Z26POHUAhNLKnhQJW8dZEXTfYJlA
         +mIkEiFzg+OiJAysyr27ABv08MhOmx9FcigjBr+vIDumjxECPoojnfUmfIvPelzG8tuJ
         JwAyLJJJE5WnEGzzO7TcVU2KA8xQMOli8/2sDFYnBpMR0N8+x6ypGk9aDBZMt6fznjNu
         ufvkGBrloyAFQQ+HvQgGdpvSH+JZBn5S2XgVg5vcGsxxAT+TrTbmSEotBxP3X3i6aJHY
         UzyfQb/nvk/W49oQQgxcBVFuQZ9XNsiq81o0ESFEyTZhcHDL9oBX1HgTbGhW5Q/Ck7MN
         W1Jw==
X-Gm-Message-State: AFqh2ko8/f25/D1dNME8oAm3AIln+hSd1LHCq2nUh2rRjHASU/dxYdXw
        22BL6wb4/m5Nxn/frfJvz4fnHkkapiSoYKipBmY=
X-Google-Smtp-Source: AMrXdXshb5W38BN89gkuM/tpJluTIX1/dQVSTiWlOgbXKKFJw+ZPTLbW8qD5lvWF8j0Oye1YROagKKGQdlei0f+kyVQ=
X-Received: by 2002:a17:907:11d9:b0:84d:1392:cd47 with SMTP id
 va25-20020a17090711d900b0084d1392cd47mr2151005ejb.502.1673317208494; Mon, 09
 Jan 2023 18:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-4-memxor@gmail.com>
 <20230105030607.hnaxgzejx4uwpby5@macbook-pro-6.dhcp.thefacebook.com> <20230109115240.kb3opxak5qi4bxd6@apollo>
In-Reply-To: <20230109115240.kb3opxak5qi4bxd6@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 9 Jan 2023 18:19:57 -0800
Message-ID: <CAADnVQLYC1G3mSJyvL8MC=eV4ciGtmfZ--ap7BGchdO0Rtu7uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Fix partial dynptr stack slot reads/writes
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Mon, Jan 9, 2023 at 3:52 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, Jan 05, 2023 at 08:36:07AM IST, Alexei Starovoitov wrote:
> > On Sun, Jan 01, 2023 at 02:03:57PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > Currently, while reads are disallowed for dynptr stack slots, writes are
> > > not. Reads don't work from both direct access and helpers, while writes
> > > do work in both cases, but have the effect of overwriting the slot_type.
> >
> > Unrelated to this patch set, but disallowing reads from dynptr slots
> > seems like unnecessary restriction.
> > We allow reads from spilled slots and conceptually dynptr slots should
> > fall in is_spilled_reg() category in check_stack_read_*().
> >
> > We already can do:
> > d = bpf_rdonly_cast(dynptr, bpf_core_type_id_kernel(struct bpf_dynptr_kern))
> > d->size;
>
> Not sure this cast is required, it can just be reads from the stack and clang
> will generate CO-RE relocatable accesses when casted to the right struct with
> preserve_access_index attribute set? Or did I miss something?

rdonly_cast is required today, because the verifier rejects raw reads.

> >
> > With verifier allowing reads into dynptr we can also enable bpf_cast_to_kern_ctx()
> > to convert struct bpf_dynptr to struct bpf_dynptr_kern and enable
> > even faster reads.
>
> I think rdonly_cast is unnecessary, just enabling reads into stack will be
> enough to enable this.

Right. I was thinking that bpf_cast_to_kern_ctx will make things
more robust, but plain vanilla cast to struct bpf_dynptr_kern *
and using CO-RE will work when the verifier enables reads.

> relocatable enum values which check for set bits etc.). But in the end how do
> you define such an interface, will it be UAPI like xdp_md or __sk_buff, or
> unstable like kfunc, or just best-effort stable as long as user is making use of
> CO-RE relocs?

We can start best-effort with CORE.
All our fixed uapi things like __sk_buff and xdp_md have ongoing
usability issues. People always need something new and we keep
adding to those structs every now and then.
struct __sk_buff is quite scary. Its vlan_* fields was a bit of a pain
to adjust when corresponding vlan changes were made in the sk_buff
and networking core.
Eventually we still had to do:
        /* Simulate the following kernel macro:
         *   #define skb_shinfo(SKB) ((struct skb_shared_info
*)(skb_end_pointer(SKB)))
         */
        shared_info = bpf_rdonly_cast(kskb->head + kskb->end,
                bpf_core_type_id_kernel(struct skb_shared_info));
I'm arguing that everything we expose to bpf progs should
be unstable in the beginning.

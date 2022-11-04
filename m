Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3421619234
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKDHvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDHvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:51:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB83286F1
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:51:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k7so4173290pll.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U80+5OAy1kF0PBXmnLSMpMOXGHy+GOn4OCIGPbSzTDw=;
        b=kPbMkZoFQ3OsklfzWCXbhL3VJ3ttVabJNrMAuGDM7PYWw/UzrNRt4NxV8yLvlCdLLq
         4voLgT2KVf9H/vxzMUACExtWr824P4neHXzIrUO1ZLDY3K9iwDl34kzTtWrS2JWpcUft
         0Ir7BlDQ8SpnvZG9svTiqa4SbzCTazn55RcP98Dh06YtP3yG869+mghFU2vIAxWwfVBi
         r3mwntY112ka70V4y83AqCpiAazuYxKbSBaiVAsML1mFlNOtFhwdm11UU0/CC5mp9PiQ
         wxdSl5yqkSK1QLWNfq/mefwYEH/W4lA/SlZ9vXG2SpQUlZFWrcQj7EByCUEmhh/LdpWd
         TYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U80+5OAy1kF0PBXmnLSMpMOXGHy+GOn4OCIGPbSzTDw=;
        b=M0EhIL4tKLwYQojwqR1q9GNkxTH6dtAh9WTN+U1xxg8z8Wy9FAE3lFZHNGDIrG7s9m
         MRT3m0opnUf+i6HBj1kZkrCrTHq7A377IgcWFLPe1XoHpfR4hR+Am8rcH24NwDsBe4Pt
         LsaAjHyY1y3jutepTGp8xYNejysDWZyWvQSDDYf3EugALr3O8EXWxhM+tBX/8xpMcGW/
         JXfZuCWIlHvR/yOBkcLHLfasxaOnEcXcou95WiAy37PnxfWA7wdFK44yk90OR52FnFXN
         gcZUv5EQsi0maC3vEPtKujyzpByiez01IjJiUNts5y7VP6BzUzoUzo17XMr1rARJrruw
         UZWg==
X-Gm-Message-State: ACrzQf3LtPjjJdvVLKPUIC9T+CyPG0y5riybxg7ILT1fzajvTD8XQqsk
        K2wUiR7UuXQvqjZ2EJ/Jau8=
X-Google-Smtp-Source: AMsMyM4IAxHIBia/1YrLX+1gg0X4XRYlea9RXUlzKRyKeKa30MegTtC4+sSbnnxJx0wYfVqiRos0gw==
X-Received: by 2002:a17:902:6b47:b0:187:12ca:94c5 with SMTP id g7-20020a1709026b4700b0018712ca94c5mr29548769plt.141.1667548297293;
        Fri, 04 Nov 2022 00:51:37 -0700 (PDT)
Received: from localhost ([157.51.134.255])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902e1d400b00176a6ba5969sm1931447pla.98.2022.11.04.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:51:36 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:21:13 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 10/24] bpf: Introduce local kptrs
Message-ID: <20221104075113.5ighwdvero4mugu7@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-11-memxor@gmail.com>
 <CAADnVQKF7zs39ZRpU-9dAKaXZwRLRE8rFZ6m152AbWKC_6=LdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKF7zs39ZRpU-9dAKaXZwRLRE8rFZ6m152AbWKC_6=LdQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 11:27:04AM IST, Alexei Starovoitov wrote:
> On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> > program BTF. This is indicated by the presence of MEM_TYPE_LOCAL type
> > tag in reg->type to avoid having to check btf_is_kernel when trying to
> > match argument types in helpers.
> ...
> >
> > +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> > +        * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
> > +        */
> > +       MEM_TYPE_LOCAL          = BIT(11 + BPF_BASE_TYPE_BITS),
> > +
>
> I know we have bpf_core_type_id_local.
> It sort-of makes sense in the context of the program.
> type_id_local -> inside the program
> type_id_kernel -> kernel
>
> but in the context of the verifier "local kptr" doesn't read right.
> Especially in MEM_TYPE_LOCAL.

Yes, "local kptr" is not the best name. "kptr to local type" is too verbose
though, do you have any suggestions on what to call this?

>
> Also, since it applies to PTR_TO_BTF_ID, should it prefix with PTR_?
> Probably MEM_ is actually cleaner.
> And we're not consistent already with MEM_PERCPU.
> We can live with this inconsistency for now.
>
> So how about we rename MEM_ALLOC to MEM_RINGBUF,
> since it's special bpf_ringbuf_reserve() memory
> and use MEM_ALLOC to indicate the memory that came from bpf_obj_new ?
>

Yes, it makes sense. I think Andrii has expressed the same wish to rename it to
something similar to MEM_RINGBUF before in [0].

[0]: https://lore.kernel.org/bpf/CAEf4BzYK939fgyc3LwNvoz3vPk2avyskP_3wRZO344irubXPtg@mail.gmail.com

> ... which made me realize that the comment above should
> s/bpf_kptr_alloc/bpf_obj_new/

I'll fix the comment.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA71A619BD8
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiKDPiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiKDPiP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:38:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437DC2DAA7
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:38:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a13so8237225edj.0
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofpn3zhTV0VluzoNSgObGQdM9MGnJuBgUaxeEF5wH3M=;
        b=QLkA2rN/VSpijo4iz9D6H3zm4U3MmhMOBfu1cQNVtbg58g2ofn/5/im+EwW5s0ZYl8
         iSROu4zEVS1oIBRFT+2Qqwgb9Q3HnpA8skhIWeIR2LKTX8ESovwZE9EhYs65+2CH/KM3
         wzpGVX5ansFQZGCV3viAuywM64hSnrxkPy0sI8rpGj/JMMREtwM00NKvkbxo29izL8Ho
         v+3BVUR0AIZvmujdDnTqtucL/PXxq1ZNZnKW/Zf19EjqzVC1pxrGjnZYzixFcmBBLeJs
         ttwt927lBKeFQMHjxy9pXxPlfKoXd3P7V+2mDyTraW8R5sVWxie/chUFdGXmbR2Jz/Rz
         TqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ofpn3zhTV0VluzoNSgObGQdM9MGnJuBgUaxeEF5wH3M=;
        b=K+0HpV+jYePur6wTBfisbxpRKtIk1OvI+qRtsrh6tFGj3A7CbyZsw9mUqTaU1M2Fe+
         XmjaAXgfZ9gbHooMqShi6EAf6NfmrVpDf640AoyfFEtmXml0BdjuCP3Tgxdk+dPwKZoC
         jLpA8hvu4NJv/boHaLbCobmLG41rpHPqbYKSyF/4murph20sHaepTAUJ8f/A2dCij/ZD
         CD/jnzujvYmNrMSl1o2baDILfo5lsAlV4jQadjakQssk3YF6hRGJDaYayCy+WK4t6RzP
         xtuiT54dfD4P3ShsD7WBl/lyQUGZMT85QPH9mrwVSgztbuyfbW5H4Xi2+XYWtQje46CT
         Idpw==
X-Gm-Message-State: ACrzQf2xb9xtrQV6Sewmsxij2up4drV0bXBnQk9v3ljSLom9acg5heC4
        vzLM2ArULONGwHPgNQIrUhOov89oVynbAvY8nR4=
X-Google-Smtp-Source: AMsMyM6fbSaLXyyOLfYKc5+FZqoCLJOYlW7qAZVAFYu7n33p8Zni8gnIVagzi1TXeBbKieuDxebWOgcLzFXjFeZSQkA=
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id
 g13-20020a056402428d00b00460b26c82a5mr37369175edc.66.1667576292633; Fri, 04
 Nov 2022 08:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-11-memxor@gmail.com>
 <CAADnVQKF7zs39ZRpU-9dAKaXZwRLRE8rFZ6m152AbWKC_6=LdQ@mail.gmail.com> <20221104075113.5ighwdvero4mugu7@apollo>
In-Reply-To: <20221104075113.5ighwdvero4mugu7@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Nov 2022 08:38:01 -0700
Message-ID: <CAADnVQK4xNidJt+D1HFohT3tLLYKc1MmvdmA0qN=_SXdsiPO6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/24] bpf: Introduce local kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Fri, Nov 4, 2022 at 12:51 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, Nov 04, 2022 at 11:27:04AM IST, Alexei Starovoitov wrote:
> > On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> > > program BTF. This is indicated by the presence of MEM_TYPE_LOCAL type
> > > tag in reg->type to avoid having to check btf_is_kernel when trying to
> > > match argument types in helpers.
> > ...
> > >
> > > +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> > > +        * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
> > > +        */
> > > +       MEM_TYPE_LOCAL          = BIT(11 + BPF_BASE_TYPE_BITS),
> > > +
> >
> > I know we have bpf_core_type_id_local.
> > It sort-of makes sense in the context of the program.
> > type_id_local -> inside the program
> > type_id_kernel -> kernel
> >
> > but in the context of the verifier "local kptr" doesn't read right.
> > Especially in MEM_TYPE_LOCAL.
>
> Yes, "local kptr" is not the best name. "kptr to local type" is too verbose
> though, do you have any suggestions on what to call this?
>
> >
> > Also, since it applies to PTR_TO_BTF_ID, should it prefix with PTR_?
> > Probably MEM_ is actually cleaner.
> > And we're not consistent already with MEM_PERCPU.
> > We can live with this inconsistency for now.
> >
> > So how about we rename MEM_ALLOC to MEM_RINGBUF,
> > since it's special bpf_ringbuf_reserve() memory
> > and use MEM_ALLOC to indicate the memory that came from bpf_obj_new ?
> >
>
> Yes, it makes sense. I think Andrii has expressed the same wish to rename it to
> something similar to MEM_RINGBUF before in [0].
>
> [0]: https://lore.kernel.org/bpf/CAEf4BzYK939fgyc3LwNvoz3vPk2avyskP_3wRZO344irubXPtg@mail.gmail.com

Great. Please rename then.
Also let's all of us agree and stop using this [0] notation
for links.
It's an email and not an academic paper.
Just insert the link.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B998622071
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 00:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKHXtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKHXtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 18:49:06 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A85C766
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 15:49:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b29so15147398pfp.13
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhHwF0n4Ht36NzmOe5XxPUlsYfyGhwH/7bw64rLjGWo=;
        b=F6PDVCUY4HdpbcH9OdPwo/PghYNsJMhgnyZSL1kL/YRkkeZsAfDHfi3avcSBzws7QL
         7a7mDXaH1+ILU0fNWm6XTv1ExmzyvfjpgDN1lBwRH7NiWnS0JAjr6f8/YK+RJYC9D0hc
         oYrFJqotBf7iKV9d/0CGFu3Dc645rEJF2EIqXtL1fapa21N438mvJNRO45TniF95QS8Q
         NHc7DY0a9NzIE8vYOE6O/V5HBEtin5niDEI3XAchi9rabEl6nc/T26YqO+avnRKWagzZ
         yEISNGYygYnRxGiw4efvZAGQvFTij/eNK3IDO+ddu/ZvIdE+asn3KWOFfMtJaAbpWpA+
         5q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhHwF0n4Ht36NzmOe5XxPUlsYfyGhwH/7bw64rLjGWo=;
        b=BzDI7Q5bwShCotrf225f/TEYM4DjxEmcSGxh60cg0OsTHKC/dGPd8iSGAEEv0epHXx
         7Ngc5sOeyhx3K/oH4XHIW6tYIHY1vPAtdpsqPvOZL8Pxo/QwBz+AVmmlN8CAUoapPvHR
         vNThGjUeCEd2Rt5MFrC381R6t/jOSzOW8fnLOzLbsO4qaDvySEsg2qJWWIWhUsc1C0cw
         xoldPmLfmRla7jQYoTQhBRnRA4NQ7STb2U4Sd865VFEKfNWEEvxvzLHdOYAO8FoqPCzR
         u+djGS5rcm8O3XqAVIai6mgPTavrjVnEVotuHqzpKJ1j3qXvLrpzth8eyuDde4+WCGDA
         cpkw==
X-Gm-Message-State: ACrzQf1OcIejC0lwXDpFkpL9sDvdS0/JDfn1J1aoWtAJDmwPqbjMmiR7
        r11gHqXLTB7Pv036eIQY96k=
X-Google-Smtp-Source: AMsMyM5Tni2Loliz8iTCG7SDh8jDLVkL1rRDOPeXnB65a2xybNKGQyR77+XXc6+cLBCsI0R/ybHItQ==
X-Received: by 2002:a63:5063:0:b0:46e:cd36:ce0c with SMTP id q35-20020a635063000000b0046ecd36ce0cmr50915739pgl.617.1667951344577;
        Tue, 08 Nov 2022 15:49:04 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709027c8f00b0017854cee6ebsm7498782pll.72.2022.11.08.15.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 15:49:04 -0800 (PST)
Date:   Wed, 9 Nov 2022 05:19:01 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 05/25] bpf: Rename MEM_ALLOC to MEM_RINGBUF
Message-ID: <20221108234901.erzrj2b6bsvqkzir@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-6-memxor@gmail.com>
 <CAEf4BzZ180YJ+fbynJSR2fXXMVuKZTyginHyRdxydvOm-po7TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ180YJ+fbynJSR2fXXMVuKZTyginHyRdxydvOm-po7TA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 04:44:16AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Currently, verifier uses MEM_ALLOC type tag to specially tag memory
> > returned from bpf_ringbuf_reserve helper. However, this is currently
> > only used for this purpose and there is an implicit assumption that it
> > only refers to ringbuf memory (e.g. the check for ARG_PTR_TO_ALLOC_MEM
> > in check_func_arg_reg_off).
> >
> > Hence, rename MEM_ALLOC to MEM_RINGBUF to indicate this special
> > relationship and instead open the use of MEM_ALLOC for more generic
> > allocations made for user types.
> >
> > Also, since ARG_PTR_TO_ALLOC_MEM_OR_NULL is unused, simply drop it.
> >
> > Finally, update selftests using 'alloc_' verifier string to 'ringbuf_'.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Ok, so you are doing what I asked in the previous patch, nice :)
>
> >  include/linux/bpf.h                               | 11 ++++-------
> >  kernel/bpf/ringbuf.c                              |  6 +++---
> >  kernel/bpf/verifier.c                             | 14 +++++++-------
> >  tools/testing/selftests/bpf/prog_tests/dynptr.c   |  2 +-
> >  tools/testing/selftests/bpf/verifier/ringbuf.c    |  2 +-
> >  tools/testing/selftests/bpf/verifier/spill_fill.c |  2 +-
> >  6 files changed, 17 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 2fe3ec620d54..afc1c51b59ff 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -488,10 +488,8 @@ enum bpf_type_flag {
> >          */
> >         MEM_RDONLY              = BIT(1 + BPF_BASE_TYPE_BITS),
> >
> > -       /* MEM was "allocated" from a different helper, and cannot be mixed
> > -        * with regular non-MEM_ALLOC'ed MEM types.
> > -        */
> > -       MEM_ALLOC               = BIT(2 + BPF_BASE_TYPE_BITS),
> > +       /* MEM points to BPF ring buffer reservation. */
> > +       MEM_RINGBUF             = BIT(2 + BPF_BASE_TYPE_BITS),
>
> What do we gain by having ringbuf memory as additional modified flag
> instead of its own type like PTR_TO_MAP_VALUE or PTR_TO_PACKET? It
> feels like here separate register type is more justified and is less
> error prone overall.
>

I'm not sure it's all that different. It only matters when checking argument
during release. We want to ensure it came from ringbuf_reserve. That's all,
apart from that it's no different from PTR_TO_MEM. In all other places it's
folded and code for PTR_TO_MEM is used. Same idea as PTR_TO_BTF_ID | MEM_ALLOC.

But I don't feel too strongly, so if you still think it's better I can make the
switch.

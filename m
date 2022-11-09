Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB42A622095
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiKIADY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIADX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:03:23 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12D298
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:03:21 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gw22so15237810pjb.3
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq5dAc5B8XSATp/SmbSXOwHfWQW5rSga5ijfeioCwZs=;
        b=UsCfPs71GWIz7AXTGPAwP4ySO8sjEcRlhYFi7WzX7rCVeGqv/9ZPHLW1afFk1HpMa9
         99UbOlBgvTB0KaveW3+L/7Wp+MwGNWPflj4ZNVfQsF6g0lGQtalCa9k/tEmFqSkTzzZD
         levsI6YOzHrm2arxFNR3BCfIQSkbOx96mjXELnhqWx1N51RfHVrKm4nCr8cqkHTvkojH
         WQcSjnAP4mHQ7MV8AJ4RnLlPxRe7v0wGhZEYKDq2Sem9vxR88EdUPCn3ewlc13Q8A+3T
         yUhAfaHTsKkBWcVwTk5P7/fMiRQHFVwcov61nTvnOrD3Z3aLbZnApOLDTCBQS//r7Qsz
         hgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq5dAc5B8XSATp/SmbSXOwHfWQW5rSga5ijfeioCwZs=;
        b=2wD54HVKcqlqFHgvvdi3LGdrzxRiTIPlnXG2ECLsMMnEUkjlSCnJT58zihakuWkmYs
         BdmWTTMBrwDviosXUGer+ILaPrYH8wkegoh5YPHBYAIAEFFmUUZXxV+m1wxH7QFZkWtZ
         pj41idNdLwutwqtAUo704i4mG8EgFanxkjXnUiYms3GfTcGSVsKvuGyF68saWLIM3oHi
         YcGKtOP20IRb5olY2otb8Xwa1cEFRNUwityAIbBiYwWHoGbkEPW+/j4p5JrR4Tahlphu
         R+YYJ48MeGPAiGfOX2Dt20gZGATrWXeWn0ahfpabNvHTkANSRKbs5W343HiUISrSxT2t
         LSjQ==
X-Gm-Message-State: ACrzQf2Ic3nYYIRWjyvksZaW7nyh/d0u0PdwM4p4AzrEXjcxJRj9yIjF
        NrF2GrfuR/p/HeyORsI8sgQ=
X-Google-Smtp-Source: AMsMyM5F5BHHyQqj1o2KKPWC4m3WYASKIrsUSL29tyVNnp8d2tCrnV37gFW6iiAIMCu7qWNUa28r6Q==
X-Received: by 2002:a17:90b:38cd:b0:214:184f:4007 with SMTP id nn13-20020a17090b38cd00b00214184f4007mr41771076pjb.82.1667952201150;
        Tue, 08 Nov 2022 16:03:21 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u7-20020a63ef07000000b004393c5a8006sm6323127pgh.75.2022.11.08.16.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:03:20 -0800 (PST)
Date:   Wed, 9 Nov 2022 05:33:18 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 10/25] bpf: Allow locking bpf_spin_lock
 global variables
Message-ID: <20221109000318.r2k2oanflb7ikrlg@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-11-memxor@gmail.com>
 <CAEf4BzaSLudM-uii61Xe3CVYhG+RXB_BiYDDZtAe5Or5ipoo9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaSLudM-uii61Xe3CVYhG+RXB_BiYDDZtAe5Or5ipoo9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 05:07:44AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Global variables reside in maps accessible using direct_value_addr
> > callbacks, so giving each load instruction's rewrite a unique reg->id
> > disallows us from holding locks which are global.
> >
> > The reason for preserving reg->id as a unique value for registers that
> > may point to spin lock is that two separate lookups are treated as two
> > separate memory regions, and any possible aliasing is ignored for the
> > purposes of spin lock correctness.
> >
> > This is not great especially for the global variable case, which are
> > served from maps that have max_entries == 1, i.e. they always lead to
> > map values pointing into the same map value.
> >
> > So refactor the active_spin_lock into a 'active_lock' structure which
> > represents the lock identity, and instead of the reg->id, remember two
> > fields, a pointer and the reg->id. The pointer will store reg->map_ptr
> > or reg->btf. It's only necessary to distinguish for the id == 0 case of
> > global variables, but always setting the pointer to a non-NULL value and
> > using the pointer to check whether the lock is held simplifies code in
> > the verifier.
> >
> > This is generic enough to allow it for global variables, map lookups,
> > and local kptr registers at the same time.
> >
> > Note that while whether a lock is held can be answered by just comparing
> > active_lock.ptr to NULL, to determine whether the register is pointing
> > to the same held lock requires comparing _both_ ptr and id.
> >
> > Finally, as a result of this refactoring, pseudo load instructions are
> > not given a unique reg->id, as they are doing lookup for the same map
> > value (max_entries is never greater than 1).
> >
> > Essentially, we consider that the tuple of (ptr, id) will always be
> > unique for any kind of argument to bpf_spin_{lock,unlock}.
> >
> > Note that this can be extended in the future to also remember offset
> > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > in the same allocation.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  5 ++++-
> >  kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
> >  2 files changed, 32 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 1a32baa78ce2..70cccac62a15 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -323,7 +323,10 @@ struct bpf_verifier_state {
> >         u32 branches;
> >         u32 insn_idx;
> >         u32 curframe;
> > -       u32 active_spin_lock;
> > +       struct {
> > +               void *ptr;
>
> document that this could be either struct bpf_map or struct btf
> pointer, at least?
>
Ack, I'll add a comment.

Though it's not really meant to be used (i.e. turned back into a pointer to
them), it's just an 'identity' pointer.

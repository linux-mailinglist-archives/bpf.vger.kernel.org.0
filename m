Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAE69B0AA
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBQQUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 11:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjBQQUb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:31 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05706F7C3
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 08:20:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j20so7749206edw.0
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wde8rQeabjQhS3a6hI/IBPOGf+7wZhJIQTmA8wDN95M=;
        b=U9yZht2U/J60mV8VPxBLlaGSX5PRVe70PRVK5j61Ew3reGrcvRJ1Mtw3luSq9guMzu
         vpLzjMWO1ygqPGvK3DmZa4KD3KEBlr2B/gysESCqHXv0pvc0KyuE3Ve0jTYJZ+BkG3Ii
         7VszcXhaIWIfAN86QjDeKVeU/alzsDAYlka9ok1YRXXvptFJjlbL+Dnd5LV+b4Y977xs
         YwEhCUAtRGZCNg3j1U2ctMbENoDh4+eqyES26zZIa3WMYHcERCs/efx/rGa39egu8rpE
         xLIxJg0aMbE7MSZAR4vT+Ytc/2Q5PNLVlcun7MPFI9RDS/9QkkkVPXU1cZmfzZAxc+PP
         QiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wde8rQeabjQhS3a6hI/IBPOGf+7wZhJIQTmA8wDN95M=;
        b=fVwEqLkEg001SL1JYFZtrWHdSf0SyRDJEQnkoNjfb/QE8s62Ya8fKisOiZGmvpOVwG
         A3H9ea7puk+PF1w7LWTKdebB9ZcimtgeGD0VNkrd7K+RefXYQWkFRJ96vJXv5C3E2ZVx
         kcMK6yqmDl+O9oN1F8zZrqdLtcaKu+WyUxa4ru/WbykFL/mdCXt+Zmj4o/4f0PRYdvUG
         LIIzwwWvlUhBpXGrCtvCpIE9vsANyYcFo/mzJtRWjydnpOZCsRP5/GmiraEg2gVrX+Bw
         eNPic5YqAU4WsCGaeZR9ljs6AZRfZhOfH61m9Bbu9qqi2OXMDxU8m+CLIvST5KPKptnn
         +mFw==
X-Gm-Message-State: AO0yUKWp6DNdM/s98eB1wuChXsBBWH0r95XxUSnqWp5mEj/GIy9ayCYe
        zL6z0EzHyouv1fVc7ao7G3Ap2x7Gu1SzCbb/sVc=
X-Google-Smtp-Source: AK7set+Ar/dS5GqG4YbasYPqvHm9JhLemSFB89jmEHH3lL8Fq9QbpZ6OR4J7MEWuqlGXOuqC8lFe9igik4hyE10ZxPk=
X-Received: by 2002:a17:906:d8d8:b0:8b1:2898:2138 with SMTP id
 re24-20020a170906d8d800b008b128982138mr626795ejb.3.1676650798179; Fri, 17 Feb
 2023 08:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20230215235931.380197-1-iii@linux.ibm.com> <20230215235931.380197-2-iii@linux.ibm.com>
 <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
 <Y+5nCRZ3ns3u+Tun@google.com> <CAADnVQJH6PRgGRMMZufDu6AZkQFF_40boz4oLHdYMWFNAj+zOA@mail.gmail.com>
 <Y+5wCbT30EGsswMg@google.com> <5a71852169384c3c60a763c6964d6798664dfa72.camel@linux.ibm.com>
In-Reply-To: <5a71852169384c3c60a763c6964d6798664dfa72.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 17 Feb 2023 08:19:46 -0800
Message-ID: <CAADnVQ+jNOAHZZmKtBFFKr2_CTWx25Z9U7KeV6QuSUnJewRoGA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
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

On Fri, Feb 17, 2023 at 2:57 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2023-02-16 at 10:03 -0800, Stanislav Fomichev wrote:
> > On 02/16, Alexei Starovoitov wrote:
> > > On Thu, Feb 16, 2023 at 9:25 AM Stanislav Fomichev <sdf@google.com>
> > > wrote:
> > > >
> > > > On 02/16, Alexei Starovoitov wrote:
> > > > > On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich
> > > > > <iii@linux.ibm.com>
> > > > > wrote:
> > > > > >
> > > > > > Make the code more readable by introducing a symbolic
> > > > > > constant
> > > > > > instead of using 0.
> > > > > >
> > > > > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > > ---
> > > > > >  include/uapi/linux/bpf.h       |  4 ++++
> > > > > >  kernel/bpf/disasm.c            |  2 +-
> > > > > >  kernel/bpf/verifier.c          | 12 +++++++-----
> > > > > >  tools/include/linux/filter.h   |  2 +-
> > > > > >  tools/include/uapi/linux/bpf.h |  4 ++++
> > > > > >  5 files changed, 17 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/bpf.h
> > > > > > b/include/uapi/linux/bpf.h
> > > > > > index 1503f61336b6..37f7588d5b2f 100644
> > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > @@ -1211,6 +1211,10 @@ enum bpf_link_type {
> > > > > >   */
> > > > > >  #define BPF_PSEUDO_FUNC                4
> > > > > >
> > > > > > +/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm
> > > > > > ==
> > > index
> > > > > of a bpf
> > > > > > + * helper function (see ___BPF_FUNC_MAPPER below for a full
> > > > > > list)
> > > > > > + */
> > > > > > +#define BPF_HELPER_CALL                0
> > > >
> > > > > I don't like this "cleanup".
> > > > > The code reads fine as-is.
> > > >
> > > > Even in the context of patch 4? There would be the following
> > > > switch
> > > > without BPF_HELPER_CALL:
> > > >
> > > > switch (insn->src_reg) {
> > > > case 0:
> > > >         ...
> > > >         break;
> > > >
> > > > case BPF_PSEUDO_CALL:
> > > >         ...
> > > >         break;
> > > >
> > > > case BPF_PSEUDO_KFUNC_CALL:
> > > >         ...
> > > >         break;
> > > > }
> > > >
> > > > That 'case 0' feels like it deserves a name. But up to you, I'm
> > > > fine
> > > > either way.
> >
> > > It's philosophical.
> > > Some people insist on if (ptr == NULL). I insist on if (!ptr).
> > > That's why canonical bpf progs are written as:
> > > val = bpf_map_lookup();
> > > if (!val) ...
> > > zero is zero. It doesn't need #define.
> >
> > Are you sure we still want to apply the same logic here for src_reg?
> > I
> > agree that doing src_reg vs !src_reg made sense when we had a
> > "helper"
> > vs "non-helper" (bpf2bpf) situation. However now this src_reg feels
> > more
> > like an enum. And since we have an enum value for 1 and 2, it feels
> > natural to have another one for 0?
> >
> > That second patch from the series ([0]) might be a good example on
> > why
> > we actually need it. I'm assuming at some point we've had:
> > #define BPF_PSEUDO_CALL 1
> >
> > So we ended up writing `src_reg != BPF_PSEUDO_CALL` instead of
> > actually
> > doing `src_reg == BPF_HELPER_CALL` (aka `src_reg == 0`).
> > Afterwards, we've added BPF_PSEUDO_KFUNC_CALL=2 which broke our
> > previous
> > src_reg vs !src_reg assumptions...
> >
> > [0]:
> > https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/T/#mf87a26ef48a909b62ce950639acfdf5b296b487b
>
> FWIW the helper checks before this series had inconsistent style:
>
> - !insn->src_reg
> - insn->src_reg == 0
> - insn->src_reg != BPF_REG_0
> - insn[i].src_reg != BPF_PSEUDO_CALL
>
> Now at least it's the same style everywhere, and also it's easy to
> grep for "where do we check for helper calls".

The above checks are not equivalent.
Comparing src_reg with BPF_REG_0 makes sense in one context
and doesn't in the other.
It's never ok to add stuff to uapi when it works as-is.
I also don't buy theoretical arguments about future additions
and how something will be cleaner in the future because
we predicted it so well today.

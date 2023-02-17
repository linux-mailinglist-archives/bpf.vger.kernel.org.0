Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C870169B198
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBQRIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 12:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQRIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 12:08:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38B6ABC6
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 09:08:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id f4so2159247plg.12
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/bVTILW5QM0ok04A5Eg+q5eXSoqCTvQp1AnmQsHPzN0=;
        b=WxrpKR4jwYMupW1SJNXVH6RcTjptq25g6lQpCYcmepOCle/ooHCqyRANMrpKLBCLtG
         VaM5gUieR/CurOHLVZyYCzpmhrTexxaYcX57wpojVoC8kN6nda9pivzEidUS/kZ2dC8L
         cUQyS246a5C/pKTAztf0nBx067NAdr8lwuW+l8q0186ox/UvJu8u7STs5FYI5fd5W4uj
         hm47XjRBTwKWRjtf2nW6pk6aIAfaJOpAXBi0esn1yVeBj2QnJwTWf9u0b7DkEPBwP/zN
         jX0Nr7JLCHo/+s7Pxa97s1XLBv9KdekxdYjtQQ3NVPkLCkyj2r2LZC2emsEAT79+VdQ7
         cRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bVTILW5QM0ok04A5Eg+q5eXSoqCTvQp1AnmQsHPzN0=;
        b=ckRXcKUqmm+ZNcsxO6qL5vusI+7xPMy/Sp99yiP+L3f+R7cZeWrj4sG4vOnV0iL3Iu
         XKCvXqk3DFWDBwqc8jmhvsJ35zXNls46tPoA9jkazGswtPYSYVJqzd97DXZpj3GQgHPN
         ex1TOmwfuZOhL8YsrdZGT44gbV3MTz/4ozqsZ0iRzA9TkLLeac/L66E8PchEHxzI1t8G
         hSf8e0dIgP3NHop+49W5Ba2Bn8dBpe61kuQKANZeWvDZv5DiKS/XVHvejqaqWvg1qZyh
         PCO3mJ3oK7dc6edM7GN3yTuD/87CkGCKD5bXP3SSDHwzDWbAE8tDum5V4Q+P2yOVZK8C
         MBCA==
X-Gm-Message-State: AO0yUKUg4ouGWVRCKsk5sTBABqqAm8BsRcjFDAQ9aPj2HAq96W1/Xc31
        pCCjx1EO9pvweRN8PuEY74mwLF5ADnsh0xdGc6Z5dw==
X-Google-Smtp-Source: AK7set+u/q+VYQVvEdJoAeSK8B+RAj4ZYxZqx2Uu9KDN4t3pix1Oay3WUlkZvo769Kefs+EYW5ygefHisCkOf0IJCJ8=
X-Received: by 2002:a17:90b:1bca:b0:233:e796:7583 with SMTP id
 oa10-20020a17090b1bca00b00233e7967583mr1780330pjb.1.1676653716370; Fri, 17
 Feb 2023 09:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20230215235931.380197-1-iii@linux.ibm.com> <20230215235931.380197-2-iii@linux.ibm.com>
 <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
 <Y+5nCRZ3ns3u+Tun@google.com> <CAADnVQJH6PRgGRMMZufDu6AZkQFF_40boz4oLHdYMWFNAj+zOA@mail.gmail.com>
 <Y+5wCbT30EGsswMg@google.com> <5a71852169384c3c60a763c6964d6798664dfa72.camel@linux.ibm.com>
 <CAADnVQ+jNOAHZZmKtBFFKr2_CTWx25Z9U7KeV6QuSUnJewRoGA@mail.gmail.com>
In-Reply-To: <CAADnVQ+jNOAHZZmKtBFFKr2_CTWx25Z9U7KeV6QuSUnJewRoGA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 17 Feb 2023 09:08:24 -0800
Message-ID: <CAKH8qBvtG+ovt46HV5hNhJpSR4X8DFrbGTKDP5godm2+dG4W2g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 8:19 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 2:57 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Thu, 2023-02-16 at 10:03 -0800, Stanislav Fomichev wrote:
> > > On 02/16, Alexei Starovoitov wrote:
> > > > On Thu, Feb 16, 2023 at 9:25 AM Stanislav Fomichev <sdf@google.com>
> > > > wrote:
> > > > >
> > > > > On 02/16, Alexei Starovoitov wrote:
> > > > > > On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich
> > > > > > <iii@linux.ibm.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > Make the code more readable by introducing a symbolic
> > > > > > > constant
> > > > > > > instead of using 0.
> > > > > > >
> > > > > > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > > > ---
> > > > > > >  include/uapi/linux/bpf.h       |  4 ++++
> > > > > > >  kernel/bpf/disasm.c            |  2 +-
> > > > > > >  kernel/bpf/verifier.c          | 12 +++++++-----
> > > > > > >  tools/include/linux/filter.h   |  2 +-
> > > > > > >  tools/include/uapi/linux/bpf.h |  4 ++++
> > > > > > >  5 files changed, 17 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/bpf.h
> > > > > > > b/include/uapi/linux/bpf.h
> > > > > > > index 1503f61336b6..37f7588d5b2f 100644
> > > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > > @@ -1211,6 +1211,10 @@ enum bpf_link_type {
> > > > > > >   */
> > > > > > >  #define BPF_PSEUDO_FUNC                4
> > > > > > >
> > > > > > > +/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm
> > > > > > > ==
> > > > index
> > > > > > of a bpf
> > > > > > > + * helper function (see ___BPF_FUNC_MAPPER below for a full
> > > > > > > list)
> > > > > > > + */
> > > > > > > +#define BPF_HELPER_CALL                0
> > > > >
> > > > > > I don't like this "cleanup".
> > > > > > The code reads fine as-is.
> > > > >
> > > > > Even in the context of patch 4? There would be the following
> > > > > switch
> > > > > without BPF_HELPER_CALL:
> > > > >
> > > > > switch (insn->src_reg) {
> > > > > case 0:
> > > > >         ...
> > > > >         break;
> > > > >
> > > > > case BPF_PSEUDO_CALL:
> > > > >         ...
> > > > >         break;
> > > > >
> > > > > case BPF_PSEUDO_KFUNC_CALL:
> > > > >         ...
> > > > >         break;
> > > > > }
> > > > >
> > > > > That 'case 0' feels like it deserves a name. But up to you, I'm
> > > > > fine
> > > > > either way.
> > >
> > > > It's philosophical.
> > > > Some people insist on if (ptr == NULL). I insist on if (!ptr).
> > > > That's why canonical bpf progs are written as:
> > > > val = bpf_map_lookup();
> > > > if (!val) ...
> > > > zero is zero. It doesn't need #define.
> > >
> > > Are you sure we still want to apply the same logic here for src_reg?
> > > I
> > > agree that doing src_reg vs !src_reg made sense when we had a
> > > "helper"
> > > vs "non-helper" (bpf2bpf) situation. However now this src_reg feels
> > > more
> > > like an enum. And since we have an enum value for 1 and 2, it feels
> > > natural to have another one for 0?
> > >
> > > That second patch from the series ([0]) might be a good example on
> > > why
> > > we actually need it. I'm assuming at some point we've had:
> > > #define BPF_PSEUDO_CALL 1
> > >
> > > So we ended up writing `src_reg != BPF_PSEUDO_CALL` instead of
> > > actually
> > > doing `src_reg == BPF_HELPER_CALL` (aka `src_reg == 0`).
> > > Afterwards, we've added BPF_PSEUDO_KFUNC_CALL=2 which broke our
> > > previous
> > > src_reg vs !src_reg assumptions...
> > >
> > > [0]:
> > > https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/T/#mf87a26ef48a909b62ce950639acfdf5b296b487b
> >
> > FWIW the helper checks before this series had inconsistent style:
> >
> > - !insn->src_reg
> > - insn->src_reg == 0
> > - insn->src_reg != BPF_REG_0
> > - insn[i].src_reg != BPF_PSEUDO_CALL
> >
> > Now at least it's the same style everywhere, and also it's easy to
> > grep for "where do we check for helper calls".
>
> The above checks are not equivalent.
> Comparing src_reg with BPF_REG_0 makes sense in one context
> and doesn't in the other.
> It's never ok to add stuff to uapi when it works as-is.
> I also don't buy theoretical arguments about future additions
> and how something will be cleaner in the future because
> we predicted it so well today.

SG! Then let's maybe respin without this part? I might have derailed
the conversation too much from the actual issue :-[

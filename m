Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AAD607F82
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJUUIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJUUII (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 16:08:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2C2670E3
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 13:08:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id q19so9909723edd.10
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NsbTJ174T4GKndNpIEScx40KnHeyFwx+PDQJ8NXLaM=;
        b=FT388DCtHbeAbABcXzKxmVJKpqWJjL1IaOwRZ59NR0fByyizuP4YO4AFBy2xdhvmKE
         n3aS/8rf1M7Q2GuLkzFJ0HOcCf0uW0D8l6jjCoNLcgDhXN3JfmuJvm8ACjZ3uN8PFo+C
         jRBuFGCk31h7193+QDaXj9CQXxtfIonOS7aZ0H5OlsZysJkbhRenkyL7bfZomStHzW4E
         euah0iZ7y6CT+UQjLcsgrXEmm6SNx+vlIxhEu5RixpriTN5juI6B32XleLOBuUk+6d6H
         iljA9oZGEs6NhBcEi8pS3Tna3M9HwzWLRbbAxTR/ivE7em4oRX6+noIzjypUmYfDYqse
         Wy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NsbTJ174T4GKndNpIEScx40KnHeyFwx+PDQJ8NXLaM=;
        b=pe5HS+ptFKpd3zs8W5BDLdzBKe2zuqdTjSRczKq6zMlqcbkRbSHVspb35Rw2MDmnfS
         WAi82FU+2iHe9EbCDhBYMSKiXKlZqfjxUEkFsmaGTdfTqag4+wCcxmG0o389AySY1CFm
         RCw60jPMcEKVoz603wdGlpahrONXRSKMYbfYjflTp4pG36JvVzSxbha3nLWi/esjSNxy
         pHQ5eL4ksXV57cr5TWnG1tFiLtD95aZ0y578eYptibmFVkF1qE19uaMHa2QAVyZVJHYI
         EeTgr/dXufz0TLuNoYC3qNGDSOSM1lVA5ZYL6d4cUfdjpglr98ju1z90ojUaWSP9/p/k
         RC6g==
X-Gm-Message-State: ACrzQf3ng+Hj5BEJoieieh2nieaQpClb7xgPbA6iAKCz6Zsg35lb8oH3
        TUfKD6XCQ4hSP3udl1UfQT0qrKzSKWXTER0QEWyxiXmG
X-Google-Smtp-Source: AMsMyM5+Nxjt6oG/Gid3hJaijx613SDlbTPRXDKtArR749bReSS5RacWk36ptY59AE2+JCqsoO41eaEuF+lPtSZyVYI=
X-Received: by 2002:a05:6402:168c:b0:458:5b8b:afd2 with SMTP id
 a12-20020a056402168c00b004585b8bafd2mr18798557edv.357.1666382885812; Fri, 21
 Oct 2022 13:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com> <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
 <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com>
 <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQL4-aNJ8gZziNC7n7_mchK+Te1+HDBg2sG2YvS3K+2kFQ@mail.gmail.com> <DM4PR21MB344020F909D07E5DEE316818A32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB344020F909D07E5DEE316818A32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Oct 2022 13:07:54 -0700
Message-ID: <CAADnVQJ36HyoP9ZDUZuz-uWT8BCvYbosyWeZfS-e4pAGgubpLg@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Fri, Oct 21, 2022 at 12:24 PM Dave Thaler <dthaler@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Friday, October 21, 2022 12:01 PM
> > To: Dave Thaler <dthaler@microsoft.com>
> > Cc: Stanislav Fomichev <sdf@google.com>; dthaler1968@googlemail.com;
> > bpf@vger.kernel.org
> > Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
> >
> > On Fri, Oct 21, 2022 at 10:56 AM Dave Thaler <dthaler@microsoft.com> wrote:
> > >
> > > > On Wed, Oct 19, 2022 at 4:35 PM Stanislav Fomichev <sdf@google.com>
> > > > wrote:
> > > > > On Wed, Oct 19, 2022 at 2:06 PM Dave Thaler
> > > > > <dthaler@microsoft.com>
> > > > wrote:
> > > > > >
> > > > > > sdf@google.com wrote:
> > > > > > > >   ``BPF_ADD | BPF_X | BPF_ALU`` means::
> > > > > > >
> > > > > > > > -  dst_reg = (u32) dst_reg + (u32) src_reg;
> > > > > > > > +  dst = (u32) (dst + src)
> > > > > > >
> > > > > > > IIUC, by going from (u32) + (u32) to (u32)(), we want to
> > > > > > > signal that the value will just wrap around?
> > > > > >
> > > > > > Right.  In particular the old line could be confusing if one
> > > > > > misinterpreted it as saying that the addition could overflow
> > > > > > into a higher bit.  The new line is intended to be unambiguous
> > > > > > that the upper 32
> > > > bits are 0.
> > > > > >
> > > > > > > But isn't it more confusing now because it's unclear what the
> > > > > > > sign of the dst/src is (s32 vs u32)?
> > > > > >
> > > > > > As stated the upper 32 bits have to be 0, just as any other u32
> > assignment.
> > > > >
> > > > > Do we mention somewhere above/below that the operands are
> > unsigned?
> > > > > IOW, what prevents me from reading this new format as follows?
> > > > >
> > > > > dst = (u32) ((s32)dst + (s32)src)
> > > >
> > > > The doc mentions it, but I completely agree with you.
> > > > The original line was better.
> > > > Dave, please undo this part.
> > >
> > > Nothing prevents you from reading the new format as
> > >     dst = (u32) ((s32)dst + (s32)src)
> > > because that implementation wouldn't be wrong.
> > >
> > > Below is why, please point out any logic errors if you see any.
> > >
> > > Mathematically, all of the following have identical results:
> > >     dst = (u32) ((s32)dst + (s32)src)
> > >     dst = (u32) ((u32)dst + (u32)src)
> > >     dst = (u32) ((s32)dst + (u32)src)
> > >     dst = (u32) ((u32)dst + (s32)src)
> > >
> > > u32 and s32, once you allow overflow/underflow to wrap within 32 bits,
> > > are mathematical rings (see
> > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wik
> > ipedia.org%2Fwiki%2FRing_&amp;data=05%7C01%7Cdthaler%40microsoft.co
> > m%7C44c24e3f67aa4a5c846f08dab396adb0%7C72f988bf86f141af91ab2d7cd01
> > 1db47%7C1%7C0%7C638019756992501432%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C3000%7C%7C%7C&amp;sdata=1rLsMSKUn0sNiZcN2RjDMH9jWIKCuf%2Fc3qZ
> > d2QOanW8%3D&amp;reserved=0(mathematics) ) meaning they're a circular
> > space where X, X + 2^32, and X - 2^32 are equal.
> > > So (s32)src == (u32)src when the most significant bit is clear, and
> > > (s32)src == (u32)src - 2^32 when the most significant bit is set.
> > >
> > > So the sign of the addition operands does not matter here.
> > > What matters is whether you do addition where the result can be more
> > > than 32 bits or not, which is what the new line makes unambiguous and
> > > the old line did not.
> > >
> > > Specifically, nothing prevented mis-interpreting the old line as
> > >
> > > u64 temp = (u32)dst;
> > > temp += (u32)src;
> > > dst = temp;
> >
> > Well dst_reg = (u32) dst_reg + (u32) src_reg implies C semantics, so it cannot
> > be misinterpreted that way.
> >
> > > which would give the wrong answer since the upper 32-bits might be non-
> > zero.
> > >
> > > u64 temp = (s32)dst;
> > > temp += (s32)src;
> > > dst = (u32)temp;
> > >
> > > Would however give the correct answer, same as
> > >
> > > u64 temp = (u32)dst;
> > > temp += (u32)src;
> > > dst = (u32)temp;
> > >
> > > As such, I maintain the old line was bad and the new line is still good.
> >
> > dst_reg = (u32) (dst_reg + src_reg)
> > implies that the operation is performed in 64-bit and then the result is
> > truncated to 32-bit which is not correct.
>
> It is mathematically correct as noted in my email above, you always get the correct result if you do the addition in 64-bit and then truncate.  You get the same
> result as if you do the addition in 32-bit and then zero-extend.

No. It's not about the result in 32-bits. The flags will be different.

> > If we had traditional carry, sign, overflow flags in bpf ISA the bit-ness of
> > operation would be significant.
> > Thankfully we don't, so it's not a big deal.
> >
> > but let's do full verbose to avoid describing C semantics:
> > dst = (u32) ((u32)dst + (u32)src)
>
> Ok, will do.
>
> Dave

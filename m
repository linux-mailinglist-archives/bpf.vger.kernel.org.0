Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F629607E58
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJUSfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJUSfO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 14:35:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACF17FF91
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 11:35:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id 8so2104915ilj.4
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=drMaaZBaH3perzkVOc+AoOVzAG7r0aPEsm8TlYzOdqw=;
        b=qi1+OHpReZkjfwtu+I/ETADeeHBMN9rqLKoF683NKWv5QU5F2NGMCBFajBQQcAV1D9
         fBXg0N7/gBpiK+GfjgOpgyHqW95gykowFaaWo5EEKP2+WJ2csMdr5ebwUSB9vRKpFFdE
         VBpPNtI/aqioazRdejoccPob4inkz7PtckFuq7MWV4BgD8XwJKd13IWW9lKQwddLJPVZ
         Q9oZT625OfCf65vcgzVtHa2hyXGAsMCUvkccT4634vXeeosM1fLrB3ZWoZcigC28eGno
         6dWJR3XlfWbY0YSBuVMElf0Do57rTGDyPdOkibZC2lKZN+V6kZFwIrUJX7IgLccnN8gl
         F4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drMaaZBaH3perzkVOc+AoOVzAG7r0aPEsm8TlYzOdqw=;
        b=5alrSMIV5OV8vqlCJqGWFN9eA/8U48REb6Csi0eagUbzCD2QB+e0qYRtIlCpVpS7jm
         L1+q00yypUQhYKStiv1JhL6V3RIYYIgKbXLL9KirlLWr5WimYRLbjxxRuNOWK5x3IXEN
         Nu6Eu6P6ry3QajCbsXByTSaJVVdSFQ+tNZjIj0tj7u3SoLx/zR7+KKz/41ev32IfULiw
         zkxUlxIM10CKOtgyDcfmlPcOuu1LRiqR4RoKyO4N2NhhuYJhlyIN6vLvzYqUsnNw+XF7
         Xgy3mA9mRA1yDg+jqBAD4zxY2M5oXkDz7QDhmpCXBP3hXmUFzqGXQlekoFIpWQvC4p4e
         IP/w==
X-Gm-Message-State: ACrzQf34etHQ3caRV+1idcTFTNUdER3Wu36ptTiY0XnE5AlaN+0N9Zcu
        I/Ptyr1yySbxsSQzDusNkev1vxesxPau9Nco5qdApw==
X-Google-Smtp-Source: AMsMyM6rB2Qt6/La/wxTXL0xTYrZDtoP407BolK9pQqTqw3BkArwJ9Q7jUm1exi0kvVYocy2ErEOy9vok3UmeTOoFxY=
X-Received: by 2002:a05:6e02:1bc4:b0:2fc:2d47:9abf with SMTP id
 x4-20020a056e021bc400b002fc2d479abfmr14504413ilv.246.1666377311854; Fri, 21
 Oct 2022 11:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com> <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
 <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com> <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 21 Oct 2022 11:35:00 -0700
Message-ID: <CAKH8qBsLqw=AbU=xHv1zFtcf-nrLUrPyrDj4rtnHJEc2B_c82Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 10:56 AM Dave Thaler <dthaler@microsoft.com> wrote:
>
> > On Wed, Oct 19, 2022 at 4:35 PM Stanislav Fomichev <sdf@google.com>
> > wrote:
> > > On Wed, Oct 19, 2022 at 2:06 PM Dave Thaler <dthaler@microsoft.com>
> > wrote:
> > > >
> > > > sdf@google.com wrote:
> > > > > >   ``BPF_ADD | BPF_X | BPF_ALU`` means::
> > > > >
> > > > > > -  dst_reg = (u32) dst_reg + (u32) src_reg;
> > > > > > +  dst = (u32) (dst + src)
> > > > >
> > > > > IIUC, by going from (u32) + (u32) to (u32)(), we want to signal
> > > > > that the value will just wrap around?
> > > >
> > > > Right.  In particular the old line could be confusing if one
> > > > misinterpreted it as saying that the addition could overflow into a
> > > > higher bit.  The new line is intended to be unambiguous that the upper 32
> > bits are 0.
> > > >
> > > > > But isn't it more confusing now because it's unclear what the sign
> > > > > of the dst/src is (s32 vs u32)?
> > > >
> > > > As stated the upper 32 bits have to be 0, just as any other u32 assignment.
> > >
> > > Do we mention somewhere above/below that the operands are unsigned?
> > > IOW, what prevents me from reading this new format as follows?
> > >
> > > dst = (u32) ((s32)dst + (s32)src)
> >
> > The doc mentions it, but I completely agree with you.
> > The original line was better.
> > Dave, please undo this part.
>
> Nothing prevents you from reading the new format as
>     dst = (u32) ((s32)dst + (s32)src)
> because that implementation wouldn't be wrong.

Assuming the underlying cpu architecture is using 2s complement to
represent negative numbers, right? (which is probably a safe one
nowadays)
I don't know whether that's something that's spelled out in a generic
BPF architecture doc.

> Below is why, please point out any logic errors if you see any.
>
> Mathematically, all of the following have identical results:
>     dst = (u32) ((s32)dst + (s32)src)
>     dst = (u32) ((u32)dst + (u32)src)
>     dst = (u32) ((s32)dst + (u32)src)
>     dst = (u32) ((u32)dst + (s32)src)
>
> u32 and s32, once you allow overflow/underflow to wrap within 32 bits, are
> mathematical rings (see https://en.wikipedia.org/wiki/Ring_(mathematics) )
> meaning they're a circular space where X, X + 2^32, and X - 2^32 are equal.
> So (s32)src == (u32)src when the most significant bit is clear, and
> (s32)src == (u32)src - 2^32 when the most significant bit is set.
>
> So the sign of the addition operands does not matter here.
> What matters is whether you do addition where the result can be
> more than 32 bits or not, which is what the new line makes unambiguous
> and the old line did not.
>
> Specifically, nothing prevented mis-interpreting the old line as
>
> u64 temp = (u32)dst;
> temp += (u32)src;
> dst = temp;
>
> which would give the wrong answer since the upper 32-bits might be non-zero.
>
> u64 temp = (s32)dst;
> temp += (s32)src;
> dst = (u32)temp;
>
> Would however give the correct answer, same as
>
> u64 temp = (u32)dst;
> temp += (u32)src;
> dst = (u32)temp;
>
> As such, I maintain the old line was bad and the new line is still good.

[..]

> If you like I can explicitly say
>     dst = (u32) ((u32)dst + (u32)src)
> but as noted above the operand sign is irrelevant once you cast the result.

That might be a good compromise. A bit verbose, but solves both "what
happens to the overflow" and "what's the operand sign" questions.

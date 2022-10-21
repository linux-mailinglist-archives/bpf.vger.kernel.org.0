Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3C607E8E
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJUTCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJUTBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 15:01:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49DDE9C
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:01:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so9432287edj.0
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3F/McVfOlwytbkRfD439XMP1gYSBJcVx+Mw1G7aSRcw=;
        b=LCBkS6arpvaSpQauzB04JDOe/GAMxHNukdwUxezZtBUDS62Mh8rpWEquKQMnP/CdaU
         9x05e9jbhhXhQGf0F4mFcDGRYydGrH087kYVMvtFzb3CwwVSiuamSo/F/wT1etht7+s5
         Sq6ObWNYI1LJBc1ZB01NhOFY082j5fTgLSFDNmJytq8D7n7f40SNG3YsfoCNqNJNUNP2
         EnQcaFjjXqZxnokp+ca3+zjASxwNBVmRClBASgwbqLCmmfuldhCD/1SkDfQOnAXFpiHF
         OURehtYFjO+lYeoRvNSmTfU6PTr84+E8m6XlMAT1FhpSjixmLbrO0kmHKIFdtZYMXYa6
         KuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F/McVfOlwytbkRfD439XMP1gYSBJcVx+Mw1G7aSRcw=;
        b=fOip32If8ezaUAZBmV1rBsaeOBgWh2MLpFrFPGbCpPokXAdn2X/XibngokadO/NIKb
         bKYfQfseVhKCOE4ydTAomozFWusH/9uvkg0Stu/61/8CLr46WO6dG/P42eSdD8yzSDW0
         UgcBa8BBtKj9HRFnewJ9lc5EFgyBi/qBvb8He1ixI3wJV7PM6Rdcq07RKjIS97SyMEQI
         EsDOtRjG3xJWMUEUDPrVGPNSbCQJU8IfCANQOjzpkxNMDl7IGJrfiwF1eMTsOtYZDjn/
         MHHOFqfW4GhXiQAexSuvMwDvj7wTLY8d1/n43jkWBmQBycKW4I8RTLj4DMY2ZipZl992
         WBbw==
X-Gm-Message-State: ACrzQf2+4jfSMhhnZWh7F8+CTMO2lxEHMWkB48F62otSapU2lk2E80UV
        QiwLsl36c4AC3ZbGjgh4LsauJO745Y2b5H/2l3U=
X-Google-Smtp-Source: AMsMyM7VrfnkXE7Emrlmj03B4EPFs3qgApi4JiqfWdLjYDc/o5r2o99LEDMPY2W3390jmZrxo3TBFXCjOwKZ8q4Z69Q=
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id
 nb24-20020a1709071c9800b0078d3b06dc8fmr16318025ejc.58.1666378895618; Fri, 21
 Oct 2022 12:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com> <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
 <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com> <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB344040829C9EAD2B159CAF3BA32D9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Oct 2022 12:01:24 -0700
Message-ID: <CAADnVQL4-aNJ8gZziNC7n7_mchK+Te1+HDBg2sG2YvS3K+2kFQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
>
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

Well dst_reg = (u32) dst_reg + (u32) src_reg
implies C semantics, so it cannot be misinterpreted that way.

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

dst_reg = (u32) (dst_reg + src_reg)
implies that the operation is performed in 64-bit and then
the result is truncated to 32-bit which is not correct.

If we had traditional carry, sign, overflow flags in bpf ISA
the bit-ness of operation would be significant.
Thankfully we don't, so it's not a big deal.

but let's do full verbose to avoid describing C semantics:
dst = (u32) ((u32)dst + (u32)src)

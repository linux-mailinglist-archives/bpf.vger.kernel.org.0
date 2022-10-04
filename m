Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE75F4950
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJDSfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJDSfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 14:35:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532D20F60
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 11:35:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x59so10042671ede.7
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PcXNHR0gghwHcV7qe4ZbOwmr/1ijONuZtbjDXAMA4gA=;
        b=Toi2tRkiBHzkYIdwyyFLLuQqal2vK3puh4i3xqPgbfcNQXL3+MHekmiFTETjYQVIF0
         9ckoIhWp4F9lmb2u14zgWRSkvyP6L6xTT82yeBuWxQSSFofEWWsczNR7ANZhIw+NWOc3
         hYd3iN1au6/VGdB+TCjDyXcMidtdmdNxp/9W8mTnboB7BYQsdv9Qw21I1o9mtBqs3J0n
         yDIE6+G4C0BkGmqYZnhzYpI2GRXlK26h74p0zy3yTxclS4zRox5gJtEkgTwT9ZvkSE5l
         b/eer8Wq0j7MMriL1mfnDvzoeAEoBduH5hqCLhgkIatINrC95OQcKOajBBRX6urqWMSB
         WfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PcXNHR0gghwHcV7qe4ZbOwmr/1ijONuZtbjDXAMA4gA=;
        b=DGWbiSR8Tn9t9WNHK+raIEJuMHvhbvsWCF/0RzGuEQREESU1Ff6oPoxZfS8cy+XgiU
         d+3Ue5znsQGUVQJB/1vok9Fep+tB0T6faGxLFSxrlZLDYCfFaijbYpEiUtVHwvjT1f8o
         TKULxaDHJqawEg1+2dbKg+mpStTZMhNwhXDnq+OjC/UpNomJbW0oL6KPXb3io+tQcwz6
         AXNzUdfMBUPGP4B2OejXQa6hcd9Si0RPEe5hzbkX5MJl948S2Jo1VZ+rlCpzpvURaTmR
         RRWM5l+9LvAbTi2YWLcRaemtgh02iG7gtkMLsNZG34/4mIjTvD03hirKqy+EPHGwVMmH
         00cA==
X-Gm-Message-State: ACrzQf17cTYgFTNGo4k+ONOjfhOWJ5g4rP2JeRhrZa0SEl5V1lvKafzT
        SSKqMLAU5dYUITv1JgoJaLHV91A6Eo5i0zGuA7s=
X-Google-Smtp-Source: AMsMyM5f7aIR35LGAp1MHfT5RwQFWVbKfcYTZ9s/i7tVUkXD5Vz/i6De1dgkxHcD31fTyYokiThj/YzUF/7eNtS0Frc=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr25052457edb.333.1664908501171; Tue, 04
 Oct 2022 11:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com> <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJto119zhc3oBuNa-OuwoNWW02bDDRb_SGKxZxq=Wid8A@mail.gmail.com>
 <DM4PR21MB34409A021A6658DDAAB3B5AEA35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQKYb9fB2-AcPB0sMbE_pT2cQhOiKQw0q5rPxXHZ-6eXTw@mail.gmail.com> <DM4PR21MB3440DC0EE41F65013FE15E45A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440DC0EE41F65013FE15E45A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Oct 2022 11:34:49 -0700
Message-ID: <CAADnVQJ387tWd7WgxqfoB44xMe17bY0RRp_Sng3xMnKsywFpxg@mail.gmail.com>
Subject: Re: div_k. Was: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by
 zero, overflow, and underflow
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
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

On Tue, Oct 4, 2022 at 11:23 AM Dave Thaler <dthaler@microsoft.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > What is the expected value for the following 64-bit BPF_DIV operation:
> > >     r0 = 0xFFFFFFFFFFFFFFFF
> > >     r0 /= -10
> > > Is it 0x1 or 0x10000000a?  i.e., is the -10 sign extended to
> > > 0xFFFFFFFFFFFFFFF6 or treated as 0xFFFFFFF6 when doing the unsigned
> > > division?
> >
> > x86 and arm64 JITs treat it as imm32 is zero extended.
>
> Alan Jowett just pointed out to me that the question is not limited to DIV.
>
> r0 = 1
> r0 += -1
>
> Is the answer 0 or 0x0000000100000000?
> Assuming the answer is to zero extend imm32, it contains the latter, which
> would be counter-intuitive enough to make it important to point out explicitly.

This is an obvious one. imm32 is _sign_ extended everywhere.

>
> > But looking at the interpreter:
> >         ALU64_DIV_K:
> >                 DST = div64_u64(DST, IMM); it looks like we have a bug there.
> > But we have a bunch of div_k tests in lib/test_bpf.c including negative
> > imm32. Hmm.

Actually I misread the JITs.
/* mov r11, imm32 */
EMIT3_off32(0x49, 0xC7, 0xC3, imm32);

It is sign extending. There is no bug in the interpreter or JIT.

> Yeah.
>
> "ALU64_DIV_K: 0xffffffffffffffff / (-1) = 0x0000000000000001",
> "ALU64_ADD_K: 2147483646 + -2147483647 = -1",
> "ALU64_ADD_K: 0 + (-1) = 0xffffffffffffffff",
> "ALU64_MUL_K: 1 * -2147483647 = -2147483647",
> "ALU64_MUL_K: 1 * (-1) = 0xffffffffffffffff",
> "ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffff0000",
> "ALU64_AND_K: 0xffffffffffffffff & -1 = 0xffffffffffffffff",
> "ALU64_OR_K: 0x000000000000000 | -1 = 0xffffffffffffffff",
>
> The above assume sign extension not zero extension is the correct behavior
> for these operations, if I understand correctly.
>
> Dave

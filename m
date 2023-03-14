Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD76B86A0
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 01:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCNAKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCNAKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 20:10:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDFD5FEA0
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 17:10:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id ay18so8715419pfb.2
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678752607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtazxYWv3j3HTsYjyz2YNDxKQqzsyMc+WtCtSsWTsQw=;
        b=cScDyHrXekflucr7Td7d5ilnD2IupTxPe6T2fT5jrgZt0zlzUBTq+MYcHqUAhS7mEY
         4ZI9WuGtExcPxLv66ohjpWZU/JvDGknR4BX0gTQSNG8Md4TwOOqCG52mWtGS0/nGn3hE
         zFJhYdibUeeJRYy/jzgwGw+0YpMPR0bxfSdQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678752607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtazxYWv3j3HTsYjyz2YNDxKQqzsyMc+WtCtSsWTsQw=;
        b=Pu3lv/3KGhDUUrsCjHeXRSfMJkKc9SlYo2R82PgVBEhvLRNtREkDdJ+oQf0moybjy9
         xHqiOGjX3A+epjT6g07sIToMRNaHkCe06/+etRKjtUV3aCsuPonDgyJLOkaVDJjhMLD3
         oRPaEof72Ukn/fsCCHSKPLIq4yz0tEneu7qD+WWXEytfXgMtqQCw2ZsBzKNEAmrUg9xc
         1wB52e2EADUqc1Crf8n9wYKz2Ahz6RobjssfrV8xgJDaCAtfpP+GNNW4yQOEd1TDXKgW
         4F7o9aPMMtVbDZYZ39ONkK5SaQuTwU7Y7iJS/+OQ7W/54Epi5MJYBzsa5RpEFXtqhP4r
         xCdQ==
X-Gm-Message-State: AO0yUKW5NzytG730wfI7YKqUWKXjER65eO++CpXBrLQxpxoKgnbFE82w
        Kjwmar5u3FVVS1VHZ/FFPz56OTXA2O3txVCpyi3hvg==
X-Google-Smtp-Source: AK7set8T/vjp8Iz/JmfVy5dElYKf02qtbtqdAUW/VrKded/oy5Nx1vGm1/YWxMPtoVcwFJVZ2a5rM+LZplNY9ADcPS4=
X-Received: by 2002:a63:1a1f:0:b0:4f2:8281:8afb with SMTP id
 a31-20020a631a1f000000b004f282818afbmr11940632pga.4.1678752606902; Mon, 13
 Mar 2023 17:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
 <c6d5e819-3e57-8e54-3cfd-d5a9814d96d1@huawei.com> <CANk7y0jYf46AQV7=FXkJAie0F_dXoMXp5A4CWgDhRcMR3o1ZDQ@mail.gmail.com>
In-Reply-To: <CANk7y0jYf46AQV7=FXkJAie0F_dXoMXp5A4CWgDhRcMR3o1ZDQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 14 Mar 2023 01:09:56 +0100
Message-ID: <CABRcYmL946h-9-D_Yt+COtkKdoWEjw8_cznQNaep=Vvo-k=MCQ@mail.gmail.com>
Subject: Re: [RFC] Implementing the BPF dispatcher on ARM64
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Xu Kuohai <xukuohai@huawei.com>, bjorn@rivosinc.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        daniel@iogearbox.net, bjorn@kernel.org, andrii@kernel.org,
        ast@kernel.org, bpf@vger.kernel.org, memxor@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Puranjay! :)

On Mon, Mar 13, 2023 at 1:56=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> [CC: Florent, KP]
>
> On Mon, Mar 13, 2023 at 7:50=E2=80=AFAM Xu Kuohai <xukuohai@huawei.com> w=
rote:
> >
> > [ cc arm list ]
> >
> > On 3/10/2023 5:33 PM, Puranjay Mohan wrote:
> > > Hi,
> > > I am starting this thread to know if someone is implementing the BPF
> > > dispatcher for ARM64 and if not, what would be needed to make this
> > > happen.

As Alexei said, I've been doing some work on ftrace direct calls on
arm64 (so the trampolines can get called in tracing programs)

https://lore.kernel.org/all/20230207182135.2671106-1-revest@chromium.org/

It is currently blocked waiting for a review from the ftrace
maintainer. Steven has been quite busy but I regularly nag him to
review it :)

> > > The basic infra + x86 specific code was introduced in [1] by Bj=C3=B6=
rn T=C3=B6pel.
> > >
> > > To make BPF dispatcher work on ARM64, the
> > > arch_prepare_bpf_dispatcher() has to be implemented in
> > > arch/arm64/net/bpf_jit_comp.c.
> > >
> > > As I am not well versed with XDP and the JIT, I have a few questions
> > > regarding this.
> > >
> > > 1. What is the best way to test this? Is there a selftest that will
> > > fail now and will pass once the dispatcher is implemented?
> > > 2. As there is no CONFIG_RETPOLINE in ARM64, will the dispatcher be u=
seful.
> >
> > Hello,
> >
> > I have some thoughts for bpf dispatcher in arm64.
> >
> > bpf dispatcher uses static call to convert indirect call instructions t=
o direct
> > call instructions, to avoid performance penalty introduced by retpoline=
. Since
> > there is no retpoline or static call in arm64, bpf dispatcher seems use=
less.

But I agree with Xu here. The reason why I did not look into bpf
dispatchers for arm64 is because there is no retpoline cost on arm64.

> > In addition, the range for a direct call instruction in arm64 is +-128M=
B, but
> > jited bpf image address is outside of +-128MB, so it may not be possibl=
e to call
> > a bpf prog with direct call instruction.
>
> So, to summarize all the information about BPF Dispatcher on ARM64:
> 1. The range for the B and BL instructions in arm64 is +-128MB, so we
> can't use direct jump.
> 2. Static Calls are not supported on ARM64 yet.
> 3. bpf_prog_pack allocator for ARM64 is not yet enabled because
> bpf_arch_text_copy()
> and bpf_arch_text_invalidate() are not implemented.
>
> Even if static calls are implemented the dispatcher can't be
> implemented because of point 1.

And even if they could, I don't see what value they would bring on arm64.

> What would be required to implement bpf_arch_text_copy()
> and bpf_arch_text_invalidate(). As enabling the bpf_prog_pack
> allocator for ARM64
> would be useful in the JIT as well.

I have not looked into this at all but ooc have you noticed the series
for powerpc sent just a few days back to the list ?

https://lore.kernel.org/bpf/20230309180028.180200-1-hbathini@linux.ibm.com/

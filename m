Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1B5F4854
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJDRZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJDRZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 13:25:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2CD2717A
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 10:25:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 13so30370628ejn.3
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=p8al/9sfuyrhFzxM6tIcfZv8ScLRYxa6V4kdJmqtVbE=;
        b=oWgYwjpHhL1OkMvefp+ZXHyS7dfBriBWXCRy8bbkHBcc4v+N/rO1abeCDz0iALi2a1
         Hf/ESEP87P7Bc8AfAZnLXDj0M1uunXUizFDdsS0MIE9SdKmR3TlgvoKgAf3jtTjqHbLL
         MOcUQobong8tqIw29NXMK7GClPjs/PJojf52dAWGZ81OVPF1unS/Cjedoq6A8cXBpKcM
         sRXggHBmn+QIw+bWuDx4DYKkBQpQ+wdAFPh43U6LOouLp8bIoqI0a4eU+PrNHR9J1Z55
         KlaCNa27pAnxnKmXbWFa5ll1RbgRBJZ5PrFGPXn+ggqY+qRtfSu7TLsSZEkvexUvX6PX
         ZcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p8al/9sfuyrhFzxM6tIcfZv8ScLRYxa6V4kdJmqtVbE=;
        b=t9jWQwhO87gZHZ+4TRcKLtbpy0UN3w8UfC7Ovr81yTMOn9Ki3GrE4UWRlWbF37QX9e
         a+n82AYcLCqwhcxGUmC5kDKZ4ixHu9Ncu7IUwmKU7hku33+OeW2PMdUfVBz+OvTDD3Zv
         MANj+ctmggd02uV1yTtiB4X007PjZHKGukUG9P9qBSTO5E6iM6enayWOYRATNy6yjrHm
         7zMQDajwcrrX53C38TtNiRh64tRXS5N2hn1KXxK+LTOMku+kY5EsAV24mm2LQJdgwMRf
         q8xoKrCo3wV9Up7TAvB4EEAfa8ePklNrVdterzz9JUdeq6s06FyxOzOt5ZkLGI5D6jO4
         vRaA==
X-Gm-Message-State: ACrzQf14zB+Kzr8Jf8uJlp1cwz+v6H281QWDt77jY3SRLgawUutqvJVu
        DtIDxz1O9zAsP5zWqDq6lmPGj20q5DILchkhxkVvMEaTRGM=
X-Google-Smtp-Source: AMsMyM71T5SOkB4X/8rH6jcIT+zh1p5vRkJBnQfpcM0gpQNd+FrmQN5wyv+uEW1gs28zZg6Onogx0avcH8I3JphlaCQ=
X-Received: by 2002:a17:907:6e87:b0:782:2d55:f996 with SMTP id
 sh7-20020a1709076e8700b007822d55f996mr20636834ejc.502.1664904309343; Tue, 04
 Oct 2022 10:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com> <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJto119zhc3oBuNa-OuwoNWW02bDDRb_SGKxZxq=Wid8A@mail.gmail.com> <DM4PR21MB34409A021A6658DDAAB3B5AEA35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB34409A021A6658DDAAB3B5AEA35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Oct 2022 10:24:57 -0700
Message-ID: <CAADnVQKYb9fB2-AcPB0sMbE_pT2cQhOiKQw0q5rPxXHZ-6eXTw@mail.gmail.com>
Subject: div_k. Was: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by
 zero, overflow, and underflow
To:     Dave Thaler <dthaler@microsoft.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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

On Tue, Oct 4, 2022 at 9:36 AM Dave Thaler <dthaler@microsoft.com> wrote:
> > Those differences are in signed div/mod only, right?
> > Unsigned div/mod doesn't have it, right?
> > bpf has only unsigned div/mod.
>
> Ah right, will replace.  However since imm is a signed integer, that leaves
> an ambiguity that is important to clarify.
>
> What is the expected value for the following 64-bit BPF_DIV operation:
>     r0 = 0xFFFFFFFFFFFFFFFF
>     r0 /= -10
> Is it 0x1 or 0x10000000a?  i.e., is the -10 sign extended to
> 0xFFFFFFFFFFFFFFF6 or treated as 0xFFFFFFF6 when doing the unsigned
> division?

x86 and arm64 JITs treat it as imm32 is zero extended.
But looking at the interpreter:
        ALU64_DIV_K:
                DST = div64_u64(DST, IMM);
it looks like we have a bug there.
But we have a bunch of div_k tests in lib/test_bpf.c
including negative imm32. Hmm.

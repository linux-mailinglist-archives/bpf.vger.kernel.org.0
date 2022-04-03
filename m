Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCF4F0D0A
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 01:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376710AbiDCXt6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 19:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376705AbiDCXt5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 19:49:57 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1E3152F
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 16:47:55 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y16so5739487ilc.7
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jc+BhTtNNmMxR3X7BxfMIujHmv1HADmhGyqhxFrM3gc=;
        b=AG7jauAuBhbO1H180rzeWI74wnaoD5a5oNTNEnWsVZ4m35yEx4yt5JVLYyMCUyHuTc
         16g52brOULTUm9T//xIstDohc6Zmepv/ImYlGDEUuueWlepKJSpWjd8ig4pxi3rtUErN
         TrpsWHT/dM68E+4MfEEEP/9ziI0BPBAcrSS0D5k1RphmgWaX/0obFNKdwPnFLI/OxFBk
         G0ROapodFvLoRrjbgOEsWAPF4DeKmvWEpFuI+5UaxGcT/vsDqQiejC2viWVOxOtYpIgY
         WoVgk0YHA/fVesvaMLHLA7S+AwspAZLQ8GZBPZuxSd4a3o84ezXxrRvkfBaheoAN95tp
         CPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jc+BhTtNNmMxR3X7BxfMIujHmv1HADmhGyqhxFrM3gc=;
        b=jR1vuHIZsI2iu2XzJ2kJ9wTpz1lcSnvCxJo7MIfgNWhlxMTiDu+sXl/4Mb4HysrlQ1
         QS4DFZvQoKo5M7IJm1RvLXLD3PJGFppJv84xaEo+02w9D0qAzthajiBvp7XPZm01LJkc
         8dCYLrAY9ChDnIyqeMw7nk2MrHaIiPbU/cGsFgL3wtmC+cqtiB1Ic0naWYqeKc3qFTUB
         yn+nNAsaYKcLqmG61HEXPIqAWrkteI0v6LB0I7NTWxIAP6AE0qJgeDfcwYC3xDShs+32
         K0PDcJ40OcJL69sShnXMXQUMsP1Ul191TqAS8H6C5nwaV7Ar8QQitI1RGP86Mk7eyUC2
         IudA==
X-Gm-Message-State: AOAM533esMcmFXUs8Ivm+PSi5BjkZwlhUTTNBBRd8qypfv/EkY7wFoSO
        mZFP9GcKhndG+RXdleAbX1L5wO7QTWicT/SMq735ZN5P
X-Google-Smtp-Source: ABdhPJyTJD9qVYeqCsYKzofmDnzWrDOHzjsswQ/Igfex4+ZkfnSeuw/qGfOIRIkaJ7Rk9boydZ3Upq/MYy3L63sZF4w=
X-Received: by 2002:a92:cd89:0:b0:2c9:bdf3:c5dd with SMTP id
 r9-20020a92cd89000000b002c9bdf3c5ddmr4019196ilb.252.1649029675022; Sun, 03
 Apr 2022 16:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oVD+0Ltuww1F-AZdPtSE4O4M-BH5NP_R-oSBWszZ3oZiQ@mail.gmail.com>
In-Reply-To: <CAO658oVD+0Ltuww1F-AZdPtSE4O4M-BH5NP_R-oSBWszZ3oZiQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Apr 2022 16:47:44 -0700
Message-ID: <CAEf4BzY8kjQDrkKU2gZox8J9gF7iQ9ht=2GVmXuktCRg0sRqjA@mail.gmail.com>
Subject: Re: Questions on BPF_PROG_TYPE_TRACING & fentry/fexit
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 1, 2022 at 7:27 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi there,
>
> I'm looking to implement programs of type BPF_PROG_TYPE_TRACING to
> replace kprobe/tracepoints because from what I can tell there's less
> performance overhead. However, I'm trying to understand restrictions
> and use cases.
>
> I see that there's a generic `bpf_program__attach()` which can be used
> to attach programs and it will attempt to auto-detect type and attach
> them accordingly.
>
> In practice, I'm curious what I can attach programs of this type to,
> and how are they specified? `bpf_program__attach()` doesn't take any
> parameters outside of the program itself. Does it attach based on the
> name of the program's name/section? If so, is there an idiomatic way
> of making sure this is correctly done?

You can specify destination either in SEC() definition:
SEC("fentry/some_kernel_func") or you can use
bpf_program__set_attach_target(...) before BPF object is loaded.

>
> My follow up question is to ask how fentry/fexit relate. I've seen
> these referred to as program types but in code they appear as attach
> types, not program types. Can someone clarify?

Formally they are different expected attach types for
BPF_PROG_TYPE_TRACING program type. There is also fmod_ret, which is
yet another expected attach type with still different semantics. But
it's like kprobe and kretprobe, they have very different semantics, so
we talk about them as two different types of BPF program.

>
> As always I'm partly asking so that I can document this and avoid
> other people having the same confusion :-)
>

Yep, I appreciate it. Please send follow up questions if you still
have some. Please check relevant selftests to see possible usages.

> Thank you very much!
> Grant

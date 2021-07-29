Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E518B3DA351
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhG2MqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhG2MqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 08:46:09 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532BAC061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 05:46:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a93so10063706ybi.1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi7rp1GNYexymoUQyvMFYPbnqInCufc4sEVtUctnyiw=;
        b=FU9ZCHbqtqfXorPLTVawPI1sEJoaFb7y5+mTOrSRXARFRLvEnFEaNrVc7H4jY+vJRK
         MIDYM+/VAKVEhocttsWZfM4Tovs2RQYk7kkjylUi9SCBcB5WolWxDzswWvs1VaCpWZqn
         B2fDAP/iE+6NANp05iFix395vI+zELGZSzruExp47Qbt0x92z7d4yKalhyUNCO98JVq0
         QVbN4IVpkqFXCUQTtt4DIJAdDJXeCBKdqvDkZL/NM5xCK592owEGcRZ3ckS41Tim+ayr
         r26qATc5cXa9OhpFHjbmQPYbtR3jWGz4fYANRRmAxYPKmXOk1zaHB7+cru/qtdcxrCcA
         Z/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi7rp1GNYexymoUQyvMFYPbnqInCufc4sEVtUctnyiw=;
        b=DR/11pvq1oebJh7ujx5J0pV5jMa1+IpygR3Ey7OAZlNg5tFAztOqmNRiOYwaLriJbl
         CiWkg8lG5PAe5+W8094xNuHN0E26L2FOGDsHxEOdZorC1WOLHBSsaZ6sqcL308RHPtHg
         eyQOkSUOpCHOiwgYUZkathGKnxKprjKzAky3GuGFj6g7Ns0+EyLq43Deh0/bSPFyc6Pv
         Rroyz/koeOBg8+SLbfOFDHgPIfI/yt4IbcN0h5bIXovKe2Zm97Hmhhf4sCxZhs/fLbrI
         fJJav6LwqwTR9i4r/5wbYJSveDoRcNbKm9mmq6wdqdEHPz3tyhUaz87QX2MFGRO7GMTU
         KSFg==
X-Gm-Message-State: AOAM530+YA2HzOFMHApjIao+x2QWUFeD9Bl/MeS8Fd2qPIu62R3qNgkm
        dY/90SJ8g5D45Auc3/NJaM7reOzPuV82k7XO4BbQlg==
X-Google-Smtp-Source: ABdhPJzVsxIRnXRzkqfX+4EUYDqbW6pnCNN0xiWCPWlBybZjpXqtAz4jBFXNKJrWPI3si5FTgR7HD5Eyk7IDm+X+Hk8=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr6382446ybg.111.1627562765580;
 Thu, 29 Jul 2021 05:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
 <20210728170502.351010-11-johan.almbladh@anyfinetworks.com> <693d7244-6b92-8690-4b04-e0a066ca4f6f@fb.com>
In-Reply-To: <693d7244-6b92-8690-4b04-e0a066ca4f6f@fb.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 29 Jul 2021 14:45:54 +0200
Message-ID: <CAM1=_QRqcVYy+ZAKkqoUZghXqLPuD8E4he47ADCRCegM2oGf_g@mail.gmail.com>
Subject: Re: [PATCH 10/14] bpf/tests: Add branch conversion JIT test
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 1:59 AM Yonghong Song <yhs@fb.com> wrote:
> > +static int bpf_fill_long_jmp(struct bpf_test *self)
> > +{
> > +     unsigned int len = BPF_MAXINSNS;
> > +     struct bpf_insn *insn;
> > +     int i;
> > +
> > +     insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
> > +     if (!insn)
> > +             return -ENOMEM;
>
> When insn will be freed?

It is freed by the existing test runner code. If the fill_helper
member is set, the function destroy_bpf_tests frees the insn pointer
in that test case. This is the same as with other tests that use the
fill_helper facility.

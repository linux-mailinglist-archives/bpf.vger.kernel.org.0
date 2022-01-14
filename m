Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85AC48F257
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 23:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiANWVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 17:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiANWVC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 17:21:02 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C4C06161C
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 14:21:02 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id z22so27182964ybi.11
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdW6l+hnl2A/9fPmp1Ui5Qe2IL3WZGRFxk5bdl0Lrnk=;
        b=F3S9kP2hnyNAyE16q+blRrSdFaHK9bN2MZwahIQBR08BxTsR+yltlO356a+iuV4rOW
         JNvwEqBjWxWG9mD0WnGKDtY1aiqbnLv7XoK4HYEORL4zdJMHZ1s01m3K1YzR6g2P5OVo
         CM1iqTdIaec72CQHMuHG50FrCw4E3c0a5dMh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdW6l+hnl2A/9fPmp1Ui5Qe2IL3WZGRFxk5bdl0Lrnk=;
        b=pfJsGhwmlWTpIyzD44sD2hcvS3PQNXOpu2Lhy2T+5fTI5eGxme5gnDL22AJN0Gfnsq
         7J/DIgyruZb5CoEVUstNevIfynbF95IOtKSKs3Hf37SQPAAKx/6Lb3YfKduSSMcGXPW6
         VDBzEzXqAzOTIJOI5grF/dieZApvhnmQPO+tURiNIRZGimluGXAM3odN5UtVIuPua7//
         iMccS0sml9yfrs9w5m304NcSPK4z1QieMsykt3TLI2YJ5A2Ee5TaDOOhDLNq8+IW/mGP
         zE/o6OLj3RgSzjyn9MNtl7XovAysIiBC3JcDC9QIEnB7q9dLsNwvExtXZ8uy0GobM7/s
         pZ+g==
X-Gm-Message-State: AOAM5305tm6G1dbR2iX/RW8KKHOUDArGlO1yGVsVHajrvDWmNdy13b5r
        lGlcwCnhXPhiU4qXunQMFlhWlPGRUffH97ZAiZXIg2Ox6I1xtHAN
X-Google-Smtp-Source: ABdhPJwZHNor0OBeUymdSE9MD8tbiW9PjUgEdrJ/+d/zqxhgb5HqLrsPpW5KqTgZCVVX2ZLVV5OjKiyMv5A6w3EMI/c=
X-Received: by 2002:a25:51c2:: with SMTP id f185mr9453004ybb.677.1642198861338;
 Fri, 14 Jan 2022 14:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20220111192952.49040-1-ivan@cloudflare.com> <CAA93jw6HKLh857nuh2eX2N=siYz5wwQknMaOtpkqLzpfWTGhuA@mail.gmail.com>
 <CABWYdi0ZHYvzzP9SFOCJhnfyMP12Ot9ALEmXg75oeXBWRAD8KQ@mail.gmail.com> <CAA93jw5+LjKLcCaNr5wJGPrXhbjvLhts8hqpKPFx7JeWG4g0AA@mail.gmail.com>
In-Reply-To: <CAA93jw5+LjKLcCaNr5wJGPrXhbjvLhts8hqpKPFx7JeWG4g0AA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 14 Jan 2022 14:20:50 -0800
Message-ID: <CABWYdi1p=rRQM3oySw2+N+mcrUq3bXA5MXm8cHmC3=qfCU5SDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tcp: bpf: Add TCP_BPF_RCV_SSTHRESH for bpf_setsockopt
To:     Dave Taht <dave.taht@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 13, 2022 at 9:44 PM Dave Taht <dave.taht@gmail.com> wrote:
> Yes, but with the caveats below. I'm fine with you just saying round trips,
> and making this api possible.
>
> It would comfort me further if you could provide an actual scenario.

The actual scenario is getting a response as quickly as possible on a
fresh connection across long distances (200ms+ RTT). If an RPC
response doesn't fit into the initial 64k of rcv_ssthresh, we end up
requiring more roundrips to receive the response. Some customers are
very picky about the latency they measure and cutting the extra
roundtrips made a very visible difference in the tests.

> See also:
>
> https://datatracker.ietf.org/doc/html/rfc6928
>
> which predates packet pacing (are you using sch_fq?)

We are using fq and bbr.

> > Congestion window is a learned property, not a static number. You
> > won't get a large initcwnd towards a poor connection.
>
> initcwnd is set globally or on a per route basis.

With TCP_BPF_IW the world is your oyster.

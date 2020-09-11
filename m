Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C81265B14
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKIFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgIKIFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 04:05:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126BAC061573
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 01:05:43 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so8598914oif.13
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skaKVZKdB1bdH+H2I7ljXdzwzvi2envl57NAkGAzg3A=;
        b=KWwERfqo48Ec4RU1zZlvBBjXoigCgRdvlAUpW6w57ELTPj0YVThRq3DW0RgjFxyM+O
         vq0IO7FcQPUKpvcZIc7RuSfiGz3ADKlmYxnuITSCJ2Ec2KYUHKRHLkglDIVsGJv4yA3u
         bqzE30mTx3O8X5yevrPulqBLlZncWnLRgMZB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skaKVZKdB1bdH+H2I7ljXdzwzvi2envl57NAkGAzg3A=;
        b=q1CgyVn4qft9m7FMsxDTFlauON5UJqRz8T6LxjHH9E/UfeV8rgIwVm6lqQRZe9T3l3
         d8QC6u/hQg9XAFNWC5hFn1f3JpFowwuWPKe97wA4ny9B02QMGsWigUmvLlFSinB1y8jf
         Z38kGtCmhrDfOsYClxMMwwhAPAJLbS0RcFYw0dkkRgELUC3BckD++ntkNBIQnZ7Sgu9H
         im3mbbbY7tZwltu0QVR9VcGM4XjxGQNSKTKc/8e1wki6PMDlcrS2IN+2qfRmxsvHDDQr
         dWB6Lje9+JiylCj0u7BnBIRq4D4zC3lU9lL0lQACCc+4w0RYeV/pik4JGRmPWnKe1w7p
         bA9w==
X-Gm-Message-State: AOAM532iTaMe/tRMLryzqbI3jQjRKVl/XnqjT75XcbrISnIAQD64sYhi
        vAMG2t475dRpn7S2gjO4e2nXVdvuOLm0dBZ4yNJxaw==
X-Google-Smtp-Source: ABdhPJwI5XG8chfPrJukQVpzRJXrk/3Sk3d2vBzAROzCX6cmZM4HwbfMtxCDEXVo3wPjssrYVV+GhzxUhc4NPuIzh6w=
X-Received: by 2002:aca:3087:: with SMTP id w129mr566088oiw.102.1599811542425;
 Fri, 11 Sep 2020 01:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200910110248.198326-1-lmb@cloudflare.com> <CAADnVQ+FuthVsgOGeSLA27js-JKi5-OvheQDuFN4cM3V-MpN1g@mail.gmail.com>
In-Reply-To: <CAADnVQ+FuthVsgOGeSLA27js-JKi5-OvheQDuFN4cM3V-MpN1g@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 11 Sep 2020 09:05:31 +0100
Message-ID: <CACAyw99=RgHKprsM-jNUCWhjBMCTDD_zmoGw4R3sS9Ry=S=Btg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: plug hole in struct bpf_sk_lookup_kern
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Sep 2020 at 01:53, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 10, 2020 at 4:03 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > As Alexei points out, struct bpf_sk_lookup_kern has two 4-byte holes.
> > This leads to suboptimal instructions being generated (IPv4, x86):
> >
> > Fix this by moving around sport and dport. pahole confirms there
> > are no more holes:
> >
> > Fixes: e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a dedicated attach point")
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>
> Applied to bpf-next.
> I feel it's a bit of a stretch to consider it a fix, but if you really
> insist I can let it go as a fix
> and reapply to a different tree. Just let me know.

Thanks, bpf-next is fine by me.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

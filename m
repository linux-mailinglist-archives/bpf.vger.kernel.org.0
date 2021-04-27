Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28636C899
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhD0PYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0PYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 11:24:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2316C061574;
        Tue, 27 Apr 2021 08:24:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2so1583992lft.4;
        Tue, 27 Apr 2021 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNaL2ah9NrBs3NDJvQ4orDYg/Cctii97cMTyLokVUCg=;
        b=Kd62gvXLZUR2IXlsCrX1HKZGYfrGx72EWmaB1FFh5h6NlYYZZ83k1vWhGN8xgbqKxd
         Rje0uad3OiRr22xFme2GDS7eyS58bRN1BJxnJMsz5ymZ+i726AIRgBCSj3NSQ6gDJv5f
         jL5dzh9hj/KKfsJs+tbHPjxCVilkQY/J4pHstHvchVp++BznEhgQYwWK2tN398cd5A2M
         vBq/OM9sleEDS09P9Cl+pV7yqP/dGbNMr/lWV2DS5IcfQJ4r/1IGJzDEYQh7xM8R5jG0
         9OKHwYVCUFL2+5azg6So7AapqhdaEEfGQlh1U+iJM5nHB1L4uVN4/8x4vZ2s1zY0RyVP
         wTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNaL2ah9NrBs3NDJvQ4orDYg/Cctii97cMTyLokVUCg=;
        b=rVnnFH/g/cRpr+eDC37TuuZBuKUmEHu+wpE+BQwzxLMAPcuYJM/lBq0uzpIjKLUtvp
         46W7WJwTJTzKFh/M+eUcuZXUyMpsI1hCzudM+fywS8+mifRitdRpxvc/1f0u4Mx+DzNq
         TG1MFyTqJbSYPHS5XZe64wTOKGRBglk9lFuBIziM/LknbFs506E87jM7327htjIJSIOP
         wWXezmEBUbvBjr1tkD5v0xiGktL+Q2hz6rgNFlOWO/MotztZ8c6e2yVwTAikLgiB8EFC
         1jHx+Sh8hV//2km2hJogr3Y50x9JQIKNt5ygit/8boW9kYPmAcO+IyB2NUUg+TEF+oxe
         II6g==
X-Gm-Message-State: AOAM5319aFTeXOvrdhNFfHST6KKjrPnE510MnyzoqgHjF9y3cUGD4yoy
        mUW4gG22WnwVsm+rpWDEbl5v7rpEWaliqTZyaP8=
X-Google-Smtp-Source: ABdhPJw14yxccZCo8NYGNc8jPl6BevtjVSDyr8P+MPJE0WXuVms8XC7tO81Hkf7WAUBK9rdTHBLpTqF64okpoePAdBk=
X-Received: by 2002:a19:f615:: with SMTP id x21mr17900348lfe.540.1619537040146;
 Tue, 27 Apr 2021 08:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210427112958.773132-1-revest@chromium.org> <CAADnVQJGMU2OAA4cRuD=LmfF3Wn5z0hqo1Uz9nx-K_KWuCA70A@mail.gmail.com>
 <CABRcYmLphttpFGdwq6YCboc_=dwkgpVAOf+Ni9NRiPioqRCokw@mail.gmail.com>
In-Reply-To: <CABRcYmLphttpFGdwq6YCboc_=dwkgpVAOf+Ni9NRiPioqRCokw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Apr 2021 08:23:48 -0700
Message-ID: <CAADnVQKimq9NGvpO3_Nrwa6YRHcPdXvtx5BHbvYsfHnW+wkgBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Lock bpf_trace_printk's tmp buf before it
 is written to
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 8:20 AM Florent Revest <revest@chromium.org> wrote:
>
> On Tue, Apr 27, 2021 at 5:08 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 4:30 AM Florent Revest <revest@chromium.org> wrote:
> > >
> > > bpf_trace_printk uses a shared static buffer to hold strings before they
> > > are printed. A recent refactoring moved the locking of that buffer after
> > > it gets filled by mistake.
> > >
> > > Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> > > Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> >
> > Applied.
>
> Thanks!
>
> > Pls send v2 of bstr_printf series as soon as possible. Thanks!
>
> Sure, I just assumed there would be more reviews on v1. The feedback
> I'll address is only about the commit description wording but I can
> send a v2 today.

Yes. Please.

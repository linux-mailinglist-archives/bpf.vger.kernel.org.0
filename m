Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB66467E5F
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382957AbhLCTli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382971AbhLCTlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:41:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7240C061354;
        Fri,  3 Dec 2021 11:38:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q17so2783895plr.11;
        Fri, 03 Dec 2021 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaob1hC85yrBoOkzQdzF9P6ft4AG93AaQ/ckI4/8U84=;
        b=JAQ/25NwWflPOlQtSCsgH+i4dZsdHopXbUC0YXfUOIYrUL/D8EeJUALEtECXrE4RTr
         dV9Gq7MSE6ui8sGHszraFzik/cYVewsA+5+notfQUW6XAOhEgttoO0vbXY+gewRfKZdJ
         xS+NNvxjLjc6f4DxHivRIco/TldqXOlfp6CXDjJmtzBQhMK3k2oCpO2YIWeAqgohpElU
         HijjoIX3D8NCYoP3aQdNE4qL13YITyr4uIwyruDpM6GaYpjwYx98umc93btsX7P0Pilj
         BSvehmGm8e5EH4ipAu5BiJ5XAc63qr0E6izJr/AYkOv4DKk8jpwE6c4WrRtYa9deD9vJ
         CFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaob1hC85yrBoOkzQdzF9P6ft4AG93AaQ/ckI4/8U84=;
        b=N0a6ewpiChvaAaPBNbUWjmhL4RZvAIeDmkThxoqpXTBElX2IevSSQ3fm8L8LziJCyj
         B0HP7q2uxkbGSQgEYHPFHoXDJ02ywefRsekhcXxwxHap3RpUOHg5rHg93fVW9eolUVK6
         t3/xt3XqRkN80dvEcaiOSyWkneCIw6rljdBM/6sO0jJ7sdq7Wt0gDyGXiiJ7T3O/ImAt
         bhM8+oI/DHnst+Ji+ZgcdXQZsY1GgXN5CLDHSH12VPTu/43j21JhOSGUXXZbMkSa3aPT
         OR222tRQyi+SJtmZr5GJX1nM2P/2sTAWVgWvb2TiF9DUBqkS+0MEaik4SHk4HtiKuzYl
         ECeg==
X-Gm-Message-State: AOAM5324TEYXxkckJg6T4Kw3CiIAiZLszHVO9TdLkqUogVELEBInnZg0
        sQFxjZNdaf6EyNRH9J7mBDkp2h3Nxaej+mNngSg=
X-Google-Smtp-Source: ABdhPJxuwTMQIG3LbU2/zVsBzt0OaA05gV2Zz0zlxbSsXuF0fUmCdxlM6nkUsXvudvkwLV6AtKjBMKG/SnlvoJtlFdI=
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id
 a8-20020a170902b58800b00143b7320834mr25289230pls.22.1638560287248; Fri, 03
 Dec 2021 11:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com> <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
In-Reply-To: <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 11:37:56 -0800
Message-ID: <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> > >
> > > From: Matteo Croce <mcroce@microsoft.com>
> > >
> > > This series add signature verification for BPF files.
> > > The first patch implements the signature validation in the kernel,
> > > the second patch optionally makes the signature mandatory,
> > > the third adds signature generation to bpftool.
> >
> > Matteo,
> >
> > I think I already mentioned that it's no-go as-is.
> > We've agreed to go with John's suggestion.
>
> Hi,
>
> my previous attempt was loading a whole ELF file and parsing it in kernel.
> In this series I just validate the instructions against a signature,
> as with kernel CO-RE libbpf doesn't need to mangle it.
>
> Which suggestion? I think I missed this one..

This talk and discussion:
https://linuxplumbersconf.org/event/11/contributions/947/

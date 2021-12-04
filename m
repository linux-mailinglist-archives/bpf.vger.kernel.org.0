Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD834681E6
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 03:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384039AbhLDCGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 21:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhLDCGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 21:06:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C92C061751;
        Fri,  3 Dec 2021 18:02:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o14so3295689plg.5;
        Fri, 03 Dec 2021 18:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dt/HhZYeQD2DFLA4IdY175U1ND++ujFbnP+5vOBlAA=;
        b=oMU49gcdvOygLCTTI6gpAwDkcix9DcSHa68rySpeANCNScTY4LuMUSOdjzMKSqXJMm
         /VU+XwE/YeYT7nuQf1SZWvINlgPBwndCcFAXjZMEFOxqnewOsRikwvecRqe20vTjOFTd
         PzDRL8Si8W6avEeiybuWxUYrIsVtIi6Ynm2k9Cl2JNzjluyM8GqXN1YH6qBi6TVxVsvy
         Okq3AmRWScnAxc8xIqAOd5I9cRnPcrsyhOg3GCrd1G7lmz/2+sk0H/DxKwSHUuNgXozY
         ERkBGO36yDMwj+4HQqvyH3UKvBnfvtfVsPBqz+rKAJfXWqVYBPZk5xbX4PPemzQ+627i
         1ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dt/HhZYeQD2DFLA4IdY175U1ND++ujFbnP+5vOBlAA=;
        b=3K71RtZ7Y8HZCOQcgFDpRp1xnFQezey3jCbbdWyzextXJNHO4BWjwrasvjEfno0dEu
         8zmt1f0QuzVsWaCqakUL8Q6+kb32M8h5Ukkf2SRS2/ZSTdsJKJo7i7N1RtYmVXLPRJ9n
         kmxdOunV3IM6kEe1fYAjLBeFrrYgv8+N49HNmLbxYU5hTpd99pKDr5PsdPfQ06sepDyy
         l+rc6NYMH9j44a+HBFxmJpGGc2SyA1zK0W6Oz++KrNeFHephXUOxD0Et7b92ikYcdNU8
         lApMFXxfplps6ECE99/MhXaWAXCbXJxZdlULr19v11oTMY5FJFlBw6H16Djlp7ZGEyzS
         d7Lg==
X-Gm-Message-State: AOAM531VtzsjKvhJWz+CxH3IJkHlJT/sda8Y7Ej+9VQACskUJGe/F/yq
        b9sCI+QQ4lqym8cNAhNbYnXHdEK31HLQHKbpfRY=
X-Google-Smtp-Source: ABdhPJyOnDkyHV7ofs6BxuWCzq095VA5AS4isx/p1BCSbvYO8OZef/xVLvN7N9eFsUeApSuCVgI2losG0qYZ1AW0a04=
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr19113499pjy.138.1638583374087;
 Fri, 03 Dec 2021 18:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
 <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
 <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com> <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
In-Reply-To: <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 18:02:43 -0800
Message-ID: <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Luca Boccassi <bluca@debian.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 4:42 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Fri, Dec 3, 2021 at 11:20 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 3, 2021 at 2:06 PM Luca Boccassi <bluca@debian.org> wrote:
> > >
> > > On Fri, 2021-12-03 at 11:37 -0800, Alexei Starovoitov wrote:
> > > > On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce
> > > > <mcroce@linux.microsoft.com> wrote:
> > > > >
> > > > > On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce
> > > > > > <mcroce@linux.microsoft.com> wrote:
> > > > > > >
> > > > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > > > >
> > > > > > > This series add signature verification for BPF files.
> > > > > > > The first patch implements the signature validation in the
> > > > > > > kernel,
> > > > > > > the second patch optionally makes the signature mandatory,
> > > > > > > the third adds signature generation to bpftool.
> > > > > >
> > > > > > Matteo,
> > > > > >
> > > > > > I think I already mentioned that it's no-go as-is.
> > > > > > We've agreed to go with John's suggestion.
> > > > >
> > > > > Hi,
> > > > >
> > > > > my previous attempt was loading a whole ELF file and parsing it in
> > > > > kernel.
> > > > > In this series I just validate the instructions against a
> > > > > signature,
> > > > > as with kernel CO-RE libbpf doesn't need to mangle it.
> > > > >
> > > > > Which suggestion? I think I missed this one..
> > > >
> > > > This talk and discussion:
> > > > https://linuxplumbersconf.org/event/11/contributions/947/
> > >
> > > Thanks for the link - but for those of us who don't have ~5 hours to
> > > watch a video recording, would you mind sharing a one line summary,
> > > please? Is there an alternative patch series implementing BPF signing
> > > that you can link us so that we can look at it? Just a link or
> > > googlable reference would be more than enough.
> >
> > It's not 5 hours and you have to read slides and watch
> > John's presentation to follow the conversation.
>
> So, If I have understood correctly, the proposal is to validate the
> tools which loads the BPF (e.g. perf, ip) with fs-verity, and only
> allow BPF loading from those validated binaries?
> That's nice, but I think that this could be complementary to the
> instructions signature.
> Imagine a validated binary being exploited somehow at runtime, that
> could be vector of malicious BPF program load.
> Can't we have both available, and use one or other, or even both
> together depending on the use case?

I'll let John comment.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE034815E7
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 18:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhL2RmK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhL2RmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Dec 2021 12:42:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2634C061574
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 09:42:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso20562414pjb.1
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 09:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh7choOI1bWOgMbvXSHdEOBwRldGyqh1gYG9bxi3RY8=;
        b=geQzihQ02F1NbWal7OrK9zDVlxW+75sx5JxYx5oqQ3fKroEZ/7VWCCykzvNWO91Q4O
         kV6+mkYj3gkvWH4qxS2PsdfZk8G4VkBB4L5/cz/h7lKVUqlKyLMuR+bSe9S+r4/eOmJG
         fwWmWl/mw9WIbpDwgv+bZEYWQnIgTNSs60/+JexnS7A4VfbvdsbIkrYtELwPfu2eVt2M
         J8P8RYi52k+Uho7RDcFuxbK3BzWSdLj2fz6B4fLOnODwgN+fu5CDCGd1RFxEOrp2jVLP
         xIgpguf9I30pCBBzjrQJuigF+n9AlYpcUxWW5AZwfVCVKXoPKp4WMGUJg35EJCmTIPeP
         x+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh7choOI1bWOgMbvXSHdEOBwRldGyqh1gYG9bxi3RY8=;
        b=2hm0k/rIPNcQuu9LTXfDGlqa+G+Jki2msw9Evlp61ZmOe+kTaDSvT9EEWMikhLHi7/
         kO3Syodyr1vOLxeg12lCnXt2LG8lTAYduoxtwkblwRoQYRJu8wOVj8XNiUesIbYQql6o
         tnR9l4X7chEeieLEVDpiE0f3hVcZFbIRO29IrSqM3WGi9eITF6Jkyq3JZoeZM5zcKE0g
         86oc6fUnhgrcTj0kKxgrCAH1fHNJiQT8UD48tNVyS6MMSK1wVfwScfHzOjzJwacnzqaB
         TETlerQhfDDoY7H7/Y3qUxyGVZ1PQ0Llj+7EBG9U5m0tS7kIXrVRhWFff4jMytkg8b0n
         /Hpg==
X-Gm-Message-State: AOAM532GPJgmulluSFI+57hGUwwjAavVTs9oM+tDYhfIqmpu1GZn3Qmi
        pXuOwqs+6ivMsNDbVKQnnU75z3GAQpzqkNYpyQ0=
X-Google-Smtp-Source: ABdhPJwS2y8mx5G5jD8Mw2Z7Y5lXzFqEQYtxTQAnSLpcJftd/AP9T1SzdMs1GtqevAyAlgh257sjPKICifuhJ+gS2wo=
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id
 f12-20020a170902860c00b00149101725f0mr27186132plo.116.1640799729328; Wed, 29
 Dec 2021 09:42:09 -0800 (PST)
MIME-Version: 1.0
References: <1640776802-22421-1-git-send-email-tcs.kernel@gmail.com> <1c8f6a26-658c-8986-2186-7e1868850cc2@fb.com>
In-Reply-To: <1c8f6a26-658c-8986-2186-7e1868850cc2@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Dec 2021 09:41:58 -0800
Message-ID: <CAADnVQLth6eh3UfdkHgKAX+UCTSyizw6OAc7-ZS0WEQgdj1b5g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Add missing map_get_next_key method to bloom
 filter map
To:     Joanne Koong <joannekoong@fb.com>
Cc:     tcs.kernel@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Haimin Zhang <tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 29, 2021 at 9:22 AM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 12/29/21 3:20 AM, tcs.kernel@gmail.com wrote:
>
> > From: Haimin Zhang <tcs_kernel@tencent.com>
> >
> > Without it, kernel crashes in map_get_next_key().
> >
> > Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
> >
> > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Haimin,

Daniel didn't give you his SOB in v1 patch, so I've dropped it
while applying.


> > ---
>
> Thanks for fixing this. I'll take a look at the other bpf_map_ops and see if
> there are other missing ones.
>
> Acked-by: Joanne Koong <joannekoong@fb.com>


Thanks everyone.

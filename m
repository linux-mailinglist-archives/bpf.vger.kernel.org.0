Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF74F2A50D8
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 21:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKCU2a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 15:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgKCU2a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 15:28:30 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CBEC0617A6
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 12:28:29 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o13so12190641ljj.11
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU40kR5HcxrCIMrQq1e+LANf73GOnwaiJ4pksrxcvYU=;
        b=hOjYAUZNJSYSRMX840dgVH2+0EeqOmzdNHXYtvBtMdFPKamlSY3NtNIJI4bDPGpQ8D
         h0iLkBTmcQahnrj/1pEiixAK/pvyy3OKwOKb9uCBUDb6LmR82IqnyYRORA4lK6RdHRQB
         JsbUvxLbjVs4+G2BB7YZLfKVXQGcHb+QRtyxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU40kR5HcxrCIMrQq1e+LANf73GOnwaiJ4pksrxcvYU=;
        b=NjIwbZ6jTx/33xBrylPZ0C8nkERxkxFmJaPAzomUA9vZTCn885i1bcODFZbpLf47x0
         /a46mQHCgX7S61iHa2c9+LqRO5tsxe/PtJJEzT4SMd/sbQwXVcNvX6kji4qpRGxnJaaU
         /BKiSPKw8kG+C2meQVa8zGmkAmMiPgPmNUOpJueI7GxDvIdstyToYb6AmrdBkxqMsQdo
         dIwokdMneSFQuDW491kf5QhnFa84T92Sh8LOD9ET9z9TZ2eivdZDQw9VU5wsaF+jBUM5
         jaEgaC3aqPlZk1BEoXbBA9IXEq/o4GfOAt37KlmP+COzUbJyEVT3GT1XlAOfbJ9hD4/d
         FoUA==
X-Gm-Message-State: AOAM533J8DF1MmbKVcOySjan3WsknlEQxsnOh/Ir5+Y+0BhHeeuI/vQP
        qHvlVxK/ukVGqUn2P2G/tqLiwKa4wACw2KS8B3bg8g==
X-Google-Smtp-Source: ABdhPJzOQKNBKOTt8A6R9djuhirhayRnPtb8aWN7s9Vp0KTZh/eX6MR8kXGFwcmSDC+zBsXdSywUAOIIum4FQY+RJMI=
X-Received: by 2002:a2e:3c07:: with SMTP id j7mr4478439lja.83.1604435307622;
 Tue, 03 Nov 2020 12:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-3-kpsingh@chromium.org> <CAEf4Bza=80OMCBMLJJa5Vu1qokwzCtePcu4arruXUi8jHK8eWw@mail.gmail.com>
In-Reply-To: <CAEf4Bza=80OMCBMLJJa5Vu1qokwzCtePcu4arruXUi8jHK8eWw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 21:28:16 +0100
Message-ID: <CACYkzJ4HC8vaNjbtC8r2n_-3jLyHYP5-_CAVCPXSsCdZAviepw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/8] libbpf: Add support for task local storage
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 8:28 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 3, 2020 at 7:34 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/lib/bpf/libbpf_probes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > index 5482a9b7ae2d..bed00ca194f0 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  /* Copyright (c) 2019 Netronome Systems, Inc. */
> >
> > +#include "linux/bpf.h"
>
> why "", not <>?

I need to disable this vscode feature where it tries to be oversmart
and adds includes. Fixed.

- KP

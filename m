Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A885390A47
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 22:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhEYUFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhEYUFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 16:05:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E56C061574
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 13:04:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b81so11094454iof.2
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHa/jxf5ff+nHL/HwGVIpDxyxV41oUcj3iWDlxx7pRk=;
        b=I3d89PmSYtAAmPdU4bYuuICwd51StJRpwGaGZM5j0MPCjYFxuA6KINZq2/qzt7J4rF
         oEafMbx80NTxz6DzoGZ5vzJhjLTnJrv0LxpzcGDsGKQzAPvIu4be39dXnzUxM18gDITV
         EWdnOICM7SBsjxTA0aNsqqY4lP0Q2GGT46PQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHa/jxf5ff+nHL/HwGVIpDxyxV41oUcj3iWDlxx7pRk=;
        b=p8Yh0r9HUq99JEANZKXnGnGLaswLKwag91saZPOspBiqpt3SV5dqNIgPivu8HESfHX
         fY76dp1hC9UV7PAeg/VWpNaFAU/Q0iOJrLebE87TsjJbaX7raX0ZdcVj7lu35Ljba0iW
         74ZwfhdlXQ0AaCbGk80PK4DEln2wMNFMt/0yWnkj6digj3EszCwmvSai1qyKAxdZXv5I
         B/wkxKAKDK9H/EkafL3GuPw3Nnfh1NG/0fYDxBi4H4Ucz4Y/j+VqyC449lU1XqSALhwE
         asntnvPVRR33H0ST5fg3BMkRTTNjbU4rCHv62vOsuoMmr+hSTFV+5FtPLyHpmYKfVsJs
         BFqA==
X-Gm-Message-State: AOAM533eI6INSbB5kln23d8ZhoYnOTfuOL87BhKBuBoeenQ9bYO+vfxg
        AIeZbEfW5SYuPUeYOYu13DRm770iUt5pR+xDo31hCWQRSV2wYg==
X-Google-Smtp-Source: ABdhPJy3QhgMgsWlXogc866Fmq75XIDGlvh7LZ7Gyq9bY4J2KUcupEDm/5ORfhwskrxUR0LgDB+PVTF6FXqUzMIEOLY=
X-Received: by 2002:a6b:e91a:: with SMTP id u26mr23484337iof.83.1621973062946;
 Tue, 25 May 2021 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210525113732.2648158-1-revest@chromium.org> <CAEf4BzYPbKYB4ky-A9x85OiMTrexV7oRkZ1rzNUErqz9nWNfLQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYPbKYB4ky-A9x85OiMTrexV7oRkZ1rzNUErqz9nWNfLQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 25 May 2021 22:04:12 +0200
Message-ID: <CABRcYmKv92Ko6rhjNcUG4sjkMQR+tEtxbTfTVGYL4JdKHCeYYA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 25, 2021 at 9:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 4:38 AM Florent Revest <revest@chromium.org> wrote:
> > +#define ___bpf_concat(a, b) a ## b
> > +#define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
> > +#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
> > +#define ___bpf_narg(...) \
> > +       ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
>
> wouldn't this conflict if both bpf_tracing.h and bpf_helpers.h are
> included in the same file?

Oh, yeah, somehow I thought that double macro definitions wouldn't
generate warnings but it would, indeed. Silly me :)

> We can probably guard this block with
> custom #ifdef both in bpf_helpers.h and bpf_tracing.h to avoid
> dependency on order of includes?

Indeed, I think the cleanest would be:
#ifndef ___bpf_concat
#define ___bpf_concat(a, b) a ## b
#endif
#ifndef ___bpf_apply
 etc...

I'm sending a v2.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E0253B57
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 03:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgH0BYV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 21:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgH0BYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 21:24:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E1C0617A4
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:24:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so4524011ljg.13
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaAhVe9NZ1R5g2YS2CTJE0/6e8EYtB7aMqdHknvKesA=;
        b=SJwPhgwUnUn2mBarnoa9bYz42e0tKRZQflSAKfXVW+1WuaJWh+0RePI1uNHutnyd2A
         YtVQxlK3Ffu4N1UF5nmbSAY8tUkVP/fRLD1G6u72jYG2ksFuQncrACVRRuOt6NpKvUPv
         fFXWzySHC85dONXfxUUAVinyHVrTxzc1msjDoirhDLNmiEGqoml2RaLfP/5L37cUSmEF
         2x+SKK69lCzSR0Uv2KNHpby9FLNCjb7H8RSlrh0dQvGgW+FHpK2t/Ozqil8Gfn1CgePU
         jjPFsyRGDg6X5bOe51QDiLaAWrD4UjhlZUsnCBSu2IvNakzMXZJxI7xDxSFVtk9hclHh
         Ey+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaAhVe9NZ1R5g2YS2CTJE0/6e8EYtB7aMqdHknvKesA=;
        b=mpZjCcdnJpgTHIwpOUJXDV+0axZ4thmIl5mWVdhzEAbcv+bpAN7cV+d9ldJQhwGDo5
         j17PDoxuM8YNFGBbS9RD7HQpAZR828PgO1mDBcQxRgGijG8bk60qfLGCXvlwcxqu+iyV
         dxI8hGTgIbLVVIt7jaLlfBmfvvjA1JJLeWyaUlQnm0u5BFDZRXq1OeY9ZNFCD8WTfgAO
         9VmT4Mv0fpclBGt9QD2Vyp3Shqz9gW5RxMn3qKN1bSeFig5yoe+15v2mw9e//Fv0xHcV
         YitMZ3kavVQF+jdkDj4fkMV00Hv2bHYTh1PrJ2HWpIVkN4npRuUqUXrdi9EC1mMxhsZ/
         LnvQ==
X-Gm-Message-State: AOAM530Xjw2pi/VoO2lh9Fq+0CfKkEm5QdvaP4PkRl5uJZz86Lf87RMY
        EgsIETdWjPGEpIIG3uHzf9BwJhADW3uS04jlbLo1kliaAi0=
X-Google-Smtp-Source: ABdhPJxgDGcNP9DxOQTWxsXv8cwD05YmMvT1hmUzl2euif9r0/9glXhCkah+fd374MAxguSaIYX9w6tni5KTkeihFKQ=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr7665336ljf.58.1598491458086;
 Wed, 26 Aug 2020 18:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-6-guro@fb.com>
In-Reply-To: <20200821150134.2581465-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:24:07 -0700
Message-ID: <CALvZod5Fb50fVSC9XaYyQ3awjYU8sc4-VYh66z4U__v5Pfxd8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/30] bpf: refine memcg-based memory
 accounting for cpumap maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 8:11 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include metadata and percpu data into the memcg-based memory accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

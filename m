Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E13156AE
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 20:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBITSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 14:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhBITQI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 14:16:08 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA385C061793
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:15:15 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id l8so6913141ybe.12
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTRqMOi3xvRmVts20nDIEkhAay9Da1AMjK23W6n1C2c=;
        b=jQPfV6Fxl9UGWqUyC8NBtyhqNMDeNLD9ipBim+HijpHiwokzUSmPnTDsCzJOJMJwGy
         M2vN8sdjyvMp8MLFgn4J+OU20bKe1h7mMIAugQ6TXCV96XnMmKgAn7vwf5ggwVGdWg2s
         KOZOGNgrZOs2j5UYANPTX5wjQG+NkKe14EOjDAknEvWIeG2GBANX7Q6epZ05IOcrE6oi
         4+j961S5kjpNEfmDeMj8VIzXS0nJ+PilyQqKN/jVBBkAY5zT8vD1rOaMRVJMDfWqwndS
         pHVF32RVhhfn3oHoNjU941ht0RHaLmwNrtYhuQLHLxCIba+RT198nGksK/xpUiovzt+V
         26Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTRqMOi3xvRmVts20nDIEkhAay9Da1AMjK23W6n1C2c=;
        b=Xhzx1tVDeQcWYNecYdzUwAqisWYudzh/BOs4/7sfhzx8ysQIhY5DncRQAltzNZTqu5
         7irhmlnlWv6tEvizbho2FrtLv9VEXnLKihyXcwe7APkPpaDtsgQuoER3FamtkjbzeHiH
         SZ91pwY2Q5HP46lSONrVrFxKzUyjaKRMSwVF8KK9kht/zFGNmOeegBI4NHnyKcLjNcf0
         NHkVGDym5cOnGF2d0HSu3OKx0WxuJ4yTYRWvqOWRCHnDiDOEEAlM9hUrS7iVMsWQiFrl
         GGAh+hD+0rymCx+habv651NINK0KZsgnMFdgWKXGuLX90p31qNXCLP0POxp7B0xw6ezI
         ex0A==
X-Gm-Message-State: AOAM530+/NMrHHYTWw+Vw4vZQlTuGVlQSUZce2sljsY8pY8rnIMAxkHd
        xb75MFOzgMGNmExUtKPG5XgZWoVEVDP1ZqyEjEI=
X-Google-Smtp-Source: ABdhPJyYDGULsQKfVjvpur4zPiImOHD9UNhbszwNZklREvcPQpyoY4aRTohy17Q8coAPhiMBEwM0nhRQ2lZTzTvEpI4=
X-Received: by 2002:a25:c905:: with SMTP id z5mr35271415ybf.260.1612898114961;
 Tue, 09 Feb 2021 11:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-4-alexei.starovoitov@gmail.com> <CAEf4Bzb1D9AzOU2Zn2DkZrP+VYOPuJ-7xFcEF1unTr6SutMSWg@mail.gmail.com>
 <6757a479-cb35-ac3d-9978-71f1c4daf4a9@fb.com>
In-Reply-To: <6757a479-cb35-ac3d-9978-71f1c4daf4a9@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Feb 2021 11:15:04 -0800
Message-ID: <CAEf4BzZzRFvUvSbcyvYd7LPzqPUqt6NUDORdMZ_zZDNymhEdTw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Add per-program recursion prevention mechanism
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 11:06 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 2/8/21 12:51 PM, Andrii Nakryiko wrote:
> >>                  start = sched_clock();
> >> +               if (unlikely(!start))
> >> +                       start = NO_START_TIME;
> >> +       }
> >>          return start;
> >
> >
> > Oh, and actually, given you have `start > NO_START_TIME` condition in
> > exit function, you don't need this `if (unlikely(!start))` bit at all,
> > because you are going to ignore both 0 and 1. So maybe no need for a
> > new function, but no need for extra if as well.
>
> This unlikely(!start) is needed for very unlikely case when
> sched_clock() returns 0. In such case the prog should still be executed.
>

oh, right, I forgot we now skip execution when start == 0. Then I
guess the point of a helper function stands.
>
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09866270AD7
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 07:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgISF1b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Sep 2020 01:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgISF1a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Sep 2020 01:27:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEDFC0613CF
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2020 22:27:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so4071876plt.9
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2020 22:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMSzGfjGixHCKv2aYBC0APFqGV0E9fiwwPB5IqJ32Q4=;
        b=PtdpD6dXrKk3CXd3giAhaYLL1FTY31noSFL7KYqO7izJK+t+FjmHlW02sGTXtsLogm
         QQr3bMrOz7nA3Fi9hpHgY9ArYA0VOdQL8ztx2SQMXdKMohXjaC/gydHhkmWHIICbtBCG
         LvCsMcdFsLX3ZwEIJL+JDvsfWxUzt+enC/tspFwc/Qjeh5mp6TwmXy60W3umVvMWS5zr
         zH6Do9h0bO84P+vSwGN8tCQTEvl6FvuRqyrg5FqexNJuIxAjTcnLr657gFNdLmPvqkt/
         PWG/TJtivvjgRCFYgh6ip4TaeiHre6alAdvCbzjBJpaONUIK/asS24RDqDMySsIuYe5c
         DaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMSzGfjGixHCKv2aYBC0APFqGV0E9fiwwPB5IqJ32Q4=;
        b=tm4lyO5ubexmf5sCcE1bo70/FbEub6p89UN8+L62oHoqiz1AILsI7oYQv57QNAJJrF
         oTTEJjzBrIyQKQmYOPSGlFtaFraK9Cjq1FbYlWShMqERSc2uS5nOOEBagV+r0PKdfYTj
         U9ugS+Pt9iUem3qwGnsraHyuPwX6wnm6uSue/lcFoz0D399kkVAvBx9fo15PZhMa+HtH
         nXxQpZRhEiQAUgTzN9qcdUTOQS8ccxTlbB8tSIkXjZ7w/RnrxAF9brA+xaNOV7rw6Z8w
         6PvdA4dBBHZsqHcmCWzuBN9xoNUglqoEeCNIAnhQybpYsK4lbRIS35MIjlvXCzFGmEm/
         hSGw==
X-Gm-Message-State: AOAM533x31SjlVCiqTz8Rz4kq5iPPef69dlF3HQwsi2tz96tUALH+5Ns
        DCicjc3XDpplfn3TLT5jWddeG7ONCKmSYdqn6car2g==
X-Google-Smtp-Source: ABdhPJyF1TJLjCU3zrC+qxcmSiS5HC4qECD/KEf7+HRA6aBzkt0LjqanwCxz+DfrCEjuA94/VLDpDyHYefUZNiuJrGI=
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr16049904pjr.13.1600493250327;
 Fri, 18 Sep 2020 22:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200917074453.20621-1-songmuchun@bytedance.com> <CAPhsuW7W0Cm_eyEY8pDGwMqo8pM3OWAUYUu8PyUqcUxPGLX3DA@mail.gmail.com>
In-Reply-To: <CAPhsuW7W0Cm_eyEY8pDGwMqo8pM3OWAUYUu8PyUqcUxPGLX3DA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 19 Sep 2020 13:26:53 +0800
Message-ID: <CAMZfGtWVgZ9CojskbN5bnex-z4=NLux0BrODVk6eG+=kfYjfBw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] bpf: Fix potential call
 bpf_link_free() in atomic context
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 18, 2020 at 6:37 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Sep 17, 2020 at 12:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The in_atomic macro cannot always detect atomic context. In particular,
> > it cannot know about held spinlocks in non-preemptible kernels. Although,
> > there is no user call bpf_link_put() with holding spinlock now. Be the
> > safe side, we can avoid this in the feature.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> This is a little weird, but I guess that is OK, as bpf_link_put() is
> not in the critical

Yeah, bpf_link_put() is OK now because there is no user call it
with a holding spinlock.

> path. Is the plan to eliminate in_atomic() (as much as possible)?

Most other users of in_atomic() just for WARN_ON. It seems
there is no problem :).





--
Yours,
Muchun

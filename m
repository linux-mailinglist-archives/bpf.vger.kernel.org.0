Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA18391374
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhEZJOw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 05:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhEZJOw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 05:14:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E0CC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 02:13:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b12so714480ljp.1
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RiBaLo8QXlyg99BwaibB32nsyM/aqFSZflQCs8lbDk=;
        b=N/wIkoWwz1nCryBTHCwA8KB93EL8abG7Bv1nOsO0APplbZZOJy0kji3EYijiieWeHT
         moxyIJGbrBt0qz7YIG5fp1jMP42MKGO9cDmiP22bvl/vivBGHHjh/HbHQgN+UnLoqkIU
         k8JJNkq0O8zylZilFfFDP7epwXRsThRJ31C7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RiBaLo8QXlyg99BwaibB32nsyM/aqFSZflQCs8lbDk=;
        b=ro0y919G0HdzJTfz5x5du4kryJAwBM/9Ai+PTBly/WtMf14g29mblML06lsLdkVy6/
         +dCpNdBI3dsD1TQNmeUrZOStR66shkXtBayaEyczx80ZqxPxdIigS/kfY5trlfGCy4LV
         wwDFv32f0pp5TPmms19Z0rfGA1pXbFTxjG6JFLTPEfVZu8OldR3kSefUOHUxBHvzU29D
         sEDWQDYp2/8r+1FWgBvpWRU/8Wur+3CPi8TvQdSZQYwdw6vc87GyUVM+fZjXzdYThg2y
         Dik+dObaB1nYEJhLd0muYpJpvTctEpQrYSwC0EZzKBzGUODZDRVu1bsgi/ecmT0cvwqs
         Oi7A==
X-Gm-Message-State: AOAM531eNmZKSwTIXpejb+6vJCEA0zYTL+SpCFOcv70Ge9DuA0pl0Nxx
        wVJ3Sq76vCvfO/0j/kanuwwPTDJwG1DWFF64CP9RHg==
X-Google-Smtp-Source: ABdhPJy9WKA7uJJ3CzBoGTDz2is3UZJsWKrLwdGAAe+6XSsi/8yP8U1a2YFwIydMoOC9PM9TVqxRUac+4HCOets3jz8=
X-Received: by 2002:a2e:8512:: with SMTP id j18mr1530777lji.196.1622020399409;
 Wed, 26 May 2021 02:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 May 2021 10:13:08 +0100
Message-ID: <CACAyw99QydcWBeE3T_4g5QzuDyfb_MEpR1V0EzEwbY=R-s202w@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 24 May 2021 at 18:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> If there are enums/types/fields that we can use to reliably detect the
> platform, then yes, we can have a new set of helpers that would do
> this with CO-RE. Someone will need to investigate how to do that for
> all the platforms we have. It's all about finding something that's
> already in the kernel and can server as a reliably indicator of a
> target architecture.

Can you explain a bit more how this would work? Seems like leg work I could do.

> Well, obviously I'm not a fan of even more magic #defines. But I think
> we can achieve a similar effect with a more "lazy" approach. I.e., if
> user tries to use PT_REGS_xxx macros but doesn't specify the platform
> -- only then it gets compilation errors. There is stuff in
> bpf_tracing.h that doesn't need pt_regs, so we can't just outright do
> #error unconditinally. But we can do something like this:
>
> #else /* !bpf_target_defined */
>
> #define PT_REGS_PARM1(x) _Pragma("GCC error \"blah blah something
> user-facing\"")
>
> ... and so on for all macros
>
> #endif
>
> Thoughts?

That would work for me, but it would change the behaviour for current
users of the header, no? That's why I added the magic define in the
first place.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3440BC33
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 01:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhINXdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhINXdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 19:33:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D92C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 16:32:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c206so1667364ybb.12
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kON7sJv4Cf6HzD0RQzHDJdXbRd58LyswWqP+XaKeAFQ=;
        b=Rk3I/kLlorYgcP1f0qWttj9cfl35aMIvXkHfhYAZhj8r2cjB9HvN+9NfhsU1rFevdU
         fvMQb+IJiVY62xgI2LHfLviVJmY5QuYzj09QsDMEjCfJ/5XjutHr5ZizURnZLNVSIdTa
         M5QyOtF2uPUhQwlHcx+dxIoFXCmAaKLGYcq0PjBDMT541F8rXLjUbmGX/pfg4B2bzzaM
         ZRZSNGUmP4Q5eJHJbddyRHX3rc0y6aqsgu8m/DaCXxsPffrmsJqYp2R8Xsq8OLqKKEJ7
         JmwJ7DZ1gQg79zaAC+dMzSq+T2ic8xhNIQbmWOM0aJXRbKUg57cqGL+OlP2oK7WpvqMw
         u3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kON7sJv4Cf6HzD0RQzHDJdXbRd58LyswWqP+XaKeAFQ=;
        b=NEYUYPQUggX2UU3nVGX20ku/FGJd4Y0CBRiusS/HmRyLh6Fiv5YymAz9b3BnhMO4nU
         j/cWfAlw9/aXWqN6uEOfNtzxpD8cg5USx6wBCJP6+0NavJt7csMbP1Ol5MtKiRyr2OvD
         06IIQbgg+WnYfcTh5rYyWy0hO0F7YpWZU2V3195W+wHoCfedlBS/x00+yF+KSCt6IsgM
         jwx+k2DRaB+aALlEnHr5BKCuU1MrtI/I/nqK75D6qAU9ZxfeK+oMK7luDydNjcaRZg1l
         THfQhvHXM8xTJvi0Ew+Wz2mH2rjQcA/1RUCMgA380R1CacDzsErcN17v+EVSJG6nZinJ
         wt6Q==
X-Gm-Message-State: AOAM533JX/x/+oPYQBtfXnt0xTabq53QUBju99Z3SJXQE7ArnWvv/HTs
        /xCvxjaBzPiHI7zjd2ZADnQQQqdJ7k3WuqCzgYJs062q
X-Google-Smtp-Source: ABdhPJxbtfC08tmZv+BKavAfTUryTGTRlWldzKzdye9X03gXfMk1JSuOFg6BYuK0LJDWWckce2Xn58+6guKzi1/VIn0=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr2193827ybb.267.1631662321336;
 Tue, 14 Sep 2021 16:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155211.3728854-1-yhs@fb.com>
 <CAEf4BzZoWe33fXy0BBz9zzju3dKUeBL25230_yBp-W38VWAnNQ@mail.gmail.com> <0031e9f3-6b01-373e-3b0e-2efdb6bd4ea9@fb.com>
In-Reply-To: <0031e9f3-6b01-373e-3b0e-2efdb6bd4ea9@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 16:31:50 -0700
Message-ID: <CAEf4BzZv-yw2kPGtJFTraJEXxaYsYcj_bxG0ZvKof1_MUnQ6vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: test BTF_KIND_TAG for deduplication
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 12:39 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/13/21 10:38 PM, Andrii Nakryiko wrote:
> > On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Add unit tests for BTF_KIND_TAG deduplication for
> >>    - struct and struct member
> >>    - variable
> >>    - func and func argument
> >>
> >
> > Can you please also add tests where you have duplicated struct,
> > variable, and func (three different tests), and each copy has two
>
> currently, variable won't be deduplicated so I will skip variable
> and add tests for func/argument and struct/member.

oh, right, yeap, it makes sense only for struct/union and func

>
> > tags: one with common value (e.g., common_val) and one with unique
> > value (uniq_val1 and uniq_val2, one for each copy of a
> > struct/var/func). End result should be a single struct/var/func with
> > three different tags pointing to it (e.g., common_val, uniq_val1,
> > uniq_val2). I.e., those tags are "inherited" by the deduplicated
> > entity and only a unique set of them is left.
> >
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/testing/selftests/bpf/prog_tests/btf.c | 91 ++++++++++++++++----
> >>   1 file changed, 74 insertions(+), 17 deletions(-)
> >>
> >
> > [...]
> >

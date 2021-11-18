Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70B45642C
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 21:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhKRUc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 15:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhKRUc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 15:32:58 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF90C06173E
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:29:57 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v23so9734381iom.12
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYt9/X+O3xwYmGyId9geOmyLFTgYSAl9UI0lqAAeF2k=;
        b=m5TEvsbxfBqQIb4tuD1f9/ZQ/7VmLTi9LbQFAllDlm/owT7miVsSXeVo64hP8FIeQR
         V5NxSG79XVDiOF7sAjpdDapSyAMaEx/jt78R+foIWa/b24yKfPQYs4Xe9IFMoefi4h/u
         VlTqhy3XhsWa3G1brbYr2E7mlv0o4cFLqsrhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYt9/X+O3xwYmGyId9geOmyLFTgYSAl9UI0lqAAeF2k=;
        b=BRN8BmGemyK6s0xY9iqNGCnl4TO5PwJH4c9uE6IS5LK1GD7hkqnjWGxzfuK/mtk7aM
         uYI64iFRALL8p7sGJM9jcyd39ASCQXjnnF0YoDpasum6l8pKd/4KzXSpG/n842Upl3ai
         LNCs+xeSJUK9ccoEnDabr+7ques2RaoxaUcHvzIjtCOJrnz4VtC8nyDh091hgxDwkCVV
         qAfQwOfOKN2q9/YZ47tDa8KfFKXOFCjKbefirspuN2Rd8eKHM9XNiNf/XuF90b78pOH5
         XzktpO/5V7ouj48K4C/asB12MwC10ZCXnim11BlvxvOYtaR5EfrLzOexikKEGVYbgc7T
         6Hrg==
X-Gm-Message-State: AOAM53001wPSAaFDSk7ogq2keRSMSeQZY5u1dt0opBaBH314MCbt78Vu
        AhHr+sUx6qzTw9LyZYHK+Eu2OmoEWkScWMrRDvt7Ig==
X-Google-Smtp-Source: ABdhPJzqpDhtem1HFVcS+EX78SHgn/oe6Rjax3EXhJ9Dq0IVlb5JcMUMdq2kJKmgClqwuZFcoVM4tRItcT5u/xOKfwc=
X-Received: by 2002:a02:864b:: with SMTP id e69mr22200390jai.9.1637267397355;
 Thu, 18 Nov 2021 12:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20211118103335.1208372-1-revest@chromium.org> <CAEf4BzY5JXvWSTdyyPRoTdqupsnxiRf622sGTzsOPhr4WVMNBA@mail.gmail.com>
In-Reply-To: <CAEf4BzY5JXvWSTdyyPRoTdqupsnxiRf622sGTzsOPhr4WVMNBA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 18 Nov 2021 21:29:46 +0100
Message-ID: <CABRcYmLfbHSU9of5x+sdor6WxkFXfWiJpJiwgjVur1Hps0TtPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add ability to clear per-program load flags
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 6:49 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 18, 2021 at 2:33 AM Florent Revest <revest@chromium.org> wrote:
> >
> > We have a use-case where we construct a skeleton with a sleepable
> > program and if it fails to load then we want to make it non-sleepable by
> > clearing BPF_F_SLEEPABLE.
>
> I'd say the better way to do this is to have two programs (that share
> the logic, of course) and pick one or another at runtime:
>
> static int whatever_logic(bool sleepable) { ... }
>
> SEC("fentry.s/whatever")
> int BPF_PROG(whatever_sleepable, ...)
> {
>     return whatever_logic(true);
> }
>
> SEC("fentry/whatever")
> int BPF_PROG(whatever_nonsleepable, ...)
> {
>     return whatever_logic(false);
> }
>
>
> Then at runtime you can bpf_program__autoload(..., false) for a
> variant you don't want to load.

Ah cool, thanks! That's a good idea :) it will also look cleaner.

> This clear_flags business seems too low-level and too limited. Next
> thing we'll be adding a few more bit manipulation variants (e.g, reset
> flags). Let's see how far you can get with the use of existing
> features. I'd set_extra_flags() to be almost never used, btw. And they
> shouldn't, if can be avoided. So I'm hesitant to keep extending
> operations around prog_flags.

I agree

> But given we just added set_extra_flags() and it's already too
> limiting, let's change set_extra flags to just set_flags() that will
> override the flags with whatever user provides. Then with
> bpf_program__flags() and bpf_program__set_flags() you can express
> whatever you want without adding extra APIs. Care to fix that?

Sure, I'll send a patch for this! :)

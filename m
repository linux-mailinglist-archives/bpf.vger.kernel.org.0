Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9809315A38
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhBIXro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 18:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233637AbhBIX05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 18:26:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A816764E58
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 23:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612912688;
        bh=IQVMBwRRYltHyfCyvHJA8tP4vlYOKBDa8u9YKbUoSbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+LTuAYNTzIWk1BW6SMu+neIM11yHixnKUR4zALuSaTBVq7N15hM+XggrE5TNvA68
         MO8/4m6HO8VnmZQ+aerCM16V5PTDBXa38CdjUigAVMcEYPwLr7s2jwWfTmT4Ar5f67
         VrOhMris5+UtL4tcZV8f1pWn0GQmjJGiBULB5flN87xi9GfLYKPpltPd2K4b4WC2H/
         0xU1vREYt8vwCBA6mFMPRIKzQ09FjAoMQumsKJXsoD6sSZWQbhitLpPi7zrz+svVRf
         SfrWZe8NCe2nXZk9y8DlJr7b4CfhHS8Xm6j0v/r2ELa0lX2L+p7HtBt12aVWuO96j/
         JLZA2GEo1SJyQ==
Received: by mail-lj1-f181.google.com with SMTP id f2so368790ljp.11
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 15:18:07 -0800 (PST)
X-Gm-Message-State: AOAM532HaKtSnzv5YiOY/aHCVnoQpz8F9wxZrV90GYTEawO5q0Ycj50i
        oJrvEEwKwbAvezbwSvTnVCce7B7A7BTcXIrX3mlB/w==
X-Google-Smtp-Source: ABdhPJx0FE7vZWfXrS1ig7SjD7GcW5IIqDjCMoZcdPNm3gZSQn5JYieEa2pSo6HYLYnYwStibJPPO55o2f2gQ1zMDgY=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr95515ljp.187.1612912685764;
 Tue, 09 Feb 2021 15:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
 <20210209194856.24269-3-alexei.starovoitov@gmail.com> <CACYkzJ4skw5x=i-bqWXmo9sH-k=5jQXZ1Jir7hvY_se9fFxOSg@mail.gmail.com>
 <b7a0125c-79e7-4d3b-12a3-86fe910bd01e@fb.com>
In-Reply-To: <b7a0125c-79e7-4d3b-12a3-86fe910bd01e@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 10 Feb 2021 00:17:55 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7nqufL94w1+bvh6HuUszU+KNojbiTAyrJ8mK5VTnrvMg@mail.gmail.com>
Message-ID: <CACYkzJ7nqufL94w1+bvh6HuUszU+KNojbiTAyrJ8mK5VTnrvMg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/8] bpf: Compute program stats for sleepable programs
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 12:11 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 2/9/21 2:47 PM, KP Singh wrote:
> > On Tue, Feb 9, 2021 at 10:01 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> In older non-RT kernels migrate_disable() was the same as preempt_disable().
> >> Since commit 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")
> >
> > nit: It would be nice to split out the bit that adds
> > migrate_disbale/enable into a separate patch
> > just to make it more explicit.
>
> Not following. What is the point of splitting it?
> Just adding it without using it for anything?
> That's a bit weird.
> How would it help anything?

The reason why I mentioned this is because you refer to this in the other patch:

https://lore.kernel.org/bpf/20210206170344.78399-1-alexei.starovoitov@gmail.com/T/#m24cdc785b71adc04ac665fe018956c4f25ca06ae

"Since sleepable programs are now executing under migrate_disable

the per-cpu maps are safe to use.
The map-in-map were ok to use in sleepable from the time sleepable
progs were introduced."

It's just a tiny bit easier to find the commit that added it. But not
a big deal if you think it's not useful to split.

[...]

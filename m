Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0F38008E
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhEMXAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 19:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhEMXAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 19:00:00 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34838C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 15:58:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c14so5090582ybr.5
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j//wuBLQrPeO+0R8nxBy3+Tq8QZ40QULPmh5wfDL8fY=;
        b=WQmMLHMpom6OpEyA17DDycNMt9yHpgnCHWQ4MMl7iR8Mi2c4MDzn59oppBtLgmlO9Y
         dFXLupDvyYyepL5tb1B5fMg52jmIkz3vc5wQwtGKuAqmXJbn5HfNo+v4rSaMe1POw7Yt
         Vtq+sTkc6CVjvNHYzKidIspJdkIhR1rysF6Gvr+wHk8rVni25n1IRtXc5LtfmUO2p6e6
         feyxlOiJj7zh2xBOQFefUJ1XpWVFHNis7XVno8+r44+RgTrkJGA8pka1oPQqagrT/sxj
         vuLf+TvUsjbtfXnqpjpmBskDpUlPe98JLCX0ycLn9vMhoc3z0uvkc4PbjFQea9qmd6ID
         A0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j//wuBLQrPeO+0R8nxBy3+Tq8QZ40QULPmh5wfDL8fY=;
        b=r+cwxEaZzqVE7oCFkXJr8/eYkQ2YDnwIHyJKWu67b7T9Ob9abgeg0pikrIWl2aAmz5
         SsnhoG2glH0BfUNmDNHh/KW14TgKKJW6tLBgUY1yjXVYcAKgTe971DLdJFmNQsCILu54
         cuL/zS//ALvJ3M1PdBubc29JR/oagI/8T6rfD6GH5g3AydTOkITuyvJOT5xDI40pXIGu
         zQEzOxGu7ssiJIRBiWqfN3A/2ipfKHG6a8NkymaTucpKnU2nvtkWxhQFSD7tobcr7Z8l
         xR/5DtophVc/pmNMcn2x6yAyfAeFvQrFGL3j+2HV5fuslElO5GGFHBc9t6u6eNa263j9
         xqTw==
X-Gm-Message-State: AOAM533ZjyqVFGvVlwASd4z5pPIEEBQhPoW9jXKsWk1uDH/qXbIXJOZ1
        NliI+uW/gcrzT1n9hE/LLmFLHhlGOhWmQuTkVY4=
X-Google-Smtp-Source: ABdhPJxQrelg5PlLBbQ7gkkNaCYJ9Kok/kuyGULmmSW8PQA2YL+yD4/PkHqasQYNrdEo5G2TAGvyJxOScTOQSzJIbaI=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr57142543ybg.459.1620946729348;
 Thu, 13 May 2021 15:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
 <20210512213256.31203-17-alexei.starovoitov@gmail.com> <CAEf4Bzb=L0LH0OfEqe+uMq0rd8=zaHzPdWV5-Qf5_CQFkKT8pw@mail.gmail.com>
 <e71cd6e3-3f2c-dc19-344a-28b8e5d68a9b@fb.com>
In-Reply-To: <e71cd6e3-3f2c-dc19-344a-28b8e5d68a9b@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 May 2021 15:58:38 -0700
Message-ID: <CAEf4BzZJcPwT7MtqW2bvePskCSZQxcfLjiT7xucPWvfHvKHHWA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 16/21] libbpf: Introduce bpf_map__initial_value().
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 13, 2021 at 3:22 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 5/13/21 2:16 PM, Andrii Nakryiko wrote:
> > On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Introduce bpf_map__initial_value() to read initial contents
> >> of rodata/bss maps. Note only mmaped maps qualify.
> >> Just as bpf_map__set_initial_value() works only for mmaped kconfig.
> >
> > This sentence is confusing. bpf_map__set_initial_value() rejects
> > LIBBPF_MAP_KCONFIG, so it *doesn't* work for kconfig. But your
> > implementation will return non-NULL pointer for kconfig (it will be
> > all zeroes before load). So did you intend to match
> > set_initial_value() semantics or not?
>
> Good catch. I'll reword.
> It was too forward looking and ended up as completely incorrect
> sentence.
>
> The idea was to make getter work for all is_internal and mmaped
> maps (including kconfig), so that after __open and before __load
> phase can populate them with correct values.
> Initially for kconfig I was thinking to do it as part of the loader
> program, but the kernel doesn't have in memory kconfig. Unzipping
> and string searching didn't feel like the right task for
> the loader prog/kernel, so the light skel instead will populate
> it from user space during __open.
> At that point we can either fail the __open if /proc/config.gz
> cannot be open or it doesn't have the fields the prog is looking for
> or proceed with default values in kconfig map that libbpf populated
> earlier during light skel and loader prog generation.
> Depending on that choice the bpf_map__initial_value() should
> either return initial value for kconfig or not.
> I think returning it for kconfig map doesn't hurt.

Yep, I agree.

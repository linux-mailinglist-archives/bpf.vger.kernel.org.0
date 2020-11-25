Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FB2C37AF
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 04:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKYDgg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 22:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbgKYDgb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 22:36:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B650C0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:36:31 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o9so1029103ejg.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 19:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VK4ZeW7Nz+CFyAfbJgfsEqmJxnrRpFVEOk6d97DaLw=;
        b=iJBbIXRcabK8sZM5rr4sYbAeByFeIxnyFkX052Ugs+GRIjpmaDd52gB1Z3rMMeYqHH
         zV80GGTWxytr3wVkGWS1VsoXZsQUF8EkU6KxZbcCpJ1qfok1xc3TyzwNKoB9gP5II2dh
         PMzr3yU1eVf7n90z+DIUqcbeVDd9DGYRyTFTzKAC7U5APJQKuD8Gr0ZtTSqgodZvJxdx
         mzE41diVzfXn7vtz6APS2WIgtD2k6s9v8qGj7wW/IVPzPT3F7GbXZOC5KjBoPe4H74He
         44Y50PrC/ZNkqpgvMT3jEdxhVoYxdiPnNwXmiGN4Lb9rjusgRH2X70BsojC/3lTRtVUu
         eqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VK4ZeW7Nz+CFyAfbJgfsEqmJxnrRpFVEOk6d97DaLw=;
        b=DuV0g2JLTRoH5yiJ52YBUNQA0712tDKVLalJWkA29NMp/L4VNd4kGV/OMWnIOjw154
         LUsXMpx5FHgV/VePG6+qTwyMn0/X3ux+XoDrn1l0aXLVzQHaNeyy2Dg1D8hj8/LW3zBI
         /rTXLkzGPIA0j+IAFgZ8+hhQkJ2uIDHat57EugdOdFSdvczAKazdbF8oVuFDLBef99m2
         4JUbEKPE0/kli+easeus3hrrTvLCmN+aA/CETNm4k0/acLDpNHXZhVXb4YVEntumC9YX
         Qom34w7R87/y1jFV8q9KeFpjFlA3cSLs+O3YFzlJeHB8ADpKbKbiIyBNOq8zF68VRoOc
         T1BA==
X-Gm-Message-State: AOAM533OOziyxcGY8oROp1ubTZQR+sNEQzxHCFx1TWiw2hHIIxcqWLEk
        885PNNGkY462JOPM486d/LyKd6c2JiCjkFdDcrst/JedXCy/dA==
X-Google-Smtp-Source: ABdhPJx9BcsySbwME/ZrVOHGwJ4qStFHHSDL3hd0flTZXDCbNHbaKGaIrrXzEVq7XzUcHZvkXUBNs7xT+YdRpJutuFI=
X-Received: by 2002:a17:906:a195:: with SMTP id s21mr1422714ejy.146.1606275390123;
 Tue, 24 Nov 2020 19:36:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs9sg69JgmQNZhutQnbijb4GzcO03XF66EjkQ6CTpXXxA@mail.gmail.com>
 <CAK8P3a1Lx1MMQ3s1uWjevsi2wqFo2r=k1hhrxf1spUxEQX_Rag@mail.gmail.com>
 <CAG48ez17CKBMO4193wxuWLRQWQ+q6EV=Qr5oTWiKivMxEi0zQw@mail.gmail.com>
 <87h7pgqhdf.fsf@collabora.com> <87a6v8qd9p.fsf_-_@collabora.com> <202011241345.FAF4D7E@keescook>
In-Reply-To: <202011241345.FAF4D7E@keescook>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Nov 2020 09:06:18 +0530
Message-ID: <CA+G9fYtRt9LA4L2tf3aw8fmPuDDZNbejnU2XGk=Q93Tx3mXYrA@mail.gmail.com>
Subject: Re: [PATCH] entry: Fix boot for !CONFIG_GENERIC_ENTRY
To:     Kees Cook <keescook@chromium.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 25 Nov 2020 at 03:15, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 23, 2020 at 10:54:58AM -0500, Gabriel Krisman Bertazi wrote:
> > Gabriel Krisman Bertazi <krisman@collabora.com> writes:
> >
> > > Jann Horn <jannh@google.com> writes:
> > >> As part of fixing this, it might be a good idea to put "enum
> > >> syscall_work_bit" behind a "#ifdef CONFIG_GENERIC_ENTRY" to avoid
> > >> future accidents like this?
> > >
> > > Hi Jan, Arnd,
> > >
> > > That is correct.  This is a copy pasta mistake.  My apologies.  I didn't
> > > have a !GENERIC_ENTRY device to test, but just the ifdef would have
> > > caught it.
> >
> > I have patched it as suggested.  Tested on qemu for arm32 and on bare
> > metal for x86-64.
> >
> > Once again, my apologies for the mistake.
> >
> > -- >8 --
> > Subject: [PATCH] entry: Fix boot for !CONFIG_GENERIC_ENTRY
> >
> > A copy-pasta mistake tries to set SYSCALL_WORK flags instead of TIF
> > flags for !CONFIG_GENERIC_ENTRY.  Also, add safeguards to catch this at
> > compilation time.

This patch tested on arm64, arm, x86_64 and i386
and the reported issue got fixed.

> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Thanks for getting this fixed!
>
> 3136b93c3fb2 ("entry: Expose helpers to migrate TIF to SYSCALL_WORK flags")
> Reviewed-by: Kees Cook <keescook@chromium.org>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh

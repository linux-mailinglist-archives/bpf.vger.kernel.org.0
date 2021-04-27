Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3181D36C852
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhD0PJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhD0PIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 11:08:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EFC061574;
        Tue, 27 Apr 2021 08:08:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h36so40065832lfv.7;
        Tue, 27 Apr 2021 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCcEen4101Y0gCFf7V397sKcaJRlYsR0cutIrtrwqXw=;
        b=vOrZ3n9qHC1AMYWTXd2/WEeRHiuyzLgK9Yj8NfoGoBVu33Iy4Uv0NHrlCg5VrlwnD4
         wYkpmHh7H/VZ0mXBg1rQzxeQKcKa1ICnuByCoQb6PPefdaMwiTYz7wWBo31+crV34fmg
         2p/2Nai+a//jSoQjHf23+PxY1DGeZyT63arHRc5HGmo+TDNzRor55fnChL2/G1GZBlfE
         og9ogHC5fWDjb7DdC9SxqXMA+auMra+7Qd12Iub5/lBLuHNXzSTeH0voIl4CYwkxKiqX
         oiWpEHiSsQ9cwTcEDci/O10YihLmFoeOC/zeF/uOEoOkTnE7uhE3l94FKO9MSDV5sh75
         pUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCcEen4101Y0gCFf7V397sKcaJRlYsR0cutIrtrwqXw=;
        b=Yta8dkIteMnJk+9VKPgjgo6pnQvyiF0s+7mthc/xtsMgXxqvm8Dv5V65LcOhAdbaFX
         fJezV0RaLKFY5vURlsKLjvRhNL3pZjCAJkvbIaYEtzPyUEUVeQ1zWuHmf5/onxvFpOR3
         6LnaQvgCjFBU4QBkOWhlJeSshkWto9J0fB2ultvJH3adbH5U19bR9XQe/imAm2n9BCIF
         ugmoCtVOC06mDAs3OQeSESgNcA32L2STq9W38lF5Dt6PuIHC6QqrQ0TTRR77osBWqM9X
         r69bwbSHVVAV18IRmC0r8GD/B727kNtHlKl0emsuqCcQ8Q+WYnr/1+thEaaIhWH6tAcR
         lGlQ==
X-Gm-Message-State: AOAM5332pp5imxdKKropVZumietI3PrnhZYPN+s84bnpcNBMMTB2iHar
        2YnpkffzZweZItVJZcc6iweTY/MbpLZjNratyzs=
X-Google-Smtp-Source: ABdhPJwo/bFJschlEdTRYq/EZ2dn47Si1+OS2NYpiOsKFOVBWF9HYVJBtxxI4IkfAgQSgC6g4AAQQH1N0SXMMjDH9ak=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr17798670lfi.539.1619536088667;
 Tue, 27 Apr 2021 08:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210427112958.773132-1-revest@chromium.org>
In-Reply-To: <20210427112958.773132-1-revest@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Apr 2021 08:07:57 -0700
Message-ID: <CAADnVQJGMU2OAA4cRuD=LmfF3Wn5z0hqo1Uz9nx-K_KWuCA70A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Lock bpf_trace_printk's tmp buf before it
 is written to
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 4:30 AM Florent Revest <revest@chromium.org> wrote:
>
> bpf_trace_printk uses a shared static buffer to hold strings before they
> are printed. A recent refactoring moved the locking of that buffer after
> it gets filled by mistake.
>
> Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Florent Revest <revest@chromium.org>

Applied.

Pls send v2 of bstr_printf series as soon as possible. Thanks!

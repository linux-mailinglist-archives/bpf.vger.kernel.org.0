Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13D4635EE
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbhK3OAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 09:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhK3OAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 09:00:53 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2427C061748
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 05:57:32 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x32so52807505ybi.12
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8mC6OqW0NDo60h/ey+ips1XwWpcV67dhd9iu/BhDz0=;
        b=WRlEVbKlNULbDO6M6gbl896ndTKr+un9IDkTKhxYx3kDhMjanE6bsjMsPGAzq97Hs9
         crYTXwAvhcyMq0NWjblhRU+XgfOOV8KfhaRjJK5IdAOTnu2vDmQtmO7FOn8mSBDsKa4m
         YW5rnK8qkBbukBswLIUOA56UjHBAV5lJj+siep6KiR6wcCMAEFsdlxJxGMWoJ0cU2ZeO
         EpGx1VdKsIXJbD+GHuwD4rtflOshZHkR4BLyyawq8g2S9UDZi/AWRB+14W+nxsqaUXTR
         /EoGaAHK0pdgbtQ6FUYKHkvKvtWBroMuvCqWmhqPx5vLQF26e030cQ3Su0fjv+eMkVZZ
         jovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8mC6OqW0NDo60h/ey+ips1XwWpcV67dhd9iu/BhDz0=;
        b=r+NJUsnAZFlOc9gSFJbqKQ6EWk1BWNTUk/XxAvtoyuClSa1FYo8ieGauaEHgTP/AqR
         ErRGtYQRQN3kVUhcgWrMsLJPRpD4BuPYHHYVVzOZi8AhyP8UzH4nZphel/DGl9hJAjB5
         vThqbZ4B0YXJl52NKrejqg3AIUQB0/5u3DcpFl6Htkjb+b4x/EC/r5IFsKgZkiC0WlGu
         HpY9eLdeNxB+SCr/HXKVBcVI/DzDnUjUy44LkefKiq0yfkR3Q9uYwy75pubaOfOeByvr
         7vqiD6P/Wsd3aD0kzj1O96Drjoe2QyHOT5Q87EWQeAffIwZ88G9F1PKdqqjxzX+akBFb
         uSMg==
X-Gm-Message-State: AOAM531tFnI2EGcP+BzddJn2bbfGjJizITKQkn74XmcqFG+MNrVaqJLT
        MAWciLFZQKxOyDpt/VzeqL06gRlR/PPD6kaiYeXaIlJW+VsusQ==
X-Google-Smtp-Source: ABdhPJy/BtczKyJzappms/4cO8+1NIBYpHuseK0gvuukRHbl9fVIpSbl33dqQ/eIMS4vDHBMIe0jGEVN1VclOswS83I=
X-Received: by 2002:a25:94d:: with SMTP id u13mr14311330ybm.723.1638280651971;
 Tue, 30 Nov 2021 05:57:31 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMyEqSsA1Xez+6nbdQTqbKJZFUVGtzG6Xb2aDDcTHCe8sg@mail.gmail.com>
In-Reply-To: <CAKXUXMyEqSsA1Xez+6nbdQTqbKJZFUVGtzG6Xb2aDDcTHCe8sg@mail.gmail.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Tue, 30 Nov 2021 14:57:21 +0100
Message-ID: <CAM1=_QQBfO_RQuYFrhdvZeM+KbY+5w=YVHTfb-zZQsN4fiBMcw@mail.gmail.com>
Subject: Re: Reference to non-existing symbol WAR_R10000 in arch/mips/net/bpf_jit_comp.h
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Lukas,

On Mon, Nov 29, 2021 at 7:39 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Johan,
>
> In arch/mips/net/bpf_jit_comp.h and introduced with commit commit
> 72570224bb8f ("mips, bpf: Add JIT workarounds for CPU errata"), there
> is an ifdef that refers to a non-existing symbol WAR_R10000. Did you
> intend to refer to WAR_R10000_LLSC instead?

You are right, that is a typo. I will prepare a patch with a fix.

Thanks for catching!
Johan

>
> This issue was identified with the script ./scripts/checkkconfigsymbols.py.
>
> Best regards,
>> Lukas

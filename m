Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2E1D229C
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgEMXDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 19:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731815AbgEMXDm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 19:03:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E3CC05BD09
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:03:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so1421317ljg.5
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdZg4gkYTds/C4KUVy9erLK1Ch+WqNN+RvFMTseVuAg=;
        b=C1TcjV6OtJpa2YRiWAUnGcZZ/u09cBy851Mx94wSMSQa9VrdsWV1jVHW4P1sNrL8Bh
         F6WpmJ1tQWre2J0ca6Wb2LX04yqV6LxMJpd1Tpa6EPb8PrEYBkkbwpuLaAdO/BjmCZ2G
         9egVYPaqRVmuIV8Yift2HwrZ/fz1dHM99i9n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdZg4gkYTds/C4KUVy9erLK1Ch+WqNN+RvFMTseVuAg=;
        b=lrWUBVbrkyiImGskRoy2UJcCWP+lTWUXdA0R/Lq0F48gmMFpAO1+AV9OA/43wxmrdr
         q8RtAgv1B0FzKi35KkW6Kmz1l/bGXZsLumEayb/92K587Y4RH4P3H7eRWZOWSXzg4Rdq
         gy+5vC2yOtXbDaNhXvKeqbXr95zY8Vnrvj4wnaDtFSePhGYcL1Zsv+r9PtGfhpALSkGN
         +ZT3zrpsJHESeEDE8BgqJbGvEDgP8YlNKGk8Mc1Kbdhe7VwunpQ4wY2yjP6IhcXI49Pb
         /f0QBT37TXq4MjDCkL9vhoawCLyVauXac6FlsEngoA1G9ULHHdtkOy5lFvzbYN/NomwK
         hDiw==
X-Gm-Message-State: AOAM531pWigZO6naL6cFI1oEg3oLT5WZV9gCPxS04jqRcJOscWmWocUn
        RkrCMc6ZdxPsCMhF2YXJSi1/6JRzpkE=
X-Google-Smtp-Source: ABdhPJwy1oQJ9Jvw9AJ7eBLzYOvVxWEYW3Txv1UbKZmIzxd+89e/dSRx3mbbVKqAmW6mLk4HbAMaDQ==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr797565lji.31.1589411018168;
        Wed, 13 May 2020 16:03:38 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w9sm439450ljw.39.2020.05.13.16.03.36
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:03:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id a4so909621lfh.12
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 16:03:36 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr1177915lfo.142.1589411015919;
 Wed, 13 May 2020 16:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de> <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
In-Reply-To: <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:03:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
Message-ID: <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 3:36 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> It's used for both.

Daniel, BPF real;ly needs to make up its mind about that.

You *cannot* use ti for both.

Yes, it happens to work on x86 and some other architectures.

But on other architectures, the exact same pointer value can be a
kernel pointer or a user pointer.

> Given this is enabled on pretty much all program types, my
> assumption would be that usage is still more often on kernel memory than user one.

You need to pick one.

If you know it is a user pointer, use strncpy_from_user() (possibly
with disable_pagefault() aka strncpy_from_user_nofault()).

And if you know it is a kernel pointer, use strncpy_from_unsafe() (aka
strncpy_from_kernel_nofault()).

You really can't pick the "randomly one or the other guess what I mean " option.

                  Linus

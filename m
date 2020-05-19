Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815C1D9C82
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgESQ0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgESQ0S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 12:26:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7AFC08C5C2
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:26:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so340716lji.12
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhbRZ27gTq3LlamCeWaOIagumkyuEgHdNj01JBr2vyU=;
        b=a8S6FimrljQCYdqdMRjHudj5xuwSAYeW17sDBke8Wp/wO6Vv10u9cXvAcweW0ZSEYT
         O3hXN68ol8TooTR2xUI2YNd5y+PctNRhxhENJnhmYB+aBitMMtqsXQFMvUY86xEYH5PA
         jFICERjG8bgZGMW0GbVN6qDt50ZsFp9Lq9zCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhbRZ27gTq3LlamCeWaOIagumkyuEgHdNj01JBr2vyU=;
        b=JP71PoyNeYvRwd5WG1YNcLe9M747lm2xmnJqOFjEcUbsP9Djw1thlAD0TGlP6m/Jv5
         wIDuf55NyRZzZ7y9OO69l1YGMftGXCaiJY2UZ4sn/K+zky5JiCgXGrvo6aww5KwrIdDy
         Bc5s/sxqqyvJNvAjF7CG5ykT3YIYujDMPi6Bwgm7Hr3NFPdPVpALVTZ/cohp9agCEEFG
         4KEkuNECKbjhiYyV6Q2P+pIhb8l19LRVC9ND1De3dd35i2M3r7N1MVRamoJf4m9pt9L0
         +iHsQ6SpZ3wGyxd6itzjADDiTXu/Ya0Yoce7atTQdTskCl9chOSz2D3wUp+X0O1M5b4o
         PWxw==
X-Gm-Message-State: AOAM5301yN7wIMrY9QaZIQdL6wdebbagB9hDgVHgC+MBq+Ieq30MRTlS
        +Nfwk5xfDRc47YJNf+TexWenorb5cSU=
X-Google-Smtp-Source: ABdhPJwTiLYogUzqlxbE6EnFgFq7t/BRkmJupiYWO3IyFR8HZ/rbY0Wg6L1V2p8775RoN1WfTEBCFg==
X-Received: by 2002:a2e:9d45:: with SMTP id y5mr144421ljj.258.1589905575276;
        Tue, 19 May 2020 09:26:15 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q13sm9365553lfh.73.2020.05.19.09.26.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:26:14 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v16so369589ljc.8
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:26:13 -0700 (PDT)
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr128485ljo.265.1589905573160;
 Tue, 19 May 2020 09:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-13-hch@lst.de>
In-Reply-To: <20200519134449.1466624-13-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:25:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
Message-ID: <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
Subject: Re: [PATCH 12/20] maccess: remove strncpy_from_unsafe
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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

On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +       if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> +           compat && (unsigned long)unsafe_ptr < TASK_SIZE)
> +               ret = strncpy_from_user_nofault(dst, user_ptr, size);
> +       else
> +               ret = strncpy_from_kernel_nofault(dst, unsafe_ptr, size);

These conditionals are completely illegible.

That's true in the next patch too.

Stop using "IS_ENABLED(config)" to make very complex conditionals.

A clear #ifdef is much better if the alternative is a conditional that
is completely impossible to actually understand and needs multiple
lines to read.

If you made this a simple helper (called "bpf_strncpy_from_unsafe()"
with that "compat" flag, perhaps?), it would be much more legible as

  /*
   * Big comment goes here about the compat behavior and
   * non-overlapping address spaces and ambiguous pointers.
   */
  static long bpf_strncpy_from_legacy(void *dest, const void
*unsafe_ptr, long size, bool legacy)
  {
  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
        if (legacy && addr < TASK_SIZE)
            return strncpy_from_user_nofault(dst, (const void __user
*) unsafe_ptr, size);
  #endif

        return strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
  }

and then you'd just use

        if (bpf_strncpy_from_unsafe(dst, unsafe_ptr, size, compat) < 0)
                memset(dst, 0, size);

and avoid any complicated conditionals, goto's, and make the code much
easier to understand thanks to having a big comment about the legacy
case.

In fact, separately I'd probably want that "compat" naming to be
scrapped entirely in that file.

"compat" generally means something very specific and completely
different in the kernel: it's the "I'm a 32-bit binary on a 64-bit
kernel" compatibility case.

Here, it's literally "BPF legacy behavior", not that kind of "compat" thing.

But that renaming is separate, although I'd start the ball rolling
with that "bpf_strncpy_from_legacy()" helper.

                Linus

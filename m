Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D821D9C03
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgESQIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgESQIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 12:08:17 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78457C08C5C1
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:08:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 82so11919lfh.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yx5q8kTLmBrxy32bs18zizlzOjtx0vFts57BKijzI48=;
        b=HCXGSXVripfdjF3MiGwI8HqE63+BVnW9g3cwRZiRc5Emx+jBu6A4Nsobp13SbpFd6U
         Lyt8wvpLjFnfI845wbjgkTVZflwu9OTBrRm/9vher3ASfX9/MH65gZZ8ahxQbI/5jnLa
         wMfTgbalXvP1B/G3Ib0nnbu0+sXLvWt0bQgfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yx5q8kTLmBrxy32bs18zizlzOjtx0vFts57BKijzI48=;
        b=iFfWJLpCYIXiMfaMMpLOaXm7Dvf4OzjYTlKYCG0wZ6NZYMzDE3fTOO0gcwojEy4ZzN
         pNKVmuBSLyOVZ2YHcqvW/KzwnaRLlvPNYZtUf7rj7oBVk4FO4Ztb2dmG5GNkdfYMzVFe
         G+ACylB8XBXfk1t+vVTbEDt3ckzySj1WDvszSWEv3l8nXs2B4YOHbn8J/MTjU5bOjwW2
         5Rfcb/leFsLAoj8Kg3jJs3s7Zgd5flUK1H6A+923KANeFQpRi2mVwR1dWITNIoQY/7rf
         ix4+bCptYx+t166PZvsIsu4VGBNUiyZmgwT+uoVxVeiB5PC2ASIRdYKXN+aCYTQiauSy
         w12Q==
X-Gm-Message-State: AOAM530rG9b9qQbv6Lk2loZk+gAFuImFX0/Way75kCsC+ekEF/phTxUZ
        RD+8T74BYG3l7CtfXzfR5oVNJ3Lg0g0=
X-Google-Smtp-Source: ABdhPJyzKjIK3+xe/QOjG2OLeWA7X564A9jR+oTUFkvYPM0NNRIW7tgR9IO9ULq+babye9qcX0R2Dg==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr15984542lfb.208.1589904493664;
        Tue, 19 May 2020 09:08:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id t30sm8400621lfd.29.2020.05.19.09.08.12
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:08:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w15so4360862lfe.11
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:08:12 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr1343727lfn.142.1589904491650;
 Tue, 19 May 2020 09:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-12-hch@lst.de>
In-Reply-To: <20200519134449.1466624-12-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:07:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com>
Message-ID: <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] bpf: factor out a bpf_trace_copy_string helper
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
> +       switch (fmt_ptype) {
> +       case 's':
> +#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> +               strncpy_from_unsafe(buf, unsafe_ptr, bufsz);
> +               break;
> +#endif
> +       case 'k':
> +               strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
> +               break;

That 's' case needs a "fallthrough;" for the overlapping case,
methinks. Otherwise you'll get warnings.

                  Linus

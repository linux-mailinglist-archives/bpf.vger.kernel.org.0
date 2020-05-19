Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A843C1D9CED
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgESQgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 12:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgESQgf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 12:36:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07EC08C5C0
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:36:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so75081lfe.5
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z16ZFiLRHWlE76l/Nnyd5FZZ2VSBLxmf0lz5LDCxbPs=;
        b=UORYpGfRWpAQPT7Eim9FPjPnn5GKxiDiyP2S+AQw0QYKUVeSC2Y2buNVi8EbpRkorO
         IcT1mnMe0MchbGIuyrDccORk12Xm6v8WUDLE8lpsgynSHzLIn9GW5XFMJoAg1fWLV4X4
         DbGGa/kxryZV9vtywESRiuCWoDlSmVvuwa5YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z16ZFiLRHWlE76l/Nnyd5FZZ2VSBLxmf0lz5LDCxbPs=;
        b=AM+nfPiwz0nWAm58VdnSTicH5jWSFHDWS4hizTY9ictC4GDGmLK4Y0ohMW1EO1/zxV
         LnQBzpI8y7pSjng7cq1wrrx0H54RaYN2cEUJ8JrMF83eXcAbSYBVwxcOmnvYpxyhncQP
         f/R/TNKR22ls1Xi6c2a5tXuZxOdZVETsdALOInsVlf4X7iF8qkFeni51GTfU/raCgLYK
         F7VU4y9uktUMT36o99t9UKVLHv5VCjzMvGkggFn4DpDnkWNJaZu1QhdGwXFxppbcRV69
         GHPEaX0L8u0WDa0xdLbUXHlcjcvwd7WnE0Xtdq6CRsngP5zvoA9sY71BIBTfUr84iPs5
         RrzQ==
X-Gm-Message-State: AOAM533tMwvNRT6bjP/9aFDX37sWuM7l/SktLy1nbAc0ki/4CDcSZNj1
        Yl6S79Yua2hS4tHdCim3HhXDu6iuUSQ=
X-Google-Smtp-Source: ABdhPJwUkwFGHkx4n4E7vV9oczihx0tmLoZC9oVNEmOyCqjK3Vsc8LFd5wdrqVFZOF2dEIBkx8OTLg==
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr16064412lfg.150.1589906193201;
        Tue, 19 May 2020 09:36:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z78sm7543094lfc.80.2020.05.19.09.36.32
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:36:32 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id z18so377153lji.12
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 09:36:32 -0700 (PDT)
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr156059ljo.265.1589906191917;
 Tue, 19 May 2020 09:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-12-hch@lst.de>
 <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com> <20200519161418.GA26545@lst.de>
In-Reply-To: <20200519161418.GA26545@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:36:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcmfe__pphtjGzLMJ2kFN0ZTRZQJQVunRxL+9E2Xki=Q@mail.gmail.com>
Message-ID: <CAHk-=wjcmfe__pphtjGzLMJ2kFN0ZTRZQJQVunRxL+9E2Xki=Q@mail.gmail.com>
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

On Tue, May 19, 2020 at 9:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I don't think we need it as the case of
>
>         case 'a':
>         case 'b':
>                 do_stuff();
>                 break;
>
> has always been fine even with the fallthough warnings.  And the
> rest of the stuff gets removed by cpp..

You're right. I read it as a fallthrough because as a human it looks
like there's code in there between, but yeah, the compiler won't
actually ever see it.

So scratch that objection.

              Linus

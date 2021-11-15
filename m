Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C75451D23
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 01:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348104AbhKPAZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 19:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbhKOUUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 15:20:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B40C043192
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:55:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id k37so46573999lfv.3
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPFT2BwevL0ZeUyPKnfSNKcI8gspp3l6LKeTTYtK9bs=;
        b=jBuJDKAh5iXvekwU2FZbH34FBlnxuEzvo0BkgMc5qfY690rB609pgwK1OfFYgxsrLW
         OrOjERQs8UszfgZdLPOPnS21Jv8ljzG+oMS2ijfdkbmDdYs8auIyTz5Pu0sfaJl7+CUo
         HT9noSBXBEVLgEpgRKQbydwNQoPS9j04fKv622mvydsHjlbRHZT2Sd/iVWbXCLClB0OQ
         jfwRx+B3Wtaowcf1OYMMS5hHC0mGyuuPZmk9mTogl+i5Y7hzjIPWlDZTxABwQot7sbQ4
         rCnRqjzMjxbpHac4V5dLLICC+uWuiv38vE5Yuxitf7hcFVrqfCchibG6seuNYDZuZbGU
         09Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPFT2BwevL0ZeUyPKnfSNKcI8gspp3l6LKeTTYtK9bs=;
        b=nFPCfLzYiqWjxbb0HV8v3STGr314xJO4f39qAK++ZFkXVLXhlsWjFruVo4oXDAJepe
         abt/vFeYlHtPFm/IC39N69k0Hi8F8xz4OwmmlWnpkilSpXQH2p1aB5lwbK54ComvzPh0
         G+5djKrMX6ERWro8OdU1zLMzXUdmhASsWimpo9SCdH+3+0HoIBaZOJoJ++ZS4pSsmvzl
         MHixqDOxZfBxs2+YTncd67OmSmDyErlq5Vkslg9GRcdlwEWX4gC/OtZb8GnRihzxBheV
         iQ0vjzqBmFMbKsXK3EBaL2GCwPlPHG+TRnWMQYTpNGoOXhvSKg7pusg0XejiMJD0ggb6
         060w==
X-Gm-Message-State: AOAM532Nj54dxIP8WhSHTGFMtBrsncEVGym6VbqKo5GXPdI5qRt9Wyqw
        wQKc7k6wvF2t5ns6ulo3KqUkrHfUj8CmysrVDys=
X-Google-Smtp-Source: ABdhPJzh9WY5SxehJAFiwdu9wy9ukzRENm1qB4KQXNOVT0jEmw4C6kGDYabNYw5KVt+BsFZImbs30NZhd6Bes4x4wjQ=
X-Received: by 2002:a05:6512:33d6:: with SMTP id d22mr1167274lfg.564.1637006110894;
 Mon, 15 Nov 2021 11:55:10 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
 <6191ee3e8a1e1_86942087@john.notmuch>
In-Reply-To: <6191ee3e8a1e1_86942087@john.notmuch>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 15 Nov 2021 11:54:44 -0800
Message-ID: <CAJygYd3sdsv25AvJbe6so2KaU1XPsUJ+rd_4vURLgWFfJDm-WQ@mail.gmail.com>
Subject: Re: sockmap test is broken
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        joamaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 14, 2021 at 9:22 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Alexei Starovoitov wrote:
> > test_maps is failing in bpf tree:
> >
> > $ ./test_maps
> > Failed sockmap recv
> >
> > and causing BPF CI to stay red.
> >
> > Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.

bpf-next is also broken

eg. https://github.com/kernel-patches/bpf/runs/4215545454?check_suite_focus=true


> >
> > Please take a look.
>
> I'll look into it thanks.
>
> .John

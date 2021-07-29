Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467593DA400
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbhG2NYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbhG2NYo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 09:24:44 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29AC0613D3
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 06:24:41 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id d73so10159543ybc.10
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3gtSFNqWlMDmi9F4nxYDosBV6KTlor90/18ofAi344=;
        b=C7koYkLFCNRI5d3aOLmjP4UgotIcym7KhpDnQrZq+VbEO0/RuCP9WbJ9nmGJA0Y7Zy
         gaRETBwCP25fPOjkKsDbgvuIoLI15o+ifA0BNxQYCN+1/Talwpjn7DvAgnmdeIlgHWMa
         V1Ubx8NEvQfb5ygqm3DvFVTYS67gVpLND8VKDYdvpCidVVjhtCsuyim3f9O43DT/E9p3
         cEmO5s+SISsMBXMZcUYpUVIqyj4lN3BvbEs+GXIsYzMnciptSQH6o0EbNQXaI5o+xaWx
         HirTVc1V41nKF/c7sjIYKdgagCdF+yikaGf4P28Y1MHyLuV3wNEyL4EO19wJGfE2mpXT
         t0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3gtSFNqWlMDmi9F4nxYDosBV6KTlor90/18ofAi344=;
        b=tiwjDEVHtWQlqOVITWfEmEeFUPY/G1VkXv/egU+EnlENg8SLNUMKUmqDoTCadKqEGZ
         7q/f652xGJtvcSM9VZ8TKXzGEtpj2fE1m02jZnmerBzZJoNKpaxAw7lbX6Bvin8JrslG
         SYscHO1BFXb0iCKTmnFnR6Uy4Y+WrdFNAMWva4pPhCRKmu0xuUi1WZD8Bc9mxNWG85zK
         V7vQeCs2C2U4uiTBtdXD7Qgj6JlTtvo1jy69+23lEQ1F/bLhDnEcgPdzV1Ist8LNFPlZ
         dz92PCaUalkdcLozyM+iJfVL7Rv5xlxtHgCwfXnI1zsWKrdJ++R6ctmLXGM7nDOy6hQY
         4XyQ==
X-Gm-Message-State: AOAM5324QfWFcE7njQKfll4UjxSf++lA/GbR0X41DjBndPndPtDFM+pC
        jZZdDsqvs0FRdGp0z34k7HR3uSHyjEAnbA1ylXqXhg==
X-Google-Smtp-Source: ABdhPJzGyV91GtfYtuhcB/tTlKHgTZafB6xVSMrvN/YBDR52baHS3XwWbpKhz2+KqAmfd0TTop2jmaE/7wvwYcPxxLE=
X-Received: by 2002:a25:7b83:: with SMTP id w125mr6681536ybc.238.1627565080581;
 Thu, 29 Jul 2021 06:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
 <20210728170502.351010-11-johan.almbladh@anyfinetworks.com> <6c362bc2-e4cf-321b-89fb-4e20276c0d73@fb.com>
In-Reply-To: <6c362bc2-e4cf-321b-89fb-4e20276c0d73@fb.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 29 Jul 2021 15:24:29 +0200
Message-ID: <CAM1=_QRN+aioWWNfeS5Tddo2u6UG86bVj66BJoYyzaUDSkDZ1w@mail.gmail.com>
Subject: Re: [PATCH 10/14] bpf/tests: Add branch conversion JIT test
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 2:55 AM Yonghong Song <yhs@fb.com> wrote:
> > +static int bpf_fill_long_jmp(struct bpf_test *self)
> > +{
> > +     unsigned int len = BPF_MAXINSNS;
>
> BPF_MAXINSNS is 4096 as defined in uapi/linux/bpf_common.h.
> Will it be able to trigger a PC relative branch + long
> conditional jump?

It does, on the MIPS32 JIT. The ALU64 MUL instruction with a large
immediate was chosen since it expands to a lot of MIPS32 instructions:
2 to load the immediate, 1 to zero/sign extend it, and then 9 for the
64x64 multiply.

Other JITs will be different of course. On the other hand, other
architectures have other limitations that this test may not trigger
anyway. I added the test because I was implementing a non-trivial
iterative branch conversion logic in the MIPS32 JIT. One can argue
that when such complex JIT mechanisms are added, the test suite should
also be updated to cover that, especially if the mechanism handles
something that almost never occur in practice.

Since I was able to trigger the branch conversion with BPF_MAXINSNS
instructions, and no other test was using more, I left it at that.
However, should I or someone else work on the MIPS64 JIT, I think
updating the test suite so that similar special cases there are
triggered would be a valuable contribution.

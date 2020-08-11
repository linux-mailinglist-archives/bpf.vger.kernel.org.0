Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9947E241687
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 08:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHKGzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgHKGzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 02:55:06 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F20C06174A
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 23:55:06 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id c9so4980075ybq.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilFJYMh26kJDcRZFNdk8QyX1BvQNs8yrfRu3yc/EDxY=;
        b=WcHSGgMuMHXsSeSIdZ4uNledEDpN3YBJIovBZdKec+n0OyMQoWSfaKqlEAv9UTk23h
         FWrc9p6J/pejfDFQFkjZDWVrm3gkVr0xAQTqmf1WGq+dNeZbZqzOpxCuWSU4IXMYqfr/
         U1eI0qpTeUdfgXaLdgWz2r6mTIrgVQ/yWH+lsJIINX66gaL1j6ACN3HM2FIcLc6Hxsc0
         l9GRJdGPqF1LDpjYkKeFbjHn2M8kz+X0S6qoVzwAA013Zbu49qMJl99UMBihAOPYKYdV
         Vtc/cJI2iYcEoTiiafJprixBkexTqRZmjySL6pEY7WVJx0QsjBbKMyXM0XOxNvDgCPyg
         Qd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilFJYMh26kJDcRZFNdk8QyX1BvQNs8yrfRu3yc/EDxY=;
        b=ZH7oTj8aMO3BlyZ/90knDFmuztapAle5y2Km9wjPZibv2XW03lgHxO46jI+u5oW/Sn
         JG9vlEEsGOQV7yVqoMpdpyP8UC+zU8rH7j1V5F6YrIA5leYMM8q2VrmOp/Og335DqNUr
         pVYrGqydyx9gFN0kYoe9UGVky5nh/7+wthKnMKrFcnMW2H36TiKodJNZUhXFvlTfXNRy
         yWrlhdsIicqai/3AiIAqo8CQXA4zwgIx6xvHTcDEShh9ihHYkpoim1i5Yo6u8kfNRh+O
         cEibvDXUsmAFmwk5giidEZ+laSabqv8IROyRWuFaZVFgpijJLlKnRzb8wb9CuBWeSEWh
         Nvlw==
X-Gm-Message-State: AOAM532fpBNhme2Woq0ivhgsBRKbSTwmg6JPL+4OV+9CnXbYAtKnl4PP
        JkHwFU0Tj276XrSBqgq4gpiS8OMMctRFazBYPBE=
X-Google-Smtp-Source: ABdhPJze216D37ANRs5ZqT2ayTGfErIKpkRlqQCUuPSmMS4U9lo/grwVbPmqE8wni+jhxnY267coqOu22/eBRNL2O4o=
X-Received: by 2002:a25:2ad3:: with SMTP id q202mr44245552ybq.27.1597128905302;
 Mon, 10 Aug 2020 23:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica> <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
 <CAADnVQ+fQG38XKR+V33qTR-G-7wm398CMCafbuQrTQ9CHfE2mA@mail.gmail.com> <20200810125753.GA1643799@myrica>
In-Reply-To: <20200810125753.GA1643799@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Aug 2020 23:54:54 -0700
Message-ID: <CAEf4BzaQcxAArJyLqxxw8sV507DyWzU44HJ3oaUAjX4UEu_KaA@mail.gmail.com>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakov Petrina <jakov.petrina@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 5:58 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Fri, Aug 07, 2020 at 01:54:02PM -0700, Alexei Starovoitov wrote:
> [...]
> > > > > ```
> > > > > typedef __Poly8_t poly8x16_t[16];
> > > > > ```
> > > > >
> > > > > AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> > > > > have opted to comment out this line as there was no additional `poly8x16_t`
> > > > > usage in the header file.
> > > >
> > > > It looks like this "__Poly8_t" type is internal to GCC (provided in
> > > > arm_neon.h) and clang has its own internals. I managed to reproduce this
> > > > with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> > > > the moment. Maybe libbpf should generate defines to translate these
> > > > intrinsics between clang and gcc? Not very elegant. I'll take another
> > > > look next week.
> > >
> > > libbpf is already blacklisting __builtin_va_list for GCC, so we can
> > > just add __Poly8_t to the list. See [0].
> > > Are there any other types like that? If you guys can provide me this,
> > > I'll gladly update libbpf to take those compiler-provided
> > > types/built-ins into account.
> >
> > Shouldn't __Int8x16_t and friends cause the same trouble?
>
> I think these do get properly defined, for example in my vmlinux.h:
>
>         typedef signed char int8x16_t[16];
>
> From a cursory reading of the "ARM C Language Extension" doc (IHI0053D) it
> looks like only the poly8/16/64/128_t types are unspecified. It's safe to
> drop them as long as they're not used in structs or function parameters,
> but I sent a more generic fix [1] that copies the clang defintions. When
> building the kernel with clang, the polyX_t types do get typedefs.
>
> Thanks,
> Jean
>

Hi Jean,

Would you be so kind to build some simple C repro code that uses those
polyX_t types? Ideally built by both GCC and Clang. And then run
`pahole -J` on them to get .BTF into them as well. If you can share
those two with me, I'd love to look at how DWARF and BTF look like.

I'm, unfortunately, having trouble making something like that to
cross-compile on my x86-64 machine, I've spent a bunch of time already
on this unsuccessfully and it's really frustrating at this point. If
you have an ARM system (or cross-compilation set up properly), it
shouldn't take much time for you, hopefully. Just make sure that those
polyX_t types do make it into DWARF, so, e.g., use them with static
variable or something, e.g.,:

int main() {
    static poly8_t a = 12;
    return a + 10;
}

Or something along those lines. Thanks!

> [1] https://lore.kernel.org/bpf/20200810122835.2309026-1-jean-philippe@linaro.org/
>
> > There is a bunch more in gcc/config/arm/arm-simd-builtin-types.def.
> > May be there is a way to detect compiler builtin types by pattern matching
> > their dwarf/btf shape and skip them automatically?
> > The simplest, of course, is to only add a few that caused this known
> > trouble to blocklist.

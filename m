Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186F023F404
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 22:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHGUyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGUyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 16:54:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A0C061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 13:54:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m15so1670128lfp.7
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2020 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meM+QqcY/bQUiJ15jxSP7yGxkVia3zRGvQvr0U3hIPw=;
        b=ink9Sr1YOk0V3/1lK4EAKw5TlSEOs8NRzeSgnHFC8miD3RIzhaixxcLnRB1VzVodp8
         ewKpj3fNNsY8sGlpqRY94OTlTkv7O+DLNE0XKlb5q4Mwyhin5Paxc/qm+VtzfWHfs0Tk
         CsKxvObi+X2jPCrB7S3zz6q5BrFP4/8bcvZb8VQKNZteKhABwSudugmkjdEqDs4oHeWN
         maUVcVfLRyp992y7cxePK8v2toe4s0D0CU1sW5GFQM8hiIU6kdlgn9Gj7B/HwZYA1tkc
         LTM4oT8EizQ1k5CSb6d4C+lNU5gkJYGlnW9ANfNgqop8eZ9AG0U/ezJbYkJdLgJauh8G
         GooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meM+QqcY/bQUiJ15jxSP7yGxkVia3zRGvQvr0U3hIPw=;
        b=qMfvuQkCo7sSZogjsb1n3TgY2ZemRc8C/rf6gXtPjDEcDkZWFtztQ3iFEyuWhKPrMv
         ukA+H/4+j9hMy7TK8Kdykbj58eTpck3YwsD3sqkq35bXzr1Y7pX9dIBKv72gNFQ0DG+B
         4CHceRv1cBpsZTsUiQFCx8OiF7iCQc3vgipAo14H12TrM7QzK1gf5EvhWjxlfXn5tgkp
         gHBf9j7iZryzzik2i7cdE38jBoQQJ655iLWEZFSvHdEZqojITKGHHY/PwQbYfPSyGTYa
         lxsbM2s3iSSL90pLQZRvC0Oxuo014y67phvHksE6v5uhM4EHtDWsEY+dXbuX14vChYr2
         S7ig==
X-Gm-Message-State: AOAM5318HggVegixjbyw3Bm+q2jFpxQOmC7mTSjhUvtF7/PHq97lptmR
        s2052GcAEM0R0E4apaNODLu0YkFxkQkeFiWVccU=
X-Google-Smtp-Source: ABdhPJzE6XW3QwtSqJ+kXZIMpqoxWGACHwc3Qf0Hfl3lvClZU87xK5O+vgukmIMEQ5T4jBVq6utpw1Nd57V5wVDU+zs=
X-Received: by 2002:a19:cc3:: with SMTP id 186mr7472792lfm.134.1596833653647;
 Fri, 07 Aug 2020 13:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica> <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
In-Reply-To: <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Aug 2020 13:54:02 -0700
Message-ID: <CAADnVQ+fQG38XKR+V33qTR-G-7wm398CMCafbuQrTQ9CHfE2mA@mail.gmail.com>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

On Fri, Aug 7, 2020 at 11:41 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 7, 2020 at 10:24 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Hi,
> >
> > [Adding the linux-arm-kernel list on Cc]
> >
> > On Fri, Aug 07, 2020 at 04:20:58PM +0200, Jakov Petrina wrote:
> > > Hi everyone,
> > >
> > > recently we have begun extensive research into eBPF and related
> > > technologies. Seeking an easier development process, we have switched over
> > > to using the eBPF CO-RE [0] approach internally which has enabled us to
> > > simplify most aspects of eBPF development, especially those related to
> > > cross-compilation.
> > >
> > > However, as part of these efforts we have stumbled upon several problems
> > > that we feel would benefit from a community discussion where we may share
> > > our solutions and discuss alternatives moving forward.
> > >
> > > As a reference point, we have started researching and modifying several eBPF
> > > CO-RE samples that have been developed or migrated from existing `bcc`
> > > tooling. Most notable examples are those present in `bcc`'s `libbpf-tools`
> > > directory [1]. Some of these samples have just recently been converted to
> > > respective eBPF CO-RE variants, of which the `tcpconnect` tracing sample has
> > > proven to be very interesting.
> > >
> > > First showstopper for cross-compiling aforementioned example on the ARM
> > > 32-bit platform has been with regards to generation of the required
> > > `vmlinux.h` kernel header from the BTF information. More specifically, our
> > > initial approach to have e.g. a compilation target dependency which would
> > > invoke `bpftool` at configure time was not appropriate due to several
> > > issues: a) CO-RE requires host kernel to have been compiled in such a way to
> > > expose BTF information which may not available, and b) the generated
> > > `vmlinux.h` was actually architecture-specific.
> > >
> > > The second point proved interesting because `tcpconnect` makes use of the
> > > `BPF_KPROBE` and `BPF_KRETPROBE` macros, which pass `struct pt_regs *ctx` as
> > > the first function parameter. The `pt_regs` structure is defined by the
> > > kernel and is architecture-specific. Since `libbpf` does have
> > > architecture-specific conditionals, pairing it with an "invalid" `vmlinux.h`
> > > resulted in cross-compilation failure as `libbpf` provided macros that work
> > > with ARM `pt_regs`, and `vmlinux.h` had an x86 `pt_regs` definition. To
> > > resolve this issue, we have resorted to including pre-generated
> > > `<arch>_vmlinux.h` files in our CO-RE build system.
> > >
> > > However, there are certainly drawbacks to this approach: a) (relatively)
> > > large file size of the generated headers, b) regular maintenance to
> > > re-generate the header files for various architectures and kernel versions,
> > > and c) incompatible definitions being generated, to name a few. This last
> > > point relates to the the fact that our `aarch64`/`arm64` kernel generates
> > > the following definition using `bpftool`, which has resulted in compilation
> > > failure:
> > >
> > > ```
> > > typedef __Poly8_t poly8x16_t[16];
> > > ```
> > >
> > > AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> > > have opted to comment out this line as there was no additional `poly8x16_t`
> > > usage in the header file.
> >
> > It looks like this "__Poly8_t" type is internal to GCC (provided in
> > arm_neon.h) and clang has its own internals. I managed to reproduce this
> > with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> > the moment. Maybe libbpf should generate defines to translate these
> > intrinsics between clang and gcc? Not very elegant. I'll take another
> > look next week.
>
> libbpf is already blacklisting __builtin_va_list for GCC, so we can
> just add __Poly8_t to the list. See [0].
> Are there any other types like that? If you guys can provide me this,
> I'll gladly update libbpf to take those compiler-provided
> types/built-ins into account.

Shouldn't __Int8x16_t and friends cause the same trouble?
There is a bunch more in gcc/config/arm/arm-simd-builtin-types.def.
May be there is a way to detect compiler builtin types by pattern matching
their dwarf/btf shape and skip them automatically?
The simplest, of course, is to only add a few that caused this known
trouble to blocklist.

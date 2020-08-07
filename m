Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39C23F2DB
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHGSkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGSki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 14:40:38 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8128C061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 11:40:38 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id p191so1514194ybg.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2020 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tvu+sDswt4i9FVcg5nv1Y+mFO5ABzXJ/vrL/i4QuS3g=;
        b=MOMWmipW9eml/wuukTsoYBxQ7Frwy9c3NuLRdgZUeTkMk/gglKSbywuXmxh4cUiBOz
         gDJBhu3mWLQWCbV5OxD6zzJTrI9GO5GQndUus+aztxMPz7hC1kb/Jgn2VmZwf4J9fmF+
         xihwXfNAUcHyvGEZYXFkvHkELFfyDEIDcTwc8E94JSsA2E2X5GazkqhwsKohRKrTjCaE
         uLRQJnt4FB+MiNuysQncT05CxbCHxLzR6iZ4XCVA+zoLUwAWt0B58u7ooVYQQO3T+ZXk
         JmFjTFm/aHBC/i+FASN+Jfw0W34uCgDgaFfBhIXrzpotywj0LseA0JULeQ5HjZTnoY+x
         JowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvu+sDswt4i9FVcg5nv1Y+mFO5ABzXJ/vrL/i4QuS3g=;
        b=SyHGetQv749vIx1WB4d0axBZFeGKBZGQNXqOpq4bMPSZTx+lSIsxkxS/bumUSSD/AS
         Y8zcTRwwDAGagroFxEubJxOiOE1Z5c9KsxrtY/cEgz++DuShfiW3xWZ2zN0zIGJWL/EX
         6hqhZwxGenhyt5JkIGZmvD/INrtz6dNsTVPwjcU1lqTCXepBS+hoQXrAblE/ENR+xZ4h
         4J8QKp5/WpnqSq8ONG+o5u7mltSym8dLz/a6iQb5MolXJbaD7xmxyIOLYuhi+essKu00
         UeLCuSB/2FOt+IobFmTyLUqieXP+n/YmLsYccBWEqEQ29rCU1RNuyZERlsDZ3C1EZY/Y
         Dc1A==
X-Gm-Message-State: AOAM533lOovaNio16gfCi2CD5Hb4Ltu+m5dbRVyTEkq3rS73ETjoOp6+
        a9rIiVRFkQBmFwqu1XcAO0qVQlK3EMlOuriOlHY=
X-Google-Smtp-Source: ABdhPJyp5vaDm5cMFcShScbr2bQavu2srcO7z5Dh1HtuIYVlxJVLZyGoEOQyvBjTFBNIqJ332LB9PNWYwJoTFn5rz+4=
X-Received: by 2002:a25:d84a:: with SMTP id p71mr23577312ybg.347.1596825637882;
 Fri, 07 Aug 2020 11:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr> <20200807172353.GA624812@myrica>
In-Reply-To: <20200807172353.GA624812@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 7 Aug 2020 11:40:26 -0700
Message-ID: <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jakov Petrina <jakov.petrina@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 7, 2020 at 10:24 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Hi,
>
> [Adding the linux-arm-kernel list on Cc]
>
> On Fri, Aug 07, 2020 at 04:20:58PM +0200, Jakov Petrina wrote:
> > Hi everyone,
> >
> > recently we have begun extensive research into eBPF and related
> > technologies. Seeking an easier development process, we have switched over
> > to using the eBPF CO-RE [0] approach internally which has enabled us to
> > simplify most aspects of eBPF development, especially those related to
> > cross-compilation.
> >
> > However, as part of these efforts we have stumbled upon several problems
> > that we feel would benefit from a community discussion where we may share
> > our solutions and discuss alternatives moving forward.
> >
> > As a reference point, we have started researching and modifying several eBPF
> > CO-RE samples that have been developed or migrated from existing `bcc`
> > tooling. Most notable examples are those present in `bcc`'s `libbpf-tools`
> > directory [1]. Some of these samples have just recently been converted to
> > respective eBPF CO-RE variants, of which the `tcpconnect` tracing sample has
> > proven to be very interesting.
> >
> > First showstopper for cross-compiling aforementioned example on the ARM
> > 32-bit platform has been with regards to generation of the required
> > `vmlinux.h` kernel header from the BTF information. More specifically, our
> > initial approach to have e.g. a compilation target dependency which would
> > invoke `bpftool` at configure time was not appropriate due to several
> > issues: a) CO-RE requires host kernel to have been compiled in such a way to
> > expose BTF information which may not available, and b) the generated
> > `vmlinux.h` was actually architecture-specific.
> >
> > The second point proved interesting because `tcpconnect` makes use of the
> > `BPF_KPROBE` and `BPF_KRETPROBE` macros, which pass `struct pt_regs *ctx` as
> > the first function parameter. The `pt_regs` structure is defined by the
> > kernel and is architecture-specific. Since `libbpf` does have
> > architecture-specific conditionals, pairing it with an "invalid" `vmlinux.h`
> > resulted in cross-compilation failure as `libbpf` provided macros that work
> > with ARM `pt_regs`, and `vmlinux.h` had an x86 `pt_regs` definition. To
> > resolve this issue, we have resorted to including pre-generated
> > `<arch>_vmlinux.h` files in our CO-RE build system.
> >
> > However, there are certainly drawbacks to this approach: a) (relatively)
> > large file size of the generated headers, b) regular maintenance to
> > re-generate the header files for various architectures and kernel versions,
> > and c) incompatible definitions being generated, to name a few. This last
> > point relates to the the fact that our `aarch64`/`arm64` kernel generates
> > the following definition using `bpftool`, which has resulted in compilation
> > failure:
> >
> > ```
> > typedef __Poly8_t poly8x16_t[16];
> > ```
> >
> > AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> > have opted to comment out this line as there was no additional `poly8x16_t`
> > usage in the header file.
>
> It looks like this "__Poly8_t" type is internal to GCC (provided in
> arm_neon.h) and clang has its own internals. I managed to reproduce this
> with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> the moment. Maybe libbpf should generate defines to translate these
> intrinsics between clang and gcc? Not very elegant. I'll take another
> look next week.

libbpf is already blacklisting __builtin_va_list for GCC, so we can
just add __Poly8_t to the list. See [0].
Are there any other types like that? If you guys can provide me this,
I'll gladly update libbpf to take those compiler-provided
types/built-ins into account.

  [0] https://github.com/torvalds/linux/blob/master/tools/lib/bpf/btf_dump.c#L585-L598

>
> > Given various issues we have encountered so far (among which is a kernel
> > panic/crash on a specific device), additional input and feedback regarding
> > cross-compilation of the eBPF utilities would be greatly appreciated.
>
> I don't know if there is a room for improvement regarding your a) and b)
> points, as I think the added complexity is inherent to cross-building. But
> kernel crashes definitely need to be fixed, as well as the above problem.
>
> Thanks,
> Jean

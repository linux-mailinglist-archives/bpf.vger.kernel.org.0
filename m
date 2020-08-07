Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4BF23F32E
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGTqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 15:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTqW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 15:46:22 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FBC061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 12:46:22 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a34so1580853ybj.9
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2020 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoIsNrXAGCPCBofi/MfTU7pE6FOeWnAiD5RrtUD7OK4=;
        b=P+O4w7UCI0vrvjPI2gbs/DrWlMjMuQsxBdAJkz8uP4REGaTeI8kDhp+bymsVqbEtNg
         Q72RlSSsOLaXx09XLhFgPEecB/MRXhm/17ofAeyMo3LPIZGlFMImAPmt5A9EAiq0EyHX
         Rw9mxCOAChoI3XaFD5iAgIsaBh3dcWiWsEarb0KmgD6gzSixiDYoftF14m2Zibfy7y8H
         bCtxDJm3lQzKDptQLWtCadP/PYyg0CVifWmfSMr5nekp/sv/7WsHUlvY4Mox6s4D6Nt+
         +DN2UdkCwI1HZr1qkm8Wm4dLL0BdK69vwXP4pyyukGa31P5HuTZ/nDTCNu/MThic1lX9
         t18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoIsNrXAGCPCBofi/MfTU7pE6FOeWnAiD5RrtUD7OK4=;
        b=CSLBRnhcQ7DlTjlLUSS5LmRxJ+E5Xtt5FxT2khOMe57plGs2ZhiguhoXKGbLC9+86W
         gXMSiXIoY12N/hicjENnVgCDcn/7dRdCnkd7gn0B9vb9rB4jmh04kaglIv20A2uuf36T
         hrgY9j1C1sQQJjdpuW35AGmpRW+YPMJP2tCx4tYqK9hCciCU5qxnUYLoyr8AHikIbMN6
         +Xl1wsgSk8glNFnWKzGEALwzmPeZB30OaZq3AsiNQ1cQBt8deB0vrZaDj05CMd97r0up
         f7LM51LqqpJGlgclqlIJG0XJR6r+zXRMFGAcn16JmGKuGE2MB19jeLAsrf32syKKa71N
         54GA==
X-Gm-Message-State: AOAM53217eVK+SSk9wrrHFqJJXMF+4B0erZdlVVyoq8/ARTFSU993pfH
        xjbiYx8Naj2OvkXLjoHOYftGsvBxrCKYxggs5tQ=
X-Google-Smtp-Source: ABdhPJwjL+8cxeM25ZuAm7/8bX2Xg6zbNEm5jMWAfrT5TDIqysQ429COqnSU52xhQrQO57f0G1yw5mCBALC3W+UO1wQ=
X-Received: by 2002:a25:84cd:: with SMTP id x13mr22984660ybm.425.1596829581756;
 Fri, 07 Aug 2020 12:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
In-Reply-To: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 7 Aug 2020 12:46:10 -0700
Message-ID: <CAEf4BzYp2WFq7xZxOs9DwBzXE743nuMLjxTLh5xL36CJqnQmvw@mail.gmail.com>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Jakov Petrina <jakov.petrina@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 7, 2020 at 7:21 AM Jakov Petrina <jakov.petrina@sartura.hr> wrote:
>
> Hi everyone,
>
> recently we have begun extensive research into eBPF and related
> technologies. Seeking an easier development process, we have switched
> over to using the eBPF CO-RE [0] approach internally which has enabled
> us to simplify most aspects of eBPF development, especially those
> related to cross-compilation.

Great!

>
> However, as part of these efforts we have stumbled upon several problems
> that we feel would benefit from a community discussion where we may
> share our solutions and discuss alternatives moving forward.
>
> As a reference point, we have started researching and modifying several
> eBPF CO-RE samples that have been developed or migrated from existing
> `bcc` tooling. Most notable examples are those present in `bcc`'s
> `libbpf-tools` directory [1]. Some of these samples have just recently
> been converted to respective eBPF CO-RE variants, of which the
> `tcpconnect` tracing sample has proven to be very interesting.
>
> First showstopper for cross-compiling aforementioned example on the ARM
> 32-bit platform has been with regards to generation of the required
> `vmlinux.h` kernel header from the BTF information. More specifically,
> our initial approach to have e.g. a compilation target dependency which
> would invoke `bpftool` at configure time was not appropriate due to
> several issues: a) CO-RE requires host kernel to have been compiled in
> such a way to expose BTF information which may not available, and b) the
> generated `vmlinux.h` was actually architecture-specific.

That's not exactly true, about "CO-RE requires host kernel to have
been compiled...". You can pass any kernel image as a parameter to
bpftool as an input to generate vmlinux.h for that target
architecture. The only limitation right now, I think, is that their
endianness have to match. We'll probably get over this limitation some
time by end of this year, though.

So in your case, I'd recommend to generate per-architecture vmlinux.h
and use the appropriate one when you cross-compile. I don't think we
ever intended to support single CO-RE BPF binary across architectures,
given it's not too bad to compile same code one time for each target
architecture. Compiling once for each kernel version/variant was much
bigger problem, which is what we tackled.

>
> The second point proved interesting because `tcpconnect` makes use of
> the `BPF_KPROBE` and `BPF_KRETPROBE` macros, which pass `struct pt_regs
> *ctx` as the first function parameter. The `pt_regs` structure is
> defined by the kernel and is architecture-specific. Since `libbpf` does
> have architecture-specific conditionals, pairing it with an "invalid"
> `vmlinux.h` resulted in cross-compilation failure as `libbpf` provided
> macros that work with ARM `pt_regs`, and `vmlinux.h` had an x86
> `pt_regs` definition. To resolve this issue, we have resorted to
> including pre-generated `<arch>_vmlinux.h` files in our CO-RE build system.

yep, see above, that's what I'd do as well.

>
> However, there are certainly drawbacks to this approach: a) (relatively)
> large file size of the generated headers, b) regular maintenance to
> re-generate the header files for various architectures and kernel
> versions, and c) incompatible definitions being generated, to name a
> few. This last point relates to the the fact that our `aarch64`/`arm64`
> kernel generates the following definition using `bpftool`, which has
> resulted in compilation failure:
>
> ```
> typedef __Poly8_t poly8x16_t[16];
> ```
>
> AFAICT these are ARM NEON intrinsic definitions which are GCC-specific.
> We have opted to comment out this line as there was no additional
> `poly8x16_t` usage in the header file.

Ok, so for a) why the size of vmlinux.h is a big factor? You use it on
host machine during compilation only, after that you don't have to
distribute it anywhere. I just checked the size of vmlinux.h we use to
write BPF programs for production, it's at 2.5MB. Having even few of
those (if you need x86 + ARM32 + ARM64 + s390x + whatever) isn't a big
deal, IMO, you can just check them in into your source control system?
If the size is a concern, I'd be curious to hear why.

b) Hm.. how often do you intend to re-geneate them? Unless you are
using some bleeding-edge and volatile features of kernel and/or
compiled-in drivers, you shouldn't need to re-generate it all that
often. Maybe once every kernel release, maybe even less frequently. We
update those vmlinux.h only when there is some new set of features
(e.g., bpf_iter) added and we need those types, or when we get a new
major kernel version bump. So far so good. But your constraints might
differ, so I'd like to learn more.

c) I addressed in another reply. BTF dumper in libbpf maintains a list
of types that are compiler-provided and avoid generating types for
them, assuming compiler will have them. So far we've handled it simply
for __builtin_va_list, we can probably do something like that here as
well?

>
> Given various issues we have encountered so far (among which is a kernel
> panic/crash on a specific device), additional input and feedback
> regarding cross-compilation of the eBPF utilities would be greatly
> appreciated.
>

Please report the panic with more details separately. If you are
referring to cross-compiling libbpf-tools in BCC repo, we can play
with that, generate a separate vmlinux.<arch>.h. It's a bit hard for
me to test as I don't have easy access to anything beyond x86-64, so
some help from other folks would be very appreciated.

> [0]
> https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html
> [1] https://github.com/iovisor/bcc/tree/master/libbpf-tools
>
> Best regards,
>
> Sartura eBPF Team

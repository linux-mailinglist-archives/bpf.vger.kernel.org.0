Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9216B23F1E4
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 19:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGRYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgHGRYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 13:24:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08641C061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 10:24:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so2824915ejd.13
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2020 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eyQgcKKa6sa8KC5xVdsdC/+RP8gsTOEmgKv3cyYA1MY=;
        b=RburP0850JrB1ImGEcqvCCrS0FPCzgg8OzjYrP/lLOpPt1c790kxesPUc0C7v69Ey2
         sFMmbGQMqDnvOSBxAOOOVxWaS5++MIiU1Jxf6OFavQ6CeA5LqnXlsAGMGfuY1dvlKE/X
         534vpIRsy9LmEDu8kLzHSCXZtuBUtOyLxEd7/L+/emEA6vu4lLPEg4W6Zq1cnNtWqN+z
         qnsD8iaqmn2lwh7OXOeeqRFKk/BRLoj+oOwcQ0Nh6ziqePbnbszAJEIfYzoZ1QS1GB1P
         gTDvuxe42jwAE2DaRfe8WHAkaD+JsUxewtxx6asZsFf7Qcd1s5BKe7tntPNm6aVK5SVR
         KnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eyQgcKKa6sa8KC5xVdsdC/+RP8gsTOEmgKv3cyYA1MY=;
        b=Z82JWUdjYaCQqb405WMUlHhP2FDlTv3uNDTTtQCj+AQ7TYX3kU1Dj+JdYKu9/gDcfS
         PMIFeR/chfjEk+vgXq8jicmHTo86Jr+t7o/3ovP/m6D7MZpA06CqSs10lRf9/RuN09ri
         JmvjjaFmhsddZhz/A5YmZ/2iL5ka9CgGGhusm1gcRHeE0NlsfKu5GMhJIFo0zDqwisMj
         /Yw8/qR2g5M+js4EPY/DEyUxbVrDfzU0CUUj+uNKNnUIrutcJSojgcBu6lD7GiH4UsSN
         McX45x5h+9hY74RrVofyJHmEzRKyDQ4u7zRWFM3nhPVhpkPO897XHtadmedQDyB0oJGo
         K3WA==
X-Gm-Message-State: AOAM530l62frPIv8K5iSLkwQSYNfCn3/cDZTVOB2PlILEy9tH4NLKnkq
        rNPfulCsTMm8i1MtNbr6xrm0zg==
X-Google-Smtp-Source: ABdhPJwd0kaCd8LoGMztjNARsWWNmMLRIR5iHEiPUMWU+JMxTyu36tKm/5HGQGV58Ickq2qC8g5W5w==
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr9967342eja.222.1596821049838;
        Fri, 07 Aug 2020 10:24:09 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id e8sm5704686edy.68.2020.08.07.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:24:09 -0700 (PDT)
Date:   Fri, 7 Aug 2020 19:23:53 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jakov Petrina <jakov.petrina@sartura.hr>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
Message-ID: <20200807172353.GA624812@myrica>
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

[Adding the linux-arm-kernel list on Cc]

On Fri, Aug 07, 2020 at 04:20:58PM +0200, Jakov Petrina wrote:
> Hi everyone,
> 
> recently we have begun extensive research into eBPF and related
> technologies. Seeking an easier development process, we have switched over
> to using the eBPF CO-RE [0] approach internally which has enabled us to
> simplify most aspects of eBPF development, especially those related to
> cross-compilation.
> 
> However, as part of these efforts we have stumbled upon several problems
> that we feel would benefit from a community discussion where we may share
> our solutions and discuss alternatives moving forward.
> 
> As a reference point, we have started researching and modifying several eBPF
> CO-RE samples that have been developed or migrated from existing `bcc`
> tooling. Most notable examples are those present in `bcc`'s `libbpf-tools`
> directory [1]. Some of these samples have just recently been converted to
> respective eBPF CO-RE variants, of which the `tcpconnect` tracing sample has
> proven to be very interesting.
> 
> First showstopper for cross-compiling aforementioned example on the ARM
> 32-bit platform has been with regards to generation of the required
> `vmlinux.h` kernel header from the BTF information. More specifically, our
> initial approach to have e.g. a compilation target dependency which would
> invoke `bpftool` at configure time was not appropriate due to several
> issues: a) CO-RE requires host kernel to have been compiled in such a way to
> expose BTF information which may not available, and b) the generated
> `vmlinux.h` was actually architecture-specific.
> 
> The second point proved interesting because `tcpconnect` makes use of the
> `BPF_KPROBE` and `BPF_KRETPROBE` macros, which pass `struct pt_regs *ctx` as
> the first function parameter. The `pt_regs` structure is defined by the
> kernel and is architecture-specific. Since `libbpf` does have
> architecture-specific conditionals, pairing it with an "invalid" `vmlinux.h`
> resulted in cross-compilation failure as `libbpf` provided macros that work
> with ARM `pt_regs`, and `vmlinux.h` had an x86 `pt_regs` definition. To
> resolve this issue, we have resorted to including pre-generated
> `<arch>_vmlinux.h` files in our CO-RE build system.
> 
> However, there are certainly drawbacks to this approach: a) (relatively)
> large file size of the generated headers, b) regular maintenance to
> re-generate the header files for various architectures and kernel versions,
> and c) incompatible definitions being generated, to name a few. This last
> point relates to the the fact that our `aarch64`/`arm64` kernel generates
> the following definition using `bpftool`, which has resulted in compilation
> failure:
> 
> ```
> typedef __Poly8_t poly8x16_t[16];
> ```
> 
> AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> have opted to comment out this line as there was no additional `poly8x16_t`
> usage in the header file.

It looks like this "__Poly8_t" type is internal to GCC (provided in
arm_neon.h) and clang has its own internals. I managed to reproduce this
with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
the moment. Maybe libbpf should generate defines to translate these
intrinsics between clang and gcc? Not very elegant. I'll take another
look next week.

> Given various issues we have encountered so far (among which is a kernel
> panic/crash on a specific device), additional input and feedback regarding
> cross-compilation of the eBPF utilities would be greatly appreciated.

I don't know if there is a room for improvement regarding your a) and b)
points, as I think the added complexity is inherent to cross-building. But
kernel crashes definitely need to be fixed, as well as the above problem.

Thanks,
Jean

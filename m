Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558AA1E87BD
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 21:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2T1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2T1G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 15:27:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCAFC03E969
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 12:27:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so1639382plr.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o/t21DOf3N4tU3q9CHLKe4uAPhKpGjNd6jUKhRTo7Pw=;
        b=C3BYX09WdYjGq3THgqRtIpX1kmXGTzdTjyvnJTXDcMbGuWUQAZA0ntUajAy2AsM5J3
         4BT26rKrS9RgdJAeimaPzZLqBvcCEj00rQymm1Tt8jqS/LEc6HqrTjT6xASBAQqzQMig
         iHpw94VcQUYfOzJffP6KUqLz/ZEdLCyigHOUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/t21DOf3N4tU3q9CHLKe4uAPhKpGjNd6jUKhRTo7Pw=;
        b=DbcdQhDHTixeQAMhyug4wD2hD/8QBzqq8OJPjmFzMvq/78iXIXhR5jWlo6i9t+8w0K
         LMuB56H9JHachMyoT20g1evQxjPGauQ0OFexRKh/3j1HwsBhmpPgo14Xi6DKHZeDkk4M
         cUkatwpo7NF4L1b2fSvkBi7ZuxfX1FtoFNq5SxRQR65/kwDANDYuruPJJxZPS5DM281t
         th+FqW7X34F7+x1YR1YGqoiTSxAHB7CSS8pYTtseVtAUJuiv0MHIjISfuU27kw/nVvkJ
         puw5TEDaP3BRhPxknCk8mNgfDqoAE/sDXYCYBqQd4Eq4Hpd5kR7VRs24Vda4ria3PPbO
         J4Fg==
X-Gm-Message-State: AOAM531Je/ofyNRLzwpm4EmQtSbY3cXd0VJXeeYT0KiqEMm28cG81F3p
        KfnoPS8B6/JopTvLApy+pjyELg==
X-Google-Smtp-Source: ABdhPJwpDHVpkT7XWfMKgzeXt9Zai0pArlJJUrlzK2q7jlmWeLfEStY3jHhhr3icXxEA51QG3pIaow==
X-Received: by 2002:a17:90a:cb13:: with SMTP id z19mr103549pjt.169.1590780425670;
        Fri, 29 May 2020 12:27:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm2246320pfr.2.2020.05.29.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:27:04 -0700 (PDT)
Date:   Fri, 29 May 2020 12:27:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202005291043.A63D910A8@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005290903.11E67AB0FD@keescook>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 29, 2020 at 09:09:28AM -0700, Kees Cook wrote:
> On Fri, May 29, 2020 at 08:43:56AM -0700, Alexei Starovoitov wrote:
> > I don't think your hunch at where cpu is spending cycles is correct.
> > Could you please do two experiments:
> > 1. try trivial seccomp bpf prog that simply returns 'allow'
> > 2. replace bpf_prog_run_pin_on_cpu() in seccomp.c with C code
> >   that returns 'allow' and make sure it's noinline or in a different C file,
> >   so that compiler doesn't optimize the whole seccomp_run_filters() into a nop.
> > 
> > Then measure performance of both.
> > I bet you'll see exactly the same numbers.
> 
> Android has already done this, it appeared to not be the same. Calling
> into a SECCOMP_RET_ALLOW filter had a surprisingly high cost. I'll see
> if I can get you the numbers. I was frankly quite surprised -- I
> understood the bulk of the seccomp overhead to be in taking the TIF_WORK
> path, copying arguments, etc, but something else is going on there.

So while it's not the Android measurements, here's what I'm seeing on
x86_64 (this is hardly a perfect noiseless benchmark, but sampling error
appears to close to 1%):


net.core.bpf_jit_enable=0:

Benchmarking 16777216 samples...
10.633756139 - 0.004359714 = 10629396425
getpid native: 633 ns
23.008737499 - 10.633967641 = 12374769858
getpid RET_ALLOW 1 filter: 737 ns
36.723141843 - 23.008975696 = 13714166147
getpid RET_ALLOW 2 filters: 817 ns
47.751422021 - 36.723345630 = 11028076391
getpid BPF-less allow: 657 ns
Estimated total seccomp overhead for 1 filter: 104 ns
Estimated total seccomp overhead for 2 filters: 184 ns
Estimated seccomp per-filter overhead: 80 ns
Estimated seccomp entry overhead: 24 ns
Estimated BPF overhead per filter: 80 ns


net.core.bpf_jit_enable=1:
net.core.bpf_jit_harden=1:

Benchmarking 16777216 samples...
31.939978606 - 21.275190689 = 10664787917
getpid native: 635 ns
43.324592380 - 31.940794751 = 11383797629
getpid RET_ALLOW 1 filter: 678 ns
55.001650599 - 43.326293248 = 11675357351
getpid RET_ALLOW 2 filters: 695 ns
65.986452855 - 55.002249904 = 10984202951
getpid BPF-less allow: 654 ns
Estimated total seccomp overhead for 1 filter: 43 ns
Estimated total seccomp overhead for 2 filters: 60 ns
Estimated seccomp per-filter overhead: 17 ns
Estimated seccomp entry overhead: 26 ns
Estimated BPF overhead per filter: 24 ns


net.core.bpf_jit_enable=1:
net.core.bpf_jit_harden=0:

Benchmarking 16777216 samples...
10.684681435 - 0.004198682 = 10680482753
getpid native: 636 ns
22.050823167 - 10.685571417 = 11365251750
getpid RET_ALLOW 1 filter: 677 ns
33.714134291 - 22.051100183 = 11663034108
getpid RET_ALLOW 2 filters: 695 ns
44.793312551 - 33.714383001 = 11078929550
getpid BPF-less allow: 660 ns
Estimated total seccomp overhead for 1 filter: 41 ns
Estimated total seccomp overhead for 2 filters: 59 ns
Estimated seccomp per-filter overhead: 18 ns
Estimated seccomp entry overhead: 23 ns
Estimated BPF overhead per filter: 17 ns


The above is from my (very dangerous!) benchmarking patch[1].

So, with the layered nature of seccomp filters there's a reasonable gain
to be seen for a O(1) bitmap lookup to skip running even a single filter,
even for the fastest BPF mode.

Not that we need to optimize for the pathological case, but this would
be especially useful for cases like systemd, which appears to be
constructing seccomp filters very inefficiently maybe on a per-syscall[3]
basis? For example, systemd-resolved has 32 (!) seccomp filters
attached[2]:

# grep ^Seccomp_filters /proc/$(pidof systemd-resolved)/status
Seccomp_filters:        32

# grep SystemCall /lib/systemd/system/systemd-resolved.service
SystemCallArchitectures=native
SystemCallErrorNumber=EPERM
SystemCallFilter=@system-service

I'd like to better understand what they're doing, but haven't had time
to dig in. (The systemd devel mailing list requires subscription, so
I've directly CCed some systemd folks that have touched seccomp there
recently. Hi! The starts of this thread is here[4].)

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=seccomp/benchmark-bpf&id=20cc7d8f4238ea3bc1798f204bb865f4994cca27
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/seccomp&id=9d06f16f463cef5c445af9738efed2bfe4c64730
[3] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#SystemCallFilter=
[4] https://lore.kernel.org/bpf/c22a6c3cefc2412cad00ae14c1371711@huawei.com/

-- 
Kees Cook

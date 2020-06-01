Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B41EAC6F
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgFASgc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbgFASQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 14:16:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9DC03E96B
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 11:16:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so1823207pfa.12
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gaFkZYsYYFJyyx55DGTF9A7EdpoNLAP59WZ+rERt0uM=;
        b=ghePNO8rIozpiTI1KKBRaL6PDserKLG92k+jNnAuF0dhxLEmR+oICYa0HILWic8GnX
         0l84MgoEZIKPOW4Kc7+D4DrX/3R+CTISxRpQo0TpkE6RTJS7/gd4fymZWo3yNORP7I+y
         x0DpHB6sCYPF/Z76naSOIuZsx5jpvgzRX6kQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gaFkZYsYYFJyyx55DGTF9A7EdpoNLAP59WZ+rERt0uM=;
        b=UbSexruYJXkWe32p6m13V/Gkl8cTp/KXIuvs9oN95OBZ+UWTs0LX1WYvlcPXvTgkPj
         RXrz/7xqAPZXljX6jAfGCgHyOK0/F/tPJh/7zYHt4DwC36iA19JzatsrG+ilPpTqxDD5
         VmkRyu93v4cPIYSK2xoOvuaD0yFxFkJ5FghDl7N1TVpFntLiGPOhg39clVEMT8C6um/2
         N6VQLWDgyAUdgtaGfI2uz9/b6V050vBjh6+DgrZJBMWxvdztqY58paF6egHx7pgtU7CY
         WRSyMePG6h01oWo/lAgGuhGCZopKEqPaNoLYcfNBLo6Lxgi14zmuvHlUJrAULHv6YNaJ
         JzpA==
X-Gm-Message-State: AOAM530FZ63pjPiL6aDJkiVt622C/6rD1jS0d6KRDyHY5koPPrTN1RjR
        JIW3Rt66sGunNLYFLBOeFRtw3Q==
X-Google-Smtp-Source: ABdhPJybGLkEiF1x3eks6bpgb0gC2n+ttaw4z8cSr+utx8q/utgBnkp0pT3UB7M/Q1v3YNSv3la41g==
X-Received: by 2002:a62:7a89:: with SMTP id v131mr2130192pfc.38.1591035376884;
        Mon, 01 Jun 2020 11:16:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm138517pgu.61.2020.06.01.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:16:15 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:16:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        daniel@iogearbox.net, netdev@vger.kernel.org
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202006011106.8766849C2@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 31, 2020 at 10:19:15AM -0700, Alexei Starovoitov wrote:
> Thank you for crafting a benchmark.
> The only thing that it's not doing a fair comparison.
> The problem with that patch [1] that is using:
> 
> static noinline u32 __seccomp_benchmark(struct bpf_prog *prog,
>                                         const struct seccomp_data *sd)
> {
>         return SECCOMP_RET_ALLOW;
> }
> 
> as a benchmarking function.
> The 'noinline' keyword tells the compiler to keep the body of the function, but
> the compiler is still doing full control and data flow analysis though this
> function and it is smart enough to optimize its usage in seccomp_run_filters()
> and in __seccomp_filter() because all functions are in a single .c file.
> Lots of code gets optimized away when 'f->benchmark' is on.
> 
> To make it into fair comparison I've added the following patch
> on top of your [1].
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 2fdbf5ad8372..86204422e096 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -244,7 +244,7 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>         return 0;
>  }
> 
> -static noinline u32 __seccomp_benchmark(struct bpf_prog *prog,
> +__weak noinline u32 __seccomp_benchmark(struct bpf_prog *prog,
>                                         const struct seccomp_data *sd)
> 
> Please take a look at 'make kernel/seccomp.s' before and after to see the difference
> __weak keyword makes.

Ah yeah, thanks. That does bring it up to the same overhead. Nice!

> And here is what seccomp_benchmark now reports:
> 
> Benchmarking 33554432 samples...
> 22.618269641 - 15.030812794 = 7587456847
> getpid native: 226 ns
> 30.792042986 - 22.619048831 = 8172994155
> getpid RET_ALLOW 1 filter: 243 ns
> 39.451435038 - 30.792836778 = 8658598260
> getpid RET_ALLOW 2 filters: 258 ns
> 47.616011529 - 39.452190830 = 8163820699
> getpid BPF-less allow: 243 ns
> Estimated total seccomp overhead for 1 filter: 17 ns
> Estimated total seccomp overhead for 2 filters: 32 ns
> Estimated seccomp per-filter overhead: 15 ns
> Estimated seccomp entry overhead: 2 ns
> Estimated BPF overhead per filter: 0 ns
> 
> [...]
> 
> > So, with the layered nature of seccomp filters there's a reasonable gain
> > to be seen for a O(1) bitmap lookup to skip running even a single filter,
> > even for the fastest BPF mode.
> 
> This is not true.
> The O(1) bitmap implemented as kernel C code will have exactly the same speed
> as O(1) bitmap implemented as eBPF program.

Yes, that'd be true if it was the first (and only) filter. What I'm
trying to provide is a mechanism to speed up the syscalls for all
attached filters (i.e. create a seccomp fast-path). The reality of
seccomp usage is that it's very layered: systemd sets some (or many!),
then container runtime sets some, then the process itself might set
some.

-- 
Kees Cook

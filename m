Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF3226FC7
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGTUh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgGTUh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 16:37:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2BC061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 13:37:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so9242107plo.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnRGd7BTxptsRTTL5a4l+TjnqeNtG3LJ+lEpBTFNdVA=;
        b=YCnKvB24XKu6GS/d2QzptGRX67bu94s5XwUi+eeiWf6MQ0vMjchl0tFUz6WzCaQ1o6
         clj/x2JHHwdwT0fUX6cppMbUKPnZw4wIASEMznAms24pzVjX8jYGRi4gwgIRLwc0XG+F
         Ab4t+KvLLycggt4vrcZQ+JZAbNH/Rddjz0ZAINRnfagcedxie9qGSPIqOvHNF1Pe4+qJ
         c3bvXdDBc4l5sNOAyeHDC2MfuzkuCUDNr7bJKbRZeFBPO1I9KsWvW+n1ko20qk09c37O
         c59mTx/p8iqUio/yNugPd2z1VysKo6rZ4EcrZX6b+TfZCQsQNAxqAqxfcUFKQ8H682Dy
         8izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnRGd7BTxptsRTTL5a4l+TjnqeNtG3LJ+lEpBTFNdVA=;
        b=aRgdjmT2nqR9z7sDlS3W9OJvy49dGL04iF73Qv4tby+Bgc8b2Fyv6N1jBoR4ruJyaO
         K9ot14NthWsOzVMPvZD1ToFlIG88ktpTThP0CXFwsXtpHYJ4cAEWmqbHcfG1l0NYqeDe
         Nqua6o60fZ9TMUm0+LyXSAHESgq7t0e/EwU4hzNUxR2whBuUr6yaXVQQnqWADvOLjXws
         5ICOyYf/T/yYGd4GCLym1qKqcVZH2xoBXPZyl01qUXA2tcXOGelzcNp9qJ2Eq1XaMVUx
         1cebnbVwHUAO8+3tBG+EjhEykWD55Nr29iLA7v0RKBKEb0NuE6/I/KGLqYwh3iwJw0Ae
         wHwA==
X-Gm-Message-State: AOAM533nVRIWwpzTCk5KveGw7mfR+i4rR+0We+8grByHzjPVXeh52VXZ
        Ql1Y58o6Wbd3e1LIGcT40aQ=
X-Google-Smtp-Source: ABdhPJxefAKYhQajvFDOdQp3xcw2rYjPbKruPlyMlMC0gp7c578Mr3p98KfHbEGiTyYB0R82e7mfhg==
X-Received: by 2002:a17:90b:196:: with SMTP id t22mr1208215pjs.13.1595277477891;
        Mon, 20 Jul 2020 13:37:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e3b])
        by smtp.gmail.com with ESMTPSA id d18sm452932pjv.25.2020.07.20.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:37:56 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:37:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Verification speed w/ KASAN builds
Message-ID: <20200720203755.icfvzannjwqusbes@ast-mbp.dhcp.thefacebook.com>
References: <CACAyw9_g6mgg_DoYpbMaWpE8BQAC+S5XG8U4aw1JAMoOxiDtPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw9_g6mgg_DoYpbMaWpE8BQAC+S5XG8U4aw1JAMoOxiDtPQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 17, 2020 at 11:46:37AM +0100, Lorenz Bauer wrote:
> Hi list,
> 
> I'm not sure whether this is a bug report or just the way of life.
> The problem: we have a couple of machines that run KASAN
> kernels to weed out bugs. On those machines, loading our
> cls-redirect TC classifier takes so long that our user space
> program aborts.
> 
> I've reproduced this in a VM: loading cls-redirect on a VM
> with a 5.4 kernel without KASAN takes around 4 seconds.
> Doing the same on recent bpf-next with KASAN and other
> shenanigans enabled it takes more like a minute.

a minute to load single program? that sounds high.
While processing patches I build the kernel with kasan and lockdep.
None of test_progs and test_verifier programs have such drastic
slowdowns. I'm not sure what is the reason.
do you use kasan inline or outline ?

> Is it expected that the overhead of KASAN is this large?

sounds like 20x overhead ? I think 10x is normal.

> I went and collected a perf profile of loading the program
> in the VM:
> 
> -   96.31%     1.00%  redirect.test  [kernel.kallsyms]  [k] do_check_common
>    - 95.32% do_check_common
>       - 69.24% states_equal.isra.0
>          + 49.81% kmem_cache_alloc_trace
>          + 16.77% kfree
>          + 1.22% regsafe.part.0
>       - 12.75% push_stack
>          - 10.65% copy_verifier_state
>             - 4.50% realloc_stack_state
>                + 4.48% __kmalloc
>             + 4.16% kmem_cache_alloc_trace
>             + 1.82% __kmalloc
>          + 2.07% kmem_cache_alloc_trace
>       + 5.25% pop_stack
>       + 2.84% push_jmp_history.isra.0
>       + 2.46% copy_verifier_state
>       + 1.00% free_verifier_state
>         0.53% kmem_cache_alloc_trace
>    + 1.00% runtime.goexit

the perf profile makes sense.
how many insn it processed?
what are test_progs -s stats ?

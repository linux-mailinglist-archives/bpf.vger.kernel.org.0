Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92559276103
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 21:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWT0T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIWT0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 15:26:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B71C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 12:26:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so260531pfn.8
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nXAM48zLIdF0YA6ut5vJsreIXLyrnpqRvhnrLrqXYJc=;
        b=Hdm+Z0AQ2YfXEdqTM/jmmXNuadizpSWELj7b/lSwr3w3mZLQny01AXlIxmcvmz89JX
         TZ/2xB2j92zPNFDUwR8fZharEUzCJmtl46sYIkw4JWRgQ4ltt1xFIh9QyH7PNQtmowfu
         yVycTgKDm02BteKPPlI+QSaXmN/Z6gtg/ww+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXAM48zLIdF0YA6ut5vJsreIXLyrnpqRvhnrLrqXYJc=;
        b=Ho646fIgI3/na3cxbwOeV7mDhsC+4tkkCF5VWhovQxgd6JRxKyx/mJEmvI6+p9s2ky
         BN87lOu3ZhkvnayyoO+fSwrgooqPGZtvbL5GhEFnrWTuuWaIoEkch2jlinlZBxHxfCvM
         JAyPXKElpsdCH/nRvV7uGHxPHuiHdS96AEW4Du+TPesSm5DlbR+zvQnL3AagmCj5/YyD
         8t/yUOJu4iMI9vKHLTrauMsfqnCMsnD3rdOHgz3x9E1TDeacqLJIhLwU0E7io2mdRF20
         PuulrD4yEzVEefDdEaSFKT4dgnG8vnfb2vJWc7fq0QACQ/eVYnbntnVryk/eJ7vTy/9C
         kcTQ==
X-Gm-Message-State: AOAM533GU9V8g9HXwa6B9YXQkRkeITMJldNeAVn/DFISsf1f40K8Mp6g
        Imvz02M9Xpdr55oJbIO0xWZJmQ==
X-Google-Smtp-Source: ABdhPJyM7dxxYK6y0p1u34cW0GjWXGoONrvCkA8LAJVejzdmZSSDiKSh4T1QlGwsBRZsNpPsK+DKQw==
X-Received: by 2002:a65:5786:: with SMTP id b6mr1062182pgr.114.1600889178892;
        Wed, 23 Sep 2020 12:26:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4sm576348pgk.19.2020.09.23.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 12:26:17 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:26:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
Message-ID: <202009231224.21BCB3BC6@keescook>
References: <cover.1600661418.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600661418.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 12:35:16AM -0500, YiFei Zhu wrote:
> In the past Kees proposed [2] to have an "add this syscall to the
> reject bitmask". It is indeed much easier to securely make a reject
> accelerator to pre-filter syscalls before passing to the BPF
> filters, considering it could only strengthen the security provided
> by the filter. However, ultimately, filter rejections are an
> exceptional / rare case. Here, instead of accelerating what is
> rejected, we accelerate what is allowed. In order not to compromise
> the security rules the BPF filters defined, any accept-side
> accelerator must complement the BPF filters rather than replacing them.

Did you see the RFC series for this?

https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/

> Without cache, seccomp_benchmark:
>   Current BPF sysctl settings:
>   net.core.bpf_jit_enable = 1
>   net.core.bpf_jit_harden = 0
>   Calibrating sample size for 15 seconds worth of syscalls ...
>   Benchmarking 23486415 syscalls...
>   16.079642020 - 1.013345439 = 15066296581 (15.1s)
>   getpid native: 641 ns
>   32.080237410 - 16.080763500 = 15999473910 (16.0s)
>   getpid RET_ALLOW 1 filter: 681 ns
>   48.609461618 - 32.081296173 = 16528165445 (16.5s)
>   getpid RET_ALLOW 2 filters: 703 ns
>   Estimated total seccomp overhead for 1 filter: 40 ns
>   Estimated total seccomp overhead for 2 filters: 62 ns
>   Estimated seccomp per-filter overhead: 22 ns
>   Estimated seccomp entry overhead: 18 ns
> 
> With cache:
>   Current BPF sysctl settings:
>   net.core.bpf_jit_enable = 1
>   net.core.bpf_jit_harden = 0
>   Calibrating sample size for 15 seconds worth of syscalls ...
>   Benchmarking 23486415 syscalls...
>   16.059512499 - 1.014108434 = 15045404065 (15.0s)
>   getpid native: 640 ns
>   31.651075934 - 16.060637323 = 15590438611 (15.6s)
>   getpid RET_ALLOW 1 filter: 663 ns
>   47.367316169 - 31.652302661 = 15715013508 (15.7s)
>   getpid RET_ALLOW 2 filters: 669 ns
>   Estimated total seccomp overhead for 1 filter: 23 ns
>   Estimated total seccomp overhead for 2 filters: 29 ns
>   Estimated seccomp per-filter overhead: 6 ns
>   Estimated seccomp entry overhead: 17 ns
> 
> Depending on the run estimated seccomp overhead for 2 filters can be
> less than seccomp overhead for 1 filter, resulting in underflow to
> estimated seccomp per-filter overhead:
>   Estimated total seccomp overhead for 1 filter: 27 ns
>   Estimated total seccomp overhead for 2 filters: 21 ns
>   Estimated seccomp per-filter overhead: 18446744073709551610 ns
>   Estimated seccomp entry overhead: 33 ns

Which also includes updated benchmarking:

https://lore.kernel.org/lkml/20200616074934.1600036-6-keescook@chromium.org/

-- 
Kees Cook

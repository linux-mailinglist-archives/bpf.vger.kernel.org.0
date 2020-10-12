Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8468328C50B
	for <lists+bpf@lfdr.de>; Tue, 13 Oct 2020 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbgJLW5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbgJLW5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 18:57:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA9C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 15:57:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x16so15922841pgj.3
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ho1l607OAVVmLnoWlMqhfwRhJkqSim+LddBz61r0Qos=;
        b=JJQ4S6hWNOQEK+Sy3Y+6MHvE6gOOcxmTo+VnXkRAr4YZg1jAzA2NjbHn3GiUPeK8gf
         0ipw1LXDfr3tEdWE6dRrL6M12460zyb+sjoMJRNxEoEbW1Tj6e5VYs12zu49n5jFE+ag
         LA//Dq0oC90jGuPSuhQwam8VrIDDiTx3NpK3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ho1l607OAVVmLnoWlMqhfwRhJkqSim+LddBz61r0Qos=;
        b=XNTuGI7qW8Ox5cDn3tRfQ0PApdCSeVm/6EdSclFXYfOU3qiDApuAfs4GR5aMvxItEj
         SPwuSFT0mAUjCxizu2aO12nUvdMSGr9RLNixZucBh2xflhf4t5DrTh9t3qFLdtqqp7lq
         tggaiLjM3UPwEWOIkT9I1pfWzD9oBY1eVuN3bnBE7ztOshWIe3lfNC+H7MUlJRYnUO42
         EhDWL60XcK/dpAvFgdM/hW07DpUzigsvesjV7ttxfbEwLKKItmtV+d9g4GumG9EnOcMc
         co4G5JBkw4Nw7apeE6GO7V1giUBFVM9rVZIcSqZmdLq9X+ZWDBqEnVFF67J6hdby/3QO
         SfJQ==
X-Gm-Message-State: AOAM533/0dYVUuXPFqD5lbWB1SlfUV21NA9SNyLF6KkU4My1IlOHSgQd
        DsNAYZs4JcnByEX3W6Y70cKZjw==
X-Google-Smtp-Source: ABdhPJxRLYOMHo59Ns0oO1+b1TTIgg1tJPZTI/F+6kwXefZKFzuOW2ptOTYCFNOKi97y0iBzVBYADg==
X-Received: by 2002:a17:90a:a782:: with SMTP id f2mr2869911pjq.50.1602543458516;
        Mon, 12 Oct 2020 15:57:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm20479216pfi.129.2020.10.12.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:57:37 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:57:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202010121556.1110776B83@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook>
 <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 10, 2020 at 08:26:16AM -0500, YiFei Zhu wrote:
> On Fri, Oct 9, 2020 at 6:14 PM Kees Cook <keescook@chromium.org> wrote:
> > HAVE_ARCH_SECCOMP_CACHE isn't used any more. I think this was left over
> > from before.
> 
> Oh, I was meant to add this to the dependencies of
> SECCOMP_CACHE_DEBUG. Is this something that would make sense?

I think it's fine to just have this "dangle" with a help text update of
"if seccomp action caching is supported by the architecture, provide the
/proc/$pid ..."

-- 
Kees Cook

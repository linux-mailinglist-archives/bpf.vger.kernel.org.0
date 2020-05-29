Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3F1E8339
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2QJc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 12:09:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4659C03E969
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 09:09:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so1311075plt.12
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7tFtwZgvZE5hW33XbmmKt8eqRyrQtOfEzKnpZP3Z4fw=;
        b=GYoiy6jTScqVloKoIjwXCzc+l+EG1hBVzc+mtPa5HPhYQ+A9L305gHi07UgwFOnw0T
         dmosi0h18RvyDg3UGAzomXNRW6wIzIZZL3hZWylaxIlGuYfTHyHke0x3akAlw9VyfnG6
         WTl5A0LIqRV7YK4EIxscvhAZaoHgOBRPACxHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7tFtwZgvZE5hW33XbmmKt8eqRyrQtOfEzKnpZP3Z4fw=;
        b=e7oJIdQ+T6X8Z3jkpuXsaVwJmjwZKVwvKb4d8V9YevQTcV0lxqH/AzjzCsQcwNv671
         94lu2WUnIpeARmTLBSlC90XIqrGk4IhI5KvGP6ZAHSRWeW83kG+zPsU4oXTaULNt85g9
         ejFQmtk6IDmRHrjAx16s46wiuZkXJRN6tLOVDAL29OntRV/PC3mTJojVNef9yFs1rOTC
         x9pkMqwfXsq3gLFZs4/V5W6PE56mCEzr+kmLzzbuekhQ8jhAUdoA9j+2EDwISShnDJZS
         ZvQfCqjSFH+9qE9qkCbqhO8hqiSUep/nq7igyFRsIGMw+Y5K6Z1BSDRntdHnrw2+wP2r
         2k8Q==
X-Gm-Message-State: AOAM5328AMYXMWbQMe33C15LiYlXtACvCN22OnE8isLgMClBACJ5VTSR
        uy27hYP4S2OfDMO6nbDzF2zpXQ==
X-Google-Smtp-Source: ABdhPJwiF0InviA286xZMds7P6A3F23qpGlkmzD4rF6zE18n7jXKvqQI9cH5t4J0qPX2tBr2hsnccA==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr10570641pjo.35.1590768570208;
        Fri, 29 May 2020 09:09:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm1993834pfr.2.2020.05.29.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:09:29 -0700 (PDT)
Date:   Fri, 29 May 2020 09:09:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202005290903.11E67AB0FD@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 29, 2020 at 08:43:56AM -0700, Alexei Starovoitov wrote:
> On Fri, May 29, 2020 at 5:50 AM zhujianwei (C) <zhujianwei7@huawei.com> wrote:
> >
> > Hi, all
> >
> > 　　We're using seccomp to increase container security, but bpf rules filter causes performance to deteriorate. So, is there a good solution to improve performance, or can we add a simplified seccomp mode to improve performance?

Yes, there are already plans for a simple syscall bitmap[1] seccomp feature.

> I don't think your hunch at where cpu is spending cycles is correct.
> Could you please do two experiments:
> 1. try trivial seccomp bpf prog that simply returns 'allow'
> 2. replace bpf_prog_run_pin_on_cpu() in seccomp.c with C code
>   that returns 'allow' and make sure it's noinline or in a different C file,
>   so that compiler doesn't optimize the whole seccomp_run_filters() into a nop.
> 
> Then measure performance of both.
> I bet you'll see exactly the same numbers.

Android has already done this, it appeared to not be the same. Calling
into a SECCOMP_RET_ALLOW filter had a surprisingly high cost. I'll see
if I can get you the numbers. I was frankly quite surprised -- I
understood the bulk of the seccomp overhead to be in taking the TIF_WORK
path, copying arguments, etc, but something else is going on there.

-Kees

[1] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/

-- 
Kees Cook

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33B7D7109
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2019 10:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfJOIap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 04:30:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfJOIap (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 04:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nde+rVxrbKGORynbc7srtKQrRn/wfiVC6y4tD1FT7B0=; b=YbFbFpEk4DpWY6RLhaLCvmJiX
        Aux8/sNbH48tsLFO5JH6caRTG0co+m0pmYYidLAW8/Lla9Ygzk0kpPQr9UvMWWAxylSf9bNlQB9BW
        7w7HkmmJ6GBaPp0Om+i17i7ed9q7icxuLV9zpcLLmRNv/5VspmqDE7gMu22tjcHUnmeDpU8VNDHjY
        KO+y7VmPxVO1I1MlZjm9p4Idv0lnNtxhNH/mOmvzD45K44F/RuNRVgko6j6rkccPhgot44PNlvIwB
        jocNU+1j2OpQHEWDy5tT9leSUdXiNvXaQpdagTRQ9Ssnk3I5RvxVJ8xgt0vpvqoInIiFI4AmF1BOC
        Ked5/SBpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKIDe-0005F7-3A; Tue, 15 Oct 2019 08:30:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4E8A303807;
        Tue, 15 Oct 2019 10:29:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3CD0284DE58D; Tue, 15 Oct 2019 10:30:08 +0200 (CEST)
Date:   Tue, 15 Oct 2019 10:30:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, James Morris <jmorris@namei.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191015083008.GC2311@hirez.programming.kicks-ass.net>
References: <20191014170308.70668-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014170308.70668-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 14, 2019 at 01:03:08PM -0400, Joel Fernandes (Google) wrote:
> In current mainline, the degree of access to perf_event_open(2) system
> call depends on the perf_event_paranoid sysctl.  This has a number of
> limitations:
> 
> 1. The sysctl is only a single value. Many types of accesses are controlled
>    based on the single value thus making the control very limited and
>    coarse grained.
> 2. The sysctl is global, so if the sysctl is changed, then that means
>    all processes get access to perf_event_open(2) opening the door to
>    security issues.
> 
> This patch adds LSM and SELinux access checking which will be used in
> Android to access perf_event_open(2) for the purposes of attaching BPF
> programs to tracepoints, perf profiling and other operations from
> userspace. These operations are intended for production systems.
> 
> 5 new LSM hooks are added:
> 1. perf_event_open: This controls access during the perf_event_open(2)
>    syscall itself. The hook is called from all the places that the
>    perf_event_paranoid sysctl is checked to keep it consistent with the
>    systctl. The hook gets passed a 'type' argument which controls CPU,
>    kernel and tracepoint accesses (in this context, CPU, kernel and
>    tracepoint have the same semantics as the perf_event_paranoid sysctl).
>    Additionally, I added an 'open' type which is similar to
>    perf_event_paranoid sysctl == 3 patch carried in Android and several other
>    distros but was rejected in mainline [1] in 2016.
> 
> 2. perf_event_alloc: This allocates a new security object for the event
>    which stores the current SID within the event. It will be useful when
>    the perf event's FD is passed through IPC to another process which may
>    try to read the FD. Appropriate security checks will limit access.
> 
> 3. perf_event_free: Called when the event is closed.
> 
> 4. perf_event_read: Called from the read(2) and mmap(2) syscalls for the event.
> 
> 5. perf_event_write: Called from the ioctl(2) syscalls for the event.
> 
> [1] https://lwn.net/Articles/696240/
> 
> Since Peter had suggest LSM hooks in 2016 [1], I am adding his
> Suggested-by tag below.

Thanks, I've queued the patch!

> To use this patch, we set the perf_event_paranoid sysctl to -1 and then
> apply selinux checking as appropriate (default deny everything, and then
> add policy rules to give access to domains that need it). In the future
> we can remove the perf_event_paranoid sysctl altogether.

This I'm not sure about; the sysctl is only redundant when you actually
use a security thingy, not everyone is. I always find them things to be
mightily unfriendly.


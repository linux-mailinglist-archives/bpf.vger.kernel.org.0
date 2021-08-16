Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454973ED348
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhHPLrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhHPLrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 07:47:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513AC061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hUmXKpthCqFixCGLx46fXKkcCF+fEjM9AmprhKk7Zs8=; b=ePRxg7Ugd/yAXJNqBcAFWRL4Tt
        lN4+yWA8yoiYoWvAN/pgqqgxqRjdraN1TBl6m5Q8YcnqXzU86bBXGtefz2aq04wcbeyqs/J+seRKw
        HwGXefPQ8I6vWoRvnjQaWsxAaPua7CTpil+HNEZvv+sAmC3x7DIxXybq8KfRNfb+N0rJRIUbKtLqJ
        Jrk/wDsCRlUpPKMQPz38ZkGZmZKTQ3zwd+y7e2VIohg8N7qF5CFnqKa5R5cpZrPe52FgJSZ5O9CSY
        AVgIfLR5Ox5UzCI/7e/QysYKb+rMYc9QllfpBTJN86LO8rs2/czSeEvo69ZP9rOKwE6yiAZCJxIB3
        i2Sy6g4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFb4l-00ABMa-5G; Mon, 16 Aug 2021 11:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4E6C3014F6;
        Mon, 16 Aug 2021 13:46:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FCDE2028D932; Mon, 16 Aug 2021 13:46:41 +0200 (CEST)
Date:   Mon, 16 Aug 2021 13:46:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v5 bpf-next 05/16] bpf: allow to specify user-provided
 bpf_cookie for BPF perf links
Message-ID: <YRpQIVVlxNs/Iu6F@hirez.programming.kicks-ass.net>
References: <20210815070609.987780-1-andrii@kernel.org>
 <20210815070609.987780-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815070609.987780-6-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 15, 2021 at 12:05:58AM -0700, Andrii Nakryiko wrote:
> Add ability for users to specify custom u64 value (bpf_cookie) when creating
> BPF link for perf_event-backed BPF programs (kprobe/uprobe, perf_event,
> tracepoints).
> 
> This is useful for cases when the same BPF program is used for attaching and
> processing invocation of different tracepoints/kprobes/uprobes in a generic
> fashion, but such that each invocation is distinguished from each other (e.g.,
> BPF program can look up additional information associated with a specific
> kernel function without having to rely on function IP lookups). This enables
> new use cases to be implemented simply and efficiently that previously were
> possible only through code generation (and thus multiple instances of almost
> identical BPF program) or compilation at runtime (BCC-style) on target hosts
> (even more expensive resource-wise). For uprobes it is not even possible in
> some cases to know function IP before hand (e.g., when attaching to shared
> library without PID filtering, in which case base load address is not known
> for a library).
> 
> This is done by storing u64 bpf_cookie in struct bpf_prog_array_item,
> corresponding to each attached and run BPF program. Given cgroup BPF programs
> already use two 8-byte pointers for their needs and cgroup BPF programs don't
> have (yet?) support for bpf_cookie, reuse that space through union of
> cgroup_storage and new bpf_cookie field.
> 
> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> program execution code, which luckily is now also split from
> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> giving access to this user-provided cookie value from inside a BPF program.
> Generic perf_event BPF programs will access this value from perf_event itself
> through passed in BPF program context.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  drivers/media/rc/bpf-lirc.c    |  4 ++--
>  include/linux/bpf.h            | 16 +++++++++++++++-
>  include/linux/perf_event.h     |  1 +
>  include/linux/trace_events.h   |  6 +++---
>  include/uapi/linux/bpf.h       |  7 +++++++
>  kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/events/core.c           | 21 ++++++++++++++-------
>  kernel/trace/bpf_trace.c       |  8 +++++---
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  10 files changed, 73 insertions(+), 28 deletions(-)
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

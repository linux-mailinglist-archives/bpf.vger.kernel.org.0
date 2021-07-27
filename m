Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202FB3D7A02
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhG0Pk4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 11:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhG0Pk4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Jul 2021 11:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627400456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtAgD2nw4ScGzNrBsnQIV3OYTC9KY3HqeJP64powmuI=;
        b=KtI6mI+6DmggtELpySb5GfcqMMczW4mVY/LcIGDL64E3w1sbOoFA+JgDyHWw2n9YPqgktb
        Vc4AhriFhcYV78xZmQxgayeIxu4ooHsQE4qRbQh5cCTaNg2NohrMSl3Y4dXJlu0eaUDtP2
        qdVkNwQi8kIJBCYuSamix2WJXHCtstE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-PeeXdGUpPqS-CZIEyXOLjg-1; Tue, 27 Jul 2021 11:40:54 -0400
X-MC-Unique: PeeXdGUpPqS-CZIEyXOLjg-1
Received: by mail-wm1-f69.google.com with SMTP id d72-20020a1c1d4b0000b029025164ff3ebfso810464wmd.7
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 08:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtAgD2nw4ScGzNrBsnQIV3OYTC9KY3HqeJP64powmuI=;
        b=Mvpe4pu0C/7KnXeHs7otwxiTXAOOcY1M7NkVuvHaZb/VEdRRGqHrV5lC7EY8VpVnwM
         QPIZaAs+/lK4z+wS72/p0SI1CaFECEMWtA7E/83JmakK8CQKoG4TLD3EInOMAnpS6sZn
         SUUsMRihn07c+eITirdQ9WgyHJqRVBBIbK5D6mmohoxwqWqlnsHSTrnJ4LZv11lahEHL
         Gm5pcCseQkncefly3+v9LgoRzt/4wVDO+VeBVk4Wp2L2afJOwnCv8GcTkjNcOOpo5CQh
         OjPvcsVPSrAMPliJ6KBcS18LRJLDVaQL6/UqbWZXlnY0LZbX/FyQL3K8qxWGrhfQK09O
         JgGw==
X-Gm-Message-State: AOAM532zXymXZhVhp0gYGSJiRT8HM8XV8Xjwok5R9GZZD+8P8WND5C6c
        rwHpr+AZLsbV96xo0P2Eg7B7BNuhRoOrAZhLdPxFU3zM+o+vxYS6IxzEaCi/x8aQkMOPKaavlaK
        IX8b1znYQjDoU
X-Received: by 2002:a5d:40c6:: with SMTP id b6mr11476685wrq.222.1627400453611;
        Tue, 27 Jul 2021 08:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlny2B5bkKcboXKftTfDAxCllKQy3/R1F92d5+TBCVKxjgS/e/8WR/PyyiDuj9OWrmHuW9EA==
X-Received: by 2002:a5d:40c6:: with SMTP id b6mr11476663wrq.222.1627400453336;
        Tue, 27 Jul 2021 08:40:53 -0700 (PDT)
Received: from krava ([83.240.61.166])
        by smtp.gmail.com with ESMTPSA id h9sm3759231wrw.38.2021.07.27.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:40:53 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:40:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
Message-ID: <YQApAyKpMOSGYhSu@krava>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726161211.925206-5-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 09:12:01AM -0700, Andrii Nakryiko wrote:
> Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
> BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
> the common BPF link infrastructure, allowing to list all active perf_event
> based attachments, auto-detaching BPF program from perf_event when link's FD
> is closed, get generic BPF link fdinfo/get_info functionality.
> 
> BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
> are currently supported.
> 
> Force-detaching and atomic BPF program updates are not yet implemented, but
> with perf_event-based BPF links we now have common framework for this without
> the need to extend ioctl()-based perf_event interface.
> 
> One interesting consideration is a new value for bpf_attach_type, which
> BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
> bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
> bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
> BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
> program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
> mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
> define a single BPF_PERF_EVENT attach type for all of them and adjust
> link_create()'s logic for checking correspondence between attach type and
> program type.
> 
> The alternative would be to define three new attach types (e.g., BPF_KPROBE,
> BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
> and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
> libbpf. I chose to not do this to avoid unnecessary proliferation of
> bpf_attach_type enum values and not have to deal with naming conflicts.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_types.h      |   3 +
>  include/linux/trace_events.h   |   3 +
>  include/uapi/linux/bpf.h       |   2 +
>  kernel/bpf/syscall.c           | 105 ++++++++++++++++++++++++++++++---
>  kernel/events/core.c           |  10 ++--
>  tools/include/uapi/linux/bpf.h |   2 +
>  6 files changed, 112 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index a9db1eae6796..0a1ada7f174d 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -135,3 +135,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
>  #ifdef CONFIG_NET
>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
>  #endif
> +#ifdef CONFIG_PERF_EVENTS
> +BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> +#endif
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index ad413b382a3c..8ac92560d3a3 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
>  void perf_trace_buf_update(void *record, u16 type);
>  void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
>  
> +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> +void perf_event_free_bpf_prog(struct perf_event *event);
> +
>  void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
>  void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
>  void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2db6925e04f4..00b1267ab4f0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -993,6 +993,7 @@ enum bpf_attach_type {
>  	BPF_SK_SKB_VERDICT,
>  	BPF_SK_REUSEPORT_SELECT,
>  	BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
> +	BPF_PERF_EVENT,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> @@ -1006,6 +1007,7 @@ enum bpf_link_type {
>  	BPF_LINK_TYPE_ITER = 4,
>  	BPF_LINK_TYPE_NETNS = 5,
>  	BPF_LINK_TYPE_XDP = 6,
> +	BPF_LINK_TYPE_PERF_EVENT = 6,

hi, should be 7

jirka


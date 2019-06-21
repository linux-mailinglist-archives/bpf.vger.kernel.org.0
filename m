Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7031E4F070
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2019 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUVVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jun 2019 17:21:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46855 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUVVM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jun 2019 17:21:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so4185012pfy.13
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2019 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lf/zzWbu1p+7OZLhl2YtTpKCGw8MMulN9uhF5nuMqCI=;
        b=r3U4/GAx1NlqiBaFHo4dgUuRt4R1I113stunqIxHWb8g8lre/apwMg5gHcounI4nsG
         sCkUj3QnxtRPW+v0FYbq189D3k5Cv9RW+0Jv1k6CWP9UDa0NKdp/EmqZLHScc7C/zOMQ
         3JqLXMwnpW5bbP4vGKo1r+qafrfYTu4ZcYJIuqbdEamPS4eo+bZh/hOdbSY6VxJXN3Ws
         6OnD21PM9KCRrVg2KIfLg2ZRKQil+RlryMWz9sX3FPsCO6Y5EMvQe6mxDlz0dIzKA4Vy
         7mnPZTW3hgv4PtV0b442JOlQHiojqkWv7GP73l5LOT9Xp09/KFblinDc7hOetX2uBIFN
         GG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lf/zzWbu1p+7OZLhl2YtTpKCGw8MMulN9uhF5nuMqCI=;
        b=n1gIIJlUuSRmHK6WJ/vAAm3iH83JW1I1JGJaNjxJi/DRnKbbhYc5dilRYd3ZFhb+nq
         uZhKvE7hoP0DT6UUPGAr+VawyrXKVO0ROD3HK6ekiWxxx5b6CFCIRFdGbXoRP/m7wq2F
         Kr+qIHgAP5fBzSMkYJN4kKRYdoAas8ZyTvZZEg5g5hvqr3Kjzkwp4jkJtnYL9/M+MZNo
         c3GcbQCu3JNDTdjA0ca3MIafZetDiTMqE1Rqju6IDVrMiK+V+MpXV/xvSN1ob3kwwYfO
         reE+HrjPaYFFwSlQ0LTb+VR+mxd3Qv55UFL6P+eE6qbZi6VEC8fdmasJ/hsm85xnKJDa
         TRAg==
X-Gm-Message-State: APjAAAUDTTmskejAIZQCsXTIJlvRAXiqJN8BImGA04xvpFROBzxIdXKR
        IHK/3sffnyiBD1TG9cHFj4+F3Q==
X-Google-Smtp-Source: APXvYqxeI+sdlGgEjcfeFJKlxpAJ9zOhTuvdbI3+rOcVFkRl6SEr8gF4p42xLM8MfC54zCNdCDwqGQ==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr9313573pjq.41.1561152072111;
        Fri, 21 Jun 2019 14:21:12 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id x3sm4205768pja.7.2019.06.21.14.21.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 14:21:11 -0700 (PDT)
Date:   Fri, 21 Jun 2019 14:21:10 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, ast@fb.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/7] libbpf: add tracing attach APIs
Message-ID: <20190621212110.GG1383@mini-arch>
References: <20190621045555.4152743-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621045555.4152743-1-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/20, Andrii Nakryiko wrote:
> This patchset adds the following APIs to allow attaching BPF programs to
> tracing entities:
> - bpf_program__attach_perf_event for attaching to any opened perf event FD,
>   allowing users full control;
> - bpf_program__attach_kprobe for attaching to kernel probes (both entry and
>   return probes);
> - bpf_program__attach_uprobe for attaching to user probes (both entry/return);
> - bpf_program__attach_tracepoint for attaching to kernel tracepoints;
> - bpf_program__attach_raw_tracepoint for attaching to raw kernel tracepoint
>   (wrapper around bpf_raw_tracepoint_open);
> 
> This set of APIs makes libbpf more useful for tracing applications.
> 
> Pre-patch #1 makes internal libbpf_strerror_r helper function work w/ negative
> error codes, lifting the burder off callers to keep track of error sign.
> Patch #2 adds attach_perf_event, which is the base for all other APIs.
> Patch #3 adds kprobe/uprobe APIs.
> Patch #4 adds tracepoint/raw_tracepoint APIs.
> Patch #5 converts one existing test to use attach_perf_event.
> Patch #6 adds new kprobe/uprobe tests.
> Patch #7 converts all the selftests currently using tracepoint to new APIs.
> 
> v1->v2:
> - preserve errno before close() call (Stanislav);
> - use libbpf_perf_event_disable_and_close in selftest (Stanislav);
> - remove unnecessary memset (Stanislav);
Reviewed-by: Stanislav Fomichev <sdf@google.com>

Thanks!

> Andrii Nakryiko (7):
>   libbpf: make libbpf_strerror_r agnostic to sign of error
>   libbpf: add ability to attach/detach BPF to perf event
>   libbpf: add kprobe/uprobe attach API
>   libbpf: add tracepoint/raw tracepoint attach API
>   selftests/bpf: switch test to new attach_perf_event API
>   selftests/bpf: add kprobe/uprobe selftests
>   selftests/bpf: convert existing tracepoint tests to new APIs
> 
>  tools/lib/bpf/libbpf.c                        | 346 ++++++++++++++++++
>  tools/lib/bpf/libbpf.h                        |  17 +
>  tools/lib/bpf/libbpf.map                      |   6 +
>  tools/lib/bpf/str_error.c                     |   2 +-
>  .../selftests/bpf/prog_tests/attach_probe.c   | 151 ++++++++
>  .../bpf/prog_tests/stacktrace_build_id.c      |  49 +--
>  .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  24 +-
>  .../selftests/bpf/prog_tests/stacktrace_map.c |  42 +--
>  .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  14 +-
>  .../bpf/prog_tests/task_fd_query_rawtp.c      |  10 +-
>  .../bpf/prog_tests/task_fd_query_tp.c         |  51 +--
>  .../bpf/prog_tests/tp_attach_query.c          |  56 +--
>  .../selftests/bpf/progs/test_attach_probe.c   |  55 +++
>  13 files changed, 651 insertions(+), 172 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_probe.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe.c
> 
> -- 
> 2.17.1
> 

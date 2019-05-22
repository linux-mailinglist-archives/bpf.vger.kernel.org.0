Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D812686E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfEVQi4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 12:38:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36830 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfEVQi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 12:38:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so1345791plr.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q6e3szSuBA3TQ23tI+f5bOHG3uRdoTQTxnBgQCG0LO4=;
        b=CKnW4jfD3i9J1+AnqWpErIvI2smTcCqKPUxgzcjpUvqsRjQGlGc2K6a97A9iDjzGgl
         pZD3+AIGV/b3yMPXLMDkBAMnRatUqqS/tXLpx6MFOEBVmt21jiLu+5/Nz8raJjf7Kjps
         DKB36ic06Ur92uHZBCIhPT28J7tDEJYT7M1QDOfu3S8kSCraTjzZqc75Oath3UojZj0c
         aovC2Q5xcYV47vY6I+ksdod/cv94kX9FMOWC4jB/PMaq2AqLfxEGIyaCw6v3NftmRqMu
         b24uJcsUIZGAogZ6EvSVMQTQg+HjPsgfRaz/U9QsrlDMYPMiSMlXMUmfPpHMTgYbEPpX
         vmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q6e3szSuBA3TQ23tI+f5bOHG3uRdoTQTxnBgQCG0LO4=;
        b=dIPhOEkkBA3Dr6uQodXdCfPSZ+/V3c2/EbPhuV53qVgPDUFPyX7Q0rS8L+VQPy3dba
         lhbrRuggnAbH/vn5hhSfrMjw0CcHKCsaIwyi1Zz/oyC8mKQ6+gdd+0zz1pZSfulxCf4f
         P+Ak0D1uR8ExX5OzF+ZoiJLA2YSDPSWteGtx3H8QdRYo+oyVSYePiAGcDM3CmRKE883Q
         MvgZ4Fm8Z9RSgJqq/a3b8O0mJWyZBvcdIg4oY6cBIs6stqUd5hjgHECEqr2KQDorpkCN
         4H7rDla/CoK122ZaCtfR5s3nj0BweOBdnQcdbSofdVdJeCD4Ke7u8J1/EjKNDe5QqMPa
         9Y7g==
X-Gm-Message-State: APjAAAUkfxtouwenxxq9ej+oy+45idWDjXvbwUBlwHFesMq+smn5C49x
        CXfLNBaQ9zhW06S8cn/P0toTqQ==
X-Google-Smtp-Source: APXvYqzZfpzsmYoTHLr1nZD660u4hZlfkL7zM6oifzONv6hlMDwlxNcu1tfc6k5rnyo7CB6JKKGRIg==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr7691353plp.118.1558543135850;
        Wed, 22 May 2019 09:38:55 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d13sm22778368pfh.113.2019.05.22.09.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 09:38:55 -0700 (PDT)
Date:   Wed, 22 May 2019 09:38:54 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: implement bpf_send_signal() helper
Message-ID: <20190522163854.GJ10244@mini-arch>
References: <20190522053900.1663459-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522053900.1663459-1-yhs@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/21, Yonghong Song wrote:
> This patch tries to solve the following specific use case.
> 
> Currently, bpf program can already collect stack traces
> through kernel function get_perf_callchain()
> when certain events happens (e.g., cache miss counter or
> cpu clock counter overflows). But such stack traces are
> not enough for jitted programs, e.g., hhvm (jited php).
> To get real stack trace, jit engine internal data structures
> need to be traversed in order to get the real user functions.
> 
> bpf program itself may not be the best place to traverse
> the jit engine as the traversing logic could be complex and
> it is not a stable interface either.
> 
> Instead, hhvm implements a signal handler,
> e.g. for SIGALARM, and a set of program locations which
> it can dump stack traces. When it receives a signal, it will
> dump the stack in next such program location.
> 

[..]
> This patch implements bpf_send_signal() helper to send
> a signal to hhvm in real time, resulting in intended stack traces.
Series looks good. One minor nit/question: maybe rename bpf_send_signal
to something like bpf_send_signal_to_current/bpf_current_send_signal/etc?
bpf_send_signal is too generic now that you send the signal
to the current process..

> Patch #1 implemented the bpf_send_helper() in the kernel,
> Patch #2 synced uapi header bpf.h to tools directory.
> Patch #3 added a self test which covers tracepoint
> and perf_event bpf programs.
> 
> Changelogs:
>   RFC v1 => v2:
>     . previous version allows to send signal to an arbitrary
>       pid. This version just sends the signal to current
>       task to avoid unstable pid and potential races between
>       sending signals and task state changes for the pid.
> 
> Yonghong Song (3):
>   bpf: implement bpf_send_signal() helper
>   tools/bpf: sync bpf uapi header bpf.h to tools directory
>   tools/bpf: add a selftest for bpf_send_signal() helper
> 
>  include/uapi/linux/bpf.h                      |  17 +-
>  kernel/trace/bpf_trace.c                      |  67 ++++++
>  tools/include/uapi/linux/bpf.h                |  17 +-
>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  tools/testing/selftests/bpf/bpf_helpers.h     |   1 +
>  .../bpf/progs/test_send_signal_kern.c         |  51 +++++
>  .../selftests/bpf/test_send_signal_user.c     | 212 ++++++++++++++++++
>  7 files changed, 365 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>  create mode 100644 tools/testing/selftests/bpf/test_send_signal_user.c
> 
> -- 
> 2.17.1
> 

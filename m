Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E5364A9C
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhDSTeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbhDSTeg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 15:34:36 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E631C06174A;
        Mon, 19 Apr 2021 12:34:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z1so40125843ybf.6;
        Mon, 19 Apr 2021 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq+o53CjcKmne6Oi4Mg+lVs/a3KUX06V156SubAskog=;
        b=lwvkHTdN1TySEU+yGfzkMB99hVDAXMCGVCUbV2LQpKndOl+wXX/GTwZBwha6S1xHgt
         l1S495fSZKHZnOYeGhQshkIsNhiBdV2p2gJfRN0xr2w43uUhVJ4+PRwTfaNCQ/ruY99O
         3pLemwQr19ypWMmHkn1E+hP8ARc5qPXr3gV4khItwHLtid2lCBewJG8nbiSHCoUzyP+Z
         vdPZ7xdkbvlZU/nijUGPvN83Lxc3fXpobftkltbw9rKrx55WScT4UzsfsaH4sSzbfQQo
         Fi/zJUyhIn0V1Q7nSxQPX9tul3SsUI/oxSeDBIHKuWlErkCxDpwf8Su5AZXpDeLEED0d
         U5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq+o53CjcKmne6Oi4Mg+lVs/a3KUX06V156SubAskog=;
        b=KSOH7EcfwvIZWaySz6wi8lKt4H8VA4pXueUUXDMaFogTS8hiBAuq6rer6Tvl5+cdiI
         Q74lGE5zNYQ2MbKat7s5rRsq4eo/9HhSV4jJi5lHPQksRkrdCFsFUZkiY81Hq+lvHy0J
         Lj4xieQdIkWF9hCLrdZhiIbA7AD9+EB3LeMQsyvhEuK3ue6p/+S2VpkUE5d3WenPqZkQ
         EEvDt0wczqTU5He/vAGe6qTAXCW/7tGaysr1/JcuTtKEN0La/9yA4gVYbdoGyhlIuJra
         mYpF0AlTkJIXBMotlO6XqiDsCj6NLdNHanfnj/byhURzX0WCW2mMXEDwPoiBws3JeG8Y
         8rTQ==
X-Gm-Message-State: AOAM533eTMyqHsiFVlEex7tTM6adDmg8h3cvUTc6snl75sJf475D+cEZ
        wFIZ37I7Z8S+PKqe0uQmnrZAYTDaYtIHcu/DoyA0YY/pZjE=
X-Google-Smtp-Source: ABdhPJz1yn1TY8QJPD6V9DtEqB/zjuF+vI5ndbzOtIlkZtHG5CUfxXgk3zSU31oSz3RV53BiIOCcd4Tmocv7wYHAXAQ=
X-Received: by 2002:a25:dc46:: with SMTP id y67mr19747592ybe.27.1618860845439;
 Mon, 19 Apr 2021 12:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org>
In-Reply-To: <20210419155243.1632274-1-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Apr 2021 12:33:54 -0700
Message-ID: <CAEf4BzZoOVZrVz+aAnx3X3fow9tMA7YZxxe6C_uu+Xx6vy1Ofg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/6] Add a snprintf eBPF helper
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
>
> We have a usecase where we want to audit symbol names (if available) in
> callback registration hooks. (ex: fentry/nf_register_net_hook)
>
> A few months back, I proposed a bpf_kallsyms_lookup series but it was
> decided in the reviews that a more generic helper, bpf_snprintf, would
> be more useful.
>
> This series implements the helper according to the feedback received in
> https://lore.kernel.org/bpf/20201126165748.1748417-1-revest@google.com/T/#u
>
> - A new arg type guarantees the NULL-termination of string arguments and
>   lets us pass format strings in only one arg
> - A new helper is implemented using that guarantee. Because the format
>   string is known at verification time, the format string validation is
>   done by the verifier
> - To implement a series of tests for bpf_snprintf, the logic for
>   marshalling variadic args in a fixed-size array is reworked as per:
> https://lore.kernel.org/bpf/20210310015455.1095207-1-revest@chromium.org/T/#u
>
> ---
> Changes in v5:
> - Fixed the bpf_printf_buf_used counter logic in try_get_fmt_tmp_buf
> - Added a couple of extra incorrect specifiers tests
> - Call test_snprintf_single__destroy unconditionally
> - Fixed a C++-style comment
>
> ---
> Changes in v4:
> - Moved bpf_snprintf, bpf_printf_prepare and bpf_printf_cleanup to
>   kernel/bpf/helpers.c so that they get built without CONFIG_BPF_EVENTS
> - Added negative test cases (various invalid format strings)
> - Renamed put_fmt_tmp_buf() as bpf_printf_cleanup()
> - Fixed a mistake that caused temporary buffers to be unconditionally
>   freed in bpf_printf_prepare
> - Fixed a mistake that caused missing 0 character to be ignored
> - Fixed a warning about integer to pointer conversion
> - Misc cleanups
>
> ---
> Changes in v3:
> - Simplified temporary buffer acquisition with try_get_fmt_tmp_buf()
> - Made zero-termination check more consistent
> - Allowed NULL output_buffer
> - Simplified the BPF_CAST_FMT_ARG macro
> - Three new test cases: number padding, simple string with no arg and
>   string length extraction only with a NULL output buffer
> - Clarified helper's description for edge cases (eg: str_size == 0)
> - Lots of cosmetic changes
>
> ---
> Changes in v2:
> - Extracted the format validation/argument sanitization in a generic way
>   for all printf-like helpers.
> - bpf_snprintf's str_size can now be 0
> - bpf_snprintf is now exposed to all BPF program types
> - We now preempt_disable when using a per-cpu temporary buffer
> - Addressed a few cosmetic changes
>
> Florent Revest (6):
>   bpf: Factorize bpf_trace_printk and bpf_seq_printf
>   bpf: Add a ARG_PTR_TO_CONST_STR argument type
>   bpf: Add a bpf_snprintf helper
>   libbpf: Initialize the bpf_seq_printf parameters array field by field
>   libbpf: Introduce a BPF_SNPRINTF helper macro
>   selftests/bpf: Add a series of tests for bpf_snprintf
>
>  include/linux/bpf.h                           |  22 ++
>  include/uapi/linux/bpf.h                      |  28 ++
>  kernel/bpf/helpers.c                          | 306 ++++++++++++++
>  kernel/bpf/verifier.c                         |  82 ++++
>  kernel/trace/bpf_trace.c                      | 373 ++----------------
>  tools/include/uapi/linux/bpf.h                |  28 ++
>  tools/lib/bpf/bpf_tracing.h                   |  58 ++-
>  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++
>  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++
>  .../bpf/progs/test_snprintf_single.c          |  20 +
>  10 files changed, 770 insertions(+), 345 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
>
> --
> 2.31.1.368.gbe11c130af-goog
>

Looks great, thank you!

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

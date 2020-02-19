Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACF1652A6
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 23:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBSWrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 17:47:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45620 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWrm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 17:47:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id z5so1426915lfd.12;
        Wed, 19 Feb 2020 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTmndBpAP4Mw3qk0P0XsD0NoHsf5gj3SK5DonytGx7c=;
        b=fwGZAmZRzsMFXy1lRO3l/3TkJe6kDihJ1V5/+yJDq+nqT+peeY1AP4gBHF/ncduZQg
         PFdwh+MBTyxEFX8usxrBBmO9WZNY8OWNpA4vxXNDPd0f7ZqsJX5bNn74PO4cLIEvxTZG
         Oc/gInRbrBraEP8tviaQOHaaEa+od4rsqdzHU1UIC1NmA0VMg8kshjgoem0fZjkZ+BzU
         nHTM3lrGffm5/KOorCdnA6CYrDq0C9B2oO9nwmnvNyEEK9R/Qnf+U7BZAmqM+qti3fo4
         VnNkqwxxsniAqmIJxjQYjSa/s2TDA4sO+edC0QiF1Y9H/oHEWs2EYs/JbDVrdkgS6Jc0
         3Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTmndBpAP4Mw3qk0P0XsD0NoHsf5gj3SK5DonytGx7c=;
        b=lxePDvQvZ+fYa2joGLgN/Mpy7liI+qJdPOIYL3QU0X/Jv0BvTZ684PI9joJRE3uX0x
         Yyb+6uzDXk7xg3TX1CmsdU8n+bLTynz+ctSaFU7ff+Y13kVj/jCEsoali5eVIsvgcuhz
         tyDwPKBCa2v0CGCvCit4rhEtR/gzUn8m4UysdzGJT0gBzj3yYe/vRyJmGa4EgWPccqGb
         wTWXlXM2b7e9/Xq5w+owRcep7f5PmI+GH0Nydd9H+1fXeM0l2BKqus0YTxvNzu69c54m
         xWHDqXO6su+AyPjN9A9Tv4aA1npf0/WdR7tzxn6vJ/IDbysbMb7ZW0vBZyF3ELB7ve4v
         hWJw==
X-Gm-Message-State: APjAAAU0msDdxqIR39z+Ka8ALDHzCP4BSdZEbfmu45WLndZNGY/6676w
        0hyjQQE7nnWhPy+U1VUmKANNAYUhzoFwfO4tpuw=
X-Google-Smtp-Source: APXvYqy8HcTrPteWsRWUUhMXsuJOiPQSODf+C4YF2cg0VABtzDB61NZGU2YHrtcYeBnfYI8DQ0eb54FO3rOCszdyAPM=
X-Received: by 2002:a05:6512:68f:: with SMTP id t15mr3089849lfe.174.1582152460116;
 Wed, 19 Feb 2020 14:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20200218030432.4600-1-dxu@dxuuu.xyz> <20200218030432.4600-3-dxu@dxuuu.xyz>
In-Reply-To: <20200218030432.4600-3-dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Feb 2020 14:47:28 -0800
Message-ID: <CAADnVQKA3ZCEAynRQOaorAxF4hP2ZgCD=6UMbF5yMCtrR7hw9A@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 2/2] selftests/bpf: add bpf_read_branch_records()
 selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 17, 2020 at 7:04 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add a selftest to test:
>
> * default bpf_read_branch_records() behavior
> * BPF_F_GET_BRANCH_RECORDS_SIZE flag behavior
> * error path on non branch record perf events
> * using helper to write to stack
> * using helper to write to global
>
> On host with hardware counter support:
>
>     # ./test_progs -t perf_branches
>     #27/1 perf_branches_hw:OK
>     #27/2 perf_branches_no_hw:OK
>     #27 perf_branches:OK
>     Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> On host without hardware counter support (VM):
>
>     # ./test_progs -t perf_branches
>     #27/1 perf_branches_hw:OK
>     #27/2 perf_branches_no_hw:OK
>     #27 perf_branches:OK
>     Summary: 1/2 PASSED, 1 SKIPPED, 0 FAILED

That's not what I see:
./test_progs -t perf_branches
test_perf_branches_hw:FAIL:perf_event_open err -1
#27/1 perf_branches_hw:FAIL
#27/2 perf_branches_no_hw:OK
#27 perf_branches:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 2 FAILED

I remember previous version used to work, but something changed.

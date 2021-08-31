Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9E3FC1B9
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 06:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhHaEEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 00:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhHaEE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 00:04:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8DAC061575
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 21:03:35 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id n126so32316030ybf.6
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSyQ4AkyV+Hjoh7sSjzuWr5QiK7Mw8dUnqVEFAAjU0o=;
        b=q7pRdKQn2R7IfJ/NUadQh5SAuPAUfzkxA3RT5jgBpAE6XHMqnZHADhBnnpFNbUFJxu
         ychKkC51gvV7efMyZEazgQw7NiELv5XK+2D10uP3Pmr/WTMrBsGivbIdiU2JSW6GpWCR
         6bw7SZSSCfoccFvLMaIbgnBD5vleEqUzrOMF5Ku2KrFZ8kNzjqI9Pz+mwXGrOvTaE6zR
         JQZkDTm5Kn247SbzsmotS9p3rOk4/L5VVudy+LyIqI6ErzFdCviyu0mkEP1Ay9/SbqZP
         hG2APOO8+kreFNycLAsUkrLVTCSyuhEvyjMFHF2E5xZDUV4/EC3TkZBebNGJGSVirnxl
         SNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSyQ4AkyV+Hjoh7sSjzuWr5QiK7Mw8dUnqVEFAAjU0o=;
        b=F4HZZh6pQAWWmjdptYTxztjM1QfTRy3armYbBHL6sJfde3SrLszFl8Ny7wY/v8cR8Z
         QjSO5XXK134olzmJIrMipQn5Zs9O42ONOXgwQWNu0YSbLu68Ule516qRpjKC3R1s3uxl
         2KalqdWl/D02Bp9xpmaIs/jDlc+NX9dVVpctW0Cgx9rrFkLxqNnDMGEJXZ73QQ3dBu3M
         wSfdySd20ERaEl5jRFMtAUvKVaHXaqKubho3gz36aRRh4SHe7HCUGIsns7jkwV5ylGqr
         qcj3wTlEkBoB54MwjLQPjtnamNH0qKkkOWdqFAEn/yUSZKgvnCBmd7lRvSWSMVDvIDm0
         VGVw==
X-Gm-Message-State: AOAM530wUFfwXGkCMZUDwzNPqkyh+R+3xxHEtxamzMVNYWW/C0vkyEc2
        7wF+0RCRlDE7hVBDoUUdk1TsAVhNVmVL1hkepg0=
X-Google-Smtp-Source: ABdhPJypCE19buvJYACPIKnVA0uulQ4ick7GWhjIWULCQBTK0Cyeh70cegkjonmupFCyN+1yTRLiXNjQDpiN6zUoNGM=
X-Received: by 2002:a25:1e03:: with SMTP id e3mr26461573ybe.459.1630382614167;
 Mon, 30 Aug 2021 21:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210827231307.3787723-1-fallentree@fb.com>
In-Reply-To: <20210827231307.3787723-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 21:03:23 -0700
Message-ID: <CAEf4BzYK8=dwrTvV1c=+zC6cxPe7STE+k2MPDokMurKs0cHwGQ@mail.gmail.com>
Subject: Re: [RFC 0/1] add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 27, 2021 at 4:13 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch added a optional "-p" to test_progs to run tests in multiple
> process, speeding up the tests.
>
> Example:
>
> time ./test_progs
> real    5m51.393s
> user    0m4.695s
> sys    5m48.055s
>
> time ./test_progs -p 16 (on a 8 core vm)
> real    3m45.673s
> user    0m4.434s
> sys    5m47.465s
>
> The feedback area I'm looking for :
>
>   1.Some tests are taking too long to run (for example:
>   bpf_verif_scale/pyperf* takes almost 80% of the total runtime). If we
>   need a work-stealing pool mechanism it would be a bigger change.

Seems like you did just a static assignment based on worker number and
test number in this RFC. I think that's way too simplistic to work
well in practice. But I don't think we need a work stealing queue
either (not any explicit queue at all).

I'd rather go with a simple client/server model, where the server is
the main process which does all the coordination. It would "dispense"
task to each forked worker one by one, wait for that test to complete,
accumulating test's output in per-worker temporary output. If we are
running in verbose mode or a test failed, output accumulated logs. If
not verbose and test is successful, just emit a summary with test name
and OK message and discard accumulated output. I think we can easily
extend this to support running multiple sub-tests on *different*
workers, "breaking up" and scaling that bpf_verif_scale test nicely.
But that could be a pretty easy step #2 after the whole client/server
machinery is setup.

Look into Unix domain sockets (UDS). But not the SOCK_STREAM kind,
rather SOCK_DGRAM. UDS allows to establish bi-directional connection
between server and worker. And it preserves packet boundaries, so you
don't have TCP stream problems of delineating boundaries of logical
packets. And it preserves ordering between packets. All great
properties. With this we can set up client/server communication with a
very simple protocol:

1. Server sends "RUN_TEST" command, specifying the number of the test
to execute by the worker.
2. Worker sends back "TEST_COMPLETED" command with the test number,
test result (success, failure, skipped), and, optionally, console
output.
3. Repeat #1-#2 as many times as needed.
4. Server sends "SHUTDOWN" command and worker exits.

(Well, probably we need a bit more flexibility to report sub-test
successes, so maybe worker will have two possible messages:
SUBTEST_COMPLETED and TEST_COMPLETED, or something along those lines).

On the server side, we can use as suboptimal and simplistic locking
scheme as possible to coordinate everything. It's probably simplest to
have a thread per worker that would take global lock to take the next
test to run (just i++, but under lock). And just remember all the
statuses (and error outputs, for dumping failed tests details).

Some refactoring will be needed to make existing code work in both
non-parallelized and parallelized modes with minimal amount of
changes, but this seems simple enough.

>
>   2. The tests output from workers are currently interleaved from all
>   workers, making it harder to read, one option would be redirect all
>   outputs onto pipes and have main process collect and print in sequence
>   for each worker finish, but that will make seeing real time progress
>   harder.

Yeah, I don't think that's acceptable. Good news is that we needed
some more complexity to hold onto test output until the very end for
error summary reporting anyway.

>
>   3. If main process want to collect tests results from worker, I plan
>   to have each worker writes a stats file to /tmp, or I can use IPC, any
>   preference?

See above, I think UDS is the way to go.

>
>   4. Some tests would fail if run in parallel, I think we would need to
>   pin some tasks onto worker 0.

Yeah, we can mark such tests with some special naming convention
(e.g., to test_blahblah_noparallel) and run them sequentially.

>
> Yucong Sun (1):
>   selftests/bpf: Add parallelism to test_progs
>
>  tools/testing/selftests/bpf/test_progs.c | 94 ++++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h |  3 +
>  2 files changed, 91 insertions(+), 6 deletions(-)
>
> --
> 2.30.2
>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE427407182
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhIJSyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJSyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 14:54:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BDBC061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:53:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a4so5947132lfg.8
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQybZDc85m9eONoPiN1UxsVjoIn484TAQ2T26wH9QMQ=;
        b=qVE0QfqiplTWvQSriEl+n1CHZ26fKRJV6PrIwoHTBZi/dHrhAZt36VhrkrNzT9azTh
         wKrKYqUxL9wAik92wNyLiuL9FfRuec6+WRm9Ocf6TInc+Z6W3AUWizTgiz8v7sR5d3wt
         85jmqXOSwi4udbMp3GgJWi6haKd8JuFCwzzy/ovzThRfY/WKLj8kcAbb61Hmy0SFb/KQ
         SI6YwFieaEIeB6bKIfePCAYNEeken/KmVRv8cDXlkRn5Ob4bvyxbZPYnjs9w7/mLl8eq
         WDnsCFEtyCnWE3zojKALup0eKq1qcSV26iQ0+55nZP7RpUDOkAWYbgPMjTploNtVIlkU
         qLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQybZDc85m9eONoPiN1UxsVjoIn484TAQ2T26wH9QMQ=;
        b=EHLKuzBrHRfhO8VLR0TFe8gTIvKjylMcnFAJxTw0PAtNcNxIUerN6WgVcJxHeBOrm3
         OqvyrCPViPIPkeZsmhAUP7G118+Hz5aARBH6rfMbt55uzZMxw759+IQjRiRFPZvrnPqg
         oqEQw+3K+jQQ9dNqUWEY14nHzWsIm7CCoyjZwJx8f0mp1UWWSt4CBPYoKtLlf8dk63C2
         1Mi5XuRtvmAkKiXs1+uvSSOVOSVd4EKEHeFV8IO6f8rXGvuvHFCYnSL2XRXb+CG4zsM7
         phmmNvU983HbDH3rB7kp+Ag2xpbAGIW9xEsqFltpWUTqCl2uv5v2qcsnWcLMFK+WqwYj
         iXwA==
X-Gm-Message-State: AOAM531qeZVCaWhpa7GE9Sers0l0aLt6n21BvgOMc4R6NEoHx6PRbeBJ
        lBsa0EF41WgVQGA2BqJAuwJwFxw01Z2kt6PTkps=
X-Google-Smtp-Source: ABdhPJzNJ2X6FVyW2qiz6zlmZvPbggA6iqZF9RWJcmz+JvHYtu3s7IAHmHf6Z+PH6Wphd1j0FY8mUCRAsbR1yaFxiqM=
X-Received: by 2002:a05:6512:3503:: with SMTP id h3mr5044667lfs.564.1631300009789;
 Fri, 10 Sep 2021 11:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210909193544.1829238-1-fallentree@fb.com> <40733168-d1b1-4d9e-63a5-e767bc9dc1ad@fb.com>
In-Reply-To: <40733168-d1b1-4d9e-63a5-e767bc9dc1ad@fb.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 10 Sep 2021 14:53:03 -0400
Message-ID: <CAJygYd3NX3qi7sOHiQOmbiJju8zMy3ip0bmreOmRPtgp=S3YtA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add parallelism to test_progs
To:     Yonghong Song <yhs@fb.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 2:28 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/9/21 12:35 PM, Yucong Sun wrote:
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch adds "-j" mode to test_progs, executing tests in multiple process.
> > "-j" mode is optional, and works with all existing test selection mechanism, as
> > well as "-v", "-l" etc.
> >
> > In "-j" mode, main process use UDS/DGRAM to communicate to each forked worker,
> > commanding it to run tests and collect logs. After all tests are finished, a
> > summary is printed. main process use multiple competing threads to dispatch
> > work to worker, trying to keep them all busy.
> >
> > Example output:
> >
> >    > ./test_progs -n 15-20 -j
> >    [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
> >    Launching 2 workers.
> >    [0]: Running test 15.
> >    [1]: Running test 16.
> >    [1]: Running test 17.
> >    [1]: Running test 18.
> >    [1]: Running test 19.
> >    [1]: Running test 20.
> >    [1]: worker exit.
> >    [0]: worker exit.
> >    #15 btf_dump:OK
> >    #16 btf_endian:OK
> >    #17 btf_map_in_map:OK
> >    #18 btf_module:OK
> >    #19 btf_skc_cls_ingress:OK
> >    #20 btf_split:OK
> >    Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
>
> I tried the patch with latest bpf-next and
>
> https://lore.kernel.org/bpf/20210909215658.hgqkvxvtjrvdnrve@revolver/T/#u
> to avoid kernel warning.
>
> My commandline is ./test_progs -j
> my env is a 4 cpu qemu.
> It seems the test is stuck and cannot finish:
> ...
> Still waiting for thread 0 (test 0).
>
>
> Still waiting for thread 0 (test 0).
>
>
> Still waiting for thread 0 (test 0).
>
>
> Still waiting for thread 0 (test 0).
>
>
> Still waiting for thread 0 (test 0).
>
>
>
>
>
> [1]+  Stopped                 ./test_progs -j

Sorry, It seems I forgot to test without "-n" param,  here is a
trivial patch that will make it work.

diff --git a/tools/testing/selftests/bpf/test_progs.c
b/tools/testing/selftests/bpf/test_progs.c
index 74c6ea45502d..dd7bb2bec4d4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -780,7 +780,7 @@ void crash_handler(int signum)
        backtrace_symbols_fd(bt, sz, STDERR_FILENO);
 }

-int current_test_idx = -1;
+int current_test_idx = 0;
 pthread_mutex_t current_test_lock;

 struct test_result {


Cheers.

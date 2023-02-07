Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66B368CCA8
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 03:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBGCjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 21:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBGCjV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 21:39:21 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B11BCF;
        Mon,  6 Feb 2023 18:39:19 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id x8so8503149ybt.13;
        Mon, 06 Feb 2023 18:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/DM3ZHFWH9+5S1qy4cWZ8ku1jvaebrV19OOb7VPWCE=;
        b=E4fEMnY3w6e/c+JBeP/QCib+VbVtKssBHY7FUZxS0phG4XsyqJMZrF0ZsO+zJ1epw3
         HAtT/bA6uxjwaVyMzsMHcPhITBLECR1tX/9AI77Xel6kBlG4dPeCJadLrn8Rx0ydq9nN
         aaYHn/Q0Izel+P2z1Nyb2IfWsmarbuSv/Wqo6BMwKyLtgnEhBugkPLcQcNsft1HbliEV
         bUDgENAF2xwW6V8V2XxgMEBjtKQYyctlihlNrcoBCU0TBDUZzXqjlZkZhUKegm1Ke2CR
         dLWM9OMM1fhB5ByOwtI4DgefYMgbfVPgw47R/tiRhYCOBT8YNZeMrIKLZoY2U9s2/INJ
         DSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/DM3ZHFWH9+5S1qy4cWZ8ku1jvaebrV19OOb7VPWCE=;
        b=JdrNyH0pOOqbJGFvn14PK0iTTgQb3cnW9ChWVYUdstWuZ5w6KudUJwGyWerk2kIDMf
         2eYMejHACS7z6pCM/k8vRfix/6odDhHpfKVnEW7PYczvc2VDvii2jh120aOB2OwfFucU
         Ds/rfQSV84enYdIe4f0MdjI6kUwq1C1EV+DA9asv1lMFUv8sd6C7rLBQZe0/Hkwq2y84
         vUcf1iIPS8p5NhnNO27HSvZ13X0GUDMuTIQy6zO4kfr0jI51m2AB7+TaJtb0gXcHQmQV
         DMEv8ZQbqtQ3u/QajjAoTGD8R9vNCV0JsIoKKw7b1TY5c0HUAp9vW6BbVFkaHEwi6fkc
         UeqQ==
X-Gm-Message-State: AO0yUKXGr7jeGz5KBeTJe+neNR3pokZ1hlEO1HETpS67sQfyeZTx73Q5
        xMFuHCQ+YUR3OWp5fXnHsFOjnqgdfaRMEHsTlq6i3+CL
X-Google-Smtp-Source: AK7set9x+pCh4zkjdzoTJfNRupzo3lOSBI7ynBJQraf4uzfSI6TylOwOwDUh2q7lsTxp2cIWb5YqYbMPMgYXsfUBKhE=
X-Received: by 2002:a25:2414:0:b0:86a:3232:d062 with SMTP id
 k20-20020a252414000000b0086a3232d062mr243212ybk.222.1675737559025; Mon, 06
 Feb 2023 18:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-3-imagedong@tencent.com> <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
In-Reply-To: <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 7 Feb 2023 10:39:07 +0800
Message-ID: <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 7, 2023 at 4:05 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Add the testing for kprobe/uprobe attaching in legacy and perf mode.
> > And the testing passed:
> >
> > ./test_progs -t attach_probe
> > $5       attach_probe:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
>
> Do you mind refactoring attach_probe test into multiple subtests,
> where each subtest will only test one of the attach mode and type. The
> reason is that libbpf CI runs tests with latest selftests and libbpf
> against old kernels (4.9 and 5.5, currently). Due to attach_probe
> testing all these uprobe/kprobe attach modes with extra features (like
> cookie, ref count, etc), we had to disable attach_probe test in libbpf
> CI on old kernels.
>
> If we can split each individual uprobe/kprobe mode, that will give us
> flexibility to selectively allowlist those tests that don't force
> libbpf to use newer features (like cookies, LINK or PERF mode, etc).
>
> It would be a great improvement and highly appreciated! If you don't
> mind doing this, let's do the split of existing use cases into subtest
> in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
> of that patch.
>

Of course, with pleasure. For the existing use cases, we split it into
subtests, such as:

  kprobe/kretprobe auto attach
  kprobe/kretprobe manual attach
  uprobe/uretprobe ref_ctr test
  uprobe/uretprobe auto attach
  sleepable kprobe/uprobe
  ......

Am I right?

Thanks!
Dongmeng Long

>
> >  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
> >  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
> >  2 files changed, 92 insertions(+), 1 deletion(-)
> >
>
> [...]

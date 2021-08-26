Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A73F8EE2
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhHZTk4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbhHZTk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 15:40:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DBFC061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t1so3951273pgv.3
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7fw5yb8eI7rSXX+5TMSxeVyPX6JoNlXZembIfc+aPs=;
        b=m8JocPcma0pgIcHKCXuSxPBsP3R4nU6iUpS4wIZXYi1vs+slCLX5cajPpZU8mFtHNz
         3sEsUxAjAh86UPNSoWuE4rZMBK8LDC29ySVvhjYKp2qfmCjMHkUYihm+xzXMsgrVyi7W
         +fnlVz0fQplASsdyO8SVXcPB0L3bp56kbd2lO+RMPkPFj/d2wd8DMI8uFqWgWSx2uRCB
         /DkcGi/OBVsCuffxvBBt4VV7OM8xgKCaWp4nrlqctqKAHLT1z5BiN1vw2CW0x2VAHEJh
         GD7ZVov4xIA3KXtfNRjuA62F0lM8BXZIY5irYTDBzouv2iVGAdGowHqI+DZo+fPbBB/b
         482Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7fw5yb8eI7rSXX+5TMSxeVyPX6JoNlXZembIfc+aPs=;
        b=ETEkpYojJEtoigJV7grcuawCyoDNQPHvJo1ILG25Dy2ECeysXmfhiil6yDwxtwOzeQ
         5id8QaXAbHRPomQqZzjmkCBoV5kStspyKe9bMnpcNDklK4TnZXF4mF6EKw16wi2yjGkt
         5IUm3mgXMWirXXOwfKzLnEnauLOBrBV1t7kI6EAPtsK6wajLNFCdHL+cYWc64d8iJGEn
         xXTdTbdvyS+GS5jm8EIngCcm1TwSxz2OHDr5X910tqA1NOApz2oB2AqB2xIe69vN2sKa
         MaNF+t/m3QLLZsDSuVaDJlZmSc4InXC97evGWLtwQW6WxD67Y3EDQYTK4k9jVPpd6Yzi
         OxvA==
X-Gm-Message-State: AOAM531U4jbuST8HG3XP/7AVKP8viYWVKDc0J/IiqAAtU76nIDH0VflX
        T1peEfVbgmwechhKISM87i7NTKFCjyzQvFsX0vs=
X-Google-Smtp-Source: ABdhPJye66ikZ1CqYbGZ5dPE9Wtkigdf+/itKCYn22RWSZUJKp5CND/ASnanIbSIf9qnzXQuFuOk7mHZt6lj66mK5Hw=
X-Received: by 2002:aa7:8754:0:b0:3e2:1de:4f92 with SMTP id
 g20-20020aa78754000000b003e201de4f92mr5301434pfo.16.1630006808289; Thu, 26
 Aug 2021 12:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_y4QumOW35qpgTbLsJ532uGq-kVW-VESJzGyiZkypnvw@mail.gmail.com>
In-Reply-To: <CACAyw9_y4QumOW35qpgTbLsJ532uGq-kVW-VESJzGyiZkypnvw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 26 Aug 2021 12:39:57 -0700
Message-ID: <CAADnVQ+nzJsaFWUXAghqs_UdwELZUPOFCvnJMVCKMUPnLOrzuQ@mail.gmail.com>
Subject: Re: Concurrent BPF_PROG_TEST_RUN for XDP contend on dispatcher mutex
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 4:09 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi,
>
> One of the tests for our XDP-based load balancer has gotten quite
> slow, so I dug in. Roughly, it simulates 1m distinct packets arriving
> at the load balancer by calling BPF_PROG_TEST_RUN a million times.
>
>     distribution_test.go:40: 1000000 iterations
>     distribution_test.go:99: Coefficient of variation: 0.52%
> --- PASS: TestLoadBalancerDistribution (0.00s)
>     --- PASS: TestLoadBalancerDistribution/32_endpoints (22.04s)
>
> You can see that the test takes 20s. Running the same test with slight
> variations in three threads results in this:
>
>     distribution_test.go:40: 1000000 iterations
> === CONT  TestLoadBalancerDistribution/32_endpoints
>     distribution_test.go:99: Coefficient of variation: 0.60%
> === CONT  TestLoadBalancerDistribution/64_endpoints
>     distribution_test.go:99: Coefficient of variation: 0.82%
> === CONT  TestLoadBalancerDistribution/128_endpoints
>     distribution_test.go:99: Coefficient of variation: 1.24%
> --- PASS: TestLoadBalancerDistribution (0.00s)
>     --- PASS: TestLoadBalancerDistribution/32_endpoints (55.61s)
>     --- PASS: TestLoadBalancerDistribution/64_endpoints (55.61s)
>     --- PASS: TestLoadBalancerDistribution/128_endpoints (55.61s)
>
> It's pretty clear that something is serialising the threads. Digging
> around in perf reveals that the culprit is bpf_prog_change_xdp called
> from bpf_prog_test_run_xdp. The call was added in f23c4b3924d2 ("bpf:
> Start using the BPF dispatcher in BPF_TEST_RUN").
>
> Is there something we can do about this? Maybe only call into the
> dispatcher when repeat > 1?

Are you doing three parallel test_run commands
with repeat=1 and doing this syscall 1m times?
yeah, that would stress bpf_dispatcher_update() logic nicely :)
3m accesses to the same mutex and flip flop of a single page
with tlb flush and text_poke_bp.
Can your test harness use test_run with repeat = 1m instead?
Or it's not possible, since input data is different every time?
I think avoiding xdp dispatcher for repeat=1 makes sense.
Folks might be using this facility in similar fashion and
paying the dispatcher penalty for a single run is unnecessary.
While at it would be good to add the test_run specific xdp dispatcher.
Since right now all netdevs share a single global xdp dispatcher.
100 parallel xdp test_run threads will probably fail because
they will reach BPF_DISPATCHER_MAX limit.

Bjorn,
could you make such a change?

Other ideas?

Thanks!

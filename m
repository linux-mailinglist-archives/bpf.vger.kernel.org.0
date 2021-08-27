Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D033F95DD
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhH0ITQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Aug 2021 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbhH0ITQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Aug 2021 04:19:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E8C061757
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 01:18:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q21so10016745ljj.6
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63/qOw3L14sQ37CjaIblV1n8tcz+MutnMk2nnmkmmdM=;
        b=qyIq0StU/HRJQ+MSFLFzKZPaIPFM8BJgXt0YUCsD5h8Z59kdQ+Z2wes2wuXu7JvDCI
         tL/8eg6Q4VpV0TBJD0XfzS1uF4+pMAem3TDvbWau9zNiRdtcXjnhev97FkpoZHnBGBhz
         6EiXqjeYEjUrLws/uI2/+1Z6fiEfH/3WpDMxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63/qOw3L14sQ37CjaIblV1n8tcz+MutnMk2nnmkmmdM=;
        b=gKgJf1sMjRFg1ncaRHTDNPB1ZXRpX+yviPcMfPguF0Zogf3oXLgPNl9qa1ZTTapdy+
         9zMtuI1ogozaPDBh8er9LoEWBWHLB+mpc6azgdbTX8rWDw/myKF/+uWbQQpSZ7/MvJ4+
         UUMRJn2Bu9wtBi8/Swv1zoRPYhVN0zqoyn4wQ8GN4HWDzkXS0M4rNP39PnnkYcx6VdDe
         IZJa52wjOiXNzbnBGNacJFlk1zZ7PNU39VlDxp/cDAJNKTKuFV48R+Bu1ZrHWUUzgNjG
         3UPDbz7o7bcy8Hfwd37VusQssYXGqlFrfw7nLyeRrKvB6b6kx1x+IEnmzYI2PoDcdaYO
         kTwg==
X-Gm-Message-State: AOAM530wO8+ep6oYxjKUVMAQY5HT2vW0AWBulGHGXeuw4MrQj8XZFBhk
        DSvHb8IuzZrcK2UshDWmaT6f8F0lGHfpGIopSEwhEQ==
X-Google-Smtp-Source: ABdhPJxpCwHBqppW3BiCl87Gudfs7+vkWWL5YlhY8X6/G7w4kPRa4//1wTQUE7uKVJKvfkXKSNujC0np6XLWgY3/cHk=
X-Received: by 2002:a2e:93c3:: with SMTP id p3mr6633802ljh.226.1630052306153;
 Fri, 27 Aug 2021 01:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_y4QumOW35qpgTbLsJ532uGq-kVW-VESJzGyiZkypnvw@mail.gmail.com>
 <CAADnVQ+nzJsaFWUXAghqs_UdwELZUPOFCvnJMVCKMUPnLOrzuQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+nzJsaFWUXAghqs_UdwELZUPOFCvnJMVCKMUPnLOrzuQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 27 Aug 2021 09:18:15 +0100
Message-ID: <CACAyw9_XO6q6bB33nRCDrjC_RY3oUovhQUHQzvaOkxubFujjKQ@mail.gmail.com>
Subject: Re: Concurrent BPF_PROG_TEST_RUN for XDP contend on dispatcher mutex
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, 26 Aug 2021 at 20:40, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Are you doing three parallel test_run commands
> with repeat=1 and doing this syscall 1m times?
> yeah, that would stress bpf_dispatcher_update() logic nicely :)

Yup, exactly.

> 3m accesses to the same mutex and flip flop of a single page
> with tlb flush and text_poke_bp.
> Can your test harness use test_run with repeat = 1m instead?
> Or it's not possible, since input data is different every time?

The input changes for every run.

> I think avoiding xdp dispatcher for repeat=1 makes sense.
> Folks might be using this facility in similar fashion and
> paying the dispatcher penalty for a single run is unnecessary.
> While at it would be good to add the test_run specific xdp dispatcher.
> Since right now all netdevs share a single global xdp dispatcher.

I guess a side effect of this is that too many BPF_PROG_TEST_RUN (aka
BPF_PROG_RUN now) may slow down programs attaching to a NIC?

> 100 parallel xdp test_run threads will probably fail because
> they will reach BPF_DISPATCHER_MAX limit.

If there are too many concurrent progs the dispatcher just becomes a
no-op rather than return an error, I think.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2B63D978
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 16:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK3PdD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 10:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK3PdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 10:33:00 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD31659D
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 07:32:59 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3bfd998fa53so121824037b3.5
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdQHiIv2WwVGqQzo9GJex3xu9NpvEfdYHQ8Y4aFhXjQ=;
        b=fKg4E91/Vll7sqIF5ecSI3UUbCpbd/NbcXpajegXrKqmWna6jx3XnampsOaTy8RpTo
         N9u1iPjWrdhvtRWeoESCqy+nK0xgzGQz2sBXJBfLxorPeGMaSURuEXZwTTiWXqF74262
         vGUfTo2g38mHFB6drNQasxqIOdQ6TeD0uAAIGH5BYQKPx00ReYkzz/JqsAjfRIjZO7w2
         0O/G+teIGfmXENDqtn/3nzSz9+nXj4zeQNgJjynwsG2JB+RSKsqZZWG1DCUdZOFYJF+H
         DsDW0v8Hi+0WjKdHHbQvHJJBQxAdUFJb1UyS8ojCmMx2LO8tAPzGfpoi2BAO+LhZf+Sr
         wmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdQHiIv2WwVGqQzo9GJex3xu9NpvEfdYHQ8Y4aFhXjQ=;
        b=v7O1rFqnypcdB0AGtUBWMRj/t27HITxveuMaZmcI8qBBKWPgx7ZJ2V8OPwmX6Zs7a6
         6sp3DitvfBzmv2JlF97MTwXSUYmy5o31+EUw8f6Ul3ynEu9gvmOZQf6beVEtPOw7JZ7u
         L0lX94jJWjrL2h6W6sW7+Nk5d2pPt/3bOjs2TXPqlNu4kT8YG70n4xM97E0R0eSGbgpC
         xbAvXjdzPOg+Ohvs3uLiGAa7ZLC/tdMrtGe/Jg81CrSPPdgq7TKEowXAvcSbG4EKjEpJ
         gogUE97GOL5GK6Jeh1563R1BMkHoTlIObzwYE/iIQcWkobSomR7RYESEjpwHxwG8if17
         qzhQ==
X-Gm-Message-State: ANoB5pkzKAee6nS3dCTsVdpZkEKVMnseFWdjiI2BDIgcZ6mAoMl/My9J
        5Xqtts0PyTz+z/SkR4FZONIna12zxBTHsJoAuW+4r7RELzOIgg==
X-Google-Smtp-Source: AA0mqf4lE0rnOsxamdK73D4Fy2m9dL4kpjpY28FSrrsDaJE/orXjqQQlbgQ3Jmtz3YOGtGXPBtfCwr8mD6GsOpxSdGg=
X-Received: by 2002:a0d:d58b:0:b0:3c5:7a8:6725 with SMTP id
 x133-20020a0dd58b000000b003c507a86725mr16240885ywd.432.1669822378796; Wed, 30
 Nov 2022 07:32:58 -0800 (PST)
MIME-Version: 1.0
References: <CAC=wTOhR-YTjuGu7mreQccx1o+nWgWZ4+V=URpj3jfCB3gipTA@mail.gmail.com>
In-Reply-To: <CAC=wTOhR-YTjuGu7mreQccx1o+nWgWZ4+V=URpj3jfCB3gipTA@mail.gmail.com>
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Wed, 30 Nov 2022 15:32:48 +0000
Message-ID: <CAC=wTOhxJX8wsY_YffvHFzGHxNvEKFOkmkA4Lc-=m+-C-aWpHw@mail.gmail.com>
Subject: Re: Per CPU map not being transferred to user space
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I think I found the problem. It is necessary to run the statistics
display application in the same network namespace where the user level
filter and the eBPF kernel code are running; I think even in the same
'ip netns exec' instance.

On Wed, 30 Nov 2022 at 13:58, Chris Ward <tjcw01@gmail.com> wrote:
>
> I have a test case similar to code in xdp-project/xdp-tutorial/ which
> maintains a statistic map in a per-cpu array, and user-space code
> which displays the statistics periodically.
>
> When I run this, the user space code always displays zeros. I have
> instrumented my eBPF kernel code with bpf_trace_printk and it appears
> to be putting the correct values into the map. The user code is
> iterating over all possible CPUs, but is always finding zeros in the
> per-cpu array slots.
>
> Can anybody tell me what is going wrong ?
>
> My test case is here
> https://github.com/tjcw/bpf-examples/tree/tjcw-integration-1.2-ebpftrace/AF_XDP-filter
> ; af_xdp_kern.c is the eBPF code, af_xdp_user.c is the userspace code
> which drives the eBPF code, and filter-xdp_stats.c is the code which
> should display the statistics. It all builds with 'make' in that
> directory, and there is a run script which I use with
> tjcw@r28b29-n10:~/workspace/bpf-examples/AF_XDP-filter/netperf-namespace$
> sudo FILTER=af_xdp_kern ./run.sh
> to run the user code and eBPF code with data being transferred between
> 2 network namespaces on the machine.
> While it is running,
> tjcw@r28b29-n10:~/workspace/bpf-examples/AF_XDP-filter$ sudo
> ./filter-xdp_stats
> should display statistics, but in fact displays zeros.
>
> My test case is coded to the '1.0' BPF interface, where the code in
> xdp-tutorial is coded to the pre-release BPF interface.
>
> Thanks for all the help you can give !
>
> Chris Ward, IBM

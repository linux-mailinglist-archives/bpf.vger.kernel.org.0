Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE22B273186
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 20:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIUSJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 14:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIUSJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 14:09:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2CAC0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 11:09:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so13674996edo.10
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2gRVRvTDWwfATk5t7wFIm55wjeGEEthD9jAmx8WrwQ=;
        b=V2T3MJ1WcOFZii4NxoAWnxNlQBSG9qyAOklIbpUH+vhVdFe3M9VI02LT3Cvam9WpPI
         UuT21fUhJvYgQPyLacXu9q5TrAknbhiJ6cmqm0QDdwSNyU1saUwJf45JRhkBwG6/kknw
         eFi97FQTDbWXRtlGpvqo5R1PcAdBSFObnBCFBfxZchUMz3Wm/rAlQcQXukGXh02ZkdQR
         Tjx5XwLp5sFAEwJjpAbIssiDdnrUMhvgsKzYKfXV07QmVxc7nUNWEwzX7Ut+2Tb6m3Dh
         ejZs+LcYMZLrVAyupT44BI22vllUq2EpmffRZO2ZrPRMzVLGpLLNMwqw+dqFNdTwe2fx
         oS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2gRVRvTDWwfATk5t7wFIm55wjeGEEthD9jAmx8WrwQ=;
        b=NlcVlO0REyDWqErvvilYVeqoV3z+1ZM8yY0G/b3TYXndYo9oFq0wGfq8KWNjIeUm86
         7/6ScV4n3Qzfkn1XSl9dKeN+3R55HCd8hWF9azx/rfj0uk2DsU5+acNavppQRq/R9ZyH
         mNcvYM4Ly8316IsuXIsVZqx+K/xWm3CZMXtwx5zA1mhJL/UrVc9qwLGtQ6GB4iJEdBBR
         Zq8oKdA8LHLwgxjxdHG3a/ESrwzx1DNUpr0qB8jFQ+DyZJtycl/EiiDUsm1BXhz/xo6v
         UopNXtZ6lnMgA7yYgPXhacsUQEAogq/0c155g9HPbNOtIoIOW0fgaVARtcFlEvCFBSXX
         m0+w==
X-Gm-Message-State: AOAM530Eg1QHa6oPp/aa4GBkr229bjbj7jE+wKuBC+d3vr0DhuBj7XF/
        QzZ96DuS0ByMWIPleXchZqpfV0LpJ5LnIw1Kx4forYRo7JRZTw==
X-Google-Smtp-Source: ABdhPJxzS1PvJpZ0m2Z/pTgp6nyi4eUGvBkhh/prcxCQ3x14BnnFzuu2H8xHujssxKMeV+RGxPHlRe66XeYpkaMAD90=
X-Received: by 2002:a05:6402:cba:: with SMTP id cn26mr173873edb.230.1600711760904;
 Mon, 21 Sep 2020 11:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
In-Reply-To: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 20:08:54 +0200
Message-ID: <CAG48ez3k0_7Vev_O=uV_WVuUGK6BPA0RyrYXMYSDV4DTMMe26g@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 2/2] seccomp/cache: Cache filter results that
 allow syscalls
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
[...]
> We do this by creating a per-task bitmap of permitted syscalls.
> If seccomp filter is invoked we check if it is cached and if so
> directly return allow. Else we call into the cBPF filter, and if
> the result is an allow then we cache the results.

What? Why? We already have code to statically evaluate the filter for
all syscall numbers. We should be using the results of that instead of
re-running the filter and separately caching the results.

> The cache is per-task

Please don't. The static results are per-filter, so the bitmask(s)
should also be per-filter and immutable.

> minimize thread-synchronization issues in
> the hot path of cache lookup

There should be no need for synchronization because those bitmasks
should be immutable.

> and to avoid different architecture
> numbers sharing the same cache.

There should be separate caches for separate architectures, and we
should precompute the results for all architectures. (We only have
around 2 different architectures max, so it's completely reasonable to
precompute and store all that.)

> To account for one thread changing the filter for another thread of
> the same process, the per-task struct also contains a pointer to
> the filter the cache is built on. When the cache lookup uses a
> different filter then the last lookup, the per-task cache bitmap is
> cleared.

Unnecessary complexity, we don't need that if we make the bitmasks immutable.

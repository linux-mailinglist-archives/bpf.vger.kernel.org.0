Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54A365048
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhDTCV3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhDTCV3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 22:21:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446BC06174A
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 19:20:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a36so30871027ljq.8
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 19:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO2qh75XltAhV+SOz3RxvN1LKvjGstw1tTi0Ol4m3/M=;
        b=I2nqrLpu51XsYzp2SkmQ60ZKPs8FqgMToMcGNirK4/SXdF2dTNYYvuhPXqFeqZv2ol
         9ZfYdKiKxozGDuaYUTokCWMqHQSr4Xu/XQUMKyxpd0mFxgsgc99qG5PNfHMjNjzpuqef
         K69qstiGu8+MPClt4HO7k8fbFl/nLvi6+xulBCbQ6zYmvN+GSM6/edOVCrQsYcJvYBxX
         8xo0f5YmfATjSKsMHuE4QI2mzUGiEu0Qpb0E6KyhnkolFOSnLaNayRD/yEa+jeVn4s7C
         SF7p2RfvUKVYTMVe8JIVEtXVl2hS3SD9kZ3dzWfG/3/Bgzo1s7iT3T8szvcuz1g9KdTM
         il6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO2qh75XltAhV+SOz3RxvN1LKvjGstw1tTi0Ol4m3/M=;
        b=Um7nokfM+GuNqP3XR6DK5au6z5luPuOkIE7lNo+JNvntB4FlivP3mOFKcqK6ioq+zH
         6cxuWKPKP5Ug6xbukHaHPgCXPurJHDaw+KMybmxGxTLdsvh32175/MEJvXUo2kka9Jtw
         lO9O7LX3HXhTNaQLvLL0duF9LSPye7BGadUy7toHyyXFI7nPB5eIlLnpwGjirWNn/v1E
         FwhS0+t//YlsujyrgCkC5lqNFbRdUq/B1t0kJebUXeRZvoVppXY7xtC5KUHegInK50UC
         WFSB5+36jGP31KjlSlYPrzW5Sv/uNyDDeccNdm+SyEbu1hyX4tnFZYaN/1Jchh29DTgY
         5vQw==
X-Gm-Message-State: AOAM533a9Fl4kDoGQOC6UJ09DK8WOkwexyt8aWrR9nnMrCFDhyy2Uus2
        ChDg/X323delOaCNCUePYna79fWpBXzZ83Bt3tU=
X-Google-Smtp-Source: ABdhPJx6eNSzy5Q5yQudc4qio2OJkfR2rKTi9u/41VZjuMY44V1fbpsSO3pATU63NmcsdV3BZAI2oUQ8gfcIhL/JmKE=
X-Received: by 2002:a2e:3511:: with SMTP id z17mr9499029ljz.32.1618885256913;
 Mon, 19 Apr 2021 19:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210416204704.2816874-1-davemarchevsky@fb.com>
In-Reply-To: <20210416204704.2816874-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 19 Apr 2021 19:20:45 -0700
Message-ID: <CAADnVQJr60gKbYdwEFK1uji905Hou9i=Xob-ty8y0hsWspZZsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: refine retval for bpf_get_task_stack helper
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 16, 2021 at 1:47 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Similarly to the bpf_get_stack helper, bpf_get_task_stack's return value
> can be more tightly bound by the verifier - it's the number of bytes
> written to a user-supplied buffer, or a negative error value. Currently
> the verifier believes bpf_task_get_stack's retval bounds to be unknown,
> requiring extraneous bounds checking to remedy.
>
> Adding it to do_refine_retval_range fixes the issue, as evidenced by
> new selftests which fail to load if retval bounds are not refined.
>
> v2: Addressed comment nit in patch 3

Applied. Thanks

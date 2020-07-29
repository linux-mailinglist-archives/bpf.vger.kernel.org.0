Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561C6232358
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2R3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 13:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2R3D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 13:29:03 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B2620809
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596043743;
        bh=HmukCrIYPvc9eXdlTyus9h4Qn/xgV4LD5QrrQcS2+8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zsUwXxhFxbC3TGVHZ39q2J4CqydNgM50w4EAfHwdyho37TqlsNEiFGaRF+U5udgYr
         Yh1aUQfjY5W3JrhiwJEonTPCejFa1qjwfkv1yRVKAfyhbgQfw9j5d5GXprzKddE8rk
         CMXKC3AOdrLTX9YMG+P/4cHn2qXCWRBOJhAxVIpc=
Received: by mail-lj1-f177.google.com with SMTP id b25so25929550ljp.6
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 10:29:02 -0700 (PDT)
X-Gm-Message-State: AOAM530SEfYL3N5RlgSa59Udne5+ELxqJsapUjFs1ccfo+fGiizRN17/
        YE1b2mUULq0FUq+vklL/n1vzx+yQb9q8xLP5kkw=
X-Google-Smtp-Source: ABdhPJzSFcir31Ofb7O6Rgb5pjQQdXaXJZKcBTsr9jI/5zHUoNVxsvSQ/KFEUCT+DXGke/w8iA6ENHIfOoyf0GpUesU=
X-Received: by 2002:a2e:7c14:: with SMTP id x20mr15597447ljc.41.1596043741122;
 Wed, 29 Jul 2020 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200728152122.1292756-1-jean-philippe@linaro.org> <20200728152122.1292756-2-jean-philippe@linaro.org>
In-Reply-To: <20200728152122.1292756-2-jean-philippe@linaro.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Jul 2020 10:28:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5CmQzELjc8+tQVWZStjPxENhGB7066YJLp=ANs8BYiHA@mail.gmail.com>
Message-ID: <CAPhsuW5CmQzELjc8+tQVWZStjPxENhGB7066YJLp=ANs8BYiHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] arm64: bpf: Add BPF exception tables
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, bpf <bpf@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, zlim.lnx@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 8:37 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When a tracing BPF program attempts to read memory without using the
> bpf_probe_read() helper, the verifier marks the load instruction with
> the BPF_PROBE_MEM flag. Since the arm64 JIT does not currently recognize
> this flag it falls back to the interpreter.
>
> Add support for BPF_PROBE_MEM, by appending an exception table to the
> BPF program. If the load instruction causes a data abort, the fixup
> infrastructure finds the exception table and fixes up the fault, by
> clearing the destination register and jumping over the faulting
> instruction.
>
> To keep the compact exception table entry format, inspect the pc in
> fixup_exception(). A more generic solution would add a "handler" field
> to the table entry, like on x86 and s390.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This patch looks good to me.

Acked-by: Song Liu <songliubraving@fb.com>

It is possible to add a selftest for this? I thought about this a
little bit, but
didn't get a good idea.

Thanks,
Song

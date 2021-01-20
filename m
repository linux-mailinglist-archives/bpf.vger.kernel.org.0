Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56E2FD957
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 20:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392218AbhATTSz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 14:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392100AbhATTSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 14:18:51 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B1C061575
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 11:18:10 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b10so27374579ljp.6
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYHtDjpZWN+ukOQQb2DCnkE1qoC/dUOlvltFcfPFpmI=;
        b=fmWlrjreuQkzitOVzU8EOIExZEbrSOyIjrOgqBvfp7Bjv4WlIYRumi1Bd75+lY95Sd
         6nlpNaJGyzezbdMEBkwXNtIM+JHoW075k7RcqmnIKb0zV4dQ46QJ2i4q15lgod9dxAoW
         LlfeHsvj71rlbiCNldrzUMhVK4yp+KvETzqILtZynsSpags4C+QUOJDJpSAo5Aj8/i1p
         h1PZCwSE95P2jTQEs5dSECfuQuzbSeyPiQhvZB/JX+ehGVzhKVcoBj2NA3L7hJ49vYT5
         0G8cGYGUTisC8rS/Dx1oXau4d8R2VL3BXUInLz5yfmzU9xu2HJJdawxXJZP5sTxCLQge
         l8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYHtDjpZWN+ukOQQb2DCnkE1qoC/dUOlvltFcfPFpmI=;
        b=jBJWE37EzAATISDU1aken4e0OBsSmyByPK0GAZLsCfiX2pRmQSXeHiFshog6O1gs5N
         2Bgsyab3LT4+oSTNTqmwrJZaasP6xCw17M2veAa1F/6F097QwIMqpOicWkrlJ7jLQz0x
         Cj3wxGqO63UgIOlxDyzrWzmFFg6eZwlCOogXWKqDOR11dslgfEHDfOjJje51DinCD2KR
         Tb2M27YNC5eCC2tHYgx4kXNYSI/StF5i01yFVjOkj75mERy23jaMzO9FWC/u6b4dpTrU
         pqYhXz0FDr7RYrSBrwoQ0/44pAwjUsDuvbVJ2G/Nv+pZv/l5u/VKyRL7tsuSfPRpzDUp
         Y4SQ==
X-Gm-Message-State: AOAM531m4lD01xLmjFgh59AnBXoGtCG0tutYNK89M+fXH1Osu8WVqkAH
        6iKQa3dX5qpcxdzmCj6xdaDvUiuIuU8hBDUqpZs=
X-Google-Smtp-Source: ABdhPJwoF7aUvCRHiP+4npFhKKIPaQcQ3G+FMBsPe8hc0Cs9OuN5zP3Azygk/ihwVI4vG0CIe/5J+55T1hNq+G8faUc=
X-Received: by 2002:a2e:3c01:: with SMTP id j1mr5135586lja.258.1611170289176;
 Wed, 20 Jan 2021 11:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20210119153519.3901963-1-yhs@fb.com>
In-Reply-To: <20210119153519.3901963-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Jan 2021 11:17:57 -0800
Message-ID: <CAADnVQJt7JmUhefKTajjfFMTt3kfYbYB_yQLv1wbnZqOH=41hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: permit size-0 datasec
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 7:35 AM Yonghong Song <yhs@fb.com> wrote:
> When loading the ./test.o to the kernel with bpftool,
> we see the following error:
>     libbpf: Error loading BTF: Invalid argument(22)
>     libbpf: magic: 0xeb9f
>     ...
>     [6] ARRAY (anon) type_id=5 index_type_id=7 nr_elems=4
>     [7] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
>     [8] VAR _license type_id=6 linkage=1
>     [9] DATASEC .rodata size=24 vlen=0 vlen == 0
>     libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
>
> Basically, libbpf changed .rodata datasec size to 24 since elf .rodata
> section size is 24. The kernel then rejected the BTF since vlen = 0.
> Note that the above kernel verifier failure can be worked around with
> changing local variable "fmt" to a static or global, optionally const, variable.
>
> This patch permits a datasec with vlen = 0 in kernel.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks

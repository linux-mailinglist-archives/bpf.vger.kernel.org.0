Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFF49D9E6
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 06:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiA0FRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 00:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiA0FRT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 00:17:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD7C06161C
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 21:17:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so1503621plg.11
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 21:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8+WFZtdjVLzDgn7NAlmMVq9ZkDSoYmtOgTspQC1xf8=;
        b=I5zPuuDauw263c2+c9zGj9F7FP81IxHMb1Jz2/V7jMXmcSoPx6xenq7OKGnXUjPoGD
         cc5fFbb27GzYnjSouWSxX6cA4eBC+HaolirA5g9ckfeed2YEo0j+oM+0/AMw/Q2Rt3nl
         GkFITxZJ4vlbh0alAyN1k+bJe07QBvs8E03FMCSWkNejqiSb6YkO7wzBHvbLgWk3jVYe
         QWqqQNDsa9M/rMDcT85KaKoBHxop6Dw8giSVesFCDLZAz4hIexZqcG8EPIkOiEIMXj0o
         klAsip7oQnrvhGMuM7B5vFfkUL5RriloXzzifMOOYFo7JcBhcOqdmrqYaqMlvhs9uOr6
         eUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8+WFZtdjVLzDgn7NAlmMVq9ZkDSoYmtOgTspQC1xf8=;
        b=7g7rHOMppWntHCEeNagM3BtFqMvTXp8yUkqEwejgU2I6swlqioXwlqBpZASSZBvaZb
         U9nqgAWmdyBnLl1/I4Mqjog6h9I/QPFK7fjOrbYs1a1+ABIMQrwXtYMy/vikFO3AQ4hO
         Q3qBC+iot+KvtKL4mMze0/2E85pCrTHS6eHRaK4lyKHoCgerW8IotZDPZswc8gWu692H
         bHkh0dofQCi8rDAwisgqbBt9n/T56c4Cvf/3aRPjuh8j8QdnYP68SEdODnFp+4nUQkX6
         23SUapahRZaRu/MybmpJuZPJCcqpQ1kEsZwiUG+/aTfaCSp7poN7+TqlFHS5DeH4+0/z
         kjyg==
X-Gm-Message-State: AOAM5306mSBA5YsMzu7mxhv5Y8uTbkdokPrejTttW1h/BYzTQUJ1oiQy
        BeFCbpwfpEVMkw+E3bdPZVqq4nXW4HZ0QxTmLsHeA9oLXkM=
X-Google-Smtp-Source: ABdhPJw27tq7O3V/qt2t/247DaKtQS2TxqzhOOvGLbBRWLPHeILuhXYFlikOJbLSdUO1VGRY1Fp/za0JeAeAPhVpHXA=
X-Received: by 2002:a17:90b:1e41:: with SMTP id pi1mr2444604pjb.62.1643260638544;
 Wed, 26 Jan 2022 21:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com>
In-Reply-To: <20220126214809.3868787-1-kuifeng@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jan 2022 21:17:07 -0800
Message-ID: <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 1:48 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Allow users to attach a 64-bits cookie to a BPF program when link it
> to fentry, fexit, or fmod_ret of a function.
>
> This changeset includes several major changes.
>
>  - Add a new field bpf_cookie to struct raw_tracepoint, so that a user
>    can attach a cookie to a program.
>
>  - Store flags in trampoline frames to provide the flexibility of
>    storing more values in these frames.
>
>  - Store the program ID of the current BPF program in the trampoline
>    frame.
>
>  - The implmentation of bpf_get_attach_cookie() for tracing programs
>    to read the attached cookie.

flags, prog_id, cookie... I don't follow what's going on here.

cookie is supposed to be per link.
Doing it for fentry only will be inconvenient for users.
For existing kprobes there is no good place to store it. iirc.
For multi attach kprobes there won't be a good place either.
I think cookie should be out of band.
Maybe lets try a resizable map[ip]->cookie and don't add
'cookie' arrays to multi-kprobe attach,
'cookie' field to kprobe, fentry, and other attach apis.
Adding 'cookie' to all of them is quite a bit of churn for kernel
and user space.
I think resizable bpf map[u64]->u64 solves this problem.
Maybe cookie isn't even needed.
If the bpf prog can have a clean map[bpf_get_func_ip()] that
doesn't have to be sized up front it will address the need.

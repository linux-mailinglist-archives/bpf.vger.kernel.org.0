Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0183158ED
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhBIVqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 16:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234368AbhBIVNo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 16:13:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08CAD64E8A
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 21:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612905179;
        bh=8Obx/ZT2EBOSGYSGVrqBCq2ie48lyEZue3Himib/Aj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HswacXMe3Js4ACauhpCQwTOq+4UxwAFw6e2N76d3E2cDXX6KJWFU7yETWPXZCo+xn
         4KPY2kfgq4h9TqhZM9qD3X5XIC7uT4MF3mLuyNfnpapc4jqumvHLfFTIbZJ3OpT3Ca
         K+fFbGHzr/LwDoSbq6CR28CUyw8oO8YPTLZdUdiDEx2JGJGxdWtplIwOcYGE1qd5PO
         3yoL3Z7KHA536UtyTOdzs5VMYO2/8U+J1zRsFYpy0T7mtGLadKdL5NeieW8exCjxBr
         nz7m2N2tRHfGiAMXJKBckIOf7WDKoy8YWBbYKo8k4UmMtPLCDqYTs7E2yV70Hr4jJr
         JUBS7he3JrLUg==
Received: by mail-lf1-f47.google.com with SMTP id f1so30594576lfu.3
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 13:12:58 -0800 (PST)
X-Gm-Message-State: AOAM5330PtDYqiwHur72l/pOPz9mXToVeXR1I6/rF1ir0Za5OMeFXaMU
        4NCtia078CzkC9+bZz5WPEk2Swagye/OtDk+V22ZbA==
X-Google-Smtp-Source: ABdhPJxX9lZ+gOwnRf8zFWDikODfFB4olcUDVhk2KthrddCPAqYs3aXvqVGm24Gs7nErgcSMbytnRJuN0Ii8V5koN2w=
X-Received: by 2002:a05:6512:711:: with SMTP id b17mr14037005lfs.424.1612905177142;
 Tue, 09 Feb 2021 13:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com> <20210209194856.24269-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20210209194856.24269-8-alexei.starovoitov@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 9 Feb 2021 22:12:46 +0100
X-Gmail-Original-Message-ID: <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
Message-ID: <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/8] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 9:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Since sleepable programs are now executing under migrate_disable
> the per-cpu maps are safe to use.
> The map-in-map were ok to use in sleepable from the time sleepable
> progs were introduced.
>
> Note that non-preallocated maps are still not safe, since there is
> no rcu_read_lock yet in sleepable programs and dynamically allocated
> map elements are relying on rcu protection. The sleepable programs
> have rcu_read_lock_trace instead. That limitation will be addresses
> in the future.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: KP Singh <kpsingh@kernel.org>

Thanks! I actually tested out some of our logic which uses per-cpu maps by
switching the programs to their sleepable counterparts

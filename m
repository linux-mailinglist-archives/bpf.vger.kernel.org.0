Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF53245D2
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhBXVbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 16:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235969AbhBXVbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 16:31:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E56CA64F0D
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614202231;
        bh=C2PvntBY/qjSUpa1ckjfUtSkKX/QusQfjHWxO0kX3to=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RczwiwEiv/LPA61DlzHw2mHaUfry43iUkZhxdfVU0Y2Bi1L21rePzU00nif1ovprJ
         Q0Indz6HtHKgVAtmYVGhH0dTvKDKqMB0mPh4DoK35lx9Wa07DbiWWszIVYWh9EWBOZ
         on+MYWRpsV39v3WDJX4aSdnz337gigYwjocBcE+guhK8MNEl44YUuDrSXYrppG8iuX
         ACsuuCfT5s8+tmc8Fwjn+eDrWZPkQdz2uX2Z7ll23bQq5hP5lD2ms9r88TNJeoDc6a
         hKQOI/KKG2rYHcaFXoaw3gtTNhE8tUjrJA1W6NN8gdBXmcDvo8b0s4vSWi/ECgoLEW
         0LasuruPQUKiA==
Received: by mail-lj1-f180.google.com with SMTP id r25so3163131ljk.11
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 13:30:30 -0800 (PST)
X-Gm-Message-State: AOAM5310g3TOYACkBo5hsy4hcnYAlcjlQ0jAy1rwDKu8slSchmvT+9sq
        66QXfXCVVvFPw5sEb9aXOdj96hLh1B8UeYe6xRad7w==
X-Google-Smtp-Source: ABdhPJxnSIUEXYip1uvKZf7nWoJHGvhex+Ji4T0HLEwQX6o9QsQkjq4NqpiaYiA1kvy+LK0Hy/u6frd4K2yfPUaPetA=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr3655514ljp.425.1614202228987;
 Wed, 24 Feb 2021 13:30:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
 <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
In-Reply-To: <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 24 Feb 2021 22:30:18 +0100
X-Gmail-Original-Message-ID: <CACYkzJ52rAyOWQsKXOOej1=Wh_Fw_S0yBROK7POwbnnccqdvQA@mail.gmail.com>
Message-ID: <CACYkzJ52rAyOWQsKXOOej1=Wh_Fw_S0yBROK7POwbnnccqdvQA@mail.gmail.com>
Subject: Re: arch_prepare_bpf_trampoline() for arm ?
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I checked with Will about it and learnt that ARM64 does support
patching certain instructions (e.g. branch, brk, nops) using
aarch64_insn_patch_text_nosync, it's used in ftrace:

https://elixir.bootlin.com/linux/latest/source/arch/arm64/kernel/ftrace.c#L24

But one has to tolerate that not all CPUs will execute these
instructions until a context synchronization happens due to an
exception or an ISB instruction. But I think we can start
with the same thing that FTrace does?

- KP

On Wed, Feb 24, 2021 at 10:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/24/21 8:54 PM, Luigi Rizzo wrote:
> > I prepared a BPF version of kstats[1]
> > https://github.com/luigirizzo/lr-cstats
> > that uses fentry/fexit hooks to monitor the execution time
> > of a kernel function.
> >
> > I hoped to have it working on ARM64 too, but it looks like
> > arch_prepare_bpf_trampoline() only exists for x86.
> >
> > Is there any outstanding patch for this function on ARM64,
> > or any similar function I could look at to implement it myself ?
>
> Not that I'm currently aware of, arm64 support would definitely be great
> to have. From x86 side, the underlying arch dependency was basically on
> text_poke_bp() to patch instructions on a live kernel. Haven't checked
> recently whether an equivalent exists on arm64 yet, but perhaps Will
> might know.
>
> > [1] kstats is an in-kernel also in the above repo and previously
> > discussed at https://lwn.net/Articles/813303/
>

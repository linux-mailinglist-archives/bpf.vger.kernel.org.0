Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A51C65B8
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgEFCAH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 22:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgEFCAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 22:00:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717AC061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 19:00:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so664089ljl.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPCwr4iUyoDdxListJ7zClgrcCYnR661n6wmFVvbHLY=;
        b=S2goQR4YweK9FgDGQu9Pe3g+q4Hkk15RM/dlxmLrYtqxhDBbr8D4pVqRG/Hl2OJ0d2
         NS2UGsNd3OqJO82RqbEsKmzHYIgjqhto73u6jAhkUP8dCJqscSyfFX2ao5FqNMqrxarN
         82EDvANgZgPw2GoRK8oRIV9Th5auKMojwDbE1obgAmrkUETEw+arJyTqlEH5sXUQMNvV
         iQJn1cta+AWd/kQ9+OHzpBmBO/iiTyOO0nPU85TPkMSHWpTI6ApIw88SDKoU28kB+Q/W
         HWVB603IGvrUaRxiZev3z8jsFH7VtvIA4WiCMYewlNeLOc6/xbMv9lJQv5L5+3uFTaYy
         /q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPCwr4iUyoDdxListJ7zClgrcCYnR661n6wmFVvbHLY=;
        b=JsxVEuLlh2SRekKH6qeug/ycwfUhB9RYCrHQbtw4PKXjux+TCZMq6arHKaLnelZjFq
         mKQiPdBG+ojAjKAPpfP9qM1BU57hy9rorH5fMfW9cTChVRybb9RCW3jxAJYiS/1srOoV
         fEtfxsBivQzwnAWOTcy1pbKPPzvGnWJWyf/BPjE0xr1dUQRHoYtO4nl1oUVH6EhJCNli
         a4/IQtExE/ZLVY906B99udHFaQZl5zdNMnGMXoxL3OMfXUEuJT2FrLxu5pEvSvLqnPJz
         z/4O0rKuBkPrXUutgjxFYsEIkT0iK8khKDGPvpBQldk6aNABn4qGusCs8IbKIS04buvT
         ICxQ==
X-Gm-Message-State: AGi0PuYWl1wmaqMLLpeMzojgVoM7Y5JPmtkIHw5X1V1a6p2MHiOkzH4J
        i5WvDRYKP9PTvUXK+1L6kJuQTobztX/U3TF3zUFnzg==
X-Google-Smtp-Source: APiQypL1b7v3kgsfIIz7nKbHmItmafBhqW3lHLfPIrxKs7Td0ZXxJrdsMJA6qGaTFjdBDBw//PKqr906opZHHBS/YOw=
X-Received: by 2002:a2e:b4c2:: with SMTP id r2mr3565165ljm.143.1588730405148;
 Tue, 05 May 2020 19:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcc1YgBxQUKa=ySQ+XTOk1EkMwLKHc1yECLxuWnVTHoLoYMFg@mail.gmail.com>
In-Reply-To: <CAFcc1YgBxQUKa=ySQ+XTOk1EkMwLKHc1yECLxuWnVTHoLoYMFg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 May 2020 18:59:53 -0700
Message-ID: <CAADnVQJrtojjdyX-5JvNH02+4Pfa81FuVSDsNY2npSJ4Tm3p-A@mail.gmail.com>
Subject: Re: bpf_override_return out of order execution?
To:     Giulia <giulia.frascaria@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 7:50 AM Giulia <giulia.frascaria@gmail.com> wrote:
>
> Hi all,
>
> I'm experimenting with the bpf_override_return() helper for the
> copyout function (using kernel 5.4) to the whitelist. (
> https://elixir.bootlin.com/linux/v5.4/source/lib/iov_iter.c#L138 )
> My goal is to avoid the buffer copy from kernel to user that happens
> in copyout, so I'm calling  bpf_override_return with return value 0 in
> a kprobe.
>
> It works most of the times, but when I test the function with
> relatively many iterations of a read from file I find that sometimes
> the copyout is actually executed with the buffer being copied.
>
> Below is an execution output with sample parameters and with the kinds
> of numbers I usually find
>
> The numbers match with debug printks in the copyout function that I
> find in dmesg, so I'm quite positive that the function actually gets
> called.
>
> The counter in the bpf kprobe arrives to 10000 executions which is
> what I am expecting, so the only explanation I have for now is that
> the kprobe execution is reordered and executed while the copyout is
> already triggered, and the instruction pointer does not get
> effectively diverted on time in the bpf_override_return. Could this be
> the case? Is there any potential security implication also for cases
> outside of mine?

kprobe+bpf won't get reordered but there are few limitations in kprobes.
First is kprobe maxactive.
"The maximum number of instances of the probed function that
 * can be active concurrently"
And another is per-cpu bpf_prog_active counter that
allows only one bpf prog attached to kprobe execute on a cpu.

Do you have more than one kprobe ?
In such cases other active kprobe+bpf may suppress the one
attached to copyout.

If you can upgrade to the latest kernel bpf_modify_return program
type is faster and doesn't have these limitations.
See example in selftests/bpf/progs/modify_return.c

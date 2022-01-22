Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75049687B
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 01:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiAVAFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 19:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiAVAFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 19:05:07 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D53C06173B;
        Fri, 21 Jan 2022 16:05:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s9so8254736plg.7;
        Fri, 21 Jan 2022 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viE1Ba1MfJX/JHAyJbMY2WkVEPZgZXlRHnMC2OHwpL4=;
        b=nTCwCaIVbDf8KnEZeG7pc7Zqe/JN8MVjG9McZxUDnbXyD2JeJhxtU6tafs8QhBFRCN
         1XvP1Wdal2CjoURlM9cLoOSCLV9LfmDtOEgkzWcvzkPqJ5PV6mGwPgjYhoIr+2I6KgLC
         g7JNiPjx8YN483+wh3yLiV4V1qTxcwsO0k2e8+GHkN3axGyM+ltw/rgi1mHw9N3plokb
         qTPz/LGylV9Zs+tLCp3AHXHEVzhC970G91COJ+cUhBYKdM8KIgADFhI/nTWiJwzUxjAF
         sJWx4pQowlYq9ItPbiJhfh1vGwKAYb7mqWBfZn3WkV424SVsP9T4wkvwsgLsW3nl86+M
         s1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viE1Ba1MfJX/JHAyJbMY2WkVEPZgZXlRHnMC2OHwpL4=;
        b=0RalzpapDELDkgsU88ihilWE/rlHDpBiaWR7TGO7yvSNBDt0Pb4/fdk3rHQEZiaq7R
         Ea5btBA2fXvfh76xFq9TzZWpK+giKrZVap0i+G5gNCBfGENYtofC80KJeI0+kR3SUXYU
         fYrrgD4Vj9ClmOE4r6WRUew+uCIhPoqnIYaXKocFK7T+75Bf1trIrz9N2laUEVFbGJZx
         Uc/DZuk0y8yMZm2LSyyEnSmRPz6+w25XnmgIEFBxMu/q23vpSrZg2B+xa1tmVj0EnskP
         ClReRiSwxuhiuxBjTkkAEIcKOKMnEypDF4/a5NkHY4cnn47ZDtdW+1jaNxVeLpgr9EXD
         egcA==
X-Gm-Message-State: AOAM532RG8+ziyzVOa6/t9iykSiFiryPYXpvA9JBu68P7T1FW9vZMUKd
        hPQGeMyl3s6156G/rbbzaGcZlpIV9K8N+sC/f6iTIqhI7EQ=
X-Google-Smtp-Source: ABdhPJykX73NPz5uOgpQKPHt8AzvOpmYxndwzFrl3h2qDcxtPEvPoEojsn+pNUg1ERrxzv4T06m7kMGWmTCAeraGEoc=
X-Received: by 2002:a17:90b:224c:: with SMTP id hk12mr2979165pjb.62.1642809906597;
 Fri, 21 Jan 2022 16:05:06 -0800 (PST)
MIME-Version: 1.0
References: <87o85ftc3p.fsf@smart-cactus.org>
In-Reply-To: <87o85ftc3p.fsf@smart-cactus.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Jan 2022 16:04:55 -0800
Message-ID: <CAADnVQ++57u30cdooEqXSDVGEgKTy70TChg8+2h8mihHbwdpOg@mail.gmail.com>
Subject: Re: Sampling of non-C-like stacks with eBPF and perf_events?
To:     Ben Gamari <ben@smart-cactus.org>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 1:53 PM Ben Gamari <ben@smart-cactus.org> wrote:
>
> Hi all,
>
> I have recently been exploring the possibility of using a
> BPF_PROG_TYPE_PERF_EVENT program to implement stack sampling for
> languages which do not use the platform's %sp for their stack pointer
> (in my case, GHC/Haskell [1], which on x86-64 uses %rbp for its stack
> pointer). Specifically, the idea is to use a sampling perf_events
> session with an eBPF overflow handler which locates the
> currently-running thread's stack and records it in the sample ringbuffer
> (see [2] for my current attempt). At this point I only care about
> user-space samples.
>
> However, I quickly ran up against the fact that perf_event's stack
> sampling logic (namely perf_output_sample_ustack) is called from an IRQ
> context. This appears to preclude use of a sleepable BPF program, which
> would be necessary to use bpf_copy_from_user. Indeed, the fact that the
> usual stack sampling logic uses copy_from_user_inatomic rather than
> copy_from_user suggests that this isn't a safe context for sleeping.
>
> So, I'm at this point a bit unclear on how to proceed. I can see a few
> possible directions forward, although none are particularly enticing:
>
> * Add a bpf_copy_from_user_atomic helper, which can be called from a
>   non-sleepable context like a perf_events overflow handler. This would
>   take the same set_fs() and pagefault_disable() precautions as
>   perf_output_sample_ustack to ensure that the access is safe and aborts
>   on fault.
>
> * Introduce a new BPF program type,
>   BPF_PROG_TYPE_PERF_EVENT_STACK_LOCATOR, which can be invoked by
>   perf_output_sample_ustack to locate the stack to be sampled.
>
> Do either of these ideas sound upstreamable? Perhaps there are other
> ideas on how to attack this general problem? I do not believe Haskell is
> alone in its struggle with the current inflexibility of stack sampling;
> the JVM introduced framepointer support specifically to allow callgraph
> sampling; however, dedicating a register and code to this seems like an
> unfortunate compromise, especially on x86-64 where registers are already
> fairly precious.
>
> Any thoughts or suggestions would be greatly appreciated.

Hi Ben,

if you're sampling the stack trace of the current process
there is no need for copy_from_user and sleepable.
The memory with the stack trace unlikely was paged out.
So normal bpf_probe_read_user() will work fine.

This approach was used to implement 'pyperf'.
It walks python stack traces:
https://github.com/iovisor/bcc/tree/master/examples/cpp/pyperf
What you're trying to do for haskel sounds very similar.

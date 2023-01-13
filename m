Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DDB66A64C
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjAMW5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjAMW50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:57:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B44857D2
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:57:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id tz12so55678788ejc.9
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=25WeVXYeM7VR4HcJpTSCtPOGT0Wz3t06jNZrS+vttQo=;
        b=LLTVaj2AXS1z1d1a+S5JkgifkKCXbVQoSM1kdPFWiqKnHdZKB5JnPg5nt67gU9wf2b
         xtN0Zpd6Va/keTQyKgUuAikBwdQLQ0AigsItSiOZsOReUuABY5UtsmVzvUQKGAeqwswQ
         l+pm998YpCaV1hK9louF173/ANAhQ67JbvmHXOWpY+9cE5xuYAlWtZ+RsCtBfrdvm5TC
         xh4tHyc8r08JIe8k9JWLbb8ChW5cDsWcr3GfG/CSRVLSYtxozZJwG1L7zWPLUO4qQFcf
         wek3PxeIJv29OJgEwFFb8hueS56+Cs1jiQFj+kY1i3MY02fy9TeaN84z+vWZcdt6S3zF
         wDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25WeVXYeM7VR4HcJpTSCtPOGT0Wz3t06jNZrS+vttQo=;
        b=vyYx0PL6ih6n771r1SjKtJLfO194jpauam1gIOopv0nnjbtMD+HNVibkXJbKwjGYbr
         rqJT1wi3lhe4tJqO6e9gPlfnkvI9gGq8sfmPvf+TPwOcQ5D8Vg5DhhMz5AoUwauD1oyy
         FvrpODEh/rPNRXugl5FGnHLLGaswwsL+r0qoSco4kGTivKBZfuNoH0qId1wPWw3jAB+m
         Kx0OENp+6xbg/g32I1SzBlBYKwoFiFRrI3LIgXncbgRAAj54LTc7pGtQCxyJ4r99Ia1J
         xkXRT+WANc7oPZhuGdIKDAuYMbTT9BuI9wQsYX6S2zUnyRS2tdS64GyKZQI/P+KFBglg
         1Fwg==
X-Gm-Message-State: AFqh2krgSex9A8RToOoUjKyulm7qUftIUODZuzjcR+svF8Vg2IzGMJUm
        3RsGAW0n+AOAlhAGHRMYwTquOAEXHN+aCKtEWHRazAgo
X-Google-Smtp-Source: AMrXdXti1VBGywbYoeFlV6XSgsCRO+6NutbT4jlMsM0P/NnU4kUMd5zYbZb6SYjguYeh4FyA780Jig1ZCOSV8EfhsK0=
X-Received: by 2002:a17:906:369b:b0:83d:2544:a11 with SMTP id
 a27-20020a170906369b00b0083d25440a11mr7472601ejc.226.1673650629683; Fri, 13
 Jan 2023 14:57:09 -0800 (PST)
MIME-Version: 1.0
References: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
 <Y75zBpkr1tLXKMWX@krava>
In-Reply-To: <Y75zBpkr1tLXKMWX@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 14:56:57 -0800
Message-ID: <CAEf4BzZDfTAaahM3zwkKwcF2RG4C0HPN+ZPzT7XH517QsvDmTw@mail.gmail.com>
Subject: Re: [QUESTION] usage of BPF_MAP_TYPE_RINGBUF
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     andrea terzolo <andreaterzolo3@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 12:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Jan 10, 2023 at 02:49:59PM +0100, andrea terzolo wrote:
> > Hello!
> >
> > If I can I would ask a question regarding the BPF_MAP_TYPE_RINGBUF
> > map. Looking at the kernel implementation [0] it seems that data pages
> > are mapped 2 times to have a more efficient and simpler
> > implementation. This seems to be a ring buffer peculiarity, the perf
> > buffer didn't have such an implementation. In the Falco project [1] we
> > use huge per-CPU buffers to collect almost all the syscalls that the
> > system throws and the default size of each buffer is 8 MB. This means
> > that using the ring buffer approach on a system with 128 CPUs, we will
> > have (128*8*2) MB, while with the perf buffer only (128*8) MB. The
>
> hum IIUC it's not allocated twice but pages are just mapped twice,
> to cope with wrap around samples, described in git log:
>
>     One interesting implementation bit, that significantly simplifies (and thus
>     speeds up as well) implementation of both producers and consumers is how data
>     area is mapped twice contiguously back-to-back in the virtual memory. This
>     allows to not take any special measures for samples that have to wrap around
>     at the end of the circular buffer data area, because the next page after the
>     last data page would be first data page again, and thus the sample will still
>     appear completely contiguous in virtual memory. See comment and a simple ASCII
>     diagram showing this visually in bpf_ringbuf_area_alloc().

yes, exactly, there is no duplication of memory, it's just mapped
twice to make working with records that wrap around simple and
efficient

>
> > issue is that this memory requirement could be too much for some
> > systems and also in Kubernetes environments where there are strict
> > resource limits... Our actual workaround is to use ring buffers shared
> > between more than one CPU with a BPF_MAP_TYPE_ARRAY_OF_MAPS, so for
> > example we allocate a ring buffer for each CPU pair. Unfortunately,
> > this solution has a price since we increase the contention on the ring
> > buffers and as highlighted here [2], the presence of multiple
> > competing writers on the same buffer could become a real bottleneck...
> > Sorry for the long introduction, my question here is, are there any
> > other approaches to manage such a scenario? Will there be a
> > possibility to use the ring buffer without the kernel double mapping
> > in the near future? The ring buffer has such amazing features with
> > respect to the perf buffer, but in a scenario like the Falco one,
> > where we have aggressive multiple producers, this double mapping could
> > become a limitation.
>
> AFAIK the bpf ring buffer can be used across cpus, so you don't need
> to have extra copy for each cpu if you don't really want to
>

seems like they do share, but only between CPUs. But nothing prevents
you from sharing between more than 2 CPUs, right? It's a tradeoff
between contention and overall memory usage (but as pointed out,
ringbuf doesn't use 2x more memory). Do you actually see a lot of
contention when sharing ringbuf between 2 CPUs? There are multiple
applications that share a single ringbuf between all CPUs, and no one
really complained about high contention so far. You'd need to push
tons of data non-stop, probably, at which point I'd worry about
consumers not being able to keep up (and definitely not doing much
useful with all this data). But YMMV, of course.

> jirka
>
> >
> > Thank you in advance for your time,
> > Andrea
> >
> > 0: https://github.com/torvalds/linux/blob/master/kernel/bpf/ringbuf.c#L107
> > 1: https://github.com/falcosecurity/falco
> > 2: https://patchwork.ozlabs.org/project/netdev/patch/20200529075424.3139988-5-andriin@fb.com/

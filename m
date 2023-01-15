Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821C66B2CB
	for <lists+bpf@lfdr.de>; Sun, 15 Jan 2023 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjAORKI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjAORKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 12:10:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F159710432
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 09:10:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mp20so16489862ejc.7
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 09:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N4nAe2b5mzHucGLbfeTFAwD5rOeRh3kWccPhb8AV/t0=;
        b=mnpoZY+dtWLFsxZBHRnuamMyf1aRHJNY+CVeBheCnF2TI00mbE2s8jVkiWogUXUYqk
         /4IPiz3hQHLajiJ7EMljCpS8b1+qXhuWmHfl6hbrVfiLNeBHb19qIJ6+ClfAUoybjiGs
         zzJEgF3WcHWwv2fesZMYU67O48htOwtfDId99Iy4yKC0UPzfEsW/mO+lD+PeKl8RWv2A
         DScagwOW5rlBI2EG4VCLX+rKfEbBGiu9b7FNwixUiKjNCaaiRIN84MpNktaann+bK2Rd
         ifA2ENl9nmvNYR32IhMNT04AAwLDMKe1EqcYlv5gHIf1MXmZhqqyvQwaS/5d/Vijm7VQ
         yZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4nAe2b5mzHucGLbfeTFAwD5rOeRh3kWccPhb8AV/t0=;
        b=gkS22p3Safe94s1aEvcaESFjrzdnv1n7J/2ene7nT8I2eg6guqYNkRW2DilTu3R6zn
         8yhPcEEoacFK0eJ/zM3D37QnVF6ZOBimx0aRDvLe9ks14anw2CMIJqeOH1tdoNwucjxe
         y8AuyzJ79e41M+kEAZo8Ib61RDvoby/ToDshaiR5pazr6AkUDWFkrsXnuJH/Q7iM/P+W
         4LQvh6LC7kRrVn9w0jUkE5CLrIJz9ExxPPVXGChmh7l5jzM1MTfqnCXoTA9aKlLzQm2Q
         uJ50s1oxeZcK9sewU5KFbv1cPSOkaAy1CfngFM1xpx7ZRu4UjWQtVhZ5BV/RHJAOqSZZ
         6YUQ==
X-Gm-Message-State: AFqh2krvso/J9AGLmsV6DTWCREgRcA+vUXtcK6qiAk9nZAs7lyOPnT+l
        D4WZa+ijeA+pARd+bY8k2dkfJpunqX8rBRN2dCmNeAp2RoS/Jg==
X-Google-Smtp-Source: AMrXdXuH6M7mLRjHlIa2K07fsIbYkv8ThZly1bPINELilQcN43VwVqJI0EHGLZTQdZd9hzQTNbFVZqDK4P9u74v2jjU=
X-Received: by 2002:a17:906:39cd:b0:7c0:deb6:e13c with SMTP id
 i13-20020a17090639cd00b007c0deb6e13cmr6414113eje.457.1673802604301; Sun, 15
 Jan 2023 09:10:04 -0800 (PST)
MIME-Version: 1.0
References: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
 <Y75zBpkr1tLXKMWX@krava> <CAEf4BzZDfTAaahM3zwkKwcF2RG4C0HPN+ZPzT7XH517QsvDmTw@mail.gmail.com>
In-Reply-To: <CAEf4BzZDfTAaahM3zwkKwcF2RG4C0HPN+ZPzT7XH517QsvDmTw@mail.gmail.com>
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Sun, 15 Jan 2023 18:09:52 +0100
Message-ID: <CAGQdkDsHuR2+zuDiFKJWpAYYf+fBgkpAFJVs5qUEWV-nOhxztA@mail.gmail.com>
Subject: Re: [QUESTION] usage of BPF_MAP_TYPE_RINGBUF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Il giorno ven 13 gen 2023 alle ore 23:57 Andrii Nakryiko
<andrii.nakryiko@gmail.com> ha scritto:
>
> On Wed, Jan 11, 2023 at 12:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Jan 10, 2023 at 02:49:59PM +0100, andrea terzolo wrote:
> > > Hello!
> > >
> > > If I can I would ask a question regarding the BPF_MAP_TYPE_RINGBUF
> > > map. Looking at the kernel implementation [0] it seems that data pages
> > > are mapped 2 times to have a more efficient and simpler
> > > implementation. This seems to be a ring buffer peculiarity, the perf
> > > buffer didn't have such an implementation. In the Falco project [1] we
> > > use huge per-CPU buffers to collect almost all the syscalls that the
> > > system throws and the default size of each buffer is 8 MB. This means
> > > that using the ring buffer approach on a system with 128 CPUs, we will
> > > have (128*8*2) MB, while with the perf buffer only (128*8) MB. The
> >
> > hum IIUC it's not allocated twice but pages are just mapped twice,
> > to cope with wrap around samples, described in git log:
> >
> >     One interesting implementation bit, that significantly simplifies (and thus
> >     speeds up as well) implementation of both producers and consumers is how data
> >     area is mapped twice contiguously back-to-back in the virtual memory. This
> >     allows to not take any special measures for samples that have to wrap around
> >     at the end of the circular buffer data area, because the next page after the
> >     last data page would be first data page again, and thus the sample will still
> >     appear completely contiguous in virtual memory. See comment and a simple ASCII
> >     diagram showing this visually in bpf_ringbuf_area_alloc().
>
> yes, exactly, there is no duplication of memory, it's just mapped
> twice to make working with records that wrap around simple and
> efficient
>

Thank you very much for the quick response, my previous question was
quite unclear, sorry for that, I will try to explain me better with
some data. I've collected in this document [3] some thoughts regarding
2 simple examples with perf buffer and ring buffer. Without going into
too many details about the document, I've noticed a strange value of
"Resident set size" (RSS) in the ring buffer example. Probably is
perfectly fine but I really don't understand why the "RSS" for each
ring buffer assumes the same value of the Virtual memory size and I'm
just asking myself if this fact could impact the OOM score computation
making the program that uses ring buffers more vulnerable to the OOM
killer.

[3]: https://hackmd.io/@l56JYH1SS9-QXhSNXKanMw/r1Z8APWso

> >
> > > issue is that this memory requirement could be too much for some
> > > systems and also in Kubernetes environments where there are strict
> > > resource limits... Our actual workaround is to use ring buffers shared
> > > between more than one CPU with a BPF_MAP_TYPE_ARRAY_OF_MAPS, so for
> > > example we allocate a ring buffer for each CPU pair. Unfortunately,
> > > this solution has a price since we increase the contention on the ring
> > > buffers and as highlighted here [2], the presence of multiple
> > > competing writers on the same buffer could become a real bottleneck...
> > > Sorry for the long introduction, my question here is, are there any
> > > other approaches to manage such a scenario? Will there be a
> > > possibility to use the ring buffer without the kernel double mapping
> > > in the near future? The ring buffer has such amazing features with
> > > respect to the perf buffer, but in a scenario like the Falco one,
> > > where we have aggressive multiple producers, this double mapping could
> > > become a limitation.
> >
> > AFAIK the bpf ring buffer can be used across cpus, so you don't need
> > to have extra copy for each cpu if you don't really want to
> >
>
> seems like they do share, but only between CPUs. But nothing prevents
> you from sharing between more than 2 CPUs, right? It's a tradeoff

Yes exactly, we can and we will do it

> between contention and overall memory usage (but as pointed out,
> ringbuf doesn't use 2x more memory). Do you actually see a lot of
> contention when sharing ringbuf between 2 CPUs? There are multiple

Actually no, I've not seen a lot of contention with this
configuration, it seems to handle throughput quite well. BTW it's
still an experimental solution so it is not much tested against
real-world workloads.

> applications that share a single ringbuf between all CPUs, and no one
> really complained about high contention so far. You'd need to push
> tons of data non-stop, probably, at which point I'd worry about
> consumers not being able to keep up (and definitely not doing much
> useful with all this data). But YMMV, of course.
>

We are a little bit worried about the single ring buffer scenario,
mainly when we have something like 64 CPUs and all syscalls enabled,
but as you correctly highlighted in this case we would have also some
issues userspace side because we wouldn't be able to handle all this
traffic, causing tons of event drops. BTW thank you for the feedback!

> > jirka
> >
> > >
> > > Thank you in advance for your time,
> > > Andrea
> > >
> > > 0: https://github.com/torvalds/linux/blob/master/kernel/bpf/ringbuf.c#L107
> > > 1: https://github.com/falcosecurity/falco
> > > 2: https://patchwork.ozlabs.org/project/netdev/patch/20200529075424.3139988-5-andriin@fb.com/

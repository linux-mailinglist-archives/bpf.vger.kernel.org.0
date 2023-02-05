Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4387368B099
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBEP3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjBEP3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 10:29:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B84C19
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 07:28:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m2so27726485ejb.8
        for <bpf@vger.kernel.org>; Sun, 05 Feb 2023 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSB/lTJhhMzDCZV2eVPfO++u6em+fQFy9fmwqr1lGp0=;
        b=hLVfXknt11mE+t2gP07PvWWaXrRksvg8d+g09thvwzhBLHtl+XmEgeEfCh9HSWgen1
         AjSYYhtjL8yvyiEueeuZFbc4sTYoQX7MUOwFrk9b2mWaUqKRia3244ILhYJpE/h6eDvv
         sdPe4cgttLEWmAHb8OT5Cbx8QOpxRHckdPavQY7D5SyUn8FxItWzmPI2WD50/HT/7dca
         p2ohrOycCD6FrIWfs0uGcu50oF6kvFPuWUvU6FbeGEeVY63bX5+FVYdAh8lKPyeynfb8
         xY0n4ci7YWi/+PVpqwsLcSjAJAcCLqWJsTsnnaT3Vb3vYuMbyk4KlQfT/ucD4WqxdtN2
         h1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSB/lTJhhMzDCZV2eVPfO++u6em+fQFy9fmwqr1lGp0=;
        b=c6HQ0CIQAhqKRr45GSmoTFdn6RPMBshkCC1KzaWp9vgppmHS88UiYaLZGHa2ap1r1H
         nGqSDp46FCf/aabqGZYA/i0STkUb52p6joLndYfcFCTCe6ncoD0qHT10XAQtidsY+yft
         Ovy3WGV+F8vrJGu2G3Y3fktjHq1EbFQo/Gp8iik32u76XI/4RDWJRfdwm5PXjgGP0PM/
         nMERHUMZwp/Gqwpo11ttNM9mRL0GvcMcnnk28fzpggqAHhXAAQOKRPERWXUe1chrmSyp
         awNgiaQFXR6FOP2MLjgZsjmNxjrNCK0GwuVdRQxduP+JBg3Z5JNgfTc8lyJpe8ZTyyzr
         GD+g==
X-Gm-Message-State: AO0yUKXmGO6Lk/VE0alTgakUBk9wGWvcalpA67vP133pEjpwinIBREdv
        gXqVFO9Uy2aek1RLazgKc9YLeTnxDl9NStTYILs=
X-Google-Smtp-Source: AK7set9iwqkciLN50jhRsDBC63qrBuX4ZbHKNpeN3g8m5LcbV3d8qNGb/9yJisQgRNYr40rakZUgNYU/FkdsBy2DsPw=
X-Received: by 2002:a17:906:2318:b0:884:2d1:ab91 with SMTP id
 l24-20020a170906231800b0088402d1ab91mr4976840eja.271.1675610936874; Sun, 05
 Feb 2023 07:28:56 -0800 (PST)
MIME-Version: 1.0
References: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
 <Y75zBpkr1tLXKMWX@krava> <CAEf4BzZDfTAaahM3zwkKwcF2RG4C0HPN+ZPzT7XH517QsvDmTw@mail.gmail.com>
 <CAGQdkDsHuR2+zuDiFKJWpAYYf+fBgkpAFJVs5qUEWV-nOhxztA@mail.gmail.com> <CAEf4BzbYoGY2e_Nf1EOgzDdjGOLbSjJ5OmHRDFnYUA_VDYD6zQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbYoGY2e_Nf1EOgzDdjGOLbSjJ5OmHRDFnYUA_VDYD6zQ@mail.gmail.com>
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Sun, 5 Feb 2023 16:28:45 +0100
Message-ID: <CAGQdkDuJ49w_=V59exbyWbW2qB7d8Pz71Vcbkk6fWLwBPeAXtQ@mail.gmail.com>
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

Il giorno ven 27 gen 2023 alle ore 19:54 Andrii Nakryiko
<andrii.nakryiko@gmail.com> ha scritto:
>
> On Sun, Jan 15, 2023 at 9:10 AM andrea terzolo <andreaterzolo3@gmail.com> wrote:
> >
> > Il giorno ven 13 gen 2023 alle ore 23:57 Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> ha scritto:
> > >
> > > On Wed, Jan 11, 2023 at 12:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Tue, Jan 10, 2023 at 02:49:59PM +0100, andrea terzolo wrote:
> > > > > Hello!
> > > > >
> > > > > If I can I would ask a question regarding the BPF_MAP_TYPE_RINGBUF
> > > > > map. Looking at the kernel implementation [0] it seems that data pages
> > > > > are mapped 2 times to have a more efficient and simpler
> > > > > implementation. This seems to be a ring buffer peculiarity, the perf
> > > > > buffer didn't have such an implementation. In the Falco project [1] we
> > > > > use huge per-CPU buffers to collect almost all the syscalls that the
> > > > > system throws and the default size of each buffer is 8 MB. This means
> > > > > that using the ring buffer approach on a system with 128 CPUs, we will
> > > > > have (128*8*2) MB, while with the perf buffer only (128*8) MB. The
> > > >
> > > > hum IIUC it's not allocated twice but pages are just mapped twice,
> > > > to cope with wrap around samples, described in git log:
> > > >
> > > >     One interesting implementation bit, that significantly simplifies (and thus
> > > >     speeds up as well) implementation of both producers and consumers is how data
> > > >     area is mapped twice contiguously back-to-back in the virtual memory. This
> > > >     allows to not take any special measures for samples that have to wrap around
> > > >     at the end of the circular buffer data area, because the next page after the
> > > >     last data page would be first data page again, and thus the sample will still
> > > >     appear completely contiguous in virtual memory. See comment and a simple ASCII
> > > >     diagram showing this visually in bpf_ringbuf_area_alloc().
> > >
> > > yes, exactly, there is no duplication of memory, it's just mapped
> > > twice to make working with records that wrap around simple and
> > > efficient
> > >
> >
> > Thank you very much for the quick response, my previous question was
> > quite unclear, sorry for that, I will try to explain me better with
> > some data. I've collected in this document [3] some thoughts regarding
> > 2 simple examples with perf buffer and ring buffer. Without going into
> > too many details about the document, I've noticed a strange value of
> > "Resident set size" (RSS) in the ring buffer example. Probably is
> > perfectly fine but I really don't understand why the "RSS" for each
> > ring buffer assumes the same value of the Virtual memory size and I'm
> > just asking myself if this fact could impact the OOM score computation
> > making the program that uses ring buffers more vulnerable to the OOM
> > killer.
> >
> > [3]: https://hackmd.io/@l56JYH1SS9-QXhSNXKanMw/r1Z8APWso
> >
>
> I'm not an mm expert, unfortunately. Perhaps because we have twice as
> many pages mapped (even though they are using only 8MB of physical
> memory), it is treated as if process' RSS usage is 2x of that. I can
> see how that might be a concern for OOM score, but I'm not sure what
> can be done about this...
>

Yes, this is weird behavior. Unfortunately, a process that uses a ring
buffer for each CPU is penalized from this point of view with respect
to one that uses a perf buffer. Do you know by chance someone who can
help us with this strange memory reservation?

> > > >
> > > > > issue is that this memory requirement could be too much for some
> > > > > systems and also in Kubernetes environments where there are strict
> > > > > resource limits... Our actual workaround is to use ring buffers shared
> > > > > between more than one CPU with a BPF_MAP_TYPE_ARRAY_OF_MAPS, so for
> > > > > example we allocate a ring buffer for each CPU pair. Unfortunately,
> > > > > this solution has a price since we increase the contention on the ring
> > > > > buffers and as highlighted here [2], the presence of multiple
> > > > > competing writers on the same buffer could become a real bottleneck...
> > > > > Sorry for the long introduction, my question here is, are there any
> > > > > other approaches to manage such a scenario? Will there be a
> > > > > possibility to use the ring buffer without the kernel double mapping
> > > > > in the near future? The ring buffer has such amazing features with
> > > > > respect to the perf buffer, but in a scenario like the Falco one,
> > > > > where we have aggressive multiple producers, this double mapping could
> > > > > become a limitation.
> > > >
> > > > AFAIK the bpf ring buffer can be used across cpus, so you don't need
> > > > to have extra copy for each cpu if you don't really want to
> > > >
> > >
> > > seems like they do share, but only between CPUs. But nothing prevents
> > > you from sharing between more than 2 CPUs, right? It's a tradeoff
> >
> > Yes exactly, we can and we will do it
> >
> > > between contention and overall memory usage (but as pointed out,
> > > ringbuf doesn't use 2x more memory). Do you actually see a lot of
> > > contention when sharing ringbuf between 2 CPUs? There are multiple
> >
> > Actually no, I've not seen a lot of contention with this
> > configuration, it seems to handle throughput quite well. BTW it's
> > still an experimental solution so it is not much tested against
> > real-world workloads.
> >
> > > applications that share a single ringbuf between all CPUs, and no one
> > > really complained about high contention so far. You'd need to push
> > > tons of data non-stop, probably, at which point I'd worry about
> > > consumers not being able to keep up (and definitely not doing much
> > > useful with all this data). But YMMV, of course.
> > >
> >
> > We are a little bit worried about the single ring buffer scenario,
> > mainly when we have something like 64 CPUs and all syscalls enabled,
> > but as you correctly highlighted in this case we would have also some
> > issues userspace side because we wouldn't be able to handle all this
> > traffic, causing tons of event drops. BTW thank you for the feedback!
> >
>
> If you decide to use ringbuf, I'd leverage its ability to be used
> across multiple CPUs and thus reduce the OOM score concern. This is
> what we see in practice here at Meta: at the same or even smaller
> total amount of memory used for ringbuf(s), compared to perfbuf, we
> see less (or no) event drops due to bigger shared buffer that can
> absorb temporary spikes in the amount of events produced.
>

Thank you for the precious feedback about shared ring buffers, we are
already experimenting with similar solutions to mitigate the OOM score
issue, maybe this could be the right way to go also for our use case!

> > > > jirka
> > > >
> > > > >
> > > > > Thank you in advance for your time,
> > > > > Andrea
> > > > >
> > > > > 0: https://github.com/torvalds/linux/blob/master/kernel/bpf/ringbuf.c#L107
> > > > > 1: https://github.com/falcosecurity/falco
> > > > > 2: https://patchwork.ozlabs.org/project/netdev/patch/20200529075424.3139988-5-andriin@fb.com/

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A46973B2
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 02:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBOBfT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 20:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOBfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 20:35:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816AE3401C
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 17:35:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qw12so44605832ejc.2
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 17:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/FWP3VrPb0Z31JVllOghHi7dv50hcb4BiykmiXdxfY=;
        b=aa97eXQdbdzfKajD+Chv8umaRCFCIslUbrPWhXrw2ArgXmyM2pBjNmx5hdwW5y9S5w
         qIZykLQmvrTL+YSLM3VpZX6Is2HdMJF24HO9jCKJQ7QWq7WMMZRI3rTnItY0buxgGWY/
         y/ege3tqZ0dYrcIbHCHYKJK9KX7G1gcDBtANpvezSsBLeQ1AvVuuUnrrRDYC8vovPJZt
         4rXdBq0z4W0c964LyCATvBIBWkFBTWyfZNAyFPO4S0Ca2xw7FMndaW2yP+geHomu4IhN
         lFJpkTQoAiw4V3SHJqcyKO/3vruQG8CP8Au/f+0Z9stU5BcIPg9pGxpJrhEN+ce+s+DW
         Y0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/FWP3VrPb0Z31JVllOghHi7dv50hcb4BiykmiXdxfY=;
        b=ejq2TY8tsvniFMJ/pNu0plu+68s9RueFFkvmOANgt5DHYrQr0HMKZngThRjHJikTPu
         pNlzHSQreOlom+l03CFQ4yKeWOybUZtwclraF7iS+W50NkX5BzffgRV7XZtE+3JtMhhi
         tg/Y2gXiRipR0q2c8lkiZi008EQHpLchthEohD+Wily0ZEn04neU/9SV/w1ZJWfiUDpB
         9nhCG/5s93KO5mmonpyUtEml2a70f5nE+t8Oel5aSr/MB42a1Iud87OYyMPig0PEeIB9
         PVqNBkpILDp478swp8NE0eR9j23PeRQhNZ8MtLZNXprMkzGKhnF3JJzruWX9J0Dn28QV
         zjzw==
X-Gm-Message-State: AO0yUKUfn5uYsBwf8Ir6boUFcHG4yzIk48qoR9IQxbVB96TXuuGyZ2M/
        e1cmsrEMFWmoAkdMINaAKW25kINR9LP1bhqMUteSNFtx/d0=
X-Google-Smtp-Source: AK7set8fkbLBeR/T68nZ39WGC+vsZCIY2VtwjZPCHSXIXkt1BSngwokbMsgvRZZBj4NgjGrIN6clmt1cRvQrzeO6M3U=
X-Received: by 2002:a17:906:ecaf:b0:88d:64e7:a2be with SMTP id
 qh15-20020a170906ecaf00b0088d64e7a2bemr227205ejb.15.1676424914892; Tue, 14
 Feb 2023 17:35:14 -0800 (PST)
MIME-Version: 1.0
References: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
 <Y75zBpkr1tLXKMWX@krava> <CAEf4BzZDfTAaahM3zwkKwcF2RG4C0HPN+ZPzT7XH517QsvDmTw@mail.gmail.com>
 <CAGQdkDsHuR2+zuDiFKJWpAYYf+fBgkpAFJVs5qUEWV-nOhxztA@mail.gmail.com>
 <CAEf4BzbYoGY2e_Nf1EOgzDdjGOLbSjJ5OmHRDFnYUA_VDYD6zQ@mail.gmail.com> <CAGQdkDuJ49w_=V59exbyWbW2qB7d8Pz71Vcbkk6fWLwBPeAXtQ@mail.gmail.com>
In-Reply-To: <CAGQdkDuJ49w_=V59exbyWbW2qB7d8Pz71Vcbkk6fWLwBPeAXtQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Feb 2023 17:35:02 -0800
Message-ID: <CAEf4BzZL-PCtnDirUpvNA6USyJfkO5WCnOk9PYsj4nV8LPUauQ@mail.gmail.com>
Subject: Re: [QUESTION] usage of BPF_MAP_TYPE_RINGBUF
To:     andrea terzolo <andreaterzolo3@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
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

On Sun, Feb 5, 2023 at 7:28 AM andrea terzolo <andreaterzolo3@gmail.com> wrote:
>
> Il giorno ven 27 gen 2023 alle ore 19:54 Andrii Nakryiko
> <andrii.nakryiko@gmail.com> ha scritto:
> >
> > On Sun, Jan 15, 2023 at 9:10 AM andrea terzolo <andreaterzolo3@gmail.com> wrote:
> > >
> > > Il giorno ven 13 gen 2023 alle ore 23:57 Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> ha scritto:
> > > >
> > > > On Wed, Jan 11, 2023 at 12:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jan 10, 2023 at 02:49:59PM +0100, andrea terzolo wrote:
> > > > > > Hello!
> > > > > >
> > > > > > If I can I would ask a question regarding the BPF_MAP_TYPE_RINGBUF
> > > > > > map. Looking at the kernel implementation [0] it seems that data pages
> > > > > > are mapped 2 times to have a more efficient and simpler
> > > > > > implementation. This seems to be a ring buffer peculiarity, the perf
> > > > > > buffer didn't have such an implementation. In the Falco project [1] we
> > > > > > use huge per-CPU buffers to collect almost all the syscalls that the
> > > > > > system throws and the default size of each buffer is 8 MB. This means
> > > > > > that using the ring buffer approach on a system with 128 CPUs, we will
> > > > > > have (128*8*2) MB, while with the perf buffer only (128*8) MB. The
> > > > >
> > > > > hum IIUC it's not allocated twice but pages are just mapped twice,
> > > > > to cope with wrap around samples, described in git log:
> > > > >
> > > > >     One interesting implementation bit, that significantly simplifies (and thus
> > > > >     speeds up as well) implementation of both producers and consumers is how data
> > > > >     area is mapped twice contiguously back-to-back in the virtual memory. This
> > > > >     allows to not take any special measures for samples that have to wrap around
> > > > >     at the end of the circular buffer data area, because the next page after the
> > > > >     last data page would be first data page again, and thus the sample will still
> > > > >     appear completely contiguous in virtual memory. See comment and a simple ASCII
> > > > >     diagram showing this visually in bpf_ringbuf_area_alloc().
> > > >
> > > > yes, exactly, there is no duplication of memory, it's just mapped
> > > > twice to make working with records that wrap around simple and
> > > > efficient
> > > >
> > >
> > > Thank you very much for the quick response, my previous question was
> > > quite unclear, sorry for that, I will try to explain me better with
> > > some data. I've collected in this document [3] some thoughts regarding
> > > 2 simple examples with perf buffer and ring buffer. Without going into
> > > too many details about the document, I've noticed a strange value of
> > > "Resident set size" (RSS) in the ring buffer example. Probably is
> > > perfectly fine but I really don't understand why the "RSS" for each
> > > ring buffer assumes the same value of the Virtual memory size and I'm
> > > just asking myself if this fact could impact the OOM score computation
> > > making the program that uses ring buffers more vulnerable to the OOM
> > > killer.
> > >
> > > [3]: https://hackmd.io/@l56JYH1SS9-QXhSNXKanMw/r1Z8APWso
> > >
> >
> > I'm not an mm expert, unfortunately. Perhaps because we have twice as
> > many pages mapped (even though they are using only 8MB of physical
> > memory), it is treated as if process' RSS usage is 2x of that. I can
> > see how that might be a concern for OOM score, but I'm not sure what
> > can be done about this...
> >
>
> Yes, this is weird behavior. Unfortunately, a process that uses a ring
> buffer for each CPU is penalized from this point of view with respect
> to one that uses a perf buffer. Do you know by chance someone who can
> help us with this strange memory reservation?

So I checked with MM expert, and he confirmed that currently there is
no way to avoid this double-accounting of memory reserved by BPF
ringbuf. But this doesn't seem to be a problem unique to BPF ringbuf,
generally RSS accounting is known to have problems with double
counting memory in some situations.

One relatively clean suggested way to solve this problem would be to
add a new memory counter (in addition to existing MM_SHMEMPAGES,
MM_SWAPENTS, MM_ANONPAGES, MM_FILEPAGES) to compensate for cases like
this.

But it does look like a pretty big overkill here, tbh. Sorry, I don't
have a good solution for you here.

>
> > > > >
> > > > > > issue is that this memory requirement could be too much for some
> > > > > > systems and also in Kubernetes environments where there are strict
> > > > > > resource limits... Our actual workaround is to use ring buffers shared
> > > > > > between more than one CPU with a BPF_MAP_TYPE_ARRAY_OF_MAPS, so for
> > > > > > example we allocate a ring buffer for each CPU pair. Unfortunately,
> > > > > > this solution has a price since we increase the contention on the ring
> > > > > > buffers and as highlighted here [2], the presence of multiple
> > > > > > competing writers on the same buffer could become a real bottleneck...
> > > > > > Sorry for the long introduction, my question here is, are there any
> > > > > > other approaches to manage such a scenario? Will there be a
> > > > > > possibility to use the ring buffer without the kernel double mapping
> > > > > > in the near future? The ring buffer has such amazing features with
> > > > > > respect to the perf buffer, but in a scenario like the Falco one,
> > > > > > where we have aggressive multiple producers, this double mapping could
> > > > > > become a limitation.
> > > > >
> > > > > AFAIK the bpf ring buffer can be used across cpus, so you don't need
> > > > > to have extra copy for each cpu if you don't really want to
> > > > >
> > > >
> > > > seems like they do share, but only between CPUs. But nothing prevents
> > > > you from sharing between more than 2 CPUs, right? It's a tradeoff
> > >
> > > Yes exactly, we can and we will do it
> > >
> > > > between contention and overall memory usage (but as pointed out,
> > > > ringbuf doesn't use 2x more memory). Do you actually see a lot of
> > > > contention when sharing ringbuf between 2 CPUs? There are multiple
> > >
> > > Actually no, I've not seen a lot of contention with this
> > > configuration, it seems to handle throughput quite well. BTW it's
> > > still an experimental solution so it is not much tested against
> > > real-world workloads.
> > >
> > > > applications that share a single ringbuf between all CPUs, and no one
> > > > really complained about high contention so far. You'd need to push
> > > > tons of data non-stop, probably, at which point I'd worry about
> > > > consumers not being able to keep up (and definitely not doing much
> > > > useful with all this data). But YMMV, of course.
> > > >
> > >
> > > We are a little bit worried about the single ring buffer scenario,
> > > mainly when we have something like 64 CPUs and all syscalls enabled,
> > > but as you correctly highlighted in this case we would have also some
> > > issues userspace side because we wouldn't be able to handle all this
> > > traffic, causing tons of event drops. BTW thank you for the feedback!
> > >
> >
> > If you decide to use ringbuf, I'd leverage its ability to be used
> > across multiple CPUs and thus reduce the OOM score concern. This is
> > what we see in practice here at Meta: at the same or even smaller
> > total amount of memory used for ringbuf(s), compared to perfbuf, we
> > see less (or no) event drops due to bigger shared buffer that can
> > absorb temporary spikes in the amount of events produced.
> >
>
> Thank you for the precious feedback about shared ring buffers, we are
> already experimenting with similar solutions to mitigate the OOM score
> issue, maybe this could be the right way to go also for our use case!

Hopefully this will work for you.

>
> > > > > jirka
> > > > >
> > > > > >
> > > > > > Thank you in advance for your time,
> > > > > > Andrea
> > > > > >
> > > > > > 0: https://github.com/torvalds/linux/blob/master/kernel/bpf/ringbuf.c#L107
> > > > > > 1: https://github.com/falcosecurity/falco
> > > > > > 2: https://patchwork.ozlabs.org/project/netdev/patch/20200529075424.3139988-5-andriin@fb.com/

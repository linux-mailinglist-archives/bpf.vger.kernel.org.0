Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B168CB7A
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBGAxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 19:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBGAxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 19:53:37 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976071C5B9
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 16:53:36 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 74so16399820ybl.12
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51cn+25RJhtbSsnTQ7+kMH70MfRmDwmxDwX5ZXNBKug=;
        b=Vdz0UCB9jLeeKMfDH5sCBDeTms+EXqZOdTDB/+4qI0EoRL9L2P+NJFmpv3DcFKIBtL
         xndcINvPp4bint7iWB7y7trinEBIPvAzf1MbYunptnj+wUhFFblgY8zYYRp3J45aK0G/
         DBinD+NhffPUdIO6MmbnLqpun8nKAqbP+u46jFPhTN6I8MniebNY+3TKyfQ5aodr13j3
         nbu9gjc9FQ5V5TI1l30yHKTksf+2cgDt5Csyz92lpbMLTegodusBrlEhFGTbE8Czqye3
         COm8mXYCgBfSKeTm65Hh3gvBUjkhw8WM1bYuB1mZhOvvqae6+MmDxCTsgsK49gGBugvU
         Lklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51cn+25RJhtbSsnTQ7+kMH70MfRmDwmxDwX5ZXNBKug=;
        b=49hCwhYmXf8dvIuDkASkiz3d5pbVeTGwRsraTTv1vznobRNvn1OxZZvg3zkXAiqzVd
         WcZn5hwTHrJ+yoNJElyI+Al1DDWiy+OTvW/kMwDfmhx+nHEovpQNfdyZTXOftISrhC5l
         7Ad0Ub2zfNWRo31dQJHBKjjCYWtrW+3voRbyGODz6ifdG9A1gsx/Zn5/158rXSaYivS0
         ap3xf8St1OKPLhc/6MR1qFYRCcDhSAk+56G9jhWNRIL5Eb84gT0fKQyROAnDwJaCAkXb
         Mg2OjJxrxUwcWXCvKbdwEEojFmZVy33UEcY+HvNZTY4coR2FwH9H9YTn/KQGLWppYVHI
         1USQ==
X-Gm-Message-State: AO0yUKUj/H5QA5loPubksFSSvbW/73kVxrvOUhTFA2ve4si5dtQ0jxjs
        zHaao5eCsRmxThPVsE948DwdhI1efLEdROwtmUrlEA==
X-Google-Smtp-Source: AK7set8ru7SLrkRouqjlWbYwRsalHwklMjTyeJcSICJDwy++QjDoIUzqmILAd0YYcSwq5XREW/b7i8TRBDiyUAzeRZA=
X-Received: by 2002:a25:3285:0:b0:85b:e1a0:e95a with SMTP id
 y127-20020a253285000000b0085be1a0e95amr141956yby.593.1675731215655; Mon, 06
 Feb 2023 16:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <63ddbfd9ae610_6bb1520861@john.notmuch>
 <CALOAHbAjHqXGZH_p19aYTbqK=sE8ZaMxhVzAoTO4ZKSXLiyx-w@mail.gmail.com>
In-Reply-To: <CALOAHbAjHqXGZH_p19aYTbqK=sE8ZaMxhVzAoTO4ZKSXLiyx-w@mail.gmail.com>
From:   Ho-Ren Chuang <horenc@vt.edu>
Date:   Mon, 6 Feb 2023 16:53:24 -0800
Message-ID: <CAOfppAWRYj6Y4Ohzskygw7jWNZPzVZq4iFBWRhR9XtXZ-wHY8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf, mm: bpf memory usage
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        hao.xiang@bytedance.com, yifeima@bytedance.com,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        horenchuang@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yafang and everyone,

We've proposed very similar features at
https://lore.kernel.org/bpf/CAAYibXgiCOOEY9NvLXbY4ve7pH8xWrZjnczrj6SHy3x_Tt=
OU1g@mail.gmail.com/#t

We are very excited seeing we are not the only ones eager to have this
feature upstream to monitor eBPF map's actual usage. This shows the
need for having such an ability in eBPF.

Regarding the use cases please also check
https://lore.kernel.org/all/CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsK=
PckQ@mail.gmail.com/#t
. We are developing an app to monitor memory footprints used by eBPF
programs/maps similar to Linux `top` command.

Thank you,


On Sat, Feb 4, 2023 at 8:03 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sat, Feb 4, 2023 at 10:15 AM John Fastabend <john.fastabend@gmail.com>=
 wrote:
> >
> > Yafang Shao wrote:
> > > Currently we can't get bpf memory usage reliably. bpftool now shows t=
he
> > > bpf memory footprint, which is difference with bpf memory usage. The
> > > difference can be quite great between the footprint showed in bpftool
> > > and the memory actually allocated by bpf in some cases, for example,
> > >
> > > - non-preallocated bpf map
> > >   The non-preallocated bpf map memory usage is dynamically changed. T=
he
> > >   allocated elements count can be from 0 to the max entries. But the
> > >   memory footprint in bpftool only shows a fixed number.
> > > - bpf metadata consumes more memory than bpf element
> > >   In some corner cases, the bpf metadata can consumes a lot more memo=
ry
> > >   than bpf element consumes. For example, it can happen when the elem=
ent
> > >   size is quite small.
> >
> > Just following up slightly on previous comment.
> >
> > The metadata should be fixed and knowable correct?
>
> The metadata of BPF itself is fixed, but the medata of MM allocation
> depends on the kernel configuretion.
>
> > What I'm getting at
> > is if this can be calculated directly instead of through a BPF helper
> > and walking the entire map.
> >
>
> As I explained in another thread, it doesn't walk the entire map.
>
> > >
> > > We need a way to get the bpf memory usage especially there will be mo=
re
> > > and more bpf programs running on the production environment and thus =
the
> > > bpf memory usage is not trivial.
> >
> > In our environments we track map usage so we always know how many entri=
es
> > are in a map. I don't think we use this to calculate memory footprint
> > at the moment, but just for map usage. Seems though once you have this
> > calculating memory footprint can be done out of band because element
> > and overheads costs are fixed.
> >
> > >
> > > This patchset introduces a new map ops ->map_mem_usage to get the mem=
ory
> > > usage. In this ops, the memory usage is got from the pointers which i=
s
> > > already allocated by a bpf map. To make the code simple, we igore som=
e
> > > small pointers as their size are quite small compared with the total
> > > usage.
> > >
> > > In order to get the memory size from the pointers, some generic mm he=
lpers
> > > are introduced firstly, for example, percpu_size(), vsize() and kvsiz=
e().
> > >
> > > This patchset only implements the bpf memory usage for hashtab. I wil=
l
> > > extend it to other maps and bpf progs (bpf progs can dynamically allo=
cate
> > > memory via bpf_obj_new()) in the future.
> >
> > My preference would be to calculate this out of band. Walking a
> > large map and doing it in a critical section to get the memory
> > usage seems not optimal
> >
>
> I don't quite understand what you mean by calculating it out of band.
> This patchset introduces a BPF helper which is used in bpftool, so it
> is already out of band, right ?
> We should do it in bpftool, because the sys admin wants a generic way
> to get the system-wide bpf memory usage.
>
> --
> Regards
> Yafang



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

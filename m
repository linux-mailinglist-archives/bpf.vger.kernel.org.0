Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7336268AE30
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 05:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBEEDo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 23:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBEEDn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 23:03:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF11EFE2
        for <bpf@vger.kernel.org>; Sat,  4 Feb 2023 20:03:42 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i17so406982qvq.13
        for <bpf@vger.kernel.org>; Sat, 04 Feb 2023 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaRPKrJenXRlZJRlBBTvbxO+nfonIN+I19ij1t4XP64=;
        b=Aa1mix3e8gLG5LLSupYiWkuEHwoutDVPEZSZ7NJdZJPxtIf+K1HDgEKH2VNSqChHf+
         VrJ45A874dIqoRl64MuWs58lolMC78y20HtYFJ+FBJRo1FZgH2ITWVFuI8I0JOASynsp
         0uYKaAR1cwxpQDc6uXzQyypybseh3z5jLWpv/1UVO97bOiqPi4XGa8bAyQHqcxED6WP3
         qadOIoznP44B1kmPL1vGuS3k4WWq9piCRtkBZRdy4FtrbNNMS1irHz39SayE7rGbg1va
         9ewW/i094JsrUdettae1Vr8oO5KAc19awwbXWlfEG6D8X1ljdJ0pXrFLul0w7bWenatx
         DDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaRPKrJenXRlZJRlBBTvbxO+nfonIN+I19ij1t4XP64=;
        b=q3FVwF+ZV3xQmLlRl9qtCILWVVQF1NLZHMwHvHm1VUomwnWAtW97ozOupcRj3msnZO
         /o+LBQBUyg02J91BEiEbn5+yuUfZRsxOxdMPcqAYq3BUFH/c8aVmZW0U5ohpVSorjYlS
         HxDKvZ5JVCUKOJEEzDP3aLFUk0rene1Rc53fJkRhnwu4p2CnGN4FL2BhhPSyWnmf2MLV
         LFwl8lPNe7Kve3YnaocWlpxhbyFjJvClBlezy4Dmm0vcDg6DWbPdCx03ZmATehlFYD7s
         DhTk+2ZuS26avEWCEYCqI9Vz2p8XiTc6MdzyjfQXpnGBWO/xOQy1ht6ooKZf+1+AjcY9
         TUJw==
X-Gm-Message-State: AO0yUKU9RFX7xFfUV8RnMLgUvldZTq6SMyJm+L1NQrxkiL0x7gF7sYsu
        R+IFTvrok/oGS+tjhytueIZr5HUeYOXaEHEVeuY=
X-Google-Smtp-Source: AK7set8W7nYgfrENJ4TTYMIbustDq1gYm/g5s7cOtFvu5XJzRHm0MGd9YbMkaAzPRxr56Xb31usjP160ASIBpmqBhbE=
X-Received: by 2002:a0c:fa52:0:b0:537:762f:48c3 with SMTP id
 k18-20020a0cfa52000000b00537762f48c3mr921710qvo.74.1675569821613; Sat, 04 Feb
 2023 20:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <63ddbfd9ae610_6bb1520861@john.notmuch>
In-Reply-To: <63ddbfd9ae610_6bb1520861@john.notmuch>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 5 Feb 2023 12:03:05 +0800
Message-ID: <CALOAHbAjHqXGZH_p19aYTbqK=sE8ZaMxhVzAoTO4ZKSXLiyx-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf, mm: bpf memory usage
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, vbabka@suse.cz, urezki@gmail.com,
        linux-mm@kvack.org, bpf@vger.kernel.org
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

On Sat, Feb 4, 2023 at 10:15 AM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Yafang Shao wrote:
> > Currently we can't get bpf memory usage reliably. bpftool now shows the
> > bpf memory footprint, which is difference with bpf memory usage. The
> > difference can be quite great between the footprint showed in bpftool
> > and the memory actually allocated by bpf in some cases, for example,
> >
> > - non-preallocated bpf map
> >   The non-preallocated bpf map memory usage is dynamically changed. The
> >   allocated elements count can be from 0 to the max entries. But the
> >   memory footprint in bpftool only shows a fixed number.
> > - bpf metadata consumes more memory than bpf element
> >   In some corner cases, the bpf metadata can consumes a lot more memory
> >   than bpf element consumes. For example, it can happen when the element
> >   size is quite small.
>
> Just following up slightly on previous comment.
>
> The metadata should be fixed and knowable correct?

The metadata of BPF itself is fixed, but the medata of MM allocation
depends on the kernel configuretion.

> What I'm getting at
> is if this can be calculated directly instead of through a BPF helper
> and walking the entire map.
>

As I explained in another thread, it doesn't walk the entire map.

> >
> > We need a way to get the bpf memory usage especially there will be more
> > and more bpf programs running on the production environment and thus the
> > bpf memory usage is not trivial.
>
> In our environments we track map usage so we always know how many entries
> are in a map. I don't think we use this to calculate memory footprint
> at the moment, but just for map usage. Seems though once you have this
> calculating memory footprint can be done out of band because element
> and overheads costs are fixed.
>
> >
> > This patchset introduces a new map ops ->map_mem_usage to get the memory
> > usage. In this ops, the memory usage is got from the pointers which is
> > already allocated by a bpf map. To make the code simple, we igore some
> > small pointers as their size are quite small compared with the total
> > usage.
> >
> > In order to get the memory size from the pointers, some generic mm helpers
> > are introduced firstly, for example, percpu_size(), vsize() and kvsize().
> >
> > This patchset only implements the bpf memory usage for hashtab. I will
> > extend it to other maps and bpf progs (bpf progs can dynamically allocate
> > memory via bpf_obj_new()) in the future.
>
> My preference would be to calculate this out of band. Walking a
> large map and doing it in a critical section to get the memory
> usage seems not optimal
>

I don't quite understand what you mean by calculating it out of band.
This patchset introduces a BPF helper which is used in bpftool, so it
is already out of band, right ?
We should do it in bpftool, because the sys admin wants a generic way
to get the system-wide bpf memory usage.

-- 
Regards
Yafang

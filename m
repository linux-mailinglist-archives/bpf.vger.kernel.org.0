Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA14741A440
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 02:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhI1Ahv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 20:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhI1Ahv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 20:37:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE8C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 17:36:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m132so7945966ybf.8
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dw10IWq1uMSILzLDi3+eQCW0s3zmx+S4kDdngtWi4n4=;
        b=ePPye/zPYB5JpHvDDejo6LgVo5qA0Nfmhi1XHo/kWJMZl1LUgpqGIQT694unpq4y2V
         nGUowtSsyNwhwxSFccj4zJLURB3nHXSr8KJscHKcLBdmxhJFEsDe7DyVx67BwMxUkrWK
         cD7t8Ul9ONFuBofY1mYsvFQZC8yghsSueEhdeD7kUZuhkwI4NOInabQb2j44SzdR8oFz
         kN9jYDBWCYlikwF3dcH+1G0tVmBsOf+zDApag2VJ1KxCMIduxIE2cYih7TKDMY1vfazR
         Rht1fXQpxO/MLbRCvJoypAWuqNuctzZgc8dRYsZ8SOHqkxJJTlGgEwR05wC5VM7hukJe
         7/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dw10IWq1uMSILzLDi3+eQCW0s3zmx+S4kDdngtWi4n4=;
        b=tlxCrWvs4lZKV1aX2ALAs9sEhpeSR9i/PGKZLf4+zUbDMn/TFBJKntrYa+T8bXqNTA
         W7/JGdbKdA0T9beK7TClXS/c6t4W2JjrhAYVmclTtItrO6eIpwMZXKew4/nJAVDV+1h+
         EOYCXGpXa4WqUqLYpEuhIl3U7TXFP1OCU5X2mPsVlGOqPGZ1VlZcVsGFD3wcokiVNuwI
         TxrIc2VQODLcG2867Z4iaHpRgH04Eh+qyZefCwKP/AYEJFZbbYMgPAxKSvjG1/NbTho9
         8QIkMozdBCydENmRWIC4eskq05IYNQaxPJ+r7foOiwgbAvLYL8xSNpVEHyGM3WIPvWto
         zoZQ==
X-Gm-Message-State: AOAM533JRcTuKEBN5Fft5dq0fhhpwfvO3i2bfj83iYYEO5h/O0hxoDqN
        CV9x0HTR8WvNTh3Uw/FyQwHis4zDF6go4UouniqaW1Kjk0E=
X-Google-Smtp-Source: ABdhPJw0slvSPMV8Np96irYyT7pNTXMmuEc+T5BucfJrOxnnNYsdr96aTowBXLm1W2zvXv1FehMuoMKyWLlQ2OOrlVs=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr3566816ybc.225.1632789371705;
 Mon, 27 Sep 2021 17:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp> <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com> <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com> <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com> <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 17:36:00 -0700
Message-ID: <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 4:51 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 02:14:09PM -0700, Andrii Nakryiko wrote:
> > On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > That's not what I proposed. So let's say somewhere in the kernel we
> > > > have this variable:
> > > >
> > > > static int bpf_bloom_exists = 1;
> > > >
> > > > Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> > > > all its hashed bits are set in Bloom filter (it "exists"), we return
> > > > &bpf_bloom_exists. So it's not a NULL pointer.
> > >
> > > imo that's too much of a hack.
> >
> > too bad, because this feels pretty natural in BPF code:
> >
> > int my_key = 1234;
> >
> > if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
> >     /* handle "maybe exists" */
> > } else {
> >     /* handle "definitely doesn't exist" */
> > }
>
> I don't think it fits bitset map.
> In the bitset the value is zero or one. It always exist.
> If bloomfilter is not a special map and instead implemented on top of
> generic bitset with a plain loop in a bpf program then
> push -> bit_set
> pop -> bit_clear
> peek -> bit_test
> would be a better fit for bitset map.
>
> bpf_map_pop_elem() and peek_elem() don't have 'flags' argument.
> In most cases that would be a blocker,
> but in this case we can add:
> .arg3_type      = ARG_ANYTHING
> and ignore it in case of stack/queue.
> While bitset could use the flags as an additional seed into the hash.
> So to do a bloomfilter the bpf prog would do:
> for (i = 0; i < 5; i++)
>    if (bpf_map_peek_elem(map, &value, conver_i_to_seed(i)))

I think I'm getting lost in the whole unified bitset + bloom filter
design, tbh. In this case, why would you pass the seed to peek()? And
what is value here? Is that the value (N bytes) or the bit index (4
bytes?)? I assumed that once we have a hashing helper and a bitset
map, you'd use that and seed to calculate bit index. But now I'm
confused about what this peek operation is doing. I'm sorry if I'm
just slow.

Overall, I think I agree with Joanne that a separate dedicated Bloom
filter map will have simpler and better usability. This bitset + bloom
filter generalization seems to just create unnecessary confusion. I
don't feel the need for bitset map even more than I didn't feel the
need for Bloom filter, given it's even simpler data structure and is
totally implementable on either global var array or
BPF_MAP_TYPE_ARRAY, if map-in-map and dynamic sizing in mandatory.

But given we are converging on having a new map, maybe let's do just a
Bloom filter map with the tweaks we discussed in this thread for
map_extra and max_entries?

>
> Probably would still be an improvement to add:
> static inline long bpf_bit_test(void *map, void *value, long flags)
> {
>     return bpf_map_peek_elem(map, value, flags);
> }
> to some header file.
>
> Or maybe bloomfilter and the loop can be a flavor of bitset map and
> done inside the helper to spare bpf programmers doing the manual loops.
> Or such loop could be another static inline function in a header file?

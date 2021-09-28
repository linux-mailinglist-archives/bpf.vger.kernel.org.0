Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4363E41B3B3
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhI1QXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbhI1QXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 12:23:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203CC06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:21:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k17so19354250pff.8
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPGPL/d6LUmATl9eLMSpqEC+PnksaRuKQCpPDhqY2nQ=;
        b=hQve0bpQtCnJt7gVeWDQ59DD2orR+e/LuDtdJl9cBe71Tt01O3VgEPci5wEocbkkrE
         0hiN3CcPKb2Q9mLTs7bw3rip1rHF4EJHxrTCgwB7zJHE5ohoMVRVdkGgrSeEhbOQXheP
         raf3EHKieATbA4KkKUaBj5DJY7shPjeX1Uhc8myF4z2xSJYS01oZMyAlGVQ/MbLcYs0j
         ZvO76nJBXWUEQrQt9mx+J8kMcPwyLWoAPl0zDqHGZWT87I5RuV3Vw+3ogj6irtX/R+6Y
         VWDy4vGy+3tA+J2hN7Tg57uLqVEgT2Faqi0vQLOp3/7jNdjmWXkqQCe1+VOf0E6QB3gP
         kWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPGPL/d6LUmATl9eLMSpqEC+PnksaRuKQCpPDhqY2nQ=;
        b=ZW4JFdNgYwQVSujIT5cP0MXgSLp3pycmBVNS7eeoIiP8Ik8BcagI3x6kWeq4VjU4eU
         E0B0V/+5jhzoJGvo4Rlgylhr6ffL9DcGPYIg4MNruMMgPdCWSHm5wbvpOW9s9xKOwd8E
         A01X9OLeuFWeFwYKcPlXucVPYhCGzUBJPLsn4h8NnxlmQ5VIvlFGkmUdliBO3aB4nFVl
         m4mMQC2QKwzSCOGAEkjm1i3SSIYAWp5PW4Mm/PQHocqhidpWcZqpLOrG2thR3bXpkC4r
         4G1L0UxWQtZ8W9jqWKoVr2i8n6w1RiOIL8cN/Y/lWdtGp9z5y3GaXg85LZXQKuFPSsFj
         inoA==
X-Gm-Message-State: AOAM5307cf3XpDZnpeZt5cEGvC9VitGeK8loVnhcrrT3vT/3WsdyBtBC
        FYlkiDWY7XUkWKpSFWzplg8=
X-Google-Smtp-Source: ABdhPJzuBpyIdC//XQo6xIgFP7dWQd6Zc6fGjcAge5JY3pRr3yb2M4ydHwQ0wwma3tbal+Gu9itXqQ==
X-Received: by 2002:aa7:991b:0:b0:447:bf92:b94d with SMTP id z27-20020aa7991b000000b00447bf92b94dmr6420123pff.76.1632846087429;
        Tue, 28 Sep 2021 09:21:27 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::6:e195])
        by smtp.gmail.com with ESMTPSA id o15sm22115002pfg.14.2021.09.28.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 09:21:27 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:21:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com>
References: <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
 <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 05:36:00PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 27, 2021 at 4:51 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 27, 2021 at 02:14:09PM -0700, Andrii Nakryiko wrote:
> > > On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> > > > >
> > > > > That's not what I proposed. So let's say somewhere in the kernel we
> > > > > have this variable:
> > > > >
> > > > > static int bpf_bloom_exists = 1;
> > > > >
> > > > > Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> > > > > all its hashed bits are set in Bloom filter (it "exists"), we return
> > > > > &bpf_bloom_exists. So it's not a NULL pointer.
> > > >
> > > > imo that's too much of a hack.
> > >
> > > too bad, because this feels pretty natural in BPF code:
> > >
> > > int my_key = 1234;
> > >
> > > if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
> > >     /* handle "maybe exists" */
> > > } else {
> > >     /* handle "definitely doesn't exist" */
> > > }
> >
> > I don't think it fits bitset map.
> > In the bitset the value is zero or one. It always exist.
> > If bloomfilter is not a special map and instead implemented on top of
> > generic bitset with a plain loop in a bpf program then
> > push -> bit_set
> > pop -> bit_clear
> > peek -> bit_test
> > would be a better fit for bitset map.
> >
> > bpf_map_pop_elem() and peek_elem() don't have 'flags' argument.
> > In most cases that would be a blocker,
> > but in this case we can add:
> > .arg3_type      = ARG_ANYTHING
> > and ignore it in case of stack/queue.
> > While bitset could use the flags as an additional seed into the hash.
> > So to do a bloomfilter the bpf prog would do:
> > for (i = 0; i < 5; i++)
> >    if (bpf_map_peek_elem(map, &value, conver_i_to_seed(i)))
> 
> I think I'm getting lost in the whole unified bitset + bloom filter
> design, tbh. In this case, why would you pass the seed to peek()? And
> what is value here? Is that the value (N bytes) or the bit index (4
> bytes?)? 

The full N byte value, of course.
The pure index has the same downsides as hashing helper:
- hard to make kernel and user space produce the same hash in all cases
- inability to dynamically change max_entries in a clean way

> I assumed that once we have a hashing helper and a bitset
> map, you'd use that and seed to calculate bit index. But now I'm
> confused about what this peek operation is doing. I'm sorry if I'm
> just slow.
> 
> Overall, I think I agree with Joanne that a separate dedicated Bloom
> filter map will have simpler and better usability. This bitset + bloom
> filter generalization seems to just create unnecessary confusion. I
> don't feel the need for bitset map even more than I didn't feel the
> need for Bloom filter, given it's even simpler data structure and is
> totally implementable on either global var array or
> BPF_MAP_TYPE_ARRAY, if map-in-map and dynamic sizing in mandatory.

Not really. For two reasons:
- inner array with N 8-byte elements is a slow workaround.
map_lookup is not inlined for inner arrays because max_entries will
be different.
- doing the same hash in user space and the kernel is hard.
For example, iproute2 is using socket(AF_ALG) to compute the same hash
(program tag) as the kernel.
Copy-paste of kernel jhash.h is not possible due to GPL,
but, as you pointed out, it's public domain, so user space would
need to search a public domain, reimplement jhash and then
make sure that it produces the same hash as the kernel.
All these trade offs point out the need for dedicated map type
(either generalized bitset or true bloomfilter) that does the hashing
and can change its size.

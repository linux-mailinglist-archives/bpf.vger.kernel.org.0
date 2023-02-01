Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A862E683AE6
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 01:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBAADD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 19:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjBAADB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 19:03:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E9901E
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:02:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bk15so46510408ejb.9
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R/sWmGmZ37TtC1FR/+0XPhD9Iq/Tp2XFVYlEye0wy08=;
        b=DL6HLCnEgNInDHpIfE/udXIbiYJjCtQD/gNB7UF3MB804D+d7uOkB2eOmppPxhf2VJ
         ss8d/XIQ+9C8uGPATD+jpGn2yzmmvwsVXJaNS53hN37XEyvMWd45GEp/S5/kRZslF39d
         2mkEhif+JRQ06E8XZ2I1udBLr+GQFHnXZz46hSuTGDqhKHbJCrLkdSidctRBWCjRFNNv
         DUzVD87cBOuxb/lnRUn4t3zrs2hpBx0wdM+I66/PVAYUvytKxehzaO5rVU4uhhgxg/jy
         Rd0NU4xmqutee81GmEHW+qhwAufAwaHUfKyqAOj2D7X1V2m9zP6yC7i8AM6oNgyYDT5K
         at1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/sWmGmZ37TtC1FR/+0XPhD9Iq/Tp2XFVYlEye0wy08=;
        b=4EnLq0ZDQf0t+UWk4IgZTSIofm9I0xaCKv8IPY35J6F+yk3pp0XepBblPabmIfyGk3
         KjHqqtp7lCWc3Ph5S0NHRFNOw+WMmBURf3E8NyLJK5khWr/621awOV7cUb3TNmZ/CGiA
         8LaKEOwBTIeUWxrpv0ZP/WS/ImiyyMHJJzDbH5gfzRd/OPrpgp5csjMKQH4YXxEskJzz
         H2fs1eVOBMsGJtOE2t72BV8wetLZprAiZISQrU39GOBt9bpOyMC+l8NfAzYVsHQsZDJH
         jZPJZF3VtBaFH2uyZbx7On0dlYWhuWwRmWf2p69kxyGqP2GhKNYebQw5GbfZNMpekvoq
         ghuw==
X-Gm-Message-State: AO0yUKXaQ9Knzwl1fKvBQjIKnA3JJPoQjI+AQ3A1rFKx1ZJ3tqEfvv7+
        f7NlmCpq0TNpnjq1RQfqR4s1Fzae2Aa4SGNLmAs=
X-Google-Smtp-Source: AK7set+DiEGoegqHZubuoXmmFLhEhbe0YW3QtNrscU3acR1Dm0hlPTqQibWW2FekGYBlYp45T10KldkPvZahZMo7rWg=
X-Received: by 2002:a17:906:5609:b0:88d:5955:b59 with SMTP id
 f9-20020a170906560900b0088d59550b59mr77347ejq.68.1675209775719; Tue, 31 Jan
 2023 16:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20230127181457.21389-1-aspsk@isovalent.com> <CAEf4BzYcMM4hzvD3TSPnK052W2a0Eu2ygm4BixPmMaZioq9TKg@mail.gmail.com>
 <Y9jxwMhL+O3obDzD@lavr> <CAEf4BzYxZpc8NZssBkpkT86A3ZFc9i08am9s76o6334HwBGMdA@mail.gmail.com>
 <Y9lpilqPsW1stF/a@lavr>
In-Reply-To: <Y9lpilqPsW1stF/a@lavr>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Jan 2023 16:02:42 -0800
Message-ID: <CAEf4BzbJPfvzzwBdapxzs7vPyHjEr_fcntKpOFeuHQbzwyE4Qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/6] New benchmark for hashmap lookups
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
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

On Tue, Jan 31, 2023 at 11:18 AM Anton Protopopov <aspsk@isovalent.com> wrote:
>
> On 23/01/31 10:48, Andrii Nakryiko wrote:
> > On Tue, Jan 31, 2023 at 2:47 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > On 23/01/30 04:17, Andrii Nakryiko wrote:
> > > > On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > >
> > > > > Add a new benchmark for hashmap lookups and fix several typos. See individual
> > > > > commits for descriptions.
> > > > >
> > > > > One thing to mention here is that in commit 3 I've patched bench so that now
> > > > > command line options can be reused by different benchmarks.
> > > > >
> > > > > The benchmark itself is added in the last commit 6. I am using this benchmark
> > > > > to test map lookup productivity when using a different hash function (see
> > > > > https://fosdem.org/2023/schedule/event/bpf_hashing/). The results provided by
> > > > > the benchmark look reasonable and match the results of my different benchmarks
> > > > > (requiring to patch kernel to get actual statistics on map lookups).
> > > >
> > > > Could you share the results with us? Curious which hash functions did
> > > > you try and which one are the most promising :)
> > >
> > > For the longer version with pictures see the talk I've referenced above (it's
> > > at FOSDEM next Sunday Feb 5). A short version follows.
> >
> > Yep, I'll try to watch it.
> >
> > >
> > > The xxh3 hash works fine for big keys, where "big" is different for different
> > > architectures and for different maps sizes. On my Intel i7 machine this means
> > > key size >= 8. On my AMD machine xxh3 works better for all keys for small maps,
> > > but degrades for keys of size 12,16,20 for bigger maps (>=200K elements or so).
> > > Example (map size 100K, 50% full, measuring M ops/second):
> >
> > Nice, I was hoping you would look at xxh3, as I've been meaning to try
> > it out as well (have dirty patches to introduce xxh3 into
> > lib/xxhash.c, but didn't get to actual benchmarking).
>
> My first attempt was with lib/xxhash.c, and it looked well on the first glance
> (outperformed every other hash in my hash benchmark). However, when used inside
> the hashmap, it behaved way worse than expected, so I had to inline it.
>
> > Despite this AMD-specific degradation (which is interesting in its own
> > right, could it be some fluke in testing?), I think it's a good idea
> > to switch from jhash to xxh3, as it seems almost universally better.
> > See also below.
> > >
> > >     hash_size    4    8   12   16   20   24   28   32   36   40   44   48   52   56   60   64
> > >     orig_map  15.7 15.4 14.2 13.9 13.1 13.2 12.0 12.0 11.5 11.2 10.6 10.7 10.0 10.0  9.6  9.3
> > >     new_map   15.5 15.9 15.2 15.3 14.3 14.6 14.0 14.2 13.3 13.6 13.1 13.4 12.7 13.1 12.3 12.8
> > >
> > > A smaller map (10K, 50% full):
> > >
> > >     hash_size    4    8   12   16   20   24   28   32   36   40   44   48   52   56   60   64
> > >     orig_map  36.1 36.8 32.1 32.4 29.0 29.1 26.2 26.4 23.9 24.3 21.8 22.5 20.4 20.7 19.3 19.1
> > >     new_map   37.7 39.6 34.0 36.5 31.5 34.1 30.7 32.7 28.1 29.5 27.4 28.8 27.1 28.1 26.4 27.8
> > >
> > > Other hash functions I've tried (older xxh32/64, spooky) work _way_ worse for
> > > small keys than jhash/xxh3. (Answering a possible question about vector instructions:
> > > xxh3 is scalar until key size <= 240, then the xxh64/xxh32 can be used which
> > > also provides ~2x map lookup speed gain comparing to jhash for keys >240.)
> >
> > Yeah, not suprising. xxh32/64 were optimized for long byte arrays, not
> > for short keys. While xxh3 puts a lot of attention on short keys. Do
> > you see xxh64 being faster than xxh3 for longs keys, as implemented in
> > kernel? Kernel doesn't use SSE2/AVX versions, just purely scalars, so
> > from reading benchmarks of xxh3/xxh64 author, xxh3 should win in all
> > situations.
>
> For keys longer than 240 the scalar xxh3 works way worse than xxhash. BTW, do
> you know use cases when hashmap keys are > 240? (For cilium/tetragon the most
> interesting use cases are keys of sizes ~4-40.)

Can't recall such big keys, but if someone was to use bpf_get_stack()
and using stack traces as keys of hashmap, we'd be looking at 1KB+
keys in such case.

When you say "way worse", how much do you think? This is surprising,
given official benchmark results. But then, I don't think official
benchmark has scalar xxh3 on some of the graphs.

>
> > >
> > > Bloom filters for big >= ~40 keys, predictably, work way faster with xxh3 than
> > > with jhash. (Why not similar to hashmap? Because Bloom filters use jhash2 for
> > > keys % 4 which works faster than jhash for small keys, see also a patch below.)
> > >
> > > The stacktrace map doesn't work much faster, because 95% of time it spends in
> > > get_perf_callchain (the hash part, though, runs ~1.5-2.0 faster with xxh, as
> > > hash size is typically about 60-90 bytes, so this makes sense to use xxh3 in
> > > stacktrace by default).
> >
> > For stacktrace very important aspect would be to pay attention (and
> > minimize) hash collisions, though. This was a big problem with
> > bpf_get_stackid() and STACK_TRACE map (and what motivated
> > bpf_get_stack()). Even with a big sparsely populated map we'd get a
> > lot of collisions between stack traces. xxh3 should have much better
> > distribution, so in production it should result in less
> > dropped/replaced stack traces. If you get a chance, it would be nice
> > to collect these stats for jhash and xxh3-based implementations. Note
> > that kernel's jhash2 seems to be what SMHasher ([0]) denotes as
> > lookup3 (as does Jenkins himself). It's not a very good hash anymore
> > in terms of distribution (and throughput as well), compared to xxh3
> > (and lots of other more modern hashes).
> >
> >   [0] https://github.com/rurban/smhasher
>
> Ok, this makes sense. Based on the fact that for stacktrace xxh3 also works
> about twice faster (for stack depths of 10 and more), I see no problem just
> using it as is (corrected by the fact that for key sizes of 240 and more we
> might prefer xxh64; this shouldn't break the stacktrace algorithms if we use
> different hash algorithms, right?).

Yep, it shouldn't, it's implementation detail. But of course it would
be nice to stick to just one hashing algorithm.

>
> > >
> > > One very simple change which brings 5-10% speed gain for all hashmaps is this:
> > >
> > > static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> > >  {
> > > +       if (likely((key_len & 0x3) == 0))
> > > +               return jhash2(key, key_len >> 2, hashrnd);
> > >         return jhash(key, key_len, hashrnd);
> > >  }
> > >
> > > I will follow up with a patch as simple as this ^ or with a combination of
> > > jhash, jhash2, and xxh3 once I will run benchmarks on more architectures to
> > > check that there are no degradations.
> >
> >
> > Sounds good, looking forward to it!
>
> Benchmarks for "the better hash" are running already!

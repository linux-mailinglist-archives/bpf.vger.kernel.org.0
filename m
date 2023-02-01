Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDCB6862FC
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBAJli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 04:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBAJlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 04:41:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B05B584
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 01:41:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr8so28036936ejc.12
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 01:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsfDO9iq8oadUA5QhTJkd+kuVu8NGywjhFuGlrvVDO8=;
        b=kqts+FE5u0rtpecQ//kq9QNTd9XJGhLSpy7ULpwicYkT6TcMTxi7KwwcuHUEMWUeVW
         SFdqVTFUko0LPQLc0pxestgDkvyoo/TtNocNoAzxk6qwiWpVR0j9+c7rm32YsXuI+H48
         ofLZY8w7WHJIu+7FZjXKiUh55bSoNIFlUcfLU9koTCspsaJkSkpXwRZuxDgD/zY06LKf
         VAR7ak6oqJj+N1UXgxThrDEWQ5s2w5kZypywXyieSE2jxNzLiTNWki8igYwanUDwSeIJ
         b9TqS5lkFMH1CinUaqlwXN+IFoXNMcNoA9vy5JZo755iE9t6cymFWq0e+hSNF+ZhPe8E
         zQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsfDO9iq8oadUA5QhTJkd+kuVu8NGywjhFuGlrvVDO8=;
        b=dA/a0bVPx6u9bVs+77dze6Hfh6wAv7HiTaEP3qmzYU+EGSpByVrdcfIthFQTMKaHWP
         qBOORIW8bThOY4UjeJGmcN9Vdw7kuggUFJfgVypkcpT/Lr1Omeh8rJ+c1m+Iq3hxpYkz
         61Yx4ORXOZNFdZzBkkxKYeF/YITuOLO5EQtUYMgcMEs0un1268xwm0rh6qlTxDtukgKx
         K4RLF+UzW/xlO0tBv39Edpo9ZnYF7XpVn761wph0ZHnKyG7eOHu1M9mhKhMtmQRC05HS
         woLSdy3UkzlATmoU86YiLNYdlaAJ1/oEap2Gd2+1G0iEcOjik60LiT9XMz7XT8WM5EuK
         LpJg==
X-Gm-Message-State: AO0yUKVCVEH7GVwfqW8eTWe2SdLLjbjOqW4AsEP2SSjqglinsxPpOYUl
        rFDhIUKPqjCL9dvi2ZNkMtb3+A==
X-Google-Smtp-Source: AK7set+pHCYovDRAUnp2jlVetTXl2+mmBKsLlpK+8kVMBJPU9SlK1RR/r7Dz4WfiOg35H1ATL+oyiQ==
X-Received: by 2002:a17:907:9c04:b0:87b:dc0a:b6a4 with SMTP id ld4-20020a1709079c0400b0087bdc0ab6a4mr5579291ejc.75.1675244494334;
        Wed, 01 Feb 2023 01:41:34 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:309:d5c3:e99a:94ef])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709063e8700b0086d70b9c023sm9844520ejj.63.2023.02.01.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:41:33 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:41:32 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 0/6] New benchmark for hashmap lookups
Message-ID: <Y9ozzAqKhz3Zf7/o@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <CAEf4BzYcMM4hzvD3TSPnK052W2a0Eu2ygm4BixPmMaZioq9TKg@mail.gmail.com>
 <Y9jxwMhL+O3obDzD@lavr>
 <CAEf4BzYxZpc8NZssBkpkT86A3ZFc9i08am9s76o6334HwBGMdA@mail.gmail.com>
 <Y9lpilqPsW1stF/a@lavr>
 <CAEf4BzbJPfvzzwBdapxzs7vPyHjEr_fcntKpOFeuHQbzwyE4Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbJPfvzzwBdapxzs7vPyHjEr_fcntKpOFeuHQbzwyE4Qg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/31 04:02, Andrii Nakryiko wrote:
> On Tue, Jan 31, 2023 at 11:18 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On 23/01/31 10:48, Andrii Nakryiko wrote:
> > > On Tue, Jan 31, 2023 at 2:47 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > On 23/01/30 04:17, Andrii Nakryiko wrote:
> > > > > On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > >
> > > > > > Add a new benchmark for hashmap lookups and fix several typos. See individual
> > > > > > commits for descriptions.
> > > > > >
> > > > > > One thing to mention here is that in commit 3 I've patched bench so that now
> > > > > > command line options can be reused by different benchmarks.
> > > > > >
> > > > > > The benchmark itself is added in the last commit 6. I am using this benchmark
> > > > > > to test map lookup productivity when using a different hash function (see
> > > > > > https://fosdem.org/2023/schedule/event/bpf_hashing/). The results provided by
> > > > > > the benchmark look reasonable and match the results of my different benchmarks
> > > > > > (requiring to patch kernel to get actual statistics on map lookups).
> > > > >
> > > > > Could you share the results with us? Curious which hash functions did
> > > > > you try and which one are the most promising :)
> > > >
> > > > For the longer version with pictures see the talk I've referenced above (it's
> > > > at FOSDEM next Sunday Feb 5). A short version follows.
> > >
> > > Yep, I'll try to watch it.
> > >
> > > >
> > > > The xxh3 hash works fine for big keys, where "big" is different for different
> > > > architectures and for different maps sizes. On my Intel i7 machine this means
> > > > key size >= 8. On my AMD machine xxh3 works better for all keys for small maps,
> > > > but degrades for keys of size 12,16,20 for bigger maps (>=200K elements or so).
> > > > Example (map size 100K, 50% full, measuring M ops/second):
> > >
> > > Nice, I was hoping you would look at xxh3, as I've been meaning to try
> > > it out as well (have dirty patches to introduce xxh3 into
> > > lib/xxhash.c, but didn't get to actual benchmarking).
> >
> > My first attempt was with lib/xxhash.c, and it looked well on the first glance
> > (outperformed every other hash in my hash benchmark). However, when used inside
> > the hashmap, it behaved way worse than expected, so I had to inline it.
> >
> > > Despite this AMD-specific degradation (which is interesting in its own
> > > right, could it be some fluke in testing?), I think it's a good idea
> > > to switch from jhash to xxh3, as it seems almost universally better.
> > > See also below.
> > > >
> > > >     hash_size    4    8   12   16   20   24   28   32   36   40   44   48   52   56   60   64
> > > >     orig_map  15.7 15.4 14.2 13.9 13.1 13.2 12.0 12.0 11.5 11.2 10.6 10.7 10.0 10.0  9.6  9.3
> > > >     new_map   15.5 15.9 15.2 15.3 14.3 14.6 14.0 14.2 13.3 13.6 13.1 13.4 12.7 13.1 12.3 12.8
> > > >
> > > > A smaller map (10K, 50% full):
> > > >
> > > >     hash_size    4    8   12   16   20   24   28   32   36   40   44   48   52   56   60   64
> > > >     orig_map  36.1 36.8 32.1 32.4 29.0 29.1 26.2 26.4 23.9 24.3 21.8 22.5 20.4 20.7 19.3 19.1
> > > >     new_map   37.7 39.6 34.0 36.5 31.5 34.1 30.7 32.7 28.1 29.5 27.4 28.8 27.1 28.1 26.4 27.8
> > > >
> > > > Other hash functions I've tried (older xxh32/64, spooky) work _way_ worse for
> > > > small keys than jhash/xxh3. (Answering a possible question about vector instructions:
> > > > xxh3 is scalar until key size <= 240, then the xxh64/xxh32 can be used which
> > > > also provides ~2x map lookup speed gain comparing to jhash for keys >240.)
> > >
> > > Yeah, not suprising. xxh32/64 were optimized for long byte arrays, not
> > > for short keys. While xxh3 puts a lot of attention on short keys. Do
> > > you see xxh64 being faster than xxh3 for longs keys, as implemented in
> > > kernel? Kernel doesn't use SSE2/AVX versions, just purely scalars, so
> > > from reading benchmarks of xxh3/xxh64 author, xxh3 should win in all
> > > situations.
> >
> > For keys longer than 240 the scalar xxh3 works way worse than xxhash. BTW, do
> > you know use cases when hashmap keys are > 240? (For cilium/tetragon the most
> > interesting use cases are keys of sizes ~4-40.)
> 
> Can't recall such big keys, but if someone was to use bpf_get_stack()
> and using stack traces as keys of hashmap, we'd be looking at 1KB+
> keys in such case.
> 
> When you say "way worse", how much do you think? This is surprising,
> given official benchmark results. But then, I don't think official
> benchmark has scalar xxh3 on some of the graphs.

Here are numbers for xxh3 vs xxh64 (hash_size/cycles):

    hash_size 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 256 272 288 304 320 336 352 368 384 400
    xxh3      17 25 33 33 42 42  47  47  68  73  78  83  88  93  98 184 218 218 218 218 252 252 252 252 286
    xxh64     26 41 49 48 57 55  63  62  71  70  79  77  86  85  93  92 107 101 110 107 117 118 135 125 134

Note how xxh3 numbers jump at hash_size=240. Probably this is because the
scalar xxh3 was never actually benchmarked by the original author? I've asked
them about this case, see https://github.com/Cyan4973/xxHash/issues/793

> > > > Bloom filters for big >= ~40 keys, predictably, work way faster with xxh3 than
> > > > with jhash. (Why not similar to hashmap? Because Bloom filters use jhash2 for
> > > > keys % 4 which works faster than jhash for small keys, see also a patch below.)
> > > >
> > > > The stacktrace map doesn't work much faster, because 95% of time it spends in
> > > > get_perf_callchain (the hash part, though, runs ~1.5-2.0 faster with xxh, as
> > > > hash size is typically about 60-90 bytes, so this makes sense to use xxh3 in
> > > > stacktrace by default).
> > >
> > > For stacktrace very important aspect would be to pay attention (and
> > > minimize) hash collisions, though. This was a big problem with
> > > bpf_get_stackid() and STACK_TRACE map (and what motivated
> > > bpf_get_stack()). Even with a big sparsely populated map we'd get a
> > > lot of collisions between stack traces. xxh3 should have much better
> > > distribution, so in production it should result in less
> > > dropped/replaced stack traces. If you get a chance, it would be nice
> > > to collect these stats for jhash and xxh3-based implementations. Note
> > > that kernel's jhash2 seems to be what SMHasher ([0]) denotes as
> > > lookup3 (as does Jenkins himself). It's not a very good hash anymore
> > > in terms of distribution (and throughput as well), compared to xxh3
> > > (and lots of other more modern hashes).
> > >
> > >   [0] https://github.com/rurban/smhasher
> >
> > Ok, this makes sense. Based on the fact that for stacktrace xxh3 also works
> > about twice faster (for stack depths of 10 and more), I see no problem just
> > using it as is (corrected by the fact that for key sizes of 240 and more we
> > might prefer xxh64; this shouldn't break the stacktrace algorithms if we use
> > different hash algorithms, right?).
> 
> Yep, it shouldn't, it's implementation detail. But of course it would
> be nice to stick to just one hashing algorithm.
> 
> >
> > > >
> > > > One very simple change which brings 5-10% speed gain for all hashmaps is this:
> > > >
> > > > static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> > > >  {
> > > > +       if (likely((key_len & 0x3) == 0))
> > > > +               return jhash2(key, key_len >> 2, hashrnd);
> > > >         return jhash(key, key_len, hashrnd);
> > > >  }
> > > >
> > > > I will follow up with a patch as simple as this ^ or with a combination of
> > > > jhash, jhash2, and xxh3 once I will run benchmarks on more architectures to
> > > > check that there are no degradations.
> > >
> > >
> > > Sounds good, looking forward to it!
> >
> > Benchmarks for "the better hash" are running already!

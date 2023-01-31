Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F32682ACE
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjAaKrl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 05:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjAaKrj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 05:47:39 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9F3D0B3
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 02:47:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qw12so24431341ejc.2
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 02:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0JeLgzBN6c701VP8BQN7qYnoz2TlYjOSEpigz8aPe8=;
        b=0TAh6goLyeBhchHUARGE3wPIkfgWcjuho1UcW8dVpj/GpqqIP+2Xa2/F5OeyUbeju0
         ETCclGNmlInnAofWj7Pfm+xjjBGIhIAQ93T/JhJggZfFu50DbCoLMmUTcHUGuBddAXDd
         SUcm4gFCSgEyyeWuwMfz9DuZnLB1LLwih4KYPUPVJw1kLseoX2KnCfeUPaW7F/+3UdWV
         oax/MscfLpuA+lorwUrG4O6duh0+xXZxa/jzePFzqxra9g4fSEg5RyNS5DFGs2Z8Rwkm
         uJWtXoV8kPdz5od2nigeUvoow5ttEDDgBhLtVll8uYV/FRV9up+v83guVeedkPe7rhma
         M8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0JeLgzBN6c701VP8BQN7qYnoz2TlYjOSEpigz8aPe8=;
        b=CRWMWiQ06M6Jy7SuX2Fw2oWurFGvAvwuTM8v7+F+8YIyoBqgCT/BsUAdBgnPWqGp7F
         CAJS0WvbJfK7HmJhdx1g9E2GZUJWFjomaGy+f9bwTAhLiyy1fTj1LyBAuVcYc5mdytwO
         2HyJSFEzjhmdyTm9UOiAATm1rbzkXe09dT3CCoUleQgUyfCc9iZYhp3rw+QkNFxHcOqr
         E0Rd8bwgM2d0XucFywzOASBOCiq/IQnrzQg2b7dQRFdEiSe9hvvRZ8e7YZaUT2VKnW5U
         Z/M97YwfkqwpRU2rZiV1SB3oEda5FhvNwi4yLIEvjrmicysvw1HNmhVcqxoHom82Xhp4
         xmvg==
X-Gm-Message-State: AO0yUKW21pRDOa3d1caiOvy0IgagszSca31sKkavFHJtr9kmITXMNSlM
        2lyXqgyx0uu5s9ja8ijCJar+yA==
X-Google-Smtp-Source: AK7set91qgw4S2Yxli9NamLoxKhlvkjZAEumxy8nBF6yhp7eZtpiqTxa9A/fJgUwCJzc9lJzDrfhxw==
X-Received: by 2002:a17:906:1290:b0:878:5da4:77a6 with SMTP id k16-20020a170906129000b008785da477a6mr19249610ejb.51.1675162050212;
        Tue, 31 Jan 2023 02:47:30 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:fa3:6e35:7858:23ee])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170906f9c800b007c14ae38a80sm4479756ejb.122.2023.01.31.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:47:29 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:47:28 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 0/6] New benchmark for hashmap lookups
Message-ID: <Y9jxwMhL+O3obDzD@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <CAEf4BzYcMM4hzvD3TSPnK052W2a0Eu2ygm4BixPmMaZioq9TKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYcMM4hzvD3TSPnK052W2a0Eu2ygm4BixPmMaZioq9TKg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/30 04:17, Andrii Nakryiko wrote:
> On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Add a new benchmark for hashmap lookups and fix several typos. See individual
> > commits for descriptions.
> >
> > One thing to mention here is that in commit 3 I've patched bench so that now
> > command line options can be reused by different benchmarks.
> >
> > The benchmark itself is added in the last commit 6. I am using this benchmark
> > to test map lookup productivity when using a different hash function (see
> > https://fosdem.org/2023/schedule/event/bpf_hashing/). The results provided by
> > the benchmark look reasonable and match the results of my different benchmarks
> > (requiring to patch kernel to get actual statistics on map lookups).
> 
> Could you share the results with us? Curious which hash functions did
> you try and which one are the most promising :)

For the longer version with pictures see the talk I've referenced above (it's
at FOSDEM next Sunday Feb 5). A short version follows.

The xxh3 hash works fine for big keys, where "big" is different for different
architectures and for different maps sizes. On my Intel i7 machine this means
key size >= 8. On my AMD machine xxh3 works better for all keys for small maps,
but degrades for keys of size 12,16,20 for bigger maps (>=200K elements or so).
Example (map size 100K, 50% full, measuring M ops/second):

    hash_size    4    8   12   16   20   24   28   32   36   40   44   48   52   56   60   64
    orig_map  15.7 15.4 14.2 13.9 13.1 13.2 12.0 12.0 11.5 11.2 10.6 10.7 10.0 10.0  9.6  9.3
    new_map   15.5 15.9 15.2 15.3 14.3 14.6 14.0 14.2 13.3 13.6 13.1 13.4 12.7 13.1 12.3 12.8

A smaller map (10K, 50% full):

    hash_size    4    8   12   16   20   24   28   32   36   40   44   48   52   56   60   64
    orig_map  36.1 36.8 32.1 32.4 29.0 29.1 26.2 26.4 23.9 24.3 21.8 22.5 20.4 20.7 19.3 19.1
    new_map   37.7 39.6 34.0 36.5 31.5 34.1 30.7 32.7 28.1 29.5 27.4 28.8 27.1 28.1 26.4 27.8

Other hash functions I've tried (older xxh32/64, spooky) work _way_ worse for
small keys than jhash/xxh3. (Answering a possible question about vector instructions:
xxh3 is scalar until key size <= 240, then the xxh64/xxh32 can be used which
also provides ~2x map lookup speed gain comparing to jhash for keys >240.)

Bloom filters for big >= ~40 keys, predictably, work way faster with xxh3 than
with jhash. (Why not similar to hashmap? Because Bloom filters use jhash2 for
keys % 4 which works faster than jhash for small keys, see also a patch below.)

The stacktrace map doesn't work much faster, because 95% of time it spends in
get_perf_callchain (the hash part, though, runs ~1.5-2.0 faster with xxh, as
hash size is typically about 60-90 bytes, so this makes sense to use xxh3 in
stacktrace by default).

One very simple change which brings 5-10% speed gain for all hashmaps is this:

static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
 {
+       if (likely((key_len & 0x3) == 0))
+               return jhash2(key, key_len >> 2, hashrnd);
        return jhash(key, key_len, hashrnd);
 }

I will follow up with a patch as simple as this ^ or with a combination of
jhash, jhash2, and xxh3 once I will run benchmarks on more architectures to
check that there are no degradations.

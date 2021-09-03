Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C640040B
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhICRXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhICRXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Sep 2021 13:23:49 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CDC061575
        for <bpf@vger.kernel.org>; Fri,  3 Sep 2021 10:22:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m11so7630922ioo.6
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RwLXQdPhzFXFIucNqjrapY3RzAMIZB9rty7RnzAMXRg=;
        b=IF4KQq2U5qy2QIhFTZRorUajvKcjlvEn9mAWTCXp9qf2GCgafsBYoH1XC78BQw7wab
         Nijekp6QAzYSxYCeEydYKCy9RhOmCD22vNSGY7oL1GC2lZZxXb3QYR1VFiq3/A8iyQYb
         2Uwmnibgw5lkTe0xsDjk3FpUPOWg89OD0/Nu0CcahQE0W/Fq3j/IeDvn9u3obumR7qtq
         eUNt6EBQRMS3ZZJzq7ShOVETr+JiqV9JJE4W/Q5SIwhC6J8PSFYkGRa4jsg0qleBPBhe
         c+axQ2pLnfU2GjhHKvW5nFX4sMsRk6zcpReLWQexhlY4hm3XONLkjrQUZHtM5OePij0K
         X/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RwLXQdPhzFXFIucNqjrapY3RzAMIZB9rty7RnzAMXRg=;
        b=gbjzdy7kF+Y6APqk+g4hm1cdaqbn/Zp5gYRyMV9FWAShqeYBxt1nh191Hg82b5VYXD
         WxxxD++OIJQ7L0OZjh+AarqvmnRdtYKDMWxjpfuy3rdJJckO4OsKDn3Fp7u7iINzXp/6
         kGGMxn6lI+gBY3W/7VHCZBAOOiLIafffSkU0bqi/flUFmI0G46cXSBNnbug03Vua9ZJ/
         zIcoiDIfTZ+hDE9VyHUnQSf3IniP6WhwC4cUKAhXSfM1uu+xgyVSLQ6t81zSqwNrTyPP
         TWVMVjSCBeN8QRzhzc29LdtOXcNagQAyx16eWmE4cLff0nsV/6p+nRhREvmwfbL6O7Kl
         IHgg==
X-Gm-Message-State: AOAM533gnDLjIlkaQ1Z7x0NjPyx86G1RH84ML9LW9k/MvS+w1rYoMLdQ
        rpRuE0r/xJYHLGVafT0EyHYNiDWio6c=
X-Google-Smtp-Source: ABdhPJx2MFA58Gf51GnqrsyFtv8fFOB4axGcUFzRWwz6XmfQpbs7OriY/wKTY06z0EQ6wa2ZKf/AxQ==
X-Received: by 2002:a05:6638:150c:: with SMTP id b12mr117932jat.110.1630689768680;
        Fri, 03 Sep 2021 10:22:48 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id u15sm32981ilk.53.2021.09.03.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:22:47 -0700 (PDT)
Date:   Fri, 03 Sep 2021 10:22:39 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joanne Koong <joannekoong@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Message-ID: <613259dfb6973_1c226208c1@john-XPS-13-9370.notmuch>
In-Reply-To: <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
 <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
 <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong wrote:
> On 9/1/21 10:11 PM, John Fastabend wrote:
> 
> > Andrii Nakryiko wrote:
> >> On Tue, Aug 31, 2021 at 3:51 PM Joanne Koong <joannekoong@fb.com> wrote:
> >>> Bloom filters are a space-efficient probabilistic data structure
> >>> used to quickly test whether an element exists in a set.
> >>> In a bloom filter, false positives are possible whereas false
> >>> negatives are not.
> >>>
> >>> This patch adds a bloom filter map for bpf programs.
> >>> The bloom filter map supports peek (determining whether an element
> >>> is present in the map) and push (adding an element to the map)
> >>> operations.These operations are exposed to userspace applications
> >>> through the already existing syscalls in the following way:
> >>>
> >>> BPF_MAP_LOOKUP_ELEM -> peek
> >>> BPF_MAP_UPDATE_ELEM -> push
> >>>
> >>> The bloom filter map does not have keys, only values. In light of
> >>> this, the bloom filter map's API matches that of queue stack maps:
> >>> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> >>> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> >>> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> >>> APIs to query or add an element to the bloom filter map. When the
> >>> bloom filter map is created, it must be created with a key_size of 0.
> >>>
> >>> For updates, the user will pass in the element to add to the map
> >>> as the value, wih a NULL key. For lookups, the user will pass in the
> >>> element to query in the map as the value. In the verifier layer, this
> >>> requires us to modify the argument type of a bloom filter's
> >>> BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> >>> the syscall layer, we need to copy over the user value so that in
> >>> bpf_map_peek_elem, we know which specific value to query.
> >>>
> >>> The maximum number of entries in the bloom filter is not enforced; if
> >>> the user wishes to insert more entries into the bloom filter than they
> >>> specified as the max entries size of the bloom filter, that is permitted
> >>> but the performance of their bloom filter will have a higher false
> >>> positive rate.
> >>>
> >>> The number of hashes to use for the bloom filter is configurable from
> >>> userspace. The benchmarks later in this patchset can help compare the
> >>> performances of different number of hashes on different entry
> >>> sizes. In general, using more hashes decreases the speed of a lookup,
> >>> but increases the false positive rate of an element being detected in the
> >>> bloom filter.
> >>>
> >>> Signed-off-by: Joanne Koong <joannekoong@fb.com>

[...]

> >>> +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
> >>> +{
> >>> +       int numa_node = bpf_map_attr_numa_node(attr);
> >>> +       u32 nr_bits, bit_array_bytes, bit_array_mask;
> >>> +       struct bpf_bloom_filter *bloom_filter;
> >>> +
> >>> +       if (!bpf_capable())
> >>> +               return ERR_PTR(-EPERM);
> >>> +
> >>> +       if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
> >>> +           attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
> >>> +           !bpf_map_flags_access_ok(attr->map_flags))
> >>> +               return ERR_PTR(-EINVAL);
> >>> +
> >>> +       /* For the bloom filter, the optimal bit array size that minimizes the
> >>> +        * false positive probability is n * k / ln(2) where n is the number of
> >>> +        * expected entries in the bloom filter and k is the number of hash
> >>> +        * functions. We use 7 / 5 to approximate 1 / ln(2).
> >>> +        *
> >>> +        * We round this up to the nearest power of two to enable more efficient
> >>> +        * hashing using bitmasks. The bitmask will be the bit array size - 1.
> >>> +        *
> >>> +        * If this overflows a u32, the bit array size will have 2^32 (4
> >>> +        * GB) bits.
> > Would it be better to return E2BIG or EINVAL here? Speculating a bit, but if I was
> > a user I might want to know that the number of bits I pushed down is not the actual
> > number?
> 
> I think if we return E2BIG or EINVAL here, this will fail to create the 
> bloom filter map
> if the max_entries exceeds some limit (~3 billion, according to my math) 
> whereas
> automatically setting the bit array size to 2^32 if the max_entries is
> extraordinarily large will still allow the user to create and use a 
> bloom filter (albeit
> one with a higher false positive rate).

It doesn't matter much to me, but I think if a user request 3+billion max entries
its ok to return E2BIG and then they can use a lower limit and know the
false positive rate is going to go up. 

> 
> > Another thought, would it be simpler to let user do this calculation and just let
> > max_elements be number of bits they want? Then we could have examples with the
> > above comment. Just a thought...
> 
> I like Martin's idea of keeping the max_entries meaning consistent 
> across all map types.
> I think that makes the interface clearer for users.

I'm convinced as well, lets keep it consistent. Thanks.

[...]

> >> Also, I wonder if ditching spinlock in favor of atomic bit set
> >> operation would improve performance in typical scenarios. Seems like
> >> set_bit() is an atomic operation, so it should be easy to test. Do you
> >> mind running benchmarks with spinlock and with set_bit()?
> > With the jhash pulled out of lock, I think it might be noticable. Curious
> > to see.
> Awesome, I will test this out and report back!

It looks like the benchmark tests were done with value size of __u64 should
we do larger entry? I guess (you tell me?) if this is used from XDP for
DDOS you would use a flow tuple and with IPv6 this could be
{dstIp, srcIp, sport, dport, proto} with roughly 44B.

> >>> +       for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
> >>> +               hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
> >>> +                       bloom_filter->bit_array_mask;
> >>> +               bitmap_set(bloom_filter->bit_array, hash, 1);
> >>> +       }
> >>> +
> >>> +       spin_unlock_irqrestore(&bloom_filter->spinlock, spinlock_flags);
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >> [...]
> >

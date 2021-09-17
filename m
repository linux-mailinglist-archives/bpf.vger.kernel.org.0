Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3340FE50
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbhIQRDC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhIQRC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 13:02:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380DC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 10:01:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s16so1521036pfk.0
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xpgvaxoIQzFP4B3YYCE8MOwTySnLM1z8uCPoQY3j8do=;
        b=SP26SuNdmxsB8XboFoL9MPbIQmSRvwbNMDDVz3y5bijpe4THkvdFZaKxjGVfrDapJ6
         CqF+ssZtMXrmEbX6LzgxkcCo0M3U6ICNOQt/kSrEnpMppbOK/7DIZx3+N9PdH3hzLhi+
         dijxr0K1/Z/lNVKXP/xUnk2Hy9ju4Eux8FIhKH8g/vYp5douLPK9iSjzlhOZgl14MtzT
         xFJDlVFZg3JORUCRfMYl9tipzcY0ZR5UqPpWOytJW7DBzIQ7wZ8dPm/0JPsqTgf+a5Cl
         gbXVQx5ntOwTZAR8GV6yl7MGJGaqKOvrrLge+HIuuaTS/vcy+w41rIjqw8NOxIth/1JS
         BjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpgvaxoIQzFP4B3YYCE8MOwTySnLM1z8uCPoQY3j8do=;
        b=P+DAEjV7ktN2ajh1nXLuqTZAHSlJNakDnsRJjbcOxFWQ23jVe5XUgGkfmdV4JOUKRg
         sMy59wYPc4nxttP3P3CZl4Jx8Q2wu3Yu/7+8z0QCi2/Yfj30uSlzpAX7q6McXin3rd0F
         d7VT3CLRXgSM2XhEMmaNawxP0IEgWdd569cbJ22IsEJVgM7WdadC3/KVpjyDQVcSKc/r
         /Wjww3yEVWonI/c8W3Vus24dPu0G2CcFUJH4iCUUK9YtmCraA6N0SBuFUB8HXTzQK+Nc
         4dCE0RMReESIWvfdiWggwx5kDrq+HKGHx0+QMSGCtxqqe27z8+p6cDTFaUT7vQD3eGvY
         PoIQ==
X-Gm-Message-State: AOAM532/UBT4d2fCiAif2SaSxyQVq27tsCjY5IR6lfL2W3RPAoI1H+fr
        3b1A7fqSzdvhHkTRSX7kjgE=
X-Google-Smtp-Source: ABdhPJzODHvKjEdoOb7EE85SVPrxXPgnVG4lZ9Cy8X32iPWm7fWSafxnSpJK6KDSq6Qf+w3is1mZkA==
X-Received: by 2002:aa7:825a:0:b0:43e:124e:5c1e with SMTP id e26-20020aa7825a000000b0043e124e5c1emr11564869pfn.76.1631898092760;
        Fri, 17 Sep 2021 10:01:32 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id z17sm6769859pfj.185.2021.09.17.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:01:32 -0700 (PDT)
Date:   Fri, 17 Sep 2021 10:01:30 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
Message-ID: <20210917170130.njmm3dm65ftd76vo@ast-mbp>
References: <20210914040433.3184308-1-joannekoong@fb.com>
 <20210914040433.3184308-2-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914040433.3184308-2-joannekoong@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 09:04:30PM -0700, Joanne Koong wrote:
> +
> +/* For bloom filter maps, the next 4 bits represent how many hashes to use.
> + * The maximum number of hash functions supported is 15. If this is not set,
> + * the default number of hash functions used will be 5.
> + */
> +	BPF_F_BLOOM_FILTER_HASH_BIT_1 = (1U << 13),
> +	BPF_F_BLOOM_FILTER_HASH_BIT_2 = (1U << 14),
> +	BPF_F_BLOOM_FILTER_HASH_BIT_3 = (1U << 15),
> +	BPF_F_BLOOM_FILTER_HASH_BIT_4 = (1U << 16),

The bit selection is unintuitive.
Since key_size has to be zero may be used that instead to indicate the number of hash
functions in the rare case when 5 is not good enough?
Or use inner_map_fd since there is no possibility of having an inner map in bloomfilter.
It could be a union:
    __u32   max_entries;    /* max number of entries in a map */
    __u32   map_flags;      /* BPF_MAP_CREATE related
                             * flags defined above.
                             */
    union {
       __u32  inner_map_fd;   /* fd pointing to the inner map */
       __u32  nr_hash_funcs;  /* or number of hash functions */
    };
    __u32   numa_node;      /* numa node */

> +struct bpf_bloom_filter {
> +	struct bpf_map map;
> +	u32 bit_array_mask;
> +	u32 hash_seed;
> +	/* If the size of the values in the bloom filter is u32 aligned,
> +	 * then it is more performant to use jhash2 as the underlying hash
> +	 * function, else we use jhash. This tracks the number of u32s
> +	 * in an u32-aligned value size. If the value size is not u32 aligned,
> +	 * this will be 0.
> +	 */
> +	u32 aligned_u32_count;

what is the performance difference?
May be we enforce 4-byte sized value for simplicity?

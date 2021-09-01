Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A67A3FD18E
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 04:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbhIAC4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhIAC4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 22:56:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947AC061575
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 19:55:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q3so637815plx.4
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ULXW/0gK0R6oDC30dZJy4yd64k62umYPU/wDu3bAOs=;
        b=FTXRe86yc8jyHf8sEYLujxiiDIbGV/+1hrOTkSTzdO5oWiiy70+L+BS65I7eR5iFET
         REz4D8svyNucmq370SyDqK24paCOqenIoMZQGXJmKhs7t+m8NRNr7e7MdHHqa1BwAx/Z
         OJJtyhS1kZmH2zlE1vb9VW1/bAeoAgt/mOcVwIrfR+k15tZZwW/0rSO0spnaOe2T2pHM
         IA+A1fB1GpVgztdGIXbMvw8s19iatIRyMBiRquCDDlfkcvREAoIGthaetHTOG0IgmlcA
         WwrlOKKM/ixYyGWB8rFmwGutaUStv/145hao+ub9l5KnJx0U6oSQ6rND24zKISreJHuk
         cWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ULXW/0gK0R6oDC30dZJy4yd64k62umYPU/wDu3bAOs=;
        b=JVxHj94OsLRY5X7AcM8GxE9WJgYTjBXSJ5uNTYc1fN7StuC5AwLltG5jDnfmbU5ZwX
         UPdXNTggg0Deg5g+f7F4C3ywQ1RGcCS0qyPQq2SYWseYFqbeDfa83QfO0X2EwxXmeqqX
         E/zc+IWaOpYdL8faK/jlFU8mTNvIK45RqpdzEap1HOMR+MoGffXreqL90eDdvN26enrs
         O0r6SEKpCbq3v3MvmIzeN3LnBb2hI7rSz2lf7ijyzbmIrTtfZ4Y4cg0kiy2KYxWEVv42
         5KzryjU4GxsIOkj+SyrnQPLAPOHF7lS4DzKGY7u2oMy0G0PoY9o2OQ8ale+FKfLFS6vw
         e2pQ==
X-Gm-Message-State: AOAM5329gKVFx5yeUP13zHiSc6tKVE063Suwyi9yO/1SGTCCyUveQlOE
        Gl83m6+VES9jo+DJG59i0O3ljAuZC0Y=
X-Google-Smtp-Source: ABdhPJyUToaBnaAMwMDkSsMVhTZ0b+q2NVJ4y5dOM9Wf/vTWxx4XNbFzBGX0liCTxDIp2NYLEbEzbA==
X-Received: by 2002:a17:902:c401:b0:138:e450:1ec4 with SMTP id k1-20020a170902c40100b00138e4501ec4mr7579959plk.56.1630464910944;
        Tue, 31 Aug 2021 19:55:10 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:121f])
        by smtp.gmail.com with ESMTPSA id k8sm2167604pjg.23.2021.08.31.19.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:55:10 -0700 (PDT)
Date:   Tue, 31 Aug 2021 19:55:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210901025507.3hx4wpx3kmtjipad@ast-mbp.dhcp.thefacebook.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831225005.2762202-2-joannekoong@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 03:50:01PM -0700, Joanne Koong wrote:
> +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
> +{
> +	struct bpf_bloom_filter *bloom_filter =
> +		container_of(map, struct bpf_bloom_filter, map);
> +	u32 i, hash;
> +
> +	for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
> +		hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
> +			bloom_filter->bit_array_mask;
> +		if (!test_bit(hash, bloom_filter->bit_array))
> +			return -ENOENT;
> +	}

I'm curious what bloom filter theory says about n-hashes > 1
concurrent access with updates in terms of false negative?
Two concurrent updates race is protected by spin_lock,
but what about peek and update?
The update might set one bit, but not the other.
That shouldn't trigger false negative lookup, right?

Is bloom filter supported as inner map?
Hash and lru maps are often used as inner maps.
The lookups from them would be pre-filtered by bloom filter
map that would have to be (in some cases) inner map.
I suspect one bloom filter for all inner maps might be
reasonable workaround in some cases too.
The delete is not supported in bloom filter, of course.
Would be good to mention it in the commit log.
Since there is no delete the users would likely need
to replace the whole bloom filter. So map-in-map would
become necessary.
Do you think 'clear-all' operation might be useful for bloom filter?
It feels that if map-in-map is supported then clear-all is probably
not that useful, since atomic replacement and delete of the map
would work better. 'clear-all' will have issues with
lookup, since it cannot be done in parallel.
Would be good to document all these ideas and restrictions.

Could you collect 'perf annotate' data for the above performance
critical loop?
I wonder whether using jhash2 and forcing u32 value size could speed it up.
Probably not, but would be good to check, since restricting value_size
later would be problematic due to backward compatibility.

The recommended nr_hashes=3 was computed with value_size=8, right?
I wonder whether nr_hashes would be different for value_size=16 and =4
which are ipv6/ipv4 addresses and value_size = 40
an approximation of networking n-tuple.

> +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
> +{
> +	int numa_node = bpf_map_attr_numa_node(attr);
> +	u32 nr_bits, bit_array_bytes, bit_array_mask;
> +	struct bpf_bloom_filter *bloom_filter;
> +
> +	if (!bpf_capable())
> +		return ERR_PTR(-EPERM);
> +
> +	if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
> +	    attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||

Would it make sense to default to nr_hashes=3 if zero is passed?
This way the libbpf changes for nr_hashes will become 'optional'.
Most users wouldn't have to specify it explicitly.

Overall looks great!
Performance numbers are impressive.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87C43F34B
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhJ1XIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 19:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhJ1XII (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 19:08:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EFC0613B9
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 16:05:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t11so5496573plq.11
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VS7Q6wKA4GMhZjVA4trp5ldenu4bzQGz7lfDNmkhm2U=;
        b=c4IEkpbX+rYhYq/7jaSYHQUopWbPSNq46NTAJj7SxtDOORclfg7OZVdhrt6IT1Ix21
         3cu1urwKfiouueqzDd+stwwdE//2Amdbk6qmbA93tTT3Lpgjhc1fXwXjxQtk1j2qTtuM
         HsvsT2+7pG0ii0u9x/nni8pWdReKyD855SCi1kRr8J4RrnY+aJdaLF07NS1bHR3ny/ZN
         weEm8L9QO81g0lFtsA+E7jv3XOXj9teX//Vp6S0qU95pEbS0NpjBnt5BBk0aHaQMulRj
         UJxAZkx6g6o/WeGpyaIVYvXj/8SI5bhC0avws++MH32j23LH1GMXgwzYZc9bu5leHE+q
         VVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VS7Q6wKA4GMhZjVA4trp5ldenu4bzQGz7lfDNmkhm2U=;
        b=wsNtJbqvwggb5jRwp/J4gx7tvP0TU6uJ6IRaxayqLOVrVx+k4yV7Lb0l0f3nBmmooG
         k536Far9bJCHjHV0SlCfpe+2bGbtCWStsZxmOYY+k9HicuEn4+BfQ3Alu7BR9QZy1E8G
         9ET2lZdX9MYFdwCCMihNZReJuL12rkpYXY8cVa4+xtsJukbAYzzG00LT3Xz+bPjKo0aN
         zQhRVztTTum2+LbW04b1EkFJZEacxYx+bhDd9F2PXR47Sa6yazi19gzvqXVBObqTEYp4
         f7xdmQFBsWUcHhR1WWz5stYPNdzUtLvG7EU0WqdGEbG0Yvu/gE29jsATXZu98sBlyj4k
         8Q6w==
X-Gm-Message-State: AOAM532P64W1XbdVa/Y8wrWSYAQzjrztRsMVhy1PeRaWhd1PWOx9/QyV
        yMmvd6e4XvijD+t1+sCUmLpxUuz6gL9K6vHT4JQ9caLn
X-Google-Smtp-Source: ABdhPJwjUD060Bb7fh9HU3N0b0BRll3rtUCrdf9E01m33hjqUOM3isMmX+TjO6xlljegMagFDnmsOTvoKUlXAo9NkDA=
X-Received: by 2002:a17:902:8211:b0:13f:afe5:e4fb with SMTP id
 x17-20020a170902821100b0013fafe5e4fbmr6638829pln.20.1635462340536; Thu, 28
 Oct 2021 16:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211028221019.oinkfqhb3keuuzau@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211028221019.oinkfqhb3keuuzau@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 Oct 2021 16:05:29 -0700
Message-ID: <CAADnVQL8jdVfcekJ8Ch7xDJCU5nyXr-q+ZrqXY2enCb6DJPRqg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/5] Implement bloom filter map
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 3:10 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Oct 27, 2021 at 04:44:59PM -0700, Joanne Koong wrote:
> > This patchset adds a new kind of bpf map: the bloom filter map.
> > Bloom filters are a space-efficient probabilistic data structure
> > used to quickly test whether an element exists in a set.
> > For a brief overview about how bloom filters work,
> > https://en.wikipedia.org/wiki/Bloom_filter
> > may be helpful.
> >
> > One example use-case is an application leveraging a bloom filter
> > map to determine whether a computationally expensive hashmap
> > lookup can be avoided. If the element was not found in the bloom
> > filter map, the hashmap lookup can be skipped.
> >
> > This patchset includes benchmarks for testing the performance of
> > the bloom filter for different entry sizes and different number of
> > hash functions used, as well as comparisons for hashmap lookups
> > with vs. without the bloom filter.
> >
> > A high level overview of this patchset is as follows:
> > 1/5 - kernel changes for adding bloom filter map
> > 2/5 - libbpf changes for adding map_extra flags
> > 3/5 - tests for the bloom filter map
> > 4/5 - benchmarks for bloom filter lookup/update throughput and false positive
> > rate
> > 5/5 - benchmarks for how hashmap lookups perform with vs. without the bloom
> > filter
> >
> > v5 -> v6:
> > * in 1/5: remove "inline" from the hash function, add check in syscall to
> > fail out in cases where map_extra is not 0 for non-bloom-filter maps,
> > fix alignment matching issues, move "map_extra flags" comments to inside
> > the bpf_attr struct, add bpf_map_info map_extra changes here, add map_extra
> > assignment in bpf_map_get_info_by_fd, change hash value_size to u32 instead of
> > a u64
> > * in 2/5: remove bpf_map_info map_extra changes, remove TODO comment about
> > extending BTF arrays to cover u64s, cast to unsigned long long for %llx when
> > printing out map_extra flags
> > * in 3/5: use __type(value, ...) instead of __uint(value_size, ...) for values
> > and keys
> > * in 4/5: fix wrong bounds for the index when iterating through random values,
> > update commit message to include update+lookup benchmark results for 8 byte
> > and 64-byte value sizes, remove explicit global bool initializaton to false
> > for hashmap_use_bloom and count_false_hits variables
> Thanks!  Only have minor comments in patch 1.  belated
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thanks for the detailed review and sorry for pushing too soon.
I forced pushed your Ack.

Joanne, pls follow up with fixes for patch 1 asap, so we get it cleaned up
before the merge window.

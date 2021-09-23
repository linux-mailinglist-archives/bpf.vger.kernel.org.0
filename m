Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0E416553
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 20:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbhIWSoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbhIWSoj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 14:44:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32881C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:43:07 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s16so311295ybe.0
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLVB4AglitkNdTvXxlPc4PVf5UljXwmlSEsEX1A02J4=;
        b=KI7Iyurra2hmTFjVIkCJSfQC8V7nEA3nzudvx0ITzQ5vHKUp6HYBS/klPhB6hnKo3g
         jOqndLOy0sPdkngwHcmRG9VJIzIXlhYMkxskbLHRfHqU6OfszjLpD7bPiRcBNSamV8jX
         sWYCP7Vv5LmDZ8Z2SmEWjxG11LhPv9ZBl5RD+27WCj8ln4De+p576z7Z0NXbnrX4FZMo
         Sw+uAKh6lFR8Zb9jMK9zMMgutY+Pdt42QqtesLzghrhkAlMvKlp8JOjVvz9aKfAiNqgC
         BbPDCFixbsRtokSZBZL3mIoA2LlBrDaXGYp+ggrElLkWf+bUVlzGrGHSzDzD+vDpswvd
         DgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLVB4AglitkNdTvXxlPc4PVf5UljXwmlSEsEX1A02J4=;
        b=38SU4nTwbJobnV49kktqOybVeilokiANYNaDLicEUnX40qQHmAVj1TLS6tiPitlnZn
         EPqf7cBRBDxQS1Ilv0aBeoyDiYNPbkRwmhFWxOBrwy6gYBozu7gwtczgTFgIvzdwmiaP
         HAcU/Xp7+BfdjrX78lwbkvu0ArpKvKfj0rqMosavHKsetEms/ItOZwTQJcoNKME8ziOi
         qJfA9NFz5cyvIzGFaQw7jkhAjJSCxksKWiABKq5/gWamXaf2Zr5f5pZxplncjcj8Mg3a
         XNtDEuJDE5Kv9E2/p+sL23sjnkCWSLXBAe06KX2Hdi7BsFLqrC+Nsz9538+eyrrpLl6b
         VUwA==
X-Gm-Message-State: AOAM531hn1gFGWv45BcmxBdAP/q2NhzCdm/oDpFeHo/BlJ1KRcXUEqyT
        10PbUMLalFlfPtRUkPTnG3VR5eX0/9THjvv8DYw0Me1K
X-Google-Smtp-Source: ABdhPJyJB0Rzv2QPyqZUyUkmr5ADNvipzVbZQcy/+gL2UEMqbxDE0IN+0j+9KHLk0ktIwTOm9llwoLEmLqXbYUHyC1Y=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr7319294ybt.433.1632422586295;
 Thu, 23 Sep 2021 11:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com> <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com> <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Sep 2021 11:42:55 -0700
Message-ID: <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 6:28 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Sep 22, 2021 at 04:07:52PM -0700, Andrii Nakryiko wrote:
> > > > Please see my RFC ([0]). I don't think there is much to coordinate. It
> > > > could be purely BPF-side code, or BPF + user-space initialization
> > > > code, depending on the need. It's a simple and beautiful algorithm,
> > > > which BPF is powerful enough to implement customly and easily.
> > > >
> > > >   [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel.org/T/#t
> > > In practice, the bloom filter will be populated only once by the userspace.
> > >
> > > The future update will be done by map-in-map to replace the whole bloom filter.
> > > May be with more max_entries with more nr_hashes.  May be fewer
> > > max_entries with fewer nr_hashes.
> > >
> > > Currently, the continuous running bpf prog using this bloom filter does
> > > not need to worry about any change in the newer bloom filter
> > > configure/setup.
> > >
> > > I wonder how that may look like in the custom bpf bloom filter in the
> > > bench prog for the map-in-map usage.
> >
> > You'd have to use BPF_MAP_TYPE_ARRAY for the map-in-map use case.
> Right, another map is needed.  When the user space generates
> a new bloom filter as inner map, it is likely that it has different
> number of entries, so the map size is different.
>
> The old and new inner array map need to at least have the same value_size,
> so an one element array with different value_size will not work.
>
> The inner array map with BPF_F_INNER_MAP can have different max_entries
> but then there is no inline code lookup generation.  It may not be too
> bad to call it multiple times to lookup a value considering the
> array_map_lookup_elem will still be directly called without retpoline.

All true, of course, due to generic BPF limitations. In practice, I'd
decide what's the maximum size of the bloom filter I'd need and use
that as an inner map definition. If I understand correctly, there is
going to be only one "active" Bloom filter map and it's generally not
that big (few megabytes covers tons of "max_entries"), so I'd just
work with maximum expected size.

If I absolutely needed variable-sized filters, I'd consider doing a
multi-element array as you suggested, but I'd expect lower
performance, as you mentioned.

> The next part is how to learn those "const volatile __u32 bloom_*;"
> values of the new inner map.  I think the max_entires can be obtained
> by map_ptr->max_entries.   Other vars (e.g. hash_cnt and seed) can
> be used as non-const global, allow the update, and a brief moment of
> inconsistence may be fine.

For single-element array with fixed value_size I'd put those in first 8 bytes:

struct my_bloom {
    __u32 msk;
    __u32 seed;
    __u64 data[];
}

For multi-element BPF_MAP_TYPE_ARRAY I'd put a mask and seed into elem[0].

I'd expect that hash_cnt would be just hard-coded, because as I
mentioned before, it determines the probability of false positive,
which is what end-users probably care about the most and set upfront,
at least they should be coming at this from the perspective "1% of
false positives is acceptable" rather than "hmm... 3 hash functions is
probably acceptable", no? But if not, first two elements would be
taken.

>
> It all sounds doable but all these small need-to-pay-attention
> things add up.

Of course, there is always a tension between "make it simple and
provide a dedicated BPF helper/BPF map" and "let users implement it on
their own". I'm saying I'm not convinced that it has to be the former
in this case. Bloom filter is just a glorified bit set, once you have
a hashing helper. I don't think we've added BPF_MAP_TYPE_BITSET yet,
though it probably would be pretty useful in some cases, just like the
Bloom filter. Similarly, we don't have BPF_MAP_TYPE_HASHSET in
addition to BPF_MAP_TYPE_HASHMAP. I've seen many cases where HASHMAP
is used as HASHSET, yet we didn't have a dedicated map for that
either. I'm just curious where we draw the line between what should be
added to the kernel for BPF, if there are reasonable ways to avoid
that.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6E3FE890
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 06:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhIBEll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 00:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIBEll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 00:41:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBCC061575
        for <bpf@vger.kernel.org>; Wed,  1 Sep 2021 21:40:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n24so834597ion.10
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QdFr2RaotOVFD1hqeEJXTb5mp63AuTIyme+DbVBdBeo=;
        b=lBu8YUAKEq2vWRc6iBR3jxA5pJQRmCcsepOaglJyUqtJ2gj0R0tKvQ5vAdmKqeveMi
         xzxCLXwV8EWqlTLl5D7Y5YFXLAmhDvjXlWN4/k7j4hf9a7s2dZ9OpDlwoZ1BpBs70QRY
         7NztwMctznX7MG0DuBD+fYOntSlx21rX1tyWUW5O21qCXUTlJ4lh57lak8saTnKG8FcH
         b1/cR4zZ/JHzty3HwBrAOXQ5jmjENz7paRc9ThBJVUGGlbGGopkELdmWmK4iypPkx4GA
         BoQrfS5PBrdx5uTKIGUm9czKr1Irxyr8QX0jqE8Gz7XummSV8udBsljhWunkfuBh9x4B
         O4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QdFr2RaotOVFD1hqeEJXTb5mp63AuTIyme+DbVBdBeo=;
        b=bsTuBplRcLUp77pycbG0gSdyFWexBBYO+FEHU97BXTk4h47QlqtFUtOEobDqPFy/se
         LChV2PBGeXEZLUynrVbxGkraLSifuTv3mmX96J809447vLDEuyV8ny5+nLOJR0NRpydM
         1Q/05cLI8wVgwHdFMRCJz/+OgYc5YUF4PmqOHwTVrXjJF+MzhGNl1pJpVNx/kketEK7J
         GAvyPJl48WCGra5zK6AVkm192SZMgYv08cbkpI6tPD+oXjY2T/bFUhLVEiNdQHB7ONcA
         gNVBcNZm8z8sBIVnfNrjd4cC0zPTiYyPfT2k2PEPcdG8UkGCWD3eGnwfXMhE/kLgkj+n
         tLkQ==
X-Gm-Message-State: AOAM532D7vYC65UCqEFojCtXkTEZiHS3GUELEI/PfGy1YnoN/iyZoK89
        EYGt/o6tNxQQ1APDvmURE1I=
X-Google-Smtp-Source: ABdhPJwgANBHNgteCWGaQtKC6xnmHx56Qg/YwKWCfKCOkn8jSSga2EpCceV/fcwG5NWVF4nDNfD5OA==
X-Received: by 2002:a05:6638:bcf:: with SMTP id g15mr1210405jad.1.1630557642606;
        Wed, 01 Sep 2021 21:40:42 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id s7sm403512ioe.11.2021.09.01.21.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 21:40:42 -0700 (PDT)
Date:   Wed, 01 Sep 2021 21:40:33 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>
Message-ID: <613055c16831d_439b20825@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzZFExb-EQcmvPV2KCc-ey8k6S-9YziY2e2MEE+NOQ9DAw@mail.gmail.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <61304218227e8_1aed208dd@john-XPS-13-9370.notmuch>
 <CAEf4BzZFExb-EQcmvPV2KCc-ey8k6S-9YziY2e2MEE+NOQ9DAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Wed, Sep 1, 2021 at 8:18 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Joanne Koong wrote:
> > > Bloom filters are a space-efficient probabilistic data structure
> > > used to quickly test whether an element exists in a set.
> > > In a bloom filter, false positives are possible whereas false
> > > negatives are not.
> > >
> > > This patch adds a bloom filter map for bpf programs.
> > > The bloom filter map supports peek (determining whether an element
> > > is present in the map) and push (adding an element to the map)
> > > operations.These operations are exposed to userspace applications
> > > through the already existing syscalls in the following way:
> > >
> > > BPF_MAP_LOOKUP_ELEM -> peek
> > > BPF_MAP_UPDATE_ELEM -> push
> > >
> > > The bloom filter map does not have keys, only values. In light of
> > > this, the bloom filter map's API matches that of queue stack maps:
> > > user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> > > which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> > > and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> > > APIs to query or add an element to the bloom filter map. When the
> > > bloom filter map is created, it must be created with a key_size of 0.
> > >
> > > For updates, the user will pass in the element to add to the map
> > > as the value, wih a NULL key. For lookups, the user will pass in the
> > > element to query in the map as the value. In the verifier layer, this
> > > requires us to modify the argument type of a bloom filter's
> > > BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
> > > the syscall layer, we need to copy over the user value so that in
> > > bpf_map_peek_elem, we know which specific value to query.
> > >
> > > The maximum number of entries in the bloom filter is not enforced; if
> > > the user wishes to insert more entries into the bloom filter than they
> > > specified as the max entries size of the bloom filter, that is permitted
> > > but the performance of their bloom filter will have a higher false
> > > positive rate.
> >
> > hmm I'm wondering if this means the memory footprint can grow without
> > bounds? Typically maps have an upper bound on memory established at
> > alloc time.
> 
> It's a bit unfortunate wording, but no, the amount of used memory is
> fixed. Bloom filter is a probabilistic data structure in which each
> "value" has few designated bits, determined by hash functions on that
> value. The number of bits is fixed, though. If all designated bits are
> set to 1, then we declare "value" to be present in the Bloom filter.

Thanks actually reading the code helped as well. Looks like a v2
will likely happen perhaps a small note here for maxiumum number of
entries in the bloom filter is only used to estimate the number of
bits used.

I guess if a BPF user did want to enforce the max number of entries
a simple BPF counter wouldn't be much for users to add. I usually
add these to maps for debug/statistic reasons anyways.

> If at least one is 0, then we definitely didn't see "value" yet
> (that's what guarantees no false negatives; this also answers Alexei's
> worry about possible false negative due to unsynchronized update and
> lookup, it can't happen by the nature of the data structure design,
> regardless of synchronization). We can, of course, have all such bits
> set to 1 even if the actual value was never "added" into the Bloom
> filter, just by the nature of hash collisions with other elements'
> hash functions (that's where the false positive comes from). It might
> be useful to just leave a link to Wikipedia for description of Bloom
> filter data structure ([0]).
> 
>   [0] https://en.wikipedia.org/wiki/Bloom_filter

Thanks. Yep needed a refresher for sure.

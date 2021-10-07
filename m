Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C5425538
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhJGOWP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhJGOWO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 10:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633616420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFQkbTWYNvDnkeWkafCQ3cJn0Bfvc5WJyurv+wNRTSs=;
        b=H5P5iN2HBDWyZlviHji3OUoB8lhmpMrXOSs+8lzlDw3yaDA72Q/THIUVaZt94/0ZOeu62+
        EEoakmOR1GhTwm4nWOCotOjym61g709NMypF4TQ4/T4c5E78+FHi3XxGwU0JTLAbtQU7yp
        pexGj+vz/ZlsYTkO9m0gT0LZvYQ1yus=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-MVTxTL5NN3GIsGylxJLWNQ-1; Thu, 07 Oct 2021 10:20:19 -0400
X-MC-Unique: MVTxTL5NN3GIsGylxJLWNQ-1
Received: by mail-ed1-f69.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso6044297edv.13
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kFQkbTWYNvDnkeWkafCQ3cJn0Bfvc5WJyurv+wNRTSs=;
        b=vBjNUNCRUbg+Eu+Jg7GaJvItYOz5trLuLIEP+KKG/XaSkA6cpP/aF7jvGb0BBzDN1e
         zjpO8I1GMqKIyv50xcyxo17i+Ookp9yA5NPPKQmnc4BcXuFiP0iYEx/g9DTWufefNimX
         hDNuG1szcc33x1mK+olVYzokIUEdR6JbVC/ja+NPH//fnW8av9Bx8l9gVo8QI9ZKS/3V
         BYOCUr9icvsEer2fb2v2WNVMYQsqdNckfHd+A3jGa8Sv7QH2wfUNuYED1dVL2uJB0LiA
         yWfrmpIvh1E7EBRK4ufZzyOvT7aOAD9P8ydQRukrLu2zYrLQTQ++LcBZPErcl4gVEbm7
         u5Aw==
X-Gm-Message-State: AOAM530Cc3KEoBIED/ZKmG0k29lXDtH/UlJ0U07PGhQA7XMrCKbPoR55
        wU1qwou+u0ZCIQjJwaIxNf49DWOUzxQG1xYwOovhXo4BmyX43iN2CLwMUUP4c5EsRWvxPhS30cP
        EpGlB4Yf2quh7
X-Received: by 2002:a05:6402:26d1:: with SMTP id x17mr4997123edd.367.1633616415899;
        Thu, 07 Oct 2021 07:20:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyrbWcZ4p/hcttCQfXIaLRNBAxBoDkRStFeoZZcVLL5yhFYEvtBmDzMSNy+R/ihzl5dd7qtQ==
X-Received: by 2002:a05:6402:26d1:: with SMTP id x17mr4996886edd.367.1633616413830;
        Thu, 07 Oct 2021 07:20:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g26sm1213597edu.9.2021.10.07.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:20:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B5F31180151; Thu,  7 Oct 2021 16:20:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
In-Reply-To: <20211006222103.3631981-2-joannekoong@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 Oct 2021 16:20:12 +0200
Message-ID: <87k0ioncgz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> This patch adds the kernel-side changes for the implementation of
> a bitset map with bloom filter capabilities.
>
> The bitset map does not have keys, only values since it is a
> non-associative data type. When the bitset map is created, it must
> be created with a key_size of 0, and the max_entries value should be the
> desired size of the bitset, in number of bits.
>
> The bitset map supports peek (determining whether a bit is set in the
> map), push (setting a bit in the map), and pop (clearing a bit in the
> map) operations. These operations are exposed to userspace applications
> through the already existing syscalls in the following way:
>
> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
>
> For updates, the user will pass in a NULL key and the index of the
> bit to set in the bitmap as the value. For lookups, the user will pass
> in the index of the bit to check as the value. If the bit is set, 0
> will be returned, else -ENOENT. For clearing the bit, the user will pass
> in the index of the bit to clear as the value.

This is interesting, and I can see other uses of such a data structure.
However, a couple of questions (talking mostly about the 'raw' bitmap
without the bloom filter enabled):

- How are you envisioning synchronisation to work? The code is using the
  atomic set_bit() operation, but there's no test_and_{set,clear}_bit().
  Any thoughts on how users would do this?

- It would be useful to expose the "find first set (ffs)" operation of
  the bitmap as well. This can be added later, but thinking about the
  API from the start would be good to avoid having to add a whole
  separate helper for this. My immediate thought is to reserve peek(-1)
  for this use - WDYT?

- Any thoughts on inlining the lookups? This should at least be feasible
  for the non-bloom-filter type, but I'm not quite sure if the use of
  map_extra allows the verifier to distinguish between the map types
  (I'm a little fuzzy on how the inlining actually works)? And can
  peek()/push()/pop() be inlined at all?

-Toke


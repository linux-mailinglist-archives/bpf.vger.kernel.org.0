Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC7419960
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhI0Qmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbhI0Qmu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 12:42:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7516C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:41:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so288988pjb.1
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIscqM5XAxs7TVySXcDXRtPJmu1StbI0uzevLGjwYIw=;
        b=B1T6ZLKwqk2q5tUd+9C1X8FaOlFCEC4WeGYPCGP/0k9KWdP+z9UBJuvoToZV5+u0XY
         18siHorVXdOOh8TezLDSTcOvQ+B70BlSuHlI4sdA1DSzXNs85dTvmpVwz67VuP1SbJ4U
         lb5QSQpkC7jzM1WsEwZ2daOAQrjEdzeAYzl66m0J6T+GPkRCaqgaEPC1AGl6kRxatCVb
         OkvpEDsbFvnuVSYeW+SjXdrjanQNoEANZkufnhjAsfAWziDaRGds9I4i0xxAMSwjpE0t
         eS6L3SUlCIvAC2ASS5H3oqqJalIaZZFLRFnXLymSjyzM6WfSyebMqCDZQRXVUGXULSVH
         VJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIscqM5XAxs7TVySXcDXRtPJmu1StbI0uzevLGjwYIw=;
        b=FRWi4u057CpF+jdjDfF8gMDg7gHKJcPZGSSlNMbMgK2CFG+K9DwzaJtfzfbOivdHQG
         I1cyOsHCOjnMBWgbO8wfOXkCThIPx8XoxA+uYRUoEbH4ygwrd/3XH0ZWltnfj6Vn2gFc
         +OH4uKtQZlL0QuZ7L7u6z27mWfbTIlwnaOcBJ2+EARVPX/vBSzWTO7d4B4K0c26JNGU4
         QQw52zU7SWvWKuz7L0P0ADn1M2JgISS4HrTVgX4eQBaDEGTtvEOoKyGv77DXuJPPSk9P
         zxhs1CH9kP7JXytSgaWgESz0oySIgXVfr+0jmhRHLBvVnOnHxDmHwHiLAoiePrP15e55
         Gb+Q==
X-Gm-Message-State: AOAM532u148IhEKeBYr+UmDLf3pbmZMnx93/eKL5VUzN3YaeIeRgIWzY
        VR5nh9X/BuBPHLUF58KSFXg=
X-Google-Smtp-Source: ABdhPJy+ofSOv/2P4YtVJdL670ucsyc6V1c4d0uQABYQSsXElBWamgHj9eJvhYOMPjs55retXRpK5g==
X-Received: by 2002:a17:90a:b117:: with SMTP id z23mr45743pjq.94.1632760872214;
        Mon, 27 Sep 2021 09:41:12 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:6cbb])
        by smtp.gmail.com with ESMTPSA id h6sm17859336pfr.121.2021.09.27.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:41:11 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:41:10 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
References: <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
 <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> 
> That's not what I proposed. So let's say somewhere in the kernel we
> have this variable:
> 
> static int bpf_bloom_exists = 1;
> 
> Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> all its hashed bits are set in Bloom filter (it "exists"), we return
> &bpf_bloom_exists. So it's not a NULL pointer.

imo that's too much of a hack.

> Now, despite returning a valid pointer, it would be good to prevent
> reading/writing from/to it in a valid BPF program. I'm hoping it is as
> easy as just seetting map->value_size = 0 during map creation. But
> worst case, we can let BPF program just overwrite that 1 with whatever
> they want. It doesn't matter because the contract is that
> bpf_map_lookup_elem() returns non-NULL for "exists" and NULL
> otherwise.
> 
> Now, for MAP_LOOKUP_ELEM command on user-space side. I'd say the
> contract should be 0 return code on "exists" (and nothing is written
> to value pointer, perhaps even disallow to specify the non-NULL value
> pointer altogether); -ENOENT, otherwise. Again, worst-case we can
> specify that "value_size" is 1 or 4 bytes and write 1 to it.
> 
> Does it make sense?
> 
> 
> BTW, for STACK/QUEUE maps, I'm not clear why we had to add
> map_peek_elem/map_pop_elem/map_push_elem operations, to be honest.
> They could have been pretty reasonably mapped to map_lookup_elem (peek
> is non-destructive lookup), map_lookup_elem + some flag (pop is
> lookup, but destructive, so flag allows "destruction"), and
> map_update_elem (for push). map_delete_elem would be pop for when
> value can be ignored.
> 
> That's to say that I don't consider STACK/QUEUE maps as good examples,
> it's rather a counter-example of maps that barely anyone is using, yet
> it just adds clutter to BPF internals.

Repurposing lookup/update ops for stack/queue and forcing bpf progs
to pass dummy key would have looked quite ugly.
peek/pop/push have one pointer. That pointer points to value.
For bitset we have single pointer as well.
So it makes perfect sense to reuse push/pop/peek and keep bitset
as a value from the verifier side.
bpf_helper_defs.h could have static inline functions:
bool bpf_bitset_clear(map, key);
bool bpf_bitset_set(map, key);
bool bpf_bitset_test(map, key);

But they will map to FUNC_map_pop_elem/push/peek as func ids
and will be seen as values from the verifier pov.

The bpf progs might think of them as keys, but they will be value_size.
The bitset creation could use key_size as an input, but internally
set it as value_size.
Not sure whether such internal vs uapi remaping will not lead
to confusion and bugs though.
I agree that key as an input to bitset_clear/set/test make more sense,
but the verifier needs value_size to plug into peek/pop infra.

I don't think it's worth to extend ops with yet another 3 callbacks
and have clean ARG_PTR_TO_UNINIT_MAP_KEY there.
That is probably too much clutter.

I think 
bool bpf_bitset_clear(map, value);
bool bpf_bitset_set(map, value);
bool bpf_bitset_test(map, value);
doesn't look too bad either.
At least this way the bit set map_create op will use value_size
and keep it as value_size. The bpf prog won't be confusing.
That's my preference, so far.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A441A3F4
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhI0Xx0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 19:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI0XxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 19:53:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2599DC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 16:51:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 75so2942872pga.3
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fasg5WFOGboXcIrBCiA7xFr5VsZw1/zzlxYKupMsO2E=;
        b=bpXqPJ7vsb0anHbl5LTKeqAo6js4KwS+FgBdYmBb7xXItELX3Nz84JWIklU25ODi56
         5ZiJasn/EDFCAojc+66tE6PW1ypLj7eSuQqOlgcOMMbrBPusiYPP5pubCI73LiB8lV9Y
         8Dcon4sBUKQx7X3LNTyChgn3cSVLhNMHoZ8O21m8O2RF4DDUORfDN+HNQVh4W7U8d4DZ
         /uO0f2B3XhOvz5d8ynTgwPhLo/xivdHhOyWIrCbMLo8w4lPU2XAkvt6Xg+XGgunLcTyc
         /ShR6djvcww3hF87sExBuuiUKwWYc3xGtOJekNah31MT+3puf6qQYunrZgzfTwsN0Q3a
         FEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fasg5WFOGboXcIrBCiA7xFr5VsZw1/zzlxYKupMsO2E=;
        b=AQNyMz3Uac67uYZu6piGZOPNltChheSeEM7Fv98LCxjDwjWcKgU4TaRAgkaPS8ciUX
         884XFsX6U0yfGA86cA2kjZrXZm1kF44BQGzGmrx6CZFOkNvaEu4YwDhW8+H0WB/W+6BP
         PC8r+oHIu+Bvnbzjs1VH5yLosKIbmfgP9UUz4iJ1+QJz3DoZqWwBEFI5VKan7j6LzClx
         PagcpqOeaJBrwZSIZFtPp54R71REopdj2v40+vtPmiHx3HP7JXEj+2CpexCQHLjMfCbv
         7LMuNLp7ISEFkxz5g8ByVxyZxLVM8rPXqrSnv8BOvdXv92I+D1GR6ueNVNAUV3aMouaC
         Nudw==
X-Gm-Message-State: AOAM533ZFRN4MPgEggI99D066lT8euOabKNnWQwSdLeR90g9D1zYwnbS
        cpMpBW14TdIwv5tOE+9q5II=
X-Google-Smtp-Source: ABdhPJxYoYt2qi0AkG9k9Q33ImIVA/uAESUehkK3hqfxI/ARI8NArU/P5pcLDIw3F3nJekbktoBGpg==
X-Received: by 2002:aa7:956a:0:b0:447:96bd:8df5 with SMTP id x10-20020aa7956a000000b0044796bd8df5mr2509047pfq.35.1632786706574;
        Mon, 27 Sep 2021 16:51:46 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:dfdb])
        by smtp.gmail.com with ESMTPSA id j24sm18124007pfh.65.2021.09.27.16.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:51:46 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:51:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
References: <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
 <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 02:14:09PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 27, 2021 at 9:41 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> > >
> > > That's not what I proposed. So let's say somewhere in the kernel we
> > > have this variable:
> > >
> > > static int bpf_bloom_exists = 1;
> > >
> > > Now, for bpf_map_lookup_elem() helper we pass data as key pointer. If
> > > all its hashed bits are set in Bloom filter (it "exists"), we return
> > > &bpf_bloom_exists. So it's not a NULL pointer.
> >
> > imo that's too much of a hack.
> 
> too bad, because this feels pretty natural in BPF code:
> 
> int my_key = 1234;
> 
> if (bpf_map_lookup_elem(&my_bloom_filter, &my_key)) {
>     /* handle "maybe exists" */
> } else {
>     /* handle "definitely doesn't exist" */
> }

I don't think it fits bitset map.
In the bitset the value is zero or one. It always exist.
If bloomfilter is not a special map and instead implemented on top of
generic bitset with a plain loop in a bpf program then
push -> bit_set
pop -> bit_clear
peek -> bit_test
would be a better fit for bitset map.

bpf_map_pop_elem() and peek_elem() don't have 'flags' argument.
In most cases that would be a blocker,
but in this case we can add:
.arg3_type      = ARG_ANYTHING
and ignore it in case of stack/queue.
While bitset could use the flags as an additional seed into the hash.
So to do a bloomfilter the bpf prog would do:
for (i = 0; i < 5; i++)
   if (bpf_map_peek_elem(map, &value, conver_i_to_seed(i)))

Probably would still be an improvement to add:
static inline long bpf_bit_test(void *map, void *value, long flags)
{
    return bpf_map_peek_elem(map, value, flags);
}
to some header file.

Or maybe bloomfilter and the loop can be a flavor of bitset map and
done inside the helper to spare bpf programmers doing the manual loops.
Or such loop could be another static inline function in a header file?

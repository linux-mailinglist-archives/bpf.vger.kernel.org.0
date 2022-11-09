Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD162302C
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 17:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiKIQ35 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 11:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIQ35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 11:29:57 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1771900C
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 08:29:56 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h193so16632062pgc.10
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJaaFYONR4qV+Yyi/+2JVio9Hk3/2pgk/1OCxx7/BW0=;
        b=ot2Evr9NI6TekGRGgEIlzOAGKdME8kDLCwl/tcU17YQRy/69BfhpORDIRMQwRNt7Zi
         cOHdHpaxA3qrCsu8hnKyxj1iZBQ7vSZCHCds+HQkKWYjJYsSPd0o2KtqJFf9EvFdaXDD
         dKs706yK57UjFY1tVMM6QtuSyqZtNhKEm2mTs6LiIAK0YIcwT4f7A/Id64msAVixxx7/
         LFG7xcvJV7CQPzV/2IipNKbmHkNaltCzjhJ38oznV1p/M8ij5tsjhDcneVMA4kCMwYCN
         VBm+jAsavWdkNi/rxhVL9hnC3Co3PbN9n7CkPa0uynZNcT7Ug/CmlxVKvxgFYcTXSzXQ
         4ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJaaFYONR4qV+Yyi/+2JVio9Hk3/2pgk/1OCxx7/BW0=;
        b=NGgnmL+QWKexwSI1pBiK2QF2CEMduu3XenAxjag/icW1Eq0HAx11YwMIovombAoMV5
         93ii15VJ6LhL2cqiTDtscywqgw6xD3dosvCUbLJv505x0V1Iw3/Qkl1p2/N6gX3l0ZIV
         0GT+7NyCaLS117c3jAz0jZWGdtGI8VpD7M4FCRuVhmh9visTv9GURGibJPapcgB5f46X
         4Mbi29dTPSJi+qts8VvGFKyeqxVxVEZLWlkJ9bQ7YB1q1X3sMDoSTUueroTsBN3Cs6Vc
         NU9Pwy+oRzA5oB1RYyw9SDcBxI6GhhZrEps89qNYGapAxKc+ktg1+fuBtUdLpM62ctho
         twhA==
X-Gm-Message-State: ACrzQf128GoJWLtMmD5u08PH2QSKnDHm3xuInflUUbBfXKQuXCmnPQhF
        ZkucJ3edX3+w5KcruMOCHzU=
X-Google-Smtp-Source: AMsMyM7u3WRCoUuxgWvBtUN+jeLu0puFQEkfZ90Q5SRxnZATVEQTKit9pPfzxx3N0TZbcPkJ7XFg5Q==
X-Received: by 2002:aa7:96b6:0:b0:56c:8c22:78f0 with SMTP id g22-20020aa796b6000000b0056c8c2278f0mr60837539pfk.21.1668011394476;
        Wed, 09 Nov 2022 08:29:54 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id cv6-20020a17090afd0600b00213a9e1f863sm1451262pjb.4.2022.11.09.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:29:54 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:59:48 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 15/25] bpf: Teach verifier about non-size
 constant arguments
Message-ID: <20221109162948.wrv44sqmnu3sl5on@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-16-memxor@gmail.com>
 <CAEf4BzaJbT0pN-tDXAgD67q3JyhjmRmyRRKYsiyjk6musyGdSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaJbT0pN-tDXAgD67q3JyhjmRmyRRKYsiyjk6musyGdSQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 05:35:26AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Currently, the verifier has support for various arguments that either
> > describe the size of the memory being passed in to a helper, or describe
> > the size of the memory being returned. When a constant is passed in like
> > this, it is assumed for the purposes of precision tracking that if the
> > value in the already explored safe state is within the value in current
> > state, it would fine to prune the search.
> >
> > While this holds well for size arguments, arguments where each value may
> > denote a distinct meaning and needs to be verified separately needs more
> > work. Search can only be pruned if both are equivalent values. In all
> > other cases, it would be incorrect to treat those two precise registers
> > as equivalent if the new value satisfies the old one (i.e. old <= cur).
> >
> > Hence, make the register precision marker tri-state. There are now three
> > values that reg->precise takes: NOT_PRECISE, PRECISE, EXACT.
> >
> > Both PRECISE and EXACT are 'true' values. EXACT affects how regsafe
> > decides whether both registers are equivalent for the purposes of
> > verifier state equivalence. When it sees that old state register has
> > reg->precise == EXACT, unless both are equivalent, it will return false.
> > Otherwise, for PRECISE case it falls back to the default check that is
> > present now (i.e. thinking that we're talking about sizes).
> >
> > This is required as a future patch introduces a BPF memory allocator
> > interface, where we take the program BTF's type ID as an argument. Each
> > distinct type ID may result in the returned pointer obtaining a
> > different size, hence precision tracking is needed, and pruning cannot
> > just happen when the old value is within the current value. It must only
> > happen when the type ID is equal. The type ID will always correspond to
> > prog->aux->btf hence actual type match is not required.
> >
> > Finally, change mark_chain_precision precision argument to EXACT for
> > kfuncs constant non-size scalar arguments (tagged with __k suffix).
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> I think this needs a bit more thinking, tbh. First, with my recent
> changes we don't even set precision marks in current state, everything
> stays imprecise. And then under CAP_BPF we also aggressively reset
> precision. This might work for EXACT, but needs careful consideration.
>

I'm sorry, I didn't have the time to look at the series, but I spent the whole
day going over it today, and it makes a lot of sense to me. I think I also
misunderstood some things and going through it brought some clarity.

I think resetting precision is fine here too. As you've stated in that series,
the verifier while simulating execution in current state already checks
everything.

> But, taking a step back. I'm trying to understand why this whole EXACT
> mode is necessary. SCALAR has min/max values which regsafe() does
> check. So for those special ___k arguments, if we correctly set
> min/max values to be *exactly* the btf_id passed in, why would
> regsafe()'s logic not work?
>

Yes, when you have tnum_is_const var_off, regsafe will return false (when
reg->precise is true). So EXACT is unnecessary in that case.

I think you're probably right. The range_within will fail for k1 != k2,
but I was more concerned for cases where it's not a constant made a concrete
value later.

rX = ...; [X1, Y1];
if (cond) // unknown
  rX = ...; [X2, Y2];
p:
...

p is a pruning point, so states will be compared there. I spent a fair amount of
time today trying to break this in different ways but failed so far. Also,
thinking about if it still lies within that range, things should still be ok
since it's in the same admissible set of values for the scalar that was later
refined and used as a constant for bpf_obj_new. So it's probably unncessary to
make things more pessimistic. The verifier will ensure the current value is
always a subset of the old value.

I guess I'll hold on for this patch and work towards getting the rest in first
(since Alexei mentioned others are waiting on this), and circle back to this if
I am able to construct a real test case that breaks. bpf_obj_new is already
behind CAP_BPF.

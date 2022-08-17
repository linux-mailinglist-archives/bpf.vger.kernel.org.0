Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0B5977E8
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbiHQUZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 16:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbiHQUZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 16:25:20 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF417A0629;
        Wed, 17 Aug 2022 13:25:18 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id f4so9253743qkl.7;
        Wed, 17 Aug 2022 13:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+MFJJBSD4zsutzL+0OV59YomrO0P4hyIyaiqDayAvmQ=;
        b=CMEnnqrZD9QomIlP2Sapk2r67Z3QZ+QRq61NI0yPCyny0ARGX2o/PIDmBkehVlcn+t
         AtFW8Y7PAo03Xf9Obae1Ggu4SfXEJBXtTyr/xs7TnlYr2dZQnyJuguA8QO8TjgbkqLuc
         Rsg1fYZ5u8bK2AmKt2gJ/QiVbS0SMbg7wPPg/j4Bwni/bDolrscJHJhcUgZGOxA/FbTb
         m6JsFqDPYc8mvvc0r2cT4XDltwlRIEBZxlwqZcoMvtLHLxda4TgnTUWsBsT2a2q7WKJK
         EU3UjpDy4aJLxqUGSOVS0q194PBs8JrPgCpcb95HBoJ9Q1JErE16yhnzeK2xCFLT3rA1
         dkxg==
X-Gm-Message-State: ACgBeo2rR17O1vFal3G5nAqZUF0b1ADridztXl3g7S2q2EtJP+nI9mlj
        0mw1kO/ArQ0e/msCRbyULrk=
X-Google-Smtp-Source: AA6agR4t4P7nvUCA+lM7EGpU954ugvBc/eek69E5yooLN1+SQRvg1GVOufIBH8GxCpStThjjI65u8A==
X-Received: by 2002:a05:620a:40c3:b0:6b9:bfdf:7633 with SMTP id g3-20020a05620a40c300b006b9bfdf7633mr20235018qko.702.1660767917384;
        Wed, 17 Aug 2022 13:25:17 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id 20-20020a370914000000b006b8d1914504sm13607294qkj.22.2022.08.17.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:25:17 -0700 (PDT)
Date:   Wed, 17 Aug 2022 15:24:40 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <Yv1OiCYmQhkvRyWS@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-3-void@manifault.com>
 <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
 <YvWi4f1hz/v72Fpc@maniforge.dhcp.thefacebook.com>
 <CAEf4BzZ6aaFqF0DvhEeKaMfSZiFdMjr3=YzX6oEmz8rCRuSFaA@mail.gmail.com>
 <YvwWvVDN11Wb6j2l@maniforge.DHCP.thefacebook.com>
 <CAEf4BzahEq=Ke7yzc8eMvp17avZ8Br-XQKRMe-WdkgoEcy9oVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzahEq=Ke7yzc8eMvp17avZ8Br-XQKRMe-WdkgoEcy9oVA@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 03:59:54PM -0700, Andrii Nakryiko wrote:

[...]

> > > > > > +       /* Synchronizes with smp_store_release() in
> > > > > > +        * __bpf_user_ringbuf_sample_release().
> > > > > > +        */
> > > > > > +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> > > > > > +       if (cons_pos >= prod_pos) {
> > > > > > +               atomic_set(&rb->busy, 0);
> > > > > > +               return -ENODATA;
> > > > > > +       }
> > > > > > +
> > > > > > +       hdr = (u32 *)((uintptr_t)rb->data + (cons_pos & rb->mask));
> > > > > > +       sample_len = *hdr;
> > > > >
> > > > > do we need smp_load_acquire() here? libbpf's ring_buffer
> > > > > implementation uses load_acquire here
> > > >
> > > > I thought about this when I was first adding the logic, but I can't
> > > > convince myself that it's necessary and wasn't able to figure out why we
> > > > did a load acquire on the len in libbpf. The kernel doesn't do a store
> > > > release on the header, so I'm not sure what the load acquire in libbpf
> > > > actually accomplishes. I could certainly be missing something, but I
> > > > _think_ the important thing is that we have load-acquire / store-release
> > > > pairs for the consumer and producer positions.
> > >
> > > kernel does xchg on len on the kernel side, which is stronger than
> > > smp_store_release (I think it was Paul's suggestion instead of doing
> > > explicit memory barrier, but my memories are hazy for exact reasons).
> >
> > Hmmm, yeah, for the kernel-producer ringbuffer, I believe the explicit
> > memory barrier is unnecessary because:
> >
> > o The smp_store_release() on producer_pos provides ordering w.r.t.
> >   producer_pos, and the write to hdr->len which includes the busy-bit
> >   should therefore be visibile in libbpf, which does an
> >   smp_load_acquire().
> > o The xchg() when the sample is committed provides full barriers before
> >   and after, so the consumer is guaranteed to read the written contents of
> >   the sample IFF it also sees the BPF_RINGBUF_BUSY_BIT as unset.
> >
> > I can't see any scenario in which a barrier would add synchronization not
> > already provided, though this stuff is tricky so I may have missed
> > something.
> >
> > > Right now this might not be necessary, but if we add support for busy
> > > bit in a sample header, it will be closer to what BPF ringbuf is doing
> > > right now, with producer position being a reservation pointer, but
> > > sample itself won't be "readable" until sample header is updated and
> > > its busy bit is unset.
> >
> > Regarding this patch, after thinking about this more I _think_ I do need
> > an xchg() (or equivalent operation with full barrier semantics) in
> > userspace when updating the producer_pos when committing the sample.
> > Which, after applying your suggestion (which I agree with) of supporting
> > BPF_RINGBUF_BUSY_BIT and BPF_RINGBUF_DISCARD_BIT from the get-go, would
> > similarly be an xchg() when setting the header, paired with an
> > smp_load_acquire() when reading the header in the kernel.
> 
> 
> right, I think __atomic_store_n() can be used in libbpf for this with
> seq_cst ordering

__atomic_store_n(__ATOMIC_SEQ_CST) will do the correct thing on x86, but it
is not guaranteed to provide a full acq/rel barrier according to the C
standard. __atomic_store_n(__ATOMIC_SEQ_CST) means "store-release, and also
participates in the sequentially-consistent global ordering".

I believe we actually need an __atomic_store_n(__ATOMIC_ACQ_REL) here. I
don't _think_ __ATOMIC_SEQ_CST is necessary because we're not reliant on
any type of global, SC ordering. We just need to ensure that the sample is
only visible after the busy bit has been removed (or discard bit added) to
the header.

Thanks,
David

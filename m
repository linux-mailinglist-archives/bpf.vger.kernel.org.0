Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEA5BD5FC
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiISVAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiISVAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 17:00:10 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB63AB09;
        Mon, 19 Sep 2022 14:00:08 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id c6so660113qvn.6;
        Mon, 19 Sep 2022 14:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9mdmrFgEg5jnYr/4Ig+o/fAymm12WeUIHo2kO/DiSd0=;
        b=yrHWwfy3RNaJNYUH7X8T1l3Z+6cFgbhz8SZZ9VNwc/9d3SUCAECdpRcMjmkj0RajvP
         QtpDTAJFcoCqeFwr5W7lKiahqM+Kb6RHGh2A0d7pI4ZLzR66drCwae59UNA1LfnMoAPT
         JYx/dMduzxt+zj4O5D+Si7s6GwVsu/5Yt//uQ6k+EV2uuMUoxJm19nzfNrcxjgVsIaWC
         HqpplZb2ggWOSUOuXmaiTV107+3PnHwkWT9blj1d78Z73ST1yFjD0wUY/K9oiW+aPFbe
         uhxX9BSCwL1KAyeH8B1qbdg5ZG8y8JRwNMNe9pOZPNd3Qz+uzFOjJTxysQjy66UCtkBk
         EpyA==
X-Gm-Message-State: ACrzQf0AX9D/TJQ9DyJ/PwRix/o7ETLVM/yXzV8yTz3faPs1cRI613+D
        EWW6siAdEtQ3vYQt0l4AOyA=
X-Google-Smtp-Source: AMsMyM7DGMx5PnIoDTJ28SK1r5efErX/SDEwEhDCz0aR7TT2M/c59tQLI+pDt0hF/4zN2zoJSSdcyA==
X-Received: by 2002:a05:6214:400c:b0:4ac:8066:991d with SMTP id kd12-20020a056214400c00b004ac8066991dmr16039924qvb.112.1663621207446;
        Mon, 19 Sep 2022 14:00:07 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::148f])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a44cf00b006bc56c063fcsm14344790qkp.62.2022.09.19.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 14:00:07 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:00:05 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, bpf@vger.kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/4] bpf: Add libbpf logic for user-space ring buffer
Message-ID: <YyjYVUetY0OL/9sX@maniforge.dhcp.thefacebook.com>
References: <20220902234317.2518808-1-void@manifault.com>
 <20220902234317.2518808-4-void@manifault.com>
 <CAEf4Bzbz_7eVSOY0iGp0YkADx80TgZw8cV6NvSm6V1EF=xKo4A@mail.gmail.com>
 <YyjPcSoBWYtjYIVj@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyjPcSoBWYtjYIVj@maniforge.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 19, 2022 at 03:22:09PM -0500, David Vernet wrote:

[...]

> > > +       timeout_ns = timeout_ms * ns_per_ms;
> > > +       do {
> > > +               __u64 ns_remaining = timeout_ns - ns_elapsed;
> > > +               int cnt, ms_remaining;
> > > +               void *sample;
> > > +               struct timespec curr;
> > > +
> > > +               sample = user_ring_buffer__reserve(rb, size);
> > > +               if (sample)
> > > +                       return sample;
> > > +               else if (errno != ENOSPC)
> > > +                       return NULL;
> > > +
> > > +               ms_remaining = timeout_ms == -1 ? -1 : ns_remaining / ns_per_ms;
> > 
> > ok, so you've special-cased timeout_ms == -1 but still didn't do
> > max(0, ns_remaining). Can you prove that ns_elapsed will never be
> > bigger than timeout_ns due to various delays in waking up this thread?
> > If not, let's please have max(0) otherwise we can accidentally
> > epoll_wait(-1).
> 
> Yes you're right, this was an oversight. Thanks for catching this!

Wait, actually, this can't happen because of the while check at the end of
the loop:

while (ns_elapsed <= timeout_ns)

So I don't think the max is necessary to prevent underflowing, but I do
think we need to have one more attempt to invoke
user_ring_buffer__reserve() at the end of the function to account for
wakeup delays after epoll_wait() returns. Otherwise, we might think we've
timed out when there's actually a sample left in the buffer. I also still
think your suggestion below for cleaning up makes sense, so I'll still add
it in v6, but I think I can leave off the max() call.

> 
> > > +               /* The kernel guarantees at least one event notification
> > > +                * delivery whenever at least one sample is drained from the
> > > +                * ring buffer in an invocation to bpf_ringbuf_drain(). Other
> > > +                * additional events may be delivered at any time, but only one
> > > +                * event is guaranteed per bpf_ringbuf_drain() invocation,
> > > +                * provided that a sample is drained, and the BPF program did
> > > +                * not pass BPF_RB_NO_WAKEUP to bpf_ringbuf_drain().
> > > +                */
> > > +               cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, ms_remaining);
> > > +               if (cnt < 0)
> > > +                       return NULL;
> > > +
> > > +               if (timeout_ms == -1)
> > > +                       continue;
> > > +
> > > +               err = clock_gettime(CLOCK_MONOTONIC, &curr);
> > > +               if (err)
> > > +                       return NULL;
> > > +
> > > +               ns_elapsed = ns_elapsed_timespec(&start, &curr);
> > 
> > nit: if you move re-calculation of ms_remaining and ns_remaining to
> > here, I think overall loop logic will be even more straightforwad. You
> > can initialize ms_remaining to -1 if timeout_ms < 0 and never
> > recalculate it, right? Note that you can also do ns_elapsed conversion
> > to ms right here and then keep everything else in ms (so no need for
> > timeout_ns, ns_remaining, etc).
> 
> Sounds good, let me give this a shot in v6.
> 
> Thanks for another detailed review!

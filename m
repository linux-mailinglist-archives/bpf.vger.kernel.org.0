Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB91D3F5E
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgENUxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727933AbgENUxv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:53:51 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF10DC061A0E
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:53:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q11so293508qvu.13
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xU4aCpS3GZnR2z32uJVCrxDvy71x8cy2ajCrm8qcvx8=;
        b=vebsu+095LbyvY60U9pg9ZVQnlSruP+qNyGvsCu5UqWyFsTA8VQAFHA2yY5NnmQJ4u
         FoVYDuurYCRgbtq6tIwko2xsCUGNFuMqXEaJJgyw4od2VVE/b+R9+irclai1MIa/gQJu
         AYuUXVeuW6cICNe1OA1zQwtnuDxe+R6ZMFENAiU9vy6AJH50dw+f4Dw6Fo2wqhxnf6Jc
         ppBwA7der5WO5yFyNWgFpTZWIissHXZejZ/Hotl/+42ngRL1bMC95qp4k4c8BOpCGv5v
         L0+RvQQm41eiwLE6ceXEM2eYDQSZV876dnrF//pb3Aw4/gIRuvcayFIhm6mR4Z3p+zPH
         PfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xU4aCpS3GZnR2z32uJVCrxDvy71x8cy2ajCrm8qcvx8=;
        b=JCZIeknE3AShvA+vwoiCRf+VPkp+jV/6erp+q0Sg64ZZrdpWaQcJnYtQ9P41iTNZZc
         hVFkqG+KIREKN+1gus8c69XzbOEYIs6UZMDxD2DJKvrMSKIQCXYGUvbT8mldnWRhU6LQ
         1mmmJrgLl4CoOVUoQUU6Z/pxWe9YOp8nPCayDuQhIVlkkQsDEsAN0vxGox+1O7cTfUcq
         f9dtkzAqXzKQMrBcmVPc4W5jTUUwrEKY6431YKIBGMLfyaatAp/YoPeuMDop8kVrgupq
         K+6EVwmmMYWx3NqWhql91lds21ddu4oNXrTHwrxTyQ/y8p3wDTraSughCYVzasGHOmhx
         xygA==
X-Gm-Message-State: AOAM532latSbA13yMvF8SKPRxuy5veRZX4v7obHHa01+enqe6NT1xXhj
        jYQ8KegH09j8rmjcLRXiUKG1hfI=
X-Google-Smtp-Source: ABdhPJz9vi5wHx1MoRpII+EDoameBfyfYlz0HSVgLElCj1s7QUHHG91coLC/zUe5lNTuUExzTa3YC5M=
X-Received: by 2002:ad4:5843:: with SMTP id de3mr325600qvb.195.1589489629811;
 Thu, 14 May 2020 13:53:49 -0700 (PDT)
Date:   Thu, 14 May 2020 13:53:48 -0700
In-Reply-To: <CAEf4BzbhqQB61JTmmp5999bbEFeHEMdvnE9vpV3tHCHm12cf-Q@mail.gmail.com>
Message-Id: <20200514205348.GB161830@google.com>
Mime-Version: 1.0
References: <20200513192532.4058934-1-andriin@fb.com> <20200513192532.4058934-2-andriin@fb.com>
 <20200514173338.GA161830@google.com> <CAEf4BzbhqQB61JTmmp5999bbEFeHEMdvnE9vpV3tHCHm12cf-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: implement BPF ring buffer and verifier
 support for it
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/14, Andrii Nakryiko wrote:
> On Thu, May 14, 2020 at 10:33 AM <sdf@google.com> wrote:
> >
> > On 05/13, Andrii Nakryiko wrote:

[...]

> > > + * void bpf_ringbuf_submit(void *data)
> > > + *   Description
> > > + *           Submit reserved ring buffer sample, pointed to by  
> *data*.
> > > + *   Return
> > > + *           Nothing.
> > Even though you mention self-pacing properties, would it still
> > make sense to add some argument to bpf_ringbuf_submit/bpf_ringbuf_output
> > to indicate whether to wake up userspace or not? Maybe something like
> > a threshold of number of outstanding events in the ringbuf after which
> > we do the wakeup? The default 0/1 preserve the existing behavior.
> >
> > The example I can give is a control plane userspace thread that
> > once a second aggregates the events, it doesn't care about millisecond
> > resolution. With the current scheme, I suppose, if BPF generates events
> > every 1ms, the userspace will be woken up 1000 times (if it can keep
> > up). Most of the time, we don't really care and some buffering
> > properties are desired.

> perf buffer has setting like this, and believe me, it's so confusing
> and dangerous, that I wouldn't want this to be exposed. Even though I
> was aware of this behavior, I still had to debug and work-around this
> lack on wakeup few times, it's really-really confusing feature.

> In your case, though, why wouldn't user-space poll data just once a
> second, if it's not interested in getting data as fast as possible?
If I poll once per second I might lose the events if, for some reason,
there is a spike. I really want to have something like: "wakeup
userspace if the ringbuffer fill is over some threshold or
the last wakeup was too long ago". We currently do this via a percpu
cache map. IIRC, you've shared on lsfmmbpf that you do something like
that as well.

So I was thinking how I can use new ringbuff to remove the unneeded
copies and help with the reordering, but I'm a bit concerned about
regressing on the number of wakeups.

Maybe having a flag like RINGBUF_NO_WAKEUP in bpf_ringbuf_submit()
will suffice? And if there is a helper or some way to obtain a
number of unconsumed items, I can implement my own flushing policy.

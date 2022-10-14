Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096BE5FE6EE
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 04:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJNCXj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJNCXi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 22:23:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5120EA692
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 19:23:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g7so347900lfv.5
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 19:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFfOpSWS847QVBaXLXU4wZtLPG1/YCVXplrcnhMSTZM=;
        b=bnNJX4WcPoBm+L0V+1wHg8yL78MnnpOG4204Hh6oEtfR2GaVVgMRsxLdKzW1giXBrq
         96kpI4HTWR+t12LRfhWo99s3YYxxHDf+/KrQ/oE7pFFhHT+ab4+AIvGzo2UnAZr97Fo+
         /Ru9f01eZnfZoyCqIdqujv+NUGWuHHPuKxxZDkftcGC+ucaQoC3ALMv8A6d5NNRAWkTq
         q6nPHGdpG+cBEBOutNGu4kqeiEd9LVP8H18Du6OJqAgF2GdLsl+o/SG2ehlUSxzj/qg4
         DertlZ1TLvemOWbKcN5IOk53e5PrMhHLmjGl6h9l62tJ1W+caj/sZ2B2D3oDxIe0N+BV
         CBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFfOpSWS847QVBaXLXU4wZtLPG1/YCVXplrcnhMSTZM=;
        b=lYGYo/vgYpNpmwlmFkd9w5XtfimS5Raj8WMCGUhhlQEjDwDFbgcPbA2TkqP+lsUEBE
         j/YTDHCUhM0PLBcTrSJU6KKRUBGIGCttfXikFuholtz0qoFREN5v6C6Ci11YFJ0s4eUH
         24XiLoGyJgfnTdbw1jet6xCnzACXWF/QvgrDPvaIjQib3K3l1cMjRXTK5KeQbRGqmTsH
         N8P9Dj7SuNl9Acv+t3z5Ym0sOdsmG4uDlhKSe2nfUiaI1nthZtBhfgP+z2wpZ+Lx+b/0
         5qxEKNqumES4wDqTxey/rZ8+d8yez7jIwMKFnRdCOE5pDH4snMCpwTusijytd/jFn7K8
         TnLw==
X-Gm-Message-State: ACrzQf3vxyTiLhijseZFvVUTfwnFBAlD5C8ZljfkWpJyO8ZQP3HRZ22J
        C7shRmx82fFiMskuYDYFFt2KupnKb4xnmccYM+3B
X-Google-Smtp-Source: AMsMyM5pQ2UcG46b5QoGPiDrmejL8uxLXHOxg+jGUrE9UmvQnWM3dGRJHSoKFmPsf2hHXB1b8mTjdLiFpAvQWAkayps=
X-Received: by 2002:a19:7704:0:b0:4a4:5d9d:2f66 with SMTP id
 s4-20020a197704000000b004a45d9d2f66mr962453lfc.515.1665714215803; Thu, 13 Oct
 2022 19:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
 <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
 <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com>
 <CAJD7tkYUoW3YU-R1wNBADdUDHVprq6CP3axD9md3gJzW=yhiFw@mail.gmail.com> <CANDhNCpHGvw2MxexRFwpx4nAmqgwXw3G3DqkD2s0W3RNXZw2Bg@mail.gmail.com>
In-Reply-To: <CANDhNCpHGvw2MxexRFwpx4nAmqgwXw3G3DqkD2s0W3RNXZw2Bg@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 13 Oct 2022 19:23:24 -0700
Message-ID: <CANDhNCrhTzmvjy9Q75M_XoTtQaBhTwF5wzPeW2d8yp-m9Erfqw@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 7:15 PM John Stultz <jstultz@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 6:29 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Thu, Oct 13, 2022 at 5:03 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Wed, Oct 12, 2022 at 8:07 PM John Stultz <jstultz@google.com> wrote:
> > > >
> > > > On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> > > > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > So I think it reasonable to say its bounded by approximately  2 *
> > > > > NSEC_PER_SEC/HZ +/- 11%.
> > > >
> > > > Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11
> > >
> > > Thanks so much for the detailed response :)
> > >
> > > IIUC this error bound is in ns. So on a 2 GHz cpu the bound is 0.11 ns
> > > (essentially 0)? I feel like I miscalculated, this error bound is too
> > > good to be true.
> >
> > Never mind, I thought HZ is the cpu speed for some reason. It's the
> > number of jiffies per second, right?
>
> Correct.
>
> > So if HZ is 1000, the error bound is actually ~2 ms, which is very
> > large considering that the unit is ns.
>
> Uh, for HZ=1000, I think it's closer to 220us, but yes, for HZ=100 2.2ms.

And again, it has been awhile since I've been deep in this code, so
I'd not be surprised if I'm missing something and the worst case may
be larger (things like SMIs or virtualization stalling the timekeeping
update for longer than a tick).  So no promises, but this feels pretty
close to the expected bound. If you can't handle time inconsistencies,
you need to use the normal locked accessors.

thanks
-john

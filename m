Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21455FE782
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 05:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJNDSM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 23:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJNDRn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 23:17:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9381929BC
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 20:17:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t4so2339151wmj.5
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X63dy3MTX5BmUci/YGKv91qnJNpqqJepE017hos/Ffs=;
        b=nCok2aMXgD/l2I+rAs/Ddbz1kLYqjM3MODDBVedIwAOC1GfDV0lWoiWo1a4kD1qnQB
         05Zx10bzh+ZTDgpI7hdQ0z4HvepsZV7MUMxCjaOgtgyN2Qt8m3A3hW+LkUnhIswEGSLU
         2G+zRKXVFwcZyfJuwjK4PvIO5O7rBvsvxYEOxCgIacoZJCxbEhDOroybgZPaDp/WR/k9
         O9YtmfulftHYBNQwLunzqVjsaEpoil8H7IRpJrTg4j2yrWSXNN7sOUJ6K+g1NKSlwlTR
         igPbLMLwmJ5sLghDhTMY4cv8ZFNU139jfLUlxnZTOhdppoPB940BZEg4qeQuXBTvLcgM
         aRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X63dy3MTX5BmUci/YGKv91qnJNpqqJepE017hos/Ffs=;
        b=Z6zcGEPNRwqp6j5NMp8FBVfFKEo1BxGjO2MA37fqDTnJRjG5ipBZtNxOQkygUbkRuQ
         Vjq8nki0ppSD0fxPdEFtvQuYhKjGJbI7obn5zBuz2IVEPyHOBIfpTFn2fJuq2hn1XhLP
         QxI6qpBSIBzZCeD8YI27aXVhKikyZcrgcz97pIv5fD5KTk4JKBrna6ljpc1Wyn0UouUx
         0R0nkmcTahgCOCV/y0/tecJp7TpwSthqQ48iinjomjtQOSptSgJdhgxARiC6VoT714fH
         DaM4g3QNkif2aPYQGQtz4N+kwaY8Y6OKjUhwhWvyrpFiczCfh8+Z09pu3cdN1XsL7r57
         t7/g==
X-Gm-Message-State: ACrzQf0ZstOo17zt5tP7LzMFhBkhJmCRaPrkgl0UckBBRGlLkulga5V7
        rUWLKl78M7Xgzxuz80ng1XMXLjE+f8urCegNroNiug==
X-Google-Smtp-Source: AMsMyM7iVOp+OllRzIv2aTOuMOcKMaXhCYCa3Rev+lssqMW6io+6j+nhJnPO2lQO77LHckFS2Yee8kUuq5xup8oqSts=
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id
 l17-20020a1ced11000000b003b4d3e10becmr1813649wmh.196.1665717419528; Thu, 13
 Oct 2022 20:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
 <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
 <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com>
 <CAJD7tkYUoW3YU-R1wNBADdUDHVprq6CP3axD9md3gJzW=yhiFw@mail.gmail.com>
 <CANDhNCpHGvw2MxexRFwpx4nAmqgwXw3G3DqkD2s0W3RNXZw2Bg@mail.gmail.com> <CANDhNCrhTzmvjy9Q75M_XoTtQaBhTwF5wzPeW2d8yp-m9Erfqw@mail.gmail.com>
In-Reply-To: <CANDhNCrhTzmvjy9Q75M_XoTtQaBhTwF5wzPeW2d8yp-m9Erfqw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 20:16:23 -0700
Message-ID: <CAJD7tkZZ9FeXd1=OYe2MJigsYzk-KH_VmTEbd3mo+wN0MqThug@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 7:23 PM John Stultz <jstultz@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 7:15 PM John Stultz <jstultz@google.com> wrote:
> >
> > On Thu, Oct 13, 2022 at 6:29 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Thu, Oct 13, 2022 at 5:03 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Wed, Oct 12, 2022 at 8:07 PM John Stultz <jstultz@google.com> wrote:
> > > > >
> > > > > On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> > > > > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > > So I think it reasonable to say its bounded by approximately  2 *
> > > > > > NSEC_PER_SEC/HZ +/- 11%.
> > > > >
> > > > > Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11
> > > >
> > > > Thanks so much for the detailed response :)
> > > >
> > > > IIUC this error bound is in ns. So on a 2 GHz cpu the bound is 0.11 ns
> > > > (essentially 0)? I feel like I miscalculated, this error bound is too
> > > > good to be true.
> > >
> > > Never mind, I thought HZ is the cpu speed for some reason. It's the
> > > number of jiffies per second, right?
> >
> > Correct.
> >
> > > So if HZ is 1000, the error bound is actually ~2 ms, which is very
> > > large considering that the unit is ns.
> >
> > Uh, for HZ=1000, I think it's closer to 220us, but yes, for HZ=100 2.2ms.
>
> And again, it has been awhile since I've been deep in this code, so
> I'd not be surprised if I'm missing something and the worst case may
> be larger (things like SMIs or virtualization stalling the timekeeping
> update for longer than a tick).  So no promises, but this feels pretty
> close to the expected bound. If you can't handle time inconsistencies,
> you need to use the normal locked accessors.
>

Thanks a lot for the clarification. The inconsistencies may be too
large, depending on what we are trying to measure, so it is something
that we need to keep in mind.

> thanks
> -john

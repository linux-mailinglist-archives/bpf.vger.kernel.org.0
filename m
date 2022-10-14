Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF75FE7A8
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 05:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJNDmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 23:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJNDmX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 23:42:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFE3192984
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 20:42:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b1so5355484lfs.7
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 20:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmPMkVM44twsLVEmNZjFiaFjx4RV7WYTWD8miefDPDQ=;
        b=XdVbeJmrs230F/8iCuMdwdr/MYxBtYCbmPtjX+6nLbqZ1J7bkfHB8E1tJun8FlOHna
         SmcZqGjVWaMvcMIAMBMlOhjEKq/csOtInPujFCFmjWnHdt36r5jACnBs+VjzXQ+hhg4F
         OTcJ0czJpbQvjxTL7BSeEaS5dfRMYX01EQi6wqvyQ7FU4zONcunYZuKx4f09zuyQEleV
         zXk6gF0IdrxNrpgfjfUtNCwOQbf70wzcdAwUBL2wYe7Gs8jFSF2RP1iKH+lvIS7WplRA
         mriZHieMCvJJPSWWrgSy04lqLiesEjKavijbj6Se5ooUSIAM5/+GlOk5saj6V3twMnVg
         uA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmPMkVM44twsLVEmNZjFiaFjx4RV7WYTWD8miefDPDQ=;
        b=zI2jxK9TYZc68/jLxjuV01AOf1ZfMgOShZP8uPR/MR+WkXH1f/8LKWA7wGNRfm+cU5
         pNcSvTPHryGVMbUhvP6JCzK8P1C8+s54ogdiIkfMvdWVHysWz03hJI2GKTwo4BLz9865
         11m3G3HuR+rsk/AQmguXYnLLi2/kCi4apXx+gD37yel5T32xuAhTtR/0FeTDs81NSeeN
         abD3sTDSEUGaroMuGxvXKebm6+ljJ9yxSzdb0PDVIUjmcxlZYmS3gBqQ3Ya6mlveXBJ1
         avppYbdtRiACP/EEXMkh3xKqg14FeAoWBwCjgwUbMg7NjK3zkxvt2jkgmtK0wtS+SzcE
         2AXw==
X-Gm-Message-State: ACrzQf2qoD79/9fmdCFKK85c168JXtafdV/41kKvErhHXXBy9Q1r0J2s
        ibtgCeloY6ZC7JMDrBJGzqbn8doYb4/ATaDRNLGZ
X-Google-Smtp-Source: AMsMyM4KFA5s9CQCJPslF766X4af/KSDF9/TU0jDSjt+3vhx2qOwKvkAKr0dNZP0voc4sGme2yRrUbLMINQ91bSywtU=
X-Received: by 2002:ac2:5110:0:b0:4a2:3cf4:b693 with SMTP id
 q16-20020ac25110000000b004a23cf4b693mr906164lfb.283.1665718939915; Thu, 13
 Oct 2022 20:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com> <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
In-Reply-To: <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 13 Oct 2022 20:42:07 -0700
Message-ID: <CANDhNCp6MOfWnHZKkd_pQbkJqJqPmArVK0JQKKzH4=GbyBVeSQ@mail.gmail.com>
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

On Thu, Oct 13, 2022 at 8:26 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> On Thu, Oct 13, 2022 at 7:39 PM John Stultz <jstultz@google.com> wrote:
> > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > I have a question about ktime_get_mono_fast_ns(), which is used by the
> > > BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> > > this function specifies that there are cases where the observed clock
> > > would not be monotonic.
> > >
> > > I had 2 beginner questions:
> >
> > Thinking about this a bit more, I have my own "beginner question": Why
> > does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
> > accessor instead of ktime_get_ns()?
> >
> > I don't know enough about the contexts that bpf logic can run, so it's
> > not clear to me and it's not obviously commented either.
>
> I am not the best person to answer this question (the BPF list is
> CC'd, it's full of more knowledgeable people).
>
> My understanding is that because BPF programs can basically be run in
> any context (because they can attach to almost all functions /
> tracepoints in the kernel), the time accessor needs to be safe in all
> contexts.

Ah. Ok, the tracepoint connection is indeed likely the case. Thanks
for clarifying.

> Now that I know that ktime_get_mono_fast_ns() can drift significantly,
> I am wondering why we don't just read sched_clock(). Can the
> difference between sched_clock() on different cpus be even higher than
> the potential drift from ktime_get_mono_fast_ns()?

sched_clock is also lock free and so I think it's possible to have
inconsistencies.

ktime_get_raw_fast_ns() is possibly closer to what you are looking
for, as it is similarly un-adjusted by NTP.
However that also means the time intervals it measures (especially
long ones) may not be accurate.

Also I worry that if it's already established as a CLOCK_MONOTONIC
interface, switching it to MONOTONIC_RAW might break some applications
that mix collected timestamps with CLOCK_MONOTONIC.

thanks
-john

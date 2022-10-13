Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF25FD368
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 05:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJMDCY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 23:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJMDCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 23:02:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A611326B6
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 20:02:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m19so520366lfq.9
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzWBQgSdxcEtl1H2Nkqa4ju8p59AJdEo00LZPrM6Tb4=;
        b=XdJwOXAJC3sMMgyMnIuR8MXZzYjvaSU1+3Eddpyj7i4ad0O6n5haGDL6oFpzGKOiGT
         5ZcZo/IVjZHodOmbXrnfruiEbnWcXoeu8saTKi952/AsZUlw3G9WTEyVoKVEiQgm3Lho
         gVi85FE8AgBOEv91SanHwxQCKc+vcuYXlviNNYrMlsPjpMzLHSIHE0+qkASBtO/ncjAX
         b6xe+x2YwJvGjAYl4dqG3dFVxbOlpO7MzVyO3yWvrXCZJ1Sx+E8WRXtEZIE2+o6Ka+cM
         aPY4ja3yFliCxQC1CcRhZv1m1IP9s+zNuyx+pvYKezlayvALRW9GaXCe2UK9ZQo6tRWb
         sp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzWBQgSdxcEtl1H2Nkqa4ju8p59AJdEo00LZPrM6Tb4=;
        b=cww3X61mSoFbBDdQkj5QJXZg/uztaq1+hr63DUWYUSY6EbYdVaIdVz+8hv9MJp6w40
         27ntPVgOx7ARpuyA7pQq9C349f0M8yn6g4JescERYunHfZ2Xqg0MLmexL7DeijETEbkb
         4GcZll8VfKYHGHibfJjJNFxt5cR6ZzTJ9DMZTnn5hU0S0+IzNSOC79vuWXD+v3vVd//U
         TRY1ZHEBQeHh7GpsrNwUbqK7ZFn7kcJD5SKNAloHnDhDUQZgEQo4DZ3ZzWE/5dnSAnCX
         YYi/8TRulxTz7Pjp8N0fGgEEKh/5anw9jwPqGuHD+jqifjIopIl+K/AdK+dUN/N0l93T
         jn0A==
X-Gm-Message-State: ACrzQf38BcQ+pU2EtjzB2zEYZ2xb279Qj/WYt7+98i4cdSjqY7DwlHFo
        GA/HlpQrMMzD3d7fIPsHVEyaaaHYp4j+CnoIyyGm
X-Google-Smtp-Source: AMsMyM5NLnWv7HM9iRTINCcxaiashvksrjXoFrcUuGgJf8Szpzb/WL4lqmqoRdpzf7rS6YNE0cNAFMWHIsC26WFP8EM=
X-Received: by 2002:a05:6512:110f:b0:4a2:697f:c39a with SMTP id
 l15-20020a056512110f00b004a2697fc39amr10687652lfg.685.1665630140035; Wed, 12
 Oct 2022 20:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
In-Reply-To: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 12 Oct 2022 20:02:07 -0700
Message-ID: <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     tglx@linutronix.de, sboyd@kernel.org,
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

On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Hey everyone,
>
> I have a question about ktime_get_mono_fast_ns(), which is used by the
> BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> this function specifies that there are cases where the observed clock
> would not be monotonic.

Sorry for the slow response.

> I had 2 beginner questions:
>
> 1) Is there a (rough) bound as to how much the clock can go backwards?
> My understanding is that it is bounded by (slope update * delta), but
> I don't know what's the bound of either of those (if any).

So, it's been awhile since I was deep in this code, and I'd not call
these beginner questions :)
But from my memory your understanding is right.

If I recall, the standard adjustment limit from NTP is usually +/-
512ppm but additional adjustments (~10% via the tick adjustment) can
be made.  There isn't a hard limit in the code, as there's clocksource
mult granularity, and other considerations, but the kernel warns when
it's over 11%.

For the discontinuity issue, we accumulate time with cycle_interval
granularity which is basically HZ, and so when we adjust the frequency
we only have to compensate the base xtime_nsec to offset for the freq
change against the unaccumulated cycles (which are less then
cycle_interval - see the logic in timekeeping_apply_adjustment()).

Then it's just the issue of how far after the update that you end up
reading the clocksource (how long of a delay you hit). I think the
assumption is you can't be delayed by more than a tick (as you the
stale base could become the active one again), but its been awhile
since I've stewed on this bit.

So I think it reasonable to say its bounded by approximately  2 *
NSEC_PER_SEC/HZ +/- 11%.



> 2) The comment specifies that for a single cpu, the only way for this
> behavior to happen is when observing the time in the context of an NMI
> that happens during an update.
> For observations across different cpus, are the scenarios where the
> non-monotonic behavior happens also tied to observing time within NMI
> contexts? or is it something that can happen outside of NMI contexts
> as well?

Yes, I believe it can happen outside of NMI contexts as well.  The
read is effectively lock-free so if you are preempted or interrupted
in the middle of the read (before fast_tk_get_delta_ns), you may end
up using the old tk_fast base with a later clocksource cycle value,
which can cause the same issue.

thanks
-john

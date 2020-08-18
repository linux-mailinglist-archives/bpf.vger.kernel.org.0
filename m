Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA0249007
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRVTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRVTi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 17:19:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70BC061389
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 14:19:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so19558347wrs.8
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M9o6jNTGSqUTEZ7n9bG5IRFEil1hGA6YlL+EeSjHik=;
        b=nSrxnZY3gCZWVhX1Vbf5kNOvxZxXBgtuQTngfaAVqmZ2lBb0WQhftyUwo7oTjubxsB
         nifGdtg46PYCi/iGat3SfqyCbNtJf4vgmeE9X3tu97dq8CsITo6LDnEeMxeRtx7YeTs/
         NySXSQMtXsLz0f/2RFWZXpCRnG47/lUaMPfBdBRSJ087c3IrwabEeDb8nLKu0U02w4FO
         gxHfnreOFaCzJC5sBxBsIRv9NGlaHndF976i63o9zH1b5rhX+1G6bVXxzTxjqrJeMir1
         mHVaiHwenraLvIxFEOgwvQj/Q8kc94dv7noAoVkK506WJwU8jzs1sR24bAP8EGQAxN7n
         77yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M9o6jNTGSqUTEZ7n9bG5IRFEil1hGA6YlL+EeSjHik=;
        b=I24Qk8BoU4fDbDvbH7skYqA1/MQdcwwQIWY0OnEuGYpK+I0DxX6s0d+jdyidktVIdo
         aVyD6OwagP4J4gWezZCZXR214rDgZGlT1INeS6NQunTLlW/WQwCOnGykoczmIwh0qMdm
         16U+0ngs0+eGZldbaHI2rfhcod6QFvebb+DF8dnwxd448uqioMO/FO3keYwMIVf7+pL4
         uS5l9jMxw9WmyQ0EeIgCXmWqRkkV3vfx0XomjPFN0foi4qppI0PUV/umIS5RqGgijkBm
         TEwJ3jxiZXHFqK4s7keXxhDuDAsBTiiCmmXnw+2L6dv0GSFGBcjnFqzNDCeTzMMbfxFZ
         8l8Q==
X-Gm-Message-State: AOAM530pbtNRiqoUyqHTgZSxxRDdQaoyI4LIViKi16KHPvehBkEgTa9G
        uoGYHfvibc8+0WTztDCIHvXF2cg8JMv5/pxK7vZApCqf9Ek=
X-Google-Smtp-Source: ABdhPJxrigIfdnHvv4dl5XoCOgYKhBq6dA/rVOeNIUEVSW7OpIi9sjnSLfldxnsuaHQdTVMj35xroDf96rXdjixSkyw=
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr1009430wrf.206.1597785576153;
 Tue, 18 Aug 2020 14:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYMaU14=5bzzasAANJW7w2pNxHZOMDwsDF_btVWvf9ADA@mail.gmail.com>
 <C50F3QS9W4JM.1OIVL1ZHWEIWI@maharaja>
In-Reply-To: <C50F3QS9W4JM.1OIVL1ZHWEIWI@maharaja>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 18 Aug 2020 14:19:24 -0700
Message-ID: <CANP3RGcVidrH6Hbne-MZ4YPwSbtF9PcWbBY0BWnTQC7uTNjNbw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Add bpf_ktime_get_real_ns
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bimmy.pujari@intel.com, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, mchehab@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, ashkan.nikravesh@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 18, 2020 at 2:11 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Mon Jul 27, 2020 at 10:01 PM PDT, Andrii Nakryiko wrote:
> > On Mon, Jul 27, 2020 at 4:35 PM <bimmy.pujari@intel.com> wrote:
> > >
> > > From: Ashkan Nikravesh <ashkan.nikravesh@intel.com>
> > >
> > > The existing bpf helper functions to get timestamp return the time
> > > elapsed since system boot. This timestamp is not particularly useful
> > > where epoch timestamp is required or more than one server is involved
> > > and time sync is required. Instead, you want to use CLOCK_REALTIME,
> > > which provides epoch timestamp.
> > > Hence add bfp_ktime_get_real_ns() based around CLOCK_REALTIME.
> > >
> >
> > This doesn't seem like a good idea. With time-since-boot it's very
> > easy to translate timestamp into a real time on the host.
>
> For bpftrace, we have a need to get millisecond-level precision on
> timestamps. bpf has nanosecond level precision via
> bpf_ktime_get[_boot]_ns(), but to the best of my knowledge userspace
> doesn't have a high precision boot timestamp.
>
> There's /proc/stat's btime, but that's second-level precision. There's
> also /proc/uptime which has millisecond-level precision but you need to
> make a second call to get current time. Between those two calls there
> could be some unknown delta. For millisecond we could probably get away
> with calculating a delta and warning on large delta but maybe one day
> we'll want microsecond-level precision.
>
> I'll probably put up a patch to add nanoseconds to btime (new field in
> /proc/stat) to see how it's received. But either this patch or my patch
> would work for bpftrace.
>
> [...]
>
> Thanks,
> Daniel

Not sure what problem you're trying to solve and thus what exactly you
need... but you can probably get something very very close with 1 or 2
of clock_gettime(CLOCK_{BOOTTIME,MONOTONIC,REALTIME}) possibly in a
triple vdso call sandwich and iterated a few times and picking the one
with smallest delta between 1st and 3rd calls.  And then assuming the
avg of 1st and 3rd matches the 2nd.
ie.

5 times do:
t1[i] = clock_gettime(REALTIME)
t2[i] = clock_gettime(BOOTTIME)
t3[i] = clock_gettime(REALTIME)

pick i so t3[i] - t1[i] is smallest

t2[i] is near equivalent to (t1[i] + t3[i]) / 2

which basically gives you a REAL to BOOT offset.

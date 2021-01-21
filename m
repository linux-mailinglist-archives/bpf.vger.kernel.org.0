Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C719E2FE419
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 08:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAUHhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 02:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbhAUHab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 02:30:31 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80018C061575
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 23:29:51 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y128so1125356ybf.10
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 23:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2IIBoec++FArkM6Ylno31PXWIl3x7Y0Tu7x92k8Kbs=;
        b=T0PV0FLty0LlKSS0BaK+bxdUpvS2DLnjfSgRQKftP3jQgN/q5PmUqWug/iyyDoosun
         F0Hn9XNpaRaF5nMuGOw4jNoTsyeQo1Rt+at6mooRU0SxfYeXI7qZbmLP4DG0rFa68sCH
         XGySony2p6DWAEfNhAV39exE6oLvxMoug2jxQyRPXLEzXvrO5sj1K/pXdPlI7X4lLMvM
         hmUWQFS7BJKzKoQrty1tGICe7Q5m0FlwVcAWMVjLlNKbEG5v8JIwnS/cG4aOXbDFD6WF
         NyimTikvRR2+HanhOh71hnjRR2ShMMhsQ3H9tsGWJSP94dhSRL5aD90ClMIPfy5RPfcL
         fBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2IIBoec++FArkM6Ylno31PXWIl3x7Y0Tu7x92k8Kbs=;
        b=NVtg+7teWXzZZZVmJOMWeSyTgb3EFhTWsMxbpY9gpQNy9ccrppu0Cmb+IYeYrvH9tT
         6Y8lnWUphtOyLafu0lvZDbnOaN+SdOc2bzZsoLPi4udyKJOvij76xWPCbn38MTPyoQAP
         E1kUwBaoShPqgtYPZxGm4HWANHPCJpY5CdSEbjiyeA2DzI3zXNxjY5g/AB8Ez6wljM0x
         /z38KakUysWcpX9iBwQtkl7XFp8pukdMHWzYZiga2P6ZuNTWqzQBRiLFZMUvxQHqFXT1
         gxyp0U3PgTI73QqhPymF4zEvUgVsE77hg8fugX5QpqHw6knepA3oT9Ztp4hvcQTXzHpV
         ihBw==
X-Gm-Message-State: AOAM531fS1H5rV5mThPrMWJSXwqd+FufTBwVdgp1t/FKsP2bNGvWdrXF
        uBv5JNYO+1siO77b/cXjWOyEX5X2+fP7Gl6sC6c=
X-Google-Smtp-Source: ABdhPJyCZ1f4F22zcIkzr/lSikpWDWBsjb1gQfJh1QfYcibhUg9G7OGo6cNAM/0ydb8THNDTVA1NVj5kIJot6ybu2Sc=
X-Received: by 2002:a25:a183:: with SMTP id a3mr13997172ybi.459.1611214190863;
 Wed, 20 Jan 2021 23:29:50 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3ENW8FV=CsKFmvpqCvbwzz5z2dLmBzrsO9QePVPuyaxXQ@mail.gmail.com>
In-Reply-To: <CANaYP3ENW8FV=CsKFmvpqCvbwzz5z2dLmBzrsO9QePVPuyaxXQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Jan 2021 23:29:40 -0800
Message-ID: <CAEf4Bzbd-_6m=u9m32c0-hZA=JMkNEC2yWgcs_02Nv4fxxmpfQ@mail.gmail.com>
Subject: Re: libbpf ringbuf manager starvation
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        assaf.piltzer@cyberark.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 19, 2021 at 7:51 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> Hello there,
>

Hi,

> When playing with the (relatively) new ringbuf api we encountered
> something that we believe can be an interesting usecase.
> When registering multiple rinbufs to the same ringbuf manager, one of
> which is highly active, other ringbufs may starve. Since libbpf
> (e)polls on all the managed ringbufs at once and then tries to read
> *as many samples as it can* from ready ringbufs, it may get stuck
> indefinitely on one of them, not being able to process the other.
> We know that the current ringbuf api exposes the epoll_fd so that one
> can implement the epoll logic on his own, but this sounds to us like a
> not so advanced usecase that may be worth taking care of specifically.
> Does allowing to specify a maximum number of samples to consume sounds
> like a reasonable addition to the ringbuf api?

Did you actually run into such a situation in practice? If you have a
BPF program producing so much data so fast that user-space can't keep
up, then it sounds like a suboptimal use case for BPF ringbuf.

But nevertheless, my advice for you situation is to use two instances
of libbpf's ring_buffer: one for super-busy ringbuf, and another for
everything else. Or you can even have one for each. It's very
flexible.

As for having this limit, it's not so simple, unfortunately. The
contract between kernel, epoll, and libbpf is that user-space will
always consume all the items until it runs out of more items to
consume. Internally in kernel BPF ringbuf relies on that to skip
unnecessary epoll notifications. If you consume not all items and will
attempt to (e)poll again, you'll never get another notification
(unless you force-notify from your BPF program, that's an advanced use
case).

We could do a round-robin across all registered ringbufs within the
ring_buffer instance in ring_buffer__poll()/ring_buffer__consume(),
but I think it's over-designing for a quite unusual case.


>
> Thanks

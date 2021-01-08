Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378C22EF8AD
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 21:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbhAHUPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 15:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbhAHUPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 15:15:23 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BE3C061380
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 12:14:43 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f6so10446520ybq.13
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWpuRYpeew/FwKZ9bqYugiO+gi2KVR5B4gbhFDywtno=;
        b=RyXkdoxycEn4g4V1pBYVwnE1l2S0xWcW3cFeuRqvtzlzcAUK4oDztzPkHMKF5c99hT
         hTRYdwXSIP0uJBFGiVlWAk9GoiolzYXBReSi0ndg/x3aLKSwEsfyvFYDVABQmNu48tYR
         a9AvkjNw1P9v6v7PZjYJpt8rgcoqenbeu2UfuK7TmftQ1QpGjpIIUEIe6MCiY+zIt+BH
         pkOPDeBKGoLr94pmXEXsewGcK423YodsF2e9Gf2kpfY/2GYh2aOrfCo4iw9DRt+Y+t/P
         eDsoiLu3AcDfwHlYanpwq1At78t24xhYn2/tXIjk1Tn3oK8l5CafD1pltDKEAhWfiy4K
         3MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWpuRYpeew/FwKZ9bqYugiO+gi2KVR5B4gbhFDywtno=;
        b=Ke02B9cgzo9FyjmH4WziKTKHWb9CG54CA2AW2EyYmF14sV0HU6TrkRWMwdk0x0l3r3
         p1NYXA83oQCHsFOxsRtJI/aEWETT54poZ9U5KHbq9KRmlm5lpPRYg8Rm3LEXL25RGxpH
         POxpvDd9figs1TaUN5z90uZfgyionSL4+xByHu4NwYuDrJ8Aorlwe896STzdeUpzS0YB
         RwPZOFqkbf528QMcJ50fPwEG6rQV/kGdRGeqw9lBphgAzd8tj7m+KUQpOFfZjOPk2Fmd
         b00uJeDTRtDsig/NNMYDT1olX5+a6KTpBkHg/meGhldT+R4SB05Z3NIRhv2knNfxNtLQ
         gXaw==
X-Gm-Message-State: AOAM531+2fzX+RQtDDl0JDfWI0idSHXYcPkMux55ZqrpsOIl39ja/N3w
        pIc3FZc37qZMxX/tY3nTw1ulpxyMia/L2YoYIkks/siQ
X-Google-Smtp-Source: ABdhPJzR7GpYNTa4Gdabl5BNIwiUAMKn4dpaF4SIhmBZ6wv2Bz50sp1eqdmYMZZkkolB6MjEN4/vtk+Jn0hBpzOIQOI=
X-Received: by 2002:a25:d6d0:: with SMTP id n199mr7614874ybg.27.1610136882481;
 Fri, 08 Jan 2021 12:14:42 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
 <CA+i-1C12rrRbTUDZXYUKWoVOgXDw+K6Hrj0Lg6wnrEL93R7_oA@mail.gmail.com>
In-Reply-To: <CA+i-1C12rrRbTUDZXYUKWoVOgXDw+K6Hrj0Lg6wnrEL93R7_oA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jan 2021 12:14:31 -0800
Message-ID: <CAEf4BzbDeGrEFFSHW9C0pMOmTbkp4Ug3483Aar15b_jWt_LVJQ@mail.gmail.com>
Subject: Re: BPF ring buffer variable-length data appending
To:     Brendan Jackman <jackmanb@google.com>
Cc:     KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 8, 2021 at 5:05 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> Hi Andrii,
>
> I should preface by saying I don't yet truly understand why
> variable-length reservations are difficult in the first place. With
> that caveat in place...

Well, there are two aspects. BPF ringbuf doesn't allow to re-reserve
already reserved space, because in general it's impossible. So you
need to provide the desired length upfront. Which means you need to
calculate all strlen()s first to know the exact size. But assuming
that's done, it's still not possible because of the BPF verifier.

It's impossible for BPF verifier to guarantee safe memory accesses if
the size of ringbuf record is not known statically at the verification
time. Imagine something like this:

int sz = rand() % 100;
void *data = bpf_ringbuf_reserve(&rb, sz);

Verifier is smart enough to deduce that sz is [0, 100), right? And so
what? We don't know whether it's actually 0, 50, or 100. The value is
known only in runtime. So allowing to access even the very first byte
of the record is unsafe, because if sz turns out to be 0, you are
already reading/writing wrong memory.

Verifier would need to completely change how it does the register
state tracking to allow something like this. It would need to properly
track relationships between registers, not just known scalar ranges.

>
> On Thu, 7 Jan 2021 at 20:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > We discussed this topic today at office hour. As I mentioned, I don't
> > know the ideal solution, but here is something that has enough
> > flexibility for real-world uses, while giving the performance and
> > convenience of reserve/commit API. Ignore naming, we can bikeshed that
> > later.
> >
> > So what we can do is introduce a new bpf_ringbuf_reserve() variant:
> >
> > bpf_ringbuf_reserve_extra(void *ringbuf, __u64 size, __u64 flags, void
> > *extra, __u64 extra_sz);
> >
> > The idea is that we reserve a fixed size amount of data that can be
> > used like it is today for filling a fixed-sized metadata/sample
> > directly. But the real size of the reserved sample is (size +
> > extra_sz), and bpf_ringbuf_reserve_extra() helper will bpf_probe_read
> > (kernel or user, depending on flags) data from extra and put it right
> > after the fixed-size part.
> >
> > So the use would be something like:
> >
> > struct my_meta *m = bpf_ringbuf_reserve_extra(&rb, sizeof(*m),
> > BPF_RB_PROBE_USER, env_vars, 1024);
> >
> > if (!m)
> >     /* too bad, either probe_read_user failed or ringbuf is full */
> >     return 1;
> >
> > m->my_field1 = 123;
> > m->my_field2 = 321;
>
> This seems useful although it seems we would then also want a version
> that did probe_read_{user,kernel}_str as well...

It will be as inefficient as a BPF program doing probe_read_str() on
its own into some per-CPU temporary buffer and then using
bpf_ringbuf_reserve_extra(). See below, knowing the size of
zero-terminated string requires extra pass over data. And to be on the
safe side, you need to copy it locally, so it's not modified between
strlen() and strcpy(). Which is why I didn't propose such a string
reading variant. It's inherently inefficient, so better to just let
BPF program do that and handle all the error conditions explicitly.

>
> > So the main problem with this is that when probe_read fails, we fail
> > reservation completely(internally we'd just discard ringbuf sample).
> > Is that OK? Or is it better to still reserve fixed-sized part and
> > zero-out the variable-length part? We are combining two separate
> > operations into a single API, so error handling is more convoluted.
>
> I think the correct answer here is "we don't know", and the natural
> response is to then let the user decide. However then we already have
> at least two or three dimensions (user/kernel, error behaviour, _str
> or runtime-fixed size...) which feels like a "design smell" to me.

Exactly. Which is why I'm leaning towards restricting extra_data to be
a known good and initialized memory location (map_value, sk_buff,
another ringbuf sample, etc).

>
> > Now, the main use case requested was to be able to fetch an array of
> > zero-terminated strings. I honestly don't think it's possible to
> > implement this efficiently without two copies of string data. Mostly
> > because to just determine the size of the string you have to read it
> > one extra time. And you'd probably want to copy string data into some
> > controlled storage first, so that you don't end up reading it once
> > successfully and then failing to read it on the second try. Next, when
> > you have multiple strings, how do you deal with partial failures? It's
> > even worse in terms of error handling and error propagation than the
> > fixed extra size variant described above.
> >
> > Ignoring all that, let's say we'd implement
> > bpf_ringbuf_reserve_extra_strs() helper, that would somehow be copying
> > multiple zero-terminated strings after the fixed-size prefix. Think
> > about implementation. Just to determine the total size of the ringbuf
> > sample, you'd need to read all strings once, and probably also copy
> > them locally.  Then you'd reserve a ringbuf sample and copy all that
> > for the second time. So it's as inefficient as a BPF program
> > constructing a single block of memory by reading all such strings
> > manually into a per-CPU array and then using the above
> > bpf_ringbuf_reserve_extra().
> >
> > But offloading that preparation to a BPF program bypasses all these
> > error handling and memory layout questions. It will be up to a BPF
> > program itself. From a kernel perspective, we just append a block of
> > memory with known (at runtime) size.
>
> I agree, I think bpf_ringbuf_reserve_extra_strs would be unnecessarily
> complex, especially if we have what I suggested above which would
> probably be called bpf_ringbuf_reserve_extra_str.
>

Ok, cool.

> > As a more restricted version of bpf_ringbuf_reserve_extra(), instead
> > of allowing reading arbitrary kernel or user-space memory in
> > bpf_ringbuf_reserve_extra() we can say that it has to be known and
> > initialized memory (like MAP_VALUE pointer), so helper knows that it
> > can just copy data directly.
>
> This is just some preliminary input but I need to do some reading and
> think more deeply about this.
>
> Another dimension to think about is that it would be great to be able
> to go directly from a helper like bpf_get_cwd into the ringbuffer with
> neither an intermediate copy nor a reservation of PATH_MAX.

I don't know how you imagine this to even look like, honestly. I
certainly can't see it given the pretty fundamental limitations (but
reasonable, honestly) we have with ringbuf and verifier.

>
> On the other hand, as you pointed out in the call, reserving PATH_MAX
> may not be as bad as it sounds since you still only copy the actual
> string length. I'm planning to do some benchmarking next week to
> investigate that.

Sounds good.

>
> Thanks,
> Brendan

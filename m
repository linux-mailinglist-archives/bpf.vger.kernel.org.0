Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42BB2EF2DB
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAHNGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbhAHNGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 08:06:09 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD586C0612F5
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 05:05:28 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id t8so9656749iov.8
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoZ36nvKGmBM6PjnVM75KlQgWxheD1KsASjWnU5y1fU=;
        b=p9WKsAO6CyfD1kjoCdeOGX/PeSiuA/AFYj2tMyhGYgedMy7q0X/VbpeBx8px2xUL+W
         V9XCkb65vH31gga/0ww4Ucj6ZSDWbfEkpQwoEYCu7PF9WWxsMQLLzXUO6hCO10QMZW7Z
         WHXddO3qaTxxuePbPmEEJk3s8TTffdJNQQ+liTqbUSfcoU9Jh0lp1c2bJxevpXgH2S+t
         XGjh0+R9RraPMhcVEUX5MLwmbf80FlEKBgKQ8QVvZLn+inoxguE9ciNZk7hvHEzEhRIe
         vYQ6wVq0z/aEqezwNgaRYxcCYatLWjoKOEvtx65cd7ac/zkRi1vYoNE5WPojpe8sX+nN
         fazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoZ36nvKGmBM6PjnVM75KlQgWxheD1KsASjWnU5y1fU=;
        b=FmL3a1BrZTI6r7byKj5CLy0ThO4y6HqicOg/h2iKOoBAFRbozxvmacqDgZ/ctceDPA
         WFjpTjGzraeB6BkIW63wWGpTPWeAcWyYl9EpukNfUuf8mloZAL7iJMwzbDGEBxR/4EVD
         5dW1GHb+/ZnZExVfZG558J/FGVnDv93EUzWe9ILstzS2AmIOEzKukyE8r2aNS5crzNGL
         DG5p1KL/3L94rAxtAIoHCbAMJBnvQlGLU62KpDFeD40N5SFvygD7V9bLAjwY6c37yl2a
         UlX03PUqBnTQsz1PrK746BiUanilbKYcVG09uEIpnQSmaNz7DjK6BE4Cfg2OQfUmmQN8
         OflA==
X-Gm-Message-State: AOAM533rFkdFyuF2wY8VIOXfpzd8cJsp3kKuHrIiUYuDsEJL/QhIN8qZ
        zP0OznYY0IdKfTW4eUcF+Ed3vYfflxf/p+lxnEQLGA==
X-Google-Smtp-Source: ABdhPJyd5rZXdozTpA463unD8iBQ+2OoYxC+Az8jdjJRXPiOzSCveMnieQVMcDcW+9czld+Pz1LoG0+J2u+0TTq/pZw=
X-Received: by 2002:a6b:bac3:: with SMTP id k186mr5222118iof.194.1610111127677;
 Fri, 08 Jan 2021 05:05:27 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
In-Reply-To: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Fri, 8 Jan 2021 14:05:16 +0100
Message-ID: <CA+i-1C12rrRbTUDZXYUKWoVOgXDw+K6Hrj0Lg6wnrEL93R7_oA@mail.gmail.com>
Subject: Re: BPF ring buffer variable-length data appending
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I should preface by saying I don't yet truly understand why
variable-length reservations are difficult in the first place. With
that caveat in place...

On Thu, 7 Jan 2021 at 20:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> We discussed this topic today at office hour. As I mentioned, I don't
> know the ideal solution, but here is something that has enough
> flexibility for real-world uses, while giving the performance and
> convenience of reserve/commit API. Ignore naming, we can bikeshed that
> later.
>
> So what we can do is introduce a new bpf_ringbuf_reserve() variant:
>
> bpf_ringbuf_reserve_extra(void *ringbuf, __u64 size, __u64 flags, void
> *extra, __u64 extra_sz);
>
> The idea is that we reserve a fixed size amount of data that can be
> used like it is today for filling a fixed-sized metadata/sample
> directly. But the real size of the reserved sample is (size +
> extra_sz), and bpf_ringbuf_reserve_extra() helper will bpf_probe_read
> (kernel or user, depending on flags) data from extra and put it right
> after the fixed-size part.
>
> So the use would be something like:
>
> struct my_meta *m = bpf_ringbuf_reserve_extra(&rb, sizeof(*m),
> BPF_RB_PROBE_USER, env_vars, 1024);
>
> if (!m)
>     /* too bad, either probe_read_user failed or ringbuf is full */
>     return 1;
>
> m->my_field1 = 123;
> m->my_field2 = 321;

This seems useful although it seems we would then also want a version
that did probe_read_{user,kernel}_str as well...

> So the main problem with this is that when probe_read fails, we fail
> reservation completely(internally we'd just discard ringbuf sample).
> Is that OK? Or is it better to still reserve fixed-sized part and
> zero-out the variable-length part? We are combining two separate
> operations into a single API, so error handling is more convoluted.

I think the correct answer here is "we don't know", and the natural
response is to then let the user decide. However then we already have
at least two or three dimensions (user/kernel, error behaviour, _str
or runtime-fixed size...) which feels like a "design smell" to me.

> Now, the main use case requested was to be able to fetch an array of
> zero-terminated strings. I honestly don't think it's possible to
> implement this efficiently without two copies of string data. Mostly
> because to just determine the size of the string you have to read it
> one extra time. And you'd probably want to copy string data into some
> controlled storage first, so that you don't end up reading it once
> successfully and then failing to read it on the second try. Next, when
> you have multiple strings, how do you deal with partial failures? It's
> even worse in terms of error handling and error propagation than the
> fixed extra size variant described above.
>
> Ignoring all that, let's say we'd implement
> bpf_ringbuf_reserve_extra_strs() helper, that would somehow be copying
> multiple zero-terminated strings after the fixed-size prefix. Think
> about implementation. Just to determine the total size of the ringbuf
> sample, you'd need to read all strings once, and probably also copy
> them locally.  Then you'd reserve a ringbuf sample and copy all that
> for the second time. So it's as inefficient as a BPF program
> constructing a single block of memory by reading all such strings
> manually into a per-CPU array and then using the above
> bpf_ringbuf_reserve_extra().
>
> But offloading that preparation to a BPF program bypasses all these
> error handling and memory layout questions. It will be up to a BPF
> program itself. From a kernel perspective, we just append a block of
> memory with known (at runtime) size.

I agree, I think bpf_ringbuf_reserve_extra_strs would be unnecessarily
complex, especially if we have what I suggested above which would
probably be called bpf_ringbuf_reserve_extra_str.

> As a more restricted version of bpf_ringbuf_reserve_extra(), instead
> of allowing reading arbitrary kernel or user-space memory in
> bpf_ringbuf_reserve_extra() we can say that it has to be known and
> initialized memory (like MAP_VALUE pointer), so helper knows that it
> can just copy data directly.

This is just some preliminary input but I need to do some reading and
think more deeply about this.

Another dimension to think about is that it would be great to be able
to go directly from a helper like bpf_get_cwd into the ringbuffer with
neither an intermediate copy nor a reservation of PATH_MAX.

On the other hand, as you pointed out in the call, reserving PATH_MAX
may not be as bad as it sounds since you still only copy the actual
string length. I'm planning to do some benchmarking next week to
investigate that.

Thanks,
Brendan

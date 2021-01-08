Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5512EF87E
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 21:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbhAHUDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 15:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbhAHUDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:16 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC8C061380
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 12:02:35 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y128so10449341ybf.10
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nL9CnCQ+yoYHYE1taCNraalL64LGMv+95dMQ3PE+uTo=;
        b=i/Xa0tJ4tKPSDzE5T6AZe80pvTW6Kxs58pNh4S+UfexoS3eMjcQf0qtyJp8p/BJyo2
         W35OYgQpZZ/2Sp0C1lyqBw7eMswZRKUqf5X7JWRwkBPH/21qzb0M5BADaZAiUkDxUSJ8
         huv2yx7CC8ceY1iIHDinv1A532kHMQeYgq9j9ALjEZ2hQ8XKpcackMjNKsVrz8a0tAly
         l15gUPb1d+VPrQVXVuJqwARVbGKAo2fKhWax709HlHowYLoRHMxxz2EdE0QUvMfztLPw
         nvgBAUaq4fgC4OzyCws4QkH7fiwtQDhqPLkCUi0Tu+cnMujqQ+X6y7hFCqG8OuG3cTLe
         Owmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nL9CnCQ+yoYHYE1taCNraalL64LGMv+95dMQ3PE+uTo=;
        b=JxsFXpVWf8aggwujXpjpmldlQVIk+c+9jVc+AL1b9hgOAtXf3VpgDxidTaaSLkiN1j
         RPTHJOw1GqtaXCOfdYRboBC94upxJPTi3546RV8ZCnUE/qfaQUosZvzjNucxF/JiAE71
         hJHGfb57jYiQ13pHqdeAfKpCQAXCvBNg3EI+07yWggRWXAabrwV1EIQu/Y0MHYKvkWpV
         8vv0Mo2wDX5s1OrNVbAtLXLJa+JTtdQCsLAkSQqAHBjVKzjMCiUa4sGmCU14tcygrrUc
         z4QLNPNGNho8djSmjeRrz6hw4C9xctiR1TQWeqXGwcyKtW3o+04T83ZYvSdRt15aT5rP
         1R+Q==
X-Gm-Message-State: AOAM530+rmpQ07EHsVvDnzheK2j+kd0muDEA1g+tfutLrXaJ4ctCYkgl
        59VeJNLmiZ4oV7wd5Hc2AA0G8wIompKsQdYr48k=
X-Google-Smtp-Source: ABdhPJwV53/I8YDju8imrIrOHNQbYyO5Ngi1yab9f3eWT767xTVSq51sfrOR3+ykDrDp/yYIaEM+L765GWZ3V33z6Uk=
X-Received: by 2002:a25:2c4c:: with SMTP id s73mr7887996ybs.230.1610136154919;
 Fri, 08 Jan 2021 12:02:34 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
 <5ff7f1167259b_36910208ef@john-XPS-13-9370.notmuch>
In-Reply-To: <5ff7f1167259b_36910208ef@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jan 2021 12:02:24 -0800
Message-ID: <CAEf4Bzaw5r9Cs_jnacTZ54LtgQrK9PNyTdTY5KU9-wSHYtXzww@mail.gmail.com>
Subject: Re: BPF ring buffer variable-length data appending
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 9:44 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > We discussed this topic today at office hour. As I mentioned, I don't
> > know the ideal solution, but here is something that has enough
> > flexibility for real-world uses, while giving the performance and
> > convenience of reserve/commit API. Ignore naming, we can bikeshed that
> > later.
>
> Missed office hours today, dang sounds interesting. Apoligies if I'm
> missing some context.
>
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
> >
>
> Is this a way to increase the reserved space? I'm a bit fuzzy on the
> details here. But what happens if something else has done another
> reserve? Then it fails I guess?

No, you misunderstood. There is no way to safely increase the size of
already reserved ringbuf record. Naming is hard.
bpf_ringbuf_reserve_extra() reserve the correct size of the record
from the very beginning. It's just that size is (size + extra_sz). The
difference from non-extra() variant is that size is still restricted
to be a known constant, so that verifier can verify safe direct memory
reads and writes within first *size* bytes. But extra_sz can be
unknown at the verification time (so it's ARG_ANYTHING), do it can be
calculated dynamically. That's most of the difference. The other part
is that because BPF program can't do much with this dynamic part of
ringbuf record, we also immediately copy provided memory for later
submission to the user space.

>
> So consider,
>
> CPU0                   CPU1
>
> bpf_ringbuf_reserve()
>                        bpf_ringbuf_reserve()
> bpf_ringbuf_reserve_extra()
>
> Does that *_reserve_extra() fail then? If so it seems very limited
> from a use perspective. Most the systems we work with will fail more
> often than not I think.
>
> If the above doesn't fail, I'm missing something about how userspace
> can know where that buffer is without a scatter-gather list.
>
> >
> > So the main problem with this is that when probe_read fails, we fail
> > reservation completely(internally we'd just discard ringbuf sample).
> > Is that OK? Or is it better to still reserve fixed-sized part and
> > zero-out the variable-length part? We are combining two separate
> > operations into a single API, so error handling is more convoluted.
>
> My $.02 here. Failing is going to be ugly and a real pain to deal

If data copying failed, you are not getting data you expected. So
failing seems reasonable in such case. The convoluted and unfortunate
part is that you don't know whether it is ringbuf ran out of free
space or memory copying failed. If we restring extra_data pointer to
be a known good memory (like sk_buff, map_value, etc), then this
concern goes away. But you also won't be able to use this directly to
read some piece of generic kernel or user memory without extra
(explicit) bpf_probe_read(). Which might be acceptable, I think.

> with. I think best approach is reserve a fixed-sized buffer that
> meets your 99% case or whatever. Then reserve some overflow buffers
> you can point to for the oddball java application with a million
> strings. Yes you need to get more complicated in userspace to manage
> the thing, but once that codes written everything works out.
>
> Also I think we keep the kernel simpler if the BPF program just
> does another reserve() if it needs more space so,
>
>  bpf_ringbuf_reserve()
>  copy
>  copy
>  ENOMEM <- buff is full,
>  bpf_ringbuf_reserve()
>  copy
>  copy
>  ....
>
> Again userspace needs some logic to join the two buffers but we
> could come up with some user side convention to do this. libbpf
> for example could have a small buffer header to do this if folks
> wanted.  Smart BPF programs can even reserve a couple buffers
> up front for the worse case and recycle them back into its
> next invocation, I think.

First, I don't think libbpf should do anything extra here. It's just
bound to be suboptimal and cumbersome.

But yes, this is another approach, though arguably quite complicated.
Chaining buffers can be done simply by using cpu_id and recording the
total number of expected chunks in the very first chunk. You can
submit the first chunk last, if you use reserve/commit API.
Reconstruction in user-space is going to require memory allocations
and copying, though.

>
> Conceptually, what is the difference between a second reserve
> as compared to reserve_extra()?
>
> >
> >
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
>
> +1 agree
>
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
>
> +1
>
> >
> > But offloading that preparation to a BPF program bypasses all these
> > error handling and memory layout questions. It will be up to a BPF
> > program itself. From a kernel perspective, we just append a block of
> > memory with known (at runtime) size.
>
> Still missing how this would be different from multiple reserve()
> calls. Its not too hard to join user space buffers I promise ;)

It's not trivial, but also probably less efficiently, as now you need
to dynamically allocate memory and still do extra copy. So I can
certainly see the appeal of being able to submit one whole record,
instead of trying to re-construct intermingled chunks across multiple
CPUs.

Anyways, I'm not advocating one or the other approach, both have the
right to exist, IMO. There is no free lunch, unfortunately. Either way
complexity and extra overhead creeps in.

>
> >
> > As a more restricted version of bpf_ringbuf_reserve_extra(), instead
> > of allowing reading arbitrary kernel or user-space memory in
> > bpf_ringbuf_reserve_extra() we can say that it has to be known and
> > initialized memory (like MAP_VALUE pointer), so helper knows that it
> > can just copy data directly.
>
> This is a fairly common operation for us, but also just chunks of a map
> value pointer. So would want a start/end offset bytes. Often our
> map values have extra data that user space doesn't need or care about.

Huh? It's just a pointer, you can point inside the MAP_VALUE today,
no? And you already have extra_sz. So this should work:

struct my_data *d = bpf_map_lookup_elem(&my_map, &my_key);
if (!d) return 0;

bpf_ringbuf_reserve_extra(&rb, 100, 0, d + 100, 200);

And you'll be copying [100, 200) range into ringbuf. No?

>
> >
> > Thoughts?
>
> I think I missed the point.

I think you misunderstood what bpf_ringbuf_reserve_extra() is going to
do. And we might differ in evaluating how easy it is to handle
chunking, both in kernel and user-space :)

>
> >
> > -- Andrii

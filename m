Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308D52F04A7
	for <lists+bpf@lfdr.de>; Sun, 10 Jan 2021 02:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbhAJA6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jan 2021 19:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJA6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jan 2021 19:58:46 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81108C061786
        for <bpf@vger.kernel.org>; Sat,  9 Jan 2021 16:58:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d8so13562399otq.6
        for <bpf@vger.kernel.org>; Sat, 09 Jan 2021 16:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Cw0FQkPofbp8UhaGkGD2N7kZb7ecJLNHTfC8/jBdcp0=;
        b=XAuydqCwnrTxKOUFSDlATdZpFUL77qHuL0a1QWijZ9kU8ycLis4dAnZP85sE6hubOa
         1JC8dUSSx8tu7rFkpBEzyQe28dbNDaZjqvoEAVZ/iJVcQb9lS0jeQIULlzdiH2oQFL/1
         TUaH0agK2tlZQ6lgRH8894tu83ysP6vZUJWav6NtAYaTFCZ3kgLw+KyIyyYm10oKSNq1
         0txcSdBBh3jJr9pmFCVlwYd9tRNbH1xwEbcDRVsMJ01AwoOjGfMv2+4fDrLCi4+IpQl+
         boAWCe70lCwTaZdOnL2z18XZ8k0+/v13NqyvY937P7Eikdp5UZA6ytooGBHhEkUrtPw9
         LSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Cw0FQkPofbp8UhaGkGD2N7kZb7ecJLNHTfC8/jBdcp0=;
        b=lV7ym7ks0W4J+Deh/BBAY3zvK7bzJ1wj2Pk1pN28u86ag4UVaN0KdewH2IRfHmJh/c
         CKQXHwd4k714+YLbev91wUbzcgT53OFKEeU85wz9Gwx2rUnQc1Kdr1gui4pQ8N3KvSls
         E5AoAohLIM3/w9hfPUfruMse6/Lvsv9rtuDeQ8tN+fzlS21onLUloH3CzYbIvVIMkk1L
         lVRdtvG+EYAnvmSXsataL+BtKkWpOfyEA+Rz/54lp1DtSiM6zGDUuf+4ZvF9jscvHuk+
         humPTGaUBdF6egOQrtrBuzN1whxlrXdpW0/WT3ExIdXl/w7vHy1tu82UsrKIB0x4PEoM
         dm+A==
X-Gm-Message-State: AOAM533vBmsudmP+gdfv5V0/PVEgTqQkJqumMhFKsJk6lepd/m1J7b9P
        9WJKyTc7Q7f8cUmCOuirgHk=
X-Google-Smtp-Source: ABdhPJx6py+E+lxHSh0BY8UWJQsXR2YgYKnB4BrwpuFoC4nX3usegglSqQYRXp2h/uSE859JuDRH0g==
X-Received: by 2002:a9d:4b19:: with SMTP id q25mr7227333otf.124.1610240285134;
        Sat, 09 Jan 2021 16:58:05 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id 39sm2703024otu.6.2021.01.09.16.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 16:58:04 -0800 (PST)
Date:   Sat, 09 Jan 2021 16:57:55 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ffa5113467a9_815b208fa@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4Bzaw5r9Cs_jnacTZ54LtgQrK9PNyTdTY5KU9-wSHYtXzww@mail.gmail.com>
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
 <5ff7f1167259b_36910208ef@john-XPS-13-9370.notmuch>
 <CAEf4Bzaw5r9Cs_jnacTZ54LtgQrK9PNyTdTY5KU9-wSHYtXzww@mail.gmail.com>
Subject: Re: BPF ring buffer variable-length data appending
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Thu, Jan 7, 2021 at 9:44 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > We discussed this topic today at office hour. As I mentioned, I don't
> > > know the ideal solution, but here is something that has enough
> > > flexibility for real-world uses, while giving the performance and
> > > convenience of reserve/commit API. Ignore naming, we can bikeshed that
> > > later.
> >
> > Missed office hours today, dang sounds interesting. Apoligies if I'm
> > missing some context.
> >
> > >
> > > So what we can do is introduce a new bpf_ringbuf_reserve() variant:
> > >
> > > bpf_ringbuf_reserve_extra(void *ringbuf, __u64 size, __u64 flags, void
> > > *extra, __u64 extra_sz);
> > >
> > > The idea is that we reserve a fixed size amount of data that can be
> > > used like it is today for filling a fixed-sized metadata/sample
> > > directly. But the real size of the reserved sample is (size +
> > > extra_sz), and bpf_ringbuf_reserve_extra() helper will bpf_probe_read
> > > (kernel or user, depending on flags) data from extra and put it right
> > > after the fixed-size part.
> > >
> > > So the use would be something like:
> > >
> > > struct my_meta *m = bpf_ringbuf_reserve_extra(&rb, sizeof(*m),
> > > BPF_RB_PROBE_USER, env_vars, 1024);
> > >
> > > if (!m)
> > >     /* too bad, either probe_read_user failed or ringbuf is full */
> > >     return 1;
> > >
> > > m->my_field1 = 123;
> > > m->my_field2 = 321;
> > >
> >
> > Is this a way to increase the reserved space? I'm a bit fuzzy on the
> > details here. But what happens if something else has done another
> > reserve? Then it fails I guess?
> 
> No, you misunderstood. There is no way to safely increase the size of
> already reserved ringbuf record. Naming is hard.

Great without a scatter-gather list I couldn't see any way increasing
size would work ;)

> bpf_ringbuf_reserve_extra() reserve the correct size of the record
> from the very beginning. It's just that size is (size + extra_sz). The
> difference from non-extra() variant is that size is still restricted
> to be a known constant, so that verifier can verify safe direct memory
> reads and writes within first *size* bytes. But extra_sz can be
> unknown at the verification time (so it's ARG_ANYTHING), do it can be
> calculated dynamically. That's most of the difference. The other part
> is that because BPF program can't do much with this dynamic part of
> ringbuf record, we also immediately copy provided memory for later
> submission to the user space.

OK. Thanks for the extra details.

> 
> >
> > So consider,
> >
> > CPU0                   CPU1
> >
> > bpf_ringbuf_reserve()
> >                        bpf_ringbuf_reserve()
> > bpf_ringbuf_reserve_extra()
> >
> > Does that *_reserve_extra() fail then? If so it seems very limited
> > from a use perspective. Most the systems we work with will fail more
> > often than not I think.
> >
> > If the above doesn't fail, I'm missing something about how userspace
> > can know where that buffer is without a scatter-gather list.
> >
> > >
> > > So the main problem with this is that when probe_read fails, we fail
> > > reservation completely(internally we'd just discard ringbuf sample).
> > > Is that OK? Or is it better to still reserve fixed-sized part and
> > > zero-out the variable-length part? We are combining two separate
> > > operations into a single API, so error handling is more convoluted.
> >
> > My $.02 here. Failing is going to be ugly and a real pain to deal
> 
> If data copying failed, you are not getting data you expected. So
> failing seems reasonable in such case. The convoluted and unfortunate
> part is that you don't know whether it is ringbuf ran out of free
> space or memory copying failed. If we restring extra_data pointer to
> be a known good memory (like sk_buff, map_value, etc), then this
> concern goes away. But you also won't be able to use this directly to
> read some piece of generic kernel or user memory without extra
> (explicit) bpf_probe_read(). Which might be acceptable, I think.

Seems reasonable. Not knowing what failed seems like a horrible
to debug error case so better to fix that.

> 
> > with. I think best approach is reserve a fixed-sized buffer that
> > meets your 99% case or whatever. Then reserve some overflow buffers
> > you can point to for the oddball java application with a million
> > strings. Yes you need to get more complicated in userspace to manage
> > the thing, but once that codes written everything works out.
> >
> > Also I think we keep the kernel simpler if the BPF program just
> > does another reserve() if it needs more space so,
> >
> >  bpf_ringbuf_reserve()
> >  copy
> >  copy
> >  ENOMEM <- buff is full,
> >  bpf_ringbuf_reserve()
> >  copy
> >  copy
> >  ....
> >
> > Again userspace needs some logic to join the two buffers but we
> > could come up with some user side convention to do this. libbpf
> > for example could have a small buffer header to do this if folks
> > wanted.  Smart BPF programs can even reserve a couple buffers
> > up front for the worse case and recycle them back into its
> > next invocation, I think.
> 
> First, I don't think libbpf should do anything extra here. It's just
> bound to be suboptimal and cumbersome.

Agree, not a great idea. Users will want to do this using specifics
of their use case.

> 
> But yes, this is another approach, though arguably quite complicated.
> Chaining buffers can be done simply by using cpu_id and recording the
> total number of expected chunks in the very first chunk. You can
> submit the first chunk last, if you use reserve/commit API.
> Reconstruction in user-space is going to require memory allocations
> and copying, though.

Sure, although maybe not copying if you have a scatter gather list
somewhere. I guess it all depends on your use case.

[...]

> > >
> > > But offloading that preparation to a BPF program bypasses all these
> > > error handling and memory layout questions. It will be up to a BPF
> > > program itself. From a kernel perspective, we just append a block of
> > > memory with known (at runtime) size.
> >
> > Still missing how this would be different from multiple reserve()
> > calls. Its not too hard to join user space buffers I promise ;)
> 
> It's not trivial, but also probably less efficiently, as now you need
> to dynamically allocate memory and still do extra copy. So I can
> certainly see the appeal of being able to submit one whole record,
> instead of trying to re-construct intermingled chunks across multiple
> CPUs.
> 
> Anyways, I'm not advocating one or the other approach, both have the
> right to exist, IMO. There is no free lunch, unfortunately. Either way
> complexity and extra overhead creeps in.

Sure.

> 
> >
> > >
> > > As a more restricted version of bpf_ringbuf_reserve_extra(), instead
> > > of allowing reading arbitrary kernel or user-space memory in
> > > bpf_ringbuf_reserve_extra() we can say that it has to be known and
> > > initialized memory (like MAP_VALUE pointer), so helper knows that it
> > > can just copy data directly.
> >
> > This is a fairly common operation for us, but also just chunks of a map
> > value pointer. So would want a start/end offset bytes. Often our
> > map values have extra data that user space doesn't need or care about.
> 
> Huh? It's just a pointer, you can point inside the MAP_VALUE today,
> no? And you already have extra_sz. So this should work:
> 
> struct my_data *d = bpf_map_lookup_elem(&my_map, &my_key);
> if (!d) return 0;
> 
> bpf_ringbuf_reserve_extra(&rb, 100, 0, d + 100, 200);
> 
> And you'll be copying [100, 200) range into ringbuf. No?

Yep that works fine.

> 
> >
> > >
> > > Thoughts?
> >
> > I think I missed the point.
> 
> I think you misunderstood what bpf_ringbuf_reserve_extra() is going to
> do. And we might differ in evaluating how easy it is to handle
> chunking, both in kernel and user-space :)

Yep above clarifies the ringbuf_reserve_extra() proposal thanks. And
having done the work to handle chunking I don't think its terribly
difficult, but agree non-trivial. Once done though its actually
fairly flexible and handles use cases like array of strings and
variable data size structures (TLVs ;) well and seemingly
efficiently.

> 
> >
> > >
> > > -- Andrii

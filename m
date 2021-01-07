Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5003B2EE9BC
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 00:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbhAGX0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 18:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbhAGX0w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 18:26:52 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED3C0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 15:26:12 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d37so7739665ybi.4
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/XQxB7tpM38vIOtR+ginb3+15vndbsJT1cB8SEGYJQ=;
        b=jUPFiYWYgSbZUY8WRtiR1Fbl+/wjDGeU3aIAPyRniDxkT7tx46pw+GyEiStaJ8pQWd
         hJ+qejh7NwnHXeWjhRhvjOxKG4Y+BqF2ZMV+vBCkIJ2gbaZGWkE7Him5JZcAR5YYxo8I
         ovxNHj6ZQ1XqTKlTEO2WM4N61ayvoFpVm+F+6CRk346LJtE68eIGA2648uYWo6N4AIDH
         PJVI9tNznFL1Rclmgfxd52iqeSiZ3SyGYMUnx5+LxYxQsrnrFwuLidpnK9ngu9XW8Bfg
         81DwPyfVz2IqoW4gw8LmR8iqQ9YZc4KEXhBaGKoFzO+lmFQOWnTLBwaR+Mb1nOxHpFEm
         vZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/XQxB7tpM38vIOtR+ginb3+15vndbsJT1cB8SEGYJQ=;
        b=TqQ8hA0PtxtikzRHtOlx+qiNGiLEDPiegdf/sGjtZKE8hx5baVAqd1g2bRdX/6h2zD
         ITBHyJFLSn8OROBIaoSXmT7CreD+EP8jElC/DtQxhBclVOvsuQxhdgr/n7SI6tumTZeM
         GP3U4p7+ZmXLyQG8d9VcmI5vM0o8ANu0tm3sMVxD0akI4oKRLi5KyKRcxi2Dcj/Rw+I7
         qKBOc98HS0Lxd4dqQj1CnFBO3B8xHiStlu52b/HYMFfPid12Ws0Vzy+v3Ly/koOoEWiG
         tmTXKS21qdjV3xblccl8xd+Mq0Uk2TWamBme7pFPdxJrSBI33wLr6pSX/yItRM//dtvc
         v3Vw==
X-Gm-Message-State: AOAM532sv7M8nldEPNLqDh7QPaKz3dov2Qe3IGpK0de8OPmBnugPRJ1z
        zGUphgVUMyPcRGpfzk6Nj4/G7GvDoch7Zcvw4xEga2OT2lA=
X-Google-Smtp-Source: ABdhPJxm2GzPOynMQN4EfbkgmrGDMo8Igm0+lIbg8KXJwHAomxaAOXZlYGI+8O9W8V/88ydeYrExnu8BkNMNfy2g2Lw=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr1782167ybj.347.1610061971778;
 Thu, 07 Jan 2021 15:26:11 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
 <alpine.LRH.2.23.451.2101072226350.6677@localhost>
In-Reply-To: <alpine.LRH.2.23.451.2101072226350.6677@localhost>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jan 2021 15:26:01 -0800
Message-ID: <CAEf4BzY80g3fEvK02EktY-jvCJ8cBPLuEUdRfP80OnU2eiavnA@mail.gmail.com>
Subject: Re: BPF ring buffer variable-length data appending
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 2:55 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Thu, 7 Jan 2021, Andrii Nakryiko wrote:
>
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
> >
> >
> > So the main problem with this is that when probe_read fails, we fail
> > reservation completely(internally we'd just discard ringbuf sample).
> > Is that OK? Or is it better to still reserve fixed-sized part and
> > zero-out the variable-length part? We are combining two separate
> > operations into a single API, so error handling is more convoluted.
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
>
> I ran into a variation of this problem with the ksnoop tool [1]. I'd hoped
> to use ringbuf, but the problem I had was I needed to store a series of N
> strings into a buffer, and for each I needed to specify a maximum size (for
> bpf_snprintf_btf()).  However it was entirely possible that the
> strings would be a lot smaller, and they'd be copied one after the other,
> so while I needed to reserve a buffer for those N strings of
> (N * MAX_STRINGSIZE) size as the worst case scenario, it would likely be a
> lot smaller (the sum of the lengths of the N strings plus null
> termination), so there was no need to commit the unused space.  I ended up
> using a BPF map-derived string buffer and perf events to send the events
> instead (the code for this is ksnoop.bpf.c in [1]).

Yes, you could have used ringbuf as well, just replace
bpf_perf_event_output() with bpf_ringbuf_output().

>
> So all of this is to say that I'm assuming along with the reserve_extra()
> API, there'd need to be some sort of bpf_ringbuf_submit_extra(ringbuf,
> flags, extra_size) which specifies how much of the extra space was used?
> If that's the case I think this approach makes ringbuf usable for my
> scenario; the string buffer would effectively all be considered extra
> space, and we'd just submit what was used.

Not really, there is no need for bpf_ringbuf_submit_extra(), normal
submit will do. See definition of bpf_ringbuf_reserve_extra(), it
already expects the caller to specify how much extra (extra_sz) bytes
to append after the fixed-size part. Why would it return this again to
you?

>
> However I _think_ you were suggesting above combining the probe read and
> the extra reservation as one operation; in my case that wouldn't work
> because the strings were written directly by a helper (bpf_snprintf_btf())
> into the target buffer. It's probably an oddball situation of course, but
> thought I'd better mention it just in case. Thanks!

Not sure why that wouldn't work. You'd use your struct trace's buffer
and correct size of accumulated strings as the last two params to
bpf_ringbuf_reserve_extra(). I have a feeling that we are not on the
same page yet :)

>
> Alan
>
> [1] https://lore.kernel.org/bpf/1609773991-10509-1-git-send-email-alan.maguire@oracle.com/

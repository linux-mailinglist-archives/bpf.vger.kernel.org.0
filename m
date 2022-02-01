Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA64A5757
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 07:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiBAGqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 01:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiBAGqF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 01:46:05 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47705C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:46:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q204so19950795iod.8
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKXQllTgkw6x+PZBxEMZeyV5chqnFD3N98BoA3ZCWQs=;
        b=TDjL/w4/sfVqCKxzp1mpaaxqHnNxLn2zQZQq28tCgP2II8mvSNQ7mci5PQ+bgbDATf
         dQe78WylhDxbJqmH294i4NRZpSmV76zO2VlCET/wp20HgbyKm2HAfe3XZjRA/EPIxwPD
         sO4oGck7Qa2f3PADL0cOVyHkEWE2JBqBLOvmTfryxhm0ORcw+K9q+K4LIsfVM+DFsE3q
         XdPzh4Ky4Ydpp2hxqKhKVkfQtsOQP2XvXSEMvYiYxbAyncozktIb1xHL4DC0GL290RRQ
         jB4YXAisUS/uik0Nb3/Ps5U2IhX41x8Djc830fUNfOSB11kEkD0xx3MXtUE8LQMMXvv6
         FoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKXQllTgkw6x+PZBxEMZeyV5chqnFD3N98BoA3ZCWQs=;
        b=IpKVkpzndeuxRcmnOWat7sfMpvH5CqknXzQPJbqjb9ZuFRW1WMqkwSktXfLlpU+m4C
         6NGEJtO8XbF5Lj8HiKM32YzMciYq5DpqPdleui9+p4Ek7APC9nT0Gn6UjYDldvwVmR/i
         Fk9OVIZsXxSU8wDfiBWt7vj+OTjz+b/As9jtfJ2T/cjItMo6GeWKMbwQog6faePmQTnC
         miVl8ND3w/TqDJTSmAWBbfhJXmeN3GyqLKGVqS/nksKYK/pAXSrXftNf8byN8DLlGbUX
         ZBxZjDK8IKbOEYfhHy9geaepv+pX7tYBs3LUyHwmZHg3nnsFr/e9yfhz7o//E787j/1A
         Lz5Q==
X-Gm-Message-State: AOAM533cVi9OaLOSwPEJYy9eFDc1bWor7I4pWwY94QzfnspR1avlyd4n
        jS1kMgUtGbRZYoFvG/jR9+UtoFUbK55i0YwrF1c=
X-Google-Smtp-Source: ABdhPJxveDBwzchgdtUU+04EJm9/k6dK1eooWIIJIzsJj3I0CErFtBRpwmpkuGGoI/0nO8sYTkfoZIeVFkIPLirToRE=
X-Received: by 2002:a05:6602:2e88:: with SMTP id m8mr6623765iow.79.1643697964481;
 Mon, 31 Jan 2022 22:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com> <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
In-Reply-To: <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 22:45:53 -0800
Message-ID: <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 9:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 26, 2022 at 1:48 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > Allow users to attach a 64-bits cookie to a BPF program when link it
> > to fentry, fexit, or fmod_ret of a function.
> >
> > This changeset includes several major changes.
> >
> >  - Add a new field bpf_cookie to struct raw_tracepoint, so that a user
> >    can attach a cookie to a program.
> >
> >  - Store flags in trampoline frames to provide the flexibility of
> >    storing more values in these frames.
> >
> >  - Store the program ID of the current BPF program in the trampoline
> >    frame.
> >
> >  - The implmentation of bpf_get_attach_cookie() for tracing programs
> >    to read the attached cookie.
>
> flags, prog_id, cookie... I don't follow what's going on here.
>
> cookie is supposed to be per link.
> Doing it for fentry only will be inconvenient for users.
> For existing kprobes there is no good place to store it. iirc.

Hm... are you talking about current kprobes? We already have
bpf_cookie support for them. We store it in the associated perf_event,
it's actually pretty convenient.

> For multi attach kprobes there won't be a good place either.

As Jiri mentioned, for multi-attach kprobes the idea was to keep a
sorted array of ips and associated cookies to do log(N) search in
bpf_get_attach_cookie() helper.

For multi-attach fentry, we could use the same approach if we let
either bpf_link or bpf_prog available to fentry/fexit program at
runtime. Kui-Feng seems to be storing prog_id in BPF trampoline
generated code, I don't think that's the best approach, it would be
probably better to store bpf_link or bpf_prog pointer, whichever is
more convenient. I think we can't attach the same BPF program twice to
the same BPF trampoline, so storing this array of ip -> cookie
mappings in bpf_prog would work (because the mapping is unique), but
might be a more cumbersome. Storing bpf_link is conceptually better,
probably, but I haven't thought through if there are any problems if
we support updating bpf_link's underlying program.

But keep in mind, this patch set is basically an RFC to arrive at the
best approach that will also be compatible with multi-attach
fentry/fexit. Though it seems like we'll first need to establish the
need for bpf_cookie (I thought that was not controversial, my bad),
which is fine, see below.

> I think cookie should be out of band.
> Maybe lets try a resizable map[ip]->cookie and don't add
> 'cookie' arrays to multi-kprobe attach,
> 'cookie' field to kprobe, fentry, and other attach apis.
> Adding 'cookie' to all of them is quite a bit of churn for kernel
> and user space.

We don't need all BPF program types, but anything that's useful for
generic tracing is much more powerful with cookies. We have them for
kprobe, uprobe and perf_event programs already. For multi-attach
kprobe/kretprobe and fentry/fexit they are essentially a must to let
users use those BPF program types to their fullest.

> I think resizable bpf map[u64]->u64 solves this problem.
> Maybe cookie isn't even needed.
> If the bpf prog can have a clean map[bpf_get_func_ip()] that
> doesn't have to be sized up front it will address the need.

You mean for users to maintain their own BPF map and pre-populated it
before attaching their BPF programs? Or did I misunderstand?

Sizing such a BPF map is just one problem.

Figuring out the correct IP to use as a key is another and arguably
bigger hassle. Everyone will be forced to consult kallsyms, even if
their use case is simple and they don't need to parse kallsyms at all.
Normally, for fentry/fexit programs, users don't even need kallsyms,
as vmlinux BTF is used to find BTF ID and that's enough to load and
attach fentry/fexit.

And while for kprobe/fentry programs it's inconvenient but can be done
with a bunch of extra work, for uprobes there are situations where
it's impossible to know IP at all. One very specific example is USDTs
in shared library. If user needs to attach to USDT defined in a shared
library across *any* PID (current and future), it's impossible to do
without BPF cookie support, because each different process will load
shared library at unknown base address, so it's impossible to
calculate upfront any absolute IP to look up by. This is the reason
BCC allows to attach to USDTs in shared library only for one specific
process (i.e., PID has to be specified in such a case).


Or did you propose to maintain such IP -> cookie mapping inside the
kernel during bpf_link creation? I think the key would have to be at
least a (link ID, IP) pair, no? The question is whether it's going to
be more convenient to get link ID and IP for all supported BPF
programs at runtime and whether it will cause the same or more amount
of churn?

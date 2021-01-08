Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019E62EED35
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 06:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbhAHFom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 00:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbhAHFol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 00:44:41 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004FC0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 21:44:01 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id j21so2133542oou.11
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 21:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/UuLDy+VMfg2CKBz1zHEOw1gXEfxxSoXAsPrXp7HrZs=;
        b=QPseVHQ83ZGkr9FtA0boYFs2RqK66nSgTkBnYXtt6yXhRU6r6CXNLgsLDnA3cy6bXl
         lsbZ8/9/CYTNKFZtdJbTY4yeGA4H8bT/49ags4PZ0TZa25pnMaZLPXGC0H8Mh2fF/cNw
         vaMu2qPpvCF0xvSCsc1EGFguMd+Rd53Y2zvm9F2mremTj9nbrkLgGtXSlO2SsU+vc/WS
         emz/ZsuqVBJ9v/fQGqYE5wPK/k5mYtCgswkIxuNIXUIE9WMOhc1v0M2Lqq09YLlS3z+F
         ezvSlEIY2AJEYSM0F8+uRdrVkK/y9TTp2z5GzmG8ajK2J9v6Mmkw0wDCbTucaIerWsv6
         C0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/UuLDy+VMfg2CKBz1zHEOw1gXEfxxSoXAsPrXp7HrZs=;
        b=Emq4ai4pXvGmxjalfKwt4aaUQhp/n+wPcPLkPOg/OhWX8izu8tzJBOf9sGrA5BnwN7
         UHidA++0pZfrBL5t+zb+FiU6dy9bpnvKaoXLlcwAgJjUE0KXp7jcu7M83IkB5G4nxKmu
         v1D8A3TSiwQmUEMEGzyHtPovLBSH+k4i6BesXV1UySpsLOxLm2TiL2Wa/TObwcKFW2SV
         DmBOVQTdRGOXhj+m+5MwOEmbKeofjMG68UmIYD0QGoMSpN+oCCkAIf0ueU5ZXP1sFvyl
         bogpxpqMOzJtr1888Jwa9ON144avCJkj8KUe4VQarfQLVsCM2DIoV7EAS14G1KuNSzIq
         +OEQ==
X-Gm-Message-State: AOAM5327FmBjtWNx9SgAvjSn5lxrObTqxq+Gdtt73L//Gt7j3UemS2k/
        VRCYjltic42vgxCoT8G3pkA=
X-Google-Smtp-Source: ABdhPJwQJf5OvfYdL4H11y/sKhEBSA8dzPXZuQleoDCN/0aDDSBLZpyYH1MMTZGg1iFcU7zCMmKGtg==
X-Received: by 2002:a4a:9f47:: with SMTP id d7mr3350420ool.23.1610084640999;
        Thu, 07 Jan 2021 21:44:00 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id f145sm1635199oob.18.2021.01.07.21.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 21:44:00 -0800 (PST)
Date:   Thu, 07 Jan 2021 21:43:50 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ff7f1167259b_36910208ef@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
Subject: RE: BPF ring buffer variable-length data appending
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> We discussed this topic today at office hour. As I mentioned, I don't
> know the ideal solution, but here is something that has enough
> flexibility for real-world uses, while giving the performance and
> convenience of reserve/commit API. Ignore naming, we can bikeshed that
> later.

Missed office hours today, dang sounds interesting. Apoligies if I'm
missing some context.

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
> 

Is this a way to increase the reserved space? I'm a bit fuzzy on the
details here. But what happens if something else has done another
reserve? Then it fails I guess?

So consider,

CPU0                   CPU1

bpf_ringbuf_reserve()
                       bpf_ringbuf_reserve()
bpf_ringbuf_reserve_extra()

Does that *_reserve_extra() fail then? If so it seems very limited
from a use perspective. Most the systems we work with will fail more
often than not I think.

If the above doesn't fail, I'm missing something about how userspace
can know where that buffer is without a scatter-gather list.

> 
> So the main problem with this is that when probe_read fails, we fail
> reservation completely(internally we'd just discard ringbuf sample).
> Is that OK? Or is it better to still reserve fixed-sized part and
> zero-out the variable-length part? We are combining two separate
> operations into a single API, so error handling is more convoluted.

My $.02 here. Failing is going to be ugly and a real pain to deal
with. I think best approach is reserve a fixed-sized buffer that
meets your 99% case or whatever. Then reserve some overflow buffers
you can point to for the oddball java application with a million
strings. Yes you need to get more complicated in userspace to manage
the thing, but once that codes written everything works out.

Also I think we keep the kernel simpler if the BPF program just
does another reserve() if it needs more space so,

 bpf_ringbuf_reserve()
 copy
 copy
 ENOMEM <- buff is full,
 bpf_ringbuf_reserve()
 copy
 copy
 ....

Again userspace needs some logic to join the two buffers but we
could come up with some user side convention to do this. libbpf
for example could have a small buffer header to do this if folks
wanted.  Smart BPF programs can even reserve a couple buffers
up front for the worse case and recycle them back into its
next invocation, I think.

Conceptually, what is the difference between a second reserve
as compared to reserve_extra()?

> 
> 
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

+1 agree

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

+1

> 
> But offloading that preparation to a BPF program bypasses all these
> error handling and memory layout questions. It will be up to a BPF
> program itself. From a kernel perspective, we just append a block of
> memory with known (at runtime) size.

Still missing how this would be different from multiple reserve()
calls. Its not too hard to join user space buffers I promise ;)

> 
> As a more restricted version of bpf_ringbuf_reserve_extra(), instead
> of allowing reading arbitrary kernel or user-space memory in
> bpf_ringbuf_reserve_extra() we can say that it has to be known and
> initialized memory (like MAP_VALUE pointer), so helper knows that it
> can just copy data directly.

This is a fairly common operation for us, but also just chunks of a map
value pointer. So would want a start/end offset bytes. Often our
map values have extra data that user space doesn't need or care about.

> 
> Thoughts?

I think I missed the point.

> 
> -- Andrii

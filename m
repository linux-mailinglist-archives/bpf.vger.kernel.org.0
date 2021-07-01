Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0549B3B8EBE
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhGAIVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAIVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Jul 2021 04:21:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF5C061756
        for <bpf@vger.kernel.org>; Thu,  1 Jul 2021 01:18:51 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g22so6555975iom.1
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcqmISKA385xJp8CFiTuVeDu3WrYH5PsOS49vQZ/pew=;
        b=cOT520El7XXRvTn25OoIWz/UuqkPPkjH3NCMXTGBAJiK759W02pE6ZmxipH8ekHlOD
         8Gd1ZOX7RHeXN4gSt6FL33Wn5c/aGHzHO0mkyQ/NF/mlB/E5rgugbbKsjah61GLchFif
         B2WZTKNvY7CE7sF6IMsmXtD7GWjmOhTwWlJc3jy/HbvUssQgn9OP6pxN0q/FM4pJv9P3
         z0cDiteltn9YAgcxyAfZoXoBGE2lWr50Bv81ncJh0zHz7IqUpGPmimxalaeCZsodoZQv
         BibkjSrV8Hql4voUtxnW1kG/YNITEBEKbw2zuyQTPuFsuwHoF8HtSa/vj0RUrUzoAfEh
         4wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcqmISKA385xJp8CFiTuVeDu3WrYH5PsOS49vQZ/pew=;
        b=W0+58gW2q7r1iShJq4o+958SapcaQJkMIQyvlQG3W8ec/s898QWKcSrskFFaZ//D3x
         i55vwGyaoDOCPCiJ57dns7PEaUS+JZdUGhaqQ2nhEqFl8R78gRKDmGVtmyans0Tz59UH
         3aco7EpNntAzDxTHOi9R4642RicE1jYuqsm95q4FWY16RGhO1HKhSrmlCGDSUsrMTSEv
         +lhYIV9MPFXZRKe72GT4jaCPDaug5eFliMGxxoabgNC5JDwB0G+5QPwZaQPmjRjtADKy
         jO7C4LFATDIKp4GDnqE+iE/3TF1n/Bweq+ddOhzz1qdjxD0LhokzJbHKJjvo6lpE23yR
         +otg==
X-Gm-Message-State: AOAM530u8tiEfp6aTKfMEhPa7V7++TF9qkTCwArl6kGZFc+fkB28175F
        Jh1wp60iSCn0cQa+R1PfHgvBj8c6lh3J4/YeIu/hzw==
X-Google-Smtp-Source: ABdhPJzmsnRMNW+KNup7I1VJI/YfR1e2GJIR0KKq4TLG+YhJixWVxDnVg2IoL06uSBTngabU9pU8RCSDCUxhnTlwheM=
X-Received: by 2002:a02:ca4a:: with SMTP id i10mr12479094jal.141.1625127531023;
 Thu, 01 Jul 2021 01:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210202135002.4024825-1-jackmanb@google.com> <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava> <YNtEcjYvSvk8uknO@krava> <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava> <YNuL442y2yn5RRdc@krava> <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
 <YNxmwZGtnqiXGnF0@krava>
In-Reply-To: <YNxmwZGtnqiXGnF0@krava>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 1 Jul 2021 10:18:39 +0200
Message-ID: <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Jiri Olsa <jolsa@redhat.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 30 Jun 2021 at 14:42, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jun 30, 2021 at 12:34:58PM +0200, Brendan Jackman wrote:
> > On Tue, 29 Jun 2021 at 23:09, Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jun 29, 2021 at 06:41:24PM +0200, Jiri Olsa wrote:
> > > > On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
> > > > > On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > > > > > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> >
> > > > > > > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > > > > > > >
> > > > > > >
> > > > > > > hum, I guess not.. will check
> > > > > >
> > > > > > nope, it locks up the same:
> > > > >
> > > > > Do you mean it locks up at commit 91c960b0056 too?
> >
> > Sorry I was being stupid here - the test didn't exist at this commit
> >
> > > > I tried this one:
> > > >   37086bfdc737 bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH
> > > >
> > > > I will check also 91c960b0056, but I think it's the new test issue
> >
> > So yeah hard to say whether this was broken on PowerPC all along. How
> > hard is it for me to get set up to reproduce the failure? Is there a
> > rootfs I can download, and some instructions for running a PowerPC
> > QEMU VM? If so if you can also share your config and I'll take a look.
> >
> > If it's not as simple as that, I'll stare at the code for a while and
> > see if anything jumps out.
> >
>
> I have latest fedora ppc server and compile/install latest bpf-next tree
> I think it will be reproduced also on vm, I attached my config

OK, getting set up to boot a PowerPC QEMU isn't practical here unless
someone's got commands I can copy-paste (suspect it will need .config
hacking too). Looks like you need to build a proper bootloader, and
boot an installer disk.

Looked at the code for a bit but nothing jumped out. It seems like the
verifier is seeing a BPF_ADD | BPF_FETCH, which means it doesn't
detect an infinite loop, but then we lose the BPF_FETCH flag somewhere
between do_check in verifier.c and bpf_jit_build_body in
bpf_jit_comp64.c. That would explain why we don't get the "eBPF filter
atomic op code %02x (@%d) unsupported", and would also explain the
lockup because a normal atomic add without fetch would leave BPF R1
unchanged.

We should be able to confirm that theory by disassembling the JITted
code that gets hexdumped by bpf_jit_dump when bpf_jit_enable is set to
2... at least for PowerPC 32-bit... maybe you could paste those lines
into the 64-bit version too? Here's some notes I made for
disassembling the hexdump on x86, I guess you'd just need to change
the objdump flags:

-- 

- Enable console JIT output:
```shell
echo 2 > /proc/sys/net/core/bpf_jit_enable
```
- Load & run the program of interest.
- Copy the hex code from the kernel console to `/tmp/jit.txt`. Here's what a
short program looks like. This includes a line of context - don't paste the
`flen=` line.
```
[ 79.381020] flen=8 proglen=54 pass=4 image=000000001af6f390
from=test_verifier pid=258
[ 79.389568] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 08 00
[ 79.397411] JIT code: 00000010: 00 00 48 c7 45 f8 64 00 00 00 bf 04 00 00 00 48
[ 79.405965] JIT code: 00000020: f7 df f0 48 29 7d f8 8b 45 f8 48 83 f8 60 74 02
[ 79.414719] JIT code: 00000030: c9 c3 31 c0 eb fa
```
- This incantation will split out and decode the hex, then disassemble the
result:
```shell
cat /tmp/jit.txt | cut -d: -f2- | xxd -r >/tmp/obj && objdump -D -b
binary -m i386:x86-64 /tmp/obj
```

--

Sandipan, Naveen, do you know of anything in the PowerPC code that
might be leading us to drop the BPF_FETCH flag from the atomic
instruction in tools/testing/selftests/bpf/verifier/atomic_bounds.c?

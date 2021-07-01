Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D73B9069
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhGAKTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 06:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235939AbhGAKTO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 06:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625134603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3sKDRuSMeLomK82BHUwYIxcC2r0lOgJd1SJHmFm4GE=;
        b=D21MrgbgIfJcWEAur3XS8aYDEXYU3c2z+8m7/T77qkQZ5+WY/UNP95oHc95hjTZB1dOTbz
        GF8hzFSDWvMjnKNMB2nUntY8QMmw0TuukD9vig9bcE1bzmx5fyebCI9nf2aNAW88b51OKV
        aSbPnhdwSpwlVxeKFBczarrvIFPZy+0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-EbaSWfqrOxuQ8w_YsEoKxA-1; Thu, 01 Jul 2021 06:16:42 -0400
X-MC-Unique: EbaSWfqrOxuQ8w_YsEoKxA-1
Received: by mail-ej1-f70.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso1932549ejp.3
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 03:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3sKDRuSMeLomK82BHUwYIxcC2r0lOgJd1SJHmFm4GE=;
        b=ArUk8efTnRw+cSPQsUYJpUyTvlCAaTCukrS7hqFunXCXqMg0swVVavIZ9pG/laFvxK
         BWB6pFgoa71P4kpKfOEi7BDLLyCPaff90SlznRwCYpI+m01GhfVsrIVAtLTHuBZI9rDo
         LLqVNLR0mZjfcOOLAK8D+9fFukIRrFQCPA6R73NuyYlOqv7Whf2/y3K6HwV2iMpQxEot
         cjSsHTRqVdmD1jP3GevcGoa2cBaFSR9eHHekJbvPJ9TXqImHGY1q1smr6H12jC6DCG5L
         +Dx00vCimHKk6HMf/Vx6eX4UufXcfP1wlEVVb7S+N5bemmSpeEBIW8ArCxdz0tSrqcy5
         NX0Q==
X-Gm-Message-State: AOAM532VRs5awDiDOEoV5lHbhfLqyFMFR/H0kMdGQuftitDKxM9Nv8Uk
        2GWsiBG/gGyHMSMBCv2HpSNmChQtxsUBU21zBba/YTwGEgZ5H3w/I0QzdPe+2I8QegTPMz/es3R
        BH1T4bUzkDYir
X-Received: by 2002:a05:6402:520c:: with SMTP id s12mr54484291edd.357.1625134600370;
        Thu, 01 Jul 2021 03:16:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRJAZQPIzfqv/EszLsvkJpAG8mWwKTbWPHYsqPS44RT3awO+9ATUYAoKZelnWXnNq29MtqTg==
X-Received: by 2002:a05:6402:520c:: with SMTP id s12mr54484263edd.357.1625134600168;
        Thu, 01 Jul 2021 03:16:40 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id b15sm2046767eja.82.2021.07.01.03.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:16:39 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:16:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Sandipan Das <sandipan@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
Message-ID: <YN2WBP9kjGQxHrKS@krava>
References: <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava>
 <YNtEcjYvSvk8uknO@krava>
 <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava>
 <YNuL442y2yn5RRdc@krava>
 <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
 <YNxmwZGtnqiXGnF0@krava>
 <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 01, 2021 at 10:18:39AM +0200, Brendan Jackman wrote:
> On Wed, 30 Jun 2021 at 14:42, Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Jun 30, 2021 at 12:34:58PM +0200, Brendan Jackman wrote:
> > > On Tue, 29 Jun 2021 at 23:09, Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 29, 2021 at 06:41:24PM +0200, Jiri Olsa wrote:
> > > > > On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
> > > > > > On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > > > > > > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> > >
> > > > > > > > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > > > > > > > >
> > > > > > > >
> > > > > > > > hum, I guess not.. will check
> > > > > > >
> > > > > > > nope, it locks up the same:
> > > > > >
> > > > > > Do you mean it locks up at commit 91c960b0056 too?
> > >
> > > Sorry I was being stupid here - the test didn't exist at this commit
> > >
> > > > > I tried this one:
> > > > >   37086bfdc737 bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH
> > > > >
> > > > > I will check also 91c960b0056, but I think it's the new test issue
> > >
> > > So yeah hard to say whether this was broken on PowerPC all along. How
> > > hard is it for me to get set up to reproduce the failure? Is there a
> > > rootfs I can download, and some instructions for running a PowerPC
> > > QEMU VM? If so if you can also share your config and I'll take a look.
> > >
> > > If it's not as simple as that, I'll stare at the code for a while and
> > > see if anything jumps out.
> > >
> >
> > I have latest fedora ppc server and compile/install latest bpf-next tree
> > I think it will be reproduced also on vm, I attached my config
> 
> OK, getting set up to boot a PowerPC QEMU isn't practical here unless
> someone's got commands I can copy-paste (suspect it will need .config
> hacking too). Looks like you need to build a proper bootloader, and
> boot an installer disk.
> 
> Looked at the code for a bit but nothing jumped out. It seems like the
> verifier is seeing a BPF_ADD | BPF_FETCH, which means it doesn't
> detect an infinite loop, but then we lose the BPF_FETCH flag somewhere
> between do_check in verifier.c and bpf_jit_build_body in
> bpf_jit_comp64.c. That would explain why we don't get the "eBPF filter
> atomic op code %02x (@%d) unsupported", and would also explain the
> lockup because a normal atomic add without fetch would leave BPF R1
> unchanged.
> 
> We should be able to confirm that theory by disassembling the JITted
> code that gets hexdumped by bpf_jit_dump when bpf_jit_enable is set to
> 2... at least for PowerPC 32-bit... maybe you could paste those lines
> into the 64-bit version too? Here's some notes I made for
> disassembling the hexdump on x86, I guess you'd just need to change
> the objdump flags:
> 
> -- 
> 
> - Enable console JIT output:
> ```shell
> echo 2 > /proc/sys/net/core/bpf_jit_enable
> ```
> - Load & run the program of interest.
> - Copy the hex code from the kernel console to `/tmp/jit.txt`. Here's what a
> short program looks like. This includes a line of context - don't paste the
> `flen=` line.
> ```
> [ 79.381020] flen=8 proglen=54 pass=4 image=000000001af6f390
> from=test_verifier pid=258
> [ 79.389568] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 08 00
> [ 79.397411] JIT code: 00000010: 00 00 48 c7 45 f8 64 00 00 00 bf 04 00 00 00 48
> [ 79.405965] JIT code: 00000020: f7 df f0 48 29 7d f8 8b 45 f8 48 83 f8 60 74 02
> [ 79.414719] JIT code: 00000030: c9 c3 31 c0 eb fa
> ```
> - This incantation will split out and decode the hex, then disassemble the
> result:
> ```shell
> cat /tmp/jit.txt | cut -d: -f2- | xxd -r >/tmp/obj && objdump -D -b
> binary -m i386:x86-64 /tmp/obj
> ```

that's where I decided to write to list and ask for help before
googling ppc assembly ;-)

I changed the test_verifier to stop before executing the test
so I can dump the program via bpftool:

	[root@ibm-p9z-07-lp1 bpf-next]# bpftool prog dump xlated id 48
	   0: (b7) r0 = 0
	   1: (7b) *(u64 *)(r10 -8) = r0
	   2: (b7) r1 = 1
	   3: (db) r1 = atomic64_fetch_add((u64 *)(r10 -8), r1)
	   4: (55) if r1 != 0x0 goto pc-1
	   5: (95) exit

	[root@ibm-p9z-07-lp1 bpf-next]# bpftool prog dump jited id 48
	bpf_prog_a2eb9104e5e8a5bf:
	   0:   nop
	   4:   nop
	   8:   stdu    r1,-112(r1)
	   c:   std     r31,104(r1)
	  10:   addi    r31,r1,48
	  14:   li      r8,0
	  18:   std     r8,-8(r31)
	  1c:   li      r3,1
	  20:   addi    r9,r31,-8
	  24:   ldarx   r10,0,r9
	  28:   add     r10,r10,r3
	  2c:   stdcx.  r10,0,r9
	  30:   bne     0x0000000000000024
	  34:   cmpldi  r3,0
	  38:   bne     0x0000000000000034
	  3c:   nop
	  40:   ld      r31,104(r1)
	  44:   addi    r1,r1,112
	  48:   mr      r3,r8
	  4c:   blr

I wanted to also do it through bpf_jit_enable and bpf_jit_dump, but I need to check
the setup, because I can't set bpf_jit_enable to 2 at the moment.. might take some time

	[root@ibm-p9z-07-lp1 bpf-next]# echo 2 > /proc/sys/net/core/bpf_jit_enable 
	-bash: echo: write error: Invalid argument

jirka

> 
> --
> 
> Sandipan, Naveen, do you know of anything in the PowerPC code that
> might be leading us to drop the BPF_FETCH flag from the atomic
> instruction in tools/testing/selftests/bpf/verifier/atomic_bounds.c?
> 


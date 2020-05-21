Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D781A1DC41E
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 02:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgEUAng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 20:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgEUAng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 20:43:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D55C061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 17:43:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu7so2135060pjb.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HS1maZuWnBXaGu3gD+7B6DdCr/3Fx7aMCbwDkTOo3Gc=;
        b=rQzSp+c1mPRqN/mz7nkR5UUFFR0tcwED1cDbLVBRElNqqE+mpvIeaYss22IE7kTzTL
         GImjgshiRnrG45KIn2qHUYsebQbeXeM7NRHVsPjzMjgWnYJUufSZlIQjMa2/8OAAjLlN
         7tavbKTz/fHk80T0+/hY+AZojLhTM7vX4oZlkVcogH7exkszwpZtLARq70zJGX1uPutY
         tdBUGaQni8hEM58ZQ4usXfuePyEu8fh5wi1TY2l19KqeyjSKVAG+o62p2Bd2ZubmReHw
         AZjnI4i+EFSjFO8tFxIBCFkQy2xv5w0D22ALHx7rp+Vk2H2txrZhZSos0zVdzsX2FVL5
         vQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HS1maZuWnBXaGu3gD+7B6DdCr/3Fx7aMCbwDkTOo3Gc=;
        b=XT/6gz4g7y8nmDqBhefXN6QvLtHDkCg2MX5womhPoQxTDJ11hxusco6DKO6vlSjEk4
         63x9RY4RxJuLiNxh4z0cjNtSM3FZ5pbBId+23BdpwAzrigcEeWEtti1JdbqtujO71I2y
         0hVwPS4JPgCS1fyTN0red+O04E9UC1iqnric0CUxwym9ZsbfIpElpS6wrirK4higc7zy
         VnfikwX/QkxbfdoMtNyblhZVd7SuepOAQ+2MOQgyxMmdAQl96evQ9IvfSZWrELTD5oC3
         R9HGmY/26vduS/sgbq7L2/l0wzHnBiLFJqV/kR7fBrYjZ80x5rp6D72NLSCuzLHakM64
         7smA==
X-Gm-Message-State: AOAM533/NTPKrG8l1RaffV3XXivaKjI7DFRJYEhyyrA9tLSX5MU9e/5j
        tn6xcuW6h26rpQ04wd7ZwT8=
X-Google-Smtp-Source: ABdhPJxVwS0lGjHT7KKag75D5pbWfBM1KdGARKVQ/TSDXwUpQ4vDrxRgVfawaKs6E0R8UcVg0gkQ2Q==
X-Received: by 2002:a17:902:a408:: with SMTP id p8mr7355383plq.36.1590021815928;
        Wed, 20 May 2020 17:43:35 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e680])
        by smtp.gmail.com with ESMTPSA id n23sm2776842pjq.18.2020.05.20.17.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:43:34 -0700 (PDT)
Date:   Wed, 20 May 2020 17:43:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [Ksummit-discuss] [TECH TOPIC] seccomp feature development
Message-ID: <20200521004332.we4m2vpmkzrb57x2@ast-mbp.dhcp.thefacebook.com>
References: <202005200917.71E6A5B20@keescook>
 <20200520163102.GZ23230@ZenIV.linux.org.uk>
 <202005201104.72FED15776@keescook>
 <CAHk-=wierGOJZhzrj1+R18id-WdfmK=eWT9YfWdCfMvEO+jLLg@mail.gmail.com>
 <202005201151.AFA3C9E@keescook>
 <20200520221256.tzqkjpeswv3d6ne2@ast-mbp.dhcp.thefacebook.com>
 <202005201540.EF1BD18B44@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005201540.EF1BD18B44@keescook>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 04:39:20PM -0700, Kees Cook wrote:
> On Wed, May 20, 2020 at 03:12:56PM -0700, Alexei Starovoitov wrote:
> > On Wed, May 20, 2020 at 12:04:04PM -0700, Kees Cook wrote:
> > > On Wed, May 20, 2020 at 11:27:03AM -0700, Linus Torvalds wrote:
> > > > Don't make this some kind of abstract conceptual problem thing.
> > > > Because it's not.
> > > 
> > > I have no intention of making this abstract (the requests for expanding
> > > seccomp coverage have been for only a select class of syscalls, and
> > > specifically clone3 and openat2) nor more complicated than it needs to be
> > > (I regularly resist expanding the seccomp BPF dialect into eBPF).
> > 
> > Kees, since you've forked the thread I'm adding bpf mailing list back and
> > re-iterating my point:
> > ** Nack to cBPF extensions **
> 
> Yes, I know. I agreed[1] with you on this point.
> 
> > How that is relevant?
> > You're proposing to add copy_from_user() to selected syscalls, like clone3,
> > and present large __u32 array to cBPF program.
> > In other words existing fixed sized 'struct seccomp_data' will become
> > either variable length or jumbo fixed size like one page.
> > In the fomer case it would mean that cBPF would need to be extended
> > with variable length logic. Which in turn means it will suffer from
> > spectre v1 issues.
> 
> I don't expect to need to do anything with variable lengths in the
> seccomp BPF dialect. As I said in the other thread, if we are faced with
> design trade-offs that require extending the seccomp filter language, we
> would switch to eBPF.
> 
> > If you go with latter approach of presenting cBPF with giant
> > 'struct seccomp_data + page' that extra page would need to be zeroed out
> > before invocation of bpf program which will make seccomp even less usable
> > that it is today. Currently it's slow and unusable in production datacenter.
> 
> Making universal declarations based on your opinion does not help
> convince people of your position. Saying it's "unusable in production
> datacenter" is perhaps true for you, but hardly true for the many
> datacenters that do use it.

The datacenter that went with full bypass of kernel storage and networking
subsystems where application don't do many syscalls per second any more ?
Sure. In such cases extreme seccomp overhead is irrelevant.
Just like kpti and retpoline overhead.

> Additionally, we're obviously not interested in making seccomp _slower_.
> The entire point of an investigation of the design is to examine our
> options and find the right solution.
> 
> > People suggested for years to adopt eBPF in seccomp to accelerate it,
> > but, as you confessed, you resisted and sounds like now you want to
> > implement seccomp specific syscall bitmask?
> 
> Yes -- because it's an order of magnitude faster than even a single
> instruction BPF seccomp filter. The vast majority of seccomp filters need
> nothing more than a single yes/no, and right now the bulk of processing
> time is spent running the BPF filter. I would prefer to avoid BPF
> entirely where possible for seccomp.

Are you running in interpreted mode? Otherwise above statement is nonsense or
you haven't done eBPF benchmarking in long time. JITed eBPF has exact same
speed as kernel C code. Even extreme use cases of bpf programs with single
'return 0' instruction are being optimized into minimal number of native
instructions.
So with above you're saying that giant bitmask of syscalls in C code
is faster than 'int foo() { return 0; }' in C code ? Simply absurd.
You realize that eBPF is processing tens of millions of packets per second
and folks measure the overhead in nanoseconds.
Indirect call and retpoline overhead was removed from a lot bpf use cases
in networking specifically because every nanosecond counts.

> 
> > Which means more kernel code, more bugs, more security issues.
> 
> Right. This is a solid design principle, and one I agree with: avoid
> adding code, keep things simple, everything will have bugs. And, as it
> stands, seccomp has had a significantly safer history than eBPF, largely
> due to its goal of staying as utterly small and simple as possible. I
> don't intend to discard that stance, and it's why I would rather continue
> to shield seccomp from the regularly occurring eBPF flaws.

It's subjectively safer. I argue it's enjoying smaller bug rate because
syzbots are not looking into it and it's not being actively developed.
In the year 2020 there were three verifier bugs that could have been exploited
through unpriv. All three were found by new kBdysch fuzzer. In 2019 there was
nothing. Not because people didn't try, but because syzbot reached its limit.
The pace of bpf development is accelerating. There will be more bugs found and
introduced in the verifier. Yet that doesn't stop folks to use eBPF to secure
the datacenters.
The JITs are also being developed. There are bugs in them and they affect both
cBPF and eBPF. If you're worried about that it's probably time to get rid of
cBPF from seccomp. Invent your own syscall processing thingy, fix bugs and stop
adding new features. That's the only way to reduce the bug rate. We're not
going to slow down JITs development because of seccomp.

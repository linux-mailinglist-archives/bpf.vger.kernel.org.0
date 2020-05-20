Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A421DC30B
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 01:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgETXjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgETXjY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 19:39:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433DC061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 16:39:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so2211287pgn.5
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKxmEd0cc9JnFOdDSJAY2t96ddzYOTGSRva5EGtl4sM=;
        b=k5WCTRegL4qtiRs71zAbn+o1yYFdrunCtzMnu61qwQABmg0/GIzFNa0WkCBD9u3xZf
         yvj0drwJ4TrgNEpv503jpUYD/nCqkyM6Q+yD/uU7x30EjlWYk8ZwA4D7Czhgvf+HQvjD
         n7AgloIUMkOGZWu54iKydCRmC2t+A3dwWw40A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKxmEd0cc9JnFOdDSJAY2t96ddzYOTGSRva5EGtl4sM=;
        b=uD6rhQ9RymqRKo77dAq2dyiRBd3uWTGYVQ1B6StbZvkwfpeSy0P6CXyYf31vZWtG10
         f09VfKKLHZPRvz1VnwHXdaxdMgalZCluOjM9ZsIm8jaxzhIYuyJ4MgBVy9DekOGe1IEo
         +Zh/24lsD0TMICxjMMD4j3dkvxpunMnoBjDngm6pVy1oTdQ1ZIG9qWIvo2fKYDm/znlB
         5wEjTOz9hkOqi0K/fmDPKEjtUCT8Eo6AboYW04NthY6JTGknxLEpdbP2P8hct7s9pctv
         BNwjv9BbcadL6G1rvWZHvfDXJ6rMcYu7DVIDGucx58304pkT5QGZnc8q9e52YDnV8Mwd
         1DWw==
X-Gm-Message-State: AOAM532+IG8MtdNgYI1DrA1WEzJH/5w/qJ0ZrgnFltEfvwYbvaLhrjWs
        jj25HM1+58MrorOBO3O/i/F8aYnCMltC3g==
X-Google-Smtp-Source: ABdhPJyQ3ePD22xinBBFKs4ZY83hieCkmjLI4/2NO3mxxs7+J15byFMue/V9Rx9ipe7u3fy7XNppDg==
X-Received: by 2002:a05:6a00:1490:: with SMTP id v16mr6377464pfu.173.1590017963037;
        Wed, 20 May 2020 16:39:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k30sm2915743pfh.49.2020.05.20.16.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:39:22 -0700 (PDT)
Date:   Wed, 20 May 2020 16:39:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [Ksummit-discuss] [TECH TOPIC] seccomp feature development
Message-ID: <202005201540.EF1BD18B44@keescook>
References: <202005200917.71E6A5B20@keescook>
 <20200520163102.GZ23230@ZenIV.linux.org.uk>
 <202005201104.72FED15776@keescook>
 <CAHk-=wierGOJZhzrj1+R18id-WdfmK=eWT9YfWdCfMvEO+jLLg@mail.gmail.com>
 <202005201151.AFA3C9E@keescook>
 <20200520221256.tzqkjpeswv3d6ne2@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520221256.tzqkjpeswv3d6ne2@ast-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 03:12:56PM -0700, Alexei Starovoitov wrote:
> On Wed, May 20, 2020 at 12:04:04PM -0700, Kees Cook wrote:
> > On Wed, May 20, 2020 at 11:27:03AM -0700, Linus Torvalds wrote:
> > > Don't make this some kind of abstract conceptual problem thing.
> > > Because it's not.
> > 
> > I have no intention of making this abstract (the requests for expanding
> > seccomp coverage have been for only a select class of syscalls, and
> > specifically clone3 and openat2) nor more complicated than it needs to be
> > (I regularly resist expanding the seccomp BPF dialect into eBPF).
> 
> Kees, since you've forked the thread I'm adding bpf mailing list back and
> re-iterating my point:
> ** Nack to cBPF extensions **

Yes, I know. I agreed[1] with you on this point.

> How that is relevant?
> You're proposing to add copy_from_user() to selected syscalls, like clone3,
> and present large __u32 array to cBPF program.
> In other words existing fixed sized 'struct seccomp_data' will become
> either variable length or jumbo fixed size like one page.
> In the fomer case it would mean that cBPF would need to be extended
> with variable length logic. Which in turn means it will suffer from
> spectre v1 issues.

I don't expect to need to do anything with variable lengths in the
seccomp BPF dialect. As I said in the other thread, if we are faced with
design trade-offs that require extending the seccomp filter language, we
would switch to eBPF.

> If you go with latter approach of presenting cBPF with giant
> 'struct seccomp_data + page' that extra page would need to be zeroed out
> before invocation of bpf program which will make seccomp even less usable
> that it is today. Currently it's slow and unusable in production datacenter.

Making universal declarations based on your opinion does not help
convince people of your position. Saying it's "unusable in production
datacenter" is perhaps true for you, but hardly true for the many
datacenters that do use it.

Additionally, we're obviously not interested in making seccomp _slower_.
The entire point of an investigation of the design is to examine our
options and find the right solution.

> People suggested for years to adopt eBPF in seccomp to accelerate it,
> but, as you confessed, you resisted and sounds like now you want to
> implement seccomp specific syscall bitmask?

Yes -- because it's an order of magnitude faster than even a single
instruction BPF seccomp filter. The vast majority of seccomp filters need
nothing more than a single yes/no, and right now the bulk of processing
time is spent running the BPF filter. I would prefer to avoid BPF
entirely where possible for seccomp.

> Which means more kernel code, more bugs, more security issues.

Right. This is a solid design principle, and one I agree with: avoid
adding code, keep things simple, everything will have bugs. And, as it
stands, seccomp has had a significantly safer history than eBPF, largely
due to its goal of staying as utterly small and simple as possible. I
don't intend to discard that stance, and it's why I would rather continue
to shield seccomp from the regularly occurring eBPF flaws.

> imo that's another reinvented wheel when eBPF can do it already. I don't think
> it's a good idea to add kernel code when eBPF-based solution exists and capable
> of examining any level of nested args.

Thanks to the neighboring thread here, the requirements no longer[2]
include nested args. Also, you're mixing bitmasks (to accelerate the
overwhelmingly common case) with the deep argument inspection (which is
a rare but needed case).

> > Perhaps the question is "how deeply does seccomp need to inspect?"
> > and maybe it does not get to see anything beyond just the "top level"
> > struct (i.e. struct clone_args) and all pointers within THAT become
> > opaque? That certainly simplifies the design.
> 
> clone3's 'struct clone_args' has set_tid pointer as a second level.
> I don't think that sticking to first level of pointers for this particular
> syscall will make seccomp filtering any more practical.

Yup, we all agree. :)

-Kees

[1] https://lore.kernel.org/lkml/202005191434.57253AD@keescook/
[2] https://lore.kernel.org/ksummit-discuss/20200520221256.tzqkjpeswv3d6ne2@ast-mbp.dhcp.thefacebook.com/T/#m01a045c8715cfff8399ba86171039110befecbcf

-- 
Kees Cook

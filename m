Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2248159B48
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBKVi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 16:38:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBKViZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 16:38:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so92291pfc.5;
        Tue, 11 Feb 2020 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJSY3+unP7njMIVK4X94hP/7d/d2A7Dqq9Ad7uaQNuM=;
        b=Kp+kvUFE8QBS06WMeMrPfDHf6XHJBSFjBNdpWZoNQEFuDXpQNvDlKsacoJXbKp/F0z
         7mjYdwKOaTU+l/BbI0M35AbxA4Bk+zW+knm5/w/vdR+3T1qXdCJkIIWDy0dwlbgz8NxY
         3cu40q8BNwsRHaAh+O5VbTV5B7QzT5e7tKwELBIAbIJAwytkfzTVvEKVVK86NXy4k0NS
         REEU+ySD34LlI7ixGYsC9mQzCTXJO/9Hoovi73SZQLq6iNnA2NqlEeMr+rggUykmNwU6
         3na9+7zREZUQHoLyBc88JraQMoPZNVka+XeZCODMhZqcujAlao92ta4IcvKoPzLbp0mP
         vfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJSY3+unP7njMIVK4X94hP/7d/d2A7Dqq9Ad7uaQNuM=;
        b=HXihRdvmOARFnYqFhbp3wgqcNg64kjntwnj2SyCAISENS/QhdICPBQPrSlN0QLLuCc
         F+xJUoBaZAjQCf11Lusl63x6IWc2Vef4dX0Wvz6s2dVyUTAc2aYeVv3Hk0SicgwOxeR6
         soCpl31HYvKnjjPnmG3rzMUxSPw/2cSdvKFx2qMmFOxNlDB7Cl93NWGwy20yUHntck3o
         nSLhPPMNn5JVcSMypaB6TbQTBMk50gFrb1jfX+PwIumX7FMETOR5xBF6XmIssWxbV2Mf
         RdTw95ibC/3SRkXebLGzJ2LgnNCfmbYKh9Qgd1+M6GZVXkMPwqVerHssPs3/N19xP0id
         jZ1Q==
X-Gm-Message-State: APjAAAX2Ht5HDPzhYWDlmff9wiO3JmJI7HX0T++xfXdZX+z90d62AdTU
        aT1hXOQ11dySP8BQUuV/Nro=
X-Google-Smtp-Source: APXvYqzPQNC73PGSmEbOYih8cQaHC5eGDgjAfZNnep7lcccZ066rjEwUFgQM6K61/xXQOktcYcoP3g==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr5108673pfd.70.1581457103385;
        Tue, 11 Feb 2020 13:38:23 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:aeb4])
        by smtp.gmail.com with ESMTPSA id d14sm4447685pjz.12.2020.02.11.13.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 13:38:22 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:38:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
Message-ID: <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp>
 <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
 <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 09:33:49PM +0100, Jann Horn wrote:
> >
> > Got it. Then let's whitelist them ?
> > All error injection points are marked with ALLOW_ERROR_INJECTION().
> > We can do something similar here, but let's do it via BTF and avoid
> > abusing yet another elf section for this mark.
> > I think BTF_TYPE_EMIT() should work. Just need to pick explicit enough
> > name and extensive comment about what is going on.
> 
> Sounds reasonable to me. :)

awesome :)

> > Locking rules and cleanup around security_blah() shouldn't change though.
> > Like security_task_alloc() should be paired with security_task_free().
> > And so on. With bpf_sk_storage like logic the alloc/free of scratch
> > space will be similar to the way socket and bpf progs deal with it.
> >
> > Some of the lsm hooks are in critical path. Like security_socket_sendmsg().
> > retpoline hurts. If we go with indirect calls right now it will be harder to
> > optimize later. It took us long time to come up with bpf trampoline and build
> > bpf dispatcher on top of it to remove single indirect call from XDP runtime.
> > For bpf+lsm would be good to avoid it from the start.
> 
> Just out of curiosity: Are fexit hooks really much cheaper than indirect calls?
> 
> AFAIK ftrace on x86-64 replaces the return pointer for fexit
> instrumentation (see prepare_ftrace_return()). So when the function
> returns, there is one return misprediction for branching into
> return_to_handler(), and then the processor's internal return stack
> will probably be misaligned so that after ftrace_return_to_handler()
> is done running, all the following returns will also be mispredicted.
> 
> So I would've thought that fexit hooks would have at least roughly the
> same impact as indirect calls - indirect calls via retpoline do one
> mispredicted branch, fexit hooks do at least two AFAICS. But I guess
> indirect calls could still be slower if fexit benefits from having all
> the mispredicted pointers stored on the cache-hot stack while the
> indirect branch target is too infrequently accessed to be in L1D, or
> something like that?

For fexit I've tried ftrace style of overwriting return address in the stack,
but it was slower than "leave; add rsp, 8; ret". So I went with that.
Looks like skipping one frame makes intel return stack prediction work better
than overwriting. I tested on broadwell only though. Later I realized that I
can do "jmp bpf_trampoline" instead of "call bpf_trampoline", so this extra
'add rsp, 8' can be removed and both direct jump and return stack predictors
will be happy. Will be posting this patch soon.

Old perf numbers of fexit vs original vs kprobe:
https://lore.kernel.org/bpf/20191122011515.255371-1-ast@kernel.org/

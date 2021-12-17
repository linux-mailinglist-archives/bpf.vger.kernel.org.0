Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAC479605
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhLQVLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 16:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLQVLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 16:11:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76076C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 13:11:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id z206so2449067wmc.1
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ug3wDSy/lkcdfiA1k2WbQxglmauXQnW3WALS3TcTBs8=;
        b=n/N+nTwRYlB4Sa2iXwZ/ez2YY9q3SoX3XMonmuD4HGQQw6gTnA/UheZ8C4dKWRTMpn
         VYw+1BuVCOrCVRau2bl1ieSzWecb/V0CdH+rMtbeKxdVZrMV4/8K8hKFpV0SPjt33mNB
         KkLfH6FjIEv5POavdqqtKZGbcqrNEqjonp6q0jnJJNgXqg3gPUfAg9y4AESUAReDq/y6
         YCtYldXY44oNVPyWz6oTMydSpFO5mmvslsElp0XVYNvFt5VJtx3DJkrwFQYv2fsCv3Be
         xY0kCEKfd6vghG1lDR0ITb4oXP4AT3SFqcpHoYO9uN4/TsLzwZ+w9GTNeIM3QJfiy54+
         SdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ug3wDSy/lkcdfiA1k2WbQxglmauXQnW3WALS3TcTBs8=;
        b=pEL9LBwrlYKCDqUzoHYKFewLVaRSuF4bjVlIrofFu0hf1kopx/BAV3Y+VgTZsL75Ec
         x5gQS3xKV1RbKew25TaBvNx72+G6kFnBHqLumO/0slw1Hyf8a2xceZNp0QqbUqUUu8Y6
         YrD8Qg8W8C1nqEYKnKzw6VvpXA5v3ZYiQvGDEVZT6py769v0BmZ5EJG/kfkSnj58oq5D
         Tr7PoLoa0ffOpWy/8uctshEImb3MUqK6yvPYh3XkA/0EAH9TH3ukQIEXDNZNnf7uQcTf
         ipdZuZF8hvcm8Vv+fyQqlXEwWgPOwTJ4jE1IhEtRmYhu1B6fmxpMjX99WhUcrufjfmW+
         kdvA==
X-Gm-Message-State: AOAM533NBsCp3D5Cj46u+MdpCK2BO/WJo/C0yvWo6UZRzfIZSY9/BMej
        HWJRQbFlzk+xrCMlCtx7j+XBit//Ge/B+Yo=
X-Google-Smtp-Source: ABdhPJwUm7bJer/WO36VcKTEHyYMmSTWDCAZlV+kB1G1BvH+YlaO7Yvx1ElFZxffY3AN9VrkiNpbrA==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr11295153wmc.187.1639775497025;
        Fri, 17 Dec 2021 13:11:37 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id f18sm8200666wre.7.2021.12.17.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 13:11:36 -0800 (PST)
Date:   Fri, 17 Dec 2021 22:11:35 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Probe for bounded loop support
Message-ID: <20211217211135.GA42088@Mem>
References: <CAHMuVOB16tif6TRjdNVN9YjGc-UpOOwuo35SM+vY7Bf5=1+oiQ@mail.gmail.com>
 <CAEf4BzZZKC_rq8h=NiWByCCxJN9GGWsqGgcGbcUJA6L5duR5Hg@mail.gmail.com>
 <20211217192235.GA40254@Mem>
 <CAEf4Bzbg2+RHhXQRB6tryQ_b3LFaLi-ibp0EjyBzASxkXW=z0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbg2+RHhXQRB6tryQ_b3LFaLi-ibp0EjyBzASxkXW=z0A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 11:41:28AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 17, 2021 at 11:22 AM Paul Chaignon <paul@isovalent.com> wrote:
> >
> > On Fri, Dec 17, 2021 at 08:12:23AM -0800, Andrii Nakryiko wrote:
> > > On Fri, Dec 17, 2021 at 4:12 AM Paul Chaignon <paul@isovalent.com> wrote:
> > > >
> > > > This patch introduces a new probe to check whether the verifier supports
> > > > bounded loops as introduced in commit 2589726d12a1 ("bpf: introduce
> > > > bounded loops"). This patch will allow BPF users such as Cilium to probe
> > > > for loop support on startup and only unconditionally unroll loops on
> > > > older kernels.
> > > >
> > > > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > > > Signed-off-by: Paul Chaignon <paul@isovalent.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.h        |  1 +
> > > >  tools/lib/bpf/libbpf.map      |  1 +
> > > >  tools/lib/bpf/libbpf_probes.c | 20 ++++++++++++++++++++
> > > >  3 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > > index 42b2f36fd9f0..3621aaaff67c 100644
> > > > --- a/tools/lib/bpf/libbpf.h
> > > > +++ b/tools/lib/bpf/libbpf.h
> > > > @@ -1058,6 +1058,7 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
> > > >  LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
> > > >                                  enum bpf_prog_type prog_type, __u32 ifindex);
> > > >  LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
> > > > +LIBBPF_API bool bpf_probe_bounded_loops(__u32 ifindex);
> > > >
> > >
> > > Nope, see [0], I'm removing bpf_probe_large_insn_limit, so no new
> > > ad-hoc feature probing APIs, please. There has to be some system to
> > > this. If you want to add it to bpftool, go ahead, but keep it inside
> > > bpftool code only. In practice I'd use CO-RE feature detection from
> > > the BPF program side to pick the best implementation. Worst case, I'd
> > > add two BPF program implementations and picked one or the other
> > > (bpf_program__set_autoload(false) to disable one of them) after doing
> > > feature detection from the process, not relying on shelling out to
> > > bpftool.
> >
> > Thanks for the pointer, I wasn't aware of that ongoing work.
> >
> > For CO-RE feature detection, do you have in mind a bpf_core_field_exists
> > call to check one of the bpf_func_state fields introduced in the same
> > commit as bounded loop support, or is there some other CO-RE magic I'm
> > not aware of?
> 
> yep, I had bpf_core_xxx() checks in mind. But even without CO-RE and
> vmlinux BTF, if you can detect it from user-space and set .rodata
> variables, BPF verifier will dead code eliminate gated parts that rely
> on bounded loops, if that's more convenient.

Yes, that's also the longer-term plan for Cilium, but IIRC one blocker
on older kernel is the lack (or smaller scope) of dead code elimination.
Today, we still ship the compiler with our image anyway.

> 
> But if bpftool works, by all means.
> 
> >
> > In any case, I don't think we can assume BTF support in Cilium yet
> > (soon, hopefully). I'll probably resend as a bpftool-only patch.
> 
> SGTM.
> 
> >
> > >
> > >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20211216070442.1492204-2-andrii@kernel.org/
> >
> > [...]

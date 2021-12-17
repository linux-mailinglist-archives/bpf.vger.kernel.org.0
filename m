Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECBF4794B6
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhLQTWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 14:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLQTWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 14:22:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B93C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 11:22:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so2148296wmd.5
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 11:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/5vZLI1+nIArprhfqZZqy/HfknMjwFNbzysDd4yCuw=;
        b=FBPQ77vifzN7SDFr/X/Afss7f9Hj2fd3qx/hy9nPkGQ8TG562qCICjl4vFSBYABxbP
         OxPDEJrASV2NUtGV7anEe13RoXfgp+K2Mt31YX42cSAAKP/qeYPMcZKHxAdXfuZ/IsoR
         j3B8bF0S9F2APd9f9y9eiBTqUHXSrM5/ARiRU99sY+rFIeEYh+fSl8OQV4Z6sJnM9aQH
         rmpr9RPmVxIuvY2W88Xnpi09i6eh/e0wWA1okeCs9pToyzIP8YPtx/011MXUMaORwv8n
         R7cP0S5eyM8//ODYpF5xdNj6CqDQi5HQlSf689Cw5nxdMxRpq4lS5HHBEJkLntHaght5
         009A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z/5vZLI1+nIArprhfqZZqy/HfknMjwFNbzysDd4yCuw=;
        b=PYCtKIfR/CdhVmcIu+oF2LEgPaUhCIDwzKDMY4b2Uz1xS52w846+6RTVrZw7nXSsMi
         /B5lLXAEElQyiY+6GoLEFgW0pPq9PFx8t/4KcE1pH+h/cchEDjN3k5yes8ikUgeBrjMC
         wUIPwl3G/CjnnlwNh3ACxhBKojly2qEkqzwp6gn9GqJhPaEfSQllTXushEpgEmq03ICO
         yyyCUE1vKpmvtI4p9i44+VaGOxqEFgtnqpg6LpQLUn1aNyznhLUuITvWdcDMzDyOcBq+
         2O39Usc9aNpaEN8yxtRR5wwQFI16PE2uvA0hvbhh7CzT2RNCizeeBOXzv0wzNVVxNWz+
         AA6w==
X-Gm-Message-State: AOAM531OEvbyvEY5b7MOuEVmvV5859XxbFt6ggYw0yMrDuT5AYCYtdH3
        1mcKHQI1LDJKmEvAaGXFSmKM
X-Google-Smtp-Source: ABdhPJzz2l41HvddwHESHO4/9eSGtS9L+jyAywAWxC8Cft+pJC5GmmSlhgVtFCZ5hJuhF9sCCK5/rQ==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr10706381wmm.163.1639768957211;
        Fri, 17 Dec 2021 11:22:37 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id h1sm8217114wrf.33.2021.12.17.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:22:36 -0800 (PST)
Date:   Fri, 17 Dec 2021 20:22:35 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Probe for bounded loop support
Message-ID: <20211217192235.GA40254@Mem>
References: <CAHMuVOB16tif6TRjdNVN9YjGc-UpOOwuo35SM+vY7Bf5=1+oiQ@mail.gmail.com>
 <CAEf4BzZZKC_rq8h=NiWByCCxJN9GGWsqGgcGbcUJA6L5duR5Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZZKC_rq8h=NiWByCCxJN9GGWsqGgcGbcUJA6L5duR5Hg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 08:12:23AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 17, 2021 at 4:12 AM Paul Chaignon <paul@isovalent.com> wrote:
> >
> > This patch introduces a new probe to check whether the verifier supports
> > bounded loops as introduced in commit 2589726d12a1 ("bpf: introduce
> > bounded loops"). This patch will allow BPF users such as Cilium to probe
> > for loop support on startup and only unconditionally unroll loops on
> > older kernels.
> >
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Paul Chaignon <paul@isovalent.com>
> > ---
> >  tools/lib/bpf/libbpf.h        |  1 +
> >  tools/lib/bpf/libbpf.map      |  1 +
> >  tools/lib/bpf/libbpf_probes.c | 20 ++++++++++++++++++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 42b2f36fd9f0..3621aaaff67c 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1058,6 +1058,7 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
> >  LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
> >                                  enum bpf_prog_type prog_type, __u32 ifindex);
> >  LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
> > +LIBBPF_API bool bpf_probe_bounded_loops(__u32 ifindex);
> >
> 
> Nope, see [0], I'm removing bpf_probe_large_insn_limit, so no new
> ad-hoc feature probing APIs, please. There has to be some system to
> this. If you want to add it to bpftool, go ahead, but keep it inside
> bpftool code only. In practice I'd use CO-RE feature detection from
> the BPF program side to pick the best implementation. Worst case, I'd
> add two BPF program implementations and picked one or the other
> (bpf_program__set_autoload(false) to disable one of them) after doing
> feature detection from the process, not relying on shelling out to
> bpftool.

Thanks for the pointer, I wasn't aware of that ongoing work.

For CO-RE feature detection, do you have in mind a bpf_core_field_exists
call to check one of the bpf_func_state fields introduced in the same
commit as bounded loop support, or is there some other CO-RE magic I'm
not aware of?

In any case, I don't think we can assume BTF support in Cilium yet
(soon, hopefully). I'll probably resend as a bpftool-only patch.

> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20211216070442.1492204-2-andrii@kernel.org/

[...]

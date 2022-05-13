Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6925526C05
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381542AbiEMVFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380411AbiEMVFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 17:05:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05647E0FF
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:05:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s23so9988282iog.13
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SJ0ywjw7EXkGQzvW02o6XIbB873Zd0RztNCexlGZmk=;
        b=JkNkUIb6Rf2hx4dFyGU46ooszLzBirJeZ/ZjVP3jGLmn4ovXw9SEmFv+sl6dnUGMII
         caO2mCCNwa7rutCAbA3tFfuG5uJxQEF4YCrblPwhYEVkjaOA6n3IwmPsLKmM9GxjuoLp
         hC7jPwxGVxaDqyjyrGpFDxfxvMxi+9cz6CW732pPfd1r+hF5qUlYumpeOwE/w/yFmCRA
         r4CWmBuN/WZO/xerwUvW+RHE8cDwPc1yG1skW6vtGLtfPLZ/+e7AmgJfadgMjDPRonTy
         /Qai9Sk9N/kea6orrsTFYGBBBpPVNfufgo0UQyT8xX9q5jiMViFWfYyJVizeGxlROor8
         bO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SJ0ywjw7EXkGQzvW02o6XIbB873Zd0RztNCexlGZmk=;
        b=3Y+lbb/tNc8GETMDPojy4rVzfWxDopaHFkp+DSph+frlTOefaZ9UOfuIEsL9cIT6vd
         auMgl2LBBaTE6OqOOzYbu413Q9VitiTT2A+KIqPYsrTMbOmpjf14nFpEAgL9RcLqh2UD
         xWU+Lqg1+oglj/FpYb5fPkLAGBMoqlKPItlNsW1PP2LzNiPmhNTIkpNtb8g3KK//LRQF
         ROqLOPWIes+dnsON4sCsaQRAA0gBrIBzlNR8oOvtbfa6hLD4+cX1nBzZWvAb6m2RE3Bx
         LwhiQvDy4GAcpekRRO5KGXqJVxZfJTzWjI58lB+rhzE02rZwZxNqRN4ExhSxD702asip
         EItw==
X-Gm-Message-State: AOAM533GJ/5KyTk0dBtHmC2/m2j2h/6F0bJ9LIKccGvkDmxk08KkAQUk
        ictP/bQoHIQFwRAvZSz7MTVsyya2Wi5VcHU32JY=
X-Google-Smtp-Source: ABdhPJwW8bvLXTD5z7f2dnCAVk9RpbON3DSzGZQKka6uEIA1kuzSJiHY/eHGRzW0fn6ncL7ugapACR1PwucxrtYYKro=
X-Received: by 2002:a5e:8e42:0:b0:657:bc82:64e5 with SMTP id
 r2-20020a5e8e42000000b00657bc8264e5mr3067691ioo.112.1652475904378; Fri, 13
 May 2022 14:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com> <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
 <CAJnrk1Zs6dVAqwbCQ1VShH+00D_EY7ePjyyhfj5UVO5zwSO7JA@mail.gmail.com>
 <b35e19c7-82ea-27fa-4fd6-50e36e64241c@iogearbox.net> <20220513163951.tg2nrsuwlglpxvu7@MBP-98dd607d3435.dhcp.thefacebook.com>
 <0313e3f4-2e5b-240f-0c45-339f7b23da8b@iogearbox.net>
In-Reply-To: <0313e3f4-2e5b-240f-0c45-339f7b23da8b@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 May 2022 14:04:53 -0700
Message-ID: <CAEf4BzbDgMjnxZ_g6ourJQzzL-bvobQknrVf7sVrro0r6KZADA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 12:28 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/13/22 6:39 PM, Alexei Starovoitov wrote:
> > On Fri, May 13, 2022 at 03:12:06PM +0200, Daniel Borkmann wrote:
> >>
> >> Thinking more about it, is there even any value for BPF_FUNC_dynptr_* for
> >> fully unpriv BPF if these are rejected anyway by the spectre mitigations
> >> from verifier?
> > ...
> >> So either for alloc, we always built-in __GFP_ZERO or bpf_dynptr_alloc()
> >> helper usage should go under perfmon_capable() where it's allowed to read
> >> kernel mem.
> >
> > dynptr should probably by cap_bpf and cap_perfmon for now.
> > Otherwise we will start adding cap_perfmon checks in run-time to helpers
> > which is not easy to do. Some sort of prog or user context would need
> > to be passed as hidden arg into helper. That's too much hassle just
> > to enable dynptr for cap_bpf only.
> >
> > Similar problem with gfp_account... remembering memcg and passing all
> > the way to bpf_dynptr_alloc helper is not easy. And it's not clear
> > which memcg to use. The one where task was that loaded that bpf prog?
> > That task could have been gone and cgroup is in dying stage.
> > bpf prog is executing some context and allocating memory for itself.
> > Like kernel allocates memory for its needs. It doesn't feel right to
> > charge prog's memcg in that case. It probably should be an explicit choice
> > by bpf program author. Maybe in the future we can introduce a fake map
> > for such accounting needs and bpf prog could pass a map pointer to
> > bpf_dynptr_alloc. When such fake and empty map is created the memcg
> > would be recorded the same way we do for existing normal maps.
> > Then the helper will look like:
> > bpf_dynptr_alloc(struct bpf_map *map, u32 size, u64 flags, struct bpf_dynptr *ptr)
> > {
> >    set_active_memcg(map->memcg);
> >    kmalloc into dynptr;
> > }
> >
> > Should we do this change now and allow NULL to be passed as a map ?
>
> Hm, this looks a bit too much like a hack, I wouldn't do that, fwiw.
>
> > This way the bpf prog will have a choice whether to account into memcg or not.
> > Maybe it's all overkill and none of this needed?
> >
> > On the other side maybe map should be a mandatory argument and dynptr_alloc
> > can do its own memory accounting for stats ? atomic inc and dec is probably
> > an acceptable overhead? bpftool will print the dynptr allocation stats.
> > All sounds nice and extra visibility is great, but the kernel code that
> > allocates for the kernel doesn't use memcg. bpf progs semantically are part of
> > the kernel whereas memcg is a mechanism to restrict memory that kernel
> > allocated on behalf of user tasks. We abused memcg for bpf progs/maps
> > to have a limit. Not clear whether we should continue doing so for dynpr_alloc
> > and in the future for kptr_alloc. gfp_account adds overhead too. It's not free.
> > Thoughts?
>
> Great question, I think the memcg is useful, just that the ownership for bpf
> progs/maps has been relying on current whereas current is not a real 'owner',
> just the entity which did the loading.
>
> Maybe we need some sort of memcg object for bpf where we can "bind" the prog
> and map to it at load time, which is then different from current and can be
> flexibly set, e.g. fd = open(/sys/fs/cgroup/memory/<foo>) and pass that fd to
> BPF_PROG_LOAD and BPF_MAP_CREATE via bpf_attr (otherwise, if not set, then
> no accounting)?
>

I think it would be great to have memory accounting for BPF program as
a separate entity from current. BPF program is sort of like a special
process w.r.t. memory that it owns. Good thing is that with
bpf_run_ctx (once wired for all program types) such "ambient" entities
can be easily accessed from helpers to do accounting without any
verifier magic involved.

> Thanks,
> Daniel

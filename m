Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EB566A8A1
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 03:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjANCUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 21:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjANCUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 21:20:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23E8CBD7
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 18:20:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so17434735pfe.2
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWEXMtv0fP2RB5AdlXVyfM+v8329B7HYzbhGXaBNKLU=;
        b=fHLtqi4MkBnkcpLOkOHzR8tYKv+i4MtMriVC+5GVLE2ahnGxC1iST3yB3DvzTT5pLa
         SZIxD60knGYZhZA29U7S9G0zYZHAOdiykAWWhIL8IrVYiUBg7VbwSGU/C3ym73UEMkll
         YNpqyJcH2T4TjjurYbVvAaRsJoljIMsFcrNQFOYtdZwWjF2RnuLPzr+aFaKp3DHe3SAt
         0E1KC0dYGXPFSFHZ48tYcVyBXEhw15ppKZNKHxvG3kNdjDSBET6+TzqqX7gcjhYRdL3R
         5Oeki0aiyQUlUxcM1OVWXKlqv6lKzjWo3ONjIgx0uoWl8Q43LV2aEnF8YdFKiRL6sdGG
         w+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWEXMtv0fP2RB5AdlXVyfM+v8329B7HYzbhGXaBNKLU=;
        b=OVnG1UAxhoB5CEa2leywo9q3yJ1V1++myQUEIRTvqziknFhy7Ernke5dE48pge+kFg
         EUldjlZyLUJrsgr65V66caZyIbTYHFsKOIu0uF+ZNitF+/zoo1lUH1VOW82YyofcH/Az
         t1Gb4kOp6wgRHGwD2iJniAL7vTicT1/d1Sj08fnk3xNb+uwI4dzECqu8KsT3lAKcCzqV
         7mi1RWfWI8pqqrveHavPSN80yhmOrwzvFrkdzD4dVHwQ9boKsijMKglIuspfWmayfElh
         Nmff9BJYTiIFUlJVm2deo9+ocA78EuhrLG7V47JSQyANb0Jhuzw0hZD4UVAaYl9yw7Pf
         SPAw==
X-Gm-Message-State: AFqh2kp1ipk+NnjVTuyLsv6BFV7heAxOr+65LKitmqx+/ldffzOkzdAp
        zoMGGkbJvwHLQ16zswdvs7vPO1tpxhCmoCHRlQpP7A==
X-Google-Smtp-Source: AMrXdXs2UIOVMtifo6bi3e7hwJrVG51LPBuPPAtnPD2tEZsZpuSMhaIBMdLul5rT8NYxjVUpg/eAcAw6WpSsCMRZDpo=
X-Received: by 2002:a62:2901:0:b0:586:7e0c:372d with SMTP id
 p1-20020a622901000000b005867e0c372dmr2102258pfp.14.1673662809738; Fri, 13 Jan
 2023 18:20:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com>
 <CA+khW7gXaHwxZjS1sp0oAF-t0jk0+CnwxdhV9kqyBfqEVack-w@mail.gmail.com> <CAEf4BzaQPtFMkcJdH4m5S0X5t3UD1M0M_bJk9Z65Zspb5bbxgA@mail.gmail.com>
In-Reply-To: <CAEf4BzaQPtFMkcJdH4m5S0X5t3UD1M0M_bJk9Z65Zspb5bbxgA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 13 Jan 2023 18:19:58 -0800
Message-ID: <CA+khW7g44a7a1-C+q7B5NA1DPiM6zCanLsrXOfNm1vOvKwPtAw@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 5:14 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 5:06 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 3:41 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
<...>
> > >
> > > Have you tried bpf_core_type_matches()? It seems like exactly what yo=
u
> > > are looking for? See [0] for logic of what constitutes "a match".
> > >
> >
> > It seems bpf_core_type_matches() is for the userspace code. I'm
>
> It's in the same family as bpf_type_{exists,size}() and
> bpf_field_{exists,size,offset}(). It's purely BPF-side. Please grep
> for bpf_core_type_matches() in selftests/bpf.
>
> > looking for type checking in the BPF code. We probably don't need to
> > check type equivalence, just comparing the btf_id of the field's type
> > and the btf_id of a target type may be sufficient.
>
> With the example above something like below should work:
>
> struct rw_semaphore__old {
>         struct task_struct *owner;
> };
>
> struct rw_semaphore__new {
>         atomic_long_t owner;
> };
>
> u64 owner;
> if (bpf_core_type_matches(struct rw_semaphore__old) /* owner is
> task_struct pointer */) {
>         struct rw_semaphore__old *old =3D (struct rw_semaphore__old *)sem=
;
>         owner =3D (u64)sem->owner;
> } else if (bpf_core_type_matches(struct rw_semaphore__old) /* owner
> field is atomic_long_t */) {
>         struct rw_semaphore__new *new =3D (struct rw_semaphore__new *)sem=
;
>         owner =3D new->owner.counter;
> }
>
> >
> > The commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an
> > atomic_long_t=E2=80=9D) is rare, but the 'owner' field is useful for tr=
acking
> > the owner of a kernel lock.
>
> We implemented bpf_core_type_matches() to detect tracepoint changes,
> which is equivalent (if not harder) use case. Give it a try.
>

Thanks Andrii for the pointer. It's still not working. I got the
following error when loading:

libbpf: prog 'on_contention_begin': relo #1: parsing [43] struct
rw_semaphore__old + 0 failed: -22
libbpf: prog 'on_contention_begin': relo #1: failed to relocate: -22
libbpf: failed to perform CO-RE relocations: -22

I'll dig a little more next week.

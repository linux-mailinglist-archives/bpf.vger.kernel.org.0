Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1202315A3C
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhBIXra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 18:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234771AbhBIXXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 18:23:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C626D64E3C
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612912954;
        bh=/Tc26PHAzvSv5GT6xkLKfQHp6dGnqZ9RwzN64T/VXyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jTl5jtstt+sEnmAF2IXmoOWtQIRZ2OwQ+hqaCVy+mbJv0U0eZG0hExhSHOjC9Vz21
         c0f9z3lWXYIIOopqXlGRE9HbKKUh37ifURbMMLnA9gVHle14w9RLIvtpzVl/QLBKE7
         XdBIGGtJUSvsQOwE865+/sEJObGqSinFqQxzwflrGa8zWcx/x3xrcSH5vzIxJ3w9VG
         VrM3XnViBvB6y95Xyy3HRoMYXmoy7BjviObi5Tvnn1SvP6yXZgC7GBGXv0bJaS7yIw
         aD1buYHy2s7Rj2LHD3YD2UEBH9YUF2bkMOEnrfYX2enBo9qaIS6cV418BDjo7HnfzK
         7r8XMQSfUhkYQ==
Received: by mail-lf1-f54.google.com with SMTP id f23so57764lfk.9
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 15:22:33 -0800 (PST)
X-Gm-Message-State: AOAM53217rf3w3hRtjgGvLYw8jgLi8Oeqc3eteOZ+5ozsMZFuo0zY0ug
        9I5n72uxYgUYbC9VamWFhqWdMMQsBhi5gM6PEKKe4g==
X-Google-Smtp-Source: ABdhPJzrB9kk77wQ/geAgzGjvzIskms4b2a5KLQ0kFLPU+rdtqLYL5ZWK43RDeLb0qqPlezKVrU9q3APGp8lbYGoNAs=
X-Received: by 2002:a19:6b1a:: with SMTP id d26mr173114lfa.162.1612912952056;
 Tue, 09 Feb 2021 15:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
 <20210209194856.24269-8-alexei.starovoitov@gmail.com> <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
 <9a45e856-c464-c6e0-6c26-baf364b6bbe8@fb.com> <CACYkzJ4=G45CG+_6wq+xR64PpZ_z1gvQsJWhYFhzKd=2_Y-s1g@mail.gmail.com>
 <61dffef3-ab23-8d9b-70da-3e84caa84fe3@fb.com>
In-Reply-To: <61dffef3-ab23-8d9b-70da-3e84caa84fe3@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 10 Feb 2021 00:22:20 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6Cda4QR8m8QJ_SZ0rx0hj3LQahrz4cwiNuPC9PVRhyFQ@mail.gmail.com>
Message-ID: <CACYkzJ6Cda4QR8m8QJ_SZ0rx0hj3LQahrz4cwiNuPC9PVRhyFQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/8] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 12:14 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 2/9/21 2:43 PM, KP Singh wrote:
> > On Tue, Feb 9, 2021 at 11:32 PM Alexei Starovoitov <ast@fb.com> wrote:
> >>
> >> On 2/9/21 1:12 PM, KP Singh wrote:
> >>> On Tue, Feb 9, 2021 at 9:57 PM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> From: Alexei Starovoitov <ast@kernel.org>
> >>>>
> >>>> Since sleepable programs are now executing under migrate_disable
> >>>> the per-cpu maps are safe to use.
> >>>> The map-in-map were ok to use in sleepable from the time sleepable
> >>>> progs were introduced.
> >>>>
> >>>> Note that non-preallocated maps are still not safe, since there is
> >>>> no rcu_read_lock yet in sleepable programs and dynamically allocated
> >>>> map elements are relying on rcu protection. The sleepable programs
> >>>> have rcu_read_lock_trace instead. That limitation will be addresses
> >>>> in the future.
> >>>>
> >>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >>>
> >>> Acked-by: KP Singh <kpsingh@kernel.org>
> >>>
> >>> Thanks! I actually tested out some of our logic which uses per-cpu maps by
> >>> switching the programs to their sleepable counterparts
> >>
> >> You mean after applying this set, right?
> >> migrate_disable is the key.
> >> It will be difficult to backport to your kernels though.
> >> The bpf change to enable per-cpu is easy, but backporting
> >> sched support is a different game.
> >>
> >
> > Yes after applying the whole set.
> >
> > Also, I think I also got it to work on 5.10 by (I am little less sure
> > of this one though)
> >
> > -  Backporting https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=12fa97c64dce2f3c2e6eed5dc618bb9046e40bf0
> > -  Backporting https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=74d862b682f51e45d25b95b1ecf212428a4967b0
> > - And, backporting this set (I initially missed
> > https://lore.kernel.org/bpf/20210209194856.24269-3-alexei.starovoitov@gmail.com
> > where you add the
> >    calls and ran into issues).
>
> and the whole machinery that it depends on.

 https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=12fa97c64dce2f3c2e6eed5dc618bb9046e40bf0
and https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=74d862b682f51e45d25b95b1ecf212428a4967b0
is the machinery I could find between 5.10 and now. But the backport
is not really relevant here, I just mentioned it to clarify that I was
testing the series more than just applying this single patch :)

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54873159B3
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhBIWuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 17:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233907AbhBIWoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 17:44:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B6F64E32
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612910612;
        bh=JwS/W9TiWM/+nqca4NeECLYQ10RP6CxIp6ZmzN3cEiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R2+GqKiGfpO0CxmW7b+qdZHwWvH+LFofwHPzVuDL8XpeVjCPxLgzrznL3O0PcltX0
         2sIPEMRf65l3l8YXKu22e4rxb83NsxyKNHzRbp9AcYotRh5JFYd2phBs4KTS8yqFw2
         qHhlDAr0e6lXIv2FY+7L8uVuQqHvuuRfyNIq+R3xdoklQDUyx6FdhlX0eBf6BWcJZh
         HXpQiqoZT0hwUfjRDKyhdYKY5zgyETmwoDO/xOBBAC8GNqoihbClGx22zvSfARlBmf
         W8jjXvgvP+v0kzDzitLfCCmzSZ5Y8fBFlJAkzZ8TWFuX9siZ5y+ryo2gKVo5gfHO4/
         tn6EvtN2xiHSg==
Received: by mail-lj1-f171.google.com with SMTP id e18so255849lja.12
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 14:43:32 -0800 (PST)
X-Gm-Message-State: AOAM5333/pcRN7zRVoSUNwTCqmfjgSkSfKtTQSGcwMhRiQzzUaHvXPiD
        x1X4Jb2FHMkzP5HJ3uAEqSxWkCeHVhWVZomL6ay/7w==
X-Google-Smtp-Source: ABdhPJxuYT1miNSPrcd69cb0oVmtjaHkwGIPy3Kuk8g1ZgBPh9yFNUBAfQOlED8Gp9sQCcugE3goYhgb9Ile0hqHaJs=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr36745ljh.204.1612910610353;
 Tue, 09 Feb 2021 14:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
 <20210209194856.24269-8-alexei.starovoitov@gmail.com> <CACYkzJ66POr0opxbrvRTTTc-T4CsyirHpDPvWRaM3R1bmNvm8w@mail.gmail.com>
 <9a45e856-c464-c6e0-6c26-baf364b6bbe8@fb.com>
In-Reply-To: <9a45e856-c464-c6e0-6c26-baf364b6bbe8@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 9 Feb 2021 23:43:19 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4=G45CG+_6wq+xR64PpZ_z1gvQsJWhYFhzKd=2_Y-s1g@mail.gmail.com>
Message-ID: <CACYkzJ4=G45CG+_6wq+xR64PpZ_z1gvQsJWhYFhzKd=2_Y-s1g@mail.gmail.com>
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

On Tue, Feb 9, 2021 at 11:32 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 2/9/21 1:12 PM, KP Singh wrote:
> > On Tue, Feb 9, 2021 at 9:57 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Since sleepable programs are now executing under migrate_disable
> >> the per-cpu maps are safe to use.
> >> The map-in-map were ok to use in sleepable from the time sleepable
> >> progs were introduced.
> >>
> >> Note that non-preallocated maps are still not safe, since there is
> >> no rcu_read_lock yet in sleepable programs and dynamically allocated
> >> map elements are relying on rcu protection. The sleepable programs
> >> have rcu_read_lock_trace instead. That limitation will be addresses
> >> in the future.
> >>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Acked-by: KP Singh <kpsingh@kernel.org>
> >
> > Thanks! I actually tested out some of our logic which uses per-cpu maps by
> > switching the programs to their sleepable counterparts
>
> You mean after applying this set, right?
> migrate_disable is the key.
> It will be difficult to backport to your kernels though.
> The bpf change to enable per-cpu is easy, but backporting
> sched support is a different game.
>

Yes after applying the whole set.

Also, I think I also got it to work on 5.10 by (I am little less sure
of this one though)

-  Backporting https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=12fa97c64dce2f3c2e6eed5dc618bb9046e40bf0
-  Backporting https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=74d862b682f51e45d25b95b1ecf212428a4967b0
- And, backporting this set (I initially missed
https://lore.kernel.org/bpf/20210209194856.24269-3-alexei.starovoitov@gmail.com
where you add the
  calls and ran into issues).

- KP

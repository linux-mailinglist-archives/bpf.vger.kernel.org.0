Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1E41531C
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhIVV6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbhIVV6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 17:58:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76807C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 14:57:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b65so14655448qkc.13
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7fWVk3iVmB++HuiwZVZRW3yW78jC7bfe0aMBg54fmM=;
        b=bW5/4ESrHZGS3tCmNNGEPseILrTQefQJk0zoxYjMW0xiNsCHhaJ1Uhe1WLN/d4AGTE
         k+ZopEi1OBn3EaeK/cnUwrVjXsSkUoHomI5uxgXICPBRN8ujjuJxWm9JvjaNnb8e/ap8
         bTkuHq3dDx1UaNyrDWjUw+qWfzCFY9Hpi5uxSNNHMRxxl0XgN82entntJ9FfO79Ex5Pv
         NNSNzVut/1DtF46h2t5xYV+0I5N5JkBhcLfkkg8ZGZtHZ+0gc4F8K4W+WIb68Si3BkB0
         qBgD+zW0IOoFSotFzjdUsTPnNL9H/S16jdwokD74a/u34omWHyGtEk+AhCajq8kDwhyu
         7Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7fWVk3iVmB++HuiwZVZRW3yW78jC7bfe0aMBg54fmM=;
        b=F+aPwkRM2oQ5xeIdagxpOBL/okUv6PoF3+GHCCeuzbO+Vfw0+H/q80rk/LXSGl5WOl
         QoZiBp6pYq4+fHHU83M1av9pP6qY3XbYYJ1rrQIbBgLe/rR0V7Sq18APqhO9nymElrc0
         MM6Wf7UtcTHLaT6APWykZleYjq0EIcTAMN2iyGeiiwCbamFNJOp/BwBXkaSxZOZd4aVX
         63RGEegsWSo2WWu5ZGkTyv3+Kpn73J/uxQGTDu/adUA6Tb1vLzp2bwXFKiIw2SMwOsD5
         5QOeHE8CxNY0exb/zgTPvDr9tTSxoqqDWkLa6eBkPYQZiwbSOHY477+FdrIc7EqV/XHp
         eARw==
X-Gm-Message-State: AOAM531P5fpVLXUcpeJZpncS697fZPwyenT51KBE8A4kzBZ2M+PqWmg7
        YV4kszzSvPuXQKHew0q/+UgMTu0ZabfsxpaqwxE=
X-Google-Smtp-Source: ABdhPJxdkb/r1GfkPWJUlG5eo8hpNiLXMA4rCztp4B5+Inc0PAW3MokmRMYHJxU6Bgxt+c8SCaOMpPo361gW9+3YhYM=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr1730657yba.225.1632347834600;
 Wed, 22 Sep 2021 14:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-9-andrii@kernel.org>
 <1f3336f0-c789-71ab-1974-b280ce28da06@fb.com>
In-Reply-To: <1f3336f0-c789-71ab-1974-b280ce28da06@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 14:57:03 -0700
Message-ID: <CAEf4BzaXsW6FHKffmr6+piA6ahAwSvuGK+z8-TKOMHHtu81FzQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 6:53 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Implement strict ELF section name handling for BPF programs. It utilizes
> > `libbpf_set_strict_mode()` framework and adds new flag: LIBBPF_STRICT_SEC_NAME.
> >
> > If this flag is set, libbpf will enforce exact section name matching for
> > a lot of program types that previously allowed just partial prefix
> > match. E.g., if previously SEC("xdp_whatever_i_want") was allowed, now
> > in strict mode only SEC("xdp") will be accepted, which makes SEC("")
> > definitions cleaner and more structured. SEC() now won't be used as yet
> > another way to uniquely encode BPF program identifier (for that
> > C function name is better and is guaranteed to be unique within
> > bpf_object). Now SEC() is strictly BPF program type and, depending on
> > program type, extra load/attach parameter specification.
> >
> > Libbpf completely supports multiple BPF programs in the same ELF
> > section, so multiple BPF programs of the same type/specification easily
> > co-exist together within the same bpf_object scope.
> >
> > Additionally, a new (for now internal) convention is introduced: section
> > name that can be a stand-alone exact BPF program type specificator, but
> > also could have extra parameters after '/' delimiter. An example of such
> > section is "struct_ops", which can be specified by itself, but also
> > allows to specify the intended operation to be attached to, e.g.,
> > "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not allowed.
> > Such section definition is specified as "struct_ops+".
> >
> > This change is part of libbpf 1.0 effort ([0], [1]).
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/271
> >   [1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c        | 135 ++++++++++++++++++++++------------
> >  tools/lib/bpf/libbpf_legacy.h |   9 +++
> >  2 files changed, 98 insertions(+), 46 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 56082865ceff..f0846f609e26 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -232,6 +232,7 @@ enum sec_def_flags {
> >       SEC_ATTACHABLE_OPT = SEC_ATTACHABLE | SEC_EXP_ATTACH_OPT,
> >       SEC_ATTACH_BTF = 4,
> >       SEC_SLEEPABLE = 8,
> > +     SEC_SLOPPY_PFX = 16, /* allow non-strict prefix matching */
> >  };
> >
> >  struct bpf_sec_def {
> > @@ -7976,15 +7977,15 @@ static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
> >  static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
> >
> >  static const struct bpf_sec_def section_defs[] = {
> > -     SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> > -     SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> > -     SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
> > +     SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> >       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
> >       SEC_DEF("uprobe/",              KPROBE, 0, SEC_NONE),
> >       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
> >       SEC_DEF("uretprobe/",           KPROBE, 0, SEC_NONE),
> > -     SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE),
> > -     SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE),
> > +     SEC_DEF("classifier",           SCHED_CLS, 0, SEC_SLOPPY_PFX),
>
> Feels like the mass SEC_NONE -> SEC_SLOPPY_PFX migration is obscuring some
> useful at-a-glance info. The equivalent SEC_NONE | SEC_SLOPPY_PFX would make
> reasoning about attach behavior easier IMO.

Sure, I can leave "SEC_NONE | SEC_SLOPPY_PFX" everywhere where there
are no other flags

>
> > +     SEC_DEF("action",               SCHED_ACT, 0, SEC_SLOPPY_PFX),
> >       SEC_DEF("tracepoint/",          TRACEPOINT, 0, SEC_NONE, attach_tp),
> >       SEC_DEF("tp/",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
>
> [...]

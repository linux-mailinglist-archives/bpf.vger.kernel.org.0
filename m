Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91427655A7D
	for <lists+bpf@lfdr.de>; Sat, 24 Dec 2022 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiLXPcK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Dec 2022 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiLXPcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Dec 2022 10:32:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CFC75B
        for <bpf@vger.kernel.org>; Sat, 24 Dec 2022 07:32:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so11280205pjj.2
        for <bpf@vger.kernel.org>; Sat, 24 Dec 2022 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uhx70Wc2VTFokQfpnR8f2VD8Nm2dmZ9bHhkHgTA0qJk=;
        b=CW5q0MaYA9m8Tysw5UUGVTIVFwbVvkxPoiIQgUDNxD/0GcMoHuvSpPUi88PjQ4vzX8
         U0qiXrvXKf+TiyW0Fs+DiaQ5iTNmgTwqoUEJXSvhLi0042q2N1clGTKM9BPGuaT6QamY
         5sNpNTJf0BKfNKg5lcq4bQHinEUX9CqiERsYWzEfAy7dBCpv+EoNVubBLiexHPcQgGfv
         Q1xj2CAXOgQkzDWd8TxDn0Wa4qZGClfxegOyHe/dWg42C3uFtIVqv3f9OUu/S5UWnvmS
         Tj5YFCq59hXCEnV/mHDkhKvmWZrastkBSJweouyhRLXf+22c5LoUqbksmhZhMyb14PHp
         1VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhx70Wc2VTFokQfpnR8f2VD8Nm2dmZ9bHhkHgTA0qJk=;
        b=bAN9PiTy/MW2+HdhcHecKftNDeCP8yZQROlo705eB1VmNafAkXajdsvoWG3J3U6Jqr
         nnIbz/6EEAv/qOV6X/V3NH67fUNHEDZm6SkfjSz8f1tFBpncR8q2TELo6YTY2MmTyFab
         iKrvlvClQ1aVGEPgWIA38gfMRV+dMCn/dC9m6ITUz959OF0dcZmvEfSAKPkIdUHG2gVH
         VWn6qzuKo+3DefbHYDdFMBiMILgdCtSPH45IsMpdUTfFeeSZAnC2680k7eNivd4PWuS3
         YVmR8TdTB8BlVX0qh82TwxioRHOy/LX9z2C5AnQNT95SO6PgxhLvzbD5P3hr2XEV9KUx
         rS+A==
X-Gm-Message-State: AFqh2ko1Cu3R9gvg1Hw1ebCxhI4nA9bkcYZ18yKREHNg9xCr/1PwOrFu
        P4bidUkxn8JlGszTLdFAdZ9z0dpqpqNxUPUUDpIv
X-Google-Smtp-Source: AMrXdXseNgExZNcaLwsrKOqDhqnUHGhQKQPn3LCFiJjUKJUm4SbPfCpkf/sYSsuZeLwe1Ksk6gbX6tQkmPaHu5AyjR8=
X-Received: by 2002:a17:90a:8a82:b0:219:b79d:c308 with SMTP id
 x2-20020a17090a8a8200b00219b79dc308mr1429281pjn.69.1671895926482; Sat, 24 Dec
 2022 07:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20221223185531.222689-1-paul@paul-moore.com> <CAKH8qBu30bdiMWmUzZsYaVRTpSXfKjeBHD9deSPQmk_v_seDuA@mail.gmail.com>
In-Reply-To: <CAKH8qBu30bdiMWmUzZsYaVRTpSXfKjeBHD9deSPQmk_v_seDuA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 24 Dec 2022 10:31:55 -0500
Message-ID: <CAHC9VhQx2AVJ05CHVSU0VnjWb85cPE2-Y6KmY7tPLSS_y5=qvw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     Stanislav Fomichev <sdf@google.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 23, 2022 at 8:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> On Fri, Dec 23, 2022 at 10:55 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > When changing the ebpf program put() routines to support being called
> > from within IRQ context the program ID was reset to zero prior to
> > calling the perf event and audit UNLOAD record generators, which
> > resulted in problems as the ebpf program ID was bogus (always zero).
> > This patch resolves this by adding a new flag, bpf_prog::valid_id, to
> > indicate when the bpf_prog_aux ID field is valid; it is set to true/1
> > in bpf_prog_alloc_id() and set to false/0 in bpf_prog_free_id().  In
> > order to help ensure that access to the bpf_prog_aux ID field takes
> > into account the new valid_id flag, the bpf_prog_aux ID field is
> > renamed to bpf_prog_aux::__id and a getter function,
> > bpf_prog_get_id(), was created and all users of bpf_prog_aux::id were
> > converted to the new caller.  Exceptions to this include some of the
> > internal ebpf functions and the xdp trace points, although the latter
> > still take into account the valid_id flag.
> >
> > I also modified the bpf_audit_prog() logic used to associate the
> > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > Instead of keying off the operation, it now keys off the execution
> > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > appropriate and should help better connect the UNLOAD operations with
> > the associated audit state (other audit records).
> >
> > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > --
> > * v2
> >   - change subj
> >   - add mention of the perf regression
> >   - drop the dedicated program audit ID
> >   - add the bpf_prog::valid_id flag, bpf_prog_get_id() getter
> >   - convert prog ID users to new ID getter
> > * v1
> >   - subj was: "bpf: restore the ebpf audit UNLOAD id field"
> >   - initial draft
> > ---
> >  drivers/net/netdevsim/bpf.c  |  6 ++++--
> >  include/linux/bpf.h          | 11 +++++++++--
> >  include/linux/bpf_verifier.h |  2 +-
> >  include/trace/events/xdp.h   |  4 ++--
> >  kernel/bpf/arraymap.c        |  2 +-
> >  kernel/bpf/bpf_struct_ops.c  |  2 +-
> >  kernel/bpf/cgroup.c          |  2 +-
> >  kernel/bpf/core.c            |  2 +-
> >  kernel/bpf/cpumap.c          |  2 +-
> >  kernel/bpf/devmap.c          |  2 +-
> >  kernel/bpf/syscall.c         | 27 +++++++++++++++------------
> >  kernel/events/core.c         |  6 +++++-
> >  kernel/trace/bpf_trace.c     |  2 +-
> >  net/core/dev.c               |  2 +-
> >  net/core/filter.c            |  3 ++-
> >  net/core/rtnetlink.c         |  2 +-
> >  net/core/sock_map.c          |  2 +-
> >  net/ipv6/seg6_local.c        |  3 ++-
> >  net/sched/act_bpf.c          |  2 +-
> >  net/sched/cls_bpf.c          |  2 +-
> >  20 files changed, 52 insertions(+), 34 deletions(-)

...

> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9e7d46d16032..18e965bd7db9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> >  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> >  void bpf_prog_put(struct bpf_prog *prog);
> >
> > +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > +{
> > +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > +               return 0;
> > +       return prog->aux->__id;
> > +}
>
> I'm still missing why we need to have this WARN and have a check at all.

I believe I explained my reasoning in the other posting, but as I also
mentioned, it's your subsystem so I don't really care about the
details as long as we fix the bug/regression in the ebpf code.

> IIUC, we're actually too eager in resetting the id to 0, and need to
> keep that stale id around at least for perf/audit.

Agreed.

> Why not have a flag only to protect against double-idr_remove
> bpf_prog_free_id and keep the rest as is?

I'll send an updated patch next week with the only protection being a
check in bpf_prog_free_id().

-- 
paul-moore.com

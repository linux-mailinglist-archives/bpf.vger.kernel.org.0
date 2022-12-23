Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2B6554BC
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiLWV1A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 16:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWV05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 16:26:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0931EEED
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 13:26:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n10-20020a17090a73ca00b00225cbc4dfaeso1493751pjk.3
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4gfG/wlEI6oRTf4TuIt7/0Mn2sElJVOoXH266i2Gr9o=;
        b=NqEbYdhjMK5O0hceL1EKWm7wlTgUqRPMoN39glTog6r43VC1O2pFm/IdILzz+s7k5k
         ni6fVmazm8uY5gl0dhbPjkBm4IdZDtS0ow16QmfJECmzYeYxWVmdPBb13i1hxVoupj4i
         gA6XHVI1mL86U6h7tOvlZ37gtG8fu+27DspkMEJ3gRM7gXY2JAelZaozAkxST5Gmd9Vw
         7JF+CzQmjOMDOvHJB2qanYz7J+3Eiq4sO5lH+QrfJHlT2ZmHmKlI8ttzwV1bl8FeG1At
         3BLVdifHvoejQo5BkLJX8iffVhDmukfGPQw2woPEq7q98dJhAeWsA00uooe9e9JE+G5e
         ML+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gfG/wlEI6oRTf4TuIt7/0Mn2sElJVOoXH266i2Gr9o=;
        b=ufCuZKw4O/CI86XODiCZ1GY/YCFEZlUtAPpOb28/9w1YqWra1m+QNyBjRlknTmdBEy
         A3YgoggHjbh/6hZN+s/QSBB32QlBQ8T7v5+iRlCdE0Cdp5XViUX8CQa7jEmeDMu2+P4r
         xNwb3feB2h/oze7b4DXHmaxjs5tsz30zJh4nMYTaUAkb4ONMgbzbo8JnZt80LeOWxIto
         1k1mcTnuCwGf2tsGwt7tvM6+4QdhCiFsXEJRJaGPbwLZ93ygMp677IOw3vPgqOMlmSs8
         P1IVeGt3Z6rvv+nmN9kFLDc7dyW64MvJcGmtIPU54acA/W4hL/tRDi1x/d2qNLJqP72n
         J8bg==
X-Gm-Message-State: AFqh2koKfK6nVS65Hp0qaag9pUyTJr1J4YuypiqOEpGy5LAFc5IDyFWf
        M25y0hALWp1tVUEvWYl02Icp9ZemABFtA0CWXex9
X-Google-Smtp-Source: AMrXdXuU9qtj67dv+uW5F8kAgRqGlTsuBqG+Ozpvlt4Opx/sle5Y8R/R3ZLOX2bZmMTWW54BwcpESIEwtGhk1J5WMKY=
X-Received: by 2002:a17:903:22c1:b0:189:8a36:1b70 with SMTP id
 y1-20020a17090322c100b001898a361b70mr756658plg.12.1671830814301; Fri, 23 Dec
 2022 13:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20221223185531.222689-1-paul@paul-moore.com>
In-Reply-To: <20221223185531.222689-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Dec 2022 16:26:43 -0500
Message-ID: <CAHC9VhQmLcLYxxmDgo9ygmcanuyGVY_A=y2z6rtGdMcwwA4rDw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 23, 2022 at 1:55 PM Paul Moore <paul@paul-moore.com> wrote:
>
> When changing the ebpf program put() routines to support being called
> from within IRQ context the program ID was reset to zero prior to
> calling the perf event and audit UNLOAD record generators, which
> resulted in problems as the ebpf program ID was bogus (always zero).
> This patch resolves this by adding a new flag, bpf_prog::valid_id, to
> indicate when the bpf_prog_aux ID field is valid; it is set to true/1
> in bpf_prog_alloc_id() and set to false/0 in bpf_prog_free_id().  In
> order to help ensure that access to the bpf_prog_aux ID field takes
> into account the new valid_id flag, the bpf_prog_aux ID field is
> renamed to bpf_prog_aux::__id and a getter function,
> bpf_prog_get_id(), was created and all users of bpf_prog_aux::id were
> converted to the new caller.  Exceptions to this include some of the
> internal ebpf functions and the xdp trace points, although the latter
> still take into account the valid_id flag.
>
> I also modified the bpf_audit_prog() logic used to associate the
> AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> Instead of keying off the operation, it now keys off the execution
> context, e.g. '!in_irg && !irqs_disabled()', which is much more
> appropriate and should help better connect the UNLOAD operations with
> the associated audit state (other audit records).
>
> Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> Reported-by: Burn Alting <burn.alting@iinet.net.au>
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> --
> * v2
>   - change subj
>   - add mention of the perf regression
>   - drop the dedicated program audit ID
>   - add the bpf_prog::valid_id flag, bpf_prog_get_id() getter
>   - convert prog ID users to new ID getter
> * v1
>   - subj was: "bpf: restore the ebpf audit UNLOAD id field"
>   - initial draft
> ---
>  drivers/net/netdevsim/bpf.c  |  6 ++++--
>  include/linux/bpf.h          | 11 +++++++++--
>  include/linux/bpf_verifier.h |  2 +-
>  include/trace/events/xdp.h   |  4 ++--
>  kernel/bpf/arraymap.c        |  2 +-
>  kernel/bpf/bpf_struct_ops.c  |  2 +-
>  kernel/bpf/cgroup.c          |  2 +-
>  kernel/bpf/core.c            |  2 +-
>  kernel/bpf/cpumap.c          |  2 +-
>  kernel/bpf/devmap.c          |  2 +-
>  kernel/bpf/syscall.c         | 27 +++++++++++++++------------
>  kernel/events/core.c         |  6 +++++-
>  kernel/trace/bpf_trace.c     |  2 +-
>  net/core/dev.c               |  2 +-
>  net/core/filter.c            |  3 ++-
>  net/core/rtnetlink.c         |  2 +-
>  net/core/sock_map.c          |  2 +-
>  net/ipv6/seg6_local.c        |  3 ++-
>  net/sched/act_bpf.c          |  2 +-
>  net/sched/cls_bpf.c          |  2 +-
>  20 files changed, 52 insertions(+), 34 deletions(-)

...

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9e7d46d16032..18e965bd7db9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
>  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>  void bpf_prog_put(struct bpf_prog *prog);
>
> +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> +{
> +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> +               return 0;
> +       return prog->aux->__id;
> +}
>  void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
>  void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);

The bpf_prog_get_id() either needs to be moved outside the `#ifdef
CONFIG_BPF_SYSCALL` block, or a dummy function needs to be added when
CONFIG_BPF_SYSCALL is undefined.  I can fix that up easily enough, but
given the time of year I'll wait a bit to see if there are any other
comments before posting another revision.

-- 
paul-moore.com

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525154B2F16
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 22:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiBKVHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 16:07:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiBKVHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 16:07:12 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6532D3
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:07:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y84so13023382iof.0
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFIdb5TTuh+PICHNtKLwWJf3JIaDx8TDSAwmPAirSUY=;
        b=otB5UYlo6qfG350iHjzcYqTzM6GKAGZ23/5wiCy+SFJvSYsqc3AlcXIATcJksVmDpd
         PfflqnQfQEFdcDEkMqw+tYzUj/RJfPZGHs8hS7wIpFIajmUWsmN2wkG2EGAGpi52Dn9q
         t+PnPBkLMsCs/pdDdxEBeeLSOtoRLFmtzwWTiJCKmREze8bRkxCNtNMyIW5OxMdHXLen
         oWhGVc6HXKYcOKiPVopsT0wEdbO3Vd7U8dDw9f0eRRRfrv5B+r51TFFpb2KImzhInn2t
         8KLWoOzXCy9uPYytFtNiLXP4HUFatxrv4elG8J/s/3n6sdFjynYcARkGdzGfITwtn7CJ
         5vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFIdb5TTuh+PICHNtKLwWJf3JIaDx8TDSAwmPAirSUY=;
        b=KfhiWYSnzbuk+VP26l78UbWYYyG8xjzMbRPoNpVBWW1e7pwHqZbngrFRLT5hV/mpDy
         wKc1uGTuNBTtckqjVXmAA5BrMURvuKVicoxVTB0E1FSLbywR6K+zn/Z5MkKgh0A9DCY8
         gyoK9WbCUoW0RamhnZri9AcHgbhaBDMEVcRdj436mXWmHjokqXRYc2bNEQ5n2Tlz8jjM
         U0LyciwiLdw2hNY/dOTKiY9bqnr2RwERb6tK6O8P0Dwk1m4D9ptwOgUfK517ORZ89vsK
         2ImNQpCnalIb2bw56SsMGvUV9LuhOexqZxzWc+aEACoD3WzeA2dPnm/byfhburfOmWWe
         Ci1w==
X-Gm-Message-State: AOAM532H9MaEsLMXUXpVH/k9nNt+SPfq46gLPFOmO2z8UhMoHJHWnAp8
        Ay0zFG+WQaS7AF19JzEiN4KwoUfmo7Xa87T9mJ5KAgDglBU=
X-Google-Smtp-Source: ABdhPJxCC4w08FX1Nx9Enp4hRmmzCmFLYRmAqhP+hgTnEAymhRlnP0MFOWoRd5D+Z9mZ4UtKsMgMzCakBiDkFqlHM6E=
X-Received: by 2002:a05:6638:304d:: with SMTP id u13mr1909326jak.103.1644613630053;
 Fri, 11 Feb 2022 13:07:10 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzYZqzAaJxbC=onWn7=Kra4QXPxXKWxrmv3jBw6Dufh_cQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYZqzAaJxbC=onWn7=Kra4QXPxXKWxrmv3jBw6Dufh_cQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 13:06:59 -0800
Message-ID: <CAEf4BzZKLHGxv1Kpf5QpFEpdp2-GE05Eej5rErNNu0fqTrAoLg@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] libbpf v0.7 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Thu, Feb 10, 2022 at 4:25 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> libbpf v0.7 was just released ([0]). It features a bunch of new
> features, quality of life improvements (e.g., automatic handling of
> RLIMIT_MEMLOCK), and a bunch of further deprecations. Also, more APIs
> got better documentation, as well as various bugs were fixed and
> support for older kernels was improved.
>
> Overall, libbpf v0.7 should be the last version with lots of
> deprecations before libbpf 1.0 release. libbpf v0.8 should get a few
> extra features helping with libbpf 1.0 migration, as well as the usual
> stream of further improvements, but no major new deprecations are
> planned so far. We are definitely getting pretty close to be ready for
> the actual v1.0 release!
>
> Thanks to all the contributors for pushing libbpf forward!
>
>
> ## Important updates towards Libbpf 1.0
>   - no need for explicit `setrlimi(RLIMIT_MEMLOCK)` when
> `LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK` is passed to
> `libbpf_set_strict_mode()`. libbpf will determine whether this is
> necessary automatically based on kernel's support for memcg-based
> memory accounting for BPF;
>   - legacy BPF map definitions (using `struct bpf_map_def`) are
> deprecated when `LIBBPF_STRICT_MAP_DEFINITIONS` is passed to
> `libbpf_set_strict_mode()`. Please use BTF-defined map definitions.
>   - another batch of API deprecations.
>
> ## New features and APIs:
>   - ability to control and capture BPF verifier log output on
> per-object and per-program level;
>   - CO-RE support and other improvements for "light skeleton";
>   - further libbpf API documentation improvements;
>   - new feature-probing APIs (`libbpf_probe_bpf_helper()`,
> `libbpf_probe_bpf_prog_type()`, `libbpf_probe_bpf_map_type()`);
>   - new streamlined low-level XDP APIs (`bpf_xdp_attach()`,
> `bpf_xdp_detach()`, `bpf_xdp_query()`, `bpf_xdp_query_id()`);
>   - new `SEC("xdp.frags")`, `SEC("xdp.frags/cpumap")`,
> `SEC("xdp.frags/devmap")` section definitions;
>   - new `SEC("iter.s/xxx")` section definitions for sleepable BPF
> iterator programs.
>
> ## BPF-side APIs and features:
>   - `bpf_loop()` helper;
>   - `bpf_func_arg()`, `bpf_func_ret()`, `bpf_func_arg_cnt()` helpers;
>   - added syscall-specific `PT_REGS_xxx()` macros for retrieving
> syscall arguments;
>   - added `BPF_KPROBE_SYSCALL()` helper macro for syscall kprobes;
>   - `bpf_get_retval()` and `bpf_set_retval()` helpers;
>   - `bpf_xdp_get_buff_len()` helper;
>   - `bpf_copy_from_user_task()` helper for sleepable BPF programs.
>
> ## Bug fixes and compatibility improvements:
>   - fixed compilation error for C++ due to `btf_dump__new()` macro magic;
>   - improved `LINUX_VERSION_CODE` detection for Ubuntu;
>   - improved multiple kprobe support for legacy kprobe mode on old kernels;
>   - improved compilation when system BTF UAPI headers are outdated;
>   - a bunch of fixes of `PT_REGS_PARMn*()` macros for various architectures.
>
> **Full Changelog**: https://github.com/libbpf/libbpf/compare/v0.6.0...v0.7.0
>
>   [0] https://github.com/libbpf/libbpf/releases/tag/v0.7.0
>

I've noticed that libbpf.map has a bug. LIBBPF_0.7.0 didn't inherit
from LIBBPF_0.6.0. I cherry picked the fix ([0]) to Github repo and
updated v0.7.0 tag. Please be advised if you happened to pull the tag
before this fix, you'll need to re-pull.  Sorry for any
inconveniences.

  [0] https://github.com/libbpf/libbpf/commit/2cd2d03f63242c048a896179398c68d2dbefe3d6


> -- Andrii

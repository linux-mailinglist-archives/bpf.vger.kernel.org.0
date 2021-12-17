Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BE479107
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhLQQMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhLQQMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 11:12:36 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA9C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 08:12:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 131so7821423ybc.7
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJAh9V9X4xNHVPiI32Vlp1D/5HEnZRtrRU/3jLciaYo=;
        b=BEeuPqUxeLW9z3zQBGr7yHFzzP2+KybIn2l/ZgQCbmz1QKH2g4O8CODIYmJ/BU5J7Z
         m3ZgSuCP/IdNNikfieQeGrS5a1M7zsbF0zsj46/ztBcMZOunnupSqtLRTuO1NjMr3yvz
         k0K0tf4z5/HNo0ufPi8ci67ahk8iqVlFCW/IXVd9vaw8WEbnLb3FOO6YV295SfBTzMS5
         ju1sQfh0hAjO2a1auhfibVC0YqvT2ZPVWV7px1fWSlI+y+rSrEhacr2JtmGJCo2vN50Z
         BCzj2qAChC/2PLbR1bfHHYuxC1RLP2TPVOo2P3gmNvMmaxFS5lZ9ZStkTac3d9lxWcpE
         gGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJAh9V9X4xNHVPiI32Vlp1D/5HEnZRtrRU/3jLciaYo=;
        b=2Z1VQ2j9dlHx9yI6SGgVwOI8HmRbIHg8VeR42wrMtwUC9uBthm7AOLpVr66D9Dgbj6
         FdE7HFTWzmdGVOnIg+rRgzJkzn99FbozcXPdHSE8SrVEt2P4KGL5xmvaB7g5G0U+IM8W
         aHsk8IN7huBe4uRX8cx62vnTVW/e6lRV35FJkY22Hj5O6RwpFgBOdyUQoFrfbm+nqxn0
         xisiR27/wiA/iSQktvhAYjgVLOEQZV8HEHZZg2ZvZt25oKtqEGim5KXUBodrKaTSrqfq
         KstYH6ODIKLOTLxVF/10Fdmyd0DAQhOjDEkBWjVqzEPldJqBBE7fDIrvZ6o+bYtIFzBi
         mH+A==
X-Gm-Message-State: AOAM530ioy7LsdF5SNwPv487K/Gvu4yow8Ej0pBUQVkmGQQwjHNABQlq
        Rx2g/H8ngyys77Zw2HFVVucJroA9IrQfnj6ZJZc=
X-Google-Smtp-Source: ABdhPJyNzznbPX69ACE31VzWLwjuMdd3gxnL0lZ9nnkcmp8Zt9ID8meModyi2k0tUmZe77e0jXpZjyF3Mg3lijHrhhs=
X-Received: by 2002:a25:3c9:: with SMTP id 192mr5320579ybd.766.1639757554908;
 Fri, 17 Dec 2021 08:12:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHMuVOB16tif6TRjdNVN9YjGc-UpOOwuo35SM+vY7Bf5=1+oiQ@mail.gmail.com>
In-Reply-To: <CAHMuVOB16tif6TRjdNVN9YjGc-UpOOwuo35SM+vY7Bf5=1+oiQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Dec 2021 08:12:23 -0800
Message-ID: <CAEf4BzZZKC_rq8h=NiWByCCxJN9GGWsqGgcGbcUJA6L5duR5Hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Probe for bounded loop support
To:     Paul Chaignon <paul@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 17, 2021 at 4:12 AM Paul Chaignon <paul@isovalent.com> wrote:
>
> This patch introduces a new probe to check whether the verifier supports
> bounded loops as introduced in commit 2589726d12a1 ("bpf: introduce
> bounded loops"). This patch will allow BPF users such as Cilium to probe
> for loop support on startup and only unconditionally unroll loops on
> older kernels.
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Paul Chaignon <paul@isovalent.com>
> ---
>  tools/lib/bpf/libbpf.h        |  1 +
>  tools/lib/bpf/libbpf.map      |  1 +
>  tools/lib/bpf/libbpf_probes.c | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 42b2f36fd9f0..3621aaaff67c 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1058,6 +1058,7 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
>  LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
>                                  enum bpf_prog_type prog_type, __u32 ifindex);
>  LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
> +LIBBPF_API bool bpf_probe_bounded_loops(__u32 ifindex);
>

Nope, see [0], I'm removing bpf_probe_large_insn_limit, so no new
ad-hoc feature probing APIs, please. There has to be some system to
this. If you want to add it to bpftool, go ahead, but keep it inside
bpftool code only. In practice I'd use CO-RE feature detection from
the BPF program side to pick the best implementation. Worst case, I'd
add two BPF program implementations and picked one or the other
(bpf_program__set_autoload(false) to disable one of them) after doing
feature detection from the process, not relying on shelling out to
bpftool.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20211216070442.1492204-2-andrii@kernel.org/

>  /*
>   * Get bpf_prog_info in continuous memory
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b3938b3f8fc9..059d168452d7 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -423,6 +423,7 @@ LIBBPF_0.6.0 {
>  LIBBPF_0.7.0 {
>         global:
>                 bpf_btf_load;
> +               bpf_probe_bounded_loops;
>                 bpf_program__log_buf;
>                 bpf_program__log_level;
>                 bpf_program__set_log_buf;
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 4bdec69523a7..e5bd691059e4 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -356,3 +356,23 @@ bool bpf_probe_large_insn_limit(__u32 ifindex)
>
>         return errno != E2BIG && errno != EINVAL;
>  }
> +
> +/*
> + * Probe for bounded loop support introduced in commit 2589726d12a1
> + * ("bpf: introduce bounded loops").
> + */
> +bool bpf_probe_bounded_loops(__u32 ifindex)
> +{
> +       struct bpf_insn insns[4] = {
> +               BPF_MOV64_IMM(BPF_REG_0, 10),
> +               BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
> +               BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, -2),
> +               BPF_EXIT_INSN()
> +       };
> +
> +       errno = 0;
> +       probe_load(BPF_PROG_TYPE_SOCKET_FILTER, insns, ARRAY_SIZE(insns), NULL,
> +                  0, ifindex);
> +
> +       return !errno;
> +}
> --
> 2.25.1
